Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6624A507F51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359119AbiDTDG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359082AbiDTDGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:06:13 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C7393ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:03:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="49273818"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="49273818"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Apr 2022 12:02:24 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9158ED502B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:23 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id BBEF0F103D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:22 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 323434060C93E;
        Wed, 20 Apr 2022 12:02:20 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v3 3/9] soc: fujitsu: Add hardware prefetch control support for A64FX
Date:   Wed, 20 Apr 2022 12:02:17 +0900
Message-Id: <20220420030223.689259-4-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds module init/exit code, and creates sysfs attribute files for
"stream_detect_prefetcher_enable", "stream_detect_prefetcher_strong"
and "stream_detect_prefetcher_dist". This driver works only if part
number is FUJITSU_CPU_PART_A64FX at this point. The details of the
registers to be read and written in this patch are described below.

"https://github.com/fujitsu/A64FX/tree/master/doc/"
    A64FX_Specification_HPC_Extension_v1_EN.pdf

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/soc/fujitsu/a64fx-pfctl.c | 356 ++++++++++++++++++++++++++++++
 1 file changed, 356 insertions(+)
 create mode 100644 drivers/soc/fujitsu/a64fx-pfctl.c

diff --git a/drivers/soc/fujitsu/a64fx-pfctl.c b/drivers/soc/fujitsu/a64fx-pfctl.c
new file mode 100644
index 000000000000..0e072592be73
--- /dev/null
+++ b/drivers/soc/fujitsu/a64fx-pfctl.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * A64FX Hardware Prefetch Control support
+ */
+
+#include <asm/cputype.h>
+#include <linux/bitfield.h>
+#include <linux/cacheinfo.h>
+#include <linux/module.h>
+#include <linux/pfctl.h>
+#include <linux/parser.h>
+
+struct pfctl_driver a64fx_pfctl_driver;
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
+#define A64FX_SDPF_MIN_DIST_L1				256
+#define A64FX_SDPF_MIN_DIST_L2				1024
+
+struct a64fx_read_info {
+	enum pfctl_attr pattr;
+	u64 val;
+	unsigned int level;
+	int ret;
+};
+
+struct a64fx_write_info {
+	enum pfctl_attr pattr;
+	u64 val;
+	unsigned int level;
+	int ret;
+};
+
+static int a64fx_get_sdpf_enable(u64 reg, unsigned int level)
+{
+	u64 val;
+
+	switch (level) {
+	case 1:
+		val = FIELD_GET(A64FX_SDPF_L1PF_DIS, reg);
+		break;
+	case 2:
+		val = FIELD_GET(A64FX_SDPF_L2PF_DIS, reg);
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
+static int a64fx_modify_sdpf_enable(u64 *reg, unsigned int level, u64 val)
+{
+	if (val == PFCTL_ENABLE_VAL)
+		val = 0;
+	else
+		val = 1;
+
+	switch (level) {
+	case 1:
+		*reg &= ~A64FX_SDPF_L1PF_DIS;
+		*reg |= FIELD_PREP(A64FX_SDPF_L1PF_DIS, val);
+		break;
+	case 2:
+		*reg &= ~A64FX_SDPF_L2PF_DIS;
+		*reg |= FIELD_PREP(A64FX_SDPF_L2PF_DIS, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int a64fx_get_sdpf_strength(u64 reg, unsigned int level)
+{
+	u64 val;
+
+	switch (level) {
+	case 1:
+		val = FIELD_GET(A64FX_SDPF_L1W, reg);
+		break;
+	case 2:
+		val = FIELD_GET(A64FX_SDPF_L2W, reg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val == 0)
+		return PFCTL_STRONG_VAL;
+	else if (val == 1)
+		return PFCTL_WEAK_VAL;
+	else
+		return -EINVAL;
+}
+
+static int a64fx_modify_sdpf_strength(u64 *reg, unsigned int level, u64 val)
+{
+	if (val == PFCTL_STRONG_VAL)
+		val = 0;
+	else
+		val = 1;
+
+	switch (level) {
+	case 1:
+		*reg &= ~A64FX_SDPF_L1W;
+		*reg |= FIELD_PREP(A64FX_SDPF_L1W, val);
+		break;
+	case 2:
+		*reg &= ~A64FX_SDPF_L2W;
+		*reg |= FIELD_PREP(A64FX_SDPF_L2W, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int a64fx_get_sdpf_dist(u64 reg, unsigned int level)
+{
+	switch (level) {
+	case 1:
+		return FIELD_GET(A64FX_SDPF_L1_DIST, reg) *
+			A64FX_SDPF_MIN_DIST_L1;
+	case 2:
+		return FIELD_GET(A64FX_SDPF_L2_DIST, reg) *
+			A64FX_SDPF_MIN_DIST_L2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int a64fx_modify_sdpf_dist(u64 *reg, unsigned int level, u64 val)
+{
+	switch (level) {
+	case 1:
+		val = roundup(val, A64FX_SDPF_MIN_DIST_L1) /
+			A64FX_SDPF_MIN_DIST_L1;
+		if (!FIELD_FIT(A64FX_SDPF_L1_DIST, val))
+			return -EINVAL;
+		*reg &= ~A64FX_SDPF_L1_DIST;
+		*reg |= FIELD_PREP(A64FX_SDPF_L1_DIST, val);
+		break;
+	case 2:
+		val = roundup(val, A64FX_SDPF_MIN_DIST_L2) /
+			A64FX_SDPF_MIN_DIST_L2;
+		if (!FIELD_FIT(A64FX_SDPF_L2_DIST, val))
+			return -EINVAL;
+		*reg &= ~A64FX_SDPF_L2_DIST;
+		*reg |= FIELD_PREP(A64FX_SDPF_L2_DIST, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void a64fx_enable_sdpf_verify(u64 *reg)
+{
+	*reg |= FIELD_PREP(A64FX_SDPF_V, 1);
+}
+
+static int a64fx_get_sdpf_params(enum pfctl_attr pattr, u64 reg,
+				 unsigned int level, u64 *val)
+{
+	int ret;
+
+	switch (pattr) {
+	case SDPF_ENABLE:
+		ret = a64fx_get_sdpf_enable(reg, level);
+		break;
+	case SDPF_STRENGTH:
+		ret = a64fx_get_sdpf_strength(reg, level);
+		break;
+	case SDPF_DIST:
+		ret = a64fx_get_sdpf_dist(reg, level);
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
+static int a64fx_modify_pfreg_val(enum pfctl_attr pattr, u64 *reg,
+				  unsigned int level, u64 val)
+{
+	int ret;
+
+	switch (pattr) {
+	case SDPF_ENABLE:
+		ret = a64fx_modify_sdpf_enable(reg, level, val);
+		break;
+	case SDPF_STRENGTH:
+		ret = a64fx_modify_sdpf_strength(reg, level, val);
+		break;
+	case SDPF_DIST:
+		ret = a64fx_modify_sdpf_dist(reg, level, val);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	a64fx_enable_sdpf_verify(reg);
+
+	return 0;
+}
+
+static void _a64fx_read_pfreg(void *info)
+{
+	u64 reg;
+	struct a64fx_read_info *rinfo = info;
+
+	reg = read_sysreg_s(A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	rinfo->ret = a64fx_get_sdpf_params(rinfo->pattr, reg, rinfo->level,
+					   &rinfo->val);
+}
+
+static int a64fx_read_pfreg(enum pfctl_attr pattr, unsigned int cpu,
+			    unsigned int level, u64 *val)
+{
+	struct a64fx_read_info info = {
+		.level = level,
+		.pattr = pattr,
+	};
+
+	smp_call_function_single(cpu, _a64fx_read_pfreg, &info, true);
+	if (info.ret < 0)
+		return info.ret;
+
+	*val = info.val;
+	return 0;
+}
+
+static void _a64fx_write_pfreg(void *info)
+{
+	u64 reg;
+	struct a64fx_write_info *winfo = info;
+
+	reg = read_sysreg_s(A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	winfo->ret = a64fx_modify_pfreg_val(winfo->pattr, &reg, winfo->level,
+					    winfo->val);
+	if (winfo->ret < 0)
+		return;
+
+	write_sysreg_s(reg, A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	winfo->ret = 0;
+}
+
+static int a64fx_write_pfreg(enum pfctl_attr pattr, unsigned int cpu,
+			     unsigned int level, u64 val)
+{
+	struct a64fx_write_info info = {
+		.level = level,
+		.pattr = pattr,
+		.val = val,
+	};
+
+	smp_call_function_single(cpu, _a64fx_write_pfreg, &info, true);
+	return info.ret;
+}
+
+/*
+ * This driver returns a negative value if it does not support the Hardware
+ * Prefetch Control or if it is running on a VM guest.
+ */
+static int __init setup_pfctl_driver_params(void)
+{
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
+
+	if (!is_kernel_in_hyp_mode())
+		return -EINVAL;
+
+	if (implementor != ARM_CPU_IMP_FUJITSU)
+		return -ENODEV;
+
+	switch (part_number) {
+	case FUJITSU_CPU_PART_A64FX:
+		/* A64FX register requires EL2 access */
+		if (!has_vhe())
+			return -EINVAL;
+
+		a64fx_pfctl_driver.supported_l1d_prefetcher = SDPF;
+		a64fx_pfctl_driver.supported_l2_prefetcher = SDPF;
+		a64fx_pfctl_driver.supported_sdpf_strength =
+			STRENGTH_STRONG|STRENGTH_WEAK;
+		a64fx_pfctl_driver.read_pfreg = a64fx_read_pfreg;
+		a64fx_pfctl_driver.write_pfreg = a64fx_write_pfreg;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int __init a64fx_pfctl_init(void)
+{
+	int ret;
+
+	ret = setup_pfctl_driver_params();
+	if (ret < 0)
+		return ret;
+
+	ret = pfctl_register_driver(&a64fx_pfctl_driver);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __exit a64fx_pfctl_exit(void)
+{
+	pfctl_unregister_driver(&a64fx_pfctl_driver);
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

