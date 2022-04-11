Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85B4FB9EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbiDKKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbiDKKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:47:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D396713CC0;
        Mon, 11 Apr 2022 03:45:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AE7C1F7AC;
        Mon, 11 Apr 2022 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649673911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3RMh1ta9pkL0HZrKYbi40EKlPk0T3CptWqGzuRzVL4=;
        b=V3vIkbMwYXRnyG7bQhw5MRr6dqI32sTJgXVeynKRwA6tVloBKZAf3oWnanHw0bDJ4BlgAF
        /XLxgirNx+fAvAPRGbU3abNLRH4hNQd8WnsXrBmOOWRV0MbWGCmq/k0eX2drG4ybce+yVk
        OuvAO9jv/Qv1C1vM6RX2WzjRjE6mc5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649673911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3RMh1ta9pkL0HZrKYbi40EKlPk0T3CptWqGzuRzVL4=;
        b=295d77y1YRFTeS1bcObwziNPOrrhs9BWLpoAMHTe7b//+4PAneLe5E4FlDk8xOt1DHWck7
        FvlvKGioNyYBimAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EEA70A3B93;
        Mon, 11 Apr 2022 10:45:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 2/3] tty: serial: owl-uart, send x_char even if stopped
Date:   Mon, 11 Apr 2022 12:45:05 +0200
Message-Id: <20220411104506.8990-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411104506.8990-1-jslaby@suse.cz>
References: <20220411104506.8990-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Flow control characters should be sent even if the TX is stopped. So fix
owl-uart to behave the same as other drivers.

This unification also allows the use of the TX helper in the future.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/owl-uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 5250bd7d390a..5ff7c89aeb06 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -184,9 +184,6 @@ static void owl_uart_send_chars(struct uart_port *port)
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int ch;
 
-	if (uart_tx_stopped(port))
-		return;
-
 	if (port->x_char) {
 		while (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU))
 			cpu_relax();
@@ -195,6 +192,9 @@ static void owl_uart_send_chars(struct uart_port *port)
 		port->x_char = 0;
 	}
 
+	if (uart_tx_stopped(port))
+		return;
+
 	while (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)) {
 		if (uart_circ_empty(xmit))
 			break;
-- 
2.35.1

