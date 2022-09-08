Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EA45B13D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiIHFLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiIHFLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:11:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22E34B6D6D;
        Wed,  7 Sep 2022 22:11:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20835106F;
        Wed,  7 Sep 2022 22:11:18 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08AF23F7B4;
        Wed,  7 Sep 2022 22:11:07 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V2 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Date:   Thu,  8 Sep 2022 10:40:42 +0530
Message-Id: <20220908051046.465307-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908051046.465307-1-anshuman.khandual@arm.com>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
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

A single perf event instance BRBE related contexts and data will be tracked
in struct pmu_hw_events. Hence update the structure to accommodate required
details related to BRBE.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf/arm_pmu.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 3d427ac0ca45..18e519e4e658 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -43,6 +43,11 @@
 	},								\
 }
 
+/*
+ * Maximum branch records in BRBE
+ */
+#define BRBE_MAX_ENTRIES 64
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
 	/*
@@ -69,6 +74,23 @@ struct pmu_hw_events {
 	struct arm_pmu		*percpu_pmu;
 
 	int irq;
+
+	/* Detected BRBE attributes */
+	bool				v1p1;
+	int				brbe_cc;
+	int				brbe_nr;
+
+	/* Evaluated BRBE configuration */
+	u64				brbfcr;
+	u64				brbcr;
+
+	/* Tracked BRBE context */
+	unsigned int			brbe_users;
+	void				*brbe_context;
+
+	/* Captured BRBE buffer - copied as is into perf_sample_data */
+	struct perf_branch_stack	brbe_stack;
+	struct perf_branch_entry	brbe_entries[BRBE_MAX_ENTRIES];
 };
 
 enum armpmu_attr_groups {
-- 
2.25.1

