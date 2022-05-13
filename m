Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F45265CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354285AbiEMPQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbiEMPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:16:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD415A0AE;
        Fri, 13 May 2022 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652454963; x=1683990963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=24oKuYXEcnWrp4B5Kh3zaIWR0+FTuDd0VrQkGRVBuc8=;
  b=Zli9crThxZTE1+om0dNbqy2cGf66DQff5k/c/2j647Jf1pHXO4BwvGFW
   kNpTojiraQgyntFjeikTfQyaBl4HoBGfuh9gPUTF5hInX2Mum++f2aWEH
   Q/Rb94QmCT3bTZKnb9cv7Y+2YF2Up+bqGx1MlTV7WTR4tvavY8TvLhU5f
   dSTg4ytSTJwdPcOw2f+v1wzJzzK4WKSZSalTN/dOMLZYn06SYOj/XAczC
   Max2/PN89n8cxD9SPqA6X0E5XGoJhpUFGULg77qn62/ZYDe+HFMqhjS/q
   q/TvwPSVeu1vLCHSLtlX5XiQV+84kbDHYymvks4xZ+thMSWpCZDc5dBqd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="269160146"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269160146"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698518050"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 08:16:02 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf evsel: Fixes topdown events in a weak group for the hybrid platform
Date:   Fri, 13 May 2022 08:15:51 -0700
Message-Id: <20220513151554.1054452-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513151554.1054452-1-kan.liang@linux.intel.com>
References: <20220513151554.1054452-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patch ("perf evlist: Keep topdown counters in weak group") fixes the
perf metrics topdown event issue when the topdown events are in a weak
group on a non-hybrid platform. However, it doesn't work for the hybrid
platform.

$./perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1

 Performance counter stats for 'system wide':

       751,765,068      cpu_core/slots/                                               (84.07%)
   <not supported>      cpu_core/topdown-bad-spec/
   <not supported>      cpu_core/topdown-be-bound/
   <not supported>      cpu_core/topdown-fe-bound/
   <not supported>      cpu_core/topdown-retiring/
        12,398,197      cpu_core/branch-instructions/                                     (84.07%)
         1,054,218      cpu_core/branch-misses/                                       (84.24%)
       539,764,637      cpu_core/bus-cycles/                                          (84.64%)
            14,683      cpu_core/cache-misses/                                        (84.87%)
         7,277,809      cpu_core/cache-references/                                     (77.30%)
       222,299,439      cpu_core/cpu-cycles/                                          (77.28%)
        63,661,714      cpu_core/instructions/                                        (84.85%)
                 0      cpu_core/mem-loads/                                           (77.29%)
        12,271,725      cpu_core/mem-stores/                                          (77.30%)
       542,241,102      cpu_core/ref-cycles/                                          (84.85%)
             8,854      cpu_core/cache-misses/                                        (76.71%)
         7,179,013      cpu_core/cache-references/                                     (76.31%)

       1.003245250 seconds time elapsed

A hybrid platform has a different PMU name for the core PMUs, while
the current perf hard code the PMU name "cpu".

The evsel->pmu_name can be used to replace the "cpu" to fix the issue.
For a hybrid platform, the pmu_name must be non-NULL. Because there are
at least two core PMUs. The PMU has to be specified.
For a non-hybrid platform, the pmu_name may be NULL. Because there is
only one core PMU, "cpu". For a NULL pmu_name, we can safely assume that
it is a "cpu" PMU.

With the patch,

$perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1

 Performance counter stats for 'system wide':

       766,620,266      cpu_core/slots/                                               (84.06%)
        73,172,129      cpu_core/topdown-bad-spec/ #      9.5% bad speculation         (84.06%)
       193,443,341      cpu_core/topdown-be-bound/ #     25.0% backend bound           (84.06%)
       403,940,929      cpu_core/topdown-fe-bound/ #     52.3% frontend bound          (84.06%)
       102,070,237      cpu_core/topdown-retiring/ #     13.2% retiring                (84.06%)
        12,364,429      cpu_core/branch-instructions/                                     (84.03%)
         1,080,124      cpu_core/branch-misses/                                       (84.24%)
       564,120,383      cpu_core/bus-cycles/                                          (84.65%)
            36,979      cpu_core/cache-misses/                                        (84.86%)
         7,298,094      cpu_core/cache-references/                                     (77.30%)
       227,174,372      cpu_core/cpu-cycles/                                          (77.31%)
        63,886,523      cpu_core/instructions/                                        (84.87%)
                 0      cpu_core/mem-loads/                                           (77.31%)
        12,208,782      cpu_core/mem-stores/                                          (77.31%)
       566,409,738      cpu_core/ref-cycles/                                          (84.87%)
            23,118      cpu_core/cache-misses/                                        (76.71%)
         7,212,602      cpu_core/cache-references/                                     (76.29%)

       1.003228667 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/evsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 00cb4466b4ca..24510bcb4bf4 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -33,8 +33,9 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 {
-	if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
-	    !pmu_have_event("cpu", "slots"))
+	const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
+
+	if (!pmu_have_event(pmu_name, "slots"))
 		return false;
 
 	return evsel->name &&
-- 
2.35.1

