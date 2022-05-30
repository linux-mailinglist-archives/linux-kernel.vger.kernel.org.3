Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA51B5388CE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 00:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbiE3WO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 18:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbiE3WOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 18:14:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E85D5F7;
        Mon, 30 May 2022 15:14:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gi33so23257251ejc.3;
        Mon, 30 May 2022 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqH6rhczeU9CRPUMU/oQIorPmrvJQ/oMws75u/HxSrc=;
        b=IId3ZIAxMBMadhEScVd/AQFPCXLZDBeUM+GtZFmU7Wd2X9gCwEZaYwcTKxov58uguN
         1W+IGMG2H40Zhutrp0E/7CNTxZclGytp3CZ6kAmRWB+D/YK3nymIM7hFfwZMfbmAH3fp
         HRkg1QIXNecZmCiDp5XSpxN4tOOLUfvyuK/qtskaFZ10B66rkK9cMt35E/0RVCOckuSw
         Fuc+CCiMTDXhaxJconbSgBpWfrPtZgDPbFWbGWqytbVM0L0O1r5MAwmp4HsZuzppAQfQ
         1Aas1aEU1OmxJ7FEE6nTFDwnl8Guga6kpGiB5NGOUjOcmZy3v3FAxx3ujxQmtcO9jNpU
         lw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqH6rhczeU9CRPUMU/oQIorPmrvJQ/oMws75u/HxSrc=;
        b=KbcMJTFX5mwIgPHLsnFF7R926lW7XoTacSiL4kpbe7hGWqupWpR2lnou6T28eMX9tQ
         bgCQVISnzk/gTgCxclkme1g9g/oclAs+Jpzffq5S60oNAUXiHtV0tutGBY+lx+cizN9F
         yxYky4GarG8Z7oXerSlG/+uAPXrmOSOd+dWDaW7ZLiJLR4llgnSEiJB/qgru9WqCVGeZ
         tHU/IhFa3Z5cn4ZMu9pQsGXFDjuj89mS439IB+FE8VyQ/7y1eztaNR/l4rUY4FwkPFzn
         xpmXnwwOdq4gjYrLjfBKJHEc9NvLp6exVPP3Pvoc3l6dhQPq3W2jr0QIylFDM7bURAo7
         EgmA==
X-Gm-Message-State: AOAM533Hk7Oq6nAhFLcV3fw4ojGE/DRA+ngL4Kb6A6RDq8MRzm/Q/a/N
        N4x6hvq+FvidhVKf9kFi26w=
X-Google-Smtp-Source: ABdhPJx+CCfuDhSq1tqD4EeO8KuZbGWKIpcWPyPCvLQ/eki5bbahpAUkhIWuFgP05+0WMqJzPXaKSw==
X-Received: by 2002:a17:907:160c:b0:6fe:c56f:751 with SMTP id hb12-20020a170907160c00b006fec56f0751mr39775071ejc.746.1653948884612;
        Mon, 30 May 2022 15:14:44 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id a92-20020a509ee5000000b0042dbc55f6e4sm4485850edf.7.2022.05.30.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 15:14:44 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH 3/4] serial: max310x: make accessing revision id interface-agnostic
Date:   Tue, 31 May 2022 01:14:28 +0300
Message-Id: <20220530221429.1248083-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530221429.1248083-1-demonsingur@gmail.com>
References: <20220530221429.1248083-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

SPI can only use 5 address bits, since one bit is reserved for
specifying R/W and 2 bits are used to specify the UART port.
To access registers that have addresses past 0x1F, an extended
register space can be enabled by writing to the GlobalCommand
register (address 0x1F).

I2C uses 8 address bits. The R/W bit is placed in the slave
address, and so is the UART port. Because of this, registers
that have addresses higher than 0x1F can be accessed normally.

To access the RevID register, on SPI, 0xCE must be written to
the 0x1F address to enable the extended register space, after
which the RevID register is accessible at address 0x5. 0xCD
must be written to the 0x1F address to disable the extended
register space.

On I2C, the RevID register is accessible at address 0x25.

Create an interface config struct, and add a method for
toggling the extended register space and a member for the RevId
register address. Implement these for SPI.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/tty/serial/max310x.c | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f4c0bb873be3..0cbe7cb1ad26 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -72,7 +72,7 @@
 #define MAX310X_GLOBALCMD_REG		MAX310X_REG_1F /* Global Command (WO) */
 
 /* Extended registers */
-#define MAX310X_REVID_EXTREG		MAX310X_REG_05 /* Revision ID */
+#define MAX310X_SPI_REVID_EXTREG	MAX310X_REG_05 /* Revision ID */
 
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
@@ -245,6 +245,12 @@
 #define MAX14830_BRGCFG_CLKDIS_BIT	(1 << 6) /* Clock Disable */
 #define MAX14830_REV_ID			(0xb0)
 
+struct max310x_if_cfg {
+	int (*set_ext_reg_en)(struct device *dev, bool enable);
+
+	unsigned int rev_id_reg;
+};
+
 struct max310x_devtype {
 	char	name[9];
 	int	nr;
@@ -267,6 +273,7 @@ struct max310x_one {
 
 struct max310x_port {
 	const struct max310x_devtype *devtype;
+	const struct max310x_if_cfg *if_cfg;
 	struct regmap		*regmap;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
@@ -350,19 +357,26 @@ static int max3108_detect(struct device *dev)
 	return 0;
 }
 
+static int max310x_spi_set_ext_reg_en(struct device *dev, bool enable)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+
+	return regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
+			    enable ? MAX310X_EXTREG_ENBL : MAX310X_EXTREG_DSBL);
+}
+
 static int max3109_detect(struct device *dev)
 {
 	struct max310x_port *s = dev_get_drvdata(dev);
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->set_ext_reg_en(dev, true);
 	if (ret)
 		return ret;
 
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->set_ext_reg_en(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX3109_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -387,13 +401,12 @@ static int max14830_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->set_ext_reg_en(dev, true);
 	if (ret)
 		return ret;
 	
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->set_ext_reg_en(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -1233,6 +1246,7 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
+			 const struct max310x_if_cfg *if_cfg,
 			 struct regmap **regmaps, int irq)
 {
 	int i, ret, fmin, fmax, freq;
@@ -1291,6 +1305,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 	s->regmap = regmaps[0];
 	s->devtype = devtype;
+	s->if_cfg = if_cfg;
 	dev_set_drvdata(dev, s);
 
 	/* Check device to ensure we are talking to what we expect */
@@ -1440,6 +1455,11 @@ static struct regmap_config regcfg = {
 	.precious_reg = max310x_reg_precious,
 };
 
+static const struct max310x_if_cfg __maybe_unused max310x_spi_if_cfg = {
+	.set_ext_reg_en = max310x_spi_set_ext_reg_en,
+	.rev_id_reg = MAX310X_SPI_REVID_EXTREG,
+};
+
 #ifdef CONFIG_SPI_MASTER
 static int max310x_spi_probe(struct spi_device *spi)
 {
@@ -1467,7 +1487,8 @@ static int max310x_spi_probe(struct spi_device *spi)
 		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
 	}
 
-	return max310x_probe(&spi->dev, devtype, regmaps, spi->irq);
+	return max310x_probe(&spi->dev, devtype, &max310x_spi_if_cfg, regmaps,
+			     spi->irq);
 }
 
 static void max310x_spi_remove(struct spi_device *spi)
-- 
2.36.1

