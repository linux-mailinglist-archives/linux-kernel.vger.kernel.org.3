Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F85A80BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiHaO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHaO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D6C992F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957746; x=1693493746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+GY+VHMpQ4tyKPMCOukgzehMzX4R6wiYIg29V61XK0=;
  b=VEQPCB4DcvGDmR26ZtRC2HTZj4tvUNsMkEq6znCwhD0eQ6y7QMxSor2l
   HSsVq3Fh5LnjM+dCKuTIJyUNV9/OB0uuzeKRV7/e0lYz9XsrrQlqy+CRm
   BVHnfcjJ402DZYPoCVyUU46elK41mz3NZ43dYbrfkNisNo0eH2bjgUOxT
   sL3LJnVjjKxhN5aSaincoElRkCk3I0RKWD6qd1Zz21T7Mg0CN6XLbP8r0
   GvmiN6pbEJJ7kGSK1HFzt4wkPwvIJRfhy/eiBiU2/d2jEVqfyxxXeCpDa
   C+LYe9SKKlcjX7VY4+kFsABHBXjqWc73PAm5dwJ6G/H1bMpGnS7ZBbYIS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296248193"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296248193"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614991680"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:55:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/6] perf/x86/intel/pebs: Fix PEBS timestamps overwritten
Date:   Wed, 31 Aug 2022 07:55:10 -0700
Message-Id: <20220831145514.190514-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831145514.190514-1-kan.liang@linux.intel.com>
References: <20220831145514.190514-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PEBS TSC-based timestamps do not appear correctly in the final
perf.data output file from perf record.

The data->time field setup by PEBS in the setup_pebs_fixed_sample_data()
is later overwritten by perf_events generic code in
perf_prepare_sample(). There is an ordering problem.

Set the sample flags when the data->time is updated by PEBS.
The data->time field will not be overwritten anymore.

Reported-by: Andreas Kogler <andreas.kogler.0x@gmail.com>
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6ce73b4ae2f3..3af24c4891fb 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1640,8 +1640,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * We can only do this for the default trace clock.
 	 */
 	if (x86_pmu.intel_cap.pebs_format >= 3 &&
-		event->attr.use_clockid == 0)
+		event->attr.use_clockid == 0) {
 		data->time = native_sched_clock_from_tsc(pebs->tsc);
+		data->sample_flags |= PERF_SAMPLE_TIME;
+	}
 
 	if (has_branch_stack(event))
 		data->br_stack = &cpuc->lbr_stack;
@@ -1702,8 +1704,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_sample_data_init(data, 0, event->hw.last_period);
 	data->period = event->hw.last_period;
 
-	if (event->attr.use_clockid == 0)
+	if (event->attr.use_clockid == 0) {
 		data->time = native_sched_clock_from_tsc(basic->tsc);
+		data->sample_flags |= PERF_SAMPLE_TIME;
+	}
 
 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
-- 
2.35.1

