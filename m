Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E633F4FFB29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiDMQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiDMQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EE1B13D74
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649867068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vT3qGhdQjfehGHhWMMA/PSxHxvxcnWmgzyvpoMXaxY4=;
        b=N1rG0lAH6osL8JTBZpbrK+FS9j4TuLsd/YNHGfdJSedoGw1ufH2YNK2v2fskbvAp3mmSqQ
        qvmfsGSTArsymhy3lD1c52lWVXiX7LWhqZ65SBF6S2K+V2iN9ZXN3y1XCq3W5YeT/IYUdy
        KQlwoz+dPpkJqmrQhwk8NVq9nhFnLFE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-YdQnt95XOC6ey2NhwGXngg-1; Wed, 13 Apr 2022 12:24:27 -0400
X-MC-Unique: YdQnt95XOC6ey2NhwGXngg-1
Received: by mail-wm1-f71.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so966545wmi.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vT3qGhdQjfehGHhWMMA/PSxHxvxcnWmgzyvpoMXaxY4=;
        b=dUPSSm1Jx1a9hs/sZ1jAqUluOlynb4fCnXPrbg8bSyw0weu2cJrJDaVfe2OUPTMTWR
         NxpO5QAQQDSm4cw4kZIxou9E+/UjSqWWZiuUX+Vcv42QDyEZH4xdregQ0fQAUxHGlSJw
         lfnczmHBeyZJf00KbEFSAuBP/3QfG50jE2RfATzuvKEgG3tzc7weFKvkAz4DPWrpdLOh
         crSXfrvBgwpWLJAU0n9spLMh2PsG0l2kf6clPIYJ/pTbLQWWGA3cIZundYRg1STHGyNn
         0Qk99w2Rsw6ZQa+nAuQfWtmgRrIJg4cw4d1pmqLbBHpo/VAXRadNJO3ZO0xQ1WsokDA1
         6a/A==
X-Gm-Message-State: AOAM531r3bmuU2ml36nliYzy2ctKQ8WftcMVj3bLiuWmLXb6wNEcLaBh
        Jm+9orB/mDdqyG6UC/tEX8ABPegkv+rNX3Zo7YVDduZMr9aVjA3oPesZig97SxWnAjSLOhUqINr
        gncynRK5GmYgW3LcA3HyGqJOcs69xaHxuovToEUFSRA1uybNJ/HPms9TnTyQYLSb1zOk/8MFolG
        E=
X-Received: by 2002:a7b:c8cd:0:b0:38e:c2c1:5219 with SMTP id f13-20020a7bc8cd000000b0038ec2c15219mr9119946wml.151.1649867065832;
        Wed, 13 Apr 2022 09:24:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV6ZCJi9p1JvOzvuZMyVvp1n2LAn9t2OyFPmaw9Q/nskwT4EpL/rGoRB3/lHhNYNgYGlINGw==
X-Received: by 2002:a7b:c8cd:0:b0:38e:c2c1:5219 with SMTP id f13-20020a7bc8cd000000b0038ec2c15219mr9119899wml.151.1649867065384;
        Wed, 13 Apr 2022 09:24:25 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm25446096wra.96.2022.04.13.09.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:24:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v4 5/5] drm/solomon: Add SSD130x OLED displays SPI support
Date:   Wed, 13 Apr 2022 18:23:58 +0200
Message-Id: <20220413162359.325021-6-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413162359.325021-1-javierm@redhat.com>
References: <20220413162359.325021-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ssd130x driver only provides the core support for these devices but it
does not have any bus transport logic. Add a driver to interface over SPI.

There is a difference in the communication protocol when using 4-wire SPI
instead of I2C. For the latter, a control byte that contains a D/C# field
has to be sent. This field tells the controller whether the data has to be
written to the command register or to the graphics display data memory.

But for 4-wire SPI that control byte is not used, instead a real D/C# line
must be pulled HIGH for commands data and LOW for graphics display data.

For this reason the standard SPI regmap can't be used and a custom .write
bus handler is needed.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
---

Changes in v4:
- Use MODULE_IMPORT_NS(DRM_SSD130X) in the ssd130x-spi driver (Andy Shevchenko)

Changes in v3:
- Drop ssd130x_spi_get_dc() helper and open code it (Geert Uytterhoeven)
- Export variants array and use &info[ID] in device table (Andy Shevchenko)

Changes in v2:
- Add the same compatible strings than I2C (Geert Uytterhoeven)

 drivers/gpu/drm/solomon/Kconfig       |   9 ++
 drivers/gpu/drm/solomon/Makefile      |   1 +
 drivers/gpu/drm/solomon/ssd130x-spi.c | 178 ++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-spi.c

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 8c0a0c788385..e170716d976b 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -20,3 +20,12 @@ config DRM_SSD130X_I2C
 	  I2C bus.
 
 	  If M is selected the module will be called ssd130x-i2c.
+
+config DRM_SSD130X_SPI
+	tristate "DRM support for Solomon SSD130X OLED displays (SPI bus)"
+	depends on DRM_SSD130X && SPI
+	select REGMAP
+	help
+	  Say Y here if the SSD130x OLED display is connected via SPI bus.
+
+	  If M is selected the module will be called ssd130x-spi.
diff --git a/drivers/gpu/drm/solomon/Makefile b/drivers/gpu/drm/solomon/Makefile
index 4bfc5acb0447..b5fc792257d7 100644
--- a/drivers/gpu/drm/solomon/Makefile
+++ b/drivers/gpu/drm/solomon/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_DRM_SSD130X)	+= ssd130x.o
 obj-$(CONFIG_DRM_SSD130X_I2C)	+= ssd130x-i2c.o
+obj-$(CONFIG_DRM_SSD130X_SPI)	+= ssd130x-spi.o
diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
new file mode 100644
index 000000000000..c94bbaa731da
--- /dev/null
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DRM driver for Solomon SSD130X OLED displays (SPI bus)
+ *
+ * Copyright 2022 Red Hat Inc.
+ * Authors: Javier Martinez Canillas <javierm@redhat.com>
+ */
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+
+#include "ssd130x.h"
+
+#define DRIVER_NAME	"ssd130x-spi"
+#define DRIVER_DESC	"DRM driver for Solomon SSD130X OLED displays (SPI)"
+
+struct ssd130x_spi_transport {
+	struct spi_device *spi;
+	struct gpio_desc *dc;
+};
+
+static const struct regmap_config ssd130x_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+/*
+ * The regmap bus .write handler, it is just a wrapper around spi_write()
+ * but toggling the Data/Command control pin (D/C#). Since for 4-wire SPI
+ * a D/C# pin is used, in contrast with I2C where a control byte is sent,
+ * prior to every data byte, that contains a bit with the D/C# value.
+ *
+ * These control bytes are considered registers by the ssd130x core driver
+ * and can be used by the ssd130x SPI driver to determine if the data sent
+ * is for a command register or for the Graphic Display Data RAM (GDDRAM).
+ */
+static int ssd130x_spi_write(void *context, const void *data, size_t count)
+{
+	struct ssd130x_spi_transport *t = context;
+	struct spi_device *spi = t->spi;
+	const u8 *reg = data;
+
+	if (*reg == SSD130X_COMMAND)
+		gpiod_set_value_cansleep(t->dc, 0);
+
+	if (*reg == SSD130X_DATA)
+		gpiod_set_value_cansleep(t->dc, 1);
+
+	/* Remove the control byte since is not used by the 4-wire SPI */
+	return spi_write(spi, ((u8 *)data) + 1, count - 1);
+}
+
+/* The ssd130x driver does not read registers but regmap expects a .read */
+static int ssd130x_spi_read(void *context, const void *reg, size_t reg_size,
+			    void *val, size_t val_size)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * A custom bus is needed due the special write that toggles a D/C# pin,
+ * another option could be to just have a .reg_write() callback but that
+ * will prevent to do data writes in bulk.
+ *
+ * Once the regmap API is extended to support defining a bulk write handler
+ * in the struct regmap_config, this can be simplified and the bus dropped.
+ */
+static struct regmap_bus regmap_ssd130x_spi_bus = {
+	.write = ssd130x_spi_write,
+	.read = ssd130x_spi_read,
+};
+
+static int ssd130x_spi_probe(struct spi_device *spi)
+{
+	struct ssd130x_spi_transport *t;
+	struct ssd130x_device *ssd130x;
+	struct regmap *regmap;
+	struct gpio_desc *dc;
+	struct device *dev = &spi->dev;
+
+	dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(dc))
+		return dev_err_probe(dev, PTR_ERR(dc),
+				     "Failed to get dc gpio\n");
+
+	t = devm_kzalloc(dev, sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate SPI transport data\n");
+
+	t->spi = spi;
+	t->dc = dc;
+
+	regmap = devm_regmap_init(dev, &regmap_ssd130x_spi_bus, t,
+				  &ssd130x_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ssd130x = ssd130x_probe(dev, regmap);
+	if (IS_ERR(ssd130x))
+		return PTR_ERR(ssd130x);
+
+	spi_set_drvdata(spi, ssd130x);
+
+	return 0;
+}
+
+static void ssd130x_spi_remove(struct spi_device *spi)
+{
+	struct ssd130x_device *ssd130x = spi_get_drvdata(spi);
+
+	ssd130x_remove(ssd130x);
+}
+
+static void ssd130x_spi_shutdown(struct spi_device *spi)
+{
+	struct ssd130x_device *ssd130x = spi_get_drvdata(spi);
+
+	ssd130x_shutdown(ssd130x);
+}
+
+static const struct of_device_id ssd130x_of_match[] = {
+	{
+		.compatible = "sinowealth,sh1106",
+		.data = &ssd130x_variants[SH1106_ID],
+	},
+	{
+		.compatible = "solomon,ssd1305",
+		.data = &ssd130x_variants[SSD1305_ID],
+	},
+	{
+		.compatible = "solomon,ssd1306",
+		.data = &ssd130x_variants[SSD1306_ID],
+	},
+	{
+		.compatible = "solomon,ssd1307",
+		.data = &ssd130x_variants[SSD1307_ID],
+	},
+	{
+		.compatible = "solomon,ssd1309",
+		.data = &ssd130x_variants[SSD1309_ID],
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ssd130x_of_match);
+
+/*
+ * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
+ * if the device was registered via OF. This means that the module will not be
+ * auto loaded, unless it contains an alias that matches the MODALIAS reported.
+ *
+ * To workaround this issue, add a SPI device ID table. Even when this should
+ * not be needed for this driver to match the registered SPI devices.
+ */
+static const struct spi_device_id ssd130x_spi_table[] = {
+	{ "sh1106",  SH1106_ID },
+	{ "ssd1305", SSD1305_ID },
+	{ "ssd1306", SSD1306_ID },
+	{ "ssd1307", SSD1307_ID },
+	{ "ssd1309", SSD1309_ID },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
+
+static struct spi_driver ssd130x_spi_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = ssd130x_of_match,
+	},
+	.probe = ssd130x_spi_probe,
+	.remove = ssd130x_spi_remove,
+	.shutdown = ssd130x_spi_shutdown,
+};
+module_spi_driver(ssd130x_spi_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(DRM_SSD130X);
-- 
2.35.1

