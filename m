Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D8597ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiHRBBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiHRBBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:01:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453748E465;
        Wed, 17 Aug 2022 18:01:10 -0700 (PDT)
Received: from localhost (unknown [82.79.170.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FA0D6601AC9;
        Thu, 18 Aug 2022 02:01:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660784468;
        bh=NdzPbe/rVhwQbZ+5l+FPEW2hhIRb2i7pyko52KBtvJs=;
        h=From:To:Cc:Subject:Date:From;
        b=V6zMgFlzJG+fo4T7MUWYzhgzMC8ywi/HMB1FMsrMw+y5EVHB9iQC8PclcyyyeA1td
         5OPl4XkNWKdd6zFz6ZxCf2GZ9SL99jCPn2DRF7uGPoPOVpKVgda00r1InZRSKNkVWj
         yT8kEC8aR/Y4knZ67QWnOBGzyynEjpcf1XA5kUK2Qxkg3sHsRM6NttadTLR+VrjYJn
         5OrcAy123FpYHvXtTSYD1ChLP/HbO0VuKZd3rN5TyXnuvaXDFc9xKCYEVxPTv3Wo/e
         h6mU8M8yh1LKOHHrD9vm1RLJv37OBGbIXFAE8fADau7rWtjA861BxM8JPvPfTRMs0v
         /EppvccoKsARw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] spi: amd: Setup all xfers before opcode execution
Date:   Thu, 18 Aug 2022 04:00:59 +0300
Message-Id: <20220818010059.403776-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD SPI controller hardware seems to expect the FIFO buffer to be
fully setup with the details of all transfers in the SPI message before
it is able to start processing the data in a reliable way.

Furthermore, it imposes a strict ordering restriction, in the sense that
all TX transfers must be handled prior any RX transfer.

Hence, let's ensure amd_spi_execute_opcode() is called only once, after
all TX transfers have been setup, and process any remaining RX transfers
afterwards, in a second iteration.

Additionally, get rid of the unnecessary AMD_SPI_XFER_TX/RX defines and
improve error handling.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/spi/spi-amd.c | 93 ++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 08df4f8d0531..b3b3f5167c4c 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -36,10 +36,6 @@
 #define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
 
-/* M_CMD OP codes for SPI */
-#define AMD_SPI_XFER_TX		1
-#define AMD_SPI_XFER_RX		2
-
 /**
  * enum amd_spi_versions - SPI controller versions
  * @AMD_SPI_V1:		AMDI0061 hardware version
@@ -194,60 +190,67 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 				    struct spi_message *message)
 {
 	struct spi_transfer *xfer = NULL;
-	u8 cmd_opcode;
+	u8 cmd_opcode = 0, fifo_pos = AMD_SPI_FIFO_BASE;
 	u8 *buf = NULL;
-	u32 m_cmd = 0;
 	u32 i = 0;
 	u32 tx_len = 0, rx_len = 0;
 
 	list_for_each_entry(xfer, &message->transfers,
 			    transfer_list) {
-		if (xfer->rx_buf)
-			m_cmd = AMD_SPI_XFER_RX;
-		if (xfer->tx_buf)
-			m_cmd = AMD_SPI_XFER_TX;
-
-		if (m_cmd & AMD_SPI_XFER_TX) {
+		if (xfer->tx_buf) {
 			buf = (u8 *)xfer->tx_buf;
-			tx_len = xfer->len - 1;
-			cmd_opcode = *(u8 *)xfer->tx_buf;
-			buf++;
-			amd_spi_set_opcode(amd_spi, cmd_opcode);
+			if (!tx_len) {
+				cmd_opcode = *(u8 *)xfer->tx_buf;
+				buf++;
+				xfer->len--;
+			}
+			tx_len += xfer->len;
 
 			/* Write data into the FIFO. */
-			for (i = 0; i < tx_len; i++) {
-				iowrite8(buf[i], ((u8 __iomem *)amd_spi->io_remap_addr +
-					 AMD_SPI_FIFO_BASE + i));
-			}
+			for (i = 0; i < xfer->len; i++)
+				amd_spi_writereg8(amd_spi, fifo_pos + i, buf[i]);
 
-			amd_spi_set_tx_count(amd_spi, tx_len);
-			amd_spi_clear_fifo_ptr(amd_spi);
-			/* Execute command */
-			amd_spi_execute_opcode(amd_spi);
-		}
-		if (m_cmd & AMD_SPI_XFER_RX) {
-			/*
-			 * Store no. of bytes to be received from
-			 * FIFO
-			 */
-			rx_len = xfer->len;
-			buf = (u8 *)xfer->rx_buf;
-			amd_spi_set_rx_count(amd_spi, rx_len);
-			amd_spi_clear_fifo_ptr(amd_spi);
-			/* Execute command */
-			amd_spi_execute_opcode(amd_spi);
-			amd_spi_busy_wait(amd_spi);
-			/* Read data from FIFO to receive buffer  */
-			for (i = 0; i < rx_len; i++)
-				buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
+			fifo_pos += xfer->len;
 		}
+
+		/* Store no. of bytes to be received from FIFO */
+		if (xfer->rx_buf)
+			rx_len += xfer->len;
+	}
+
+	if (!buf) {
+		message->status = -EINVAL;
+		goto fin_msg;
+	}
+
+	amd_spi_set_opcode(amd_spi, cmd_opcode);
+	amd_spi_set_tx_count(amd_spi, tx_len);
+	amd_spi_set_rx_count(amd_spi, rx_len);
+
+	/* Execute command */
+	message->status = amd_spi_execute_opcode(amd_spi);
+	if (message->status)
+		goto fin_msg;
+
+	if (rx_len) {
+		message->status = amd_spi_busy_wait(amd_spi);
+		if (message->status)
+			goto fin_msg;
+
+		list_for_each_entry(xfer, &message->transfers, transfer_list)
+			if (xfer->rx_buf) {
+				buf = (u8 *)xfer->rx_buf;
+				/* Read data from FIFO to receive buffer */
+				for (i = 0; i < xfer->len; i++)
+					buf[i] = amd_spi_readreg8(amd_spi, fifo_pos + i);
+				fifo_pos += xfer->len;
+			}
 	}
 
 	/* Update statistics */
 	message->actual_length = tx_len + rx_len + 1;
-	/* complete the transaction */
-	message->status = 0;
 
+fin_msg:
 	switch (amd_spi->version) {
 	case AMD_SPI_V1:
 		break;
@@ -260,7 +263,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 	spi_finalize_current_message(master);
 
-	return 0;
+	return message->status;
 }
 
 static int amd_spi_master_transfer(struct spi_master *master,
@@ -275,9 +278,7 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	 * Extract spi_transfers from the spi message and
 	 * program the controller.
 	 */
-	amd_spi_fifo_xfer(amd_spi, master, msg);
-
-	return 0;
+	return amd_spi_fifo_xfer(amd_spi, master, msg);
 }
 
 static size_t amd_spi_max_transfer_size(struct spi_device *spi)
-- 
2.37.2

