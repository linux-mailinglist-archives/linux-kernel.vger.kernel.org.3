Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3A4908F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiAQMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:45:28 -0500
Received: from foss.arm.com ([217.140.110.172]:57834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbiAQMpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:45:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F123101E;
        Mon, 17 Jan 2022 04:45:25 -0800 (PST)
Received: from e127744.arm.com (unknown [10.57.36.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20D453F73D;
        Mon, 17 Jan 2022 04:45:24 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com,
        leo.yan@linaro.org
Cc:     German Gomez <german.gomez@arm.com>
Subject: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register bit CX
Date:   Mon, 17 Jan 2022 12:44:31 +0000
Message-Id: <20220117124432.3119132-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117124432.3119132-1-german.gomez@arm.com>
References: <20220117124432.3119132-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm_spe_pmu driver will enable the CX bit of the PMSCR register in
order to add CONTEXT packets into the traces if the owner of the perf
event runs with capabilities CAP_PERFMON or CAP_SYS_ADMIN.

The value of the bit is computed in the arm_spe_event_to_pmscr function
[1], and the check for capabilities happens in [2] in the pmu init
callback. This suggests that the value of the CX bit should remain
consistent for the duration of the perf session.

However, the function arm_spe_event_to_pmscr may be called later during
the start callback [3] when the "current" process is not the owner of
the perf session, so the CX bit is currently not consistent. Consider
the following example:

  1. Run a process in the background with capability CAP_SYS_ADMIN in CPU0.

    $ taskset --cpu-list 0 sudo dd if=/dev/random of=/dev/null &
    [3] 3806

  2. Begin a perf session _without_ capabilities (we shouldn't see CONTEXT packets).

    $ perf record -e arm_spe_0// -C0 -- sleep 1
    $ perf report -D | grep CONTEXT
    .  0000000e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
    .  0000004e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
    .  0000008e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
    [...]

As can be seen, the traces begin showing CONTEXT packets when the pid is
0xedf (3807). This happens because the pmu start callback is run when
the current process is not the owner of the perf session, so the CX
register bit is set.

One way to fix this is by caching the value of the CX bit during the
initialization of the PMU event, so that it remains consistent for the
duration of the session.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n275
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n713
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n751

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d..8515bf85c 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -57,6 +57,7 @@ struct arm_spe_pmu {
 	u16					pmsver;
 	u16					min_period;
 	u16					counter_sz;
+	bool					pmscr_cx;
 
 #define SPE_PMU_FEAT_FILT_EVT			(1UL << 0)
 #define SPE_PMU_FEAT_FILT_TYP			(1UL << 1)
@@ -260,6 +261,7 @@ static const struct attribute_group *arm_spe_pmu_attr_groups[] = {
 static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
+	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 	u64 reg = 0;
 
 	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << SYS_PMSCR_EL1_TS_SHIFT;
@@ -272,7 +274,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 	if (!attr->exclude_kernel)
 		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
 
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && spe_pmu->pmscr_cx)
 		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
 
 	return reg;
@@ -709,10 +711,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
+	spe_pmu->pmscr_cx = perfmon_capable();
 	reg = arm_spe_event_to_pmscr(event);
 	if (!perfmon_capable() &&
 	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
-		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
 		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
 		return -EACCES;
 
-- 
2.25.1

