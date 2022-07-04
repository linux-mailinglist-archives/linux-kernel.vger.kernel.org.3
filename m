Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6C565030
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiGDJBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiGDJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:01:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B892B68
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:01:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so10798214edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTzb7P3Ka1QQKa3SQpTRVRJOQE01QIRS+JQiznZvzvU=;
        b=IHHk+u2thLVLNVRHSPxxDMvnuOpm7qUoUjgR9V68q4sOhjrJLJsXSaMhXQdrnj8UBz
         CjvupJPwy7yJhuv3l7LACXP7IlmPWWBTPDNlfDxpG8VpBSna1ga44bDik9Icb0FjHrW0
         hTYqEjDwrHbuKIBT8qeuX6UIwl580oSZGzsjqa8CVN/Mt6+UAWXKUCTKot1S62i/FJq9
         eqxGPQJ5UqwMo6qNdbc2Nip/pa8Rr0PJpvcRkYAmKigF2BE1wpVmqA5e5xVqqih86VaX
         3l15Ptu4Wakm6QetnRW+oveoETkvuMw7poe0R6Wa+OnrawYpbkGtB6ziJm56huAkBWxM
         XqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTzb7P3Ka1QQKa3SQpTRVRJOQE01QIRS+JQiznZvzvU=;
        b=j2l7s8DoswDr4Yae8VP+g2DPDkL299tsdqK9fcMc6bKSFs4u9zl/bQCq9mKDaTkKtm
         RtcLgHyPtiQeyvJeMtRc/MYw1Wugn1PeY/2aAmqkm0BQbjyKWjgxfhiW5LL2su7WYTD1
         nAj0ielEpz8A3vFUNs7RUNOhEKBBCat4iyCwDpWADmn8YoOMttBivh+DxubDAzRH4yYS
         j9VxYAIfAb8VpxZjpYw+lXdKufcUkwesksMMrBiBN/8aJlVDi0cLYs4X84gIRfj8fy1I
         hlhSKHnbMXnRhcYRr258/5yM+iTTIwZcssO9Clseb8skeN6nr4R67+Xvyr+Mw/8eVbZ2
         2NuA==
X-Gm-Message-State: AJIora9Ubn7jCSh5ID98yG69MqnYYMK8WF9FyV1hHHKX8CmwFA5ZjT+6
        bTMMHUG0DOx0WMLT/9IHbn6q6oSIIHB78L+0
X-Google-Smtp-Source: AGRyM1s3ItVB5FDxBdZWJGgUOrPZUm/zhLYjcfkjDfa34K7fVChZiUs1ZhLu9fYVEWmk2bOwECJ01g==
X-Received: by 2002:a05:6402:2684:b0:435:dcaf:29b3 with SMTP id w4-20020a056402268400b00435dcaf29b3mr37927155edd.358.1656925283404;
        Mon, 04 Jul 2022 02:01:23 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0072ab9f5ae5fsm1642613ejo.75.2022.07.04.02.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:01:22 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 4/5] iio: max597x: Add support for max597x
Date:   Mon,  4 Jul 2022 11:00:48 +0200
Message-Id: <20220704090050.3289572-5-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704090050.3289572-1-Naresh.Solanki@9elements.com>
References: <20220704090050.3289572-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

max597x has 10bit ADC for voltage & current monitoring.
Use iio framework to expose the same in sysfs.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/iio/adc/Kconfig       |   9 ++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/max597x-iio.c | 156 ++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/iio/adc/max597x-iio.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 48ace7412874..d4676eefb60f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -683,6 +683,15 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX597X_IIO
+	tristate "Maxim 597x power switch and monitor"
+	depends on I2C
+	depends on OF
+	select MFD_MAX597X
+	help
+	  This driver exposes Maxim 5970/5978 voltage/current monitoring
+	  interface using iio framework.
+
 config MAX9611
 	tristate "Maxim max9611/max9612 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f6d457..f8cb5a30a946 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX597X_IIO) += max597x-iio.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
diff --git a/drivers/iio/adc/max597x-iio.c b/drivers/iio/adc/max597x-iio.c
new file mode 100644
index 000000000000..de0ea762c5c8
--- /dev/null
+++ b/drivers/iio/adc/max597x-iio.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/iio/iio.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max597x.h>
+#include <linux/regmap.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+struct max597x_iio {
+	struct regmap *regmap;
+	int shunt_micro_ohms[MAX5970_NUM_SWITCHES];
+	unsigned int irng[MAX5970_NUM_SWITCHES];
+	unsigned int mon_rng[MAX5970_NUM_SWITCHES];
+};
+
+#define MAX597X_ADC_CHANNEL(_idx, _type) {			\
+	.type = IIO_ ## _type,					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.address = MAX5970_REG_ ## _type ## _L(_idx),		\
+}
+
+static const struct iio_chan_spec max5978_adc_iio_channels[] = {
+	MAX597X_ADC_CHANNEL(0, VOLTAGE),
+	MAX597X_ADC_CHANNEL(0, CURRENT),
+};
+
+static const struct iio_chan_spec max5970_adc_iio_channels[] = {
+	MAX597X_ADC_CHANNEL(0, VOLTAGE),
+	MAX597X_ADC_CHANNEL(0, CURRENT),
+	MAX597X_ADC_CHANNEL(1, VOLTAGE),
+	MAX597X_ADC_CHANNEL(1, CURRENT),
+};
+
+static int max597x_iio_read_raw(struct iio_dev *iio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long info)
+{
+	int ret;
+	struct max597x_iio *data = iio_priv(iio_dev);
+	unsigned int reg_l, reg_h;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, chan->address, &reg_l);
+		if (ret < 0)
+			return ret;
+		ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
+		if (ret < 0)
+			return ret;
+		*val = (reg_h << 2) | (reg_l & 3);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+
+		switch (chan->address) {
+		case MAX5970_REG_CURRENT_L(0):
+			fallthrough;
+		case MAX5970_REG_CURRENT_L(1):
+			/* in A, convert to mA */
+			*val = data->irng[chan->channel] * 1000;
+			*val2 =
+			    data->shunt_micro_ohms[chan->channel] * ADC_MASK;
+			return IIO_VAL_FRACTIONAL;
+
+		case MAX5970_REG_VOLTAGE_L(0):
+			fallthrough;
+		case MAX5970_REG_VOLTAGE_L(1):
+			/* in uV, convert to mV */
+			*val = data->mon_rng[chan->channel];
+			*val2 = ADC_MASK * 1000;
+			return IIO_VAL_FRACTIONAL;
+		}
+
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info max597x_adc_iio_info = {
+	.read_raw = &max597x_iio_read_raw,
+};
+
+static int max597x_iio_probe(struct platform_device *pdev)
+{
+	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev;
+	struct max597x_iio *priv;
+	int ret, i;
+
+	/* registering iio */
+	indio_dev = devm_iio_device_alloc(max597x->dev, sizeof(*priv));
+	if (!indio_dev) {
+		dev_err(max597x->dev, "failed allocating iio device\n");
+		return -ENOMEM;
+	}
+	indio_dev->name = dev_name(max597x->dev);
+	indio_dev->info = &max597x_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	switch (max597x->num_switches) {
+	case MAX597x_TYPE_MAX5970:
+		indio_dev->channels = max5970_adc_iio_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max5970_adc_iio_channels);
+		break;
+	case MAX597x_TYPE_MAX5978:
+		indio_dev->channels = max5978_adc_iio_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max5978_adc_iio_channels);
+		break;
+	}
+
+	priv = iio_priv(indio_dev);
+	priv->regmap = max597x->regmap;
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		priv->irng[i] = max597x->irng[i];
+		priv->mon_rng[i] = max597x->mon_rng[i];
+		priv->shunt_micro_ohms[i] = max597x->shunt_micro_ohms[i];
+	}
+
+	ret = devm_iio_device_register(max597x->dev, indio_dev);
+	if (ret)
+		dev_err(max597x->dev, "could not register iio device");
+
+	return ret;
+
+}
+
+static struct platform_driver max597x_iio_driver = {
+	.driver = {
+		.name = "max597x-iio",
+	},
+	.probe = max597x_iio_probe,
+};
+
+module_platform_driver(max597x_iio_driver);
+
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.35.3

