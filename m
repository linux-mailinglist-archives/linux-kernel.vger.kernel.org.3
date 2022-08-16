Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E49595E32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiHPOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiHPOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:18:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6364D58B4B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:18:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E4D7113E;
        Tue, 16 Aug 2022 07:18:23 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.44.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C87813F66F;
        Tue, 16 Aug 2022 07:18:21 -0700 (PDT)
Date:   Tue, 16 Aug 2022 15:18:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Newman <peternewman@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf/arm: adjust hwevents mappings on boot
Message-ID: <YvunKCJHSXKz/kZB@FVFF77S0Q05N>
References: <20220816130221.885920-1-peternewman@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816130221.885920-1-peternewman@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:02:21PM +0200, Peter Newman wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> The mapping of perf_events generic hardware events to actual PMU events on
> ARM PMUv3 may not always be correct. This is in particular true for the
> PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
> architected event, it may not always be available. This can be seen with a
> simple:
> 
> $ perf stat -e branches sleep 0
>  Performance counter stats for 'sleep 0':
> 
>    <not supported>      branches
> 
>        0.001401081 seconds time elapsed
> 
> Yet the hardware does have an event that could be used for branches.  This
> patch fixes the problem by dynamically validating the generic hardware
> events against the supported architected events. If a mapping is wrong it
> can be replaced it with another. This is done for the event above at boot
> time.
> 
> And with that:
> 
> $ perf stat -e branches sleep 0
> 
>  Performance counter stats for 'sleep 0':
> 
>            166,739      branches
> 
>        0.000832163 seconds time elapsed
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Co-developed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
> 
> v2: https://lore.kernel.org/lkml/20220324181458.3216262-1-eranian@google.com/
> 
> since v2, removed prints per Will's suggestion
> 
>  arch/arm64/kernel/perf_event.c | 36 +++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1e6138..945c31e3f3e3 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -39,7 +39,7 @@
>   * be supported on any given implementation. Unsupported events will
>   * be disabled at run-time based on the PMCEID registers.

>   */
> -static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
> +static unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
>  	PERF_MAP_ALL_UNSUPPORTED,
>  	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
>  	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,

On big.LITTLE systems this is array is shared by multiple PMUs, so this cannot
be altered based on a single PMU.

Rather than applying a fixup, could we special-case this at mapping time?

Does the following work for you?

Thanks
Mark.

---->8----
From 6cf78ec72194296e8d0c87572b81f2b02a097918 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 16 Aug 2022 15:16:23 +0100
Subject: [PATCH] arm64: pmuv3: dynamically map
 PERF_COUNT_HW_BRANCH_INSTRUCTIONS

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/perf_event.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e61380..0435adee5cab8 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -45,7 +45,6 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
@@ -1050,6 +1049,28 @@ static void armv8pmu_reset(void *info)
 	armv8pmu_pmcr_write(pmcr);
 }
 
+static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
+				      struct perf_event *event)
+{
+	if (event->attr.type == PERF_TYPE_HARDWARE &&
+	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
+
+		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
+			     armpmu->pmceid_bitmap))
+			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
+
+		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
+			     armpmu->pmceid_bitmap))
+			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
+
+		return HW_OP_UNSUPPORTED;
+	}
+
+	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				&armv8_pmuv3_perf_cache_map,
+				ARMV8_PMU_EVTYPE_EVENT);
+}
+
 static int __armv8_pmuv3_map_event(struct perf_event *event,
 				   const unsigned (*extra_event_map)
 						  [PERF_COUNT_HW_MAX],
@@ -1061,9 +1082,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	int hw_event_id;
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 
-	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
-				       &armv8_pmuv3_perf_cache_map,
-				       ARMV8_PMU_EVTYPE_EVENT);
+	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
 
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
-- 
2.30.2

