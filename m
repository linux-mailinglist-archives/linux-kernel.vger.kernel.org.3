Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4407517F77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiECIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiECILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:11:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACE20F63;
        Tue,  3 May 2022 01:08:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 09783210E3;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651565290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZY4eZA8TU/JFu/sgVc8ZGWUJ92szGRyRslgx5G5fOQ=;
        b=CZ8WyMUWfh9MImP/7fvYx6qum0uaHtM8hG7wB9E0dGt9+pgnaUBTj3yP6v0ET2+NtutCJY
        ekLYL5QqLkhyjva9YAJygn5LVQNugTwk9DL90L+BBf/Rhr8+UO4Xq7l0n2QVX2736flrIb
        gMNs0ImIkUtkXN6BiVRXJQM3GTHm8w8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651565290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZY4eZA8TU/JFu/sgVc8ZGWUJ92szGRyRslgx5G5fOQ=;
        b=hvx8J/VTBmruN6YHQVpsRyIvx5npIZnj48UU0FYFR5I9ucJ7mP1Zm/CecVoeSqOGKydknN
        ldRBR+3LeGKkYiCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF73B2C143;
        Tue,  3 May 2022 08:08:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/7] serial: pch: decomission pch_uart_hal_write()
Date:   Tue,  3 May 2022 10:08:04 +0200
Message-Id: <20220503080808.28332-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503080808.28332-1-jslaby@suse.cz>
References: <20220503080613.27601-1-jslaby@suse.cz>
 <20220503080808.28332-1-jslaby@suse.cz>
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

It's horrid and if we inline it into callers, we can get rid of a lot of
sugar around.

So:
* x_char handling becomes a single iowrite8.
* xmit->buf handling is a single loop simply writing characters one by
  one directly from the buf instead of complex cnt_to_end computations.
  Until the buf is empty or fifo size is reached.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pch_uart.c | 46 ++++++++++-------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6cb631487383..4fcb6c144b54 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -550,18 +550,6 @@ static u8 pch_uart_hal_get_modem(struct eg20t_port *priv)
 	return (u8)msr;
 }
 
-static void pch_uart_hal_write(struct eg20t_port *priv,
-			      const unsigned char *buf, int tx_size)
-{
-	int i;
-	unsigned int thr;
-
-	for (i = 0; i < tx_size;) {
-		thr = buf[i++];
-		iowrite8(thr, priv->membase + PCH_UART_THR);
-	}
-}
-
 static int pch_uart_hal_read(struct eg20t_port *priv, unsigned char *buf,
 			     int rx_size)
 {
@@ -769,23 +757,21 @@ static void pch_dma_tx_complete(void *arg)
 	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
 }
 
-static int pop_tx(struct eg20t_port *priv, int size)
+static bool pop_tx(struct eg20t_port *priv, unsigned int size)
 {
-	int count = 0;
+	unsigned int count = 0;
 	struct uart_port *port = &priv->port;
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (uart_tx_stopped(port) || uart_circ_empty(xmit))
+	if (uart_tx_stopped(port))
 		goto pop_tx_end;
 
-	do {
-		int cnt_to_end =
-		    CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
-		int sz = min(size - count, cnt_to_end);
-		pch_uart_hal_write(priv, &xmit->buf[xmit->tail], sz);
-		xmit->tail = (xmit->tail + sz) & (UART_XMIT_SIZE - 1);
-		count += sz;
-	} while (!uart_circ_empty(xmit) && count < size);
+	while (!uart_circ_empty(xmit) && count < size) {
+		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+		count++;
+	}
 
 pop_tx_end:
 	dev_dbg(priv->port.dev, "%d characters. Remained %d characters.(%lu)\n",
@@ -859,7 +845,6 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 	struct uart_port *port = &priv->port;
 	struct circ_buf *xmit = &port->state->xmit;
 	int fifo_size;
-	int tx_size;
 	int size;
 	int tx_empty;
 
@@ -874,7 +859,7 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 	fifo_size = max(priv->fifo_size, 1);
 	tx_empty = 1;
 	if (port->x_char) {
-		pch_uart_hal_write(priv, &port->x_char, 1);
+		iowrite8(port->x_char, priv->membase + PCH_UART_THR);
 		port->icount.tx++;
 		port->x_char = 0;
 		tx_empty = 0;
@@ -884,13 +869,8 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 	size = min(xmit->head - xmit->tail, fifo_size);
 	if (size < 0)
 		size = fifo_size;
-	if (size) {
-		tx_size = pop_tx(priv, size);
-		if (tx_size > 0) {
-			port->icount.tx += tx_size;
-			tx_empty = 0;
-		}
-	}
+	if (size && pop_tx(priv, size))
+		tx_empty = 0;
 
 	priv->tx_empty = tx_empty;
 
@@ -935,7 +915,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	fifo_size = max(priv->fifo_size, 1);
 
 	if (port->x_char) {
-		pch_uart_hal_write(priv, &port->x_char, 1);
+		iowrite8(port->x_char, priv->membase + PCH_UART_THR);
 		port->icount.tx++;
 		port->x_char = 0;
 		fifo_size--;
-- 
2.36.0

