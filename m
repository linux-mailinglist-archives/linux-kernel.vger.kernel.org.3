Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA9497831
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbiAXEcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:32:14 -0500
Received: from foss.arm.com ([217.140.110.172]:47200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241428AbiAXEcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:32:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FFE9ED1;
        Sun, 23 Jan 2022 20:32:12 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2346E3F73B;
        Sun, 23 Jan 2022 20:32:08 -0800 (PST)
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
Subject: [RFC V1 05/11] arm64/perf: Detect support for BRBE
Date:   Mon, 24 Jan 2022 10:00:47 +0530
Message-Id: <1642998653-21377-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU specific BRBE entries, cycle count, format support gets detected during
PMU init. This information gets saved in per-cpu struct pmu_hw_events which
later helps in operating BRBE during a perf event context.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu_platform.c | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 513de1f54e2d..800e4a6e8bc3 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -172,6 +172,36 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
 	return err;
 }
 
+static void arm_brbe_probe_cpu(void *info)
+{
+	struct pmu_hw_events *hw_events;
+	struct arm_pmu *armpmu = info;
+
+	/*
+	 * Return from here, if BRBE driver has not been
+	 * implemented for this PMU. This helps prevent
+	 * kernel crash later when brbe_probe() will be
+	 * called on the PMU.
+	 */
+	if (!armpmu->brbe_probe)
+		return;
+
+	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
+	armpmu->brbe_probe(hw_events);
+}
+
+static int armpmu_request_brbe(struct arm_pmu *armpmu)
+{
+	int cpu, err = 0;
+
+	for_each_cpu(cpu, &armpmu->supported_cpus) {
+		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);
+		if (err)
+			return err;
+	}
+	return err;
+}
+
 static void armpmu_free_irqs(struct arm_pmu *armpmu)
 {
 	int cpu;
@@ -229,6 +259,10 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	if (ret)
 		goto out_free_irqs;
 
+	ret = armpmu_request_brbe(pmu);
+	if (ret)
+		goto out_free_irqs;
+
 	ret = armpmu_register(pmu);
 	if (ret) {
 		dev_err(dev, "failed to register PMU devices!\n");
-- 
2.25.1

