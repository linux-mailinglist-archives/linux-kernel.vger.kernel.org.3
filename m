Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DEC53DC56
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbiFEOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbiFEOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:47:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AC36155;
        Sun,  5 Jun 2022 07:47:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so24467792ejj.10;
        Sun, 05 Jun 2022 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rG/BDvC9vYMVBbRz+OHe3th7pTYOw2w+50FOj4opSHg=;
        b=DZS2hojVMoEYb2nBgamOuV2yrqxLBJHZNhuFRJmHSmhNqJ1I/BPncfo89uW2dok8Nj
         XS4up1b5jlWBrr6drAqUatHxHL2ff+Y2UTWMdcbyh60YHEIE8rrvmvNr1H70h94mMlOv
         FCkniR2mhzINqyxwP0uUdXDVFzC2ddKCeV6uEjI0dwxzv3bj7Ek5qByFuRXe1VhImXad
         MaJiOP2jFdx6pVoHBm2ggpi4eLUBnNsA3D7Qdw5sUVPYzh4jKTtR5C3rILKykibSks8l
         YYb1XbYVf4ZlJ05DkupTbdzEPpU9jZGCS/SR+MaNBXBWTZZhT2rk3xSyFYTWkjCTz7O+
         1wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rG/BDvC9vYMVBbRz+OHe3th7pTYOw2w+50FOj4opSHg=;
        b=YJt1rCIYUG3GJokwKWJDSf1HrM1Ef/5Q8pYoMf1r9YjCwB9Q1SOwNAlLP1ASIRXRCo
         SEx5NfqMqVnXKhQLO6f7EYr+tCr+uxwXHlwT4tUETQ2PymCyUENBVuQg+sNpqPZZsCgb
         nTi7XRIfiIOWt6xcs1Hz9HhUmTx1nmfJB/BF87J3N29EJxg1zWzbG4sc7RQIyyhh8a70
         B+a2ImeumJ5mMV9KgX/HOVd1LKQwCBCr4grVaYUEhCV1sMsspTXF101Q6+G0wD/r7VFk
         tX288tjZSVWXhvQ0qwDkbc+KvDUUWBlEO9YPANNM8G2OXE5DpC4C3jyhVW6yAJYhwaSd
         8fpA==
X-Gm-Message-State: AOAM5312NgFxIHN9iEx4ed5LoOf8vHMQbq/AiepwSrQc5gmx0jVubUA8
        e7H+e/78aBjO/vmaX+WIVa+Culzy46I=
X-Google-Smtp-Source: ABdhPJxTQLmoOY81FGxS3UVcYf+9GEZ61sAea6qAFIbi7k8evJNtp97gLHf6wPpIZrO5XduMv4i/oQ==
X-Received: by 2002:a17:907:6d91:b0:6fe:269a:1500 with SMTP id sb17-20020a1709076d9100b006fe269a1500mr17632168ejc.482.1654440450012;
        Sun, 05 Jun 2022 07:47:30 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b0042dd4ccccf5sm6854254edv.82.2022.06.05.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:47:29 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 3/4] serial: max310x: make accessing revision id interface-agnostic
Date:   Sun,  5 Jun 2022 17:46:58 +0300
Message-Id: <20220605144659.4169853-4-demonsingur@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220605144659.4169853-1-demonsingur@gmail.com>
References: <20220605144659.4169853-1-demonsingur@gmail.com>
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
 drivers/tty/serial/max310x.c | 40 +++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 6fd133c177a3..ef6b91242524 100644
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
+	int (*extended_reg_enable)(struct device *dev, bool enable);
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
@@ -356,13 +363,12 @@ static int max3109_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->extended_reg_enable(dev, true);
 	if (ret)
 		return ret;
 
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->extended_reg_enable(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX3109_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -387,13 +393,12 @@ static int max14830_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->extended_reg_enable(dev, true);
 	if (ret)
 		return ret;
 	
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->extended_reg_enable(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -1233,6 +1238,7 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
+			 const struct max310x_if_cfg *if_cfg,
 			 struct regmap *regmaps[], int irq)
 {
 	int i, ret, fmin, fmax, freq;
@@ -1291,6 +1297,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 	s->regmap = regmaps[0];
 	s->devtype = devtype;
+	s->if_cfg = if_cfg;
 	dev_set_drvdata(dev, s);
 
 	/* Check device to ensure we are talking to what we expect */
@@ -1441,6 +1448,19 @@ static struct regmap_config regcfg = {
 };
 
 #ifdef CONFIG_SPI_MASTER
+static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+
+	return regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
+			    enable ? MAX310X_EXTREG_ENBL : MAX310X_EXTREG_DSBL);
+}
+
+static const struct max310x_if_cfg __maybe_unused max310x_spi_if_cfg = {
+	.extended_reg_enable = max310x_spi_extended_reg_enable,
+	.rev_id_reg = MAX310X_SPI_REVID_EXTREG,
+};
+
 static int max310x_spi_probe(struct spi_device *spi)
 {
 	const struct max310x_devtype *devtype;
@@ -1467,7 +1487,7 @@ static int max310x_spi_probe(struct spi_device *spi)
 		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
 	}
 
-	return max310x_probe(&spi->dev, devtype, regmaps, spi->irq);
+	return max310x_probe(&spi->dev, devtype, &max310x_spi_if_cfg, regmaps, spi->irq);
 }
 
 static void max310x_spi_remove(struct spi_device *spi)
-- 
2.36.1

