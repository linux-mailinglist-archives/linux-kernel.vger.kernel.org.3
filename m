Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8444C2A96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiBXLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiBXLLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:11:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998222819BA;
        Thu, 24 Feb 2022 03:10:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5A34F1F44A;
        Thu, 24 Feb 2022 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645701029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sECtLV2Cqp23vI3UmmE7oa1AoO0Iz0arFPmxPufCiUQ=;
        b=vqe18UGda1pv8BPtiSiVnVAqI/pjx2cfzpzxsKbnLWQB28mkzXKfvHFaD2/zU+uIM7CWej
        2BtC+iBnbwCFZ1B6TCYvFbFQG0Ed8AmftlVOQxq01UoMiJB7T1QTYU4UaS9GMMqgoCWxIX
        hYUFALWxR1ctt8UOdntpK0dXa6Xzcc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645701029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sECtLV2Cqp23vI3UmmE7oa1AoO0Iz0arFPmxPufCiUQ=;
        b=WS81C5E/gpL3u78HHG15XxA320mODHgx8aWZtIW6GhfmjSfGn0Wy4r0p4bE9/kprwvLJeT
        Ts1djSzI0SuiN7Aw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 30FA8A3B94;
        Thu, 24 Feb 2022 11:10:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/5] tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned
Date:   Thu, 24 Feb 2022 12:10:24 +0100
Message-Id: <20220224111028.20917-2-jslaby@suse.cz>
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

All these return bitmasks, so it makes more sense to return unsigned --
this is what a reader and also all the callers expect.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mpc52xx_uart.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 2704dc988e4a..8a6958377764 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -83,11 +83,11 @@ static irqreturn_t mpc5xxx_uart_process_int(struct uart_port *port);
 
 struct psc_ops {
 	void		(*fifo_init)(struct uart_port *port);
-	int		(*raw_rx_rdy)(struct uart_port *port);
-	int		(*raw_tx_rdy)(struct uart_port *port);
-	int		(*rx_rdy)(struct uart_port *port);
-	int		(*tx_rdy)(struct uart_port *port);
-	int		(*tx_empty)(struct uart_port *port);
+	unsigned int	(*raw_rx_rdy)(struct uart_port *port);
+	unsigned int	(*raw_tx_rdy)(struct uart_port *port);
+	unsigned int	(*rx_rdy)(struct uart_port *port);
+	unsigned int	(*tx_rdy)(struct uart_port *port);
+	unsigned int	(*tx_empty)(struct uart_port *port);
 	void		(*stop_rx)(struct uart_port *port);
 	void		(*start_tx)(struct uart_port *port);
 	void		(*stop_tx)(struct uart_port *port);
@@ -203,34 +203,34 @@ static void mpc52xx_psc_fifo_init(struct uart_port *port)
 	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
 }
 
-static int mpc52xx_psc_raw_rx_rdy(struct uart_port *port)
+static unsigned int mpc52xx_psc_raw_rx_rdy(struct uart_port *port)
 {
 	return in_be16(&PSC(port)->mpc52xx_psc_status)
 	    & MPC52xx_PSC_SR_RXRDY;
 }
 
-static int mpc52xx_psc_raw_tx_rdy(struct uart_port *port)
+static unsigned int mpc52xx_psc_raw_tx_rdy(struct uart_port *port)
 {
 	return in_be16(&PSC(port)->mpc52xx_psc_status)
 	    & MPC52xx_PSC_SR_TXRDY;
 }
 
 
-static int mpc52xx_psc_rx_rdy(struct uart_port *port)
+static unsigned int mpc52xx_psc_rx_rdy(struct uart_port *port)
 {
 	return in_be16(&PSC(port)->mpc52xx_psc_isr)
 	    & port->read_status_mask
 	    & MPC52xx_PSC_IMR_RXRDY;
 }
 
-static int mpc52xx_psc_tx_rdy(struct uart_port *port)
+static unsigned int mpc52xx_psc_tx_rdy(struct uart_port *port)
 {
 	return in_be16(&PSC(port)->mpc52xx_psc_isr)
 	    & port->read_status_mask
 	    & MPC52xx_PSC_IMR_TXRDY;
 }
 
-static int mpc52xx_psc_tx_empty(struct uart_port *port)
+static unsigned int mpc52xx_psc_tx_empty(struct uart_port *port)
 {
 	u16 sts = in_be16(&PSC(port)->mpc52xx_psc_status);
 
@@ -1365,7 +1365,7 @@ static const struct uart_ops mpc52xx_uart_ops = {
 /* Interrupt handling                                                       */
 /* ======================================================================== */
 
-static inline int
+static inline unsigned int
 mpc52xx_uart_int_rx_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
-- 
2.35.1

