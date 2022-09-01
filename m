Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D655A8B97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiIACpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIACpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:45:52 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C89E01F4;
        Wed, 31 Aug 2022 19:45:48 -0700 (PDT)
Received: from droid01-xa.amlogic.com (10.88.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.9; Thu, 1 Sep 2022
 10:45:45 +0800
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/4] perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver
Date:   Thu, 1 Sep 2022 10:45:23 +0800
Message-ID: <20220901024526.2833232-1-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.88.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support Amlogic meson G12 series SoC
DDR bandwidth PMU driver framework and interfaces.

The PMU not only can monitor the total DDR bandwidth,
but also the bandwidth which is from individual IP module.

Example usage:

 $ perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10

- or -

 $ perf stat -a -e \
   meson_ddr_bw/total_rw_bytes/,\
   meson_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 \
   sleep 10

g12 SoC support 4 channels to monitor DDR bandwidth
simultaneously. Each channel can monitor up to 4 IP modules
simultaneously.

For Instance, If you want to get the sum of DDR bandwidth
from CPU, GPU, USB3.0 and VDEC. You can use the following
command parameters to display.

 $ perf stat -a -e \
   meson_ddr_bw/chan_2_rw_bytes,arm=1,gpu=1,usb3_0=1,nna=1/ -I 1000 \
   sleep 10

Other events are supported, and advertised via perf list.

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes v5 -> v6:
  - Add const for driver data

Changes v4 -> v5:
  - Remove error message
  - Use smp_processor_id() instead of raw_smp_processor_id()
  - Remove EXPORT_SYMBOL()
  - Use variant specific driver data for compatible
  - Use module_platform_driver for modules_init/exit
  - Change location of driver structures from .h  to .c

Changes v3 -> v4:
  - No change

Changes v2 -> v3:
  - Fix sh GCC 12.1.0 compiling warning
  - Rename prefix aml to meson for files and code

Changes v1 -> v2:
  - Remove inline to let GCC make the decisions
  - Remove spinlock
  - Remove ddr_cnt_accumulate()
  - Remove the message which only indicate a bug
  - Remove all dev_warn() message
  - Use hweight64() helper instead of whole loop
  - Remove setting of hwc
  - Use for_each_set_bit() helper for bit loop
  - Use sysfs_emit() in sysfs show
  - Remove checking for bugs
  - Replace irq_set_affinity_hint() to irq_set_affinity()
  - Remove #ifdef CONFIG_OF
  - Use devm_platform_ioremap_resource() instead of
    platform_get_resource()&ioremap()
  - Use platform_get_irq() instead of platform_get_resource()&ioremap()
  - Replace IRQF_SHARED to IRQF_NOBALANCING
  - Remove meaningless log like "init ok"
  - Use compatible instead of creating new property to distinguish
    different platform.
  - Use the is_visible callback to avoid exposing unsupported fmt_attr
  - Use module_platform_driver_probe() instead of module_init/exit
---
 MAINTAINERS                               |   7 +
 drivers/perf/Kconfig                      |   2 +
 drivers/perf/Makefile                     |   1 +
 drivers/perf/amlogic/Kconfig              |  10 +
 drivers/perf/amlogic/Makefile             |   5 +
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 562 ++++++++++++++++++++++
 drivers/perf/amlogic/meson_g12_ddr_pmu.c  | 394 +++++++++++++++
 include/soc/amlogic/meson_ddr_pmu.h       |  66 +++
 8 files changed, 1047 insertions(+)
 create mode 100644 drivers/perf/amlogic/Kconfig
 create mode 100644 drivers/perf/amlogic/Makefile
 create mode 100644 drivers/perf/amlogic/meson_ddr_pmu_core.c
 create mode 100644 drivers/perf/amlogic/meson_g12_ddr_pmu.c
 create mode 100644 include/soc/amlogic/meson_ddr_pmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d99d54fa881..ac8a98dfbacc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1050,6 +1050,13 @@ S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 
+AMLOGIC DDR PMU DRIVER
+M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
+S:	Supported
+W:	http://www.amlogic.com
+F:	drivers/perf/amlogic/
+F:	include/soc/amlogic/
+
 AMPHION VPU CODEC V4L2 DRIVER
 M:	Ming Qian <ming.qian@nxp.com>
 M:	Shijie Qin <shijie.qin@nxp.com>
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 1e2d69453771..68200c798128 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
 	  Enable perf support for Marvell DDR Performance monitoring
 	  event on CN10K platform.
 
+source "drivers/perf/amlogic/Kconfig"
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 57a279c61df5..4930482a15ff 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
+obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
diff --git a/drivers/perf/amlogic/Kconfig b/drivers/perf/amlogic/Kconfig
new file mode 100644
index 000000000000..f68db01a7f17
--- /dev/null
+++ b/drivers/perf/amlogic/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MESON_DDR_PMU
+	tristate "Amlogic DDR Bandwidth Performance Monitor"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+          Provides support for the DDR performance monitor
+          in Amlogic SoCs, which can give information about
+          memory throughput and other related events. It
+          supports multiple channels to monitor the memory
+          bandwidth simultaneously.
diff --git a/drivers/perf/amlogic/Makefile b/drivers/perf/amlogic/Makefile
new file mode 100644
index 000000000000..d3ab2ac5353b
--- /dev/null
+++ b/drivers/perf/amlogic/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_MESON_DDR_PMU) += meson_ddr_pmu_g12.o
+
+meson_ddr_pmu_g12-y	:= meson_ddr_pmu_core.o meson_g12_ddr_pmu.o
diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
new file mode 100644
index 000000000000..f14a8d5e24bf
--- /dev/null
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+#include <soc/amlogic/meson_ddr_pmu.h>
+
+struct ddr_pmu {
+	struct pmu pmu;
+	struct dmc_info info;
+	struct dmc_counter counters;	/* save counters from hw */
+	bool pmu_enabled;
+	struct device *dev;
+	char *name;
+	struct hlist_node node;
+	enum cpuhp_state cpuhp_state;
+	int cpu;			/* for cpu hotplug */
+};
+
+#define DDR_PERF_DEV_NAME "meson_ddr_bw"
+#define MAX_AXI_PORTS_OF_CHANNEL	4	/* A DMC channel can monitor max 4 axi ports */
+
+#define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
+#define dmc_info_to_pmu(p)	container_of(p, struct ddr_pmu, info)
+
+static void dmc_pmu_enable(struct ddr_pmu *pmu)
+{
+	if (!pmu->pmu_enabled)
+		pmu->info.hw_info->enable(&pmu->info);
+
+	pmu->pmu_enabled = true;
+}
+
+static void dmc_pmu_disable(struct ddr_pmu *pmu)
+{
+	if (pmu->pmu_enabled)
+		pmu->info.hw_info->disable(&pmu->info);
+
+	pmu->pmu_enabled = false;
+}
+
+static void meson_ddr_set_axi_filter(struct perf_event *event, u8 axi_id)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	int chann;
+
+	if (event->attr.config > ALL_CHAN_COUNTER_ID &&
+	    event->attr.config < COUNTER_MAX_ID) {
+		chann = event->attr.config - CHAN1_COUNTER_ID;
+
+		pmu->info.hw_info->set_axi_filter(&pmu->info, axi_id, chann);
+	}
+}
+
+static void ddr_cnt_addition(struct dmc_counter *sum,
+			     struct dmc_counter *add1,
+			     struct dmc_counter *add2,
+			     int chann_nr)
+{
+	int i;
+	u64 cnt1, cnt2;
+
+	sum->all_cnt = add1->all_cnt + add2->all_cnt;
+	sum->all_req = add1->all_req + add2->all_req;
+	for (i = 0; i < chann_nr; i++) {
+		cnt1 = add1->channel_cnt[i];
+		cnt2 = add2->channel_cnt[i];
+
+		sum->channel_cnt[i] = cnt1 + cnt2;
+	}
+}
+
+static void meson_ddr_perf_event_update(struct perf_event *event)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	u64 new_raw_count = 0;
+	struct dmc_counter dc = {0}, sum_dc = {0};
+	int idx;
+	int chann_nr = pmu->info.hw_info->chann_nr;
+
+	/* get the remain counters in register. */
+	pmu->info.hw_info->get_counters(&pmu->info, &dc);
+
+	ddr_cnt_addition(&sum_dc, &pmu->counters, &dc, chann_nr);
+
+	switch (event->attr.config) {
+	case ALL_CHAN_COUNTER_ID:
+		new_raw_count = sum_dc.all_cnt;
+		break;
+	case CHAN1_COUNTER_ID:
+	case CHAN2_COUNTER_ID:
+	case CHAN3_COUNTER_ID:
+	case CHAN4_COUNTER_ID:
+	case CHAN5_COUNTER_ID:
+	case CHAN6_COUNTER_ID:
+	case CHAN7_COUNTER_ID:
+	case CHAN8_COUNTER_ID:
+		idx = event->attr.config - CHAN1_COUNTER_ID;
+		new_raw_count = sum_dc.channel_cnt[idx];
+		break;
+	}
+
+	local64_set(&event->count, new_raw_count);
+}
+
+static int meson_ddr_perf_event_init(struct perf_event *event)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+	u64 config1 = event->attr.config1;
+	u64 config2 = event->attr.config2;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0)
+		return -EOPNOTSUPP;
+
+	/* check if the number of parameters is too much */
+	if (event->attr.config != ALL_CHAN_COUNTER_ID &&
+	    hweight64(config1) + hweight64(config2) > MAX_AXI_PORTS_OF_CHANNEL)
+		return -EOPNOTSUPP;
+
+	event->cpu = pmu->cpu;
+
+	return 0;
+}
+
+static void meson_ddr_perf_event_start(struct perf_event *event, int flags)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+
+	memset(&pmu->counters, 0, sizeof(pmu->counters));
+	dmc_pmu_enable(pmu);
+}
+
+static int meson_ddr_perf_event_add(struct perf_event *event, int flags)
+{
+	u64 config1 = event->attr.config1;
+	u64 config2 = event->attr.config2;
+	int i;
+
+	for_each_set_bit(i, (const unsigned long *)&config1, sizeof(config1))
+		meson_ddr_set_axi_filter(event, i);
+
+	for_each_set_bit(i, (const unsigned long *)&config2, sizeof(config2))
+		meson_ddr_set_axi_filter(event, i + 64);
+
+	if (flags & PERF_EF_START)
+		meson_ddr_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void meson_ddr_perf_event_stop(struct perf_event *event, int flags)
+{
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+
+	if (flags & PERF_EF_UPDATE)
+		meson_ddr_perf_event_update(event);
+
+	dmc_pmu_disable(pmu);
+}
+
+static void meson_ddr_perf_event_del(struct perf_event *event, int flags)
+{
+	meson_ddr_perf_event_stop(event, PERF_EF_UPDATE);
+}
+
+static ssize_t meson_ddr_perf_cpumask_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+}
+
+static struct device_attribute meson_ddr_perf_cpumask_attr =
+__ATTR(cpumask, 0444, meson_ddr_perf_cpumask_show, NULL);
+
+static struct attribute *meson_ddr_perf_cpumask_attrs[] = {
+	&meson_ddr_perf_cpumask_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_cpumask_attr_group = {
+	.attrs = meson_ddr_perf_cpumask_attrs,
+};
+
+static ssize_t
+pmu_event_show(struct device *dev, struct device_attribute *attr,
+	       char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+static ssize_t
+event_show_unit(struct device *dev, struct device_attribute *attr,
+		char *page)
+{
+	return sysfs_emit(page, "MB\n");
+}
+
+static ssize_t
+event_show_scale(struct device *dev, struct device_attribute *attr,
+		 char *page)
+{
+	/* one count = 16byte = 1.52587890625e-05 MB */
+	return sysfs_emit(page, "1.52587890625e-05\n");
+}
+
+#define AML_DDR_PMU_EVENT_ATTR(_name, _id)				\
+{									\
+	.attr = __ATTR(_name, 0444, pmu_event_show, NULL),		\
+	.id = _id,							\
+}
+
+#define AML_DDR_PMU_EVENT_UNIT_ATTR(_name)				\
+	__ATTR(_name.unit, 0444, event_show_unit, NULL)
+
+#define AML_DDR_PMU_EVENT_SCALE_ATTR(_name)				\
+	__ATTR(_name.scale, 0444, event_show_scale, NULL)
+
+static struct device_attribute event_unit_attrs[] = {
+	AML_DDR_PMU_EVENT_UNIT_ATTR(total_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_1_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_2_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_3_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_4_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_5_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_6_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_7_rw_bytes),
+	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_8_rw_bytes),
+};
+
+static struct device_attribute event_scale_attrs[] = {
+	AML_DDR_PMU_EVENT_SCALE_ATTR(total_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_1_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_2_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_3_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_4_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_5_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_6_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_7_rw_bytes),
+	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_8_rw_bytes),
+};
+
+static struct perf_pmu_events_attr event_attrs[] = {
+	AML_DDR_PMU_EVENT_ATTR(total_rw_bytes, ALL_CHAN_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_1_rw_bytes, CHAN1_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_2_rw_bytes, CHAN2_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_3_rw_bytes, CHAN3_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_4_rw_bytes, CHAN4_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_5_rw_bytes, CHAN5_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_6_rw_bytes, CHAN6_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_7_rw_bytes, CHAN7_COUNTER_ID),
+	AML_DDR_PMU_EVENT_ATTR(chan_8_rw_bytes, CHAN8_COUNTER_ID),
+};
+
+/* three attrs are combined an event */
+static struct attribute *ddr_perf_events_attrs[COUNTER_MAX_ID * 3];
+
+static struct attribute_group ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = ddr_perf_events_attrs,
+};
+
+static umode_t meson_ddr_perf_format_attr_visible(struct kobject *kobj,
+						  struct attribute *attr,
+						  int n)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
+	const u64 *capability = ddr_pmu->info.hw_info->capability;
+	struct device_attribute *dev_attr;
+	int id;
+	char value[20]; // config1:xxx, 20 is enough
+
+	dev_attr = container_of(attr, struct device_attribute, attr);
+	dev_attr->show(NULL, NULL, value);
+
+	if (sscanf(value, "config1:%d", &id) == 1)
+		return capability[0] & (1 << id) ? attr->mode : 0;
+
+	if (sscanf(value, "config2:%d", &id) == 1)
+		return capability[1] & (1 << id) ? attr->mode : 0;
+
+	return attr->mode;
+}
+
+static struct attribute_group ddr_perf_format_attr_group = {
+	.name = "format",
+	.is_visible = meson_ddr_perf_format_attr_visible,
+};
+
+static ssize_t meson_ddr_perf_identifier_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *page)
+{
+	struct ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	return sysfs_emit(page, "%s\n", pmu->name);
+}
+
+static struct device_attribute meson_ddr_perf_identifier_attr =
+__ATTR(identifier, 0444, meson_ddr_perf_identifier_show, NULL);
+
+static struct attribute *meson_ddr_perf_identifier_attrs[] = {
+	&meson_ddr_perf_identifier_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_identifier_attr_group = {
+	.attrs = meson_ddr_perf_identifier_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&ddr_perf_events_attr_group,
+	&ddr_perf_format_attr_group,
+	&ddr_perf_cpumask_attr_group,
+	&ddr_perf_identifier_attr_group,
+	NULL,
+};
+
+static irqreturn_t dmc_irq_handler(int irq, void *dev_id)
+{
+	struct dmc_info *info = dev_id;
+	struct ddr_pmu *pmu;
+	struct dmc_counter counters, *sum_cnter;
+	int i;
+
+	pmu = dmc_info_to_pmu(info);
+
+	if (info->hw_info->irq_handler(info, &counters) != 0)
+		goto out;
+
+	sum_cnter = &pmu->counters;
+	sum_cnter->all_cnt += counters.all_cnt;
+	sum_cnter->all_req += counters.all_req;
+
+	for (i = 0; i < pmu->info.hw_info->chann_nr; i++)
+		sum_cnter->channel_cnt[i] += counters.channel_cnt[i];
+
+	if (pmu->pmu_enabled)
+		/*
+		 * the timer interrupt only supprt
+		 * one shot mode, we have to re-enable
+		 * it in ISR to support continue mode.
+		 */
+		info->hw_info->enable(info);
+
+	dev_dbg(pmu->dev, "counts: %llu %llu %llu, %llu, %llu, %llu\t\t"
+			"sum: %llu %llu %llu, %llu, %llu, %llu\n",
+			counters.all_req,
+			counters.all_cnt,
+			counters.channel_cnt[0],
+			counters.channel_cnt[1],
+			counters.channel_cnt[2],
+			counters.channel_cnt[3],
+
+			pmu->counters.all_req,
+			pmu->counters.all_cnt,
+			pmu->counters.channel_cnt[0],
+			pmu->counters.channel_cnt[1],
+			pmu->counters.channel_cnt[2],
+			pmu->counters.channel_cnt[3]);
+out:
+	return IRQ_HANDLED;
+}
+
+static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct ddr_pmu *pmu = hlist_entry_safe(node, struct ddr_pmu, node);
+	int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+
+	WARN_ON(irq_set_affinity(pmu->info.irq_num, cpumask_of(pmu->cpu)));
+
+	return 0;
+}
+
+static void fill_event_attr(struct ddr_pmu *pmu)
+{
+	int i, j, k;
+	struct attribute **dst = ddr_perf_events_attrs;
+
+	j = 0;
+	k = 0;
+
+	/* fill ALL_CHAN_COUNTER_ID event */
+	dst[j++] = &event_attrs[k].attr.attr;
+	dst[j++] = &event_unit_attrs[k].attr;
+	dst[j++] = &event_scale_attrs[k].attr;
+
+	k++;
+
+	/* fill each channel event */
+	for (i = 0; i < pmu->info.hw_info->chann_nr; i++, k++) {
+		dst[j++] = &event_attrs[k].attr.attr;
+		dst[j++] = &event_unit_attrs[k].attr;
+		dst[j++] = &event_scale_attrs[k].attr;
+	}
+
+	dst[j] = NULL; /* mark end */
+}
+
+static void fmt_attr_fill(struct attribute **fmt_attr)
+{
+	ddr_perf_format_attr_group.attrs = fmt_attr;
+}
+
+static int ddr_pmu_parse_dt(struct platform_device *pdev,
+			    struct dmc_info *info)
+{
+	void __iomem *base;
+	int i, ret;
+
+	info->hw_info = of_device_get_match_data(&pdev->dev);
+
+	for (i = 0; i < info->hw_info->dmc_nr; i++) {
+		/* resource 0 for ddr register base */
+		base = devm_platform_ioremap_resource(pdev, i);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		info->ddr_reg[i] = base;
+	}
+
+	/* resource i for pll register base */
+	base = devm_platform_ioremap_resource(pdev, i);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	info->pll_reg = base;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	info->irq_num = ret;
+
+	ret = devm_request_irq(&pdev->dev, info->irq_num, dmc_irq_handler,
+			       IRQF_NOBALANCING, dev_name(&pdev->dev),
+			       (void *)info);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int meson_ddr_pmu_create(struct platform_device *pdev)
+{
+	int ret;
+	char *name;
+	struct ddr_pmu *pmu;
+
+	pmu = devm_kzalloc(&pdev->dev, sizeof(struct ddr_pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	*pmu = (struct ddr_pmu) {
+		.pmu = {
+			.module		= THIS_MODULE,
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr	= perf_invalid_context,
+			.attr_groups	= attr_groups,
+			.event_init	= meson_ddr_perf_event_init,
+			.add		= meson_ddr_perf_event_add,
+			.del		= meson_ddr_perf_event_del,
+			.start		= meson_ddr_perf_event_start,
+			.stop		= meson_ddr_perf_event_stop,
+			.read		= meson_ddr_perf_event_update,
+		},
+	};
+
+	ret = ddr_pmu_parse_dt(pdev, &pmu->info);
+	if (ret < 0)
+		return ret;
+
+	fmt_attr_fill(pmu->info.hw_info->fmt_attr);
+
+	pmu->cpu = smp_processor_id();
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME);
+	if (!name)
+		return -ENOMEM;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, name, NULL,
+				      ddr_perf_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	pmu->cpuhp_state = ret;
+
+	/* Register the pmu instance for cpu hotplug */
+	ret = cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	if (ret)
+		goto cpuhp_instance_err;
+
+	fill_event_attr(pmu);
+
+	ret = perf_pmu_register(&pmu->pmu, name, -1);
+	if (ret)
+		goto pmu_register_err;
+
+	pmu->name = name;
+	pmu->dev = &pdev->dev;
+	pmu->pmu_enabled = false;
+
+	platform_set_drvdata(pdev, pmu);
+
+	return 0;
+
+pmu_register_err:
+	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+
+cpuhp_instance_err:
+	cpuhp_remove_state(pmu->cpuhp_state);
+
+	return ret;
+}
+
+int meson_ddr_pmu_remove(struct platform_device *pdev)
+{
+	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&pmu->pmu);
+	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	cpuhp_remove_state(pmu->cpuhp_state);
+
+	return 0;
+}
diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
new file mode 100644
index 000000000000..27713c11350e
--- /dev/null
+++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+#include <soc/amlogic/meson_ddr_pmu.h>
+
+#define PORT_MAJOR		32
+#define DEFAULT_XTAL_FREQ	24000000UL
+
+#define DMC_QOS_IRQ		BIT(30)
+
+/* DMC bandwidth monitor register address offset */
+#define DMC_MON_G12_CTRL0		(0x20  << 2)
+#define DMC_MON_G12_CTRL1		(0x21  << 2)
+#define DMC_MON_G12_CTRL2		(0x22  << 2)
+#define DMC_MON_G12_CTRL3		(0x23  << 2)
+#define DMC_MON_G12_CTRL4		(0x24  << 2)
+#define DMC_MON_G12_CTRL5		(0x25  << 2)
+#define DMC_MON_G12_CTRL6		(0x26  << 2)
+#define DMC_MON_G12_CTRL7		(0x27  << 2)
+#define DMC_MON_G12_CTRL8		(0x28  << 2)
+
+#define DMC_MON_G12_ALL_REQ_CNT		(0x29  << 2)
+#define DMC_MON_G12_ALL_GRANT_CNT	(0x2a  << 2)
+#define DMC_MON_G12_ONE_GRANT_CNT	(0x2b  << 2)
+#define DMC_MON_G12_SEC_GRANT_CNT	(0x2c  << 2)
+#define DMC_MON_G12_THD_GRANT_CNT	(0x2d  << 2)
+#define DMC_MON_G12_FOR_GRANT_CNT	(0x2e  << 2)
+#define DMC_MON_G12_TIMER		(0x2f  << 2)
+
+/* Each bit represent a axi line */
+PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR(arm, "config1:0");
+PMU_FORMAT_ATTR(gpu, "config1:1");
+PMU_FORMAT_ATTR(pcie, "config1:2");
+PMU_FORMAT_ATTR(hdcp, "config1:3");
+PMU_FORMAT_ATTR(hevc_front, "config1:4");
+PMU_FORMAT_ATTR(usb3_0, "config1:6");
+PMU_FORMAT_ATTR(device, "config1:7");
+PMU_FORMAT_ATTR(hevc_back, "config1:8");
+PMU_FORMAT_ATTR(h265enc, "config1:9");
+PMU_FORMAT_ATTR(vpu_read1, "config1:16");
+PMU_FORMAT_ATTR(vpu_read2, "config1:17");
+PMU_FORMAT_ATTR(vpu_read3, "config1:18");
+PMU_FORMAT_ATTR(vpu_write1, "config1:19");
+PMU_FORMAT_ATTR(vpu_write2, "config1:20");
+PMU_FORMAT_ATTR(vdec, "config1:21");
+PMU_FORMAT_ATTR(hcodec, "config1:22");
+PMU_FORMAT_ATTR(ge2d, "config1:23");
+
+PMU_FORMAT_ATTR(spicc1, "config1:32");
+PMU_FORMAT_ATTR(usb0, "config1:33");
+PMU_FORMAT_ATTR(dma, "config1:34");
+PMU_FORMAT_ATTR(arb0, "config1:35");
+PMU_FORMAT_ATTR(sd_emmc_b, "config1:36");
+PMU_FORMAT_ATTR(usb1, "config1:37");
+PMU_FORMAT_ATTR(audio, "config1:38");
+PMU_FORMAT_ATTR(aififo, "config1:39");
+PMU_FORMAT_ATTR(parser, "config1:41");
+PMU_FORMAT_ATTR(ao_cpu, "config1:42");
+PMU_FORMAT_ATTR(sd_emmc_c, "config1:43");
+PMU_FORMAT_ATTR(spicc2, "config1:44");
+PMU_FORMAT_ATTR(ethernet, "config1:45");
+PMU_FORMAT_ATTR(sana, "config1:46");
+
+/* for sm1 and g12b */
+PMU_FORMAT_ATTR(nna, "config1:10");
+
+/* for g12b only */
+PMU_FORMAT_ATTR(gdc, "config1:11");
+PMU_FORMAT_ATTR(mipi_isp, "config1:12");
+PMU_FORMAT_ATTR(arm1, "config1:13");
+PMU_FORMAT_ATTR(sd_emmc_a, "config1:40");
+
+static struct attribute *g12_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_arm.attr,
+	&format_attr_gpu.attr,
+	&format_attr_nna.attr,
+	&format_attr_gdc.attr,
+	&format_attr_arm1.attr,
+	&format_attr_mipi_isp.attr,
+	&format_attr_sd_emmc_a.attr,
+	&format_attr_pcie.attr,
+	&format_attr_hdcp.attr,
+	&format_attr_hevc_front.attr,
+	&format_attr_usb3_0.attr,
+	&format_attr_device.attr,
+	&format_attr_hevc_back.attr,
+	&format_attr_h265enc.attr,
+	&format_attr_vpu_read1.attr,
+	&format_attr_vpu_read2.attr,
+	&format_attr_vpu_read3.attr,
+	&format_attr_vpu_write1.attr,
+	&format_attr_vpu_write2.attr,
+	&format_attr_vdec.attr,
+	&format_attr_hcodec.attr,
+	&format_attr_ge2d.attr,
+	&format_attr_spicc1.attr,
+	&format_attr_usb0.attr,
+	&format_attr_dma.attr,
+	&format_attr_arb0.attr,
+	&format_attr_sd_emmc_b.attr,
+	&format_attr_usb1.attr,
+	&format_attr_audio.attr,
+	&format_attr_aififo.attr,
+	&format_attr_parser.attr,
+	&format_attr_ao_cpu.attr,
+	&format_attr_sd_emmc_c.attr,
+	&format_attr_spicc2.attr,
+	&format_attr_ethernet.attr,
+	&format_attr_sana.attr,
+	NULL,
+};
+
+/* calculate ddr clock */
+static unsigned long dmc_g12_get_freq_quick(struct dmc_info *info)
+{
+	unsigned int val;
+	unsigned int n, m, od1;
+	unsigned int od_div = 0xfff;
+	unsigned long freq = 0;
+
+	val = readl(info->pll_reg);
+	val = val & 0xfffff;
+	switch ((val >> 16) & 7) {
+	case 0:
+		od_div = 2;
+		break;
+
+	case 1:
+		od_div = 3;
+		break;
+
+	case 2:
+		od_div = 4;
+		break;
+
+	case 3:
+		od_div = 6;
+		break;
+
+	case 4:
+		od_div = 8;
+		break;
+
+	default:
+		break;
+	}
+
+	m = val & 0x1ff;
+	n = ((val >> 10) & 0x1f);
+	od1 = (((val >> 19) & 0x1)) == 1 ? 2 : 1;
+	freq = DEFAULT_XTAL_FREQ / 1000;        /* avoid overflow */
+	if (n)
+		freq = ((((freq * m) / n) >> od1) / od_div) * 1000;
+
+	return freq;
+}
+
+#ifdef DEBUG
+static void g12_dump_reg(struct dmc_info *db)
+{
+	int s = 0, i;
+	unsigned int r;
+
+	for (i = 0; i < 9; i++) {
+		r  = readl(db->ddr_reg[0] + (DMC_MON_G12_CTRL0 + (i << 2)));
+		pr_notice("DMC_MON_CTRL%d:        %08x\n", i, r);
+	}
+	r  = readl(db->ddr_reg[0] + DMC_MON_G12_ALL_REQ_CNT);
+	pr_notice("DMC_MON_ALL_REQ_CNT:  %08x\n", r);
+	r  = readl(db->ddr_reg[0] + DMC_MON_G12_ALL_GRANT_CNT);
+	pr_notice("DMC_MON_ALL_GRANT_CNT:%08x\n", r);
+	r  = readl(db->ddr_reg[0] + DMC_MON_G12_ONE_GRANT_CNT);
+	pr_notice("DMC_MON_ONE_GRANT_CNT:%08x\n", r);
+	r  = readl(db->ddr_reg[0] + DMC_MON_G12_SEC_GRANT_CNT);
+	pr_notice("DMC_MON_SEC_GRANT_CNT:%08x\n", r);
+	r  = readl(db->ddr_reg[0] + DMC_MON_G12_THD_GRANT_CNT);
+	pr_notice("DMC_MON_THD_GRANT_CNT:%08x\n", r);
+	r  = readl(db->ddr_reg[0] + DMC_MON_G12_FOR_GRANT_CNT);
+	pr_notice("DMC_MON_FOR_GRANT_CNT:%08x\n", r);
+	r  = readl(db->ddr_reg[0] + DMC_MON_G12_TIMER);
+	pr_notice("DMC_MON_TIMER:        %08x\n", r);
+}
+#endif
+
+static void dmc_g12_counter_enable(struct dmc_info *info)
+{
+	unsigned int val;
+	unsigned long clock_count = dmc_g12_get_freq_quick(info) / 10; /* 100ms */
+
+	writel(clock_count, info->ddr_reg[0] + DMC_MON_G12_TIMER);
+
+	val = readl(info->ddr_reg[0] + DMC_MON_G12_CTRL0);
+
+	/* enable all channel */
+	val =  BIT(31) |	/* enable bit */
+	       BIT(20) |	/* use timer  */
+	       0x0f;		/* 4 channels */
+
+	writel(val, info->ddr_reg[0] + DMC_MON_G12_CTRL0);
+
+#ifdef DEBUG
+	g12_dump_reg(info);
+#endif
+}
+
+static void dmc_g12_config_fiter(struct dmc_info *info,
+				 int port, int channel)
+{
+	u32 val;
+	u32 rp[MAX_CHANNEL_NUM] = {DMC_MON_G12_CTRL1, DMC_MON_G12_CTRL3,
+					DMC_MON_G12_CTRL5, DMC_MON_G12_CTRL7};
+	u32 rs[MAX_CHANNEL_NUM] = {DMC_MON_G12_CTRL2, DMC_MON_G12_CTRL4,
+					DMC_MON_G12_CTRL6, DMC_MON_G12_CTRL8};
+	int subport = -1;
+
+	/* clear all port mask */
+	if (port < 0) {
+		writel(0, info->ddr_reg[0] + rp[channel]);
+		writel(0, info->ddr_reg[0] + rs[channel]);
+		return;
+	}
+
+	if (port >= PORT_MAJOR)
+		subport = port - PORT_MAJOR;
+
+	if (subport < 0) {
+		val = readl(info->ddr_reg[0] + rp[channel]);
+		val |=  (1 << port);
+		writel(val, info->ddr_reg[0] + rp[channel]);
+		val = 0xffff;
+		writel(val, info->ddr_reg[0] + rs[channel]);
+	} else {
+		val = BIT(23);		/* select device */
+		writel(val, info->ddr_reg[0] + rp[channel]);
+		val = readl(info->ddr_reg[0] + rs[channel]);
+		val |= (1 << subport);
+		writel(val, info->ddr_reg[0] + rs[channel]);
+	}
+}
+
+static void dmc_g12_set_axi_filter(struct dmc_info *info, int axi_id, int channel)
+{
+	if (channel > info->hw_info->chann_nr)
+		return;
+
+	dmc_g12_config_fiter(info, axi_id, channel);
+}
+
+static void dmc_g12_counter_disable(struct dmc_info *info)
+{
+	int i;
+
+	/* clear timer */
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_CTRL0);
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_TIMER);
+
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_ALL_REQ_CNT);
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_ALL_GRANT_CNT);
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_ONE_GRANT_CNT);
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_SEC_GRANT_CNT);
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_THD_GRANT_CNT);
+	writel(0, info->ddr_reg[0] + DMC_MON_G12_FOR_GRANT_CNT);
+
+	/* clear port channel mapping */
+	for (i = 0; i < info->hw_info->chann_nr; i++)
+		dmc_g12_config_fiter(info, -1, i);
+}
+
+static void dmc_g12_get_counters(struct dmc_info *info,
+				 struct dmc_counter *counter)
+{
+	int i;
+	unsigned int reg;
+
+	counter->all_cnt = readl(info->ddr_reg[0] + DMC_MON_G12_ALL_GRANT_CNT);
+	counter->all_req   = readl(info->ddr_reg[0] + DMC_MON_G12_ALL_REQ_CNT);
+
+	for (i = 0; i < info->hw_info->chann_nr; i++) {
+		reg = DMC_MON_G12_ONE_GRANT_CNT + (i << 2);
+		counter->channel_cnt[i] = readl(info->ddr_reg[0] + reg);
+	}
+}
+
+static int dmc_g12_irq_handler(struct dmc_info *info,
+			       struct dmc_counter *counter)
+{
+	unsigned int val;
+	int ret = -EINVAL;
+
+	val = readl(info->ddr_reg[0] + DMC_MON_G12_CTRL0);
+	if (val & DMC_QOS_IRQ) {
+		dmc_g12_get_counters(info, counter);
+		/* clear irq flags */
+		writel(val, info->ddr_reg[0] + DMC_MON_G12_CTRL0);
+		ret = 0;
+	}
+	return ret;
+}
+
+static const struct dmc_hw_info g12a_dmc_info = {
+	.enable		= dmc_g12_counter_enable,
+	.disable	= dmc_g12_counter_disable,
+	.irq_handler	= dmc_g12_irq_handler,
+	.get_counters	= dmc_g12_get_counters,
+	.set_axi_filter	= dmc_g12_set_axi_filter,
+
+	.dmc_nr = 1,
+	.chann_nr = 4,
+	.capability = {0X7EFF00FF03DF, 0},
+	.fmt_attr = g12_pmu_format_attrs,
+};
+
+static const struct dmc_hw_info g12b_dmc_info = {
+	.enable		= dmc_g12_counter_enable,
+	.disable	= dmc_g12_counter_disable,
+	.irq_handler	= dmc_g12_irq_handler,
+	.get_counters	= dmc_g12_get_counters,
+	.set_axi_filter	= dmc_g12_set_axi_filter,
+
+	.dmc_nr = 1,
+	.chann_nr = 4,
+	.capability = {0X7FFF00FF3FDF, 0},
+	.fmt_attr = g12_pmu_format_attrs,
+};
+
+static const struct dmc_hw_info sm1_dmc_info = {
+	.enable		= dmc_g12_counter_enable,
+	.disable	= dmc_g12_counter_disable,
+	.irq_handler	= dmc_g12_irq_handler,
+	.get_counters	= dmc_g12_get_counters,
+	.set_axi_filter	= dmc_g12_set_axi_filter,
+
+	.dmc_nr = 1,
+	.chann_nr = 4,
+	.capability = {0X7EFF00FF07DF, 0},
+	.fmt_attr = g12_pmu_format_attrs,
+};
+
+static int g12_ddr_pmu_probe(struct platform_device *pdev)
+{
+	return meson_ddr_pmu_create(pdev);
+}
+
+static int g12_ddr_pmu_remove(struct platform_device *pdev)
+{
+	meson_ddr_pmu_remove(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id meson_ddr_pmu_dt_match[] = {
+	{
+		.compatible = "amlogic,g12a-ddr-pmu",
+		.data = &g12a_dmc_info,
+	},
+	{
+		.compatible = "amlogic,g12b-ddr-pmu",
+		.data = &g12b_dmc_info,
+	},
+	{
+		.compatible = "amlogic,sm1-ddr-pmu",
+		.data = &sm1_dmc_info,
+	},
+	{}
+};
+
+static struct platform_driver g12_ddr_pmu_driver = {
+	.probe = g12_ddr_pmu_probe,
+	.remove = g12_ddr_pmu_remove,
+
+	.driver = {
+		.name = "amlogic,g12-ddr-pmu",
+		.of_match_table = meson_ddr_pmu_dt_match,
+	},
+};
+
+module_platform_driver(g12_ddr_pmu_driver);
+MODULE_AUTHOR("Jiucheng Xu");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Amlogic G12 series SoC DDR PMU");
diff --git a/include/soc/amlogic/meson_ddr_pmu.h b/include/soc/amlogic/meson_ddr_pmu.h
new file mode 100644
index 000000000000..4a33e4ab8ada
--- /dev/null
+++ b/include/soc/amlogic/meson_ddr_pmu.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __MESON_DDR_PMU_H__
+#define __MESON_DDR_PMU_H__
+
+#define MAX_CHANNEL_NUM		8
+
+enum {
+	ALL_CHAN_COUNTER_ID,
+	CHAN1_COUNTER_ID,
+	CHAN2_COUNTER_ID,
+	CHAN3_COUNTER_ID,
+	CHAN4_COUNTER_ID,
+	CHAN5_COUNTER_ID,
+	CHAN6_COUNTER_ID,
+	CHAN7_COUNTER_ID,
+	CHAN8_COUNTER_ID,
+	COUNTER_MAX_ID,
+};
+
+struct dmc_info;
+
+struct dmc_counter {
+	u64 all_cnt;	/* The count of all requests come in/out ddr controller */
+	union {
+		u64 all_req;
+		struct {
+			u64 all_idle_cnt;
+			u64 all_16bit_cnt;
+		};
+	};
+	u64 channel_cnt[MAX_CHANNEL_NUM]; /* To save a DMC bandwidth-monitor channel counter */
+};
+
+struct dmc_hw_info {
+	void (*enable)(struct dmc_info *info);
+	void (*disable)(struct dmc_info *info);
+	/* Bind an axi line to a bandwidth-monitor channel */
+	void (*set_axi_filter)(struct dmc_info *info, int axi_id, int chann);
+	int (*irq_handler)(struct dmc_info *info,
+			   struct dmc_counter *counter);
+	void (*get_counters)(struct dmc_info *info,
+			     struct dmc_counter *counter);
+
+	int dmc_nr;			/* The number of dmc controller */
+	int chann_nr;			/* The number of dmc bandwidth monitor channels */
+	struct attribute **fmt_attr;
+	const u64 capability[2];
+};
+
+struct dmc_info {
+	const struct dmc_hw_info *hw_info;
+
+	void __iomem *ddr_reg[4];
+	unsigned long timer_value;	/* Timer value in TIMER register */
+	void __iomem *pll_reg;
+	int irq_num;			/* irq vector number */
+};
+
+int meson_ddr_pmu_create(struct platform_device *pdev);
+int meson_ddr_pmu_remove(struct platform_device *pdev);
+
+#endif /* __MESON_DDR_PMU_H__ */

base-commit: 7e7a24c3c6c98abc4425abd1dbf2a71b42dfafcf
-- 
2.25.1

