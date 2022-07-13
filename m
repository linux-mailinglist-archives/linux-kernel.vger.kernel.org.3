Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAE5731C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiGMI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiGMI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:59:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81083DC8B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:59:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 901B81424;
        Wed, 13 Jul 2022 01:59:40 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D462E3F792;
        Wed, 13 Jul 2022 01:59:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     german.gomez@arm.com, james.clark@arm.com, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers/perf: arm_spe: Fix consistency of SYS_PMSCR_EL1.CX
Date:   Wed, 13 Jul 2022 14:29:25 +0530
Message-Id: <20220713085925.2627533-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm_spe_pmu driver will enable SYS_PMSCR_EL1.CX in order to add CONTEXT
packets into the traces, if the owner of the perf event runs with required
capabilities i.e CAP_PERFMON or CAP_SYS_ADMIN via perfmon_capable() helper.

The value of this bit is computed in the arm_spe_event_to_pmscr() function
but the check for capabilities happens in the pmu event init callback i.e
arm_spe_pmu_event_init(). This suggests that the value of the CX bit should
remain consistent for the duration of the perf session.

However, the function arm_spe_event_to_pmscr() may be called later during
the event start callback i.e arm_spe_pmu_start() when the "current" process
is not the owner of the perf session, hence the CX bit setting is currently
not consistent.

One way to fix this, is by caching the required value of the CX bit during
the initialization of the PMU event, so that it remains consistent for the
duration of the session. It uses currently unused 'event->hw.flags' element
to cache perfmon_capable() value, which can be referred during event start
callback to compute SYS_PMSCR_EL1.CX. This ensures consistent availability
of context packets in the trace as per event owner capabilities.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: cea7d0d4a59b ("drivers/perf: Open access for CAP_PERFMON privileged process")
Reported-by: German Gomez <german.gomez@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Moved CONFIG_PID_IN_CONTEXTIDR config check inside the helper per Suzuki
- Changed the comment per Suzuki
- Renamed the helpers Per Suzuki
- Added "Fixes: " tag per German

Changes in V1:

https://lore.kernel.org/all/20220712051404.2546851-1-anshuman.khandual@arm.com/

 drivers/perf/arm_spe_pmu.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index db670b265897..c4290b0492fd 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -39,6 +39,24 @@
 #include <asm/mmu.h>
 #include <asm/sysreg.h>
 
+/*
+ * Cache if the event is allowed to trace Context information.
+ * This allows us to perform the check, i.e, perfmon_capable(),
+ * in the context of the event owner, once, during the event_init().
+ */
+#define SPE_PMU_HW_FLAGS_CX			BIT(0)
+
+static void set_spe_event_has_cx(struct perf_event *event)
+{
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
+}
+
+static bool get_spe_event_has_cx(struct perf_event *event)
+{
+	return !!(event->hw.flags & SPE_PMU_HW_FLAGS_CX);
+}
+
 #define ARM_SPE_BUF_PAD_BYTE			0
 
 struct arm_spe_pmu_buf {
@@ -272,7 +290,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 	if (!attr->exclude_kernel)
 		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
 
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (get_spe_event_has_cx(event))
 		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
 
 	return reg;
@@ -710,7 +728,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	reg = arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
+	set_spe_event_has_cx(event);
+	if (!get_spe_event_has_cx(event) &&
 	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
 		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
 		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
-- 
2.25.1

