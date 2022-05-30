Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A25388D2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 00:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbiE3WPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 18:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiE3WOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 18:14:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F75D668;
        Mon, 30 May 2022 15:14:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f21so23130947ejh.11;
        Mon, 30 May 2022 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOKaH3M7/pHjmrcILcMEX0R6ej4L5KW6VEbmTw65R4U=;
        b=TbiCglhAvk87jcDu4hJEfObeERLf+oSoeO0N8bUbqbYz19IrnT5aeVYQFgZvW5EM4P
         T4HFxrBJ8oyhJ2varPxLBXecoLH79YVrFL2arVPTqfFJ0EieKmSLmPSfULCdMpgdXxFF
         xWWOzxR66DXkKLGYE3evnf6t5BTyGuT0Wgzzah7U4wib9efI4fD/n5Omy1mZD6SaN1X1
         QjPAmRGJioxEzJJxMY0MkrvrpdIycmaOhH++cWnzUKvfkKgn0kKyDp1UqH/uGafYukCE
         BgbI9VndeQHnDcH8zA4BBIC71ZOV5bgnIZLRLREdT1giR0MThVf4ImMYuNN7cj4FgSrN
         IZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOKaH3M7/pHjmrcILcMEX0R6ej4L5KW6VEbmTw65R4U=;
        b=lXUboJ1RA5SqUdaZD+jVmRr2S7R5uLCxcmJ1azQJYTnZAJ1QJv133FHVjXMOewwxjQ
         fQIwuTIRgV95w3swms5wyfRUP1/qD/YuB+nHwXvK2fsm7upx4wD6nM4nt928f+yG3FYx
         FZJYoO5XtGibFw37Nqzj4FrvklpWDoEEiNdvl7+A/hwOh6l2DnRV3yxr649znaBJIf9W
         fO2xyF6VRRj4wWqEoL6Ml6N6wG5KuODbKDFNiPo4GEhopJMVSbJCfCs/75WZ36rp7CWA
         FXGxpYaphqXuwl6iPzKh3lItidVnVSDEk8omjII6T3LDd1OKiSHJ4Q5RCO5/mp6vdGjb
         PFvw==
X-Gm-Message-State: AOAM531rHYMulebP/GAoJKFaYu7PjhNrogHTekbAZfjwdcH2qu7EnXA7
        ao/qzRUfoF2UnPRDRe9p23Y=
X-Google-Smtp-Source: ABdhPJyTcUceOmnsZoWxEIVY8h221SQ4yn4mqux4u14QU91jsEeVS4CovvXBMjaVfMloj99QeytnWA==
X-Received: by 2002:a17:907:7d90:b0:6ff:b2b:8272 with SMTP id oz16-20020a1709077d9000b006ff0b2b8272mr26801164ejc.82.1653948885728;
        Mon, 30 May 2022 15:14:45 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id a92-20020a509ee5000000b0042dbc55f6e4sm4485850edf.7.2022.05.30.15.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 15:14:45 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH 4/4] serial: max310x: implement I2C support
Date:   Tue, 31 May 2022 01:14:29 +0300
Message-Id: <20220530221429.1248083-4-demonsingur@gmail.com>
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

I2C implementation on this chip has a few key differences
compared to SPI, as described in previous patches.
 * extended register space access needs no extra logic
 * slave address is used to select which UART to communicate
   with

To accommodate these differences, add an I2C interface config,
set the RevID register address and implement an empty method
for setting the GlobalCommand register, since no special handling
is needed for the extended register space.

To handle the port-specific slave address, create an I2C dummy
device for each port, except the base one (UART0), which is
expected to be the one specified in firmware, and create a
regmap for each I2C device.
Add minimum and maximum slave addresses to each devtype for
sanity checking.

Also, use a separate regmap config with no write_flag_mask,
since I2C has a R/W bit in its slave address, and set the
max register to the address of the RevID register, since the
extended register space needs no extra logic.

Finally, add the I2C driver.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/tty/serial/Kconfig   |   1 +
 drivers/tty/serial/max310x.c | 131 ++++++++++++++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 80321b9c4465..a397c8607647 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -324,6 +324,7 @@ config SERIAL_MAX310X
 	depends on SPI_MASTER
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
+	select REGMAP_I2C if I2C
 	help
 	  This selects support for an advanced UART from Maxim (Dallas).
 	  Supported ICs are MAX3107, MAX3108, MAX3109, MAX14830.
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0cbe7cb1ad26..0ebb723dd241 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -73,6 +74,7 @@
 
 /* Extended registers */
 #define MAX310X_SPI_REVID_EXTREG	MAX310X_REG_05 /* Revision ID */
+#define MAX310X_I2C_REVID_EXTREG	(0x25) /* Revision ID */
 
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
@@ -252,6 +254,10 @@ struct max310x_if_cfg {
 };
 
 struct max310x_devtype {
+	struct {
+		unsigned short min;
+		unsigned short max;
+	} slave_addr;
 	char	name[9];
 	int	nr;
 	u8	mode1;
@@ -365,6 +371,11 @@ static int max310x_spi_set_ext_reg_en(struct device *dev, bool enable)
 			    enable ? MAX310X_EXTREG_ENBL : MAX310X_EXTREG_DSBL);
 }
 
+static int max310x_i2c_set_ext_reg_en(struct device *dev, bool enable)
+{
+	return 0;
+}
+
 static int max3109_detect(struct device *dev)
 {
 	struct max310x_port *s = dev_get_drvdata(dev);
@@ -431,6 +442,10 @@ static const struct max310x_devtype max3107_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT | MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max3107_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x2c,
+		.max = 0x2f,
+	},
 };
 
 static const struct max310x_devtype max3108_devtype = {
@@ -439,6 +454,10 @@ static const struct max310x_devtype max3108_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3108_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max3109_devtype = {
@@ -447,6 +466,10 @@ static const struct max310x_devtype max3109_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3109_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max14830_devtype = {
@@ -455,6 +478,10 @@ static const struct max310x_devtype max14830_devtype = {
 	.mode1	= MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max14830_detect,
 	.power	= max14830_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
@@ -1517,6 +1544,90 @@ static struct spi_driver max310x_spi_driver = {
 };
 #endif
 
+static struct regmap_config regcfg_i2c = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.writeable_reg = max310x_reg_writeable,
+	.volatile_reg = max310x_reg_volatile,
+	.precious_reg = max310x_reg_precious,
+	.max_register = MAX310X_I2C_REVID_EXTREG,
+};
+
+static const struct max310x_if_cfg max310x_i2c_if_cfg = {
+	.set_ext_reg_en = max310x_i2c_set_ext_reg_en,
+	.rev_id_reg = MAX310X_I2C_REVID_EXTREG,
+};
+
+static unsigned short max310x_i2c_slave_addr(unsigned short addr,
+					     unsigned int nr)
+{
+	/*
+	 * For MAX14830 and MAX3109, the slave address depends on what the
+	 * A0 and A1 pins are tied to.
+	 * See Table I2C Address Map of the datasheet.
+	 * Based on that table, the following formulas were determined.
+	 * UART1 - UART0 = 0x10
+	 * UART2 - UART1 = 0x20 + 0x10
+	 * UART3 - UART2 = 0x10
+	 */
+
+	addr -= nr * 0x10;
+
+	if (nr >= 2)
+		addr -= 0x20;
+
+	return addr;
+}
+
+static int max310x_i2c_probe(struct i2c_client *client)
+{
+	const struct max310x_devtype *devtype =
+			device_get_match_data(&client->dev);
+	struct i2c_client *port_client;
+	struct regmap *regmaps[4];
+	unsigned int i;
+	u8 port_addr;
+
+	if (client->addr < devtype->slave_addr.min ||
+		client->addr > devtype->slave_addr.max)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Slave addr 0x%x outside of range [0x%x, 0x%x]\n",
+				     client->addr, devtype->slave_addr.min,
+				     devtype->slave_addr.max);
+
+	regmaps[0] = devm_regmap_init_i2c(client, &regcfg_i2c);
+
+	for (i = 1; i < devtype->nr; i++) {
+		port_addr = max310x_i2c_slave_addr(client->addr, i);
+		port_client = devm_i2c_new_dummy_device(&client->dev,
+							client->adapter,
+							port_addr);
+
+		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
+	}
+
+	return max310x_probe(&client->dev, devtype, &max310x_i2c_if_cfg,
+			     regmaps, client->irq);
+}
+
+static int max310x_i2c_remove(struct i2c_client *client)
+{
+	max310x_remove(&client->dev);
+
+	return 0;
+}
+
+static struct i2c_driver __maybe_unused max310x_i2c_driver = {
+	.driver = {
+		.name		= MAX310X_NAME,
+		.of_match_table	= max310x_dt_ids,
+		.pm		= &max310x_pm_ops,
+	},
+	.probe_new	= max310x_i2c_probe,
+	.remove		= max310x_i2c_remove,
+};
+
 static int __init max310x_uart_init(void)
 {
 	int ret;
@@ -1530,15 +1641,33 @@ static int __init max310x_uart_init(void)
 #ifdef CONFIG_SPI_MASTER
 	ret = spi_register_driver(&max310x_spi_driver);
 	if (ret)
-		uart_unregister_driver(&max310x_uart);
+		goto err_spi_register;
 #endif
 
+#ifdef CONFIG_I2C
+	ret = i2c_add_driver(&max310x_i2c_driver);
+	if (ret)
+		goto err_i2c_register;
+#endif
+
+	return 0;
+
+err_spi_register:
+	spi_unregister_driver(&max310x_spi_driver);
+
+err_i2c_register:
+	uart_unregister_driver(&max310x_uart);
+
 	return ret;
 }
 module_init(max310x_uart_init);
 
 static void __exit max310x_uart_exit(void)
 {
+#ifdef CONFIG_I2C
+	i2c_del_driver(&max310x_i2c_driver);
+#endif
+
 #ifdef CONFIG_SPI_MASTER
 	spi_unregister_driver(&max310x_spi_driver);
 #endif
-- 
2.36.1

