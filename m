Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639A4497832
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiAXEcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:32:31 -0500
Received: from foss.arm.com ([217.140.110.172]:47222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241456AbiAXEcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:32:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAB0CED1;
        Sun, 23 Jan 2022 20:32:16 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E578B3F73B;
        Sun, 23 Jan 2022 20:32:12 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [RFC V1 06/11] arm64/perf: Drive BRBE from perf event states
Date:   Mon, 24 Jan 2022 10:00:48 +0530
Message-Id: <1642998653-21377-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branch stack sampling rides along the normal perf event and all the branch
records get captured during the PMU interrupt. This just changes perf event
handling on the arm64 platform to accommodate required BRBE operations that
will enable branch stack sampling support.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/perf_event.c |  6 +++++
 drivers/perf/arm_pmu.c         | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f6a47036b0b4..11c82c8f2eec 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -864,6 +864,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event)) {
+			cpu_pmu->brbe_read(cpuc, event);
+			data.br_stack = &cpuc->brbe_stack;
+			cpu_pmu->brbe_reset(cpuc);
+		}
+
 		/*
 		 * Perf event overflow will queue the processing of the event as
 		 * an irq_work which will be taken care of in the handling of
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 295cc7952d0e..0800c8858ed8 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -269,12 +269,22 @@ armpmu_stop(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 
 	/*
 	 * ARM pmu always has to update the counter, so ignore
 	 * PERF_EF_UPDATE, see comments in armpmu_start().
 	 */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
+		if (has_branch_stack(event)) {
+			WARN_ON_ONCE(!hw_events->brbe_users);
+			hw_events->brbe_users--;
+			if (!hw_events->brbe_users) {
+				hw_events->brbe_context = NULL;
+				armpmu->brbe_disable(hw_events);
+			}
+		}
+
 		armpmu->disable(event);
 		armpmu_event_update(event);
 		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
@@ -285,6 +295,7 @@ static void armpmu_start(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 
 	/*
 	 * ARM pmu always has to reprogram the period, so ignore
@@ -302,6 +313,14 @@ static void armpmu_start(struct perf_event *event, int flags)
 	 * happened since disabling.
 	 */
 	armpmu_event_set_period(event);
+	if (has_branch_stack(event)) {
+		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
+			armpmu->brbe_reset(hw_events);
+			hw_events->brbe_context = event->ctx;
+		}
+		armpmu->brbe_enable(hw_events);
+		hw_events->brbe_users++;
+	}
 	armpmu->enable(event);
 }
 
@@ -347,6 +366,10 @@ armpmu_add(struct perf_event *event, int flags)
 	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (has_branch_stack(event))
+		armpmu->brbe_filter(hw_events, event);
+
 	if (flags & PERF_EF_START)
 		armpmu_start(event, PERF_EF_RELOAD);
 
@@ -438,6 +461,7 @@ __hw_perf_event_init(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	int mapping;
 
 	hwc->flags = 0;
@@ -492,6 +516,9 @@ __hw_perf_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	if (has_branch_stack(event))
+		armpmu->brbe_filter(hw_events, event);
+
 	return 0;
 }
 
@@ -520,6 +547,18 @@ static int armpmu_event_init(struct perf_event *event)
 	return __hw_perf_event_init(event);
 }
 
+static void armpmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(ctx->pmu);
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
+
+	if (!hw_events->brbe_users)
+		return;
+
+	if (sched_in)
+		armpmu->brbe_reset(hw_events);
+}
+
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
@@ -877,6 +916,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
-- 
2.25.1

