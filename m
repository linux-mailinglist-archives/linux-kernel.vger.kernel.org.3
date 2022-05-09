Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C803C520023
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiEIOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiEIOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:47:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4F321BA8C8;
        Mon,  9 May 2022 07:43:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1F87153B;
        Mon,  9 May 2022 07:43:29 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.4.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61FD93F73D;
        Mon,  9 May 2022 07:43:27 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org
Cc:     german.gomez@arm.com, James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH v1 1/6] perf: arm64: Add SVE vector granule register to user regs
Date:   Mon,  9 May 2022 15:42:49 +0100
Message-Id: <20220509144257.1623063-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220509144257.1623063-1-james.clark@arm.com>
References: <20220509144257.1623063-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwarf based unwinding in a function that pushes SVE registers onto
the stack requires the unwinder to know the length of the SVE register
to calculate the stack offsets correctly. This was added to the Arm
specific Dwarf spec as the VG pseudo register[1].

Add the vector length at position 46 if it's requested by userspace and
SVE is supported. If it's not supported then fail to open the event.

The vector length must be on each sample because it can be changed
at runtime via a prctl or ptrace call. Also by adding it as a register
rather than a separate attribute, minimal changes will be required in an
unwinder that already indexes into the register list.

[1]: https://github.com/ARM-software/abi-aa/blob/main/aadwarf64/aadwarf64.rst

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/uapi/asm/perf_regs.h |  7 +++++-
 arch/arm64/kernel/perf_regs.c           | 30 +++++++++++++++++++++++--
 drivers/perf/arm_pmu.c                  |  2 +-
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/perf_regs.h b/arch/arm64/include/uapi/asm/perf_regs.h
index d54daafa89e3..fd157f46727e 100644
--- a/arch/arm64/include/uapi/asm/perf_regs.h
+++ b/arch/arm64/include/uapi/asm/perf_regs.h
@@ -36,6 +36,11 @@ enum perf_event_arm_regs {
 	PERF_REG_ARM64_LR,
 	PERF_REG_ARM64_SP,
 	PERF_REG_ARM64_PC,
-	PERF_REG_ARM64_MAX,
+
+	/* Extended/pseudo registers */
+	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
+
+	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
+	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
 };
 #endif /* _ASM_ARM64_PERF_REGS_H */
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index f6f58e6265df..b4eece3eb17d 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -9,9 +9,27 @@
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
+static u64 perf_ext_regs_value(int idx)
+{
+	switch (idx) {
+	case PERF_REG_ARM64_VG:
+		if (WARN_ON_ONCE(!system_supports_sve()))
+			return 0;
+
+		/*
+		 * Vector granule is current length in bits of SVE registers
+		 * divided by 64.
+		 */
+		return (task_get_sve_vl(current) * 8) / 64;
+	default:
+		WARN_ON_ONCE(true);
+		return 0;
+	}
+}
+
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
-	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_MAX))
+	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_EXTENDED_MAX))
 		return 0;
 
 	/*
@@ -51,6 +69,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	if ((u32)idx == PERF_REG_ARM64_PC)
 		return regs->pc;
 
+	if ((u32)idx >= PERF_REG_ARM64_MAX)
+		return perf_ext_regs_value(idx);
+
 	return regs->regs[idx];
 }
 
@@ -58,7 +79,12 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || mask & REG_RESERVED)
+	u64 reserved_mask = REG_RESERVED;
+
+	if (system_supports_sve())
+		reserved_mask &= ~(1ULL << PERF_REG_ARM64_VG);
+
+	if (!mask || mask & reserved_mask)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 59d3980b8ca2..3f07df5a7e95 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -894,7 +894,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 		 * pmu::filter_match callback and pmu::event_init group
 		 * validation).
 		 */
-		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS,
+		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
 	};
 
 	pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =
-- 
2.28.0

