Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773D2507C20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355759AbiDSVvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358064AbiDSVvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BCBF3FD8F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BABEWfImdlFz6h6c/n67mZugkGxrntzCJH3oamrW2E=;
        b=Ai0Kjoeaio+CIPspI8ARsI9MIAmlvr9A5HoCFYqTQVpzPCT2XZuxDGw0rEx8kxQfMmuCB+
        9TLDxBPJZqq2mVgB9A5HAF34CLyxD1O6mhw3lEyPOBvswOoHrw7lTSjYw5IKp78xinAnIy
        SRXghHMb7AqkHFi/vlAZKclLqhRKdVI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-5XIQTabpMvGNsIPyvRDgeQ-1; Tue, 19 Apr 2022 17:48:37 -0400
X-MC-Unique: 5XIQTabpMvGNsIPyvRDgeQ-1
Received: by mail-wm1-f70.google.com with SMTP id n37-20020a05600c502500b0038fdc1394c6so9247387wmr.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BABEWfImdlFz6h6c/n67mZugkGxrntzCJH3oamrW2E=;
        b=NZ8Va2l3e0QnIllYXPG43N49R+8nIl/J8QHGYlfYUuRxV+wUBlrzsSVP7RROmpM0+A
         muOfU+gCz95VtRzxR7BModmH9RcpPxjEpjyRa0d1KFDs/jQWwercSHxvW2BrN8uhsMYj
         i5on375kIEAU1xIvVkc8Wev0Xi4FhLOaxw3cuvL5Jm0DeCNoqQYjvOkcTwTqXO7ls7mT
         vDwCXvQ4pAnz6PRG/A/wXE3OZInsZ1dkZlsh2Xzq7fl1oRqeQqhhn8kcMxn+LmaHDkCj
         6YpU78SsUmBc1zYBE8h5y/c9KH9Xl+PF3G4tuYIUKcJwGG9+YBL8spDikTgOAPH2boFR
         Be6Q==
X-Gm-Message-State: AOAM530o9k9dXmb5QsKOGAAVl4n1868sW9JrY7u8zPpKyNSF2gw+fvRU
        yipQRTmjR3z4HmAdFoT6iRJ9YeEp+ZWAQ8iyWFOqWhUIiwoIIoYgdGipUftCJyfNBrwQ4eNwFRC
        bn56ZFK7E1brNcej36QfrueAvIj1ECwQHldKMGK4i8dGxQQF1cKiKRSrk4ssJhJOAFen3dppnIu
        I=
X-Received: by 2002:a05:6000:1f83:b0:207:a4d8:5173 with SMTP id bw3-20020a0560001f8300b00207a4d85173mr13509744wrb.556.1650404916209;
        Tue, 19 Apr 2022 14:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF2skj/V3EtDOGqDPbahJ0c56qmLcV68R71JLptBPDt4NcJfm0DW9YIY+OPcNJy8tLV2Jqxw==
X-Received: by 2002:a05:6000:1f83:b0:207:a4d8:5173 with SMTP id bw3-20020a0560001f8300b00207a4d85173mr13509714wrb.556.1650404915863;
        Tue, 19 Apr 2022 14:48:35 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b00207a8cde900sm13333699wrv.19.2022.04.19.14.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:48:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v5 5/5] drm/solomon: Add SSD130x OLED displays SPI support
Date:   Tue, 19 Apr 2022 23:48:23 +0200
Message-Id: <20220419214824.335075-6-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419214824.335075-1-javierm@redhat.com>
References: <20220419214824.335075-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v5:
- Remove cast by just using u8 *reg instead of void *data (Geert Uytterhoeven).
- Add Geert Uytterhoeven's Reviewed-by tag to patch 5/5.

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
index 000000000000..43722adab1f8
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
+	/* Remove control byte since is not used in a 4-wire SPI interface */
+	return spi_write(spi, reg + 1, count - 1);
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

