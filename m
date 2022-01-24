Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C93497943
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiAXHOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58082 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbiAXHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C583C1F3B6;
        Mon, 24 Jan 2022 07:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9a5B5RGVmJ6PZ7we55uVKingQ30djeTUqYcDv5kgvY=;
        b=0sjKwF5c8FiS2KpPZTRL9Si8lqNFI5zSHu6Z24Mw/l75IrqwfVJqmIhzDTPbN4v327hKtw
        R8BG1X4P3b3dwUP6huhppJTAJXQL404gKteW5Day/nOWR4zEbAzjpYStr4CzsSxoaDJc3M
        4owRPASDfA+SAOaIW56YIEXTllVujvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9a5B5RGVmJ6PZ7we55uVKingQ30djeTUqYcDv5kgvY=;
        b=LgXxeYj1hXPl+LT5X5nZ0LRWQujhs/Y6iHgB2TtHYl4C4nGGvjajDVXjOZOCkbOhW68XJw
        q01kz5BNuBWoqEAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 90E84A3B84;
        Mon, 24 Jan 2022 07:14:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/11] mxser: use tty_port xmit_buf helpers
Date:   Mon, 24 Jan 2022 08:14:25 +0100
Message-Id: <20220124071430.14907-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the mxser driver to use kfifo, use tty_port_alloc_xmit_buf() and
tty_port_free_xmit_buf() helpers in activate/shutdown, respectively.

As these calls have to be done in a non-atomic context, we have to move
them outside spinlock and make sure irq is really stopped after we write
to the ISR register.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index fbb796f83753..4ddc12a63666 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -742,13 +742,12 @@ static void mxser_disable_and_clear_FIFO(struct mxser_port *info)
 static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct mxser_port *info = container_of(port, struct mxser_port, port);
-	unsigned long page;
 	unsigned long flags;
 	int ret;
 
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&info->slock, flags);
 
@@ -758,7 +757,6 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 		ret = 0;
 		goto err_free_xmit;
 	}
-	info->port.xmit_buf = (unsigned char *) page;
 
 	/*
 	 * Clear the FIFO buffers and disable them
@@ -825,8 +823,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 
 	return 0;
 err_free_xmit:
-	free_page(page);
-	info->port.xmit_buf = NULL;
+	tty_port_free_xmit_buf(port);
 	return ret;
 }
 
@@ -862,14 +859,6 @@ static void mxser_shutdown_port(struct tty_port *port)
 	 */
 	wake_up_interruptible(&info->port.delta_msr_wait);
 
-	/*
-	 * Free the xmit buffer, if necessary
-	 */
-	if (info->port.xmit_buf) {
-		free_page((unsigned long) info->port.xmit_buf);
-		info->port.xmit_buf = NULL;
-	}
-
 	info->IER = 0;
 	outb(0x00, info->ioaddr + UART_IER);
 
@@ -884,6 +873,11 @@ static void mxser_shutdown_port(struct tty_port *port)
 		mxser_must_no_sw_flow_control(info->ioaddr);
 
 	spin_unlock_irqrestore(&info->slock, flags);
+
+	/* make sure ISR is not running while we free the buffer */
+	synchronize_irq(info->board->irq);
+
+	tty_port_free_xmit_buf(port);
 }
 
 /*
-- 
2.34.1

