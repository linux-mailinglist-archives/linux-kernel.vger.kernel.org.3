Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633B65288BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiEPPYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiEPPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:24:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D93981A;
        Mon, 16 May 2022 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652714685; x=1684250685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/+6zYJkMdhw9qD4LUaNt6Hef+u3nCvlP8VmMLrkqXA=;
  b=EIyI7Ns8CCaIxf6qnbR4oB0V3/b/iDE8qixw2gH4iY/danFP3W8x7vHe
   WcfkJ/Px0z4TXTU4qQmAfw8Se4//pOqJ7Lo6ZZ8ogldB6tX//JENm/3uT
   crcUu5K+yvraW2KqP488ndJCVm/yRKT7BjL8ELB2h5ESJF0iBiHTB00PE
   ZbFCRSiNeCqRYQiCJtm+gu06pcRQ8fJvDOfXA9NKUsVHJkz7r1A5ETHGZ
   0Cd1zpZShnkMoNrYGmw5udye+SmGnQlhgxrki9TVOQAWEJcDoQkQkirn1
   dv6097GH9AsgIkNjqjRQRyGTIisouv/wZqVU75YvlrF4IXKydwQqU8Y+r
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270561297"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270561297"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 08:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="741290201"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2022 08:24:43 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/4] perf evsel: Fixes topdown events in a weak group for the hybrid platform
Date:   Mon, 16 May 2022 08:24:33 -0700
Message-Id: <20220516152436.1104757-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516152436.1104757-1-kan.liang@linux.intel.com>
References: <20220516152436.1104757-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

In case other PMUs also define the "slots" event, checking the PMU type
as well.

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
 tools/perf/arch/x86/util/evsel.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 00cb4466b4ca..6eda5a491eda 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -31,10 +31,27 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
 	free(env.cpuid);
 }
 
+static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
+{
+	const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
+
+	/*
+	 * The PERF_TYPE_RAW type is the core PMU type.
+	 * The slots event is only available for the core PMU, which
+	 * supports the perf metrics feature.
+	 * Checking both the PERF_TYPE_RAW type and the slots event
+	 * should be good enough to detect the perf metrics feature.
+	 */
+	if ((evsel->core.attr.type == PERF_TYPE_RAW) &&
+	    pmu_have_event(pmu_name, "slots"))
+		return true;
+
+	return false;
+}
+
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 {
-	if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
-	    !pmu_have_event("cpu", "slots"))
+	if (!evsel__sys_has_perf_metrics(evsel))
 		return false;
 
 	return evsel->name &&
-- 
2.35.1

