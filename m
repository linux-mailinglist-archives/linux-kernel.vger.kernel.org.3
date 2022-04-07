Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA054F8867
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiDGURt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDGURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 474C8487C14
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649362404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NcP0b+Q0Ufxh9RUzkPjmCQaibubGP7dZRDqNH5/afA=;
        b=NiL33Bm+ZrX1Ldd1LGsU17J+RcUACmtFX5U7bLsCdih4yhjCIz5CmBgSMiFd8iYndppmME
        pb8QCF1OfAa819zweQxmhyTvJ+bYPxTDbG525zX1cwP5TDvRz/7C9+eUBAsFwhzWPNAVMj
        Nmj42ZsWury7ChK78U3gL/y0T5HZPWs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-C8vLtdqgPbmTxxompWJopQ-1; Thu, 07 Apr 2022 16:03:06 -0400
X-MC-Unique: C8vLtdqgPbmTxxompWJopQ-1
Received: by mail-wm1-f72.google.com with SMTP id a16-20020a05600c349000b0038e6392a346so3435867wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5NcP0b+Q0Ufxh9RUzkPjmCQaibubGP7dZRDqNH5/afA=;
        b=02VYGd8ZpcDbrWwhEmXGVgki2f/DJ7yB7/uxtzO1zAHxzwBVyniR4XUbTZdwcBngW9
         HKEyNaDabP805EzM1vTIwQG30rLW7bL+ghc+haskMfv3m6NUVk7694G/P+HFcIt/y/2t
         3QCH8qwYKJbcbv+k4l4VRGYXk3jUT+5NdkVHE22qLGcMBlkTh6FKB1SXAehzucGmTFmi
         /K1ZMbv94zDLLPXSECLaS2LDTwx9VMYcG92qh/mO2aYB3ODxdkPdbKFF0aOjjvtNcFtN
         L8MiHwCpBX4TygkYERwXUGD89Wb/Llc4I8+wR9brNHHVIip5PXyAcIuN4KLWWKtMLoke
         /ZMg==
X-Gm-Message-State: AOAM533P9SewKlctcx742VUX0ndjPAqW4Jzf2WKSsIxWVPWE00zuQe3E
        hW5oQZClA8R9ebb53AjvgWQwrd5ZAOZB5sx/nzPR0qxHpXnTwPt3lfSY+oGaiSUcCD+C/6TuQRl
        dpOjJ4zdwrRHPiZSDj+be5ymgyJvb+mpxoWYayZEnm/NwpQ3/jPYtxaOJvaE6WBM94fWlgbnpxY
        w=
X-Received: by 2002:a5d:5584:0:b0:206:d53:b553 with SMTP id i4-20020a5d5584000000b002060d53b553mr12234310wrv.222.1649361785238;
        Thu, 07 Apr 2022 13:03:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXhhElfHmHDSPxSVNJjtnjf4vXjXqp1p7HB+KYOspevUbZB9uXRGs/dS5r42YLL/Kl1pV98Q==
X-Received: by 2002:a5d:5584:0:b0:206:d53:b553 with SMTP id i4-20020a5d5584000000b002060d53b553mr12234281wrv.222.1649361784743;
        Thu, 07 Apr 2022 13:03:04 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm1048712wry.36.2022.04.07.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:03:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 5/5] drm/solomon: Add SSD130x OLED displays SPI support
Date:   Thu,  7 Apr 2022 22:02:04 +0200
Message-Id: <20220407200205.28838-6-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407200205.28838-1-javierm@redhat.com>
References: <20220407200205.28838-1-javierm@redhat.com>
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
---

 drivers/gpu/drm/solomon/Kconfig       |   9 ++
 drivers/gpu/drm/solomon/Makefile      |   1 +
 drivers/gpu/drm/solomon/ssd130x-spi.c | 184 ++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
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
index 000000000000..c3a2e7ba67a1
--- /dev/null
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -0,0 +1,184 @@
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
+	return 0;
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
+static struct gpio_desc *ssd130x_spi_get_dc(struct device *dev)
+{
+	struct gpio_desc *dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
+
+	if (IS_ERR(dc))
+		return ERR_PTR(dev_err_probe(dev, PTR_ERR(dc), "Failed to get dc gpio\n"));
+
+	return dc;
+}
+
+static int ssd130x_spi_probe(struct spi_device *spi)
+{
+	struct ssd130x_spi_transport *t;
+	struct ssd130x_device *ssd130x;
+	struct regmap *regmap;
+	struct device *dev = &spi->dev;
+
+	t = devm_kzalloc(dev, sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate SPI transport data\n");
+
+	t->spi = spi;
+
+	t->dc = ssd130x_spi_get_dc(&spi->dev);
+	if (IS_ERR(t->dc))
+		return PTR_ERR(t->dc);
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
+		.compatible = "sinowealth,sh1106-spi",
+		.data = (void *)SH1106_ID,
+	},
+	{
+		.compatible = "solomon,ssd1305-spi",
+		.data = (void *)SSD1305_ID,
+	},
+	{
+		.compatible = "solomon,ssd1306-spi",
+		.data =  (void *)SSD1306_ID,
+	},
+	{
+		.compatible = "solomon,ssd1307-spi",
+		.data =  (void *)SSD1307_ID,
+	},
+	{
+		.compatible = "solomon,ssd1309-spi",
+		.data =  (void *)SSD1309_ID,
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
+	{ "sh1106-spi",  SH1106_ID },
+	{ "ssd1305-spi", SSD1305_ID },
+	{ "ssd1306-spi", SSD1306_ID },
+	{ "ssd1307-spi", SSD1307_ID },
+	{ "ssd1309-spi", SSD1309_ID },
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
-- 
2.35.1

