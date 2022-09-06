Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542B35AE293
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiIFI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiIFI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:28:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7B696E5;
        Tue,  6 Sep 2022 01:28:35 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:414f:4149:b474:40e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BEA8C6601EB2;
        Tue,  6 Sep 2022 09:28:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662452913;
        bh=adeJ5oZysQSQP0TyQ/ZFvxfxSYtSlVn6Tyomi8Mr38w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4kBhQ8en7TM6S4K4Kw3ojieK4D7UsIBOSjggQrLCKV3ozk5M2OfYw8vzgivbnfT9
         sjbM2BSiYY+XaDfOOxoJX58ox6gejC5JaZRQFzowOoTj7nDBrxJ3wQEMPLGZfW+Kcw
         yKYxfUMQnjU8lAU1gDtQ3v/whnn7+7hFfctbGrmsBqFQdD8qEHhxw1m4Ui+9Bdmi5g
         lQXXSCMcU1s0vjHKC4Pz5Av0v77PIooh5mKvMQuayxRb0uC30ks8ESgPyN+uGvq9GR
         cm8ryS4w5MKZiNf3H2/IQnx/yz2nHxgE7GtT1rETByx6DWaPnKNWprtQXpXJYacJlr
         keqvy60M8SPvw==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] gpio: pca953x: Swap if statements to save later complexity
Date:   Tue,  6 Sep 2022 09:28:18 +0100
Message-Id: <20220906082820.4030401-4-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

A later patch in the series adds support for a further chip type that
shares some similarity with the PCA953X_TYPE. In order to keep the logic
simple, swap over the if and else portions where checks are made against
PCA953X_TYPE and instead check for PCA957X_TYPE.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v2:
 - None

 drivers/gpio/gpio-pca953x.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 62367c9d6e99..1e8f038734e0 100644
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
@@ -1070,13 +1070,12 @@ static int pca953x_probe(struct i2c_client *client,
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

