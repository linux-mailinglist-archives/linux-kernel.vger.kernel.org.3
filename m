Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19788517F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiECIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiECILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:11:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629920F7E;
        Tue,  3 May 2022 01:08:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FEED1F750;
        Tue,  3 May 2022 08:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651565291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UO147EkrcD8s2C3iZ2gPdiFE1wRQPBc2PLaQ9zYEfvk=;
        b=t8xKe070RT0yUWutZROHx4pSUEU/hc9BhQwVFTlJOd1Qe1LYjpNJ5h0bdMmLDAoosBBfOn
        tvOakU2dXn9CO4PVCmiWGy0LZs88Q/de5ZRRXpD39pu4GBW2yl9OjpPqhdFI9OaHR4NyLy
        iyXnTa0CWKyMPD72TIoP40zSU7aBrls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651565291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UO147EkrcD8s2C3iZ2gPdiFE1wRQPBc2PLaQ9zYEfvk=;
        b=fFg8s/ilMSS0Z5/iwZcHCMoZH11+EduYu11v5iaOCvs9Xxi7JjvaTF5UFTZgh+b4WTma8u
        P/+rQlUdY5odrjBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EB3612C149;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/7] serial: pch: inline pop_tx() into handle_tx()
Date:   Tue,  3 May 2022 10:08:08 +0200
Message-Id: <20220503080808.28332-6-jslaby@suse.cz>
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

Given pop_tx() is a simple loop, inline it directly into handle_tx().

The code in handle_tx() looks much saner and straightforward now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pch_uart.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index e1eadf519089..3b26524d48e3 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -757,23 +757,6 @@ static void pch_dma_tx_complete(void *arg)
 	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
 }
 
-static bool pop_tx(struct eg20t_port *priv, unsigned int size)
-{
-	struct uart_port *port = &priv->port;
-	struct circ_buf *xmit = &port->state->xmit;
-	bool ret = false;
-
-	while (!uart_tx_stopped(port) && !uart_circ_empty(xmit) && size) {
-		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		size--;
-		ret = true;
-	}
-
-	return ret;
-}
-
 static int handle_rx_to(struct eg20t_port *priv)
 {
 	struct pch_uart_buffer *buf;
@@ -837,6 +820,7 @@ static int dma_handle_rx(struct eg20t_port *priv)
 static unsigned int handle_tx(struct eg20t_port *priv)
 {
 	struct uart_port *port = &priv->port;
+	struct circ_buf *xmit = &port->state->xmit;
 	int fifo_size;
 	int tx_empty;
 
@@ -858,8 +842,13 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 		fifo_size--;
 	}
 
-	if (fifo_size && pop_tx(priv, fifo_size))
+	while (!uart_tx_stopped(port) && !uart_circ_empty(xmit) && fifo_size) {
+		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+		fifo_size--;
 		tx_empty = 0;
+	}
 
 	priv->tx_empty = tx_empty;
 
-- 
2.36.0

