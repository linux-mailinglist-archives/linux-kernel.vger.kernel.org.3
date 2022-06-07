Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6859553FE68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbiFGMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243450AbiFGMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:57 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A768BD10
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:07:46 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="75590274"
X-IronPort-AV: E=Sophos;i="5.91,283,1647270000"; 
   d="scan'208";a="75590274"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Jun 2022 21:07:44 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2F22FD5028;
        Tue,  7 Jun 2022 21:07:43 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 389EED05F3;
        Tue,  7 Jun 2022 21:07:42 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id D6DFC4008021D;
        Tue,  7 Jun 2022 21:07:41 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org,
        eugenis@google.com, tony.luck@intel.com, pcc@google.com,
        peterz@infradead.org, marcos@orca.pet, marcan@marcan.st,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v5 4/6] x86: Add hardware prefetch control driver for x86
Date:   Tue,  7 Jun 2022 21:05:28 +0900
Message-Id: <20220607120530.2447112-5-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
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

Adds module init/exit code to create sysfs attributes for x86 with
"hardware_prefetcher_enable", "ip_prefetcher_enable" and
"adjacent_cache_line_prefetcher_enable".

This driver works only if a CPU model is mapped to type of register
specification(e.g. TYPE_L12_BASE) in pfctl_match[].

The details of the registers(MSR_MISC_FEATURE_CONTROL) to be read and
written in this patch are described below:

"https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html"
    Volume 4

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 arch/x86/kernel/cpu/x86-pfctl.c | 363 ++++++++++++++++++++++++++++++++
 1 file changed, 363 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/x86-pfctl.c

diff --git a/arch/x86/kernel/cpu/x86-pfctl.c b/arch/x86/kernel/cpu/x86-pfctl.c
new file mode 100644
index 000000000000..154e927d092c
--- /dev/null
+++ b/arch/x86/kernel/cpu/x86-pfctl.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * x86 Hardware Prefetch Control support
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/sysfs.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <asm/msr.h>
+
+/*
+ * MSR_MISC_FEATURE_CONTROL has three type of register specifications.
+ *
+ * The register specification of TYPE_L12_BASE is as follow:
+ * [0]    L2 Hardware Prefetcher Disable (R/W)
+ * [1]    Reserved
+ * [2]    DCU Hardware Prefetcher Disable (R/W)
+ * [63:3] Reserved
+ *
+ * The register specification of TYPE_L12_PLUS is as follow:
+ * [0]    L2 Hardware Prefetcher Disable (R/W)
+ * [1]    L2 Adjacent Cache Line Prefetcher Disable (R/W)
+ * [2]    DCU Hardware Prefetcher Disable (R/W)
+ * [3]    DCU IP Prefetcher Disable (R/W)
+ * [63:4] Reserved
+ *
+ * The register specification of TYPE_L12_XPHI is as follow:
+ * [0]    L2 Hardware Prefetcher Disable (R/W)
+ * [1]    DCU Hardware Prefetcher Disable (R/W)
+ * [63:2] Reserved
+ *
+ * See "Intel 64 and IA-32 Architectures Software Developer's Manual"
+ * (https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
+ * for register specification details.
+ */
+enum {
+	TYPE_L12_BASE,
+	TYPE_L12_PLUS,
+	TYPE_L12_XPHI,
+};
+
+struct x86_pfctl_attr {
+	struct device_attribute		attr;
+	u64				mask;
+};
+
+struct pfctl_group {
+	unsigned int			level;
+	enum cache_type			type;
+	const struct attribute_group	**groups;
+};
+
+enum cpuhp_state hp_online;
+
+static inline unsigned int pfctl_dev_get_cpu(struct device *pfctl_dev)
+{
+	return *(u32 *)dev_get_drvdata(pfctl_dev);
+}
+
+static ssize_t
+pfctl_show(struct device *pfctl_dev, struct device_attribute *attr, char *buf)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct x86_pfctl_attr *xa;
+	u64 val;
+
+	xa = container_of(attr, struct x86_pfctl_attr, attr);
+
+	rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &val);
+	return sysfs_emit(buf, "%d\n", val & xa->mask ? 0 : 1);
+}
+
+struct write_info {
+	u64 mask;
+	bool enable;
+};
+
+/*
+ * wrmsrl() in this patch is only done inside of an interrupt-disabled region
+ * to avoid a conflict of write access from other drivers,
+ */
+static void pfctl_write(void *info)
+{
+	struct write_info *winfo = info;
+	u64 reg;
+
+	reg = 0;
+	rdmsrl(MSR_MISC_FEATURE_CONTROL, reg);
+
+	if (winfo->enable)
+		reg &= ~winfo->mask;
+	else
+		reg |= winfo->mask;
+
+	wrmsrl(MSR_MISC_FEATURE_CONTROL, reg);
+}
+
+/*
+ * MSR_MISC_FEATURE_CONTROL has "core" scope, so define the lock to avoid a
+ * conflict of write access from different logical processors in the same core.
+ */
+static DEFINE_MUTEX(pfctl_mutex);
+
+static ssize_t
+pfctl_store(struct device *pfctl_dev, struct device_attribute *attr,
+	    const char *buf, size_t size)
+{
+	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
+	struct x86_pfctl_attr *xa;
+	struct write_info info;
+
+	xa = container_of(attr, struct x86_pfctl_attr, attr);
+	info.mask = xa->mask;
+
+	if (strtobool(buf, &info.enable) < 0)
+		return -EINVAL;
+
+	mutex_lock(&pfctl_mutex);
+	smp_call_function_single(cpu, pfctl_write, &info, true);
+	mutex_unlock(&pfctl_mutex);
+
+	return size;
+}
+
+#define PFCTL_ATTR(_name, _level, _bit)					\
+	struct x86_pfctl_attr attr_l##_level##_##_name = {		\
+		.attr = __ATTR(_name, 0600, pfctl_show, pfctl_store),	\
+		.mask = BIT_ULL(_bit), }
+
+static PFCTL_ATTR(hardware_prefetcher_enable,			1, 2);
+static PFCTL_ATTR(hardware_prefetcher_enable,			2, 0);
+static PFCTL_ATTR(ip_prefetcher_enable,				1, 3);
+static PFCTL_ATTR(adjacent_cache_line_prefetcher_enable,	2, 1);
+
+static struct attribute *l1_attrs[] = {
+	&attr_l1_hardware_prefetcher_enable.attr.attr,
+	&attr_l1_ip_prefetcher_enable.attr.attr,
+	NULL,
+};
+
+static struct attribute *l2_attrs[] = {
+	&attr_l2_hardware_prefetcher_enable.attr.attr,
+	&attr_l2_adjacent_cache_line_prefetcher_enable.attr.attr,
+	NULL,
+};
+
+static struct attribute_group l1_group = {
+	.attrs = l1_attrs,
+};
+
+static struct attribute_group l2_group = {
+	.attrs = l2_attrs,
+};
+
+static const struct attribute_group *l1_groups[] = {
+	&l1_group,
+	NULL,
+};
+
+static const struct attribute_group *l2_groups[] = {
+	&l2_group,
+	NULL,
+};
+
+static const struct pfctl_group pfctl_groups[] = {
+	{
+		.level = 1,
+		.type = CACHE_TYPE_DATA,
+		.groups = l1_groups,
+	},
+	{
+		.level = 2,
+		.type = CACHE_TYPE_UNIFIED,
+		.groups = l2_groups,
+	},
+	{
+		.groups = NULL,
+	},
+};
+
+static const struct attribute_group **
+get_pfctl_attribute_groups(unsigned int level, enum cache_type type)
+{
+	int i;
+
+	for (i = 0; pfctl_groups[i].groups; i++)
+		if ((level == pfctl_groups[i].level) &&
+		    (type == pfctl_groups[i].type))
+			return pfctl_groups[i].groups;
+
+	return NULL;
+}
+
+static int remove_pfctl_attr(struct device *index_dev, void *data)
+{
+	struct device *pfctl_dev;
+
+	pfctl_dev = device_find_child_by_name(index_dev, "prefetch_control");
+	if (!pfctl_dev)
+		return 0;
+
+	device_unregister(pfctl_dev);
+	put_device(pfctl_dev);
+
+	return 0;
+}
+
+static int create_pfctl_attr(struct device *index_dev, void *data)
+{
+	struct cacheinfo *leaf = dev_get_drvdata(index_dev);
+	const struct attribute_group **groups;
+	struct device *pfctl_dev;
+
+	groups = get_pfctl_attribute_groups(leaf->level, leaf->type);
+	if (!groups)
+		return 0;
+
+	pfctl_dev = cpu_device_create(index_dev, data, groups,
+				      "prefetch_control");
+	if (IS_ERR(pfctl_dev))
+		return PTR_ERR(pfctl_dev);
+
+	return 0;
+}
+
+static int pfctl_online(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct device *cache_dev;
+	int ret;
+
+	cache_dev = device_find_child_by_name(cpu_dev, "cache");
+	if (!cache_dev)
+		return -ENODEV;
+
+	ret = device_for_each_child(cache_dev, &cpu_dev->id, create_pfctl_attr);
+
+	put_device(cache_dev);
+
+	return ret;
+}
+
+static int pfctl_prepare_down(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct device *cache_dev;
+
+	cache_dev = device_find_child_by_name(cpu_dev, "cache");
+	if (!cache_dev)
+		return 0;
+
+	device_for_each_child(cache_dev, NULL, remove_pfctl_attr);
+
+	put_device(cache_dev);
+
+	return 0;
+}
+
+/*
+ * Only BROADWELL_X has been tested in the actual machine at this point. Other
+ * models were defined based on the information in the "Intel 64 and IA-32
+ * Architectures Software Developer's Manual"
+ */
+static const struct x86_cpu_id pfctl_match[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	TYPE_L12_BASE),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	TYPE_L12_BASE),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	TYPE_L12_BASE),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	TYPE_L12_BASE),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_G,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		TYPE_L12_PLUS),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	TYPE_L12_XPHI),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	TYPE_L12_XPHI),
+	{},
+};
+MODULE_DEVICE_TABLE(x86cpu, pfctl_match);
+
+static int __init x86_pfctl_init(void)
+{
+	const struct x86_cpu_id *m;
+	int ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
+	m = x86_match_cpu(pfctl_match);
+	if (!m)
+		return -ENODEV;
+
+	switch (m->driver_data) {
+	case TYPE_L12_BASE:
+		l1_attrs[1] = NULL;
+		l2_attrs[1] = NULL;
+		break;
+	case TYPE_L12_PLUS:
+		break;
+	case TYPE_L12_XPHI:
+		attr_l1_hardware_prefetcher_enable.mask = BIT_ULL(1);
+		l1_attrs[1] = NULL;
+		l2_attrs[1] = NULL;
+		break;
+	default:
+		return -ENODEV;
+	};
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/x86-pfctl:online",
+				pfctl_online, pfctl_prepare_down);
+	if (ret < 0) {
+		pr_err("failed to register hotplug callbacks\n");
+		return ret;
+	}
+
+	hp_online = ret;
+
+	return 0;
+}
+
+static void __exit x86_pfctl_exit(void)
+{
+	cpuhp_remove_state(hp_online);
+}
+
+late_initcall(x86_pfctl_init);
+module_exit(x86_pfctl_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("FUJITSU LIMITED");
+MODULE_DESCRIPTION("x86 Hardware Prefetch Control Driver");
-- 
2.27.0

