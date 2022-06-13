Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3C54843B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiFMKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiFMKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:01:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A7421CFF0;
        Mon, 13 Jun 2022 03:01:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 557ABD6E;
        Mon, 13 Jun 2022 03:01:54 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.38.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 365B13F66F;
        Mon, 13 Jun 2022 03:01:47 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/8] arm64/perf: Update struct arm_pmu for BRBE
Date:   Mon, 13 Jun 2022 15:31:14 +0530
Message-Id: <20220613100119.684673-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613100119.684673-1-anshuman.khandual@arm.com>
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
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

Although BRBE is an armv8 speciifc HW feature, abstracting out its various
function callbacks at the struct arm_pmu level is preferred, as it cleaner
, easier to follow and maintain.

Besides some helpers i.e brbe_supported(), brbe_probe() and brbe_reset()
might not fit seamlessly, when tried to be embedded via existing arm_pmu
helpers in the armv8 implementation.

Updates the struct arm_pmu to include all required helpers that will drive
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
 include/linux/perf/arm_pmu.h   | 21 ++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e6138..e7013699171f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1025,6 +1025,35 @@ static int armv8pmu_filter_match(struct perf_event *event)
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
@@ -1257,6 +1286,13 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 
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
index 0407a38b470a..3d427ac0ca45 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -100,6 +100,27 @@ struct arm_pmu {
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
 	int		(*filter_match)(struct perf_event *event);
+
+	/* Convert perf event filters into BRBE HW filters */
+	void		(*brbe_filter)(struct pmu_hw_events *hw_events, struct perf_event *event);
+
+	/* Probe BRBE HW and capture its attributes */
+	void		(*brbe_probe)(struct pmu_hw_events *hw_events);
+
+	/* Enable BRBE HW with a given config */
+	void		(*brbe_enable)(struct pmu_hw_events *hw_events);
+
+	/* Disable BRBE HW */
+	void		(*brbe_disable)(struct pmu_hw_events *hw_events);
+
+	/* Process BRBE buffer for captured branch records */
+	void		(*brbe_read)(struct pmu_hw_events *hw_events, struct perf_event *event);
+
+	/* Reset BRBE buffer */
+	void		(*brbe_reset)(struct pmu_hw_events *hw_events);
+
+	/* Check whether BRBE is supported */
+	bool		(*brbe_supported)(struct perf_event *event);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
-- 
2.25.1

