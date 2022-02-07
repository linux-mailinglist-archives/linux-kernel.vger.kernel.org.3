Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75C4AB343
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346623AbiBGB5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiBGB5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:57:08 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56367C061A73;
        Sun,  6 Feb 2022 17:57:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id e6so10399020pfc.7;
        Sun, 06 Feb 2022 17:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=GNGrFE+CxWvfLlmYAkO/3A6ygyoXlhK3rO8p+T80Py8=;
        b=mII/243PX5+pZfhX15NRapL8sAZv+Tm6bHA4caBTOI70m/iYQJ09adEXR17fDbwo8S
         a7Gb434mpfYZny3+/e0diGaBUtOwoAuxB1Wxyss/rVj3l9Y73m/nyU3xeeQrYCiTiySd
         eidDLXyhFxkcTe3rNInYnlmD572IBOu3vm5JiTp6yNob9E+mJE4c9GLh0HMiTDvfriPu
         JXttwwEnwPkI1Knrk4z6ERFBIF1yJUuo4JKxaKZtZZFt946RvLzWABz8Q8m5bMA5L58y
         aLVYMUMbtGYc+QuGc4JempBO9HkjOw9c4XKPF/dnwHizln+Vc9Deiz5VOgBr0xdXodrU
         3SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GNGrFE+CxWvfLlmYAkO/3A6ygyoXlhK3rO8p+T80Py8=;
        b=WTSrHmZE9FYBkZ6Lv/8Uw3xrK1mjn1UvN6umoYMYS2X3nJTpF08KeIsP1KLSKKYQtw
         y6H2AEEkCGnWi7Y18W7F+gmcd3HigsGYANnu6ubXoWm7p/SnqPAuhOzBKEUsNK7X6eQy
         awuLfFAwJumLi6d8mCgB+6QbJ/l6WAA5X7ufFg9ppRLnmOwNSwI3usYLmO7ppYrqQpgY
         HQVbmPjQbD7COD8PbAsVCjOa0dEyGWtCeE58ekipbU3pFPtC2pMa1i5Ge8KatmryQ+6S
         +RBcDtONW28QNMqARXqXpwbpLFcV5EKwmG0RiIgHmNRI4+dTYw9C+en09LvsvChIfXDI
         Ij4A==
X-Gm-Message-State: AOAM532xXbwBo7Fg1jWd1gmxYc2avx+dWTGz1LVYGAppWZgwBYDnFkPn
        zwzNMfckK6kHm6VcILp8W6chKGr5FoN9ZA==
X-Google-Smtp-Source: ABdhPJxPhHXnI/T6eXPCREJwsZZbPRJvBmbACmIsWHpfD9PAU9e7YxhVWUXCzsIAd/e22tOCyG49VA==
X-Received: by 2002:a05:6a00:1682:: with SMTP id k2mr13660724pfc.69.1644199026747;
        Sun, 06 Feb 2022 17:57:06 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id y41sm9817659pfa.213.2022.02.06.17.57.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Feb 2022 17:57:06 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH next] spi: Modify irq request position and modify parameters
Date:   Mon,  7 Feb 2022 09:57:22 +0800
Message-Id: <a94e3b123773fe303221d2bd2e4ce36ffa905a1c.1644198957.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change irq request position to the back.
- Add temporary varilable and setting (as suggested by Mr. Andy Shevchenko)

Fixes: f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 63 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index e5bdeb3..ba5ed9f 100644
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
@@ -366,9 +366,8 @@ static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct sp
 			writel(pspim->xfer_conf, pspim->m_base + SP7021_SPI_CONFIG_REG);
 
 		mutex_unlock(&pspim->buf_lock);
-		ret = 0;
 	}
-	return ret;
+	return 0;
 }
 
 static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
@@ -376,12 +375,12 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
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
@@ -445,7 +444,7 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 		ctlr = devm_spi_alloc_master(dev, sizeof(*pspim));
 	if (!ctlr)
 		return -ENOMEM;
-	device_set_node(&ctlr->dev, pdev->dev.fwnode);
+	device_set_node(&ctlr->dev, dev_fwnode(dev));
 	ctlr->bus_num = pdev->id;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	ctlr->auto_runtime_pm = true;
@@ -488,16 +487,6 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
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
@@ -522,6 +511,16 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
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

