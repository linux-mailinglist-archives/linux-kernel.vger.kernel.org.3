Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89E584571
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiG1Rv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiG1Rvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:51:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16EB73929
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l22so3221005wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjnkW3tzFod/D+8w6/bq2Oy1wMEdgV9amYmMNoE4+kk=;
        b=AeMzvLXQZYx1+cTGYxXW7aACAUk+ZFnEms7iuZAECC9qKZZXh7w7MPG32ye7VvPj9f
         qZMkhvwKXZmeK/YlH/X7PFCSU3SB5ejZEjWwKucdf4OAI5Rd4PeEIZhtUGu6y3jnper3
         3OArMwynYOkMUjMoXxOxyQ694MeVpAJDOGkojRNuT3Bbj3GeKzCk9APoDhHO3ime91b5
         wSLntVUmKdVoIqtiGIGedgZVDpj1PyBIX7YA9XERHLQyTlBLYp1dPYUdItgANvTKLHk9
         5qEBMwIcqRZ4r2vSWH4Lkut/RwLJGg43I8EhDMn3AJp0gu5v0d7OvsgNQoNeg4PNnRas
         R7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjnkW3tzFod/D+8w6/bq2Oy1wMEdgV9amYmMNoE4+kk=;
        b=M41CcA97mnNeb8TZzzYKe6RuRl8rNre3qfEhnR4R+3bbMMgolLOoVZQeI65ByOUvCk
         P7cpDuIARVaqmknCR/oQbk150SfWS4+lgPXhx1FZQvFI3h1KxZzfM+KGyMoKblPdt/qM
         dvwTyLexVTsoZEy0bASWOfmjqWbI1mOIEMV6DDK7gmQH2lIAiNk0nJrHzQI/jh7Lw+8h
         9sKmfn/BHqaFqOIY0CgYoXiD+XI+NTgQOWUsYKEEe6uBeGHwmei1FniWtjVJhJAGBC3q
         76t6FmIhb4y7SEZOaZAWXZAQipj8XqhhVGM6YseiU+hJZMT4rjaBc7dliuhYngBtnqLe
         cGlQ==
X-Gm-Message-State: ACgBeo12a+yET9H4Oh79ZSwiKcC7VGAnvvYDshZmWUfB4ZgUjZl9fwYI
        7ENDVTNKit8D5dBEeG7PMpB7HQ==
X-Google-Smtp-Source: AA6agR6qPOi91MJYBICh3apEUZJvnnF4W2lGJPcoZ5vYE63nYuia0z15ObHfuCa37XTruUJ/H/1gXw==
X-Received: by 2002:adf:f0c1:0:b0:21d:ed10:5811 with SMTP id x1-20020adff0c1000000b0021ded105811mr55834wro.656.1659030695991;
        Thu, 28 Jul 2022 10:51:35 -0700 (PDT)
Received: from localhost.localdomain (33.169.185.81.rev.sfr.net. [81.185.169.33])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003a3442f1229sm8274027wmq.29.2022.07.28.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:51:35 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support for ECAP
Date:   Thu, 28 Jul 2022 19:51:24 +0200
Message-Id: <20220728175124.468461-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728175124.468461-1-jpanis@baylibre.com>
References: <20220728175124.468461-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECAP hardware on AM62x SoC supports capture feature. It can be used
to timestamp events (falling/rising edges) detected on signal input pin.

This commit adds capture driver support for ECAP hardware on AM62x SoC.

In the ECAP hardware, capture pin can also be configured to be in
PWM mode. Current implementation only supports capture operating mode.
Hardware also supports timebase sync between multiple instances, but
this driver supports simple independent capture functionality.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/iio/Kconfig               |   1 +
 drivers/iio/Makefile              |   1 +
 drivers/iio/time/Kconfig          |  22 ++
 drivers/iio/time/Makefile         |   6 +
 drivers/iio/time/capture-tiecap.c | 517 ++++++++++++++++++++++++++++++
 5 files changed, 547 insertions(+)
 create mode 100644 drivers/iio/time/Kconfig
 create mode 100644 drivers/iio/time/Makefile
 create mode 100644 drivers/iio/time/capture-tiecap.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b190846c3dc2..ba11b8824071 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -99,5 +99,6 @@ source "drivers/iio/pressure/Kconfig"
 source "drivers/iio/proximity/Kconfig"
 source "drivers/iio/resolver/Kconfig"
 source "drivers/iio/temperature/Kconfig"
+source "drivers/iio/time/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 3be08cdadd7e..09283402a2c6 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -42,4 +42,5 @@ obj-y += proximity/
 obj-y += resolver/
 obj-y += temperature/
 obj-y += test/
+obj-y += time/
 obj-y += trigger/
diff --git a/drivers/iio/time/Kconfig b/drivers/iio/time/Kconfig
new file mode 100644
index 000000000000..02f6cf7ff79e
--- /dev/null
+++ b/drivers/iio/time/Kconfig
@@ -0,0 +1,22 @@
+#
+# Time drivers
+#
+
+menu "Time"
+
+config CAPTURE_TIECAP
+	tristate "ECAP capture support"
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	depends on HAS_IOMEM
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	help
+	  IIO driver support for the ECAP capture hardware found on TI SoCs.
+
+	  It can be used to timestamp events (falling/rising edges) detected
+	  on signal input pin.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called capture-tiecap.
+
+endmenu
diff --git a/drivers/iio/time/Makefile b/drivers/iio/time/Makefile
new file mode 100644
index 000000000000..3a27f3557d1e
--- /dev/null
+++ b/drivers/iio/time/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O Time drivers
+#
+
+obj-$(CONFIG_CAPTURE_TIECAP) += capture-tiecap.o
diff --git a/drivers/iio/time/capture-tiecap.c b/drivers/iio/time/capture-tiecap.c
new file mode 100644
index 000000000000..305011836ef3
--- /dev/null
+++ b/drivers/iio/time/capture-tiecap.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ECAP Capture driver
+ *
+ * Copyright (C) 2022 Julien Panis <jpanis@baylibre.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_device.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+
+/* Registers */
+#define ECAP_NB_CAP			4
+
+#define ECAP_TSCNT_REG			0x00
+
+#define ECAP_CAP_REG(i)		(((i) << 2) + 0x08)
+
+#define ECAP_ECCTL_REG			0x28
+#define ECAP_CAPPOL_BIT(i)		BIT((i) << 1)
+#define ECAP_EV_MODE_MASK		GENMASK(7, 0)
+#define ECAP_CAPLDEN_BIT		BIT(8)
+#define ECAP_EVTFLTPS_MASK		GENMASK(13, 9)
+#define ECAP_PS_DEFAULT_VAL		0
+#define ECAP_PS_MAX_VAL		31
+#define ECAP_CONT_ONESHT_BIT		BIT(16)
+#define ECAP_STOPVALUE_MASK		GENMASK(18, 17)
+#define ECAP_REARM_RESET_BIT		BIT(19)
+#define ECAP_TSCNTSTP_BIT		BIT(20)
+#define ECAP_SYNCO_DIS_MASK		GENMASK(23, 22)
+#define ECAP_CAP_APWM_BIT		BIT(25)
+#define ECAP_ECCTL_EN_MASK		(ECAP_CAPLDEN_BIT | ECAP_TSCNTSTP_BIT)
+#define ECAP_ECCTL_CFG_MASK		(ECAP_EVTFLTPS_MASK | ECAP_SYNCO_DIS_MASK	\
+					| ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK	\
+					| ECAP_CAP_APWM_BIT | ECAP_CONT_ONESHT_BIT	\
+					| ECAP_REARM_RESET_BIT)
+
+#define ECAP_ECINT_EN_FLG_REG		0x2c
+#define ECAP_NB_CEVT			(ECAP_NB_CAP + 1)
+#define ECAP_CEVT_EN_MASK		GENMASK(ECAP_NB_CEVT, 1)
+#define ECAP_CEVT_FLG_BIT(i)		BIT((i) + 17)
+#define ECAP_OVF_VAL			0xff
+
+#define ECAP_ECINT_CLR_FRC_REG	0x30
+#define ECAP_INT_CLR_BIT		BIT(0)
+#define ECAP_CEVT_CLR_BIT(i)		BIT((i) + 1)
+#define ECAP_CEVT_CLR_MASK		GENMASK(ECAP_NB_CEVT, 0)
+
+#define ECAP_PID_REG			0x5c
+
+/*
+ * Event modes
+ * One bit for each CAPx register : 1 = falling edge / 0 = rising edge
+ * e.g. mode = 13 = 0xd = 0b1101
+ * -> falling edge for CAP1-3-4 / rising edge for CAP2
+ */
+#define ECAP_NB_EV_MODES		GENMASK(ECAP_NB_CAP - 1, 0)
+#define ECAP_EV_MODE_BIT(i)		BIT(i)
+
+static unsigned int prescaler = ECAP_PS_DEFAULT_VAL;
+module_param(prescaler, uint, 0644);
+MODULE_PARM_DESC(prescaler, "Input capture signal prescaler from 0 to "
+		 __MODULE_STRING(ECAP_PS_MAX_VAL)", default "
+		 __MODULE_STRING(ECAP_PS_DEFAULT_VAL));
+
+static const struct regmap_config ecap_iio_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = ECAP_PID_REG,
+};
+
+/*
+ * struct ecap_iio_context - IIO device context
+ * @ev_mode:   event mode describing falling/rising edges for captures 1 to 4
+ * @time_cntr: timestamp counter value
+ */
+struct ecap_iio_context {
+	u8 ev_mode;
+	unsigned int time_cntr;
+};
+
+/*
+ * struct ecap_iio_data - IIO device data
+ * @ev_idx:  event index (0 to 3 for CAP1 to CAP4)
+ * @ev_time: falling/rising edge timestamp
+ */
+struct ecap_iio_data {
+	u8 ev_idx;
+	s64 ev_time __aligned(sizeof(s64));
+};
+
+/*
+ * struct ecap_iio_dev - IIO device private data structure
+ * @enabled:  device state
+ * @clk:      device clock
+ * @clk_rate: device clock rate
+ * @regmap:   device register map
+ * @pm_ctx:   device context for PM operations
+ * @data:     device data
+ */
+struct ecap_iio_dev {
+	bool enabled;
+	struct clk *clk;
+	unsigned long clk_rate;
+	struct regmap *regmap;
+	struct ecap_iio_context pm_ctx;
+	struct ecap_iio_data data;
+};
+
+static u8 ecap_iio_capture_get_evmode(struct iio_dev *indio_dev)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	u8 ev_mode = 0;
+	unsigned int regval;
+	int i;
+
+	pm_runtime_get_sync(indio_dev->dev.parent);
+	regmap_read(ecap_dev->regmap, ECAP_ECCTL_REG, &regval);
+	pm_runtime_put_sync(indio_dev->dev.parent);
+
+	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
+		if (regval & ECAP_CAPPOL_BIT(i))
+			ev_mode |= ECAP_EV_MODE_BIT(i);
+	}
+
+	return ev_mode;
+}
+
+static void ecap_iio_capture_set_evmode(struct iio_dev *indio_dev, u8 ev_mode)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	unsigned int regval = 0;
+	int i;
+
+	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
+		if (ev_mode & ECAP_EV_MODE_BIT(i))
+			regval |= ECAP_CAPPOL_BIT(i);
+	}
+
+	pm_runtime_get_sync(indio_dev->dev.parent);
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_EV_MODE_MASK, regval);
+	pm_runtime_put_sync(indio_dev->dev.parent);
+}
+
+static void ecap_iio_capture_enable(struct iio_dev *indio_dev, bool rearm)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	unsigned int regval = 0;
+
+	pm_runtime_get_sync(indio_dev->dev.parent);
+
+	/* Enable interrupts on events */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
+			   ECAP_CEVT_EN_MASK, ECAP_CEVT_EN_MASK);
+
+	/* Run counter */
+	regval |= FIELD_PREP(ECAP_EVTFLTPS_MASK, prescaler)
+		| ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK;
+	if (rearm) {
+		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, 0);
+		regval |= ECAP_REARM_RESET_BIT;
+	}
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MASK, regval);
+}
+
+static void ecap_iio_capture_disable(struct iio_dev *indio_dev)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	/* Disable interrupts on events */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_CEVT_EN_MASK, 0);
+
+	/* Stop counter */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK, 0);
+
+	pm_runtime_put_sync(indio_dev->dev.parent);
+}
+
+static int ecap_iio_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long info)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_ENABLE:
+		*val = ecap_dev->enabled;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ecap_iio_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long info)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_ENABLE:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+		if (val == ecap_dev->enabled)
+			return 0;
+		if (val)
+			ecap_iio_capture_enable(indio_dev, true);
+		else
+			ecap_iio_capture_disable(indio_dev);
+		ecap_dev->enabled = val;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ecap_iio_read_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int *val, int *val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_FALLING:
+			*val = ecap_iio_capture_get_evmode(indio_dev);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ecap_iio_write_event_value(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      enum iio_event_info info,
+				      int val, int val2)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_FALLING:
+			if (val < 0 || val > ECAP_NB_EV_MODES)
+				return -EINVAL;
+			if (ecap_dev->enabled)
+				return -EBUSY;
+			ecap_iio_capture_set_evmode(indio_dev, val);
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ecap_iio_info = {
+	.read_raw = ecap_iio_read_raw,
+	.write_raw = ecap_iio_write_raw,
+	.read_event_value = ecap_iio_read_event_value,
+	.write_event_value = ecap_iio_write_event_value,
+};
+
+static const struct iio_event_spec ecap_iio_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_chan_spec ecap_iio_channels[] = {
+	{
+		.scan_index = 0,
+		.type = IIO_INDEX,
+		.address = 0,
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_ENABLE),
+		.modified = 0,
+		.event_spec = ecap_iio_events,
+		.num_event_specs = ARRAY_SIZE(ecap_iio_events),
+		.scan_type = {
+			.sign = 'u',
+			.endianness = IIO_LE,
+			.realbits = 2,
+			.storagebits = 8,
+			.shift = 0,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static irqreturn_t ecap_iio_isr(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	struct ecap_iio_data *ecap_data = &ecap_dev->data;
+	unsigned int clr = 0;
+	unsigned int flg;
+	unsigned int cap_time;
+	int i;
+
+	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
+
+	for (i = 0 ; i < ECAP_NB_CEVT ; i++) {
+		if (flg & ECAP_CEVT_FLG_BIT(i)) {
+			if (i < ECAP_NB_CAP) {
+				/*
+				 * Input signal edge detected
+				 * time_ns = 10^9 * time_cycles / clk_rate
+				 */
+				ecap_data->ev_idx = i;
+				regmap_read(ecap_dev->regmap, ECAP_CAP_REG(i), &cap_time);
+				ecap_data->ev_time = cap_time * NSEC_PER_SEC;
+				do_div(ecap_data->ev_time, ecap_dev->clk_rate);
+			} else {
+				/* Counter overflow */
+				ecap_data->ev_idx = ECAP_OVF_VAL;
+				ecap_data->ev_time = 0;
+			}
+			iio_push_to_buffers(indio_dev, ecap_data);
+
+			clr |= ECAP_CEVT_CLR_BIT(i);
+		}
+	}
+
+	clr |= ECAP_INT_CLR_BIT;
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_CLR_FRC_REG, ECAP_CEVT_CLR_MASK, clr);
+
+	return IRQ_HANDLED;
+}
+
+static void ecap_iio_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static int ecap_iio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ecap_iio_dev *ecap_dev;
+	struct iio_dev *indio_dev;
+	void __iomem *mmio_base;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ecap_dev));
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
+
+	ecap_dev = iio_priv(indio_dev);
+
+	ecap_dev->clk = devm_clk_get(dev, "fck");
+	if (IS_ERR(ecap_dev->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(ecap_dev->clk);
+	}
+
+	ret = clk_prepare_enable(ecap_dev->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ecap_iio_clk_disable, ecap_dev->clk);
+	if (ret) {
+		dev_err(dev, "failed to add clock disable action\n");
+		return ret;
+	}
+
+	ecap_dev->clk_rate = clk_get_rate(ecap_dev->clk);
+	if (!ecap_dev->clk_rate) {
+		dev_err(dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	if (prescaler > ECAP_PS_MAX_VAL) {
+		prescaler = ECAP_PS_MAX_VAL;
+		dev_warn(dev, "prescaler out of range, forced to %d\n", prescaler);
+	}
+
+	mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio_base))
+		return PTR_ERR(mmio_base);
+
+	ecap_dev->regmap = regmap_init_mmio(dev, mmio_base, &ecap_iio_regmap_config);
+	if (IS_ERR(ecap_dev->regmap)) {
+		dev_err(dev, "failed to init regmap\n");
+		return PTR_ERR(ecap_dev->regmap);
+	}
+
+	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL,
+					 "ecap-iio-%p", mmio_base);
+	indio_dev->info = &ecap_iio_info;
+	indio_dev->channels = ecap_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ecap_iio_channels);
+	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+
+	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, NULL, NULL);
+	if (ret) {
+		dev_err(dev, "failed to setup iio buffer\n");
+		return ret;
+	}
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to get irq\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(dev, ret, ecap_iio_isr, 0, pdev->name, indio_dev);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ecap_dev->enabled = 0;
+	ecap_iio_capture_set_evmode(indio_dev, 0);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ecap_iio_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	if (ecap_dev->enabled)
+		ecap_iio_capture_disable(indio_dev);
+
+	regmap_exit(ecap_dev->regmap);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static __maybe_unused int ecap_iio_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	/* If eCAP is running, stop capture then save timestamp counter */
+	if (ecap_dev->enabled) {
+		ecap_iio_capture_disable(indio_dev);
+
+		pm_runtime_get_sync(indio_dev->dev.parent);
+		regmap_read(ecap_dev->regmap, ECAP_TSCNT_REG, &ecap_dev->pm_ctx.time_cntr);
+		pm_runtime_put_sync(indio_dev->dev.parent);
+	}
+
+	ecap_dev->pm_ctx.ev_mode = ecap_iio_capture_get_evmode(indio_dev);
+
+	return 0;
+}
+
+static __maybe_unused int ecap_iio_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	ecap_iio_capture_set_evmode(indio_dev, ecap_dev->pm_ctx.ev_mode);
+
+	/* If eCAP was running, restore timestamp counter then run capture */
+	if (ecap_dev->enabled) {
+		pm_runtime_get_sync(indio_dev->dev.parent);
+		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, ecap_dev->pm_ctx.time_cntr);
+		pm_runtime_put_sync(indio_dev->dev.parent);
+
+		ecap_iio_capture_enable(indio_dev, false);
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ecap_iio_pm_ops, ecap_iio_suspend, ecap_iio_resume);
+
+static const struct of_device_id ecap_iio_of_match[] = {
+	{ .compatible	= "ti,am62-ecap-capture" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ecap_iio_of_match);
+
+static struct platform_driver ecap_iio_driver = {
+	.probe = ecap_iio_probe,
+	.remove = ecap_iio_remove,
+	.driver = {
+		.name = "ecap-capture",
+		.of_match_table = of_match_ptr(ecap_iio_of_match),
+		.pm = &ecap_iio_pm_ops,
+	},
+};
+module_platform_driver(ecap_iio_driver);
+
+MODULE_DESCRIPTION("ECAP Capture driver");
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

