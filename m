Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1042A53DC53
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiFEOre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbiFEOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:47:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7425FD4;
        Sun,  5 Jun 2022 07:47:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg6so4675010ejb.0;
        Sun, 05 Jun 2022 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQkm19AYTjfiIGzMxhbkfzj0qsvPIA6SmaCCAOK1I8Q=;
        b=L9/TEcu2dNHjO+HEM+M28qtl0/N75Yb4avF+SAZPAGo9N+XUYw3rh39m8moLVka3cH
         b15JvMxLLwkcGRs/AokgzOGGWp2AAr8WO5PBjF4yQpvsNn2R5hRSNKTFljSpIuhwnnQc
         E74iDt5wwefdN85heJ4twsaR0XohVRbVvxowk0vdLsNjQ7q048BlqDLY8Ifs3jCuAKkT
         NPwMLtc0losu5CYpkRy5uFokZUvUdKVsuYpdz1kVREJhaQNQbYtiW5MDk/nSk8DTgz5H
         M+mU3CkAHq9cuC8Ocq2XL/SsZ2sDoX0W1oryaHvCDMytcfenZcSCqH1NYxierYABv3nl
         hNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQkm19AYTjfiIGzMxhbkfzj0qsvPIA6SmaCCAOK1I8Q=;
        b=y9HvEvjYiIGyt3VINkzcD5hw7T2pNFL86dFGt79pv8xN15llGRIiRClwFZqMeYYFyG
         /AbG48AADFvUiIX8ndr2tWkgH8Amy9grZKBynYRwdX9sWvjGHob8aCz3Yaf/nqv2UlI9
         wYV3NsOigI2eo3T7ryLU1AX2sFbnTkhrKZ03rcf/swV9fEw1bpL8A2iMq/DG53yz0BbY
         Y5WMtcOlhULm1ZGBGpUc6UNJYHkh5EcOVwOmOSHPmPd52J3FKRm9T0cBwnBRmZ85O5wS
         KYRCgS5DBRDVmDxaTJr7vW1o9s0NIuP9Lj/4ZzfhJ3kw4Tnyfnw/3N7b7OZBvhXx8KMf
         wQ9w==
X-Gm-Message-State: AOAM531MJGmUd9KVBe1L95o/OdPaKZUZTibNSqh1l1u+5lhGrIsRJjZC
        8WfNOCf8MgjoQXptYOL0YoU=
X-Google-Smtp-Source: ABdhPJyrR05tS5mz79Ye1b4UeO4tsC+qcG/6rHtDZpcVmzH2tAIStWZuvv2DgUoGmYSmf4xS0WhmjQ==
X-Received: by 2002:a17:907:968b:b0:70f:30b7:9324 with SMTP id hd11-20020a170907968b00b0070f30b79324mr10540607ejc.19.1654440448486;
        Sun, 05 Jun 2022 07:47:28 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b0042dd4ccccf5sm6854254edv.82.2022.06.05.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:47:28 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 2/4] serial: max310x: use a separate regmap for each port
Date:   Sun,  5 Jun 2022 17:46:57 +0300
Message-Id: <20220605144659.4169853-3-demonsingur@gmail.com>
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

The driver currently does manual register manipulation in
multiple places to talk to a specific UART port.

In order to talk to a specific UART port over SPI, the bits U1
and U0 of the register address can be set, as explained in the
Command byte configuration section of the datasheet.

Make this more elegant by creating regmaps for each UART port
and setting the read_flag_mask and write_flag_mask
accordingly.

All communcations regarding global registers are done on UART
port 0, so replace the global regmap entirely with the port 0
regmap.

Also, remove the 0x1f masks from reg_writeable(), reg_volatile()
and reg_precious() methods, since setting the U1 and U0 bits of
the register address happens inside the regmap core now.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/tty/serial/max310x.c | 68 +++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 46887a4ffea4..6fd133c177a3 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -258,6 +258,7 @@ struct max310x_one {
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+	struct regmap		*regmap;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
@@ -287,26 +288,26 @@ static DECLARE_BITMAP(max310x_lines, MAX310X_UART_NRMAX);
 
 static u8 max310x_port_read(struct uart_port *port, u8 reg)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val = 0;
 
-	regmap_read(s->regmap, port->iobase + reg, &val);
+	regmap_read(one->regmap, reg, &val);
 
 	return val;
 }
 
 static void max310x_port_write(struct uart_port *port, u8 reg, u8 val)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_write(s->regmap, port->iobase + reg, val);
+	regmap_write(one->regmap, reg, val);
 }
 
 static void max310x_port_update(struct uart_port *port, u8 reg, u8 mask, u8 val)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_update_bits(s->regmap, port->iobase + reg, mask, val);
+	regmap_update_bits(one->regmap, reg, mask, val);
 }
 
 static int max3107_detect(struct device *dev)
@@ -445,7 +446,7 @@ static const struct max310x_devtype max14830_devtype = {
 
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -462,7 +463,7 @@ static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
@@ -484,7 +485,7 @@ static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -621,18 +622,16 @@ static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
-	u8 reg = port->iobase + MAX310X_THR_REG;
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_write(s->regmap, reg, txbuf, len);
+	regmap_raw_write(one->regmap, MAX310X_THR_REG, txbuf, len);
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
-	u8 reg = port->iobase + MAX310X_RHR_REG;
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_read(s->regmap, reg, rxbuf, len);
+	regmap_raw_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
@@ -1234,15 +1233,16 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
-			 struct regmap *regmap, int irq)
+			 struct regmap *regmaps[], int irq)
 {
 	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
 	u32 uartclk = 0;
 	bool xtal;
 
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	for (i = 0; i < devtype->nr; i++)
+		if (IS_ERR(regmaps[i]))
+			return PTR_ERR(regmaps[i]);
 
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
@@ -1289,7 +1289,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 	}
 
-	s->regmap = regmap;
+	s->regmap = regmaps[0];
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 
@@ -1299,22 +1299,18 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
-		unsigned int offs = i << 5;
-
 		/* Reset port */
-		regmap_write(s->regmap, MAX310X_MODE2_REG + offs,
+		regmap_write(regmaps[i], MAX310X_MODE2_REG,
 			     MAX310X_MODE2_RST_BIT);
 		/* Clear port reset */
-		regmap_write(s->regmap, MAX310X_MODE2_REG + offs, 0);
+		regmap_write(regmaps[i], MAX310X_MODE2_REG, 0);
 
 		/* Wait for port startup */
 		do {
-			regmap_read(s->regmap,
-				    MAX310X_BRGDIVLSB_REG + offs, &ret);
+			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &ret);
 		} while (ret != 0x01);
 
-		regmap_write(s->regmap, MAX310X_MODE1_REG + offs,
-			     devtype->mode1);
+		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
@@ -1337,11 +1333,13 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		s->p[i].port.fifosize	= MAX310X_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iotype	= UPIO_PORT;
-		s->p[i].port.iobase	= i * 0x20;
+		s->p[i].port.iobase	= i;
 		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.uartclk	= uartclk;
 		s->p[i].port.rs485_config = max310x_rs485_config;
 		s->p[i].port.ops	= &max310x_ops;
+		s->p[i].regmap		= regmaps[i];
+
 		/* Disable all interrupts */
 		max310x_port_write(&s->p[i].port, MAX310X_IRQEN_REG, 0);
 		/* Clear IRQ status register */
@@ -1436,6 +1434,7 @@ static struct regmap_config regcfg = {
 	.val_bits = 8,
 	.write_flag_mask = MAX310X_WRITE_BIT,
 	.cache_type = REGCACHE_RBTREE,
+	.max_register = MAX310X_REG_1F,
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
@@ -1445,7 +1444,8 @@ static struct regmap_config regcfg = {
 static int max310x_spi_probe(struct spi_device *spi)
 {
 	const struct max310x_devtype *devtype;
-	struct regmap *regmap;
+	struct regmap *regmaps[4];
+	unsigned int i;
 	int ret;
 
 	/* Setup SPI bus */
@@ -1460,10 +1460,14 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (!devtype)
 		devtype = (struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
 
-	regcfg.max_register = devtype->nr * 0x20 - 1;
-	regmap = devm_regmap_init_spi(spi, &regcfg);
+	for (i = 0; i < devtype->nr; i++) {
+		u8 port_mask = i * 0x20;
+		regcfg.read_flag_mask = port_mask;
+		regcfg.write_flag_mask = port_mask | MAX310X_WRITE_BIT;
+		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
+	}
 
-	return max310x_probe(&spi->dev, devtype, regmap, spi->irq);
+	return max310x_probe(&spi->dev, devtype, regmaps, spi->irq);
 }
 
 static void max310x_spi_remove(struct spi_device *spi)
-- 
2.36.1

