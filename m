Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1A5A9834
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiIANM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiIANML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8298617049
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662037805; x=1693573805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sbi6khNsjjvSS4caSIbQyKIV39nuU2klly/xGl3rjT8=;
  b=QzVPrnf0A4xUqdXjv4tvAGcXWnApZGcBKS6NcF6t3sAGdNB5kVXk4hVC
   RVlUHGFuvYcvjHDIAtzj2EgeGUqwzPZpqiU+sB6l0XQXHnDN/cj+oVFzc
   2gYxcxqQoiF5JayAIqPq5ksRatbpB84n5zaQy3myYNX1ae/NZENiDa2wl
   MO3SSMji3J7h/BQsAaa7jSdi50olxHChEygI1HcPX2efoXGNw4QN8APiJ
   Yc517HVfp8Y/78Y3JXkxYy/JSKXMZkKx9k8Os2RsJGp8YHUJelJzKYe3N
   wEbSUU8LofEKbxnr3FV8FFXEBJ8XK3gxfWEFNNy/uARY0M7qY7+IH/3ng
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321858087"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321858087"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612485335"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 06:10:02 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/6] perf/x86/intel/pebs: Fix PEBS timestamps overwritten
Date:   Thu,  1 Sep 2022 06:09:55 -0700
Message-Id: <20220901130959.1285717-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901130959.1285717-1-kan.liang@linux.intel.com>
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index de1f55d51784..01cbe26225c2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1643,8 +1643,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
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
@@ -1705,8 +1707,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
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

