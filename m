Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064C94C2A90
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiBXLLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiBXLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:11:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5DE2905A8;
        Thu, 24 Feb 2022 03:10:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4CE5B212B9;
        Thu, 24 Feb 2022 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645701030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYvxaPxtmjrawievgZ8Raha0WUh7vamBwY35Qyu7N4c=;
        b=qSbXQL4u2oexw2Z3Dp+u+fai3BkFB00Z7oBpzHmQe9y2qeMsTkrPWkaQzG0N+ezzghFQqz
        Vz88L7/28/d1aK2FgQexcVlGsAsEZR2ZqTM5/kda4mnAI9mW+CdbPAe6rPK/1J71ZKSa5F
        BT4HUfPVoEILlja6aAEJAnDHoQzJWu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645701030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYvxaPxtmjrawievgZ8Raha0WUh7vamBwY35Qyu7N4c=;
        b=m+eKHrWZTWz4vtDIdXaXSxWEZSnznk+yiv0piNZ4Ty/N8l3dM2b6OskubXdvh4M99hhsmU
        YK1WEoz0BHRpZrAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D3EEA3B90;
        Thu, 24 Feb 2022 11:10:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] tty: serial: lpc32xx_hs: use serial_lpc32xx_stop_tx() helper
Date:   Thu, 24 Feb 2022 12:10:28 +0100
Message-Id: <20220224111028.20917-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224111028.20917-1-jslaby@suse.cz>
References: <20220224111028.20917-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coding what serial_lpc32xx_stop_tx() already does, call
it in __serial_lpc32xx_tx() directly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/lpc32xx_hs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index b7b489c68c36..93140cac1ca1 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -276,10 +276,11 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 	tty_flip_buffer_push(tport);
 }
 
+static void serial_lpc32xx_stop_tx(struct uart_port *port);
+
 static void __serial_lpc32xx_tx(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int tmp;
 
 	if (port->x_char) {
 		writel((u32)port->x_char, LPC32XX_HSUART_FIFO(port->membase));
@@ -306,11 +307,8 @@ static void __serial_lpc32xx_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 
 exit_tx:
-	if (uart_circ_empty(xmit)) {
-		tmp = readl(LPC32XX_HSUART_CTRL(port->membase));
-		tmp &= ~LPC32XX_HSU_TX_INT_EN;
-		writel(tmp, LPC32XX_HSUART_CTRL(port->membase));
-	}
+	if (uart_circ_empty(xmit))
+		serial_lpc32xx_stop_tx(port);
 }
 
 static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
-- 
2.35.1

