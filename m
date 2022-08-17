Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293335970C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiHQOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiHQOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:16:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27795F9BB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:16:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso1013087wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3OHZoQAWriB0EYCBRV+lZ+7h9MLE8qNIp+Fsdg0OJk4=;
        b=vwPmRRvl9TW4P+CpmKNlG5J677BN+gOy4339Wgp9XgFGI9CXrl1YUqc+wKl9USr/OK
         vMseQcS/0DYyQcAS357eDZXphcTcpUGUiuYW2vRMI/m0cP72pRRRRzafMUKCcAJRHK/V
         8iRPstqDktcE1tx4iEKqfr8Z9xuJsrDb9n1SmkC5YlbvP+1cBiBCiGVVBhGh1MyP9jgS
         ZGaZhMeE4ZlY4AKp92XZXzeuK5L2801CBTOs6Kf0MhTIHWXYOG/uUJD6BVqXHIYqSlwH
         9mTWmExvZHEYWFgiOADsZ3kHN3ooks59uqkNZB/IxVsOEBO/h0xajhy1X25sEOIgzXOk
         HDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3OHZoQAWriB0EYCBRV+lZ+7h9MLE8qNIp+Fsdg0OJk4=;
        b=ofLPZ8mYp2HJBMTs4NMbhyzJ571m4Ak9K2C5Pn8U/6EwKpfEDq84UILoX72iLwiIQD
         IARq8O6/MDRxRH+gVcdX2cXAYUvufLrfOpiyo0MgPSNX5R2nk6wVemDFxXAc/KuF4wCk
         oGL0MZFoKPVjRzH1SBL1V1NuQl8EEK4PiCevwrZoWBWfjMc1vJ3PybD0usgG5s3OiTmW
         frrQIhHWnjFQtb1QpzGgUwLAz0HoiR7P1fIYhR8cUUENrj3MjDrBHlCJmdmwHby98p7K
         H26dDFQhsfgY7xeS6Ku+smZbOWVnmAic3oeaNHvkfwpdbwnrWza11F/k/0vmSvm1cFsB
         LoSQ==
X-Gm-Message-State: ACgBeo2GutXewv1vEUZlUqeIMrVG51cm0CvL2xpMxP1razJW7qzi1j8e
        OWRRU8kbZRRRUCIWoX311tO9QzWKDAlqeQ==
X-Google-Smtp-Source: AA6agR6GGZhpS+UhHy1CIghQQ8FI65FPMIEY3Jg88sr6MepDNtiQ4KxG2JVUZIFI7xfLr/A6pLuRCg==
X-Received: by 2002:a1c:f209:0:b0:3a4:f42c:9ffb with SMTP id s9-20020a1cf209000000b003a4f42c9ffbmr2344739wmc.62.1660745794959;
        Wed, 17 Aug 2022 07:16:34 -0700 (PDT)
Received: from localhost.localdomain (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b003a5f3de6fddsm2416533wms.25.2022.08.17.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:16:34 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v5 3/3] counter: ti-ecap-capture: capture driver support for ECAP
Date:   Wed, 17 Aug 2022 16:16:20 +0200
Message-Id: <20220817141620.256481-4-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817141620.256481-1-jpanis@baylibre.com>
References: <20220817141620.256481-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECAP hardware on TI AM62x SoC supports capture feature. It can be used
to timestamp events (falling/rising edges) detected on signal input pin.

This commit adds capture driver support for ECAP hardware on AM62x SoC.

In the ECAP hardware, capture pin can also be configured to be in
PWM mode. Current implementation only supports capture operating mode.
Hardware also supports timebase sync between multiple instances, but
this driver supports simple independent capture functionality.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/counter/Kconfig           |  15 +
 drivers/counter/Makefile          |   1 +
 drivers/counter/ti-ecap-capture.c | 624 ++++++++++++++++++++++++++++++
 include/uapi/linux/counter.h      |   2 +
 4 files changed, 642 insertions(+)
 create mode 100644 drivers/counter/ti-ecap-capture.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 5edd155f1911..08235268af0b 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -101,4 +101,19 @@ config INTEL_QEP
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-qep.
 
+config TI_ECAP_CAPTURE
+	tristate "TI eCAP capture driver"
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
+	help
+	  Select this option to enable the Texas Instruments Enhanced Capture
+	  (eCAP) driver in input mode.
+
+	  It can be used to timestamp events (falling/rising edges) detected
+	  on signal input pin.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ti-ecap-capture.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 8fde6c100ebc..b9a369e0d4fc 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
 obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
 obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
+obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
new file mode 100644
index 000000000000..b00ddf122bbd
--- /dev/null
+++ b/drivers/counter/ti-ecap-capture.c
@@ -0,0 +1,624 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ECAP Capture driver
+ *
+ * Copyright (C) 2022 Julien Panis <jpanis@baylibre.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/clk.h>
+#include <linux/counter.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define ECAP_DRV_NAME "ecap"
+
+/* ECAP event IDs */
+enum ecap_event_id {
+	/* Capture events */
+	ECAP_CEVT1,
+	ECAP_CEVT2,
+	ECAP_CEVT3,
+	ECAP_CEVT4,
+	/* Counter overflow event */
+	ECAP_CNTOVF,
+	/* Helpers for capture events */
+	ECAP_CEVT_LAST = ECAP_CEVT4,
+	ECAP_NB_CEVT = ECAP_CEVT_LAST + 1,
+	/* Helpers for all events */
+	ECAP_EVT_LAST = ECAP_CNTOVF,
+	ECAP_NB_EVT = ECAP_EVT_LAST + 1,
+};
+
+/* Registers */
+#define ECAP_NB_CAP			ECAP_NB_CEVT
+
+#define ECAP_TSCNT_REG			0x00
+
+#define ECAP_CAP_REG(i)		(((i) << 2) + 0x08)
+
+#define ECAP_ECCTL_REG			0x28
+#define ECAP_CAPPOL_BIT(i)		BIT((i) << 1)
+#define ECAP_EV_MODE_MASK		GENMASK(7, 0)
+#define ECAP_CAPLDEN_BIT		BIT(8)
+#define ECAP_CONT_ONESHT_BIT		BIT(16)
+#define ECAP_STOPVALUE_MASK		GENMASK(18, 17)
+#define ECAP_REARM_RESET_BIT		BIT(19)
+#define ECAP_TSCNTSTP_BIT		BIT(20)
+#define ECAP_SYNCO_DIS_MASK		GENMASK(23, 22)
+#define ECAP_CAP_APWM_BIT		BIT(25)
+#define ECAP_ECCTL_EN_MASK		(ECAP_CAPLDEN_BIT | ECAP_TSCNTSTP_BIT)
+#define ECAP_ECCTL_CFG_MASK		(ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK	\
+					| ECAP_ECCTL_EN_MASK | ECAP_REARM_RESET_BIT	\
+					| ECAP_CAP_APWM_BIT | ECAP_CONT_ONESHT_BIT)
+
+#define ECAP_ECINT_EN_FLG_REG		0x2c
+#define ECAP_EVT_EN_MASK		GENMASK(ECAP_NB_EVT, ECAP_NB_CEVT)
+#define ECAP_EVT_FLG_BIT(i)		BIT((i) + 17)
+
+#define ECAP_ECINT_CLR_FRC_REG	0x30
+#define ECAP_INT_CLR_BIT		BIT(0)
+#define ECAP_EVT_CLR_BIT(i)		BIT((i) + 1)
+#define ECAP_EVT_CLR_MASK		GENMASK(ECAP_NB_EVT, 0)
+
+#define ECAP_PID_REG			0x5c
+
+/*
+ * Event modes
+ * One bit for each CAPx register : 1 = falling edge / 0 = rising edge
+ * e.g. mode = 13 = 0xd = 0b1101
+ * -> falling edge for CAP1-3-4 / rising edge for CAP2
+ */
+#define ECAP_EV_MODE_BIT(i)		BIT(i)
+
+/* ECAP signals */
+#define ECAP_INPUT_SIG 0
+#define ECAP_CLOCK_SIG 1
+
+#define ECAP_CHAN 0
+
+static const struct regmap_config ecap_cnt_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = ECAP_PID_REG,
+};
+
+/**
+ * struct ecap_cnt_dev - device private data structure
+ * @enabled:  device state
+ * @clk:      device clock
+ * @clk_rate: device clock rate
+ * @regmap:   device register map
+ * @nb_ovf:   number of overflows since capture start
+ * @pm_ctx:   device context for PM operations
+ */
+struct ecap_cnt_dev {
+	bool enabled;
+	struct clk *clk;
+	unsigned long clk_rate;
+	struct regmap *regmap;
+	atomic_t nb_ovf;
+	struct {
+		u8 ev_mode;
+		unsigned int time_cntr;
+	} pm_ctx;
+};
+
+static u8 ecap_cnt_capture_get_evmode(struct counter_device *counter)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+	u8 ev_mode = 0;
+	unsigned int regval;
+	int i;
+
+	pm_runtime_get_sync(counter->parent);
+	regmap_read(ecap_dev->regmap, ECAP_ECCTL_REG, &regval);
+	pm_runtime_put_sync(counter->parent);
+
+	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
+		if (regval & ECAP_CAPPOL_BIT(i))
+			ev_mode |= ECAP_EV_MODE_BIT(i);
+	}
+
+	return ev_mode;
+}
+
+static void ecap_cnt_capture_set_evmode(struct counter_device *counter, u8 ev_mode)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+	unsigned int regval = 0;
+	int i;
+
+	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
+		if (ev_mode & ECAP_EV_MODE_BIT(i))
+			regval |= ECAP_CAPPOL_BIT(i);
+	}
+
+	pm_runtime_get_sync(counter->parent);
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_EV_MODE_MASK, regval);
+	pm_runtime_put_sync(counter->parent);
+}
+
+static void ecap_cnt_capture_enable(struct counter_device *counter, bool rearm)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+	unsigned int regval;
+
+	pm_runtime_get_sync(counter->parent);
+
+	/* Enable interrupts on events */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
+			   ECAP_EVT_EN_MASK, ECAP_EVT_EN_MASK);
+
+	/* Run counter */
+	regval = ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK;
+	if (rearm) {
+		atomic_set(&ecap_dev->nb_ovf, 0);
+		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, 0);
+		regval |= ECAP_REARM_RESET_BIT;
+	}
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MASK, regval);
+}
+
+static void ecap_cnt_capture_disable(struct counter_device *counter)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	/* Disable interrupts on events */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_EVT_EN_MASK, 0);
+
+	/* Stop counter */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK, 0);
+
+	pm_runtime_put_sync(counter->parent);
+}
+
+static int ecap_cnt_count_get_val(struct counter_device *counter, unsigned int reg, u64 *val)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+	unsigned int regval;
+
+	pm_runtime_get_sync(counter->parent);
+	regmap_read(ecap_dev->regmap, reg, &regval);
+	pm_runtime_put_sync(counter->parent);
+
+	*val = regval;
+
+	return 0;
+}
+
+static inline int ecap_cnt_count_read(struct counter_device *counter,
+				      struct counter_count *count,
+				      u64 *val)
+{
+	return ecap_cnt_count_get_val(counter, ECAP_TSCNT_REG, val);
+}
+
+static int ecap_cnt_function_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  enum counter_function *function)
+{
+	*function = COUNTER_FUNCTION_INCREASE;
+
+	return 0;
+}
+
+static int ecap_cnt_action_read(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_synapse *synapse,
+				enum counter_synapse_action *action)
+{
+	*action = COUNTER_SYNAPSE_ACTION_NONE;
+
+	return 0;
+}
+
+static int ecap_cnt_watch_validate(struct counter_device *counter,
+				   const struct counter_watch *watch)
+{
+	return (watch->channel == ECAP_CHAN &&
+		(watch->event == COUNTER_EVENT_CAPTURE ||
+		 watch->event == COUNTER_EVENT_OVERFLOW)) ? 0 : -EINVAL;
+}
+
+static int ecap_cnt_enable_read(struct counter_device *counter,
+				struct counter_count *count,
+				u8 *enable)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	*enable = ecap_dev->enabled;
+
+	return 0;
+}
+
+static int ecap_cnt_enable_write(struct counter_device *counter,
+				 struct counter_count *count,
+				 u8 enable)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	if (enable == ecap_dev->enabled)
+		return 0;
+	if (enable)
+		ecap_cnt_capture_enable(counter, true);
+	else
+		ecap_cnt_capture_disable(counter);
+	ecap_dev->enabled = enable;
+
+	return 0;
+}
+
+static int ecap_cnt_cap_get_pol(struct counter_device *counter,
+				struct counter_signal *signal,
+				u8 inst, u32 *pol)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	pm_runtime_get_sync(counter->parent);
+	*pol = regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(inst));
+	pm_runtime_put_sync(counter->parent);
+
+	return 0;
+}
+
+static int ecap_cnt_cap_set_pol(struct counter_device *counter,
+				struct counter_signal *signal,
+				u8 inst, u32 pol)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	if (ecap_dev->enabled)
+		return -EBUSY;
+	if (pol > 1)
+		return -EINVAL;
+
+	pm_runtime_get_sync(counter->parent);
+	if (pol)
+		regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(inst));
+	else
+		regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(inst));
+	pm_runtime_put_sync(counter->parent);
+
+	return 0;
+}
+
+static inline int ecap_cnt_cap_read(struct counter_device *counter,
+				    struct counter_count *count,
+				    u8 inst, u64 *cap)
+{
+	return ecap_cnt_count_get_val(counter, ECAP_CAP_REG(inst), cap);
+}
+
+#define ECAP_CAP_GET_POL(i) int ecap_cnt_cap##i##_get_pol(struct counter_device *counter,	\
+							    struct counter_signal *signal,	\
+							    u32 *pol)				\
+{												\
+	return ecap_cnt_cap_get_pol(counter, signal, (i) - 1, pol);				\
+}
+
+#define ECAP_CAP_SET_POL(i) int ecap_cnt_cap##i##_set_pol(struct counter_device *counter,	\
+							    struct counter_signal *signal,	\
+							    u32 pol)				\
+{												\
+	return ecap_cnt_cap_set_pol(counter, signal, (i) - 1, pol);				\
+}
+
+#define ECAP_CAP_READ(i) int ecap_cnt_cap##i##_read(struct counter_device *counter,		\
+						     struct counter_count *count,		\
+						     u64 *cap)					\
+{												\
+	return ecap_cnt_cap_read(counter, count, (i) - 1, cap);				\
+}
+
+static inline ECAP_CAP_GET_POL(1)
+static inline ECAP_CAP_GET_POL(2)
+static inline ECAP_CAP_GET_POL(3)
+static inline ECAP_CAP_GET_POL(4)
+static inline ECAP_CAP_SET_POL(1)
+static inline ECAP_CAP_SET_POL(2)
+static inline ECAP_CAP_SET_POL(3)
+static inline ECAP_CAP_SET_POL(4)
+static inline ECAP_CAP_READ(1)
+static inline ECAP_CAP_READ(2)
+static inline ECAP_CAP_READ(3)
+static inline ECAP_CAP_READ(4)
+
+static int ecap_cnt_count_cumul_read(struct counter_device *counter,
+				     struct counter_count *count, u64 *val)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	*val = ((u64)U32_MAX + 1) * atomic_read(&ecap_dev->nb_ovf);
+
+	return 0;
+}
+
+static int ecap_cnt_clk_get_freq(struct counter_device *counter,
+				 struct counter_signal *signal, u64 *freq)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	*freq = ecap_dev->clk_rate;
+
+	return 0;
+}
+
+static const struct counter_ops ecap_cnt_ops = {
+	.count_read = ecap_cnt_count_read,
+	.function_read = ecap_cnt_function_read,
+	.action_read = ecap_cnt_action_read,
+	.watch_validate = ecap_cnt_watch_validate,
+};
+
+static const enum counter_function ecap_cnt_functions[] = {
+	COUNTER_FUNCTION_INCREASE,
+};
+
+static const enum counter_synapse_action ecap_cnt_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
+static const char *const ecap_cnt_cap_polarities[] = {
+	"rising edge",
+	"falling edge",
+};
+
+static DEFINE_COUNTER_ENUM(ecap_cnt_cap_avail_pol, ecap_cnt_cap_polarities);
+
+static struct counter_comp ecap_cnt_signal_ext[] = {
+	COUNTER_COMP_SIGNAL_ENUM("polarity1", ecap_cnt_cap1_get_pol,
+				 ecap_cnt_cap1_set_pol, ecap_cnt_cap_avail_pol),
+	COUNTER_COMP_SIGNAL_ENUM("polarity2", ecap_cnt_cap2_get_pol,
+				 ecap_cnt_cap2_set_pol, ecap_cnt_cap_avail_pol),
+	COUNTER_COMP_SIGNAL_ENUM("polarity3", ecap_cnt_cap3_get_pol,
+				 ecap_cnt_cap3_set_pol, ecap_cnt_cap_avail_pol),
+	COUNTER_COMP_SIGNAL_ENUM("polarity4", ecap_cnt_cap4_get_pol,
+				 ecap_cnt_cap4_set_pol, ecap_cnt_cap_avail_pol),
+};
+
+static struct counter_comp ecap_cnt_clock_ext[] = {
+	COUNTER_COMP_SIGNAL_U64("frequency", ecap_cnt_clk_get_freq, NULL),
+};
+
+static struct counter_signal ecap_cnt_signals[] = {
+	{
+		.id = ECAP_INPUT_SIG,
+		.name = "ECAP Input Signal",
+		.ext = ecap_cnt_signal_ext,
+		.num_ext = ARRAY_SIZE(ecap_cnt_signal_ext),
+	},
+	{
+		.id = ECAP_CLOCK_SIG,
+		.name = "ECAP Clock Signal",
+		.ext = ecap_cnt_clock_ext,
+		.num_ext = ARRAY_SIZE(ecap_cnt_clock_ext),
+	},
+};
+
+static struct counter_synapse ecap_cnt_synapses[] = {
+	{
+		.actions_list = ecap_cnt_actions,
+		.num_actions = ARRAY_SIZE(ecap_cnt_actions),
+		.signal = &ecap_cnt_signals[ECAP_INPUT_SIG],
+	},
+	{
+		.actions_list = ecap_cnt_actions,
+		.num_actions = ARRAY_SIZE(ecap_cnt_actions),
+		.signal = &ecap_cnt_signals[ECAP_CLOCK_SIG],
+	},
+};
+
+static struct counter_comp ecap_cnt_count_ext[] = {
+	COUNTER_COMP_COUNT_U64("capture1", ecap_cnt_cap1_read, NULL),
+	COUNTER_COMP_COUNT_U64("capture2", ecap_cnt_cap2_read, NULL),
+	COUNTER_COMP_COUNT_U64("capture3", ecap_cnt_cap3_read, NULL),
+	COUNTER_COMP_COUNT_U64("capture4", ecap_cnt_cap4_read, NULL),
+	COUNTER_COMP_COUNT_U64("count_cumul", ecap_cnt_count_cumul_read, NULL),
+	COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),
+};
+
+static struct counter_count ecap_cnt_counts[] = {
+	{
+		.id = 0,
+		.name = "ECAP Timestamp Counter",
+		.functions_list = ecap_cnt_functions,
+		.num_functions = ARRAY_SIZE(ecap_cnt_functions),
+		.synapses = ecap_cnt_synapses,
+		.num_synapses = ARRAY_SIZE(ecap_cnt_synapses),
+		.ext = ecap_cnt_count_ext,
+		.num_ext = ARRAY_SIZE(ecap_cnt_count_ext),
+	},
+};
+
+static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
+{
+	struct counter_device *counter_dev = dev_id;
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+	unsigned int clr = 0;
+	unsigned int flg;
+	int i;
+
+	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
+
+	for (i = ECAP_CEVT_LAST ; i <= ECAP_EVT_LAST ; i++) {
+		if (flg & ECAP_EVT_FLG_BIT(i)) {
+			if (i != ECAP_CNTOVF) {
+				/* Input signal edge detected on last CAP (CAP4) */
+				counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, ECAP_CHAN);
+			} else {
+				/* Counter overflow */
+				counter_push_event(counter_dev, COUNTER_EVENT_OVERFLOW, ECAP_CHAN);
+				atomic_inc(&ecap_dev->nb_ovf);
+			}
+
+			clr |= ECAP_EVT_CLR_BIT(i);
+		}
+	}
+
+	clr |= ECAP_INT_CLR_BIT;
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_CLR_FRC_REG, ECAP_EVT_CLR_MASK, clr);
+
+	return IRQ_HANDLED;
+}
+
+static void ecap_cnt_pm_disable(void *dev)
+{
+	pm_runtime_disable(dev);
+}
+
+static int ecap_cnt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ecap_cnt_dev *ecap_dev;
+	struct counter_device *counter_dev;
+	void __iomem *mmio_base;
+	int ret;
+
+	counter_dev = devm_counter_alloc(dev, sizeof(*ecap_dev));
+	if (IS_ERR(counter_dev))
+		return PTR_ERR(counter_dev);
+
+	counter_dev->name = ECAP_DRV_NAME;
+	counter_dev->parent = dev;
+	counter_dev->ops = &ecap_cnt_ops;
+	counter_dev->signals = ecap_cnt_signals;
+	counter_dev->num_signals = ARRAY_SIZE(ecap_cnt_signals);
+	counter_dev->counts = ecap_cnt_counts;
+	counter_dev->num_counts = ARRAY_SIZE(ecap_cnt_counts);
+
+	ecap_dev = counter_priv(counter_dev);
+
+	ecap_dev->clk = devm_clk_get_enabled(dev, "fck");
+	if (IS_ERR(ecap_dev->clk))
+		return dev_err_probe(dev, PTR_ERR(ecap_dev->clk), "failed to get clock\n");
+
+	ecap_dev->clk_rate = clk_get_rate(ecap_dev->clk);
+	if (!ecap_dev->clk_rate) {
+		dev_err(dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio_base))
+		return PTR_ERR(mmio_base);
+
+	ecap_dev->regmap = devm_regmap_init_mmio(dev, mmio_base, &ecap_cnt_regmap_config);
+	if (IS_ERR(ecap_dev->regmap))
+		return dev_err_probe(dev, PTR_ERR(ecap_dev->regmap), "failed to init regmap\n");
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get irq\n");
+
+	ret = devm_request_irq(dev, ret, ecap_cnt_isr, 0, pdev->name, counter_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq\n");
+
+	platform_set_drvdata(pdev, counter_dev);
+
+	pm_runtime_enable(dev);
+
+	/* Register a cleanup callback to care for disabling PM */
+	ret = devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add pm disable action\n");
+
+	ecap_dev->enabled = 0;
+	ecap_cnt_capture_set_evmode(counter_dev, 0);
+
+	ret = devm_counter_add(dev, counter_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add counter\n");
+
+	return 0;
+}
+
+static int ecap_cnt_remove(struct platform_device *pdev)
+{
+	struct counter_device *counter_dev = platform_get_drvdata(pdev);
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+
+	if (ecap_dev->enabled)
+		ecap_cnt_capture_disable(counter_dev);
+
+	return 0;
+}
+
+static int ecap_cnt_suspend(struct device *dev)
+{
+	struct counter_device *counter_dev = dev_get_drvdata(dev);
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+
+	/* If eCAP is running, stop capture then save timestamp counter */
+	if (ecap_dev->enabled) {
+		/*
+		 * Disabling capture has the following effects:
+		 * - interrupts are disabled
+		 * - loading of capture registers is disabled
+		 * - timebase counter is stopped
+		 */
+		ecap_cnt_capture_disable(counter_dev);
+
+		pm_runtime_get_sync(dev);
+		regmap_read(ecap_dev->regmap, ECAP_TSCNT_REG, &ecap_dev->pm_ctx.time_cntr);
+		pm_runtime_put_sync(dev);
+	}
+
+	ecap_dev->pm_ctx.ev_mode = ecap_cnt_capture_get_evmode(counter_dev);
+
+	clk_disable(ecap_dev->clk);
+
+	return 0;
+}
+
+static int ecap_cnt_resume(struct device *dev)
+{
+	struct counter_device *counter_dev = dev_get_drvdata(dev);
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+
+	clk_enable(ecap_dev->clk);
+
+	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
+
+	/* If eCAP was running, restore timestamp counter then run capture */
+	if (ecap_dev->enabled) {
+		pm_runtime_get_sync(dev);
+		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, ecap_dev->pm_ctx.time_cntr);
+		pm_runtime_put_sync(dev);
+
+		ecap_cnt_capture_enable(counter_dev, false);
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ecap_cnt_pm_ops, ecap_cnt_suspend, ecap_cnt_resume);
+
+static const struct of_device_id ecap_cnt_of_match[] = {
+	{ .compatible	= "ti,am62-ecap-capture" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ecap_cnt_of_match);
+
+static struct platform_driver ecap_cnt_driver = {
+	.probe = ecap_cnt_probe,
+	.remove = ecap_cnt_remove,
+	.driver = {
+		.name = "ecap-capture",
+		.of_match_table = ecap_cnt_of_match,
+		.pm = pm_sleep_ptr(&ecap_cnt_pm_ops),
+	},
+};
+module_platform_driver(ecap_cnt_driver);
+
+MODULE_DESCRIPTION("ECAP Capture driver");
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 96c5ffd368ad..4c5372c6f2a3 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -63,6 +63,8 @@ enum counter_event_type {
 	COUNTER_EVENT_INDEX,
 	/* State of counter is changed */
 	COUNTER_EVENT_CHANGE_OF_STATE,
+	/* Count value is captured */
+	COUNTER_EVENT_CAPTURE,
 };
 
 /**
-- 
2.25.1

