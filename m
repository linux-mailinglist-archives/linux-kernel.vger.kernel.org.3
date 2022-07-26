Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0411F580DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiGZHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiGZH3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:29:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE12C645
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:26:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso359356wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrsMTaCyo0zfll7tRiDPkvAV1op6TzjuN+fdE5s9Fbg=;
        b=XMzkAdf6riWY+4YytqaZXu9w5siuko3IV3sLvTHIibdT2e2uPQtuWuZnMvRRrkAsFj
         HVPyfdGW8YcvEsWSAuPLCnFv3LpXpS1S2j8w+IMXOYmWK5guSZv8js5JUMxXHffV6Pmf
         p+jkAWaiFmJ80psSh6Z60+Ty3eN/d17fJxax6InfdGZeaVnMCpvtxdlB/7Qe5HA2vLV6
         aMyQCMBImULB6bCUzU761Y0JS7MaKnc9w4i2jZg3kXp33eX6ENyXCxpvt7W66IWMCzdX
         +2qpLGllXuFrJHr+eFsKGijeBG19Meam1fHmkxyBv+qvN8RBRbI5GXkng1jETeAW4h1L
         zkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrsMTaCyo0zfll7tRiDPkvAV1op6TzjuN+fdE5s9Fbg=;
        b=t1sLbyO49nXmeb7cZOH0ahZzWG82JZkgUHdNVJgzct8FToEzgfJz0E7ZHHV5m/FMyW
         9VhNk6soXd+hqbh+wyiUpxvIlgQP3e4MGzzZxUKK6nMaTpvlmxwRikA3iWuaj+XEDOAQ
         6zYyWqQXkuc3dmznoqW5pV0U/ZEL8NLIyHrXKuyacyq9zcQbWcuNve28pCXlyoVnw/SG
         H8ZyvF9y+6DKdZFbTacuvjN3hdkpR6C3xYDsCN8QYR7hTV4zxTypDiFCm73N5VyLw+Ew
         rMBcMVs5V236+LMHlrU1Ac1mCp6jNlG+uD1PKufR+n5rGGsBwIQgJSwQ455j7nhUp4q6
         Z8VA==
X-Gm-Message-State: AJIora+ZhTPIGH4VfTmry5MPoqtL5yO6qoLZdP4gkl7gN4kBbMB55otg
        A6duG0g4uFHpfVpCvn+vIOArwXgZz2SdcA==
X-Google-Smtp-Source: AGRyM1v0+3kwPBWzM4S7JLoHZly/gwheDod0PM40ViipBUNJj8crDe7gjW78Vst6M787OaluU5djKg==
X-Received: by 2002:a05:600c:19d2:b0:3a3:3aca:a83d with SMTP id u18-20020a05600c19d200b003a33acaa83dmr11612709wmq.88.1658820369877;
        Tue, 26 Jul 2022 00:26:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:77d:8cd7:621a:855b:69ac:c34a])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b0021b956da1dcsm9007835wrv.113.2022.07.26.00.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 00:26:09 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v1 1/2] iio: time: capture-tiecap: capture driver support for ECAP
Date:   Tue, 26 Jul 2022 09:25:52 +0200
Message-Id: <20220726072553.5136-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726072553.5136-1-jpanis@baylibre.com>
References: <20220726072553.5136-1-jpanis@baylibre.com>
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
 drivers/iio/time/capture-tiecap.c | 532 ++++++++++++++++++++++++++++++
 5 files changed, 562 insertions(+)
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
index 000000000000..fff846ca431a
--- /dev/null
+++ b/drivers/iio/time/capture-tiecap.c
@@ -0,0 +1,532 @@
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
+#include <linux/interrupt.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+
+/* Registers */
+#define TSCNT_REG		0x00
+
+#define NB_CAP			4
+#define CAP_REG(i)		(((i) << 2) + 0x08)
+
+#define ECCTL_REG		0x28
+#define CAPPOL_BIT(i)		BIT((i) << 1)
+#define CAPLDEN_BIT		BIT(8)
+#define EVTFLTPS_MASK		GENMASK(13, 9)
+#define PS_DEFAULT_VAL		0
+#define PS_MAX_VAL		31
+#define CONT_ONESHT_BIT	BIT(16)
+#define STOPVALUE_MASK		GENMASK(18, 17)
+#define REARM_RESET_BIT	BIT(19)
+#define TSCNTSTP_BIT		BIT(20)
+#define SYNCO_DIS_MASK		GENMASK(23, 22)
+#define CAP_APWM_BIT		BIT(25)
+
+#define ECINT_EN_FLG_REG	0x2c
+#define NB_CEVT		(NB_CAP + 1)
+#define CEVT_EN_MASK		GENMASK(NB_CEVT, 1)
+#define CEVT_FLG_BIT(i)	BIT((i) + 17)
+#define OVF_VAL		0xff
+
+#define ECINT_CLR_FRC_REG	0x30
+#define INT_CLR_BIT		BIT(0)
+#define CEVT_CLR_BIT(i)	BIT((i) + 1)
+
+/*
+ * Event modes
+ * One bit for each CAPx register : 1 = falling edge / 0 = rising edge
+ * e.g. mode = 13 = 0xd = 0b1101
+ * -> falling edge for CAP1-3-4 / rising edge for CAP2
+ */
+#define NB_EV_MODES		GENMASK(NB_CAP - 1, 0)
+#define EV_MODE_BIT(i)		BIT(i)
+
+/* IIO channels */
+static const struct iio_event_spec ecap_iio_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+#define IIO_CHAN_INDEX {					\
+	.scan_index = 0,					\
+	.type = IIO_INDEX,					\
+	.address = 0,						\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_ENABLE), \
+	.modified = 0,						\
+	.event_spec = ecap_iio_events,			\
+	.num_event_specs = ARRAY_SIZE(ecap_iio_events),	\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.endianness = IIO_LE,				\
+		.realbits = 2,					\
+		.storagebits = 8,				\
+		.shift = 0,					\
+	},							\
+}
+
+static unsigned int prescaler = PS_DEFAULT_VAL;
+module_param(prescaler, uint, 0644);
+MODULE_PARM_DESC(prescaler, "Input capture signal prescaler from 0 to "
+		 __MODULE_STRING(PS_MAX_VAL)", default "
+		 __MODULE_STRING(PS_DEFAULT_VAL));
+
+/*
+ * struct ecap_iio_context - IIO device context
+ * @enabled: device state
+ * @ev_mode: event mode describing falling/rising edges for captures 1 to 4
+ * @tscnt:   counter value
+ */
+struct ecap_iio_context {
+	u8 enabled;
+	u8 ev_mode;
+	u32 tscnt;
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
+ * @clk_rate:	device clock rate
+ * @lock:	synchronization lock to prevent I/O race conditions
+ * @mmio_base:	device base address
+ * @ctx:	device context for PM operations
+ * @data:	device data
+ */
+struct ecap_iio_dev {
+	unsigned int clk_rate;
+	spinlock_t lock;
+	void __iomem *mmio_base;
+	struct ecap_iio_context ctx;
+	struct ecap_iio_data data;
+};
+
+static inline u32 ecap_iio_read_reg(struct ecap_iio_dev *ecap_dev, int reg)
+{
+	return readl(ecap_dev->mmio_base + reg);
+}
+
+static inline void ecap_iio_write_reg(struct ecap_iio_dev *ecap_dev, int reg, u32 val)
+{
+	writel(val, ecap_dev->mmio_base + reg);
+}
+
+static void ecap_iio_capture_get_evmode(struct iio_dev *indio_dev, u8 *ev_mode)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	u32 regval;
+	int i;
+
+	pm_runtime_get_sync(indio_dev->dev.parent);
+	regval = ecap_iio_read_reg(ecap_dev, ECCTL_REG);
+	pm_runtime_put_sync(indio_dev->dev.parent);
+
+	for (i = 0 ; i < NB_CAP ; i++) {
+		if (regval & CAPPOL_BIT(i))
+			*ev_mode |= EV_MODE_BIT(i);
+		else
+			*ev_mode &= ~EV_MODE_BIT(i);
+	}
+}
+
+static void ecap_iio_capture_set_evmode(struct iio_dev *indio_dev, u8 ev_mode)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	u32 regval;
+	int i;
+
+	pm_runtime_get_sync(indio_dev->dev.parent);
+	regval = ecap_iio_read_reg(ecap_dev, ECCTL_REG);
+
+	for (i = 0 ; i < NB_CAP ; i++) {
+		if (ev_mode & EV_MODE_BIT(i))
+			regval |= CAPPOL_BIT(i);
+		else
+			regval &= ~CAPPOL_BIT(i);
+	}
+
+	ecap_iio_write_reg(ecap_dev, ECCTL_REG, regval);
+	pm_runtime_put_sync(indio_dev->dev.parent);
+}
+
+static void ecap_iio_capture_enable(struct iio_dev *indio_dev, bool rearm)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	u32 regval;
+
+	pm_runtime_get_sync(indio_dev->dev.parent);
+
+	/* Enable interrupts on events */
+	regval = ecap_iio_read_reg(ecap_dev, ECINT_EN_FLG_REG);
+	regval |= CEVT_EN_MASK;
+	ecap_iio_write_reg(ecap_dev, ECINT_EN_FLG_REG, regval);
+
+	/* Run counter */
+	regval = ecap_iio_read_reg(ecap_dev, ECCTL_REG);
+	regval &= ~(CAP_APWM_BIT | CONT_ONESHT_BIT);
+	regval |= FIELD_PREP(EVTFLTPS_MASK, prescaler)
+		| SYNCO_DIS_MASK | STOPVALUE_MASK
+		| CAPLDEN_BIT | TSCNTSTP_BIT;
+	if (rearm) {
+		ecap_iio_write_reg(ecap_dev, TSCNT_REG, 0);
+		regval |= REARM_RESET_BIT;
+	}
+	ecap_iio_write_reg(ecap_dev, ECCTL_REG, regval);
+}
+
+static void ecap_iio_capture_disable(struct iio_dev *indio_dev)
+{
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	u32 regval;
+	unsigned long lock_flags;
+
+	/* Disable interrupts on events */
+	spin_lock_irqsave(&ecap_dev->lock, lock_flags);
+	regval = ecap_iio_read_reg(ecap_dev, ECINT_EN_FLG_REG);
+	regval &= ~CEVT_EN_MASK;
+	ecap_iio_write_reg(ecap_dev, ECINT_EN_FLG_REG, regval);
+	spin_unlock_irqrestore(&ecap_dev->lock, lock_flags);
+
+	/* Stop counter */
+	regval = ecap_iio_read_reg(ecap_dev, ECCTL_REG);
+	regval &= ~(CAPLDEN_BIT | TSCNTSTP_BIT);
+	ecap_iio_write_reg(ecap_dev, ECCTL_REG, regval);
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
+		*val = ecap_dev->ctx.enabled;
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
+		if (val == ecap_dev->ctx.enabled)
+			return 0;
+		if (val)
+			ecap_iio_capture_enable(indio_dev, true);
+		else
+			ecap_iio_capture_disable(indio_dev);
+		ecap_dev->ctx.enabled = val;
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
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_FALLING:
+			ecap_iio_capture_get_evmode(indio_dev, &ecap_dev->ctx.ev_mode);
+			*val = ecap_dev->ctx.ev_mode;
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
+			if (val < 0 || val > NB_EV_MODES)
+				return -EINVAL;
+			if (ecap_dev->ctx.enabled)
+				return -EBUSY;
+			if (val == ecap_dev->ctx.ev_mode)
+				return 0;
+			ecap_dev->ctx.ev_mode = val;
+			ecap_iio_capture_set_evmode(indio_dev, ecap_dev->ctx.ev_mode);
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
+static const struct iio_chan_spec ecap_iio_channels[] = {
+	IIO_CHAN_INDEX,
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static irqreturn_t ecap_iio_isr(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+	struct ecap_iio_data *ecap_data = &ecap_dev->data;
+	u32 flg;
+	u32 clr;
+	int i;
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(&ecap_dev->lock, lock_flags);
+	flg = ecap_iio_read_reg(ecap_dev, ECINT_EN_FLG_REG);
+	clr = ecap_iio_read_reg(ecap_dev, ECINT_CLR_FRC_REG);
+
+	for (i = 0 ; i < NB_CEVT ; i++) {
+		if (flg & CEVT_FLG_BIT(i)) {
+			if (i < NB_CAP) {
+				/*
+				 * Input signal edge detected
+				 * time_ns = 10^9 * time_cycles / clk_rate
+				 */
+				ecap_data->ev_idx = i;
+				ecap_data->ev_time = ecap_iio_read_reg(ecap_dev, CAP_REG(i));
+				ecap_data->ev_time *= NSEC_PER_SEC;
+				do_div(ecap_data->ev_time, ecap_dev->clk_rate);
+			} else {
+				/* Counter overflow */
+				ecap_data->ev_idx = OVF_VAL;
+				ecap_data->ev_time = 0;
+			}
+			iio_push_to_buffers(indio_dev, ecap_data);
+
+			clr |= CEVT_CLR_BIT(i);
+		}
+	}
+
+	clr |= INT_CLR_BIT;
+	ecap_iio_write_reg(ecap_dev, ECINT_CLR_FRC_REG, clr);
+	spin_unlock_irqrestore(&ecap_dev->lock, lock_flags);
+
+	return IRQ_HANDLED;
+}
+
+static int ecap_iio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ecap_iio_dev *ecap_dev;
+	struct iio_dev *indio_dev;
+	struct clk *clk;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ecap_dev));
+	if (IS_ERR(indio_dev)) {
+		dev_err(dev, "failed to allocate memory for iio device\n");
+		return PTR_ERR(indio_dev);
+	}
+
+	ecap_dev = iio_priv(indio_dev);
+
+	clk = devm_clk_get(dev, "fck");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(clk);
+	}
+
+	ecap_dev->clk_rate = clk_get_rate(clk);
+	if (!ecap_dev->clk_rate) {
+		dev_err(dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	if (prescaler > PS_MAX_VAL) {
+		prescaler = PS_MAX_VAL;
+		dev_warn(dev, "prescaler out of range, forced to %d\n", PS_MAX_VAL);
+	}
+
+	spin_lock_init(&ecap_dev->lock);
+
+	ecap_dev->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ecap_dev->mmio_base)) {
+		dev_err(dev, "failed to remap io\n");
+		return PTR_ERR(ecap_dev->mmio_base);
+	}
+
+	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL,
+					 "ecap-iio-%p", ecap_dev->mmio_base);
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
+	/* Configure HW */
+	ecap_dev->ctx.enabled = 0;
+	ecap_dev->ctx.ev_mode = 0;
+	ecap_iio_capture_set_evmode(indio_dev, ecap_dev->ctx.ev_mode);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ecap_iio_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	/* Disable explicitly if eCAP is running */
+	if (ecap_dev->ctx.enabled)
+		ecap_iio_capture_disable(indio_dev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static __maybe_unused void ecap_iio_save_context(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	pm_runtime_get_sync(dev);
+	ecap_iio_capture_get_evmode(indio_dev, &ecap_dev->ctx.ev_mode);
+	ecap_dev->ctx.tscnt = ecap_iio_read_reg(ecap_dev, TSCNT_REG);
+	pm_runtime_put_sync(dev);
+}
+
+static __maybe_unused void ecap_iio_restore_context(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	pm_runtime_get_sync(dev);
+	ecap_iio_capture_set_evmode(indio_dev, ecap_dev->ctx.ev_mode);
+	ecap_iio_write_reg(ecap_dev, TSCNT_REG, ecap_dev->ctx.tscnt);
+	pm_runtime_put_sync(dev);
+}
+
+static __maybe_unused int ecap_iio_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	ecap_iio_save_context(dev);
+
+	/* Disable explicitly if eCAP is running */
+	if (ecap_dev->ctx.enabled)
+		ecap_iio_capture_disable(indio_dev);
+
+	return 0;
+}
+
+static __maybe_unused int ecap_iio_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
+
+	ecap_iio_restore_context(dev);
+
+	/* Enable explicitly if eCAP was running */
+	if (ecap_dev->ctx.enabled)
+		ecap_iio_capture_enable(indio_dev, false);
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

