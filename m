Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D5C51C586
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382223AbiEERBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382290AbiEERBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF65D1BB
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769843; x=1683305843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eX2ACS3WuhZJh3E7Z+BEmTb/GkO8KXR51sXFaeopJsU=;
  b=BR8dbMhDur472iAJTbTqTX2XJAoSRYY1zKgE/c1AJpBZh4OY3NgIb09s
   l9Odi6daCkB4Sv2aMrx7+Osd77VDsWmZqHm5dced8lUI0bMdCbxd7enev
   SpBXFId4FnDJgLyNvkqv/gJbIM6B779AaKtrc9xR6iBDRbMcJUm14HsrO
   rllgLhuYccCxriSf1q2RWlF5GnxypfDWOEZxU+pW0LoL2OdxXHHOqlAe2
   iHDaewYpLXvKzMIiKPID/OPBEiDzb8LQQ4An+jBgnI/zgalbmLEH1kphb
   OEV+WMS3pIT/B1ZmG6t5xl7MQ1rdaXIfMZ2wPtOKrotta0qMqI8YPrkaB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717937"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032831"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 09/23] perf auxtrace: Record whether an auxtrace mmap is needed
Date:   Thu,  5 May 2022 19:56:25 +0300
Message-Id: <20220505165639.361733-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505165639.361733-1-adrian.hunter@intel.com>
References: <20220505165639.361733-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag needs_auxtrace_mmap to record whether an auxtrace mmap is
needed, in preparation for correctly determining whether or not an
auxtrace mmap is needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 1 +
 tools/perf/arch/arm64/util/arm-spe.c | 1 +
 tools/perf/arch/s390/util/auxtrace.c | 1 +
 tools/perf/arch/x86/util/intel-bts.c | 1 +
 tools/perf/arch/x86/util/intel-pt.c  | 1 +
 tools/perf/util/evsel.h              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 11c71aa219f7..1b54638d53b0 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -319,6 +319,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
+			evsel->needs_auxtrace_mmap = true;
 			cs_etm_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index e8b577d33e53..6f4db2ac5420 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -160,6 +160,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = arm_spe_pmu->default_config->sample_period;
+			evsel->needs_auxtrace_mmap = true;
 			arm_spe_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 0db5c58c98e8..5068baa3e092 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -98,6 +98,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	evlist__for_each_entry(evlist, pos) {
 		if (pos->core.attr.config == PERF_EVENT_CPUM_SF_DIAG) {
 			diagnose = 1;
+			pos->needs_auxtrace_mmap = true;
 			break;
 		}
 	}
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d68a0f48e41e..bcccfbade5c6 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -129,6 +129,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
+			evsel->needs_auxtrace_mmap = true;
 			intel_bts_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 38ec2666ec12..2eaac4638aab 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -649,6 +649,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
 			evsel->no_aux_samples = true;
+			evsel->needs_auxtrace_mmap = true;
 			intel_pt_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 45d674812239..544fbed98df1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -124,6 +124,7 @@ struct evsel {
 	bool			merged_stat;
 	bool			reset_group;
 	bool			errored;
+	bool			needs_auxtrace_mmap;
 	struct hashmap		*per_pkg_mask;
 	int			err;
 	struct {
-- 
2.25.1

