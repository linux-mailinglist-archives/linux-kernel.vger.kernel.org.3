Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F15951D79B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391825AbiEFMam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391829AbiEFMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C95DA00
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839988; x=1683375988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8v35ff6wW1nUrp/QD1hjUv6/DgplSoXaM8FKX5EJVnk=;
  b=NzOAEwG2n4JjpmLJc4s3p3iFExvVIZPtvKp4lxXnfi5zY3HQEFdKBNTT
   qyKTks+7HoXRwAh4pD/rICc/Q+jBiIcF8FE2Wpq30YOqBLFrGSbs3e0Oq
   NIKIQOPX2UiARz+oK3pkIcjtBifveYN/oT9YbV1Fqt4OMKPyb0HBNbvbR
   1x/WjslANBtnJjdCm7HcZGXs91X1XwyuyIrZ/7ZBwmXbuHVYm79uvjL8W
   j0MHoLLPc8IVcrPrJdXaYVD0keG4TTBt9Jdi8g9vT8NL/I/Nh1amuZMX7
   35BEmOMAaxFtmWaxfA1Lm1MJ2l0NKRYcPZ2NZesQtWt0EWWtGV04GWrCA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045774"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045774"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440808"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/23] perf auxtrace: Record whether an auxtrace mmap is needed
Date:   Fri,  6 May 2022 15:25:47 +0300
Message-Id: <20220506122601.367589-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506122601.367589-1-adrian.hunter@intel.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Acked-by: Ian Rogers <irogers@google.com>
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

