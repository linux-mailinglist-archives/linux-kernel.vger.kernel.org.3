Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F64D5F61
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347920AbiCKKYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347834AbiCKKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:49 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E4140B2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:41 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="45468777"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="45468777"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 19:21:37 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B0B6AE3E10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:36 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D43DBD05E2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:35 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 92C76406139C9;
        Fri, 11 Mar 2022 19:21:35 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 6/8] x86: Add hardware prefetch control support for x86
Date:   Fri, 11 Mar 2022 19:19:38 +0900
Message-Id: <20220311101940.3403607-7-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
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

This adds module init/exit code, and creates sysfs attribute file
"hardware_prefetcher_enable", "ip_prefetcher_enable" and
"adjacent_cache_line_prefetcher_enable" for x86. This driver works
only if the model is INTEL_FAM6_BROADWELL_X at this point.

If you would like to support a new model with the same register
specifications as INTEL_FAM6_BROADWELL_X, it is possible to add the
model settings to array of broadwell_cpu_ids[].

The details of the registers to be read and written in this patch are
described below:

"https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html"
    Volume 4

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 arch/x86/kernel/cpu/pfctl.c | 314 ++++++++++++++++++++++++++++++++++++
 1 file changed, 314 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/pfctl.c

diff --git a/arch/x86/kernel/cpu/pfctl.c b/arch/x86/kernel/cpu/pfctl.c
new file mode 100644
index 000000000000..be2dce644808
--- /dev/null
+++ b/arch/x86/kernel/cpu/pfctl.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * x86 Hardware Prefetch Control support
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cacheinfo.h>
+#include <linux/pfctl.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <asm/msr.h>
+
+struct pfctl_driver x86_pfctl_driver;
+
+/**************************************
+ * Intle BROADWELL support
+ **************************************/
+
+/*
+ * The register specification for each bits of Intel BROADWELL is as
+ * follow:
+ *
+ * [0]    L2 Hardware Prefetcher Disable (R/W)
+ * [1]    L2 Adjacent Cache Line Prefetcher Disable (R/W)
+ * [2]    DCU Hardware Prefetcher Disable (R/W)
+ * [3]    DCU IP Prefetcher Disable (R/W)
+ * [63:4] Reserved
+ *
+ * See "Intel 64 and IA-32 Architectures Software Developer's Manual"
+ * (https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
+ * for register specification details.
+ */
+#define BROADWELL_L2_HWPF_FIELD		BIT_ULL(0)
+#define BROADWELL_L2_ACLPF_FIELD	BIT_ULL(1)
+#define BROADWELL_DCU_HWPF_FIELD	BIT_ULL(2)
+#define BROADWELL_DCU_IPPF_FIELD	BIT_ULL(3)
+
+static int broadwell_get_hwpf_enable(u64 reg, unsigned int level)
+{
+	u64 val;
+
+	switch (level) {
+	case 1:
+		val = FIELD_GET(BROADWELL_DCU_HWPF_FIELD, reg);
+		break;
+	case 2:
+		val = FIELD_GET(BROADWELL_L2_HWPF_FIELD, reg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val == 0)
+		return PFCTL_ENABLE_VAL;
+	else if (val == 1)
+		return PFCTL_DISABLE_VAL;
+	else
+		return -EINVAL;
+}
+
+static int broadwell_modify_hwpf_enable(u64 *reg, unsigned int level, u64 val)
+{
+	if (val == PFCTL_ENABLE_VAL)
+		val = 0;
+	else
+		val = 1;
+
+	switch (level) {
+	case 1:
+		*reg &= ~BROADWELL_DCU_HWPF_FIELD;
+		*reg |= FIELD_PREP(BROADWELL_DCU_HWPF_FIELD, val);
+		break;
+	case 2:
+		*reg &= ~BROADWELL_L2_HWPF_FIELD;
+		*reg |= FIELD_PREP(BROADWELL_L2_HWPF_FIELD, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int broadwell_get_ippf_enable(u64 reg, unsigned int level)
+{
+	u64 val;
+
+	switch (level) {
+	case 1:
+		val = FIELD_GET(BROADWELL_DCU_IPPF_FIELD, reg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val == 0)
+		return PFCTL_ENABLE_VAL;
+	else if (val == 1)
+		return PFCTL_DISABLE_VAL;
+	else
+		return -EINVAL;
+}
+
+static int broadwell_modify_ippf_enable(u64 *reg, unsigned int level, u64 val)
+{
+	if (val == PFCTL_ENABLE_VAL)
+		val = 0;
+	else
+		val = 1;
+
+	switch (level) {
+	case 1:
+		*reg &= ~BROADWELL_DCU_IPPF_FIELD;
+		*reg |= FIELD_PREP(BROADWELL_DCU_IPPF_FIELD, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int broadwell_get_aclpf_enable(u64 reg, unsigned int level)
+{
+	u64 val;
+
+	switch (level) {
+	case 2:
+		val = FIELD_GET(BROADWELL_L2_ACLPF_FIELD, reg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val == 0)
+		return PFCTL_ENABLE_VAL;
+	else if (val == 1)
+		return PFCTL_DISABLE_VAL;
+	else
+		return -EINVAL;
+}
+
+static int broadwell_modify_aclpf_enable(u64 *reg, unsigned int level, u64 val)
+{
+	if (val == PFCTL_ENABLE_VAL)
+		val = 0;
+	else
+		val = 1;
+
+	switch (level) {
+	case 2:
+		*reg &= ~BROADWELL_L2_ACLPF_FIELD;
+		*reg |= FIELD_PREP(BROADWELL_L2_ACLPF_FIELD, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int broadwell_get_pfctl_params(enum pfctl_attr pattr, u64 reg,
+				      unsigned int level, u64 *val)
+{
+	int ret;
+
+	switch (pattr) {
+	case HWPF_ENABLE:
+		ret = broadwell_get_hwpf_enable(reg, level);
+		break;
+	case IPPF_ENABLE:
+		ret = broadwell_get_ippf_enable(reg, level);
+		break;
+	case ACLPF_ENABLE:
+		ret = broadwell_get_aclpf_enable(reg, level);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (ret < 0)
+		return ret;
+	*val = ret;
+
+	return 0;
+}
+
+static int broadwell_modify_pfreg(enum pfctl_attr pattr, u64 *reg,
+				  unsigned int level, u64 val)
+{
+	int ret;
+
+	switch (pattr) {
+	case HWPF_ENABLE:
+		ret = broadwell_modify_hwpf_enable(reg, level, val);
+		break;
+	case IPPF_ENABLE:
+		ret = broadwell_modify_ippf_enable(reg, level, val);
+		break;
+	case ACLPF_ENABLE:
+		ret = broadwell_modify_aclpf_enable(reg, level, val);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int broadwell_read_pfreg(enum pfctl_attr pattr, unsigned int cpu,
+				unsigned int level, u64 *val)
+{
+	int ret;
+	u64 reg;
+
+	ret = rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &reg);
+	if (ret)
+		return ret;
+
+	ret = broadwell_get_pfctl_params(pattr, reg, level, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int broadwell_write_pfreg(enum pfctl_attr pattr, unsigned int cpu,
+				 unsigned int level, u64 val)
+{
+	int ret;
+	u64 reg;
+
+	ret = rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &reg);
+	if (ret)
+		return ret;
+
+	ret = broadwell_modify_pfreg(pattr, &reg, level, val);
+	if (ret < 0)
+		return ret;
+
+	ret = wrmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, reg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * In addition to BROADWELL_X, NEHALEM and others have same register
+ * specifications as those represented by BROADWELL_XXX_FIELD.
+ * If you want to add support for these processor, add the new target model
+ * here.
+ */
+static const struct x86_cpu_id broadwell_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, NULL),
+	{}
+};
+
+/***** end of Intel BROADWELL support *****/
+
+/*
+ * This driver returns a negative value if it does not support the Hardware
+ * Prefetch Control or if it is running on a VM guest.
+ */
+static int __init setup_pfctl_driver_params(void)
+{
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return -EINVAL;
+
+	if (x86_match_cpu(broadwell_cpu_ids)) {
+		x86_pfctl_driver.supported_l1d_prefetcher = HWPF|IPPF;
+		x86_pfctl_driver.supported_l2_prefetcher = HWPF|ACLPF;
+		x86_pfctl_driver.read_pfreg = broadwell_read_pfreg;
+		x86_pfctl_driver.write_pfreg = broadwell_write_pfreg;
+	} else {
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int __init x86_pfctl_init(void)
+{
+	int ret;
+
+	ret = setup_pfctl_driver_params();
+	if (ret < 0)
+		return ret;
+
+	ret = pfctl_register_driver(&x86_pfctl_driver);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __exit x86_pfctl_exit(void)
+{
+	pfctl_unregister_driver(&x86_pfctl_driver);
+}
+
+late_initcall(x86_pfctl_init);
+module_exit(x86_pfctl_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("FUJITSU LIMITED");
+MODULE_DESCRIPTION("x86 Hardware Prefetch Control Driver");
-- 
2.27.0

