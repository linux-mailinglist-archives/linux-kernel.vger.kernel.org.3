Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321C349782F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiAXEcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:32:11 -0500
Received: from foss.arm.com ([217.140.110.172]:47166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241436AbiAXEb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:31:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF41ED1;
        Sun, 23 Jan 2022 20:31:57 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 925E23F73B;
        Sun, 23 Jan 2022 20:31:53 -0800 (PST)
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
Subject: [RFC V1 03/11] arm64/perf: Update struct arm_pmu for BRBE
Date:   Mon, 24 Jan 2022 10:00:45 +0530
Message-Id: <1642998653-21377-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates struct arm_pmu to include all required helpers that will drive
BRBE functionality for a given PMU implementation. These are the following.

- brbe_filter	: Convert perf event filters into BRBE HW filters
- brbe_probe	: Probe BRBE HW and capture its attributes
- brbe_enable	: Enable BRBE HW with a given config
- brbe_disable	: Disable BRBE HW
- brbe_read	: Read BRBE buffer for captured branch records
- brbe_reset	: Reset BRBE buffer
- brbe_supported: Whether BRBE is supported or not

A BRBE driver implementation needs to provide these functionalities.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h   |  7 +++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cab678ed6618..f6a47036b0b4 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1015,6 +1015,35 @@ static int armv8pmu_filter_match(struct perf_event *event)
 	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
 }
 
+static void armv8pmu_brbe_filter(struct pmu_hw_events *hw_event, struct perf_event *event)
+{
+}
+
+static void armv8pmu_brbe_enable(struct pmu_hw_events *hw_event)
+{
+}
+
+static void armv8pmu_brbe_disable(struct pmu_hw_events *hw_event)
+{
+}
+
+static void armv8pmu_brbe_read(struct pmu_hw_events *hw_event, struct perf_event *event)
+{
+}
+
+static void armv8pmu_brbe_probe(struct pmu_hw_events *hw_event)
+{
+}
+
+static void armv8pmu_brbe_reset(struct pmu_hw_events *hw_event)
+{
+}
+
+static bool armv8pmu_brbe_supported(struct perf_event *event)
+{
+	return false;
+}
+
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
@@ -1247,6 +1276,13 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
 
+	cpu_pmu->brbe_filter		= armv8pmu_brbe_filter;
+	cpu_pmu->brbe_enable		= armv8pmu_brbe_enable;
+	cpu_pmu->brbe_disable		= armv8pmu_brbe_disable;
+	cpu_pmu->brbe_read		= armv8pmu_brbe_read;
+	cpu_pmu->brbe_probe		= armv8pmu_brbe_probe;
+	cpu_pmu->brbe_reset		= armv8pmu_brbe_reset;
+	cpu_pmu->brbe_supported		= armv8pmu_brbe_supported;
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 2512e2f9cd4e..c0dd0d6c5883 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -98,6 +98,13 @@ struct arm_pmu {
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
 	int		(*filter_match)(struct perf_event *event);
+	void		(*brbe_filter)(struct pmu_hw_events *hw_events, struct perf_event *event);
+	void		(*brbe_probe)(struct pmu_hw_events *hw_events);
+	void		(*brbe_enable)(struct pmu_hw_events *hw_events);
+	void		(*brbe_disable)(struct pmu_hw_events *hw_events);
+	void		(*brbe_read)(struct pmu_hw_events *hw_events, struct perf_event *event);
+	void		(*brbe_reset)(struct pmu_hw_events *hw_events);
+	bool		(*brbe_supported)(struct perf_event *event);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
-- 
2.25.1

