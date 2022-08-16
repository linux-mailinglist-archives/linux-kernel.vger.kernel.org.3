Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F30595FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiHPQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiHPQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:14:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3A5004F;
        Tue, 16 Aug 2022 09:14:24 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GBEDvW003120;
        Tue, 16 Aug 2022 18:14:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=u6JuADSr1XO0NXsUCaPfNxpteZihgpsUAllwoBr+U4o=;
 b=hYK76awz/a/g6B1fafw25SzP+0whJmFoviQIOiWxVS4eF76KFJFBTxSekbkJxN8VScBV
 zeIP9mQ5ojE6jXpyP6BDTzijsYCKbbbqcXhTc7B43aOQkguC9XahxACs6hOp4HlNPRSF
 5ChsmvKmmv/0Q8FMPJr6/MBq8MZmrJEewA2tiYcthMQahVNv9pR+gonif6VEJ9o+zwy+
 3YZdjtGw45QmvKETz3v+s4AJFwuh1hhgQ9rWdQw2+jwXMZEbnn8iqa2GJKYpRRs2mnYd
 k52K4+SamSG8q1NrtRqGl+RsEBjgV1iuwntxlwEAKhbX+Rb3b+3IfMYzXPmGr2/UByss Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hx2uhfpq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 18:14:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94F8D100038;
        Tue, 16 Aug 2022 18:14:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 908B623BE1B;
        Tue, 16 Aug 2022 18:14:03 +0200 (CEST)
Received: from localhost (10.75.127.117) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 16 Aug
 2022 18:14:03 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH v3 2/2] spi: stm32_qspi: Add transfer_one_message() spi callback
Date:   Tue, 16 Aug 2022 18:13:44 +0200
Message-ID: <20220816161344.2599908-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816161344.2599908-1-patrice.chotard@foss.st.com>
References: <20220816161344.2599908-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add transfer_one_message() spi callback in order to use the QSPI interface
as a communication channel using up to 8 qspi lines (QSPI configured
in dual flash mode).
To enable this mode, both spi-rx-bus-width and spi-tx-bus-width must be
set to 8 and cs-qpios must be populated.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

v3: _ add cleanup() callback.
    _ rework the trigger to enable dual flash mode QSPI block feature:
       _ spi-tx-bus-width and spi-rx-bus-width must be set to 8.
       _ cs-gpios property must be populated.

v2: _ use parallel-memories property
    _ set auto_runtime_pm to true
    _ remove pm_runtime_*() usage in transfer_one_message() callback

 drivers/spi/spi-stm32-qspi.c | 125 ++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index f3fe92300639..eee843ae24f0 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -8,6 +8,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
@@ -15,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
@@ -355,10 +357,10 @@ static int stm32_qspi_get_mode(u8 buswidth)
 	return buswidth;
 }
 
-static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
+static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
 {
-	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
-	struct stm32_qspi_flash *flash = &qspi->flash[mem->spi->chip_select];
+	struct stm32_qspi *qspi = spi_controller_get_devdata(spi->master);
+	struct stm32_qspi_flash *flash = &qspi->flash[spi->chip_select];
 	u32 ccr, cr;
 	int timeout, err = 0, err_poll_status = 0;
 
@@ -465,7 +467,7 @@ static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *
 	qspi->fmode = CCR_FMODE_APM;
 	qspi->status_timeout = timeout_ms;
 
-	ret = stm32_qspi_send(mem, op);
+	ret = stm32_qspi_send(mem->spi, op);
 	mutex_unlock(&qspi->lock);
 
 	pm_runtime_mark_last_busy(qspi->dev);
@@ -489,7 +491,7 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	else
 		qspi->fmode = CCR_FMODE_INDW;
 
-	ret = stm32_qspi_send(mem, op);
+	ret = stm32_qspi_send(mem->spi, op);
 	mutex_unlock(&qspi->lock);
 
 	pm_runtime_mark_last_busy(qspi->dev);
@@ -545,7 +547,7 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	else
 		qspi->fmode = CCR_FMODE_INDR;
 
-	ret = stm32_qspi_send(desc->mem, &op);
+	ret = stm32_qspi_send(desc->mem->spi, &op);
 	mutex_unlock(&qspi->lock);
 
 	pm_runtime_mark_last_busy(qspi->dev);
@@ -554,12 +556,92 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	return ret ?: len;
 }
 
+static void stm32_qspi_cleanup(struct spi_device *spi)
+{
+	gpiod_put(spi->cs_gpiod);
+}
+
+static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
+					   struct spi_message *msg)
+{
+	struct stm32_qspi *qspi = spi_controller_get_devdata(ctrl);
+	struct spi_transfer *transfer;
+	struct spi_device *spi = msg->spi;
+	struct spi_mem_op op;
+	int ret;
+
+	if (!spi->cs_gpiod)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&qspi->lock);
+
+	gpiod_set_value_cansleep(spi->cs_gpiod, true);
+
+	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
+		u8 dummy_bytes = 0;
+
+		memset(&op, 0, sizeof(op));
+
+		dev_dbg(qspi->dev, "tx_buf:%p tx_nbits:%d rx_buf:%p rx_nbits:%d len:%d dummy_data:%d\n",
+			transfer->tx_buf, transfer->tx_nbits,
+			transfer->rx_buf, transfer->rx_nbits,
+			transfer->len, transfer->dummy_data);
+
+		/*
+		 * QSPI hardware supports dummy bytes transfer.
+		 * If current transfer is dummy byte, merge it with the next
+		 * transfer in order to take into account QSPI block constraint
+		 */
+		if (transfer->dummy_data) {
+			op.dummy.buswidth = transfer->tx_nbits;
+			op.dummy.nbytes = transfer->len;
+			dummy_bytes = transfer->len;
+
+			/* if happens, means that message is not correctly built */
+			if (list_is_last(&transfer->transfer_list, &msg->transfers))
+				goto end_of_transfer;
+
+			transfer = list_next_entry(transfer, transfer_list);
+		}
+
+		op.data.nbytes = transfer->len;
+
+		if (transfer->rx_buf) {
+			qspi->fmode = CCR_FMODE_INDR;
+			op.data.buswidth = transfer->rx_nbits;
+			op.data.dir = SPI_MEM_DATA_IN;
+			op.data.buf.in = transfer->rx_buf;
+		} else {
+			qspi->fmode = CCR_FMODE_INDW;
+			op.data.buswidth = transfer->tx_nbits;
+			op.data.dir = SPI_MEM_DATA_OUT;
+			op.data.buf.out = transfer->tx_buf;
+		}
+
+		ret = stm32_qspi_send(spi, &op);
+		if (ret)
+			goto end_of_transfer;
+
+		msg->actual_length += transfer->len + dummy_bytes;
+	}
+
+end_of_transfer:
+	gpiod_set_value_cansleep(spi->cs_gpiod, false);
+
+	mutex_unlock(&qspi->lock);
+
+	msg->status = ret;
+	spi_finalize_current_message(ctrl);
+
+	return ret;
+}
+
 static int stm32_qspi_setup(struct spi_device *spi)
 {
 	struct spi_controller *ctrl = spi->master;
 	struct stm32_qspi *qspi = spi_controller_get_devdata(ctrl);
 	struct stm32_qspi_flash *flash;
-	u32 presc;
+	u32 presc, mode;
 	int ret;
 
 	if (ctrl->busy)
@@ -568,6 +650,16 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
+	mode = spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL);
+	if ((mode == SPI_TX_OCTAL || mode == SPI_RX_OCTAL) ||
+	    ((mode == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
+	    of_gpio_named_count(qspi->dev->of_node, "cs-gpios") == -ENOENT)) {
+		dev_err(qspi->dev, "spi-rx-bus-width\\/spi-tx-bus-width\\/cs-gpios\n");
+		dev_err(qspi->dev, "configuration not supported\n");
+
+		return -EINVAL;
+	}
+
 	ret = pm_runtime_resume_and_get(qspi->dev);
 	if (ret < 0)
 		return ret;
@@ -580,6 +672,17 @@ static int stm32_qspi_setup(struct spi_device *spi)
 
 	mutex_lock(&qspi->lock);
 	qspi->cr_reg = CR_APMS | 3 << CR_FTHRES_SHIFT | CR_SSHIFT | CR_EN;
+
+	/*
+	 * Dual flash mode is only enable in case SPI_TX_OCTAL and SPI_TX_OCTAL
+	 * are both set in spi->mode and "cs-gpios" properties is found in DT
+	 */
+	if (((spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL)) == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
+	    of_gpio_named_count(qspi->dev->of_node, "cs-gpios")) {
+		qspi->cr_reg |= CR_DFM;
+		dev_dbg(qspi->dev, "Dual flash mode enable");
+	}
+
 	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 
 	/* set dcr fsize to max address */
@@ -741,11 +844,15 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 	mutex_init(&qspi->lock);
 
-	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
-		| SPI_TX_DUAL | SPI_TX_QUAD;
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL
+		| SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_OCTAL;
 	ctrl->setup = stm32_qspi_setup;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &stm32_qspi_mem_ops;
+	ctrl->use_gpio_descriptors = true;
+	ctrl->transfer_one_message = stm32_qspi_transfer_one_message;
+	ctrl->cleanup = stm32_qspi_cleanup;
+	ctrl->auto_runtime_pm = true;
 	ctrl->num_chipselect = STM32_QSPI_MAX_NORCHIP;
 	ctrl->dev.of_node = dev->of_node;
 
-- 
2.25.1

