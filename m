Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45A2509D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388251AbiDUKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiDUKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:20:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661322B10;
        Thu, 21 Apr 2022 03:17:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 068341F753;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Av0WDD17KqZTnnWpTO7caIQzT04y2/xp320J3kYCBfI=;
        b=phxzUDo1E0uAUHonf9nDzXPKqJOI5Xi5Kln8yeW5r/LaEzLBjc7/Oxm9xmWBzm/7z3JUTR
        RjrXpOK5mMYDWydXZKebGSDsKAk2i7l+QFjBNt8v/R4+OGpA9be+xrmiM+RPRk+NgRL9Mt
        2/foT1agPh+NCc3M1A5rgiHwAVY+QyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Av0WDD17KqZTnnWpTO7caIQzT04y2/xp320J3kYCBfI=;
        b=2zW+Sr+BmD13xFjUgKqg8cBYoW6p6OSJmm9Fpw2mjkFMXTH+1lftKyvicZ1TKIx4lWv+9C
        zvd+0ixRz3/KF/Bg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D082F2C141;
        Thu, 21 Apr 2022 10:17:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/7] serial: xilinx_uartps: cache xmit in cdns_uart_handle_tx()
Date:   Thu, 21 Apr 2022 12:17:04 +0200
Message-Id: <20220421101708.5640-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421101708.5640-1-jslaby@suse.cz>
References: <20220421101708.5640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache port->state->xmit into a local variable (xmit) in
cdns_uart_handle_tx(). This reduces length of some lines there
significantly. I.e. makes the code more readable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/xilinx_uartps.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b84ae9c07c3b..9e01fe6c0ab8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -313,29 +313,26 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
-	if (uart_circ_empty(&port->state->xmit)) {
+	if (uart_circ_empty(xmit)) {
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
 		return;
 	}
 
 	numbytes = port->fifosize;
-	while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-	       !(readl(port->membase + CDNS_UART_SR) &
-					CDNS_UART_SR_TXFULL)) {
+	while (numbytes && !uart_circ_empty(xmit) &&
+	       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
 
-		writel(port->state->xmit.buf[port->state->xmit.tail],
-				port->membase + CDNS_UART_FIFO);
+		writel(xmit->buf[xmit->tail], port->membase + CDNS_UART_FIFO);
 
 		port->icount.tx++;
-		port->state->xmit.tail = (port->state->xmit.tail + 1) &
-				(UART_XMIT_SIZE - 1);
-
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		numbytes--;
 	}
 
-	if (uart_circ_chars_pending(&port->state->xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 }
 
-- 
2.36.0

