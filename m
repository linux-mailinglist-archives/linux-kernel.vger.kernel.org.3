Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD344847CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiADS0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:26:17 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51774 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234736AbiADS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:26:05 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204FUQ1F029263;
        Tue, 4 Jan 2022 19:25:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=afe/Z9iYxJmYbWTSRofGvSsgFbbkGOpi70uPHEyEyKk=;
 b=XVFlWWoEHYknox8BShy7FVq1mDbzpf34PiHdz2+Gl3pTy/8Cg7QDhQsvQRvTxVfxlE0B
 LPl/nNpzaO2oB9MtjrqPAEhMbAMh0gMOtJzHGXyP/15JYIODO2YfpKpQvXUWt2GM1Ycn
 HNcRfq+epqFus8GmFm1gxFYMA/iovxf9e9Y1DP3bBH8AXJJZHFpknwPattBBecuDf3td
 mZBhOE98DP5OHPIOZVULWYTu+uYWNZhbTfB15bYKrvbO8wJhy0xrBPXs+UBqZRTpGIaS
 bExx1mTSgBzyRIkx3Aso5efd11P9+ltfyzAB2JYj1eYjMj85pB4o/NdvDkuoPvZgqrFR IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcagrc7wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 19:25:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4885A10002A;
        Tue,  4 Jan 2022 19:25:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3463424D5E6;
        Tue,  4 Jan 2022 19:25:50 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 19:25:49
 +0100
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] serial: stm32: rework TX DMA state condition
Date:   Tue, 4 Jan 2022 19:24:43 +0100
Message-ID: <20220104182445.4195-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220104182445.4195-1-valentin.caron@foss.st.com>
References: <20220104182445.4195-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_09,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TX DMA state condition is handled by tx_dma_busy boolean.
This boolean is set when dma descriptor is requested and reset when dma
channel is stopped (dma_terminate).

In stm32_usart_serial_remove(), stm32_usart_stop_tx() and
stm32_usart_transmit_chars_dma() fallback error case, DMA channel is
stopped but tx_dma_busy is not handled.

Rework the driver by using two new functions to solve this issue:
- stm32_usart_tx_dma_started return true if DMA TX have a descriptor.
- stm32_usart_tx_dma_enabled return true if DMAT bit is set.

stm32_usart_tx_dma_started uses tx_dma_busy flag to prevent dual DMA
transaction at the same time. This flag is set when a DMA transaction
begins and is unset when dmaengine_terminate_async function is called.
A new DMA transaction cannot be created if this flag is set.

Create a new function "stm32_usart_tx_dma_terminate" to be sure the flag
is unset after each call of dmaengine_terminate_async.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 66 +++++++++++++++++++++++---------
 drivers/tty/serial/stm32-usart.h |  2 +-
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 6cfc3bec6749..52755a576bc2 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -365,6 +365,31 @@ static unsigned int stm32_usart_receive_chars(struct uart_port *port, bool force
 	return size;
 }
 
+static void stm32_usart_tx_dma_terminate(struct stm32_port *stm32_port)
+{
+	dmaengine_terminate_async(stm32_port->tx_ch);
+	stm32_port->tx_dma_busy = false;
+}
+
+static bool stm32_usart_tx_dma_started(struct stm32_port *stm32_port)
+{
+	/*
+	 * We cannot use the function "dmaengine_tx_status" to know the
+	 * status of DMA. This function does not show if the "dma complete"
+	 * callback of the DMA transaction has been called. So we prefer
+	 * to use "tx_dma_busy" flag to prevent dual DMA transaction at the
+	 * same time.
+	 */
+	return stm32_port->tx_dma_busy;
+}
+
+static bool stm32_usart_tx_dma_enabled(struct stm32_port *stm32_port)
+{
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	return !!(readl_relaxed(stm32_port->port.membase + ofs->cr3) & USART_CR3_DMAT);
+}
+
 static void stm32_usart_tx_dma_complete(void *arg)
 {
 	struct uart_port *port = arg;
@@ -372,9 +397,8 @@ static void stm32_usart_tx_dma_complete(void *arg)
 	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	unsigned long flags;
 
-	dmaengine_terminate_async(stm32port->tx_ch);
 	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-	stm32port->tx_dma_busy = false;
+	stm32_usart_tx_dma_terminate(stm32port);
 
 	/* Let's see if we have pending data to send */
 	spin_lock_irqsave(&port->lock, flags);
@@ -428,10 +452,8 @@ static void stm32_usart_transmit_chars_pio(struct uart_port *port)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (stm32_port->tx_dma_busy) {
+	if (stm32_usart_tx_dma_enabled(stm32_port))
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-		stm32_port->tx_dma_busy = false;
-	}
 
 	while (!uart_circ_empty(xmit)) {
 		/* Check that TDR is empty before filling FIFO */
@@ -457,10 +479,11 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 	struct dma_async_tx_descriptor *desc = NULL;
 	unsigned int count, i;
 
-	if (stm32port->tx_dma_busy)
+	if (stm32_usart_tx_dma_started(stm32port)) {
+		if (!stm32_usart_tx_dma_enabled(stm32port))
+			stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAT);
 		return;
-
-	stm32port->tx_dma_busy = true;
+	}
 
 	count = uart_circ_chars_pending(xmit);
 
@@ -491,13 +514,21 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 	if (!desc)
 		goto fallback_err;
 
+	/*
+	 * Set "tx_dma_busy" flag. This flag will be released when
+	 * dmaengine_terminate_async will be called. This flag helps
+	 * transmit_chars_dma not to start another DMA transaction
+	 * if the callback of the previous is not yet called.
+	 */
+	stm32port->tx_dma_busy = true;
+
 	desc->callback = stm32_usart_tx_dma_complete;
 	desc->callback_param = port;
 
 	/* Push current DMA TX transaction in the pending queue */
 	if (dma_submit_error(dmaengine_submit(desc))) {
 		/* dma no yet started, safe to free resources */
-		dmaengine_terminate_async(stm32port->tx_ch);
+		stm32_usart_tx_dma_terminate(stm32port);
 		goto fallback_err;
 	}
 
@@ -522,12 +553,13 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (port->x_char) {
-		if (stm32_port->tx_dma_busy)
+		if (stm32_usart_tx_dma_started(stm32_port) &&
+		    stm32_usart_tx_dma_enabled(stm32_port))
 			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 		writel_relaxed(port->x_char, port->membase + ofs->tdr);
 		port->x_char = 0;
 		port->icount.tx++;
-		if (stm32_port->tx_dma_busy)
+		if (stm32_usart_tx_dma_started(stm32_port))
 			stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAT);
 		return;
 	}
@@ -719,9 +751,8 @@ static void stm32_usart_flush_buffer(struct uart_port *port)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	if (stm32_port->tx_ch) {
-		dmaengine_terminate_async(stm32_port->tx_ch);
+		stm32_usart_tx_dma_terminate(stm32_port);
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-		stm32_port->tx_dma_busy = false;
 	}
 }
 
@@ -883,10 +914,11 @@ static void stm32_usart_shutdown(struct uart_port *port)
 	u32 val, isr;
 	int ret;
 
-	if (stm32_port->tx_dma_busy) {
-		dmaengine_terminate_async(stm32_port->tx_ch);
+	if (stm32_usart_tx_dma_enabled(stm32_port))
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-	}
+
+	if (stm32_usart_tx_dma_started(stm32_port))
+		stm32_usart_tx_dma_terminate(stm32_port);
 
 	/* Disable modem control interrupts */
 	stm32_usart_disable_ms(port);
@@ -1424,8 +1456,6 @@ static int stm32_usart_of_dma_tx_probe(struct stm32_port *stm32port,
 	struct dma_slave_config config;
 	int ret;
 
-	stm32port->tx_dma_busy = false;
-
 	stm32port->tx_buf = dma_alloc_coherent(dev, TX_BUF_L,
 					       &stm32port->tx_dma_buf,
 					       GFP_KERNEL);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index e23916bfbb60..feab952aec16 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -264,7 +264,7 @@ struct stm32_port {
 	u32 cr1_irq;		 /* USART_CR1_RXNEIE or RTOIE */
 	u32 cr3_irq;		 /* USART_CR3_RXFTIE */
 	int last_res;
-	bool tx_dma_busy;	 /* dma tx busy               */
+	bool tx_dma_busy;	 /* dma tx transaction in progress */
 	bool throttled;		 /* port throttled            */
 	bool hw_flow_control;
 	bool swap;		 /* swap RX & TX pins */
-- 
2.17.1

