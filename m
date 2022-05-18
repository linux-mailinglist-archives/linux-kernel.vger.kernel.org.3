Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17AF52B257
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiERGeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiERGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:31 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16754A473
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:29 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="61256555"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="61256555"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:27 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D0D32D687B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:26 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D550F0FE5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:26 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 924EB4007E8A3;
        Wed, 18 May 2022 15:31:25 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, mchehab+huawei@kernel.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, conor.dooley@microchip.com,
        nicolas.ferre@microchip.com, marcan@marcan.st,
        linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v4 3/8] soc: fujitsu: Add hardware prefetch control support for A64FX
Date:   Wed, 18 May 2022 15:30:27 +0900
Message-Id: <20220518063032.2377351-4-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds module init/exit code to create sysfs attributes for A64FX with
"stream_detect_prefetcher_enable", "stream_detect_prefetcher_strong"
and "stream_detect_prefetcher_dist".

This driver works only if part number is FUJITSU_CPU_PART_A64FX. The
details of the registers to be read and written in this patch are
described below.

"https://github.com/fujitsu/A64FX/tree/master/doc/"
    A64FX_Specification_HPC_Extension_v1_EN.pdf

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/soc/fujitsu/a64fx-pfctl.c | 373 ++++++++++++++++++++++++++++++
 1 file changed, 373 insertions(+)
 create mode 100644 drivers/soc/fujitsu/a64fx-pfctl.c

diff --git a/drivers/soc/fujitsu/a64fx-pfctl.c b/drivers/soc/fujitsu/a64fx-pfctl.c
new file mode 100644
index 000000000000..f765f53987d4
--- /dev/null
+++ b/drivers/soc/fujitsu/a64fx-pfctl.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * A64FX Hardware Prefetch Control support
+ */
+
+#include <asm/cputype.h>
+#include <linux/cacheinfo.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pfctl.h>
+#include <linux/smp.h>
+#include <linux/sysfs.h>
+
+/*
+ * Constants for these add the "A64FX_SDPF" prefix to the name described in
+ * section "1.3.4.2. IMP_PF_STREAM_DETECT_CTRL_EL0" of "A64FX specification".
+ * (https://github.com/fujitsu/A64FX/tree/master/doc/A64FX_Specification_HPC_Extension_v1_EN.pdf")
+ * See this document for register specification details.
+ */
+#define A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0	sys_reg(3, 3, 11, 4, 0)
+#define A64FX_SDPF_V					BIT_ULL(63)
+#define A64FX_SDPF_L1PF_DIS				BIT_ULL(59)
+#define A64FX_SDPF_L2PF_DIS				BIT_ULL(58)
+#define A64FX_SDPF_L1W					BIT_ULL(55)
+#define A64FX_SDPF_L2W					BIT_ULL(54)
+#define A64FX_SDPF_L1_DIST				GENMASK_ULL(27, 24)
+#define A64FX_SDPF_L2_DIST				GENMASK_ULL(19, 16)
+
+#define PFCTL_MIN_L1_DIST				256
+#define PFCTL_MIN_L2_DIST				1024
+#define PFCTL_DIST_AUTO_VAL				0
+#define PFCTL_STRONG_VAL				0
+#define PFCTL_WEAK_VAL					1
+
+/*
+ * Define bitfield access macros for non-constant mask, because macros such as
+ * FIELD_FIT defined in include/linux/bitfield.h require constant mask.
+ */
+#define NC_FIELD_FIT(_mask, _val)					\
+	!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask))
+
+#define NC_FIELD_PREP(_mask, _val)					\
+	(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))
+
+#define NC_FIELD_GET(_mask, _reg)					\
+	((typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)))
+
+struct a64fx_pfctl_attr {
+	struct device_attribute	attr;
+	u64			mask;
+	void			*data;
+};
+
+static const char strength_strong_string[] = "strong";
+static const char strength_weak_string[] = "weak";
+static const char dist_auto_string[] = "auto";
+
+/*
+ * Returns the cpu number of the cpu_device(/sys/devices/system/cpu/cpuX)
+ * in the ancestor directory of prefetch_control.
+ *
+ * When initializing this driver, it is verified that the cache directory exists
+ * under cpuX device. Therefore, the third level up from prefetch_control is
+ * cpuX device as shown below.
+ *
+ * /sys/devices/system/cpu/cpuX/cache/indexX/prefetch_control
+ */
+static inline unsigned int pfctl_dev_get_cpu(struct device *pfctl_dev)
+{
+	return pfctl_dev->parent->parent->parent->id;
+}
+
+/* Enable the value written to the A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0 */
+static inline void enable_verify(u64 *reg)
+{
+	*reg |= NC_FIELD_PREP(A64FX_SDPF_V, 1);
+}
+
+static void _pfctl_read_mask(void *_reg)
+{
+	u64 *reg = (u64 *)_reg;
+
+	*reg = read_sysreg_s(A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+}
+
+static u64 pfctl_read_mask(unsigned int cpu, u64 mask)
+{
+	u64 reg;
+
+	smp_call_function_single(cpu, _pfctl_read_mask, &reg, true);
+
+	return NC_FIELD_GET(mask, reg);
+}
+
+struct write_info {
+	u64 mask;
+	u64 val;
+};
+
+static void _pfctl_write_mask(void *info)
+{
+	struct write_info *winfo = info;
+	u64 reg;
+
+	reg = read_sysreg_s(A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	reg &= ~winfo->mask;
+	reg |= NC_FIELD_PREP(winfo->mask, winfo->val);
+
+	enable_verify(&reg);
+
+	write_sysreg_s(reg, A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+}
+
+static int pfctl_write_mask(unsigned int cpu, u64 mask, u64 val)
+{
+	struct write_info info = {
+		.mask	= mask,
+		.val	= val,
+	};
+
+	if (!NC_FIELD_FIT(mask, val))
+		return -EINVAL;
+
+	smp_call_function_single(cpu, _pfctl_write_mask, &info, true);
+
+	return 0;
+}
+
+static ssize_t
+pfctl_enable_show(struct device *pfctl_dev, struct device_attribute *attr,
+		char *buf)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct a64fx_pfctl_attr *aa;
+	bool val;
+
+	aa = container_of(attr, struct a64fx_pfctl_attr, attr);
+
+	val = (bool)pfctl_read_mask(cpu, aa->mask);
+
+	return sysfs_emit(buf, "%d\n", val ? 0 : 1);
+}
+
+static ssize_t
+pfctl_enable_store(struct device *pfctl_dev, struct device_attribute *attr,
+		 const char *buf, size_t size)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct a64fx_pfctl_attr *aa;
+	bool val;
+	int ret;
+
+	aa = container_of(attr, struct a64fx_pfctl_attr, attr);
+
+	if (strtobool(buf, &val) < 0)
+		return -EINVAL;
+
+	ret = pfctl_write_mask(cpu, aa->mask, val ? 0 : 1);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+
+#define A64FX_PFCTL_ENABLE_ATTR(_level, _mask)				\
+	struct a64fx_pfctl_attr attr_l##_level##_enable = {		\
+		.attr = __ATTR(stream_detect_prefetcher_enable, 0600,	\
+			       pfctl_enable_show, pfctl_enable_store),	\
+		.mask = _mask, }
+
+
+static A64FX_PFCTL_ENABLE_ATTR(1, A64FX_SDPF_L1PF_DIS);
+static A64FX_PFCTL_ENABLE_ATTR(2, A64FX_SDPF_L2PF_DIS);
+
+static ssize_t
+pfctl_dist_show(struct device *pfctl_dev, struct device_attribute *attr,
+		char *buf)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct a64fx_pfctl_attr *aa;
+	u64 val, min_dist;
+
+	aa = container_of(attr, struct a64fx_pfctl_attr, attr);
+	min_dist = (u64)aa->data;
+
+	val = pfctl_read_mask(cpu, aa->mask);
+
+	if (val == PFCTL_DIST_AUTO_VAL)
+		return sysfs_emit(buf, "%s\n", dist_auto_string);
+	else
+		return sysfs_emit(buf, "%llu\n", val * min_dist);
+}
+
+static ssize_t
+pfctl_dist_store(struct device *pfctl_dev, struct device_attribute *attr,
+		 const char *buf, size_t size)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct a64fx_pfctl_attr *aa;
+	u64 min_dist, val;
+	int ret;
+
+	aa = container_of(attr, struct a64fx_pfctl_attr, attr);
+	min_dist = (u64)aa->data;
+
+	if (sysfs_streq(buf, dist_auto_string)) {
+		val = PFCTL_DIST_AUTO_VAL;
+	} else {
+		ret = kstrtoull(buf, 10, &val);
+		if (ret < 0 || val < 1)
+			return -EINVAL;
+	}
+
+	val = roundup(val, min_dist) / min_dist;
+
+	if (!NC_FIELD_FIT(aa->mask, val))
+		return -EINVAL;
+
+	ret = pfctl_write_mask(cpu, aa->mask, val);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+
+#define PFCTL_DIST_ATTR(_level, _mask, _min_dist)			\
+	struct a64fx_pfctl_attr attr_l##_level##_dist = {		\
+		.attr = __ATTR(stream_detect_prefetcher_dist, 0600,	\
+			       pfctl_dist_show, pfctl_dist_store),	\
+		.mask = _mask,						\
+		.data = (void *)(u64)_min_dist, }
+
+static PFCTL_DIST_ATTR(1, A64FX_SDPF_L1_DIST, PFCTL_MIN_L1_DIST);
+static PFCTL_DIST_ATTR(2, A64FX_SDPF_L2_DIST, PFCTL_MIN_L2_DIST);
+
+static ssize_t
+pfctl_strength_show(struct device *pfctl_dev, struct device_attribute *attr,
+		    char *buf)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct a64fx_pfctl_attr *aa;
+	u64 val;
+
+	aa = container_of(attr, struct a64fx_pfctl_attr, attr);
+
+	val = pfctl_read_mask(cpu, aa->mask);
+
+	switch (val) {
+	case PFCTL_STRONG_VAL:
+		return sysfs_emit(buf, "%s\n", strength_strong_string);
+	case PFCTL_WEAK_VAL:
+		return sysfs_emit(buf, "%s\n", strength_weak_string);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t
+pfctl_strength_store(struct device *pfctl_dev, struct device_attribute *attr,
+		     const char *buf, size_t size)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct a64fx_pfctl_attr *aa;
+	u64 val;
+	int ret;
+
+	aa = container_of(attr, struct a64fx_pfctl_attr, attr);
+
+	if (sysfs_streq(buf, strength_strong_string))
+		val = PFCTL_STRONG_VAL;
+	else if (sysfs_streq(buf, strength_weak_string))
+		val = PFCTL_WEAK_VAL;
+	else
+		return -EINVAL;
+
+	ret = pfctl_write_mask(cpu, aa->mask, val);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+
+#define PFCTL_STRENGTH_ATTR(_level, _mask)				\
+	struct a64fx_pfctl_attr attr_l##_level##_strength = {		\
+		.attr = __ATTR(stream_detect_prefetcher_strength, 0600, \
+			       pfctl_strength_show,			\
+			       pfctl_strength_store),			\
+		.mask = _mask, }
+
+static PFCTL_STRENGTH_ATTR(1, A64FX_SDPF_L1W);
+static PFCTL_STRENGTH_ATTR(2, A64FX_SDPF_L2W);
+
+static ssize_t
+pfctl_strength_available_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%s %s\n", strength_strong_string,
+			  strength_weak_string);
+}
+
+/*
+ * A64FX has same kind of available strength for any caches, so define only one
+ * attribute.
+ */
+struct a64fx_pfctl_attr attr_strength_available = {
+	.attr = __ATTR(stream_detect_prefetcher_strength_available, 0400,
+		       pfctl_strength_available_show, NULL), };
+
+static struct device_attribute *l1_attrs[] __ro_after_init = {
+	&attr_l1_enable.attr,
+	&attr_l1_dist.attr,
+	&attr_l1_strength.attr,
+	&attr_strength_available.attr,
+	NULL,
+};
+
+static struct device_attribute *l2_attrs[] __ro_after_init = {
+	&attr_l2_enable.attr,
+	&attr_l2_dist.attr,
+	&attr_l2_strength.attr,
+	&attr_strength_available.attr,
+	NULL,
+};
+
+static const struct pfctl_group a64fx_pfctl_groups[] = {
+	{
+		.level = 1,
+		.type = CACHE_TYPE_DATA,
+		.attrs = l1_attrs,
+	},
+	{
+		.level = 2,
+		.type = CACHE_TYPE_UNIFIED,
+		.attrs = l2_attrs,
+	},
+	{
+		.attrs = NULL,
+	},
+};
+
+/*
+ * This driver returns a negative value if it does not support the Hardware
+ * Prefetch Control or if it is running on a VM guest.
+ */
+static int __init a64fx_pfctl_init(void)
+{
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
+
+	if (!is_kernel_in_hyp_mode())
+		return -EINVAL;
+
+	if ((implementor != ARM_CPU_IMP_FUJITSU) ||
+	    (part_number != FUJITSU_CPU_PART_A64FX))
+		return -ENODEV;
+
+	return pfctl_register_attrs(a64fx_pfctl_groups);
+}
+
+static void __exit a64fx_pfctl_exit(void)
+{
+	return pfctl_unregister_attrs(a64fx_pfctl_groups);
+}
+
+late_initcall(a64fx_pfctl_init);
+module_exit(a64fx_pfctl_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("FUJITSU LIMITED");
+MODULE_DESCRIPTION("A64FX Hardware Prefetch Control Driver");
-- 
2.27.0

