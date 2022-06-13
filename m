Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2C85483F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbiFMKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiFMKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:02:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6628226CF;
        Mon, 13 Jun 2022 03:02:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE1C91042;
        Mon, 13 Jun 2022 03:02:29 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.38.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 421013F66F;
        Mon, 13 Jun 2022 03:02:22 -0700 (PDT)
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
Subject: [PATCH 8/8] arm64/perf: Enable branch stack sampling
Date:   Mon, 13 Jun 2022 15:31:19 +0530
Message-Id: <20220613100119.684673-9-anshuman.khandual@arm.com>
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
 drivers/perf/arm_pmu.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 52a903d26702..efbc6db42b35 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -537,9 +537,35 @@ static int armpmu_event_init(struct perf_event *event)
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
+		if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_KERNEL) {
+			if (!perfmon_capable()) {
+				pr_warn_once("does not have permission for kernel branch filter\n");
+				return -EPERM;
+			}
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

