Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC149AD93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387961AbiAYH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:26:00 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:58061 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1443458AbiAYHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:21:57 -0500
IronPort-SDR: ZM928DjHdUPW+d/4tYWCvExLyaJLLvIP+7FMuC9Ds4zd9uLq7fKI+VXqJeafAtVa5fTZuW2TIv
 3FmWhMyjx9b6VV+7ulWFWAFMjLibhb4ZC6dwUOsG80H1k3A6+k9kWw3/pfxw5dkhRlB7h1sOoQ
 XqzfC3s9wqlKjkWjjZ9Wv+qdH/D5sUJPvdvt4Ax6l/qc14E8sTmlH6SOrUYbwaV42jVWhzl78x
 x2dXnaD9/Rds0YZe325O+Y8Acs9/ii+S5va/90iCkJH6GFLi3bOmXAKRSx9O0+2AWFR9sbq07J
 WW+KJg1JV+LN85vghjAVXI3b
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="60525469"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="60525469"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:19 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 05DDAE8FF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:18 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 31FD819826
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:17 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id DB25C4007ED6C;
        Tue, 25 Jan 2022 16:14:16 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 3/8] arm64: Add hardware prefetch control support for ARM64
Date:   Tue, 25 Jan 2022 16:14:09 +0900
Message-Id: <20220125071414.811344-4-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds module init/exit code, and creates sysfs attribute files for
"prefetch_control". This driver works only if part number is
FUJITSU_CPU_PART_A64FX at this point. The details of the registers to
be read and written in this patch are described below.

"https://github.com/fujitsu/A64FX/tree/master/doc/"
    A64FX_Specification_HPC_Extension_v1_EN.pdf

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 arch/arm64/kernel/pfctl.c | 324 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)
 create mode 100644 arch/arm64/kernel/pfctl.c

diff --git a/arch/arm64/kernel/pfctl.c b/arch/arm64/kernel/pfctl.c
new file mode 100644
index 000000000000..14f4b8248280
--- /dev/null
+++ b/arch/arm64/kernel/pfctl.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * ARM64 Hardware Prefetch Control support
+ */
+
+#include <asm/cputype.h>
+#include <linux/bitfield.h>
+#include <linux/cacheinfo.h>
+#include <linux/module.h>
+#include <linux/pfctl.h>
+#include <linux/parser.h>
+
+struct pfctl_driver arm64_pfctl_driver;
+
+/**************************************
+ * FUJITSU A64FX support
+ **************************************/
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
+	struct prefetcher_options *opts;
+	unsigned int level;
+	int ret;
+};
+
+struct a64fx_write_info {
+	struct prefetcher_options *opts;
+	unsigned int level;
+	int ret;
+};
+
+static int a64fx_get_sdpf_enable(u64 reg, unsigned int level)
+{
+	switch (level) {
+	case 1:
+		return FIELD_GET(A64FX_SDPF_L1PF_DIS, reg);
+	case 2:
+		return FIELD_GET(A64FX_SDPF_L2PF_DIS, reg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int a64fx_modify_sdpf_enable(u64 *reg, unsigned int level, int val)
+{
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
+static int a64fx_modify_sdpf_dist(u64 *reg, unsigned int level, int val)
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
+static int a64fx_get_sdpf_strong(u64 reg, unsigned int level)
+{
+	switch (level) {
+	case 1:
+		return FIELD_GET(A64FX_SDPF_L1W, reg);
+	case 2:
+		return FIELD_GET(A64FX_SDPF_L2W, reg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int a64fx_modify_sdpf_strong(u64 *reg, unsigned int level, int val)
+{
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
+static void a64fx_enable_sdpf_verify(u64 *reg)
+{
+	*reg &= ~A64FX_SDPF_V;
+	*reg |= FIELD_PREP(A64FX_SDPF_V, 1);
+}
+
+static int a64fx_get_sdpf_params(struct prefetcher_options *opts, u64 reg,
+			    unsigned int level)
+{
+	int ret;
+
+	ret = a64fx_get_sdpf_enable(reg, level);
+	if (ret < 0)
+		return ret;
+	opts->sdpf_enable = ret;
+
+	ret = a64fx_get_sdpf_dist(reg, level);
+	if (ret < 0)
+		return ret;
+	opts->sdpf_dist = ret;
+
+	ret = a64fx_get_sdpf_strong(reg, level);
+	if (ret < 0)
+		return ret;
+	opts->sdpf_strong = ret;
+
+	return 0;
+}
+
+static int a64fx_modify_pfreg_val(u64 *reg, struct prefetcher_options *opts,
+			 unsigned int level)
+{
+	int ret;
+
+	if (opts->sdpf_enable != PFCTL_PARAM_UNSET) {
+		ret = a64fx_modify_sdpf_enable(reg, level, opts->sdpf_enable);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (opts->sdpf_dist != PFCTL_PARAM_UNSET) {
+		ret = a64fx_modify_sdpf_dist(reg, level, opts->sdpf_dist);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (opts->sdpf_strong != PFCTL_PARAM_UNSET) {
+		ret = a64fx_modify_sdpf_strong(reg, level, opts->sdpf_strong);
+		if (ret < 0)
+			return ret;
+	}
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
+	rinfo->ret = a64fx_get_sdpf_params(rinfo->opts, reg, rinfo->level);
+}
+
+static int a64fx_read_pfreg(unsigned int cpu, unsigned int level,
+		      struct prefetcher_options *opt)
+{
+	struct a64fx_read_info info = {
+		.level = level,
+		.opts = opt,
+	};
+
+	smp_call_function_single(cpu, _a64fx_read_pfreg, &info, true);
+	return info.ret;
+}
+
+static void _a64fx_write_pfreg(void *info)
+{
+	int ret;
+	u64 reg;
+	struct a64fx_write_info *winfo = info;
+
+	reg = read_sysreg_s(A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	ret = a64fx_modify_pfreg_val(&reg, winfo->opts, winfo->level);
+	if (ret < 0) {
+		winfo->ret = ret;
+		return;
+	}
+
+	write_sysreg_s(reg, A64FX_SDPF_IMP_PF_STREAM_DETECT_CTRL_EL0);
+
+	winfo->ret = 0;
+}
+
+static int a64fx_write_pfreg(unsigned int cpu, unsigned int level,
+		       struct prefetcher_options *opt)
+{
+	struct a64fx_write_info info = {
+		.level = level,
+		.opts = opt,
+	};
+
+	smp_call_function_single(cpu, _a64fx_write_pfreg, &info, true);
+	return info.ret;
+}
+
+/***** end of FUJITSU A64FX support *****/
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
+	switch (implementor) {
+	case ARM_CPU_IMP_FUJITSU:
+		switch (part_number) {
+		case FUJITSU_CPU_PART_A64FX:
+			/* A64FX register requires EL2 access */
+			if (!has_vhe())
+				return -EINVAL;
+
+			arm64_pfctl_driver.supported_l1d_prefetcher = SDPF;
+			arm64_pfctl_driver.supported_l2_prefetcher = SDPF;
+			arm64_pfctl_driver.read_pfreg = a64fx_read_pfreg;
+			arm64_pfctl_driver.write_pfreg = a64fx_write_pfreg;
+			break;
+		default:
+			return -ENODEV;
+		}
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int __init arm64_pfctl_init(void)
+{
+	int ret;
+
+	ret = setup_pfctl_driver_params();
+	if (ret < 0)
+		return ret;
+
+	ret = pfctl_register_driver(&arm64_pfctl_driver);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __exit arm64_pfctl_exit(void)
+{
+	pfctl_unregister_driver(&arm64_pfctl_driver);
+}
+
+late_initcall(arm64_pfctl_init);
+module_exit(arm64_pfctl_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("FUJITSU LIMITED");
+MODULE_DESCRIPTION("ARM64 Prefetch Control Driver");
-- 
2.27.0

