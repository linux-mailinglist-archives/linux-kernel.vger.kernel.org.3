Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2E464DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349386AbhLAMjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:39:18 -0500
Received: from foss.arm.com ([217.140.110.172]:35970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349382AbhLAMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:37:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A7A1477;
        Wed,  1 Dec 2021 04:34:21 -0800 (PST)
Received: from e127744.cambridge.arm.com (e127744.cambridge.arm.com [10.1.32.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AEDF3F694;
        Wed,  1 Dec 2021 04:34:18 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 3/4] perf tools: Crete header files with register names
Date:   Wed,  1 Dec 2021 12:33:31 +0000
Message-Id: <20211201123334.679131-4-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201123334.679131-1-german.gomez@arm.com>
References: <20211201123334.679131-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds C headers containing the names of the registers of all
architectures (that currently support registers in perf).

A followup patch will re-implement the function "perf_reg_name" using
this headers to display register names consistent with the achitecture
of the perf.data files.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/perf_regs_arm.h     |  57 ++++++++++++++++
 tools/perf/util/perf_regs_arm64.h   |  83 +++++++++++++++++++++++
 tools/perf/util/perf_regs_csky.h    | 101 ++++++++++++++++++++++++++++
 tools/perf/util/perf_regs_mips.h    |  76 +++++++++++++++++++++
 tools/perf/util/perf_regs_powerpc.h |  74 ++++++++++++++++++++
 tools/perf/util/perf_regs_riscv.h   |  81 ++++++++++++++++++++++
 tools/perf/util/perf_regs_s390.h    |  85 +++++++++++++++++++++++
 tools/perf/util/perf_regs_x86.h     |  87 ++++++++++++++++++++++++
 8 files changed, 644 insertions(+)
 create mode 100644 tools/perf/util/perf_regs_arm.h
 create mode 100644 tools/perf/util/perf_regs_arm64.h
 create mode 100644 tools/perf/util/perf_regs_csky.h
 create mode 100644 tools/perf/util/perf_regs_mips.h
 create mode 100644 tools/perf/util/perf_regs_powerpc.h
 create mode 100644 tools/perf/util/perf_regs_riscv.h
 create mode 100644 tools/perf/util/perf_regs_s390.h
 create mode 100644 tools/perf/util/perf_regs_x86.h

diff --git a/tools/perf/util/perf_regs_arm.h b/tools/perf/util/perf_regs_arm.h
new file mode 100644
index 000000000..779b40d6c
--- /dev/null
+++ b/tools/perf/util/perf_regs_arm.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_ARM_H
+#define __PERF_REGS_ARM_H
+
+/*
+ * ARM and ARM64 registers are grouped under enums of the same name.
+ * Temporarily rename the name of the enum to prevent the naming collision.
+ */
+#define perf_event_arm_regs perf_event_arm_regs_workaround
+
+#include "../../arch/arm/include/uapi/asm/perf_regs.h"
+
+static inline const char *__perf_reg_name_arm(int id)
+{
+	switch (id) {
+	case PERF_REG_ARM_R0:
+		return "r0";
+	case PERF_REG_ARM_R1:
+		return "r1";
+	case PERF_REG_ARM_R2:
+		return "r2";
+	case PERF_REG_ARM_R3:
+		return "r3";
+	case PERF_REG_ARM_R4:
+		return "r4";
+	case PERF_REG_ARM_R5:
+		return "r5";
+	case PERF_REG_ARM_R6:
+		return "r6";
+	case PERF_REG_ARM_R7:
+		return "r7";
+	case PERF_REG_ARM_R8:
+		return "r8";
+	case PERF_REG_ARM_R9:
+		return "r9";
+	case PERF_REG_ARM_R10:
+		return "r10";
+	case PERF_REG_ARM_FP:
+		return "fp";
+	case PERF_REG_ARM_IP:
+		return "ip";
+	case PERF_REG_ARM_SP:
+		return "sp";
+	case PERF_REG_ARM_LR:
+		return "lr";
+	case PERF_REG_ARM_PC:
+		return "pc";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#undef perf_event_arm_regs
+
+#endif /* __PERF_REGS_ARM_H */
diff --git a/tools/perf/util/perf_regs_arm64.h b/tools/perf/util/perf_regs_arm64.h
new file mode 100644
index 000000000..422a1db03
--- /dev/null
+++ b/tools/perf/util/perf_regs_arm64.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_ARM64_H
+#define __PERF_REGS_ARM64_H
+
+#include "../../arch/arm64/include/uapi/asm/perf_regs.h"
+
+static inline const char *__perf_reg_name_arm64(int id)
+{
+	switch (id) {
+	case PERF_REG_ARM64_X0:
+		return "x0";
+	case PERF_REG_ARM64_X1:
+		return "x1";
+	case PERF_REG_ARM64_X2:
+		return "x2";
+	case PERF_REG_ARM64_X3:
+		return "x3";
+	case PERF_REG_ARM64_X4:
+		return "x4";
+	case PERF_REG_ARM64_X5:
+		return "x5";
+	case PERF_REG_ARM64_X6:
+		return "x6";
+	case PERF_REG_ARM64_X7:
+		return "x7";
+	case PERF_REG_ARM64_X8:
+		return "x8";
+	case PERF_REG_ARM64_X9:
+		return "x9";
+	case PERF_REG_ARM64_X10:
+		return "x10";
+	case PERF_REG_ARM64_X11:
+		return "x11";
+	case PERF_REG_ARM64_X12:
+		return "x12";
+	case PERF_REG_ARM64_X13:
+		return "x13";
+	case PERF_REG_ARM64_X14:
+		return "x14";
+	case PERF_REG_ARM64_X15:
+		return "x15";
+	case PERF_REG_ARM64_X16:
+		return "x16";
+	case PERF_REG_ARM64_X17:
+		return "x17";
+	case PERF_REG_ARM64_X18:
+		return "x18";
+	case PERF_REG_ARM64_X19:
+		return "x19";
+	case PERF_REG_ARM64_X20:
+		return "x20";
+	case PERF_REG_ARM64_X21:
+		return "x21";
+	case PERF_REG_ARM64_X22:
+		return "x22";
+	case PERF_REG_ARM64_X23:
+		return "x23";
+	case PERF_REG_ARM64_X24:
+		return "x24";
+	case PERF_REG_ARM64_X25:
+		return "x25";
+	case PERF_REG_ARM64_X26:
+		return "x26";
+	case PERF_REG_ARM64_X27:
+		return "x27";
+	case PERF_REG_ARM64_X28:
+		return "x28";
+	case PERF_REG_ARM64_X29:
+		return "x29";
+	case PERF_REG_ARM64_SP:
+		return "sp";
+	case PERF_REG_ARM64_LR:
+		return "lr";
+	case PERF_REG_ARM64_PC:
+		return "pc";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif /* __PERF_REGS_ARM64_H */
diff --git a/tools/perf/util/perf_regs_csky.h b/tools/perf/util/perf_regs_csky.h
new file mode 100644
index 000000000..aff603300
--- /dev/null
+++ b/tools/perf/util/perf_regs_csky.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_CSKY_H
+#define __PERF_REGS_CSKY_H
+
+/*
+ * Temporarily define __CSKYABIV2__ as some of the registers are defined under that macro
+ * The macro will be undefined at the end of the file.
+ */
+#ifndef __CSKYABIV2__
+#define __CSKYABIV2__
+#define __CSKYABIV2__PERF_REGS__
+#endif
+
+#include "../../arch/csky/include/uapi/asm/perf_regs.h"
+
+static inline const char *__perf_reg_name_csky(int id)
+{
+	switch (id) {
+	case PERF_REG_CSKY_A0:
+		return "a0";
+	case PERF_REG_CSKY_A1:
+		return "a1";
+	case PERF_REG_CSKY_A2:
+		return "a2";
+	case PERF_REG_CSKY_A3:
+		return "a3";
+	case PERF_REG_CSKY_REGS0:
+		return "regs0";
+	case PERF_REG_CSKY_REGS1:
+		return "regs1";
+	case PERF_REG_CSKY_REGS2:
+		return "regs2";
+	case PERF_REG_CSKY_REGS3:
+		return "regs3";
+	case PERF_REG_CSKY_REGS4:
+		return "regs4";
+	case PERF_REG_CSKY_REGS5:
+		return "regs5";
+	case PERF_REG_CSKY_REGS6:
+		return "regs6";
+	case PERF_REG_CSKY_REGS7:
+		return "regs7";
+	case PERF_REG_CSKY_REGS8:
+		return "regs8";
+	case PERF_REG_CSKY_REGS9:
+		return "regs9";
+	case PERF_REG_CSKY_SP:
+		return "sp";
+	case PERF_REG_CSKY_LR:
+		return "lr";
+	case PERF_REG_CSKY_PC:
+		return "pc";
+	case PERF_REG_CSKY_EXREGS0:
+		return "exregs0";
+	case PERF_REG_CSKY_EXREGS1:
+		return "exregs1";
+	case PERF_REG_CSKY_EXREGS2:
+		return "exregs2";
+	case PERF_REG_CSKY_EXREGS3:
+		return "exregs3";
+	case PERF_REG_CSKY_EXREGS4:
+		return "exregs4";
+	case PERF_REG_CSKY_EXREGS5:
+		return "exregs5";
+	case PERF_REG_CSKY_EXREGS6:
+		return "exregs6";
+	case PERF_REG_CSKY_EXREGS7:
+		return "exregs7";
+	case PERF_REG_CSKY_EXREGS8:
+		return "exregs8";
+	case PERF_REG_CSKY_EXREGS9:
+		return "exregs9";
+	case PERF_REG_CSKY_EXREGS10:
+		return "exregs10";
+	case PERF_REG_CSKY_EXREGS11:
+		return "exregs11";
+	case PERF_REG_CSKY_EXREGS12:
+		return "exregs12";
+	case PERF_REG_CSKY_EXREGS13:
+		return "exregs13";
+	case PERF_REG_CSKY_EXREGS14:
+		return "exregs14";
+	case PERF_REG_CSKY_TLS:
+		return "tls";
+	case PERF_REG_CSKY_HI:
+		return "hi";
+	case PERF_REG_CSKY_LO:
+		return "lo";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#ifdef __CSKYABIV2__PERF_REGS__
+#undef __CSKYABIV2__
+#undef __CSKYABIV2__PERF_REGS__
+#endif
+
+#endif /* __PERF_REGS_CSKY_H */
diff --git a/tools/perf/util/perf_regs_mips.h b/tools/perf/util/perf_regs_mips.h
new file mode 100644
index 000000000..32f6ac8f8
--- /dev/null
+++ b/tools/perf/util/perf_regs_mips.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_MIPS_H
+#define __PERF_REGS_MIPS_H
+
+#include "../../arch/mips/include/uapi/asm/perf_regs.h"
+
+static inline const char *__perf_reg_name_mips(int id)
+{
+	switch (id) {
+	case PERF_REG_MIPS_PC:
+		return "PC";
+	case PERF_REG_MIPS_R1:
+		return "$1";
+	case PERF_REG_MIPS_R2:
+		return "$2";
+	case PERF_REG_MIPS_R3:
+		return "$3";
+	case PERF_REG_MIPS_R4:
+		return "$4";
+	case PERF_REG_MIPS_R5:
+		return "$5";
+	case PERF_REG_MIPS_R6:
+		return "$6";
+	case PERF_REG_MIPS_R7:
+		return "$7";
+	case PERF_REG_MIPS_R8:
+		return "$8";
+	case PERF_REG_MIPS_R9:
+		return "$9";
+	case PERF_REG_MIPS_R10:
+		return "$10";
+	case PERF_REG_MIPS_R11:
+		return "$11";
+	case PERF_REG_MIPS_R12:
+		return "$12";
+	case PERF_REG_MIPS_R13:
+		return "$13";
+	case PERF_REG_MIPS_R14:
+		return "$14";
+	case PERF_REG_MIPS_R15:
+		return "$15";
+	case PERF_REG_MIPS_R16:
+		return "$16";
+	case PERF_REG_MIPS_R17:
+		return "$17";
+	case PERF_REG_MIPS_R18:
+		return "$18";
+	case PERF_REG_MIPS_R19:
+		return "$19";
+	case PERF_REG_MIPS_R20:
+		return "$20";
+	case PERF_REG_MIPS_R21:
+		return "$21";
+	case PERF_REG_MIPS_R22:
+		return "$22";
+	case PERF_REG_MIPS_R23:
+		return "$23";
+	case PERF_REG_MIPS_R24:
+		return "$24";
+	case PERF_REG_MIPS_R25:
+		return "$25";
+	case PERF_REG_MIPS_R28:
+		return "$28";
+	case PERF_REG_MIPS_R29:
+		return "$29";
+	case PERF_REG_MIPS_R30:
+		return "$30";
+	case PERF_REG_MIPS_R31:
+		return "$31";
+	default:
+		break;
+	}
+	return NULL;
+}
+
+#endif /* __PERF_REGS_MIPS_H */
diff --git a/tools/perf/util/perf_regs_powerpc.h b/tools/perf/util/perf_regs_powerpc.h
new file mode 100644
index 000000000..ed6473f52
--- /dev/null
+++ b/tools/perf/util/perf_regs_powerpc.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_POWERPC_H
+#define __PERF_REGS_POWERPC_H
+
+#include "../../arch/powerpc/include/uapi/asm/perf_regs.h"
+
+static const char *perf_regs_powerpc_reg_names[] = {
+	[PERF_REG_POWERPC_R0] = "r0",
+	[PERF_REG_POWERPC_R1] = "r1",
+	[PERF_REG_POWERPC_R2] = "r2",
+	[PERF_REG_POWERPC_R3] = "r3",
+	[PERF_REG_POWERPC_R4] = "r4",
+	[PERF_REG_POWERPC_R5] = "r5",
+	[PERF_REG_POWERPC_R6] = "r6",
+	[PERF_REG_POWERPC_R7] = "r7",
+	[PERF_REG_POWERPC_R8] = "r8",
+	[PERF_REG_POWERPC_R9] = "r9",
+	[PERF_REG_POWERPC_R10] = "r10",
+	[PERF_REG_POWERPC_R11] = "r11",
+	[PERF_REG_POWERPC_R12] = "r12",
+	[PERF_REG_POWERPC_R13] = "r13",
+	[PERF_REG_POWERPC_R14] = "r14",
+	[PERF_REG_POWERPC_R15] = "r15",
+	[PERF_REG_POWERPC_R16] = "r16",
+	[PERF_REG_POWERPC_R17] = "r17",
+	[PERF_REG_POWERPC_R18] = "r18",
+	[PERF_REG_POWERPC_R19] = "r19",
+	[PERF_REG_POWERPC_R20] = "r20",
+	[PERF_REG_POWERPC_R21] = "r21",
+	[PERF_REG_POWERPC_R22] = "r22",
+	[PERF_REG_POWERPC_R23] = "r23",
+	[PERF_REG_POWERPC_R24] = "r24",
+	[PERF_REG_POWERPC_R25] = "r25",
+	[PERF_REG_POWERPC_R26] = "r26",
+	[PERF_REG_POWERPC_R27] = "r27",
+	[PERF_REG_POWERPC_R28] = "r28",
+	[PERF_REG_POWERPC_R29] = "r29",
+	[PERF_REG_POWERPC_R30] = "r30",
+	[PERF_REG_POWERPC_R31] = "r31",
+	[PERF_REG_POWERPC_NIP] = "nip",
+	[PERF_REG_POWERPC_MSR] = "msr",
+	[PERF_REG_POWERPC_ORIG_R3] = "orig_r3",
+	[PERF_REG_POWERPC_CTR] = "ctr",
+	[PERF_REG_POWERPC_LINK] = "link",
+	[PERF_REG_POWERPC_XER] = "xer",
+	[PERF_REG_POWERPC_CCR] = "ccr",
+	[PERF_REG_POWERPC_SOFTE] = "softe",
+	[PERF_REG_POWERPC_TRAP] = "trap",
+	[PERF_REG_POWERPC_DAR] = "dar",
+	[PERF_REG_POWERPC_DSISR] = "dsisr",
+	[PERF_REG_POWERPC_SIER] = "sier",
+	[PERF_REG_POWERPC_MMCRA] = "mmcra",
+	[PERF_REG_POWERPC_MMCR0] = "mmcr0",
+	[PERF_REG_POWERPC_MMCR1] = "mmcr1",
+	[PERF_REG_POWERPC_MMCR2] = "mmcr2",
+	[PERF_REG_POWERPC_MMCR3] = "mmcr3",
+	[PERF_REG_POWERPC_SIER2] = "sier2",
+	[PERF_REG_POWERPC_SIER3] = "sier3",
+	[PERF_REG_POWERPC_PMC1] = "pmc1",
+	[PERF_REG_POWERPC_PMC2] = "pmc2",
+	[PERF_REG_POWERPC_PMC3] = "pmc3",
+	[PERF_REG_POWERPC_PMC4] = "pmc4",
+	[PERF_REG_POWERPC_PMC5] = "pmc5",
+	[PERF_REG_POWERPC_PMC6] = "pmc6",
+	[PERF_REG_POWERPC_SDAR] = "sdar",
+	[PERF_REG_POWERPC_SIAR] = "siar",
+};
+
+static inline const char *__perf_reg_name_powerpc(int id)
+{
+	return perf_regs_powerpc_reg_names[id];
+}
+
+#endif /* __PERF_REGS_POWERPC_H */
diff --git a/tools/perf/util/perf_regs_riscv.h b/tools/perf/util/perf_regs_riscv.h
new file mode 100644
index 000000000..6e784c40a
--- /dev/null
+++ b/tools/perf/util/perf_regs_riscv.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_RISCV_H
+#define __PERF_REGS_RISCV_H
+
+#include "../../arch/riscv/include/uapi/asm/perf_regs.h"
+
+static inline const char *__perf_reg_name_riscv(int id)
+{
+	switch (id) {
+	case PERF_REG_RISCV_PC:
+		return "pc";
+	case PERF_REG_RISCV_RA:
+		return "ra";
+	case PERF_REG_RISCV_SP:
+		return "sp";
+	case PERF_REG_RISCV_GP:
+		return "gp";
+	case PERF_REG_RISCV_TP:
+		return "tp";
+	case PERF_REG_RISCV_T0:
+		return "t0";
+	case PERF_REG_RISCV_T1:
+		return "t1";
+	case PERF_REG_RISCV_T2:
+		return "t2";
+	case PERF_REG_RISCV_S0:
+		return "s0";
+	case PERF_REG_RISCV_S1:
+		return "s1";
+	case PERF_REG_RISCV_A0:
+		return "a0";
+	case PERF_REG_RISCV_A1:
+		return "a1";
+	case PERF_REG_RISCV_A2:
+		return "a2";
+	case PERF_REG_RISCV_A3:
+		return "a3";
+	case PERF_REG_RISCV_A4:
+		return "a4";
+	case PERF_REG_RISCV_A5:
+		return "a5";
+	case PERF_REG_RISCV_A6:
+		return "a6";
+	case PERF_REG_RISCV_A7:
+		return "a7";
+	case PERF_REG_RISCV_S2:
+		return "s2";
+	case PERF_REG_RISCV_S3:
+		return "s3";
+	case PERF_REG_RISCV_S4:
+		return "s4";
+	case PERF_REG_RISCV_S5:
+		return "s5";
+	case PERF_REG_RISCV_S6:
+		return "s6";
+	case PERF_REG_RISCV_S7:
+		return "s7";
+	case PERF_REG_RISCV_S8:
+		return "s8";
+	case PERF_REG_RISCV_S9:
+		return "s9";
+	case PERF_REG_RISCV_S10:
+		return "s10";
+	case PERF_REG_RISCV_S11:
+		return "s11";
+	case PERF_REG_RISCV_T3:
+		return "t3";
+	case PERF_REG_RISCV_T4:
+		return "t4";
+	case PERF_REG_RISCV_T5:
+		return "t5";
+	case PERF_REG_RISCV_T6:
+		return "t6";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif /* __PERF_REGS_RISCV_H */
diff --git a/tools/perf/util/perf_regs_s390.h b/tools/perf/util/perf_regs_s390.h
new file mode 100644
index 000000000..3b2397ece
--- /dev/null
+++ b/tools/perf/util/perf_regs_s390.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_S390_H
+#define __PERF_REGS_S390_H
+
+#include "../../arch/s390/include/uapi/asm/perf_regs.h"
+
+static inline const char *__perf_reg_name_s390(int id)
+{
+	switch (id) {
+	case PERF_REG_S390_R0:
+		return "R0";
+	case PERF_REG_S390_R1:
+		return "R1";
+	case PERF_REG_S390_R2:
+		return "R2";
+	case PERF_REG_S390_R3:
+		return "R3";
+	case PERF_REG_S390_R4:
+		return "R4";
+	case PERF_REG_S390_R5:
+		return "R5";
+	case PERF_REG_S390_R6:
+		return "R6";
+	case PERF_REG_S390_R7:
+		return "R7";
+	case PERF_REG_S390_R8:
+		return "R8";
+	case PERF_REG_S390_R9:
+		return "R9";
+	case PERF_REG_S390_R10:
+		return "R10";
+	case PERF_REG_S390_R11:
+		return "R11";
+	case PERF_REG_S390_R12:
+		return "R12";
+	case PERF_REG_S390_R13:
+		return "R13";
+	case PERF_REG_S390_R14:
+		return "R14";
+	case PERF_REG_S390_R15:
+		return "R15";
+	case PERF_REG_S390_FP0:
+		return "FP0";
+	case PERF_REG_S390_FP1:
+		return "FP1";
+	case PERF_REG_S390_FP2:
+		return "FP2";
+	case PERF_REG_S390_FP3:
+		return "FP3";
+	case PERF_REG_S390_FP4:
+		return "FP4";
+	case PERF_REG_S390_FP5:
+		return "FP5";
+	case PERF_REG_S390_FP6:
+		return "FP6";
+	case PERF_REG_S390_FP7:
+		return "FP7";
+	case PERF_REG_S390_FP8:
+		return "FP8";
+	case PERF_REG_S390_FP9:
+		return "FP9";
+	case PERF_REG_S390_FP10:
+		return "FP10";
+	case PERF_REG_S390_FP11:
+		return "FP11";
+	case PERF_REG_S390_FP12:
+		return "FP12";
+	case PERF_REG_S390_FP13:
+		return "FP13";
+	case PERF_REG_S390_FP14:
+		return "FP14";
+	case PERF_REG_S390_FP15:
+		return "FP15";
+	case PERF_REG_S390_MASK:
+		return "MASK";
+	case PERF_REG_S390_PC:
+		return "PC";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif /* __PERF_REGS_S390_H */
diff --git a/tools/perf/util/perf_regs_x86.h b/tools/perf/util/perf_regs_x86.h
new file mode 100644
index 000000000..27432599a
--- /dev/null
+++ b/tools/perf/util/perf_regs_x86.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __PERF_REGS_X86_H
+#define __PERF_REGS_X86_H
+
+#include "../../arch/x86/include/uapi/asm/perf_regs.h"
+
+static inline const char *__perf_reg_name_x86(int id)
+{
+	switch (id) {
+	case PERF_REG_X86_AX:
+		return "AX";
+	case PERF_REG_X86_BX:
+		return "BX";
+	case PERF_REG_X86_CX:
+		return "CX";
+	case PERF_REG_X86_DX:
+		return "DX";
+	case PERF_REG_X86_SI:
+		return "SI";
+	case PERF_REG_X86_DI:
+		return "DI";
+	case PERF_REG_X86_BP:
+		return "BP";
+	case PERF_REG_X86_SP:
+		return "SP";
+	case PERF_REG_X86_IP:
+		return "IP";
+	case PERF_REG_X86_FLAGS:
+		return "FLAGS";
+	case PERF_REG_X86_CS:
+		return "CS";
+	case PERF_REG_X86_SS:
+		return "SS";
+	case PERF_REG_X86_DS:
+		return "DS";
+	case PERF_REG_X86_ES:
+		return "ES";
+	case PERF_REG_X86_FS:
+		return "FS";
+	case PERF_REG_X86_GS:
+		return "GS";
+	case PERF_REG_X86_R8:
+		return "R8";
+	case PERF_REG_X86_R9:
+		return "R9";
+	case PERF_REG_X86_R10:
+		return "R10";
+	case PERF_REG_X86_R11:
+		return "R11";
+	case PERF_REG_X86_R12:
+		return "R12";
+	case PERF_REG_X86_R13:
+		return "R13";
+	case PERF_REG_X86_R14:
+		return "R14";
+	case PERF_REG_X86_R15:
+		return "R15";
+
+#define XMM(x) \
+	case PERF_REG_X86_XMM ## x:	\
+	case PERF_REG_X86_XMM ## x + 1:	\
+		return "XMM" #x;
+	XMM(0)
+	XMM(1)
+	XMM(2)
+	XMM(3)
+	XMM(4)
+	XMM(5)
+	XMM(6)
+	XMM(7)
+	XMM(8)
+	XMM(9)
+	XMM(10)
+	XMM(11)
+	XMM(12)
+	XMM(13)
+	XMM(14)
+	XMM(15)
+#undef XMM
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif /* __PERF_REGS_X86_H */
\ No newline at end of file
-- 
2.25.1

