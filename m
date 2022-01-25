Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA649AD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445441AbiAYH23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:28:29 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:58197 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1444472AbiAYHV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:21:58 -0500
IronPort-SDR: 2wYmYFIqB50Kl3K75d8Gh1y3pMpLSA0zBgkLFr1raQFCxz+TQHJIvgeHy8YjFR/hTLJL9XSnid
 xYSl6u35I41u1lQPIqoE0gYbWzZep13VJFEtUoM3odqKcP4B/0U37XVRMwbw9gCMvpTTVkn9xu
 kjPxPioW0fG053UCXHByvt5nksGPMo4wvKlUhk665B21oZTDUQ40gmgodh7ETtrRAuT9+sM37n
 WnRKku2oBkZa94rWBsJcW0psHzUHe77abmikcAhAORV6oTj0Ishjz4EFI4jD/EvKf/IY1OU1ek
 SdzxKDlL2f4KYcOvxd3tW3B6
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="60525509"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="60525509"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:39 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 230CACD6C1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:38 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6B118D0424
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:37 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 2BE74400C1BBC;
        Tue, 25 Jan 2022 16:14:37 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 6/8] x86: Add hardware prefetch control support for x86
Date:   Tue, 25 Jan 2022 16:14:12 +0900
Message-Id: <20220125071414.811344-7-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds module init/exit code, and creates sysfs attribute file
"prefetch_control" for x86. This driver works only if the model is
INTEL_FAM6_BROADWELL_X at this point.

If you would like to support a new model with the same register
specifications as INTEL_FAM6_BROADWELL_X, it is possible to add the
model settings to array of broadwell_cpu_ids[].

The details of the registers to be read and written in this patch are
described below:

"https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html"
Volume 4

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 arch/x86/kernel/cpu/pfctl.c | 292 ++++++++++++++++++++++++++++++++++++
 1 file changed, 292 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/pfctl.c

diff --git a/arch/x86/kernel/cpu/pfctl.c b/arch/x86/kernel/cpu/pfctl.c
new file mode 100644
index 000000000000..02628f6d2c05
--- /dev/null
+++ b/arch/x86/kernel/cpu/pfctl.c
@@ -0,0 +1,292 @@
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
+	switch (level) {
+	case 1:
+		return FIELD_GET(BROADWELL_DCU_HWPF_FIELD, reg);
+	case 2:
+		return FIELD_GET(BROADWELL_L2_HWPF_FIELD, reg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int broadwell_modify_hwpf_enable(u64 *reg, unsigned int level,
+					unsigned int val)
+{
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
+	switch (level) {
+	case 1:
+		return FIELD_GET(BROADWELL_DCU_IPPF_FIELD, reg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int broadwell_modify_ippf_enable(u64 *reg, unsigned int level,
+					unsigned int val)
+{
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
+	switch (level) {
+	case 2:
+		return FIELD_GET(BROADWELL_L2_ACLPF_FIELD, reg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int broadwell_modify_aclpf_enable(u64 *reg, unsigned int level,
+					 unsigned int val)
+{
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
+static int _broadwell_get_pfctl_params(struct prefetcher_options *opts, u64 reg,
+				   unsigned int level, int supported_prefetcher)
+{
+	int ret;
+
+	if (supported_prefetcher & HWPF) {
+		ret = broadwell_get_hwpf_enable(reg, level);
+		if (ret < 0)
+			return ret;
+		opts->hwpf_enable = ret;
+	}
+
+	if (supported_prefetcher & IPPF) {
+		ret = broadwell_get_ippf_enable(reg, level);
+		if (ret < 0)
+			return ret;
+		opts->ippf_enable = ret;
+	}
+
+	if (supported_prefetcher & ACLPF) {
+		ret = broadwell_get_aclpf_enable(reg, level);
+		if (ret < 0)
+			return ret;
+		opts->aclpf_enable = ret;
+	}
+
+	return 0;
+}
+
+static int broadwell_get_pfctl_params(struct prefetcher_options *opts, u64 reg,
+				   unsigned int level)
+{
+	int ret, supported_prefetcher;
+
+	if (level == 1)
+		supported_prefetcher =
+			x86_pfctl_driver.supported_l1d_prefetcher;
+	else if (level == 2)
+		supported_prefetcher =
+			x86_pfctl_driver.supported_l2_prefetcher;
+	else
+		return -EINVAL;
+
+	ret = _broadwell_get_pfctl_params(opts, reg, level, supported_prefetcher);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int broadwell_modify_pfreg(u64 *reg, struct prefetcher_options *opts,
+				  unsigned int level)
+{
+	int ret;
+
+	if (opts->hwpf_enable != PFCTL_PARAM_UNSET) {
+		ret = broadwell_modify_hwpf_enable(reg, level,
+						   opts->hwpf_enable);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (opts->ippf_enable != PFCTL_PARAM_UNSET) {
+		ret = broadwell_modify_ippf_enable(reg, level,
+						   opts->ippf_enable);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (opts->aclpf_enable != PFCTL_PARAM_UNSET) {
+		ret = broadwell_modify_aclpf_enable(reg, level,
+						    opts->aclpf_enable);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int broadwell_read_pfreg(unsigned int cpu, unsigned int level,
+				struct prefetcher_options *opts)
+{
+	int ret;
+	u64 reg;
+
+	ret = rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &reg);
+	if (ret)
+		return ret;
+
+	ret = broadwell_get_pfctl_params(opts, reg, level);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int broadwell_write_pfreg(unsigned int cpu, unsigned int level,
+				 struct prefetcher_options *opts)
+{
+	int ret;
+	u64 reg;
+
+	ret = rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &reg);
+	if (ret)
+		return ret;
+
+	ret = broadwell_modify_pfreg(&reg, opts, level);
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
+static int __init setup_pfctl_driver_params(void)
+{
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

