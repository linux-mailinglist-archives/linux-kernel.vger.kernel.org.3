Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA71509D72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388313AbiDUKUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388241AbiDUKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:20:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AD222B0C;
        Thu, 21 Apr 2022 03:17:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BDBFA215FE;
        Thu, 21 Apr 2022 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPmULzmh0/xA3SxYa2A8Wvr5Go8Reyih7fHmmfVIddM=;
        b=PpeW2wuuZuaofyJb6mAIjpipTq3x3pQmCGP0oGj9eKi8OqXLBqeTMYEu4rCUbRYKouR2UB
        4KJEzhyJokHsmfNUcv7iw+qlUpPCeGXwadm7KQcnFP9l1ykjWl5XR9BrNLSqz4bcy5CzBL
        TlOpBoZD/GMjf8S4eQylHAqizSNz/AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPmULzmh0/xA3SxYa2A8Wvr5Go8Reyih7fHmmfVIddM=;
        b=VHL8VVSzBsF6qfsey7xd/8/rVRWA5yyEQ5qCAor58h9ClHzA9LmwCdk9wg+4q2xljOe8q8
        lPgRV1MaxhY7ZuAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 948742C142;
        Thu, 21 Apr 2022 10:17:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/7] serial: xilinx_uartps: return early in cdns_uart_handle_tx()
Date:   Thu, 21 Apr 2022 12:17:03 +0200
Message-Id: <20220421101708.5640-3-jslaby@suse.cz>
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

Return from the true branch of the 'if'. This saves one indentation
level and makes the code more readable.

The two comments about what obvious code does are removed too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/xilinx_uartps.c | 47 ++++++++++++------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 250a1d888eeb..b84ae9c07c3b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -317,37 +317,26 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (uart_circ_empty(&port->state->xmit)) {
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
-	} else {
-		numbytes = port->fifosize;
-		while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-		       !(readl(port->membase + CDNS_UART_SR) &
-						CDNS_UART_SR_TXFULL)) {
-			/*
-			 * Get the data from the UART circular buffer
-			 * and write it to the cdns_uart's TX_FIFO
-			 * register.
-			 */
-			writel(
-				port->state->xmit.buf[port->state->xmit.tail],
-					port->membase + CDNS_UART_FIFO);
-
-			port->icount.tx++;
-
-			/*
-			 * Adjust the tail of the UART buffer and wrap
-			 * the buffer if it reaches limit.
-			 */
-			port->state->xmit.tail =
-				(port->state->xmit.tail + 1) &
-					(UART_XMIT_SIZE - 1);
-
-			numbytes--;
-		}
+		return;
+	}
 
-		if (uart_circ_chars_pending(
-				&port->state->xmit) < WAKEUP_CHARS)
-			uart_write_wakeup(port);
+	numbytes = port->fifosize;
+	while (numbytes && !uart_circ_empty(&port->state->xmit) &&
+	       !(readl(port->membase + CDNS_UART_SR) &
+					CDNS_UART_SR_TXFULL)) {
+
+		writel(port->state->xmit.buf[port->state->xmit.tail],
+				port->membase + CDNS_UART_FIFO);
+
+		port->icount.tx++;
+		port->state->xmit.tail = (port->state->xmit.tail + 1) &
+				(UART_XMIT_SIZE - 1);
+
+		numbytes--;
 	}
+
+	if (uart_circ_chars_pending(&port->state->xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
 }
 
 /**
-- 
2.36.0

