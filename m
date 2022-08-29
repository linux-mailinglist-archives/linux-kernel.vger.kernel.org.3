Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D275A4E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiH2Njv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiH2Nji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:39:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7264691D04;
        Mon, 29 Aug 2022 06:39:37 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:c9c8:35ca:a27e:68d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 163076601EF9;
        Mon, 29 Aug 2022 14:39:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661780376;
        bh=MKi6iSuiyBrqjQ+i2iO51hvgrkrKFIHF32iimDWmvTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bx7vGc1yg3TkyDEW0G0fd2HkIrZel9NQCGpm6VYa9lhNhKE5+ZnuWTizoKW4j0Sf1
         f2ARunTW+xPlpKJN27H+Vk7U4tsvVjC0+3J4PSWJ1Db65gT/cxDIDxRpeL0CwmVuKD
         2C4aZoEATMDd/LYRwRSC3UQEJ/1t61JFF9WvCNHxLlWvFObicyYyPyKxB9st35VCpQ
         UNoZE4X//QiQQuS3K6WdPIVXEezLmNKug23yaq7WpAeFxamhp8SmfNpSoRoHch3m1a
         SVMrLKz4m2zb55pvURr4hha1Iw4ycY23LYRJZTnYjRo/hz+73WDd8jFLlkESGpkhdd
         DMxuWSZ2nVUvw==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] gpio: pca953x: Swap if statements to save later complexity
Date:   Mon, 29 Aug 2022 14:39:21 +0100
Message-Id: <20220829133923.1114555-4-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829133923.1114555-1-martyn.welch@collabora.com>
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A later patch in the series adds support for a further chip type that
shares some similarity with the PCA953X_TYPE. In order to keep the logic
simple, swap over the if and else portions where checks are made against
PCA953X_TYPE and instead check for PCA957X_TYPE.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 drivers/gpio/gpio-pca953x.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 41e7ff83a735..19a8eb94a629 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -293,13 +293,13 @@ static bool pca953x_readable_register(struct device *dev, unsigned int reg)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 	u32 bank;
 
-	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
-		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
-		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
-	} else {
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
 		bank = PCA957x_BANK_INPUT | PCA957x_BANK_OUTPUT |
 		       PCA957x_BANK_POLARITY | PCA957x_BANK_CONFIG |
 		       PCA957x_BANK_BUSHOLD;
+	} else {
+		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
+		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
 	}
 
 	if (chip->driver_data & PCA_PCAL) {
@@ -316,12 +316,12 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 	u32 bank;
 
-	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
-		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
-			PCA953x_BANK_CONFIG;
-	} else {
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
 		bank = PCA957x_BANK_OUTPUT | PCA957x_BANK_POLARITY |
 			PCA957x_BANK_CONFIG | PCA957x_BANK_BUSHOLD;
+	} else {
+		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
+			PCA953x_BANK_CONFIG;
 	}
 
 	if (chip->driver_data & PCA_PCAL)
@@ -336,10 +336,10 @@ static bool pca953x_volatile_register(struct device *dev, unsigned int reg)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 	u32 bank;
 
-	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE)
-		bank = PCA953x_BANK_INPUT;
-	else
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE)
 		bank = PCA957x_BANK_INPUT;
+	else
+		bank = PCA953x_BANK_INPUT;
 
 	if (chip->driver_data & PCA_PCAL)
 		bank |= PCAL9xxx_BANK_IRQ_STAT;
@@ -1069,13 +1069,12 @@ static int pca953x_probe(struct i2c_client *client,
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
-
-	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
-		chip->regs = &pca953x_regs;
-		ret = device_pca95xx_init(chip, invert);
-	} else {
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
 		chip->regs = &pca957x_regs;
 		ret = device_pca957x_init(chip, invert);
+	} else {
+		chip->regs = &pca953x_regs;
+		ret = device_pca95xx_init(chip, invert);
 	}
 	if (ret)
 		goto err_exit;
-- 
2.35.1

