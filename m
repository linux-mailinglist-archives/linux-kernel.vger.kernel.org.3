Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E236D464DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349364AbhLAMjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:39:19 -0500
Received: from foss.arm.com ([217.140.110.172]:35988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349353AbhLAMht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:37:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF068147A;
        Wed,  1 Dec 2021 04:34:28 -0800 (PST)
Received: from e127744.cambridge.arm.com (e127744.cambridge.arm.com [10.1.32.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1D543F694;
        Wed,  1 Dec 2021 04:34:25 -0800 (PST)
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
Subject: [PATCH v1 4/4] perf tools: Support register names from all architectures
Date:   Wed,  1 Dec 2021 12:33:32 +0000
Message-Id: <20211201123334.679131-5-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201123334.679131-1-german.gomez@arm.com>
References: <20211201123334.679131-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading a perf.data file with register values, there is a mismatch
between the names and the values of the registers because the tool is
built using only the register names from the local architecture.

Reading a perf.data file that was recorded on Arm64, gives the following
erroneous output on an x86 machine:

  # perf report -i perf_arm64.data -D
  [...]
  24661932634451 0x698 [0x21d0]: PERF_RECORD_SAMPLE(IP, 0x1): 43239/43239: 0xffffc5be8f100f98 period: 1 addr: 0
  ... user regs: mask 0x1ffffffff ABI 64-bit
  .... AX    0x0000ffffd1515817
  .... BX    0x0000ffffd1515480
  .... CX    0x0000aaaadabf6c80
  .... DX    0x000000000000002e
  .... SI    0x0000000040100401
  .... DI    0x0040600200000080
  .... BP    0x0000ffffd1510e10
  .... SP    0x0000000000000000
  .... IP    0x00000000000000dd
  .... FLAGS 0x0000ffffd1510cd0
  .... CS    0x0000000000000000
  .... SS    0x0000000000000030
  .... DS    0x0000ffffa569a208
  .... ES    0x0000000000000000
  .... FS    0x0000000000000000
  .... GS    0x0000000000000000
  .... R8    0x0000aaaad3de9650
  .... R9    0x0000ffffa57397f0
  .... R10   0x0000000000000001
  .... R11   0x0000ffffa57fd000
  .... R12   0x0000ffffd1515817
  .... R13   0x0000ffffd1515480
  .... R14   0x0000aaaadabf6c80
  .... R15   0x0000000000000000
  .... unknown 0x0000000000000001
  .... unknown 0x0000000000000000
  .... unknown 0x0000000000000000
  .... unknown 0x0000000000000000
  .... unknown 0x0000000000000000
  .... unknown 0x0000ffffd1510d90
  .... unknown 0x0000ffffa5739b90
  .... unknown 0x0000ffffd1510d80
  .... XMM0  0x0000ffffa57392c8
   ... thread: perf-exec:43239
   ...... dso: [kernel.kallsyms]

As can be seen, the register names correspond to x86 registers, even
though the perf.data file was recorded on an Arm64 system. After this
patch, the output of the command displays the correct register names:

  # perf report -i perf_arm64.data -D
  [...]
  24661932634451 0x698 [0x21d0]: PERF_RECORD_SAMPLE(IP, 0x1): 43239/43239: 0xffffc5be8f100f98 period: 1 addr: 0
  ... user regs: mask 0x1ffffffff ABI 64-bit
  .... x0    0x0000ffffd1515817
  .... x1    0x0000ffffd1515480
  .... x2    0x0000aaaadabf6c80
  .... x3    0x000000000000002e
  .... x4    0x0000000040100401
  .... x5    0x0040600200000080
  .... x6    0x0000ffffd1510e10
  .... x7    0x0000000000000000
  .... x8    0x00000000000000dd
  .... x9    0x0000ffffd1510cd0
  .... x10   0x0000000000000000
  .... x11   0x0000000000000030
  .... x12   0x0000ffffa569a208
  .... x13   0x0000000000000000
  .... x14   0x0000000000000000
  .... x15   0x0000000000000000
  .... x16   0x0000aaaad3de9650
  .... x17   0x0000ffffa57397f0
  .... x18   0x0000000000000001
  .... x19   0x0000ffffa57fd000
  .... x20   0x0000ffffd1515817
  .... x21   0x0000ffffd1515480
  .... x22   0x0000aaaadabf6c80
  .... x23   0x0000000000000000
  .... x24   0x0000000000000001
  .... x25   0x0000000000000000
  .... x26   0x0000000000000000
  .... x27   0x0000000000000000
  .... x28   0x0000000000000000
  .... x29   0x0000ffffd1510d90
  .... lr    0x0000ffffa5739b90
  .... sp    0x0000ffffd1510d80
  .... pc    0x0000ffffa57392c8
   ... thread: perf-exec:43239
   ...... dso: [kernel.kallsyms]

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/arch/arm/include/perf_regs.h       | 42 ----------
 tools/perf/arch/arm64/include/perf_regs.h     | 76 -----------------
 tools/perf/arch/csky/include/perf_regs.h      | 82 -------------------
 tools/perf/arch/mips/include/perf_regs.h      | 69 ----------------
 tools/perf/arch/powerpc/include/perf_regs.h   | 66 ---------------
 tools/perf/arch/riscv/include/perf_regs.h     | 74 -----------------
 tools/perf/arch/s390/include/perf_regs.h      | 78 ------------------
 tools/perf/arch/x86/include/perf_regs.h       | 82 -------------------
 tools/perf/builtin-script.c                   | 24 +++---
 tools/perf/util/perf_regs.h                   | 33 +++++++-
 .../scripting-engines/trace-event-python.c    | 12 +--
 tools/perf/util/session.c                     | 25 +++---
 12 files changed, 62 insertions(+), 601 deletions(-)

diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
index 408541928..99a06550e 100644
--- a/tools/perf/arch/arm/include/perf_regs.h
+++ b/tools/perf/arch/arm/include/perf_regs.h
@@ -15,46 +15,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP	PERF_REG_ARM_PC
 #define PERF_REG_SP	PERF_REG_ARM_SP
 
-static inline const char *__perf_reg_name(int id)
-{
-	switch (id) {
-	case PERF_REG_ARM_R0:
-		return "r0";
-	case PERF_REG_ARM_R1:
-		return "r1";
-	case PERF_REG_ARM_R2:
-		return "r2";
-	case PERF_REG_ARM_R3:
-		return "r3";
-	case PERF_REG_ARM_R4:
-		return "r4";
-	case PERF_REG_ARM_R5:
-		return "r5";
-	case PERF_REG_ARM_R6:
-		return "r6";
-	case PERF_REG_ARM_R7:
-		return "r7";
-	case PERF_REG_ARM_R8:
-		return "r8";
-	case PERF_REG_ARM_R9:
-		return "r9";
-	case PERF_REG_ARM_R10:
-		return "r10";
-	case PERF_REG_ARM_FP:
-		return "fp";
-	case PERF_REG_ARM_IP:
-		return "ip";
-	case PERF_REG_ARM_SP:
-		return "sp";
-	case PERF_REG_ARM_LR:
-		return "lr";
-	case PERF_REG_ARM_PC:
-		return "pc";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index fa3e07459..c4eb1dcfa 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -15,80 +15,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP	PERF_REG_ARM64_PC
 #define PERF_REG_SP	PERF_REG_ARM64_SP
 
-static inline const char *__perf_reg_name(int id)
-{
-	switch (id) {
-	case PERF_REG_ARM64_X0:
-		return "x0";
-	case PERF_REG_ARM64_X1:
-		return "x1";
-	case PERF_REG_ARM64_X2:
-		return "x2";
-	case PERF_REG_ARM64_X3:
-		return "x3";
-	case PERF_REG_ARM64_X4:
-		return "x4";
-	case PERF_REG_ARM64_X5:
-		return "x5";
-	case PERF_REG_ARM64_X6:
-		return "x6";
-	case PERF_REG_ARM64_X7:
-		return "x7";
-	case PERF_REG_ARM64_X8:
-		return "x8";
-	case PERF_REG_ARM64_X9:
-		return "x9";
-	case PERF_REG_ARM64_X10:
-		return "x10";
-	case PERF_REG_ARM64_X11:
-		return "x11";
-	case PERF_REG_ARM64_X12:
-		return "x12";
-	case PERF_REG_ARM64_X13:
-		return "x13";
-	case PERF_REG_ARM64_X14:
-		return "x14";
-	case PERF_REG_ARM64_X15:
-		return "x15";
-	case PERF_REG_ARM64_X16:
-		return "x16";
-	case PERF_REG_ARM64_X17:
-		return "x17";
-	case PERF_REG_ARM64_X18:
-		return "x18";
-	case PERF_REG_ARM64_X19:
-		return "x19";
-	case PERF_REG_ARM64_X20:
-		return "x20";
-	case PERF_REG_ARM64_X21:
-		return "x21";
-	case PERF_REG_ARM64_X22:
-		return "x22";
-	case PERF_REG_ARM64_X23:
-		return "x23";
-	case PERF_REG_ARM64_X24:
-		return "x24";
-	case PERF_REG_ARM64_X25:
-		return "x25";
-	case PERF_REG_ARM64_X26:
-		return "x26";
-	case PERF_REG_ARM64_X27:
-		return "x27";
-	case PERF_REG_ARM64_X28:
-		return "x28";
-	case PERF_REG_ARM64_X29:
-		return "x29";
-	case PERF_REG_ARM64_SP:
-		return "sp";
-	case PERF_REG_ARM64_LR:
-		return "lr";
-	case PERF_REG_ARM64_PC:
-		return "pc";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch/csky/include/perf_regs.h
index 25ac3bdcb..1afcc0e91 100644
--- a/tools/perf/arch/csky/include/perf_regs.h
+++ b/tools/perf/arch/csky/include/perf_regs.h
@@ -15,86 +15,4 @@
 #define PERF_REG_IP	PERF_REG_CSKY_PC
 #define PERF_REG_SP	PERF_REG_CSKY_SP
 
-static inline const char *__perf_reg_name(int id)
-{
-	switch (id) {
-	case PERF_REG_CSKY_A0:
-		return "a0";
-	case PERF_REG_CSKY_A1:
-		return "a1";
-	case PERF_REG_CSKY_A2:
-		return "a2";
-	case PERF_REG_CSKY_A3:
-		return "a3";
-	case PERF_REG_CSKY_REGS0:
-		return "regs0";
-	case PERF_REG_CSKY_REGS1:
-		return "regs1";
-	case PERF_REG_CSKY_REGS2:
-		return "regs2";
-	case PERF_REG_CSKY_REGS3:
-		return "regs3";
-	case PERF_REG_CSKY_REGS4:
-		return "regs4";
-	case PERF_REG_CSKY_REGS5:
-		return "regs5";
-	case PERF_REG_CSKY_REGS6:
-		return "regs6";
-	case PERF_REG_CSKY_REGS7:
-		return "regs7";
-	case PERF_REG_CSKY_REGS8:
-		return "regs8";
-	case PERF_REG_CSKY_REGS9:
-		return "regs9";
-	case PERF_REG_CSKY_SP:
-		return "sp";
-	case PERF_REG_CSKY_LR:
-		return "lr";
-	case PERF_REG_CSKY_PC:
-		return "pc";
-#if defined(__CSKYABIV2__)
-	case PERF_REG_CSKY_EXREGS0:
-		return "exregs0";
-	case PERF_REG_CSKY_EXREGS1:
-		return "exregs1";
-	case PERF_REG_CSKY_EXREGS2:
-		return "exregs2";
-	case PERF_REG_CSKY_EXREGS3:
-		return "exregs3";
-	case PERF_REG_CSKY_EXREGS4:
-		return "exregs4";
-	case PERF_REG_CSKY_EXREGS5:
-		return "exregs5";
-	case PERF_REG_CSKY_EXREGS6:
-		return "exregs6";
-	case PERF_REG_CSKY_EXREGS7:
-		return "exregs7";
-	case PERF_REG_CSKY_EXREGS8:
-		return "exregs8";
-	case PERF_REG_CSKY_EXREGS9:
-		return "exregs9";
-	case PERF_REG_CSKY_EXREGS10:
-		return "exregs10";
-	case PERF_REG_CSKY_EXREGS11:
-		return "exregs11";
-	case PERF_REG_CSKY_EXREGS12:
-		return "exregs12";
-	case PERF_REG_CSKY_EXREGS13:
-		return "exregs13";
-	case PERF_REG_CSKY_EXREGS14:
-		return "exregs14";
-	case PERF_REG_CSKY_TLS:
-		return "tls";
-	case PERF_REG_CSKY_HI:
-		return "hi";
-	case PERF_REG_CSKY_LO:
-		return "lo";
-#endif
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/mips/include/perf_regs.h b/tools/perf/arch/mips/include/perf_regs.h
index ee73b36a1..b8cd8bbb3 100644
--- a/tools/perf/arch/mips/include/perf_regs.h
+++ b/tools/perf/arch/mips/include/perf_regs.h
@@ -12,73 +12,4 @@
 
 #define PERF_REGS_MASK ((1ULL << PERF_REG_MIPS_MAX) - 1)
 
-static inline const char *__perf_reg_name(int id)
-{
-	switch (id) {
-	case PERF_REG_MIPS_PC:
-		return "PC";
-	case PERF_REG_MIPS_R1:
-		return "$1";
-	case PERF_REG_MIPS_R2:
-		return "$2";
-	case PERF_REG_MIPS_R3:
-		return "$3";
-	case PERF_REG_MIPS_R4:
-		return "$4";
-	case PERF_REG_MIPS_R5:
-		return "$5";
-	case PERF_REG_MIPS_R6:
-		return "$6";
-	case PERF_REG_MIPS_R7:
-		return "$7";
-	case PERF_REG_MIPS_R8:
-		return "$8";
-	case PERF_REG_MIPS_R9:
-		return "$9";
-	case PERF_REG_MIPS_R10:
-		return "$10";
-	case PERF_REG_MIPS_R11:
-		return "$11";
-	case PERF_REG_MIPS_R12:
-		return "$12";
-	case PERF_REG_MIPS_R13:
-		return "$13";
-	case PERF_REG_MIPS_R14:
-		return "$14";
-	case PERF_REG_MIPS_R15:
-		return "$15";
-	case PERF_REG_MIPS_R16:
-		return "$16";
-	case PERF_REG_MIPS_R17:
-		return "$17";
-	case PERF_REG_MIPS_R18:
-		return "$18";
-	case PERF_REG_MIPS_R19:
-		return "$19";
-	case PERF_REG_MIPS_R20:
-		return "$20";
-	case PERF_REG_MIPS_R21:
-		return "$21";
-	case PERF_REG_MIPS_R22:
-		return "$22";
-	case PERF_REG_MIPS_R23:
-		return "$23";
-	case PERF_REG_MIPS_R24:
-		return "$24";
-	case PERF_REG_MIPS_R25:
-		return "$25";
-	case PERF_REG_MIPS_R28:
-		return "$28";
-	case PERF_REG_MIPS_R29:
-		return "$29";
-	case PERF_REG_MIPS_R30:
-		return "$30";
-	case PERF_REG_MIPS_R31:
-		return "$31";
-	default:
-		break;
-	}
-	return NULL;
-}
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 93339d17a..9bb17c3f3 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -19,70 +19,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP     PERF_REG_POWERPC_NIP
 #define PERF_REG_SP     PERF_REG_POWERPC_R1
 
-static const char *reg_names[] = {
-	[PERF_REG_POWERPC_R0] = "r0",
-	[PERF_REG_POWERPC_R1] = "r1",
-	[PERF_REG_POWERPC_R2] = "r2",
-	[PERF_REG_POWERPC_R3] = "r3",
-	[PERF_REG_POWERPC_R4] = "r4",
-	[PERF_REG_POWERPC_R5] = "r5",
-	[PERF_REG_POWERPC_R6] = "r6",
-	[PERF_REG_POWERPC_R7] = "r7",
-	[PERF_REG_POWERPC_R8] = "r8",
-	[PERF_REG_POWERPC_R9] = "r9",
-	[PERF_REG_POWERPC_R10] = "r10",
-	[PERF_REG_POWERPC_R11] = "r11",
-	[PERF_REG_POWERPC_R12] = "r12",
-	[PERF_REG_POWERPC_R13] = "r13",
-	[PERF_REG_POWERPC_R14] = "r14",
-	[PERF_REG_POWERPC_R15] = "r15",
-	[PERF_REG_POWERPC_R16] = "r16",
-	[PERF_REG_POWERPC_R17] = "r17",
-	[PERF_REG_POWERPC_R18] = "r18",
-	[PERF_REG_POWERPC_R19] = "r19",
-	[PERF_REG_POWERPC_R20] = "r20",
-	[PERF_REG_POWERPC_R21] = "r21",
-	[PERF_REG_POWERPC_R22] = "r22",
-	[PERF_REG_POWERPC_R23] = "r23",
-	[PERF_REG_POWERPC_R24] = "r24",
-	[PERF_REG_POWERPC_R25] = "r25",
-	[PERF_REG_POWERPC_R26] = "r26",
-	[PERF_REG_POWERPC_R27] = "r27",
-	[PERF_REG_POWERPC_R28] = "r28",
-	[PERF_REG_POWERPC_R29] = "r29",
-	[PERF_REG_POWERPC_R30] = "r30",
-	[PERF_REG_POWERPC_R31] = "r31",
-	[PERF_REG_POWERPC_NIP] = "nip",
-	[PERF_REG_POWERPC_MSR] = "msr",
-	[PERF_REG_POWERPC_ORIG_R3] = "orig_r3",
-	[PERF_REG_POWERPC_CTR] = "ctr",
-	[PERF_REG_POWERPC_LINK] = "link",
-	[PERF_REG_POWERPC_XER] = "xer",
-	[PERF_REG_POWERPC_CCR] = "ccr",
-	[PERF_REG_POWERPC_SOFTE] = "softe",
-	[PERF_REG_POWERPC_TRAP] = "trap",
-	[PERF_REG_POWERPC_DAR] = "dar",
-	[PERF_REG_POWERPC_DSISR] = "dsisr",
-	[PERF_REG_POWERPC_SIER] = "sier",
-	[PERF_REG_POWERPC_MMCRA] = "mmcra",
-	[PERF_REG_POWERPC_MMCR0] = "mmcr0",
-	[PERF_REG_POWERPC_MMCR1] = "mmcr1",
-	[PERF_REG_POWERPC_MMCR2] = "mmcr2",
-	[PERF_REG_POWERPC_MMCR3] = "mmcr3",
-	[PERF_REG_POWERPC_SIER2] = "sier2",
-	[PERF_REG_POWERPC_SIER3] = "sier3",
-	[PERF_REG_POWERPC_PMC1] = "pmc1",
-	[PERF_REG_POWERPC_PMC2] = "pmc2",
-	[PERF_REG_POWERPC_PMC3] = "pmc3",
-	[PERF_REG_POWERPC_PMC4] = "pmc4",
-	[PERF_REG_POWERPC_PMC5] = "pmc5",
-	[PERF_REG_POWERPC_PMC6] = "pmc6",
-	[PERF_REG_POWERPC_SDAR] = "sdar",
-	[PERF_REG_POWERPC_SIAR] = "siar",
-};
-
-static inline const char *__perf_reg_name(int id)
-{
-	return reg_names[id];
-}
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
index 6b02a767c..6944bf0de 100644
--- a/tools/perf/arch/riscv/include/perf_regs.h
+++ b/tools/perf/arch/riscv/include/perf_regs.h
@@ -19,78 +19,4 @@
 #define PERF_REG_IP	PERF_REG_RISCV_PC
 #define PERF_REG_SP	PERF_REG_RISCV_SP
 
-static inline const char *__perf_reg_name(int id)
-{
-	switch (id) {
-	case PERF_REG_RISCV_PC:
-		return "pc";
-	case PERF_REG_RISCV_RA:
-		return "ra";
-	case PERF_REG_RISCV_SP:
-		return "sp";
-	case PERF_REG_RISCV_GP:
-		return "gp";
-	case PERF_REG_RISCV_TP:
-		return "tp";
-	case PERF_REG_RISCV_T0:
-		return "t0";
-	case PERF_REG_RISCV_T1:
-		return "t1";
-	case PERF_REG_RISCV_T2:
-		return "t2";
-	case PERF_REG_RISCV_S0:
-		return "s0";
-	case PERF_REG_RISCV_S1:
-		return "s1";
-	case PERF_REG_RISCV_A0:
-		return "a0";
-	case PERF_REG_RISCV_A1:
-		return "a1";
-	case PERF_REG_RISCV_A2:
-		return "a2";
-	case PERF_REG_RISCV_A3:
-		return "a3";
-	case PERF_REG_RISCV_A4:
-		return "a4";
-	case PERF_REG_RISCV_A5:
-		return "a5";
-	case PERF_REG_RISCV_A6:
-		return "a6";
-	case PERF_REG_RISCV_A7:
-		return "a7";
-	case PERF_REG_RISCV_S2:
-		return "s2";
-	case PERF_REG_RISCV_S3:
-		return "s3";
-	case PERF_REG_RISCV_S4:
-		return "s4";
-	case PERF_REG_RISCV_S5:
-		return "s5";
-	case PERF_REG_RISCV_S6:
-		return "s6";
-	case PERF_REG_RISCV_S7:
-		return "s7";
-	case PERF_REG_RISCV_S8:
-		return "s8";
-	case PERF_REG_RISCV_S9:
-		return "s9";
-	case PERF_REG_RISCV_S10:
-		return "s10";
-	case PERF_REG_RISCV_S11:
-		return "s11";
-	case PERF_REG_RISCV_T3:
-		return "t3";
-	case PERF_REG_RISCV_T4:
-		return "t4";
-	case PERF_REG_RISCV_T5:
-		return "t5";
-	case PERF_REG_RISCV_T6:
-		return "t6";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch/s390/include/perf_regs.h
index ce3031526..52fcc0891 100644
--- a/tools/perf/arch/s390/include/perf_regs.h
+++ b/tools/perf/arch/s390/include/perf_regs.h
@@ -14,82 +14,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP PERF_REG_S390_PC
 #define PERF_REG_SP PERF_REG_S390_R15
 
-static inline const char *__perf_reg_name(int id)
-{
-	switch (id) {
-	case PERF_REG_S390_R0:
-		return "R0";
-	case PERF_REG_S390_R1:
-		return "R1";
-	case PERF_REG_S390_R2:
-		return "R2";
-	case PERF_REG_S390_R3:
-		return "R3";
-	case PERF_REG_S390_R4:
-		return "R4";
-	case PERF_REG_S390_R5:
-		return "R5";
-	case PERF_REG_S390_R6:
-		return "R6";
-	case PERF_REG_S390_R7:
-		return "R7";
-	case PERF_REG_S390_R8:
-		return "R8";
-	case PERF_REG_S390_R9:
-		return "R9";
-	case PERF_REG_S390_R10:
-		return "R10";
-	case PERF_REG_S390_R11:
-		return "R11";
-	case PERF_REG_S390_R12:
-		return "R12";
-	case PERF_REG_S390_R13:
-		return "R13";
-	case PERF_REG_S390_R14:
-		return "R14";
-	case PERF_REG_S390_R15:
-		return "R15";
-	case PERF_REG_S390_FP0:
-		return "FP0";
-	case PERF_REG_S390_FP1:
-		return "FP1";
-	case PERF_REG_S390_FP2:
-		return "FP2";
-	case PERF_REG_S390_FP3:
-		return "FP3";
-	case PERF_REG_S390_FP4:
-		return "FP4";
-	case PERF_REG_S390_FP5:
-		return "FP5";
-	case PERF_REG_S390_FP6:
-		return "FP6";
-	case PERF_REG_S390_FP7:
-		return "FP7";
-	case PERF_REG_S390_FP8:
-		return "FP8";
-	case PERF_REG_S390_FP9:
-		return "FP9";
-	case PERF_REG_S390_FP10:
-		return "FP10";
-	case PERF_REG_S390_FP11:
-		return "FP11";
-	case PERF_REG_S390_FP12:
-		return "FP12";
-	case PERF_REG_S390_FP13:
-		return "FP13";
-	case PERF_REG_S390_FP14:
-		return "FP14";
-	case PERF_REG_S390_FP15:
-		return "FP15";
-	case PERF_REG_S390_MASK:
-		return "MASK";
-	case PERF_REG_S390_PC:
-		return "PC";
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index cddc4cdc0..16e23b722 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -23,86 +23,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP PERF_REG_X86_IP
 #define PERF_REG_SP PERF_REG_X86_SP
 
-static inline const char *__perf_reg_name(int id)
-{
-	switch (id) {
-	case PERF_REG_X86_AX:
-		return "AX";
-	case PERF_REG_X86_BX:
-		return "BX";
-	case PERF_REG_X86_CX:
-		return "CX";
-	case PERF_REG_X86_DX:
-		return "DX";
-	case PERF_REG_X86_SI:
-		return "SI";
-	case PERF_REG_X86_DI:
-		return "DI";
-	case PERF_REG_X86_BP:
-		return "BP";
-	case PERF_REG_X86_SP:
-		return "SP";
-	case PERF_REG_X86_IP:
-		return "IP";
-	case PERF_REG_X86_FLAGS:
-		return "FLAGS";
-	case PERF_REG_X86_CS:
-		return "CS";
-	case PERF_REG_X86_SS:
-		return "SS";
-	case PERF_REG_X86_DS:
-		return "DS";
-	case PERF_REG_X86_ES:
-		return "ES";
-	case PERF_REG_X86_FS:
-		return "FS";
-	case PERF_REG_X86_GS:
-		return "GS";
-#ifdef HAVE_ARCH_X86_64_SUPPORT
-	case PERF_REG_X86_R8:
-		return "R8";
-	case PERF_REG_X86_R9:
-		return "R9";
-	case PERF_REG_X86_R10:
-		return "R10";
-	case PERF_REG_X86_R11:
-		return "R11";
-	case PERF_REG_X86_R12:
-		return "R12";
-	case PERF_REG_X86_R13:
-		return "R13";
-	case PERF_REG_X86_R14:
-		return "R14";
-	case PERF_REG_X86_R15:
-		return "R15";
-#endif /* HAVE_ARCH_X86_64_SUPPORT */
-
-#define XMM(x) \
-	case PERF_REG_X86_XMM ## x:	\
-	case PERF_REG_X86_XMM ## x + 1:	\
-		return "XMM" #x;
-	XMM(0)
-	XMM(1)
-	XMM(2)
-	XMM(3)
-	XMM(4)
-	XMM(5)
-	XMM(6)
-	XMM(7)
-	XMM(8)
-	XMM(9)
-	XMM(10)
-	XMM(11)
-	XMM(12)
-	XMM(13)
-	XMM(14)
-	XMM(15)
-#undef XMM
-	default:
-		return NULL;
-	}
-
-	return NULL;
-}
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 711132f0b..3da0c95c6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4,6 +4,7 @@
 #include "util/counts.h"
 #include "util/debug.h"
 #include "util/dso.h"
+#include "util/env.h"
 #include <subcmd/exec-cmd.h>
 #include "util/header.h"
 #include <subcmd/parse-options.h>
@@ -649,7 +650,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 }
 
 static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
-				     FILE *fp)
+				     const char *arch, FILE *fp)
 {
 	unsigned i = 0, r;
 	int printed = 0;
@@ -661,7 +662,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, arch), val);
 	}
 
 	return printed;
@@ -717,18 +718,16 @@ tod_scnprintf(struct perf_script *script, char *buf, int buflen,
 	return buf;
 }
 
-static int perf_sample__fprintf_iregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, FILE *fp)
+static int perf_sample__fprintf_iregs(struct perf_sample *sample, struct perf_event_attr *attr,
+				      const char *arch, FILE *fp)
 {
-	return perf_sample__fprintf_regs(&sample->intr_regs,
-					 attr->sample_regs_intr, fp);
+	return perf_sample__fprintf_regs(&sample->intr_regs, attr->sample_regs_intr, arch, fp);
 }
 
-static int perf_sample__fprintf_uregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, FILE *fp)
+static int perf_sample__fprintf_uregs(struct perf_sample *sample, struct perf_event_attr *attr,
+				      const char *arch, FILE *fp)
 {
-	return perf_sample__fprintf_regs(&sample->user_regs,
-					 attr->sample_regs_user, fp);
+	return perf_sample__fprintf_regs(&sample->user_regs, attr->sample_regs_user, arch, fp);
 }
 
 static int perf_sample__fprintf_start(struct perf_script *script,
@@ -2000,6 +1999,7 @@ static void process_event(struct perf_script *script,
 	struct evsel_script *es = evsel->priv;
 	FILE *fp = es->fp;
 	char str[PAGE_SIZE_NAME_LEN];
+	const char *arch = perf_env__arch(machine->env);
 
 	if (output[type].fields == 0)
 		return;
@@ -2066,10 +2066,10 @@ static void process_event(struct perf_script *script,
 	}
 
 	if (PRINT_FIELD(IREGS))
-		perf_sample__fprintf_iregs(sample, attr, fp);
+		perf_sample__fprintf_iregs(sample, attr, arch, fp);
 
 	if (PRINT_FIELD(UREGS))
-		perf_sample__fprintf_uregs(sample, attr, fp);
+		perf_sample__fprintf_uregs(sample, attr, arch, fp);
 
 	if (PRINT_FIELD(BRSTACK))
 		perf_sample__fprintf_brstack(sample, thread, attr, fp);
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index eeac181eb..a201181fc 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -27,15 +27,42 @@ uint64_t arch__user_reg_mask(void);
 #ifdef HAVE_PERF_REGS_SUPPORT
 extern const struct sample_reg sample_reg_masks[];
 
+#include <string.h>
 #include <perf_regs.h>
 
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
 
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
-static inline const char *perf_reg_name(int id)
+#include "perf_regs_csky.h"
+#include "perf_regs_mips.h"
+#include "perf_regs_powerpc.h"
+#include "perf_regs_riscv.h"
+#include "perf_regs_s390.h"
+#include "perf_regs_x86.h"
+#include "perf_regs_arm.h"
+#include "perf_regs_arm64.h"
+
+static inline const char *perf_reg_name(int id, const char *arch)
 {
-	const char *reg_name = __perf_reg_name(id);
+	const char *reg_name = NULL;
+
+	if (!strcmp(arch, "csky"))
+		reg_name = __perf_reg_name_csky(id);
+	else if (!strcmp(arch, "mips"))
+		reg_name = __perf_reg_name_mips(id);
+	else if (!strcmp(arch, "powerpc"))
+		reg_name = __perf_reg_name_powerpc(id);
+	else if (!strcmp(arch, "riscv"))
+		reg_name = __perf_reg_name_riscv(id);
+	else if (!strcmp(arch, "s390"))
+		reg_name = __perf_reg_name_s390(id);
+	else if (!strcmp(arch, "x86"))
+		reg_name = __perf_reg_name_x86(id);
+	else if (!strcmp(arch, "arm"))
+		reg_name = __perf_reg_name_arm(id);
+	else if (!strcmp(arch, "arm64"))
+		reg_name = __perf_reg_name_arm64(id);
 
 	return reg_name ?: "unknown";
 }
@@ -46,7 +73,7 @@ static inline const char *perf_reg_name(int id)
 
 #define DWARF_MINIMAL_REGS PERF_REGS_MASK
 
-static inline const char *perf_reg_name(int id __maybe_unused)
+static inline const char *perf_reg_name(int id __maybe_unused, const char *arch __maybe_unused)
 {
 	return "unknown";
 }
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e164f8d00..373fdd798 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -36,6 +36,7 @@
 #include "../debug.h"
 #include "../dso.h"
 #include "../callchain.h"
+#include "../env.h"
 #include "../evsel.h"
 #include "../event.h"
 #include "../thread.h"
@@ -687,7 +688,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 			_PyUnicode_FromString(decode));
 }
 
-static void regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
+static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, char *bf, int size)
 {
 	unsigned int i = 0, r;
 	int printed = 0;
@@ -702,16 +703,17 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
 
 		printed += scnprintf(bf + printed, size - printed,
 				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r), val);
+				     perf_reg_name(r, arch), val);
 	}
 }
 
 static void set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
 			     struct evsel *evsel,
-			     struct machine *machine __maybe_unused)
+			     struct machine *machine)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
+	const char *arch = perf_env__arch(machine->env);
 
 	/*
 	 * Here value 28 is a constant size which can be used to print
@@ -723,12 +725,12 @@ static void set_regs_in_dict(PyObject *dict,
 	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
 	char bf[size];
 
-	regs_map(&sample->intr_regs, attr->sample_regs_intr, bf, sizeof(bf));
+	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, sizeof(bf));
 
 	pydict_set_item_string_decref(dict, "iregs",
 			_PyUnicode_FromString(bf));
 
-	regs_map(&sample->user_regs, attr->sample_regs_user, bf, sizeof(bf));
+	regs_map(&sample->user_regs, attr->sample_regs_user, arch, bf, sizeof(bf));
 
 	pydict_set_item_string_decref(dict, "uregs",
 			_PyUnicode_FromString(bf));
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d8857d1b6..e1a273048 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -15,6 +15,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 #include "debug.h"
+#include "env.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "memswap.h"
@@ -1168,7 +1169,7 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 	}
 }
 
-static void regs_dump__printf(u64 mask, u64 *regs)
+static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
 {
 	unsigned rid, i = 0;
 
@@ -1176,7 +1177,7 @@ static void regs_dump__printf(u64 mask, u64 *regs)
 		u64 val = regs[i++];
 
 		printf(".... %-5s 0x%016" PRIx64 "\n",
-		       perf_reg_name(rid), val);
+		       perf_reg_name(rid, arch), val);
 	}
 }
 
@@ -1194,7 +1195,7 @@ static inline const char *regs_dump_abi(struct regs_dump *d)
 	return regs_abi[d->abi];
 }
 
-static void regs__printf(const char *type, struct regs_dump *regs)
+static void regs__printf(const char *type, struct regs_dump *regs, const char *arch)
 {
 	u64 mask = regs->mask;
 
@@ -1203,23 +1204,23 @@ static void regs__printf(const char *type, struct regs_dump *regs)
 	       mask,
 	       regs_dump_abi(regs));
 
-	regs_dump__printf(mask, regs->regs);
+	regs_dump__printf(mask, regs->regs, arch);
 }
 
-static void regs_user__printf(struct perf_sample *sample)
+static void regs_user__printf(struct perf_sample *sample, const char *arch)
 {
 	struct regs_dump *user_regs = &sample->user_regs;
 
 	if (user_regs->regs)
-		regs__printf("user", user_regs);
+		regs__printf("user", user_regs, arch);
 }
 
-static void regs_intr__printf(struct perf_sample *sample)
+static void regs_intr__printf(struct perf_sample *sample, const char *arch)
 {
 	struct regs_dump *intr_regs = &sample->intr_regs;
 
 	if (intr_regs->regs)
-		regs__printf("intr", intr_regs);
+		regs__printf("intr", intr_regs, arch);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
@@ -1304,7 +1305,7 @@ char *get_page_size_name(u64 size, char *str)
 }
 
 static void dump_sample(struct evsel *evsel, union perf_event *event,
-			struct perf_sample *sample)
+			struct perf_sample *sample, const char *arch)
 {
 	u64 sample_type;
 	char str[PAGE_SIZE_NAME_LEN];
@@ -1325,10 +1326,10 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		branch_stack__printf(sample, evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
-		regs_user__printf(sample);
+		regs_user__printf(sample, arch);
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
-		regs_intr__printf(sample);
+		regs_intr__printf(sample, arch);
 
 	if (sample_type & PERF_SAMPLE_STACK_USER)
 		stack_user__printf(&sample->user_stack);
@@ -1502,7 +1503,7 @@ static int machines__deliver_event(struct machines *machines,
 			++evlist->stats.nr_unknown_id;
 			return 0;
 		}
-		dump_sample(evsel, event, sample);
+		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
 		if (machine == NULL) {
 			++evlist->stats.nr_unprocessable_samples;
 			return 0;
-- 
2.25.1

