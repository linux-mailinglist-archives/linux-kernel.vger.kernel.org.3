Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA11F4AFC09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiBISwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbiBISvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:51:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4382C03E931
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644432472; x=1675968472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J/7XQfjKt9d3myGcrh1l1pOHrCE5f9w0ySm6uM+4N84=;
  b=cI5eKVEev2IL6+LoXwEXtcUsxDEKX4lVLXnW52dVieQIN7qxvyaokjd1
   +P28x1GkMvgBhYT5K3wdwtZSQ3nGQHcfgfcUbw7xUsSuWcVH2qCPLMcEQ
   WN5heG+nsYTj+tlohonKTCYciI84tT3MemJ5zTsCaJ+gqRwYEGqfwRMXv
   ZhrAoPbwEN5VH/WoZych7Myk1WB3U7SwKbU09bWkIOSXtZem+Tn1zCEDw
   yV4wFNlZjFCycK1sB/kxGLwUylMjez1R3R2XxC//g7iu3ul9ySdE3QTt6
   9i39xTJYd4RZCzxR5/cjT+Pscka2fT8bwc7FN4XMxbf/TUiGQJwWuLvmy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232867310"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="232867310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="541245172"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 Feb 2022 10:47:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C02D107; Wed,  9 Feb 2022 20:48:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] perf/smmuv3: Don't cast parameter in bit operations
Date:   Wed,  9 Feb 2022 20:47:58 +0200
Message-Id: <20220209184758.56578-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in this particular case it would not be a (critical) issue,
the pattern itself is bad and error prone in case somebody blindly
copies to their code.

Don't cast parameter to unsigned long pointer in the bit operations.
Instead copy to a local variable on stack of a proper type and use.

Note, new compilers might warn on this line for potential outbound access.

Fixes: 7d839b4b9e00 ("perf/smmuv3: Add arm64 smmuv3 pmu driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index c49108a72865..00d4c45a8017 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -654,6 +654,7 @@ static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
 {
 	struct smmu_pmu *smmu_pmu = data;
+	DECLARE_BITMAP(ovs, BITS_PER_TYPE(u64));
 	u64 ovsr;
 	unsigned int idx;
 
@@ -663,7 +664,8 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
 
 	writeq(ovsr, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
 
-	for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters) {
+	bitmap_from_u64(ovs, ovsr);
+	for_each_set_bit(idx, ovs, smmu_pmu->num_counters) {
 		struct perf_event *event = smmu_pmu->events[idx];
 		struct hw_perf_event *hwc;
 
-- 
2.34.1

