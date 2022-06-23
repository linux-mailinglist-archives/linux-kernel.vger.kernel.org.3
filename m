Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11268558497
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiFWRot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiFWRiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:38:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC835268;
        Thu, 23 Jun 2022 10:08:37 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25NH8CLa033728;
        Thu, 23 Jun 2022 12:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656004092;
        bh=3lrjqDjeMRQsvMIXSea/P/Qf7GprS3hwJIwrNvtTILg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JUV33mComDbu1HKhP4DcqUFwbcfQTBpZ6hoHGL3BmWSVfp7QcD+/bRK0yChDJ2I6N
         OkJtVHHwScBZm/HA9YNLfLZT6W0FTTGQ0rDr0Bp4EE6w8tJKFdeE5YqhwthrpyvsPA
         PaThrnfRQ44XeAbDG+o4W/VUpvyxgoVrx2sm1h+8=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25NH8BEE004635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 12:08:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 12:08:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 12:08:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25NH8BIN006504;
        Thu, 23 Jun 2022 12:08:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 2/2] rtc: Introduce ti-k3-rtc
Date:   Thu, 23 Jun 2022 12:08:08 -0500
Message-ID: <20220623170808.20998-3-nm@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220623170808.20998-1-nm@ti.com>
References: <20220623170808.20998-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for Texas Instruments Real Time Clock controller on
newer K3 family of SoCs such as AM62x.

The hardware module that is being supported is the "digital only"
version which doesn't have capability of external wakeup sources and
external power backup. However, for many practical applications, this
should suffice as RTC is operational across low power sequences.

The hardware block by itself is split into two distinct domains
internally to further reduce the power consumption with the actual
counter block and comparators clocked off a 32k clock source (which
based on SoC integration can be sourced by an external crystal) and an
register interface block which is driven by the bus clock. While optimal
from power perspective, it does create some complicated synchronizations
and sequences that one must be wary of in the driver handling.

Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V3:
* Updates for fixing typos, removal of un-necessary prints, sharpen
  usage of ret

V3: https://lore.kernel.org/all/20220513194457.25942-3-nm@ti.com/
V2: https://lore.kernel.org/all/20220511002600.27964-3-nm@ti.com/
V1: https://lore.kernel.org/all/20220412073138.25027-3-nm@ti.com/
 drivers/rtc/Kconfig     |  11 +
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-ti-k3.c | 680 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 692 insertions(+)
 create mode 100644 drivers/rtc/rtc-ti-k3.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a00f901b5c1d..80557d326776 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1929,6 +1929,17 @@ config RTC_DRV_ASPEED
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-aspeed".
 
+config RTC_DRV_TI_K3
+	tristate "TI K3 RTC"
+	depends on ARCH_K3 || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  If you say yes here you get support for the Texas Instruments's
+	  Real Time Clock for K3 architecture.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-ti-k3".
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fb04467b652d..e449b174165b 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -172,6 +172,7 @@ obj-$(CONFIG_RTC_DRV_SUNPLUS)	+= rtc-sunplus.o
 obj-$(CONFIG_RTC_DRV_SUNXI)	+= rtc-sunxi.o
 obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
+obj-$(CONFIG_RTC_DRV_TI_K3)	+= rtc-ti-k3.o
 obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
 obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
 obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
new file mode 100644
index 000000000000..7a0f181d3fef
--- /dev/null
+++ b/drivers/rtc/rtc-ti-k3.c
@@ -0,0 +1,680 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments K3 RTC driver
+ *
+ * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+/* Registers */
+#define REG_K3RTC_S_CNT_LSW		0x08
+#define REG_K3RTC_S_CNT_MSW		0x0c
+#define REG_K3RTC_COMP			0x10
+#define REG_K3RTC_ON_OFF_S_CNT_LSW	0x20
+#define REG_K3RTC_ON_OFF_S_CNT_MSW	0x24
+#define REG_K3RTC_SCRATCH0		0x30
+#define REG_K3RTC_SCRATCH7		0x4c
+#define REG_K3RTC_GENERAL_CTL		0x50
+#define REG_K3RTC_IRQSTATUS_RAW_SYS	0x54
+#define REG_K3RTC_IRQSTATUS_SYS		0x58
+#define REG_K3RTC_IRQENABLE_SET_SYS	0x5c
+#define REG_K3RTC_IRQENABLE_CLR_SYS	0x60
+#define REG_K3RTC_SYNCPEND		0x68
+#define REG_K3RTC_KICK0			0x70
+#define REG_K3RTC_KICK1			0x74
+
+/* Freeze when lsw is read and unfreeze when msw is read */
+#define K3RTC_CNT_FMODE_S_CNT_VALUE	(0x2 << 24)
+
+/* Magic values for lock/unlock */
+#define K3RTC_KICK0_UNLOCK_VALUE	0x83e70b13
+#define K3RTC_KICK1_UNLOCK_VALUE	0x95a4f1e0
+
+/* Multiplier for ppb conversions */
+#define K3RTC_PPB_MULT			(1000000000LL)
+/* Min and max values supported with 'offset' interface (swapped sign) */
+#define K3RTC_MIN_OFFSET		(-277761)
+#define K3RTC_MAX_OFFSET		(277778)
+
+/**
+ * struct ti_k3_rtc_soc_data - Private of compatible data for ti-k3-rtc
+ * @unlock_irq_erratum:	Has erratum for unlock infinite IRQs (erratum i2327)
+ */
+struct ti_k3_rtc_soc_data {
+	const bool unlock_irq_erratum;
+};
+
+static const struct regmap_config ti_k3_rtc_regmap_config = {
+	.name = "peripheral-registers",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = REG_K3RTC_KICK1,
+};
+
+enum ti_k3_rtc_fields {
+	K3RTC_KICK0,
+	K3RTC_KICK1,
+	K3RTC_S_CNT_LSW,
+	K3RTC_S_CNT_MSW,
+	K3RTC_O32K_OSC_DEP_EN,
+	K3RTC_UNLOCK,
+	K3RTC_CNT_FMODE,
+	K3RTC_PEND,
+	K3RTC_RELOAD_FROM_BBD,
+	K3RTC_COMP,
+
+	K3RTC_ALM_S_CNT_LSW,
+	K3RTC_ALM_S_CNT_MSW,
+	K3RTC_IRQ_STATUS_RAW,
+	K3RTC_IRQ_STATUS,
+	K3RTC_IRQ_ENABLE_SET,
+	K3RTC_IRQ_ENABLE_CLR,
+
+	K3RTC_IRQ_STATUS_ALT,
+	K3RTC_IRQ_ENABLE_CLR_ALT,
+
+	K3_RTC_MAX_FIELDS
+};
+
+static const struct reg_field ti_rtc_reg_fields[] = {
+	[K3RTC_KICK0] = REG_FIELD(REG_K3RTC_KICK0, 0, 31),
+	[K3RTC_KICK1] = REG_FIELD(REG_K3RTC_KICK1, 0, 31),
+	[K3RTC_S_CNT_LSW] = REG_FIELD(REG_K3RTC_S_CNT_LSW, 0, 31),
+	[K3RTC_S_CNT_MSW] = REG_FIELD(REG_K3RTC_S_CNT_MSW, 0, 15),
+	[K3RTC_O32K_OSC_DEP_EN] = REG_FIELD(REG_K3RTC_GENERAL_CTL, 21, 21),
+	[K3RTC_UNLOCK] = REG_FIELD(REG_K3RTC_GENERAL_CTL, 23, 23),
+	[K3RTC_CNT_FMODE] = REG_FIELD(REG_K3RTC_GENERAL_CTL, 24, 25),
+	[K3RTC_PEND] = REG_FIELD(REG_K3RTC_SYNCPEND, 0, 1),
+	[K3RTC_RELOAD_FROM_BBD] = REG_FIELD(REG_K3RTC_SYNCPEND, 31, 31),
+	[K3RTC_COMP] = REG_FIELD(REG_K3RTC_COMP, 0, 31),
+
+	/* We use on to off as alarm trigger */
+	[K3RTC_ALM_S_CNT_LSW] = REG_FIELD(REG_K3RTC_ON_OFF_S_CNT_LSW, 0, 31),
+	[K3RTC_ALM_S_CNT_MSW] = REG_FIELD(REG_K3RTC_ON_OFF_S_CNT_MSW, 0, 15),
+	[K3RTC_IRQ_STATUS_RAW] = REG_FIELD(REG_K3RTC_IRQSTATUS_RAW_SYS, 0, 0),
+	[K3RTC_IRQ_STATUS] = REG_FIELD(REG_K3RTC_IRQSTATUS_SYS, 0, 0),
+	[K3RTC_IRQ_ENABLE_SET] = REG_FIELD(REG_K3RTC_IRQENABLE_SET_SYS, 0, 0),
+	[K3RTC_IRQ_ENABLE_CLR] = REG_FIELD(REG_K3RTC_IRQENABLE_CLR_SYS, 0, 0),
+	/* Off to on is alternate */
+	[K3RTC_IRQ_STATUS_ALT] = REG_FIELD(REG_K3RTC_IRQSTATUS_SYS, 1, 1),
+	[K3RTC_IRQ_ENABLE_CLR_ALT] = REG_FIELD(REG_K3RTC_IRQENABLE_CLR_SYS, 1, 1),
+};
+
+/**
+ * struct ti_k3_rtc - Private data for ti-k3-rtc
+ * @irq:		IRQ
+ * @sync_timeout_us:	data sync timeout period in uSec
+ * @rate_32k:		32k clock rate in Hz
+ * @rtc_dev:		rtc device
+ * @regmap:		rtc mmio regmap
+ * @r_fields:		rtc register fields
+ * @soc:		SoC compatible match data
+ */
+struct ti_k3_rtc {
+	unsigned int irq;
+	u32 sync_timeout_us;
+	unsigned long rate_32k;
+	struct rtc_device *rtc_dev;
+	struct regmap *regmap;
+	struct regmap_field *r_fields[K3_RTC_MAX_FIELDS];
+	const struct ti_k3_rtc_soc_data *soc;
+};
+
+static int k3rtc_field_read(struct ti_k3_rtc *priv, enum ti_k3_rtc_fields f)
+{
+	int ret;
+	int val;
+
+	ret = regmap_field_read(priv->r_fields[f], &val);
+	/*
+	 * We shouldn't be seeing regmap fail on us for mmio reads
+	 * This is possible if clock context fails, but that isn't the case for us
+	 */
+	if (WARN_ON_ONCE(ret))
+		return ret;
+	return val;
+}
+
+static void k3rtc_field_write(struct ti_k3_rtc *priv, enum ti_k3_rtc_fields f, u32 val)
+{
+	regmap_field_write(priv->r_fields[f], val);
+}
+
+/**
+ * k3rtc_fence  - Ensure a register sync took place between the two domains
+ * @priv:      pointer to priv data
+ *
+ * Return: 0 if the sync took place, else returns -ETIMEDOUT
+ */
+static int k3rtc_fence(struct ti_k3_rtc *priv)
+{
+	int ret;
+
+	ret = regmap_field_read_poll_timeout(priv->r_fields[K3RTC_PEND], ret,
+					     !ret, 2, priv->sync_timeout_us);
+
+	return ret;
+}
+
+static inline int k3rtc_check_unlocked(struct ti_k3_rtc *priv)
+{
+	int ret;
+
+	ret = k3rtc_field_read(priv, K3RTC_UNLOCK);
+	if (ret < 0)
+		return ret;
+
+	return (ret) ? 0 : 1;
+}
+
+static int k3rtc_unlock_rtc(struct ti_k3_rtc *priv)
+{
+	int ret;
+
+	ret = k3rtc_check_unlocked(priv);
+	if (!ret)
+		return ret;
+
+	k3rtc_field_write(priv, K3RTC_KICK0, K3RTC_KICK0_UNLOCK_VALUE);
+	k3rtc_field_write(priv, K3RTC_KICK1, K3RTC_KICK1_UNLOCK_VALUE);
+
+	/* Skip fence since we are going to check the unlock bit as fence */
+	ret = regmap_field_read_poll_timeout(priv->r_fields[K3RTC_UNLOCK], ret,
+					     !ret, 2, priv->sync_timeout_us);
+
+	return ret;
+}
+
+static int k3rtc_configure(struct device *dev)
+{
+	int ret;
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+
+	/*
+	 * HWBUG: The compare state machine is broken if the RTC module
+	 * is NOT unlocked in under one second of boot - which is pretty long
+	 * time from the perspective of Linux driver (module load, u-boot
+	 * shell all can take much longer than this.
+	 *
+	 * In such occurrence, it is assumed that the RTC module is unusable
+	 */
+	if (priv->soc->unlock_irq_erratum) {
+		ret = k3rtc_check_unlocked(priv);
+		/* If there is an error OR if we are locked, return error */
+		if (ret) {
+			dev_err(dev,
+				HW_ERR "Erratum i2327 unlock QUIRK! Cannot operate!!\n");
+			return -EFAULT;
+		}
+	} else {
+		/* May need to explicitly unlock first time */
+		ret = k3rtc_unlock_rtc(priv);
+		if (ret) {
+			dev_err(dev, "Failed to unlock(%d)!\n", ret);
+			return ret;
+		}
+	}
+
+	/* Enable Shadow register sync on 32k clock boundary */
+	k3rtc_field_write(priv, K3RTC_O32K_OSC_DEP_EN, 0x1);
+
+	/*
+	 * Wait at least clock sync time before proceeding further programming.
+	 * This ensures that the 32k based sync is active.
+	 */
+	usleep_range(priv->sync_timeout_us, priv->sync_timeout_us + 5);
+
+	/* We need to ensure fence here to make sure sync here */
+	ret = k3rtc_fence(priv);
+	if (ret) {
+		dev_err(dev,
+			"Failed fence osc_dep enable(%d) - is 32k clk working?!\n", ret);
+		return ret;
+	}
+
+	/*
+	 * FMODE setting: Reading lower seconds will freeze value on higher
+	 * seconds. This also implies that we must *ALWAYS* read lower seconds
+	 * prior to reading higher seconds
+	 */
+	k3rtc_field_write(priv, K3RTC_CNT_FMODE, K3RTC_CNT_FMODE_S_CNT_VALUE);
+
+	/* Clear any spurious IRQ sources if any */
+	k3rtc_field_write(priv, K3RTC_IRQ_STATUS_ALT, 0x1);
+	k3rtc_field_write(priv, K3RTC_IRQ_STATUS, 0x1);
+	/* Disable all IRQs */
+	k3rtc_field_write(priv, K3RTC_IRQ_ENABLE_CLR_ALT, 0x1);
+	k3rtc_field_write(priv, K3RTC_IRQ_ENABLE_CLR, 0x1);
+
+	/* And.. Let us Sync the writes in */
+	return k3rtc_fence(priv);
+}
+
+static int ti_k3_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	u32 seconds_lo, seconds_hi;
+
+	seconds_lo = k3rtc_field_read(priv, K3RTC_S_CNT_LSW);
+	seconds_hi = k3rtc_field_read(priv, K3RTC_S_CNT_MSW);
+
+	rtc_time64_to_tm((((time64_t)seconds_hi) << 32) | (time64_t)seconds_lo, tm);
+
+	return 0;
+}
+
+static int ti_k3_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	time64_t seconds;
+
+	seconds = rtc_tm_to_time64(tm);
+
+	/*
+	 * Read operation on LSW will freeze the RTC, so to update
+	 * the time, we cannot use field operations. Just write since the
+	 * reserved bits are ignored.
+	 */
+	regmap_write(priv->regmap, REG_K3RTC_S_CNT_LSW, seconds);
+	regmap_write(priv->regmap, REG_K3RTC_S_CNT_MSW, seconds >> 32);
+
+	return k3rtc_fence(priv);
+}
+
+static int ti_k3_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	u32 reg;
+	u32 offset = enabled ? K3RTC_IRQ_ENABLE_SET : K3RTC_IRQ_ENABLE_CLR;
+
+	reg = k3rtc_field_read(priv, K3RTC_IRQ_ENABLE_SET);
+	if ((enabled && reg) || (!enabled && !reg))
+		return 0;
+
+	k3rtc_field_write(priv, offset, 0x1);
+
+	/*
+	 * Ensure the write sync is through - NOTE: it should be OK to have
+	 * ISR to fire as we are checking sync (which should be done in a 32k
+	 * cycle or so).
+	 */
+	return k3rtc_fence(priv);
+}
+
+static int ti_k3_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	u32 seconds_lo, seconds_hi;
+
+	seconds_lo = k3rtc_field_read(priv, K3RTC_ALM_S_CNT_LSW);
+	seconds_hi = k3rtc_field_read(priv, K3RTC_ALM_S_CNT_MSW);
+
+	rtc_time64_to_tm((((time64_t)seconds_hi) << 32) | (time64_t)seconds_lo, &alarm->time);
+
+	alarm->enabled = k3rtc_field_read(priv, K3RTC_IRQ_ENABLE_SET);
+
+	return 0;
+}
+
+static int ti_k3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	time64_t seconds;
+	int ret;
+
+	seconds = rtc_tm_to_time64(&alarm->time);
+
+	k3rtc_field_write(priv, K3RTC_ALM_S_CNT_LSW, seconds);
+	k3rtc_field_write(priv, K3RTC_ALM_S_CNT_MSW, (seconds >> 32));
+
+	/* Make sure the alarm time is synced in */
+	ret = k3rtc_fence(priv);
+	if (ret) {
+		dev_err(dev, "Failed to fence(%d)! Potential config issue?\n", ret);
+		return ret;
+	}
+
+	/* Alarm IRQ enable will do a sync */
+	return ti_k3_rtc_alarm_irq_enable(dev, alarm->enabled);
+}
+
+static int ti_k3_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	u32 ticks_per_hr = priv->rate_32k * 3600;
+	int comp;
+	s64 tmp;
+
+	comp = k3rtc_field_read(priv, K3RTC_COMP);
+
+	/* Convert from RTC calibration register format to ppb format */
+	tmp = comp * (s64)K3RTC_PPB_MULT;
+	if (tmp < 0)
+		tmp -= ticks_per_hr / 2LL;
+	else
+		tmp += ticks_per_hr / 2LL;
+	tmp = div_s64(tmp, ticks_per_hr);
+
+	/* Offset value operates in negative way, so swap sign */
+	*offset = (long)-tmp;
+
+	return 0;
+}
+
+static int ti_k3_rtc_set_offset(struct device *dev, long offset)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	u32 ticks_per_hr = priv->rate_32k * 3600;
+	int comp;
+	s64 tmp;
+
+	/* Make sure offset value is within supported range */
+	if (offset < K3RTC_MIN_OFFSET || offset > K3RTC_MAX_OFFSET)
+		return -ERANGE;
+
+	/* Convert from ppb format to RTC calibration register format */
+	tmp = offset * (s64)ticks_per_hr;
+	if (tmp < 0)
+		tmp -= K3RTC_PPB_MULT / 2LL;
+	else
+		tmp += K3RTC_PPB_MULT / 2LL;
+	tmp = div_s64(tmp, K3RTC_PPB_MULT);
+
+	/* Offset value operates in negative way, so swap sign */
+	comp = (int)-tmp;
+
+	k3rtc_field_write(priv, K3RTC_COMP, comp);
+
+	return k3rtc_fence(priv);
+}
+
+static irqreturn_t ti_k3_rtc_interrupt(s32 irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+	u32 reg;
+	int ret;
+
+	/*
+	 * IRQ assertion can be very fast, however, the IRQ Status clear
+	 * de-assert depends on 32k clock edge in the 32k domain
+	 * If we clear the status prior to the first 32k clock edge,
+	 * the status bit is cleared, but the IRQ stays re-asserted.
+	 *
+	 * To prevent this condition, we need to wait for clock sync time.
+	 * We can either do that by polling the 32k observability signal for
+	 * a toggle OR we could just sleep and let the processor do other
+	 * stuff.
+	 */
+	usleep_range(priv->sync_timeout_us, priv->sync_timeout_us + 2);
+
+	/* Lets make sure that this is a valid interrupt */
+	reg = k3rtc_field_read(priv, K3RTC_IRQ_STATUS);
+
+	if (!reg) {
+		u32 raw = k3rtc_field_read(priv, K3RTC_IRQ_STATUS_RAW);
+
+		dev_err(dev,
+			HW_ERR
+			"Erratum i2327/IRQ trig: status: 0x%08x / 0x%08x\n", reg, raw);
+		return IRQ_NONE;
+	}
+
+	/*
+	 * Write 1 to clear status reg
+	 * We cannot use a field operation here due to a potential race between
+	 * 32k domain and vbus domain.
+	 */
+	regmap_write(priv->regmap, REG_K3RTC_IRQSTATUS_SYS, 0x1);
+
+	/* Sync the write in */
+	ret = k3rtc_fence(priv);
+	if (ret) {
+		dev_err(dev, "Failed to fence irq status clr(%d)!\n", ret);
+		return IRQ_NONE;
+	}
+
+	/*
+	 * Force the 32k status to be reloaded back in to ensure status is
+	 * reflected back correctly.
+	 */
+	k3rtc_field_write(priv, K3RTC_RELOAD_FROM_BBD, 0x1);
+
+	/* Ensure the write sync is through */
+	ret = k3rtc_fence(priv);
+	if (ret) {
+		dev_err(dev, "Failed to fence reload from bbd(%d)!\n", ret);
+		return IRQ_NONE;
+	}
+
+	/* Now we ensure that the status bit is cleared */
+	ret = regmap_field_read_poll_timeout(priv->r_fields[K3RTC_IRQ_STATUS],
+					     ret, !ret, 2, priv->sync_timeout_us);
+	if (ret) {
+		dev_err(dev, "Time out waiting for status clear\n");
+		return IRQ_NONE;
+	}
+
+	/* Notify RTC core on event */
+	rtc_update_irq(priv->rtc_dev, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops ti_k3_rtc_ops = {
+	.read_time = ti_k3_rtc_read_time,
+	.set_time = ti_k3_rtc_set_time,
+	.read_alarm = ti_k3_rtc_read_alarm,
+	.set_alarm = ti_k3_rtc_set_alarm,
+	.read_offset = ti_k3_rtc_read_offset,
+	.set_offset = ti_k3_rtc_set_offset,
+	.alarm_irq_enable = ti_k3_rtc_alarm_irq_enable,
+};
+
+static int ti_k3_rtc_scratch_read(void *priv_data, unsigned int offset,
+				  void *val, size_t bytes)
+{
+	struct ti_k3_rtc *priv = (struct ti_k3_rtc *)priv_data;
+
+	return regmap_bulk_read(priv->regmap, REG_K3RTC_SCRATCH0 + offset, val, bytes / 4);
+}
+
+static int ti_k3_rtc_scratch_write(void *priv_data, unsigned int offset,
+				   void *val, size_t bytes)
+{
+	struct ti_k3_rtc *priv = (struct ti_k3_rtc *)priv_data;
+	int ret;
+
+	ret = regmap_bulk_write(priv->regmap, REG_K3RTC_SCRATCH0 + offset, val, bytes / 4);
+	if (ret)
+		return ret;
+
+	return k3rtc_fence(priv);
+}
+
+static struct nvmem_config ti_k3_rtc_nvmem_config = {
+	.name = "ti_k3_rtc_scratch",
+	.word_size = 4,
+	.stride = 4,
+	.size = REG_K3RTC_SCRATCH7 - REG_K3RTC_SCRATCH0 + 4,
+	.reg_read = ti_k3_rtc_scratch_read,
+	.reg_write = ti_k3_rtc_scratch_write,
+};
+
+static int k3rtc_get_32kclk(struct device *dev, struct ti_k3_rtc *priv)
+{
+	int ret;
+	struct clk *clk;
+
+	clk = devm_clk_get(dev, "osc32k");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, (void (*)(void *))clk_disable_unprepare, clk);
+	if (ret)
+		return ret;
+
+	priv->rate_32k = clk_get_rate(clk);
+
+	/* Make sure we are exact 32k clock. Else, try to compensate delay */
+	if (priv->rate_32k != 32768)
+		dev_warn(dev, "Clock rate %ld is not 32768! Could misbehave!\n",
+			 priv->rate_32k);
+
+	/*
+	 * Sync timeout should be two 32k clk sync cycles = ~61uS. We double
+	 * it to comprehend intermediate bus segment and cpu frequency
+	 * deltas
+	 */
+	priv->sync_timeout_us = (u32)(DIV_ROUND_UP_ULL(1000000, priv->rate_32k) * 4);
+
+	return ret;
+}
+
+static int k3rtc_get_vbusclk(struct device *dev, struct ti_k3_rtc *priv)
+{
+	int ret;
+	struct clk *clk;
+
+	/* Note: VBUS isn't a context clock, it is needed for hardware operation */
+	clk = devm_clk_get(dev, "vbus");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, (void (*)(void *))clk_disable_unprepare, clk);
+}
+
+static int ti_k3_rtc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ti_k3_rtc *priv;
+	void __iomem *rtc_base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct ti_k3_rtc), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	rtc_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rtc_base))
+		return PTR_ERR(rtc_base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, rtc_base, &ti_k3_rtc_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = devm_regmap_field_bulk_alloc(dev, priv->regmap, priv->r_fields,
+					   ti_rtc_reg_fields, K3_RTC_MAX_FIELDS);
+	if (ret)
+		return ret;
+
+	ret = k3rtc_get_32kclk(dev, priv);
+	if (ret)
+		return ret;
+	ret = k3rtc_get_vbusclk(dev, priv);
+	if (ret)
+		return ret;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	priv->irq = (unsigned int)ret;
+
+	priv->rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(priv->rtc_dev))
+		return PTR_ERR(priv->rtc_dev);
+
+	priv->soc = of_device_get_match_data(dev);
+
+	priv->rtc_dev->ops = &ti_k3_rtc_ops;
+	priv->rtc_dev->range_max = (1ULL << 48) - 1;	/* 48Bit seconds */
+	ti_k3_rtc_nvmem_config.priv = priv;
+
+	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
+					ti_k3_rtc_interrupt,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					dev_name(dev), dev);
+	if (ret) {
+		dev_err(dev, "Could not request IRQ: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = k3rtc_configure(dev);
+	if (ret)
+		return ret;
+
+	if (device_property_present(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+	else
+		device_set_wakeup_capable(dev, true);
+
+	ret = devm_rtc_register_device(priv->rtc_dev);
+	if (ret)
+		return ret;
+
+	return devm_rtc_nvmem_register(priv->rtc_dev, &ti_k3_rtc_nvmem_config);
+}
+
+static const struct ti_k3_rtc_soc_data ti_k3_am62_data = {
+	.unlock_irq_erratum = true,
+};
+
+static const struct of_device_id ti_k3_rtc_of_match_table[] = {
+	{.compatible = "ti,am62-rtc", .data = &ti_k3_am62_data},
+	{}
+};
+MODULE_DEVICE_TABLE(of, ti_k3_rtc_of_match_table);
+
+static int __maybe_unused ti_k3_rtc_suspend(struct device *dev)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(priv->irq);
+	return 0;
+}
+
+static int __maybe_unused ti_k3_rtc_resume(struct device *dev)
+{
+	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(priv->irq);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ti_k3_rtc_pm_ops, ti_k3_rtc_suspend, ti_k3_rtc_resume);
+
+static struct platform_driver ti_k3_rtc_driver = {
+	.probe = ti_k3_rtc_probe,
+	.driver = {
+		   .name = "rtc-ti-k3",
+		   .of_match_table = ti_k3_rtc_of_match_table,
+		   .pm = &ti_k3_rtc_pm_ops,
+	},
+};
+module_platform_driver(ti_k3_rtc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI K3 RTC driver");
+MODULE_AUTHOR("Nishanth Menon");
-- 
2.31.1

