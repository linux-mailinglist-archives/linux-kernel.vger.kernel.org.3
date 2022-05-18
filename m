Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670EA52B25C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiERGbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiERGbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:37 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B039CB4B3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:35 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="72779168"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="72779168"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:33 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B6E01D502D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:32 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id EFD23141C4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:31 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 80359400D50DB;
        Wed, 18 May 2022 15:31:31 +0900 (JST)
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
Subject: [PATCH v4 6/8] x86: Add hardware prefetch control support for x86
Date:   Wed, 18 May 2022 15:30:30 +0900
Message-Id: <20220518063032.2377351-7-tarumizu.kohei@fujitsu.com>
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
 arch/x86/kernel/cpu/x86-pfctl.c | 258 ++++++++++++++++++++++++++++++++
 1 file changed, 258 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/x86-pfctl.c

diff --git a/arch/x86/kernel/cpu/x86-pfctl.c b/arch/x86/kernel/cpu/x86-pfctl.c
new file mode 100644
index 000000000000..0b3b22128dff
--- /dev/null
+++ b/arch/x86/kernel/cpu/x86-pfctl.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * x86 Hardware Prefetch Control support
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pfctl.h>
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
+static struct device_attribute *l1_attrs[] __ro_after_init = {
+	&attr_l1_hardware_prefetcher_enable.attr,
+	&attr_l1_ip_prefetcher_enable.attr,
+	NULL,
+};
+
+static struct device_attribute *l2_attrs[] __ro_after_init = {
+	&attr_l2_hardware_prefetcher_enable.attr,
+	&attr_l2_adjacent_cache_line_prefetcher_enable.attr,
+	NULL,
+};
+
+static const struct pfctl_group x86_pfctl_groups[] = {
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
+
+static int __init x86_pfctl_init(void)
+{
+	const struct x86_cpu_id *m;
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
+	return pfctl_register_attrs(x86_pfctl_groups);
+}
+
+static void __exit x86_pfctl_exit(void)
+{
+	return pfctl_unregister_attrs(x86_pfctl_groups);
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

