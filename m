Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8729F49F198
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiA1C7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiA1C7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:59:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836EC061714;
        Thu, 27 Jan 2022 18:59:08 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so5155821pja.2;
        Thu, 27 Jan 2022 18:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=qRdGzZtXjRnY1yM88cLPMFH0KsI0BjxCeugP2VNJtoM=;
        b=l36C3KuJOUvbq4lAZ9Y81VUIFLLCpS/QB6u4orDD3NdtuhelXHn8KtxF8W45G1Qcj/
         CTq4HO5zKYEoT6PrybpBouGr610N4Cj7Je3/mD1y2eaWI57yKJicRt5pM2vJ9Ge2HarI
         +eBuwG5aDf9+XS72497ghc03noN8d1s6vgGv1+sQmzFeAZy2JanytFf+BUqUXEPpCrnF
         cYnLoEFtmIp4Dqh+mkntDwdJMfV4wOdVJrR4hrbOMU/7SfndbnKPdexsBHIabl9LCUkd
         6Qbg8e7uysg7Cavhj/TlhqssuIBuJXFMT04yM7+d1lcZ2jokY9TAXiHlIH7hRAeRzMFl
         KCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qRdGzZtXjRnY1yM88cLPMFH0KsI0BjxCeugP2VNJtoM=;
        b=Y0n+x9OwZMzUrqnXJmkOBnznJGZpiRWKkwWqdfzGYfGwq5EixDjUKwdDznYeIKNM3X
         VdDaemlJdD+vZNCHoakv1AZ32TUEkgw1BHVbnYRrghQZufGzTDGAH8voMEG+uFw24uaS
         JlmeRP7RJcCcyl+IgI/3+6eMfqbESk6486PgArGlVGZEWtFgaQq2OMZCpnPEp04msb27
         qWZvHXbm+Z8D7MPbhezB7Pbe9nCbUX6vaC+GxJ7iKiSYZZUoWBOWDQganBbu6joG9uRT
         IQs3B72zo67Oix2g0JZyQH7I3hgpVgahbNQg5fXQZG6+3agpA5m8RwPdy/QIqW6ipk7t
         EL9g==
X-Gm-Message-State: AOAM533dMk8WybL21PX5N2X09NVmbfrgPinYd35hoPD8NIMyMlcwAHvP
        xf9s4vyWbBQprrSgYvYl1Mc=
X-Google-Smtp-Source: ABdhPJx1wOF7wIIpqUpw207jYX5aLzvcwqKWiEdjp+h1TQOR+UOwq4NkR4uGbj8SRk6OxTH5GzR3jQ==
X-Received: by 2002:a17:902:f782:: with SMTP id q2mr6263606pln.81.1643338747816;
        Thu, 27 Jan 2022 18:59:07 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id a1sm20314979pgg.18.2022.01.27.18.59.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 18:59:07 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH -next] spi: Modify irq request position and modify parameters
Date:   Fri, 28 Jan 2022 10:59:20 +0800
Message-Id: <1643338760-17577-1-git-send-email-lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Change irq request position to the back.
 - Add temporary varilable and setting (as suggested by Mr. Andy Shevchenko)
---
 drivers/spi/spi-sunplus-sp7021.c | 63 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index d45b5dd..a78146f 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -110,7 +110,8 @@ static irqreturn_t sp7021_spi_slave_irq(int irq, void *dev)
 	unsigned int data_status;
 
 	data_status = readl(pspim->s_base + SP7021_DATA_RDY_REG);
-	writel(data_status | SP7021_SLAVE_CLR_INT, pspim->s_base + SP7021_DATA_RDY_REG);
+	data_status |= SP7021_SLAVE_CLR_INT;
+	writel(data_status , pspim->s_base + SP7021_DATA_RDY_REG);
 	complete(&pspim->slave_isr);
 	return IRQ_HANDLED;
 }
@@ -127,14 +128,16 @@ static int sp7021_spi_slave_abort(struct spi_controller *ctlr)
 static int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
+	u32 value;
 
 	reinit_completion(&pspim->slave_isr);
-	writel(SP7021_SLAVE_DMA_EN | SP7021_SLAVE_DMA_RW | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
-	       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
+	value = SP7021_SLAVE_DMA_EN | SP7021_SLAVE_DMA_RW | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3);
+	writel(value, pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
 	writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
 	writel(xfer->tx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
-	writel(readl(pspim->s_base + SP7021_DATA_RDY_REG) | SP7021_SLAVE_DATA_RDY,
-	       pspim->s_base + SP7021_DATA_RDY_REG);
+	value = readl(pspim->s_base + SP7021_DATA_RDY_REG);
+	value |= SP7021_SLAVE_DATA_RDY;
+	writel(value, pspim->s_base + SP7021_DATA_RDY_REG);
 	if (wait_for_completion_interruptible(&pspim->isr_done)) {
 		dev_err(&spi->dev, "%s() wait_for_completion err\n", __func__);
 		return -EINTR;
@@ -145,11 +148,11 @@ static int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer
 static int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
-	int ret = 0;
+	u32 value;
 
 	reinit_completion(&pspim->isr_done);
-	writel(SP7021_SLAVE_DMA_EN | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
-	       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
+	value = SP7021_SLAVE_DMA_EN | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3);
+	writel(value, pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
 	writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
 	writel(xfer->rx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
 	if (wait_for_completion_interruptible(&pspim->isr_done)) {
@@ -157,7 +160,7 @@ static int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer
 		return -EINTR;
 	}
 	writel(SP7021_SLAVE_SW_RST, pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
-	return ret;
+	return 0;
 }
 
 static void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
@@ -188,7 +191,6 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 	unsigned int tx_cnt, total_len;
 	unsigned int tx_len, rx_cnt;
 	unsigned int fd_status;
-	unsigned long flags;
 	bool isrdone = false;
 	u32 value;
 
@@ -203,7 +205,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 	if (tx_len == 0 && total_len == 0)
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&pspim->lock, flags);
+	spin_lock_irq(&pspim->lock);
 
 	rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
 	if (fd_status & SP7021_RX_FULL_FLAG)
@@ -243,7 +245,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
 
 	if (isrdone)
 		complete(&pspim->isr_done);
-	spin_unlock_irqrestore(&pspim->lock, flags);
+	spin_unlock_irq(&pspim->lock);
 	return IRQ_HANDLED;
 }
 
@@ -296,11 +298,10 @@ static void sp7021_spi_setup_clk(struct spi_controller *ctlr, struct spi_transfe
 	u32 clk_rate, clk_sel, div;
 
 	clk_rate = clk_get_rate(pspim->spi_clk);
-	div = clk_rate / xfer->speed_hz;
-	if (div < 2)
-		div = 2;
+	div = max(2U, clk_rate / xfer->speed_hz);
+
 	clk_sel = (div / 2) - 1;
-	pspim->xfer_conf &= SP7021_CLK_MASK;
+	pspim->xfer_conf &= ~SP7021_CLK_MASK;
 	pspim->xfer_conf |= FIELD_PREP(SP7021_CLK_MASK, clk_sel);
 	writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
 }
@@ -313,7 +314,6 @@ static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct sp
 	unsigned int xfer_cnt, xfer_len, last_len;
 	unsigned int i, len_temp;
 	u32 reg_temp;
-	int ret;
 
 	xfer_cnt = xfer->len / SP7021_SPI_DATA_SIZE;
 	last_len = xfer->len % SP7021_SPI_DATA_SIZE;
@@ -365,9 +365,8 @@ static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct sp
 			writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
 
 		mutex_unlock(&pspim->buf_lock);
-		ret = 0;
 	}
-	return ret;
+	return 0;
 }
 
 static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
@@ -375,12 +374,12 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 {
 	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
 	struct device *dev = pspim->dev;
-	int mode, ret = 0;
+	int mode, ret;
 
 	mode = SP7021_SPI_IDLE;
 	if (xfer->tx_buf && xfer->rx_buf) {
 		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
-		ret = -EINVAL;
+		return -EINVAL;
 	} else if (xfer->tx_buf) {
 		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
 					      xfer->len, DMA_TO_DEVICE);
@@ -444,7 +443,7 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 		ctlr = devm_spi_alloc_master(dev, sizeof(*pspim));
 	if (!ctlr)
 		return -ENOMEM;
-	device_set_node(&ctlr->dev, pdev->dev.fwnode);
+	device_set_node(&ctlr->dev, dev_fwnode(dev));
 	ctlr->bus_num = pdev->id;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	ctlr->auto_runtime_pm = true;
@@ -487,16 +486,6 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	if (pspim->s_irq < 0)
 		return pspim->s_irq;
 
-	ret = devm_request_irq(dev, pspim->m_irq, sp7021_spi_master_irq,
-			       IRQF_TRIGGER_RISING, pdev->name, pspim);
-	if (ret)
-		return ret;
-
-	ret = devm_request_irq(dev, pspim->s_irq, sp7021_spi_slave_irq,
-			       IRQF_TRIGGER_RISING, pdev->name, pspim);
-	if (ret)
-		return ret;
-
 	pspim->spi_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pspim->spi_clk))
 		return dev_err_probe(dev, PTR_ERR(pspim->spi_clk), "clk get fail\n");
@@ -521,6 +510,16 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_request_irq(dev, pspim->m_irq, sp7021_spi_master_irq,
+			       IRQF_TRIGGER_RISING, pdev->name, pspim);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(dev, pspim->s_irq, sp7021_spi_slave_irq,
+			       IRQF_TRIGGER_RISING, pdev->name, pspim);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(dev);
 	ret = spi_register_controller(ctlr);
 	if (ret) {
-- 
2.7.4

