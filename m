Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891B148DD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiAMRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:54:44 -0500
Received: from foss.arm.com ([217.140.110.172]:49226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237305AbiAMRyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:54:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756A2106F;
        Thu, 13 Jan 2022 09:54:43 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 698D73F766;
        Thu, 13 Jan 2022 09:54:42 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-eng@arm.com
Cc:     james.clark@arm.com, German Gomez <german.gomez@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf: arm_spe: make the PMSCR CX bit[3] consistent across the session
Date:   Thu, 13 Jan 2022 17:54:16 +0000
Message-Id: <20220113175417.5523-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113175417.5523-1-german.gomez@arm.com>
References: <20220113175417.5523-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM SPE driver will seenablet the CX bit in the PMSCR register if it
detects that the profiler (perf tool) has enough capabilities during the
initialization of the PMU event in the "arm_spe_pmu_event_init" callback:

  reg = arm_spe_event_to_pmscr(event);
  if (!perfmon_capable() &&
      (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
              BIT(SYS_PMSCR_EL1_CX_SHIFT) |
              BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
          return -EACCES;

This implies that the CX bit should remain consistent across the entire
duration of the session. However, the value of the bit is later being
changed (from 0 to 1 and vice versa) in the "arm_spe_pmu_start" callback

Consider this example:

  1. Run a process in the background with privileges in CPU0

    $ taskset --cpu-list 0 sudo dd if=/dev/random of=/dev/null &
    [3] 3806

  2. Begin a perf session without privileges (we shouldn't see CONTEXT packets)

    $ perf record -e arm_spe_0// -C0 -- sleep 1
    $ perf report -D | grep CONTEXT
    .  0000000e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
    .  0000004e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
    .  0000008e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
    [...]

One way to fix this is by caching the value of the CX bit during the
initialization of the PMU event, so that it remains consistent during
the session.

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

