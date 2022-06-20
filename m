Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6B5515F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiFTKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiFTKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:34:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0741402D;
        Mon, 20 Jun 2022 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721262; x=1687257262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhyCBHnUYgFu1lkQy+iQgrwinq7N6eDlsC/oxYPLtOQ=;
  b=l/CPfBP76j49J47HYoSE8uVmYfyHmOtnz/D24Ao1GmN6CeCSrQDnzuEX
   WYf9TjU2HFU6VS5hzq54XpVmXVrIiFRptnTJJgGMfpy/v7KX98QPeUc6/
   U7izcj7DGKexxYyc7n73KjfaFNHeGcpo9cs4USMWdPHmZcAlFf393oGJd
   XaizoRxlhTcpSs7+taUVd3t78AzwLJOwDeymoeSCowqeKf8f2dqego3j9
   TtbQ+pMSRX8QHCJyTvWdD2kX9NSSOyTb0pcz0mR9UHnvyQLag0g9lSnxN
   YcrEVlRJV1iF5av3+ORpWilIAl+7rVONfi1eVI+rRHzOPBv8UZ/F1PtW4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341543265"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341543265"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643055492"
Received: from lspinell-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/6] serial: msm: Convert container_of UART_TO_MSM to static inline
Date:   Mon, 20 Jun 2022 13:34:03 +0300
Message-Id: <20220620103408.37454-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com>
References: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create static inline instead of define.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/msm_serial.c | 49 +++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index e676ec761f18..15cab9c4b295 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -181,7 +181,10 @@ struct msm_port {
 	struct msm_dma		rx_dma;
 };
 
-#define UART_TO_MSM(uart_port)	container_of(uart_port, struct msm_port, uart)
+static inline struct msm_port *to_msm_port(struct uart_port *up)
+{
+	return container_of(up, struct msm_port, uart);
+}
 
 static
 void msm_write(struct uart_port *port, unsigned int val, unsigned int off)
@@ -221,7 +224,7 @@ static void msm_serial_set_mnd_regs_tcxoby4(struct uart_port *port)
 
 static void msm_serial_set_mnd_regs(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	/*
 	 * These registers don't exist so we change the clk input rate
@@ -404,7 +407,7 @@ static inline void msm_wait_for_xmitr(struct uart_port *port)
 
 static void msm_stop_tx(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	msm_port->imr &= ~UART_IMR_TXLEV;
 	msm_write(port, msm_port->imr, UART_IMR);
@@ -412,7 +415,7 @@ static void msm_stop_tx(struct uart_port *port)
 
 static void msm_start_tx(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	struct msm_dma *dma = &msm_port->tx_dma;
 
 	/* Already started in DMA mode */
@@ -690,7 +693,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 
 static void msm_stop_rx(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	struct msm_dma *dma = &msm_port->rx_dma;
 
 	msm_port->imr &= ~(UART_IMR_RXLEV | UART_IMR_RXSTALE);
@@ -702,7 +705,7 @@ static void msm_stop_rx(struct uart_port *port)
 
 static void msm_enable_ms(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	msm_port->imr |= UART_IMR_DELTA_CTS;
 	msm_write(port, msm_port->imr, UART_IMR);
@@ -714,7 +717,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 	struct tty_port *tport = &port->state->port;
 	unsigned int sr;
 	int count = 0;
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	if ((msm_read(port, UART_SR) & UART_SR_OVERRUN)) {
 		port->icount.overrun++;
@@ -837,7 +840,7 @@ static void msm_handle_rx(struct uart_port *port)
 static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
 {
 	struct circ_buf *xmit = &port->state->xmit;
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	unsigned int num_chars;
 	unsigned int tf_pointer = 0;
 	void __iomem *tf;
@@ -883,7 +886,7 @@ static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
 
 static void msm_handle_tx(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	struct circ_buf *xmit = &msm_port->uart.state->xmit;
 	struct msm_dma *dma = &msm_port->tx_dma;
 	unsigned int pio_count, dma_count, dma_min;
@@ -947,7 +950,7 @@ static void msm_handle_delta_cts(struct uart_port *port)
 static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	struct msm_dma *dma = &msm_port->rx_dma;
 	unsigned long flags;
 	unsigned int misr;
@@ -1002,7 +1005,7 @@ static unsigned int msm_get_mctrl(struct uart_port *port)
 
 static void msm_reset(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	unsigned int mr;
 
 	/* reset everything */
@@ -1055,7 +1058,7 @@ static const struct msm_baud_map *
 msm_find_best_baud(struct uart_port *port, unsigned int baud,
 		   unsigned long *rate)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	unsigned int divisor, result;
 	unsigned long target, old, best_rate = 0, diff, best_diff = ULONG_MAX;
 	const struct msm_baud_map *entry, *end, *best;
@@ -1124,7 +1127,7 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 			     unsigned long *saved_flags)
 {
 	unsigned int rxstale, watermark, mask;
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	const struct msm_baud_map *entry;
 	unsigned long flags, rate;
 
@@ -1185,7 +1188,7 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 
 static void msm_init_clock(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	clk_prepare_enable(msm_port->clk);
 	clk_prepare_enable(msm_port->pclk);
@@ -1194,7 +1197,7 @@ static void msm_init_clock(struct uart_port *port)
 
 static int msm_startup(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	unsigned int data, rfr_level, mask;
 	int ret;
 
@@ -1246,7 +1249,7 @@ static int msm_startup(struct uart_port *port)
 
 static void msm_shutdown(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	msm_port->imr = 0;
 	msm_write(port, 0, UART_IMR); /* disable interrupts */
@@ -1262,7 +1265,7 @@ static void msm_shutdown(struct uart_port *port)
 static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	struct msm_dma *dma = &msm_port->rx_dma;
 	unsigned long flags;
 	unsigned int baud, mr;
@@ -1416,7 +1419,7 @@ static int msm_verify_port(struct uart_port *port, struct serial_struct *ser)
 static void msm_power(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	switch (state) {
 	case 0:
@@ -1435,7 +1438,7 @@ static void msm_power(struct uart_port *port, unsigned int state,
 #ifdef CONFIG_CONSOLE_POLL
 static int msm_poll_get_char_single(struct uart_port *port)
 {
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 	unsigned int rf_reg = msm_port->is_uartdm ? UARTDM_RF : UART_RF;
 
 	if (!(msm_read(port, UART_SR) & UART_SR_RX_READY))
@@ -1489,7 +1492,7 @@ static int msm_poll_get_char(struct uart_port *port)
 {
 	u32 imr;
 	int c;
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	/* Disable all interrupts */
 	imr = msm_read(port, UART_IMR);
@@ -1509,7 +1512,7 @@ static int msm_poll_get_char(struct uart_port *port)
 static void msm_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	u32 imr;
-	struct msm_port *msm_port = UART_TO_MSM(port);
+	struct msm_port *msm_port = to_msm_port(port);
 
 	/* Disable all interrupts */
 	imr = msm_read(port, UART_IMR);
@@ -1677,7 +1680,7 @@ static void msm_console_write(struct console *co, const char *s,
 	BUG_ON(co->index < 0 || co->index >= UART_NR);
 
 	port = msm_get_port_from_line(co->index);
-	msm_port = UART_TO_MSM(port);
+	msm_port = to_msm_port(port);
 
 	__msm_console_write(port, s, count, msm_port->is_uartdm);
 }
@@ -1808,7 +1811,7 @@ static int msm_serial_probe(struct platform_device *pdev)
 
 	port = msm_get_port_from_line(line);
 	port->dev = &pdev->dev;
-	msm_port = UART_TO_MSM(port);
+	msm_port = to_msm_port(port);
 
 	id = of_match_device(msm_uartdm_table, &pdev->dev);
 	if (id)
-- 
2.30.2

