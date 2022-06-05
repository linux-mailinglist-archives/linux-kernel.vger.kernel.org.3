Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59053DC57
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbiFEOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbiFEOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:47:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13455F52;
        Sun,  5 Jun 2022 07:47:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kq6so11488789ejb.11;
        Sun, 05 Jun 2022 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHOtVO3YML97AxTHN1lPIFLaGm5HbxOfT4Z5jAGZugo=;
        b=CL3SS+vgAElyH9qpICNCklTVijTGO/HvPibTqan8lPauLdERlD7mENhyDF0OONNI3S
         JHADrl6x7vVzddG/JGvK/bImNn1RLIEXZLVJ6tcjqCt61MmhiiIXBS+sXfOI+7sH9Bk8
         zXP0UEVlhUgLRkPo4KhLBMlGkyXxSXpYpKON5r258w2fGnjLm53E86oOdCfuijZEj3JY
         4DeZrPTHdg3L9kEZcXLtqHkyNCYSvTHHKAKFVw4knUP7aUTrSuyAllQd4Qrx6xuerxxz
         VokicaLttaR2qTH3adz3Qmavj7/8HOcSC/n8ToSadab929mkkYF72CEnujHHYXCi0kZ3
         vYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHOtVO3YML97AxTHN1lPIFLaGm5HbxOfT4Z5jAGZugo=;
        b=n7l8+AplJcapiVVMysJpD5VYTUnuqzLJ0fz64TfWOEA+p54vnxwlZl+lz9cPn+36YX
         b88hU0hvrhheJb+fJFMpAktjjp2JGfvsAAxgUSU6GcOB4Rv6n+lTpSie9s3WLBefTjVm
         Capj9f4Qz4AxOhA/Y65GLXwgDNFr9ac7FG/mbYlPcBV+rAI05DR0DUHqZgcXC2GL+9Rm
         1lknzQ68ZPUsRn+3DjcCPadBAkKMnhlVbS0sYbeTGxL6h77n2/Z/xmLDsg8Y8TV/MKAR
         Yoso2ZFeVzXSglGLHHJrTwCJs1GTneaILqIX6aqmQYerxu4V4dKZvUtK2c71rKdCWkZe
         BFMQ==
X-Gm-Message-State: AOAM533eK8FMUFDg30FaqM8kmBY0rqabKJ3sKbc3fl8SViQwphpK4rOr
        3brgOJun/hvXRkEAiLYmwZt59u6g9As=
X-Google-Smtp-Source: ABdhPJzTPstgV6eipESq+ORYcq7GsSrW2igOzOdZWbARfkjFQ08KUkZpIgvMqq9ZkqYdxnnX83935Q==
X-Received: by 2002:a17:907:6e11:b0:6fe:feaa:bb04 with SMTP id sd17-20020a1709076e1100b006fefeaabb04mr18216429ejc.187.1654440452198;
        Sun, 05 Jun 2022 07:47:32 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b0042dd4ccccf5sm6854254edv.82.2022.06.05.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:47:31 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 4/4] serial: max310x: implement I2C support
Date:   Sun,  5 Jun 2022 17:46:59 +0300
Message-Id: <20220605144659.4169853-5-demonsingur@gmail.com>
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
 drivers/tty/serial/max310x.c | 135 ++++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a452748c69b2..8a3ee1525d80 100644
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
index ef6b91242524..0f7c5908fee0 100644
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
@@ -423,6 +429,10 @@ static const struct max310x_devtype max3107_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT | MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max3107_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x2c,
+		.max = 0x2f,
+	},
 };
 
 static const struct max310x_devtype max3108_devtype = {
@@ -431,6 +441,10 @@ static const struct max310x_devtype max3108_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3108_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max3109_devtype = {
@@ -439,6 +453,10 @@ static const struct max310x_devtype max3109_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3109_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max14830_devtype = {
@@ -447,6 +465,10 @@ static const struct max310x_devtype max14830_devtype = {
 	.mode1	= MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max14830_detect,
 	.power	= max14830_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
@@ -1516,6 +1538,97 @@ static struct spi_driver max310x_spi_driver = {
 };
 #endif
 
+#ifdef CONFIG_I2C
+static int max310x_i2c_extended_reg_enable(struct device *dev, bool enable)
+{
+	return 0;
+}
+
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
+	.extended_reg_enable = max310x_i2c_extended_reg_enable,
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
+static struct i2c_driver max310x_i2c_driver = {
+	.driver = {
+		.name		= MAX310X_NAME,
+		.of_match_table	= max310x_dt_ids,
+		.pm		= &max310x_pm_ops,
+	},
+	.probe_new	= max310x_i2c_probe,
+	.remove		= max310x_i2c_remove,
+};
+#endif
+
 static int __init max310x_uart_init(void)
 {
 	int ret;
@@ -1529,15 +1642,35 @@ static int __init max310x_uart_init(void)
 #ifdef CONFIG_SPI_MASTER
 	ret = spi_register_driver(&max310x_spi_driver);
 	if (ret)
-		uart_unregister_driver(&max310x_uart);
+		goto err_spi_register;
+#endif
+
+#ifdef CONFIG_I2C
+	ret = i2c_add_driver(&max310x_i2c_driver);
+	if (ret)
+		goto err_i2c_register;
 #endif
 
+	return 0;
+
+#ifdef CONFIG_I2C
+err_i2c_register:
+	spi_unregister_driver(&max310x_spi_driver);
+#endif
+
+err_spi_register:
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

