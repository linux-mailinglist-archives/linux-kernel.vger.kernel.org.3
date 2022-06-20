Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186F45515F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiFTKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiFTKe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:34:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14851408E;
        Mon, 20 Jun 2022 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721266; x=1687257266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ucK4emxgkr+bGORz4Ymh1FOn2Kz+GCbQazo5XTt0L2c=;
  b=G/Gd8n+24Sd3C23DeVJue1KatU3eI8rs4IZH01LCgukbuIbwHHYy1Px7
   J33b5WkRFL+pSDb6Oh06NCJGMEoo2hYs9yv9zGKoNfU7ombDwccVwW31J
   JCLPtNdoGZY9irRq2rBw9Zh1x0AlYvBMXHDWWWt/WjknC8Ty8BtoZKP/o
   RNmY97HTpxJ4VJtzuOjbIuCqW9t4bGC03f49teROFCD+e5M6e054OLVOI
   jIhiCiJPv6CdtDqYOlRgIMQsL4aDzVAmZmoGRpw+0BbSoESmru7aQ7Rck
   +hhQS7fmsKpo7apV66Pel3GM/IXl1Yy6jJWEuNhbktICcg6wf6kxs20i3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341543282"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341543282"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643055498"
Received: from lspinell-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:23 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/6] serial: msm: Rename UART_* defines to MSM_UART_*
Date:   Mon, 20 Jun 2022 13:34:04 +0300
Message-Id: <20220620103408.37454-3-ilpo.jarvinen@linux.intel.com>
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

Using UART_* to name defines is a bit problematic. When trying to do
unrelated cleanup which also involved tweaking header inclusion logic,
caused UART_CSR from serial_reg.h to leak into msm's namespace which is
also among msm defines. Thus, rename all UART_* ones to MSM_UART_* to
avoid eliminate possibility of collisions.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/msm_serial.c | 501 ++++++++++++++++----------------
 1 file changed, 250 insertions(+), 251 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 15cab9c4b295..3159889ddae1 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -29,103 +29,103 @@
 #include <linux/of_device.h>
 #include <linux/wait.h>
 
-#define UART_MR1			0x0000
-
-#define UART_MR1_AUTO_RFR_LEVEL0	0x3F
-#define UART_MR1_AUTO_RFR_LEVEL1	0x3FF00
-#define UART_DM_MR1_AUTO_RFR_LEVEL1	0xFFFFFF00
-#define UART_MR1_RX_RDY_CTL		BIT(7)
-#define UART_MR1_CTS_CTL		BIT(6)
-
-#define UART_MR2			0x0004
-#define UART_MR2_ERROR_MODE		BIT(6)
-#define UART_MR2_BITS_PER_CHAR		0x30
-#define UART_MR2_BITS_PER_CHAR_5	(0x0 << 4)
-#define UART_MR2_BITS_PER_CHAR_6	(0x1 << 4)
-#define UART_MR2_BITS_PER_CHAR_7	(0x2 << 4)
-#define UART_MR2_BITS_PER_CHAR_8	(0x3 << 4)
-#define UART_MR2_STOP_BIT_LEN_ONE	(0x1 << 2)
-#define UART_MR2_STOP_BIT_LEN_TWO	(0x3 << 2)
-#define UART_MR2_PARITY_MODE_NONE	0x0
-#define UART_MR2_PARITY_MODE_ODD	0x1
-#define UART_MR2_PARITY_MODE_EVEN	0x2
-#define UART_MR2_PARITY_MODE_SPACE	0x3
-#define UART_MR2_PARITY_MODE		0x3
-
-#define UART_CSR			0x0008
-
-#define UART_TF				0x000C
+#define MSM_UART_MR1			0x0000
+
+#define MSM_UART_MR1_AUTO_RFR_LEVEL0	0x3F
+#define MSM_UART_MR1_AUTO_RFR_LEVEL1	0x3FF00
+#define MSM_UART_DM_MR1_AUTO_RFR_LEVEL1	0xFFFFFF00
+#define MSM_UART_MR1_RX_RDY_CTL		BIT(7)
+#define MSM_UART_MR1_CTS_CTL		BIT(6)
+
+#define MSM_UART_MR2			0x0004
+#define MSM_UART_MR2_ERROR_MODE		BIT(6)
+#define MSM_UART_MR2_BITS_PER_CHAR	0x30
+#define MSM_UART_MR2_BITS_PER_CHAR_5	(0x0 << 4)
+#define MSM_UART_MR2_BITS_PER_CHAR_6	(0x1 << 4)
+#define MSM_UART_MR2_BITS_PER_CHAR_7	(0x2 << 4)
+#define MSM_UART_MR2_BITS_PER_CHAR_8	(0x3 << 4)
+#define MSM_UART_MR2_STOP_BIT_LEN_ONE	(0x1 << 2)
+#define MSM_UART_MR2_STOP_BIT_LEN_TWO	(0x3 << 2)
+#define MSM_UART_MR2_PARITY_MODE_NONE	0x0
+#define MSM_UART_MR2_PARITY_MODE_ODD	0x1
+#define MSM_UART_MR2_PARITY_MODE_EVEN	0x2
+#define MSM_UART_MR2_PARITY_MODE_SPACE	0x3
+#define MSM_UART_MR2_PARITY_MODE	0x3
+
+#define MSM_UART_CSR			0x0008
+
+#define MSM_UART_TF			0x000C
 #define UARTDM_TF			0x0070
 
-#define UART_CR				0x0010
-#define UART_CR_CMD_NULL		(0 << 4)
-#define UART_CR_CMD_RESET_RX		(1 << 4)
-#define UART_CR_CMD_RESET_TX		(2 << 4)
-#define UART_CR_CMD_RESET_ERR		(3 << 4)
-#define UART_CR_CMD_RESET_BREAK_INT	(4 << 4)
-#define UART_CR_CMD_START_BREAK		(5 << 4)
-#define UART_CR_CMD_STOP_BREAK		(6 << 4)
-#define UART_CR_CMD_RESET_CTS		(7 << 4)
-#define UART_CR_CMD_RESET_STALE_INT	(8 << 4)
-#define UART_CR_CMD_PACKET_MODE		(9 << 4)
-#define UART_CR_CMD_MODE_RESET		(12 << 4)
-#define UART_CR_CMD_SET_RFR		(13 << 4)
-#define UART_CR_CMD_RESET_RFR		(14 << 4)
-#define UART_CR_CMD_PROTECTION_EN	(16 << 4)
-#define UART_CR_CMD_STALE_EVENT_DISABLE	(6 << 8)
-#define UART_CR_CMD_STALE_EVENT_ENABLE	(80 << 4)
-#define UART_CR_CMD_FORCE_STALE		(4 << 8)
-#define UART_CR_CMD_RESET_TX_READY	(3 << 8)
-#define UART_CR_TX_DISABLE		BIT(3)
-#define UART_CR_TX_ENABLE		BIT(2)
-#define UART_CR_RX_DISABLE		BIT(1)
-#define UART_CR_RX_ENABLE		BIT(0)
-#define UART_CR_CMD_RESET_RXBREAK_START	((1 << 11) | (2 << 4))
-
-#define UART_IMR			0x0014
-#define UART_IMR_TXLEV			BIT(0)
-#define UART_IMR_RXSTALE		BIT(3)
-#define UART_IMR_RXLEV			BIT(4)
-#define UART_IMR_DELTA_CTS		BIT(5)
-#define UART_IMR_CURRENT_CTS		BIT(6)
-#define UART_IMR_RXBREAK_START		BIT(10)
-
-#define UART_IPR_RXSTALE_LAST		0x20
-#define UART_IPR_STALE_LSB		0x1F
-#define UART_IPR_STALE_TIMEOUT_MSB	0x3FF80
-#define UART_DM_IPR_STALE_TIMEOUT_MSB	0xFFFFFF80
-
-#define UART_IPR			0x0018
-#define UART_TFWR			0x001C
-#define UART_RFWR			0x0020
-#define UART_HCR			0x0024
-
-#define UART_MREG			0x0028
-#define UART_NREG			0x002C
-#define UART_DREG			0x0030
-#define UART_MNDREG			0x0034
-#define UART_IRDA			0x0038
-#define UART_MISR_MODE			0x0040
-#define UART_MISR_RESET			0x0044
-#define UART_MISR_EXPORT		0x0048
-#define UART_MISR_VAL			0x004C
-#define UART_TEST_CTRL			0x0050
-
-#define UART_SR				0x0008
-#define UART_SR_HUNT_CHAR		BIT(7)
-#define UART_SR_RX_BREAK		BIT(6)
-#define UART_SR_PAR_FRAME_ERR		BIT(5)
-#define UART_SR_OVERRUN			BIT(4)
-#define UART_SR_TX_EMPTY		BIT(3)
-#define UART_SR_TX_READY		BIT(2)
-#define UART_SR_RX_FULL			BIT(1)
-#define UART_SR_RX_READY		BIT(0)
-
-#define UART_RF				0x000C
+#define MSM_UART_CR				0x0010
+#define MSM_UART_CR_CMD_NULL			(0 << 4)
+#define MSM_UART_CR_CMD_RESET_RX		(1 << 4)
+#define MSM_UART_CR_CMD_RESET_TX		(2 << 4)
+#define MSM_UART_CR_CMD_RESET_ERR		(3 << 4)
+#define MSM_UART_CR_CMD_RESET_BREAK_INT		(4 << 4)
+#define MSM_UART_CR_CMD_START_BREAK		(5 << 4)
+#define MSM_UART_CR_CMD_STOP_BREAK		(6 << 4)
+#define MSM_UART_CR_CMD_RESET_CTS		(7 << 4)
+#define MSM_UART_CR_CMD_RESET_STALE_INT		(8 << 4)
+#define MSM_UART_CR_CMD_PACKET_MODE		(9 << 4)
+#define MSM_UART_CR_CMD_MODE_RESET		(12 << 4)
+#define MSM_UART_CR_CMD_SET_RFR			(13 << 4)
+#define MSM_UART_CR_CMD_RESET_RFR		(14 << 4)
+#define MSM_UART_CR_CMD_PROTECTION_EN		(16 << 4)
+#define MSM_UART_CR_CMD_STALE_EVENT_DISABLE	(6 << 8)
+#define MSM_UART_CR_CMD_STALE_EVENT_ENABLE	(80 << 4)
+#define MSM_UART_CR_CMD_FORCE_STALE		(4 << 8)
+#define MSM_UART_CR_CMD_RESET_TX_READY		(3 << 8)
+#define MSM_UART_CR_TX_DISABLE			BIT(3)
+#define MSM_UART_CR_TX_ENABLE			BIT(2)
+#define MSM_UART_CR_RX_DISABLE			BIT(1)
+#define MSM_UART_CR_RX_ENABLE			BIT(0)
+#define MSM_UART_CR_CMD_RESET_RXBREAK_START	((1 << 11) | (2 << 4))
+
+#define MSM_UART_IMR			0x0014
+#define MSM_UART_IMR_TXLEV		BIT(0)
+#define MSM_UART_IMR_RXSTALE		BIT(3)
+#define MSM_UART_IMR_RXLEV		BIT(4)
+#define MSM_UART_IMR_DELTA_CTS		BIT(5)
+#define MSM_UART_IMR_CURRENT_CTS	BIT(6)
+#define MSM_UART_IMR_RXBREAK_START	BIT(10)
+
+#define MSM_UART_IPR_RXSTALE_LAST		0x20
+#define MSM_UART_IPR_STALE_LSB			0x1F
+#define MSM_UART_IPR_STALE_TIMEOUT_MSB		0x3FF80
+#define MSM_UART_DM_IPR_STALE_TIMEOUT_MSB	0xFFFFFF80
+
+#define MSM_UART_IPR			0x0018
+#define MSM_UART_TFWR			0x001C
+#define MSM_UART_RFWR			0x0020
+#define MSM_UART_HCR			0x0024
+
+#define MSM_UART_MREG			0x0028
+#define MSM_UART_NREG			0x002C
+#define MSM_UART_DREG			0x0030
+#define MSM_UART_MNDREG			0x0034
+#define MSM_UART_IRDA			0x0038
+#define MSM_UART_MISR_MODE		0x0040
+#define MSM_UART_MISR_RESET		0x0044
+#define MSM_UART_MISR_EXPORT		0x0048
+#define MSM_UART_MISR_VAL		0x004C
+#define MSM_UART_TEST_CTRL		0x0050
+
+#define MSM_UART_SR			0x0008
+#define MSM_UART_SR_HUNT_CHAR		BIT(7)
+#define MSM_UART_SR_RX_BREAK		BIT(6)
+#define MSM_UART_SR_PAR_FRAME_ERR	BIT(5)
+#define MSM_UART_SR_OVERRUN		BIT(4)
+#define MSM_UART_SR_TX_EMPTY		BIT(3)
+#define MSM_UART_SR_TX_READY		BIT(2)
+#define MSM_UART_SR_RX_FULL		BIT(1)
+#define MSM_UART_SR_RX_READY		BIT(0)
+
+#define MSM_UART_RF			0x000C
 #define UARTDM_RF			0x0070
-#define UART_MISR			0x0010
-#define UART_ISR			0x0014
-#define UART_ISR_TX_READY		BIT(7)
+#define MSM_UART_MISR			0x0010
+#define MSM_UART_ISR			0x0014
+#define MSM_UART_ISR_TX_READY		BIT(7)
 
 #define UARTDM_RXFS			0x50
 #define UARTDM_RXFS_BUF_SHIFT		0x7
@@ -203,10 +203,10 @@ unsigned int msm_read(struct uart_port *port, unsigned int off)
  */
 static void msm_serial_set_mnd_regs_tcxo(struct uart_port *port)
 {
-	msm_write(port, 0x06, UART_MREG);
-	msm_write(port, 0xF1, UART_NREG);
-	msm_write(port, 0x0F, UART_DREG);
-	msm_write(port, 0x1A, UART_MNDREG);
+	msm_write(port, 0x06, MSM_UART_MREG);
+	msm_write(port, 0xF1, MSM_UART_NREG);
+	msm_write(port, 0x0F, MSM_UART_DREG);
+	msm_write(port, 0x1A, MSM_UART_MNDREG);
 	port->uartclk = 1843200;
 }
 
@@ -215,10 +215,10 @@ static void msm_serial_set_mnd_regs_tcxo(struct uart_port *port)
  */
 static void msm_serial_set_mnd_regs_tcxoby4(struct uart_port *port)
 {
-	msm_write(port, 0x18, UART_MREG);
-	msm_write(port, 0xF6, UART_NREG);
-	msm_write(port, 0x0F, UART_DREG);
-	msm_write(port, 0x0A, UART_MNDREG);
+	msm_write(port, 0x18, MSM_UART_MREG);
+	msm_write(port, 0xF6, MSM_UART_NREG);
+	msm_write(port, 0x0F, MSM_UART_DREG);
+	msm_write(port, 0x0A, MSM_UART_MNDREG);
 	port->uartclk = 1843200;
 }
 
@@ -395,22 +395,22 @@ static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
 	unsigned int timeout = 500000;
 
-	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
-		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
+	while (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_TX_EMPTY)) {
+		if (msm_read(port, MSM_UART_ISR) & MSM_UART_ISR_TX_READY)
 			break;
 		udelay(1);
 		if (!timeout--)
 			break;
 	}
-	msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_RESET_TX_READY, MSM_UART_CR);
 }
 
 static void msm_stop_tx(struct uart_port *port)
 {
 	struct msm_port *msm_port = to_msm_port(port);
 
-	msm_port->imr &= ~UART_IMR_TXLEV;
-	msm_write(port, msm_port->imr, UART_IMR);
+	msm_port->imr &= ~MSM_UART_IMR_TXLEV;
+	msm_write(port, msm_port->imr, MSM_UART_IMR);
 }
 
 static void msm_start_tx(struct uart_port *port)
@@ -422,8 +422,8 @@ static void msm_start_tx(struct uart_port *port)
 	if (dma->count)
 		return;
 
-	msm_port->imr |= UART_IMR_TXLEV;
-	msm_write(port, msm_port->imr, UART_IMR);
+	msm_port->imr |= MSM_UART_IMR_TXLEV;
+	msm_write(port, msm_port->imr, MSM_UART_IMR);
 }
 
 static void msm_reset_dm_count(struct uart_port *port, int count)
@@ -459,8 +459,8 @@ static void msm_complete_tx_dma(void *args)
 	msm_write(port, val, UARTDM_DMEN);
 
 	if (msm_port->is_uartdm > UARTDM_1P3) {
-		msm_write(port, UART_CR_CMD_RESET_TX, UART_CR);
-		msm_write(port, UART_CR_TX_ENABLE, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
+		msm_write(port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
 	}
 
 	count = dma->count - state.residue;
@@ -471,8 +471,8 @@ static void msm_complete_tx_dma(void *args)
 	xmit->tail &= UART_XMIT_SIZE - 1;
 
 	/* Restore "Tx FIFO below watermark" interrupt */
-	msm_port->imr |= UART_IMR_TXLEV;
-	msm_write(port, msm_port->imr, UART_IMR);
+	msm_port->imr |= MSM_UART_IMR_TXLEV;
+	msm_write(port, msm_port->imr, MSM_UART_IMR);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -519,8 +519,8 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	 * Using DMA complete for Tx FIFO reload, no need for
 	 * "Tx FIFO below watermark" one, disable it
 	 */
-	msm_port->imr &= ~UART_IMR_TXLEV;
-	msm_write(port, msm_port->imr, UART_IMR);
+	msm_port->imr &= ~MSM_UART_IMR_TXLEV;
+	msm_write(port, msm_port->imr, MSM_UART_IMR);
 
 	dma->count = count;
 
@@ -562,10 +562,10 @@ static void msm_complete_rx_dma(void *args)
 	val &= ~dma->enable_bit;
 	msm_write(port, val, UARTDM_DMEN);
 
-	if (msm_read(port, UART_SR) & UART_SR_OVERRUN) {
+	if (msm_read(port, MSM_UART_SR) & MSM_UART_SR_OVERRUN) {
 		port->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-		msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_RESET_ERR, MSM_UART_CR);
 	}
 
 	count = msm_read(port, UARTDM_RX_TOTAL_SNAP);
@@ -587,7 +587,7 @@ static void msm_complete_rx_dma(void *args)
 				continue;
 		}
 
-		if (!(port->read_status_mask & UART_SR_RX_BREAK))
+		if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 			flag = TTY_NORMAL;
 
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -641,23 +641,23 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 	 * Using DMA for FIFO off-load, no need for "Rx FIFO over
 	 * watermark" or "stale" interrupts, disable them
 	 */
-	msm_port->imr &= ~(UART_IMR_RXLEV | UART_IMR_RXSTALE);
+	msm_port->imr &= ~(MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE);
 
 	/*
 	 * Well, when DMA is ADM3 engine(implied by <= UARTDM v1.3),
 	 * we need RXSTALE to flush input DMA fifo to memory
 	 */
 	if (msm_port->is_uartdm < UARTDM_1P4)
-		msm_port->imr |= UART_IMR_RXSTALE;
+		msm_port->imr |= MSM_UART_IMR_RXSTALE;
 
-	msm_write(uart, msm_port->imr, UART_IMR);
+	msm_write(uart, msm_port->imr, MSM_UART_IMR);
 
 	dma->count = UARTDM_RX_SIZE;
 
 	dma_async_issue_pending(dma->chan);
 
-	msm_write(uart, UART_CR_CMD_RESET_STALE_INT, UART_CR);
-	msm_write(uart, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
+	msm_write(uart, MSM_UART_CR_CMD_RESET_STALE_INT, MSM_UART_CR);
+	msm_write(uart, MSM_UART_CR_CMD_STALE_EVENT_ENABLE, MSM_UART_CR);
 
 	val = msm_read(uart, UARTDM_DMEN);
 	val |= dma->enable_bit;
@@ -679,16 +679,16 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 	 * Switch from DMA to SW/FIFO mode. After clearing Rx BAM (UARTDM_DMEN),
 	 * receiver must be reset.
 	 */
-	msm_write(uart, UART_CR_CMD_RESET_RX, UART_CR);
-	msm_write(uart, UART_CR_RX_ENABLE, UART_CR);
+	msm_write(uart, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
+	msm_write(uart, MSM_UART_CR_RX_ENABLE, MSM_UART_CR);
 
-	msm_write(uart, UART_CR_CMD_RESET_STALE_INT, UART_CR);
+	msm_write(uart, MSM_UART_CR_CMD_RESET_STALE_INT, MSM_UART_CR);
 	msm_write(uart, 0xFFFFFF, UARTDM_DMRX);
-	msm_write(uart, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
+	msm_write(uart, MSM_UART_CR_CMD_STALE_EVENT_ENABLE, MSM_UART_CR);
 
 	/* Re-enable RX interrupts */
-	msm_port->imr |= (UART_IMR_RXLEV | UART_IMR_RXSTALE);
-	msm_write(uart, msm_port->imr, UART_IMR);
+	msm_port->imr |= MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE;
+	msm_write(uart, msm_port->imr, MSM_UART_IMR);
 }
 
 static void msm_stop_rx(struct uart_port *port)
@@ -696,8 +696,8 @@ static void msm_stop_rx(struct uart_port *port)
 	struct msm_port *msm_port = to_msm_port(port);
 	struct msm_dma *dma = &msm_port->rx_dma;
 
-	msm_port->imr &= ~(UART_IMR_RXLEV | UART_IMR_RXSTALE);
-	msm_write(port, msm_port->imr, UART_IMR);
+	msm_port->imr &= ~(MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE);
+	msm_write(port, msm_port->imr, MSM_UART_IMR);
 
 	if (dma->chan)
 		msm_stop_dma(port, dma);
@@ -707,8 +707,8 @@ static void msm_enable_ms(struct uart_port *port)
 {
 	struct msm_port *msm_port = to_msm_port(port);
 
-	msm_port->imr |= UART_IMR_DELTA_CTS;
-	msm_write(port, msm_port->imr, UART_IMR);
+	msm_port->imr |= MSM_UART_IMR_DELTA_CTS;
+	msm_write(port, msm_port->imr, MSM_UART_IMR);
 }
 
 static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
@@ -719,18 +719,18 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 	int count = 0;
 	struct msm_port *msm_port = to_msm_port(port);
 
-	if ((msm_read(port, UART_SR) & UART_SR_OVERRUN)) {
+	if ((msm_read(port, MSM_UART_SR) & MSM_UART_SR_OVERRUN)) {
 		port->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-		msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_RESET_ERR, MSM_UART_CR);
 	}
 
-	if (misr & UART_IMR_RXSTALE) {
+	if (misr & MSM_UART_IMR_RXSTALE) {
 		count = msm_read(port, UARTDM_RX_TOTAL_SNAP) -
 			msm_port->old_snap_state;
 		msm_port->old_snap_state = 0;
 	} else {
-		count = 4 * (msm_read(port, UART_RFWR));
+		count = 4 * (msm_read(port, MSM_UART_RFWR));
 		msm_port->old_snap_state += count;
 	}
 
@@ -742,8 +742,8 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 		unsigned char buf[4];
 		int sysrq, r_count, i;
 
-		sr = msm_read(port, UART_SR);
-		if ((sr & UART_SR_RX_READY) == 0) {
+		sr = msm_read(port, MSM_UART_SR);
+		if ((sr & MSM_UART_SR_RX_READY) == 0) {
 			msm_port->old_snap_state -= count;
 			break;
 		}
@@ -762,7 +762,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 					continue;
 			}
 
-			if (!(port->read_status_mask & UART_SR_RX_BREAK))
+			if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 				flag = TTY_NORMAL;
 
 			spin_unlock(&port->lock);
@@ -776,10 +776,10 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 
 	tty_flip_buffer_push(tport);
 
-	if (misr & (UART_IMR_RXSTALE))
-		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
+	if (misr & (MSM_UART_IMR_RXSTALE))
+		msm_write(port, MSM_UART_CR_CMD_RESET_STALE_INT, MSM_UART_CR);
 	msm_write(port, 0xFFFFFF, UARTDM_DMRX);
-	msm_write(port, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_STALE_EVENT_ENABLE, MSM_UART_CR);
 
 	/* Try to use DMA */
 	msm_start_rx_dma(msm_port);
@@ -795,25 +795,25 @@ static void msm_handle_rx(struct uart_port *port)
 	 * Handle overrun. My understanding of the hardware is that overrun
 	 * is not tied to the RX buffer, so we handle the case out of band.
 	 */
-	if ((msm_read(port, UART_SR) & UART_SR_OVERRUN)) {
+	if ((msm_read(port, MSM_UART_SR) & MSM_UART_SR_OVERRUN)) {
 		port->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-		msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_RESET_ERR, MSM_UART_CR);
 	}
 
 	/* and now the main RX loop */
-	while ((sr = msm_read(port, UART_SR)) & UART_SR_RX_READY) {
+	while ((sr = msm_read(port, MSM_UART_SR)) & MSM_UART_SR_RX_READY) {
 		unsigned int c;
 		char flag = TTY_NORMAL;
 		int sysrq;
 
-		c = msm_read(port, UART_RF);
+		c = msm_read(port, MSM_UART_RF);
 
-		if (sr & UART_SR_RX_BREAK) {
+		if (sr & MSM_UART_SR_RX_BREAK) {
 			port->icount.brk++;
 			if (uart_handle_break(port))
 				continue;
-		} else if (sr & UART_SR_PAR_FRAME_ERR) {
+		} else if (sr & MSM_UART_SR_PAR_FRAME_ERR) {
 			port->icount.frame++;
 		} else {
 			port->icount.rx++;
@@ -822,9 +822,9 @@ static void msm_handle_rx(struct uart_port *port)
 		/* Mask conditions we're ignorning. */
 		sr &= port->read_status_mask;
 
-		if (sr & UART_SR_RX_BREAK)
+		if (sr & MSM_UART_SR_RX_BREAK)
 			flag = TTY_BREAK;
-		else if (sr & UART_SR_PAR_FRAME_ERR)
+		else if (sr & MSM_UART_SR_PAR_FRAME_ERR)
 			flag = TTY_FRAME;
 
 		spin_unlock(&port->lock);
@@ -848,7 +848,7 @@ static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
 	if (msm_port->is_uartdm)
 		tf = port->membase + UARTDM_TF;
 	else
-		tf = port->membase + UART_TF;
+		tf = port->membase + MSM_UART_TF;
 
 	if (tx_count && msm_port->is_uartdm)
 		msm_reset_dm_count(port, tx_count);
@@ -857,7 +857,7 @@ static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
 		int i;
 		char buf[4] = { 0 };
 
-		if (!(msm_read(port, UART_SR) & UART_SR_TX_READY))
+		if (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_TX_READY))
 			break;
 
 		if (msm_port->is_uartdm)
@@ -898,7 +898,7 @@ static void msm_handle_tx(struct uart_port *port)
 		if (msm_port->is_uartdm)
 			tf = port->membase + UARTDM_TF;
 		else
-			tf = port->membase + UART_TF;
+			tf = port->membase + MSM_UART_TF;
 
 		buf[0] = port->x_char;
 
@@ -942,7 +942,7 @@ static void msm_handle_tx(struct uart_port *port)
 
 static void msm_handle_delta_cts(struct uart_port *port)
 {
-	msm_write(port, UART_CR_CMD_RESET_CTS, UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_RESET_CTS, MSM_UART_CR);
 	port->icount.cts++;
 	wake_up_interruptible(&port->state->port.delta_msr_wait);
 }
@@ -957,20 +957,20 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 	u32 val;
 
 	spin_lock_irqsave(&port->lock, flags);
-	misr = msm_read(port, UART_MISR);
-	msm_write(port, 0, UART_IMR); /* disable interrupt */
+	misr = msm_read(port, MSM_UART_MISR);
+	msm_write(port, 0, MSM_UART_IMR); /* disable interrupt */
 
-	if (misr & UART_IMR_RXBREAK_START) {
+	if (misr & MSM_UART_IMR_RXBREAK_START) {
 		msm_port->break_detected = true;
-		msm_write(port, UART_CR_CMD_RESET_RXBREAK_START, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_RESET_RXBREAK_START, MSM_UART_CR);
 	}
 
-	if (misr & (UART_IMR_RXLEV | UART_IMR_RXSTALE)) {
+	if (misr & (MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE)) {
 		if (dma->count) {
-			val = UART_CR_CMD_STALE_EVENT_DISABLE;
-			msm_write(port, val, UART_CR);
-			val = UART_CR_CMD_RESET_STALE_INT;
-			msm_write(port, val, UART_CR);
+			val = MSM_UART_CR_CMD_STALE_EVENT_DISABLE;
+			msm_write(port, val, MSM_UART_CR);
+			val = MSM_UART_CR_CMD_RESET_STALE_INT;
+			msm_write(port, val, MSM_UART_CR);
 			/*
 			 * Flush DMA input fifo to memory, this will also
 			 * trigger DMA RX completion
@@ -982,12 +982,12 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 			msm_handle_rx(port);
 		}
 	}
-	if (misr & UART_IMR_TXLEV)
+	if (misr & MSM_UART_IMR_TXLEV)
 		msm_handle_tx(port);
-	if (misr & UART_IMR_DELTA_CTS)
+	if (misr & MSM_UART_IMR_DELTA_CTS)
 		msm_handle_delta_cts(port);
 
-	msm_write(port, msm_port->imr, UART_IMR); /* restore interrupt */
+	msm_write(port, msm_port->imr, MSM_UART_IMR); /* restore interrupt */
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_HANDLED;
@@ -995,7 +995,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 
 static unsigned int msm_tx_empty(struct uart_port *port)
 {
-	return (msm_read(port, UART_SR) & UART_SR_TX_EMPTY) ? TIOCSER_TEMT : 0;
+	return (msm_read(port, MSM_UART_SR) & MSM_UART_SR_TX_EMPTY) ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int msm_get_mctrl(struct uart_port *port)
@@ -1009,15 +1009,15 @@ static void msm_reset(struct uart_port *port)
 	unsigned int mr;
 
 	/* reset everything */
-	msm_write(port, UART_CR_CMD_RESET_RX, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_TX, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_BREAK_INT, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_CTS, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_RFR, UART_CR);
-	mr = msm_read(port, UART_MR1);
-	mr &= ~UART_MR1_RX_RDY_CTL;
-	msm_write(port, mr, UART_MR1);
+	msm_write(port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_RESET_ERR, MSM_UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_RESET_BREAK_INT, MSM_UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_RESET_CTS, MSM_UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_RESET_RFR, MSM_UART_CR);
+	mr = msm_read(port, MSM_UART_MR1);
+	mr &= ~MSM_UART_MR1_RX_RDY_CTL;
+	msm_write(port, mr, MSM_UART_MR1);
 
 	/* Disable DM modes */
 	if (msm_port->is_uartdm)
@@ -1028,24 +1028,24 @@ static void msm_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	unsigned int mr;
 
-	mr = msm_read(port, UART_MR1);
+	mr = msm_read(port, MSM_UART_MR1);
 
 	if (!(mctrl & TIOCM_RTS)) {
-		mr &= ~UART_MR1_RX_RDY_CTL;
-		msm_write(port, mr, UART_MR1);
-		msm_write(port, UART_CR_CMD_RESET_RFR, UART_CR);
+		mr &= ~MSM_UART_MR1_RX_RDY_CTL;
+		msm_write(port, mr, MSM_UART_MR1);
+		msm_write(port, MSM_UART_CR_CMD_RESET_RFR, MSM_UART_CR);
 	} else {
-		mr |= UART_MR1_RX_RDY_CTL;
-		msm_write(port, mr, UART_MR1);
+		mr |= MSM_UART_MR1_RX_RDY_CTL;
+		msm_write(port, mr, MSM_UART_MR1);
 	}
 }
 
 static void msm_break_ctl(struct uart_port *port, int break_ctl)
 {
 	if (break_ctl)
-		msm_write(port, UART_CR_CMD_START_BREAK, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_START_BREAK, MSM_UART_CR);
 	else
-		msm_write(port, UART_CR_CMD_STOP_BREAK, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_STOP_BREAK, MSM_UART_CR);
 }
 
 struct msm_baud_map {
@@ -1142,45 +1142,45 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 	*saved_flags = flags;
 	port->uartclk = rate;
 
-	msm_write(port, entry->code, UART_CSR);
+	msm_write(port, entry->code, MSM_UART_CSR);
 
 	/* RX stale watermark */
 	rxstale = entry->rxstale;
-	watermark = UART_IPR_STALE_LSB & rxstale;
+	watermark = MSM_UART_IPR_STALE_LSB & rxstale;
 	if (msm_port->is_uartdm) {
-		mask = UART_DM_IPR_STALE_TIMEOUT_MSB;
+		mask = MSM_UART_DM_IPR_STALE_TIMEOUT_MSB;
 	} else {
-		watermark |= UART_IPR_RXSTALE_LAST;
-		mask = UART_IPR_STALE_TIMEOUT_MSB;
+		watermark |= MSM_UART_IPR_RXSTALE_LAST;
+		mask = MSM_UART_IPR_STALE_TIMEOUT_MSB;
 	}
 
 	watermark |= mask & (rxstale << 2);
 
-	msm_write(port, watermark, UART_IPR);
+	msm_write(port, watermark, MSM_UART_IPR);
 
 	/* set RX watermark */
 	watermark = (port->fifosize * 3) / 4;
-	msm_write(port, watermark, UART_RFWR);
+	msm_write(port, watermark, MSM_UART_RFWR);
 
 	/* set TX watermark */
-	msm_write(port, 10, UART_TFWR);
+	msm_write(port, 10, MSM_UART_TFWR);
 
-	msm_write(port, UART_CR_CMD_PROTECTION_EN, UART_CR);
+	msm_write(port, MSM_UART_CR_CMD_PROTECTION_EN, MSM_UART_CR);
 	msm_reset(port);
 
 	/* Enable RX and TX */
-	msm_write(port, UART_CR_TX_ENABLE | UART_CR_RX_ENABLE, UART_CR);
+	msm_write(port, MSM_UART_CR_TX_ENABLE | MSM_UART_CR_RX_ENABLE, MSM_UART_CR);
 
 	/* turn on RX and CTS interrupts */
-	msm_port->imr = UART_IMR_RXLEV | UART_IMR_RXSTALE |
-			UART_IMR_CURRENT_CTS | UART_IMR_RXBREAK_START;
+	msm_port->imr = MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE |
+			MSM_UART_IMR_CURRENT_CTS | MSM_UART_IMR_RXBREAK_START;
 
-	msm_write(port, msm_port->imr, UART_IMR);
+	msm_write(port, msm_port->imr, MSM_UART_IMR);
 
 	if (msm_port->is_uartdm) {
-		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_RESET_STALE_INT, MSM_UART_CR);
 		msm_write(port, 0xFFFFFF, UARTDM_DMRX);
-		msm_write(port, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
+		msm_write(port, MSM_UART_CR_CMD_STALE_EVENT_ENABLE, MSM_UART_CR);
 	}
 
 	return baud;
@@ -1212,18 +1212,18 @@ static int msm_startup(struct uart_port *port)
 		rfr_level = port->fifosize;
 
 	/* set automatic RFR level */
-	data = msm_read(port, UART_MR1);
+	data = msm_read(port, MSM_UART_MR1);
 
 	if (msm_port->is_uartdm)
-		mask = UART_DM_MR1_AUTO_RFR_LEVEL1;
+		mask = MSM_UART_DM_MR1_AUTO_RFR_LEVEL1;
 	else
-		mask = UART_MR1_AUTO_RFR_LEVEL1;
+		mask = MSM_UART_MR1_AUTO_RFR_LEVEL1;
 
 	data &= ~mask;
-	data &= ~UART_MR1_AUTO_RFR_LEVEL0;
+	data &= ~MSM_UART_MR1_AUTO_RFR_LEVEL0;
 	data |= mask & (rfr_level << 2);
-	data |= UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
-	msm_write(port, data, UART_MR1);
+	data |= MSM_UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
+	msm_write(port, data, MSM_UART_MR1);
 
 	if (msm_port->is_uartdm) {
 		msm_request_tx_dma(msm_port, msm_port->uart.mapbase);
@@ -1252,7 +1252,7 @@ static void msm_shutdown(struct uart_port *port)
 	struct msm_port *msm_port = to_msm_port(port);
 
 	msm_port->imr = 0;
-	msm_write(port, 0, UART_IMR); /* disable interrupts */
+	msm_write(port, 0, MSM_UART_IMR); /* disable interrupts */
 
 	if (msm_port->is_uartdm)
 		msm_release_dma(msm_port);
@@ -1282,60 +1282,60 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 		tty_termios_encode_baud_rate(termios, baud, baud);
 
 	/* calculate parity */
-	mr = msm_read(port, UART_MR2);
-	mr &= ~UART_MR2_PARITY_MODE;
+	mr = msm_read(port, MSM_UART_MR2);
+	mr &= ~MSM_UART_MR2_PARITY_MODE;
 	if (termios->c_cflag & PARENB) {
 		if (termios->c_cflag & PARODD)
-			mr |= UART_MR2_PARITY_MODE_ODD;
+			mr |= MSM_UART_MR2_PARITY_MODE_ODD;
 		else if (termios->c_cflag & CMSPAR)
-			mr |= UART_MR2_PARITY_MODE_SPACE;
+			mr |= MSM_UART_MR2_PARITY_MODE_SPACE;
 		else
-			mr |= UART_MR2_PARITY_MODE_EVEN;
+			mr |= MSM_UART_MR2_PARITY_MODE_EVEN;
 	}
 
 	/* calculate bits per char */
-	mr &= ~UART_MR2_BITS_PER_CHAR;
+	mr &= ~MSM_UART_MR2_BITS_PER_CHAR;
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
-		mr |= UART_MR2_BITS_PER_CHAR_5;
+		mr |= MSM_UART_MR2_BITS_PER_CHAR_5;
 		break;
 	case CS6:
-		mr |= UART_MR2_BITS_PER_CHAR_6;
+		mr |= MSM_UART_MR2_BITS_PER_CHAR_6;
 		break;
 	case CS7:
-		mr |= UART_MR2_BITS_PER_CHAR_7;
+		mr |= MSM_UART_MR2_BITS_PER_CHAR_7;
 		break;
 	case CS8:
 	default:
-		mr |= UART_MR2_BITS_PER_CHAR_8;
+		mr |= MSM_UART_MR2_BITS_PER_CHAR_8;
 		break;
 	}
 
 	/* calculate stop bits */
-	mr &= ~(UART_MR2_STOP_BIT_LEN_ONE | UART_MR2_STOP_BIT_LEN_TWO);
+	mr &= ~(MSM_UART_MR2_STOP_BIT_LEN_ONE | MSM_UART_MR2_STOP_BIT_LEN_TWO);
 	if (termios->c_cflag & CSTOPB)
-		mr |= UART_MR2_STOP_BIT_LEN_TWO;
+		mr |= MSM_UART_MR2_STOP_BIT_LEN_TWO;
 	else
-		mr |= UART_MR2_STOP_BIT_LEN_ONE;
+		mr |= MSM_UART_MR2_STOP_BIT_LEN_ONE;
 
 	/* set parity, bits per char, and stop bit */
-	msm_write(port, mr, UART_MR2);
+	msm_write(port, mr, MSM_UART_MR2);
 
 	/* calculate and set hardware flow control */
-	mr = msm_read(port, UART_MR1);
-	mr &= ~(UART_MR1_CTS_CTL | UART_MR1_RX_RDY_CTL);
+	mr = msm_read(port, MSM_UART_MR1);
+	mr &= ~(MSM_UART_MR1_CTS_CTL | MSM_UART_MR1_RX_RDY_CTL);
 	if (termios->c_cflag & CRTSCTS) {
-		mr |= UART_MR1_CTS_CTL;
-		mr |= UART_MR1_RX_RDY_CTL;
+		mr |= MSM_UART_MR1_CTS_CTL;
+		mr |= MSM_UART_MR1_RX_RDY_CTL;
 	}
-	msm_write(port, mr, UART_MR1);
+	msm_write(port, mr, MSM_UART_MR1);
 
 	/* Configure status bits to ignore based on termio flags. */
 	port->read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		port->read_status_mask |= UART_SR_PAR_FRAME_ERR;
+		port->read_status_mask |= MSM_UART_SR_PAR_FRAME_ERR;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		port->read_status_mask |= UART_SR_RX_BREAK;
+		port->read_status_mask |= MSM_UART_SR_RX_BREAK;
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
@@ -1439,9 +1439,9 @@ static void msm_power(struct uart_port *port, unsigned int state,
 static int msm_poll_get_char_single(struct uart_port *port)
 {
 	struct msm_port *msm_port = to_msm_port(port);
-	unsigned int rf_reg = msm_port->is_uartdm ? UARTDM_RF : UART_RF;
+	unsigned int rf_reg = msm_port->is_uartdm ? UARTDM_RF : MSM_UART_RF;
 
-	if (!(msm_read(port, UART_SR) & UART_SR_RX_READY))
+	if (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_RX_READY))
 		return NO_POLL_CHAR;
 
 	return msm_read(port, rf_reg) & 0xff;
@@ -1459,7 +1459,7 @@ static int msm_poll_get_char_dm(struct uart_port *port)
 		c = sp[sizeof(slop) - count];
 		count--;
 	/* Or if FIFO is empty */
-	} else if (!(msm_read(port, UART_SR) & UART_SR_RX_READY)) {
+	} else if (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_RX_READY)) {
 		/*
 		 * If RX packing buffer has less than a word, force stale to
 		 * push contents into RX FIFO
@@ -1467,14 +1467,13 @@ static int msm_poll_get_char_dm(struct uart_port *port)
 		count = msm_read(port, UARTDM_RXFS);
 		count = (count >> UARTDM_RXFS_BUF_SHIFT) & UARTDM_RXFS_BUF_MASK;
 		if (count) {
-			msm_write(port, UART_CR_CMD_FORCE_STALE, UART_CR);
+			msm_write(port, MSM_UART_CR_CMD_FORCE_STALE, MSM_UART_CR);
 			slop = msm_read(port, UARTDM_RF);
 			c = sp[0];
 			count--;
-			msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
+			msm_write(port, MSM_UART_CR_CMD_RESET_STALE_INT, MSM_UART_CR);
 			msm_write(port, 0xFFFFFF, UARTDM_DMRX);
-			msm_write(port, UART_CR_CMD_STALE_EVENT_ENABLE,
-				  UART_CR);
+			msm_write(port, MSM_UART_CR_CMD_STALE_EVENT_ENABLE, MSM_UART_CR);
 		} else {
 			c = NO_POLL_CHAR;
 		}
@@ -1495,8 +1494,8 @@ static int msm_poll_get_char(struct uart_port *port)
 	struct msm_port *msm_port = to_msm_port(port);
 
 	/* Disable all interrupts */
-	imr = msm_read(port, UART_IMR);
-	msm_write(port, 0, UART_IMR);
+	imr = msm_read(port, MSM_UART_IMR);
+	msm_write(port, 0, MSM_UART_IMR);
 
 	if (msm_port->is_uartdm)
 		c = msm_poll_get_char_dm(port);
@@ -1504,7 +1503,7 @@ static int msm_poll_get_char(struct uart_port *port)
 		c = msm_poll_get_char_single(port);
 
 	/* Enable interrupts */
-	msm_write(port, imr, UART_IMR);
+	msm_write(port, imr, MSM_UART_IMR);
 
 	return c;
 }
@@ -1515,25 +1514,25 @@ static void msm_poll_put_char(struct uart_port *port, unsigned char c)
 	struct msm_port *msm_port = to_msm_port(port);
 
 	/* Disable all interrupts */
-	imr = msm_read(port, UART_IMR);
-	msm_write(port, 0, UART_IMR);
+	imr = msm_read(port, MSM_UART_IMR);
+	msm_write(port, 0, MSM_UART_IMR);
 
 	if (msm_port->is_uartdm)
 		msm_reset_dm_count(port, 1);
 
 	/* Wait until FIFO is empty */
-	while (!(msm_read(port, UART_SR) & UART_SR_TX_READY))
+	while (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_TX_READY))
 		cpu_relax();
 
 	/* Write a character */
-	msm_write(port, c, msm_port->is_uartdm ? UARTDM_TF : UART_TF);
+	msm_write(port, c, msm_port->is_uartdm ? UARTDM_TF : MSM_UART_TF);
 
 	/* Wait until FIFO is empty */
-	while (!(msm_read(port, UART_SR) & UART_SR_TX_READY))
+	while (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_TX_READY))
 		cpu_relax();
 
 	/* Enable interrupts */
-	msm_write(port, imr, UART_IMR);
+	msm_write(port, imr, MSM_UART_IMR);
 }
 #endif
 
@@ -1591,7 +1590,7 @@ static struct msm_port msm_uart_ports[] = {
 	},
 };
 
-#define UART_NR	ARRAY_SIZE(msm_uart_ports)
+#define MSM_UART_NR	ARRAY_SIZE(msm_uart_ports)
 
 static inline struct uart_port *msm_get_port_from_line(unsigned int line)
 {
@@ -1612,7 +1611,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 	if (is_uartdm)
 		tf = port->membase + UARTDM_TF;
 	else
-		tf = port->membase + UART_TF;
+		tf = port->membase + MSM_UART_TF;
 
 	/* Account for newlines that will get a carriage return added */
 	for (i = 0; i < count; i++)
@@ -1658,7 +1657,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 			}
 		}
 
-		while (!(msm_read(port, UART_SR) & UART_SR_TX_READY))
+		while (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_TX_READY))
 			cpu_relax();
 
 		iowrite32_rep(tf, buf, 1);
@@ -1677,7 +1676,7 @@ static void msm_console_write(struct console *co, const char *s,
 	struct uart_port *port;
 	struct msm_port *msm_port;
 
-	BUG_ON(co->index < 0 || co->index >= UART_NR);
+	BUG_ON(co->index < 0 || co->index >= MSM_UART_NR);
 
 	port = msm_get_port_from_line(co->index);
 	msm_port = to_msm_port(port);
@@ -1693,7 +1692,7 @@ static int msm_console_setup(struct console *co, char *options)
 	int parity = 'n';
 	int flow = 'n';
 
-	if (unlikely(co->index >= UART_NR || co->index < 0))
+	if (unlikely(co->index >= MSM_UART_NR || co->index < 0))
 		return -ENXIO;
 
 	port = msm_get_port_from_line(co->index);
@@ -1774,7 +1773,7 @@ static struct uart_driver msm_uart_driver = {
 	.owner = THIS_MODULE,
 	.driver_name = "msm_serial",
 	.dev_name = "ttyMSM",
-	.nr = UART_NR,
+	.nr = MSM_UART_NR,
 	.cons = MSM_CONSOLE,
 };
 
@@ -1804,7 +1803,7 @@ static int msm_serial_probe(struct platform_device *pdev)
 	if (line < 0)
 		line = atomic_inc_return(&msm_uart_next_id) - 1;
 
-	if (unlikely(line < 0 || line >= UART_NR))
+	if (unlikely(line < 0 || line >= MSM_UART_NR))
 		return -ENXIO;
 
 	dev_info(&pdev->dev, "msm_serial: detected port #%d\n", line);
-- 
2.30.2

