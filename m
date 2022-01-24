Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB78497834
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiAXEcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:32:47 -0500
Received: from foss.arm.com ([217.140.110.172]:47256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241457AbiAXEcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:32:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C853ED1;
        Sun, 23 Jan 2022 20:32:36 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25A3A3F73B;
        Sun, 23 Jan 2022 20:32:27 -0800 (PST)
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
Subject: [RFC V1 08/11] arm64/perf: Enable branch stack sampling
Date:   Mon, 24 Jan 2022 10:00:50 +0530
Message-Id: <1642998653-21377-9-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the required pieces are already in place, just enable the perf
branch stack sampling support on arm64 platform, by removing the gate which
blocks it in armpmu_event_init().

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 0800c8858ed8..2117bf5d3232 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -537,9 +537,28 @@ static int armpmu_event_init(struct perf_event *event)
 		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
 		return -ENOENT;
 
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
-		return -EOPNOTSUPP;
+	if (has_branch_stack(event)) {
+		/*
+		 * BRBE support is absent. Select CONFIG_ARM_BRBE_PMU
+		 * in the config, before branch stack sampling events
+		 * can be requested.
+		 */
+		if (!IS_ENABLED(CONFIG_ARM_BRBE_PMU)) {
+			pr_warn_once("BRBE is disabled, select CONFIG_ARM_BRBE_PMU\n");
+			return -EOPNOTSUPP;
+		}
+
+		/*
+		 * Branch stack sampling event can not be supported in
+		 * case either the required driver itself is absent or
+		 * BRBE buffer, is not supported. Besides checking for
+		 * the callback prevents a crash in case it's absent.
+		 */
+		if (!armpmu->brbe_supported || !armpmu->brbe_supported(event)) {
+			pr_warn_once("BRBE is not supported\n");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	if (armpmu->map_event(event) == -ENOENT)
 		return -ENOENT;
-- 
2.25.1

