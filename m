Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB858D523
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiHIIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiHIIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:07:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15421E11
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660032447; x=1691568447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/B7Zqzq1Dw5/FKXwWDsIYdASZVFV/pT3d93M+DMx6yg=;
  b=T7p/ElX1b3s3htygq/yCGmPfgnya6IFnNqttp2+kO4Anz3zE3Xx8W+Xh
   44OieTIBuXsTqSF2whg2Nfab/u+2eCc3uB9EnW0ybbQa4gJRgT3CerbtP
   kv3p7iZrOEutw/4mrTxOZg3+0n0v5A+fwQDhZblNB6/kmjowbFywlvVjp
   v7+KbCqCNqcwn2h/r7/00A+qx6wE5K48BrSAhhFdQX/3FFVtPfkbZlwDk
   QOAGxfsCNSiTL5TVTn2HCyVxFla8MjaYPXv0HvzYjYX8ou/AESOhusEra
   cMMK0BXqmkmJW5DM4eyHPZmYQuH2Hs5W7HzkSPoqHGmAYSkHTcg35IXT4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289537563"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="289537563"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:07:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="633242875"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.48.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:07:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] perf tools: Do not pass NULL to parse_events()
Date:   Tue,  9 Aug 2022 11:07:02 +0300
Message-Id: <20220809080702.6921-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809080702.6921-1-adrian.hunter@intel.com>
References: <20220809080702.6921-1-adrian.hunter@intel.com>
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

Many cases do not use the extra error information provided by
parse_events and instead pass NULL as the struct parse_events_error
pointer. Add a wrapper for those cases so that the pointer is never
NULL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/arm/util/cs-etm.c       |  2 +-
 tools/perf/arch/arm64/util/arm-spe.c    |  2 +-
 tools/perf/arch/x86/tests/intel-cqm.c   |  2 +-
 tools/perf/arch/x86/util/intel-bts.c    |  2 +-
 tools/perf/arch/x86/util/intel-pt.c     |  2 +-
 tools/perf/arch/x86/util/iostat.c       |  2 +-
 tools/perf/arch/x86/util/topdown.c      |  2 +-
 tools/perf/tests/code-reading.c         |  2 +-
 tools/perf/tests/event-times.c          |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c |  4 ++--
 tools/perf/tests/hists_cumulate.c       |  2 +-
 tools/perf/tests/hists_filter.c         |  4 ++--
 tools/perf/tests/hists_link.c           |  4 ++--
 tools/perf/tests/hists_output.c         |  2 +-
 tools/perf/tests/keep-tracking.c        |  4 ++--
 tools/perf/tests/perf-time-to-tsc.c     |  2 +-
 tools/perf/tests/switch-tracking.c      | 12 ++++++------
 tools/perf/util/bpf-loader.c            |  2 +-
 tools/perf/util/parse-events.c          | 18 ++++++++++++------
 tools/perf/util/parse-events.h          |  4 ++++
 tools/perf/util/perf_api_probe.c        |  2 +-
 tools/perf/util/record.c                |  2 +-
 22 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 1b54638d53b0..a346d5f3dafa 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -438,7 +438,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (opts->full_auxtrace) {
 		struct evsel *tracking_evsel;
 
-		err = parse_events(evlist, "dummy:u", NULL);
+		err = parse_event(evlist, "dummy:u");
 		if (err)
 			goto out;
 
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 6f4db2ac5420..d4c234076541 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -257,7 +257,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		evsel__set_sample_bit(arm_spe_evsel, PHYS_ADDR);
 
 	/* Add dummy event to keep tracking */
-	err = parse_events(evlist, "dummy:u", NULL);
+	err = parse_event(evlist, "dummy:u");
 	if (err)
 		return err;
 
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index cb5b2c6c3b3b..360a082fc928 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -56,7 +56,7 @@ int test__intel_cqm_count_nmi_context(struct test_suite *test __maybe_unused, in
 		return TEST_FAIL;
 	}
 
-	ret = parse_events(evlist, "intel_cqm/llc_occupancy/", NULL);
+	ret = parse_event(evlist, "intel_cqm/llc_occupancy/");
 	if (ret) {
 		pr_debug("parse_events failed, is \"intel_cqm/llc_occupancy/\" available?\n");
 		err = TEST_SKIP;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index bcccfbade5c6..439c2956f3e7 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -233,7 +233,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		struct evsel *tracking_evsel;
 		int err;
 
-		err = parse_events(evlist, "dummy:u", NULL);
+		err = parse_event(evlist, "dummy:u");
 		if (err)
 			return err;
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 06c2cdfd8f2f..13933020a79e 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -426,7 +426,7 @@ static int intel_pt_track_switches(struct evlist *evlist)
 	if (!evlist__can_select_event(evlist, sched_switch))
 		return -EPERM;
 
-	err = parse_events(evlist, sched_switch, NULL);
+	err = parse_event(evlist, sched_switch);
 	if (err) {
 		pr_debug2("%s: failed to parse %s, error %d\n",
 			  __func__, sched_switch, err);
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 792cd75ade33..404de795ec0b 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -316,7 +316,7 @@ static int iostat_event_group(struct evlist *evl,
 		sprintf(iostat_cmd, iostat_cmd_template,
 			list->rps[idx]->pmu_idx, list->rps[idx]->pmu_idx,
 			list->rps[idx]->pmu_idx, list->rps[idx]->pmu_idx);
-		ret = parse_events(evl, iostat_cmd, NULL);
+		ret = parse_event(evl, iostat_cmd);
 		if (ret)
 			goto err;
 	}
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 67c524324125..54810f9acd6f 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -122,5 +122,5 @@ int topdown_parse_events(struct evlist *evlist)
 			topdown_events = TOPDOWN_L1_EVENTS;
 	}
 
-	return parse_events(evlist, topdown_events, NULL);
+	return parse_event(evlist, topdown_events);
 }
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 5610767b407f..95feb6ef34a0 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -638,7 +638,7 @@ static int do_test_code_reading(bool try_kcore)
 
 		str = do_determine_event(excl_kernel);
 		pr_debug("Parsing event '%s'\n", str);
-		ret = parse_events(evlist, str, NULL);
+		ret = parse_event(evlist, str);
 		if (ret < 0) {
 			pr_debug("parse_events failed\n");
 			goto out_put;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 7606eb3df92f..e155f0e0e04d 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -174,7 +174,7 @@ static int test_times(int (attach)(struct evlist *),
 		goto out_err;
 	}
 
-	err = parse_events(evlist, "cpu-clock:u", NULL);
+	err = parse_event(evlist, "cpu-clock:u");
 	if (err) {
 		pr_debug("failed to parse event cpu-clock:u\n");
 		goto out_err;
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 9d3c64974f77..e94fed901992 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -27,7 +27,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				err = parse_events(evlist, name, NULL);
+				err = parse_event(evlist, name);
 				if (err)
 					ret = err;
 			}
@@ -75,7 +75,7 @@ static int __perf_evsel__name_array_test(const char *const names[], int nr_names
                 return -ENOMEM;
 
 	for (i = 0; i < nr_names; ++i) {
-		err = parse_events(evlist, names[i], NULL);
+		err = parse_event(evlist, names[i]);
 		if (err) {
 			pr_debug("failed to parse event '%s', err %d\n",
 				 names[i], err);
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 17f4fcd6bdce..b42d37ff2399 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -706,7 +706,7 @@ static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subt
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_event(evlist, "cpu-clock");
 	if (err)
 		goto out;
 	err = TEST_FAIL;
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 08cbeb9e39ae..8e1ceeb9b7b6 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -111,10 +111,10 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_event(evlist, "cpu-clock");
 	if (err)
 		goto out;
-	err = parse_events(evlist, "task-clock", NULL);
+	err = parse_event(evlist, "task-clock");
 	if (err)
 		goto out;
 	err = TEST_FAIL;
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index c575e13a850d..14b2ff808b5e 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -276,10 +276,10 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 	if (evlist == NULL)
                 return -ENOMEM;
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_event(evlist, "cpu-clock");
 	if (err)
 		goto out;
-	err = parse_events(evlist, "task-clock", NULL);
+	err = parse_event(evlist, "task-clock");
 	if (err)
 		goto out;
 
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 0bde4a768c15..62b0093253e3 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -593,7 +593,7 @@ static int test__hists_output(struct test_suite *test __maybe_unused, int subtes
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_event(evlist, "cpu-clock");
 	if (err)
 		goto out;
 	err = TEST_FAIL;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index dd2067312452..8f4f9b632e1e 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -89,8 +89,8 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	CHECK__(parse_events(evlist, "dummy:u", NULL));
-	CHECK__(parse_events(evlist, "cycles:u", NULL));
+	CHECK__(parse_event(evlist, "dummy:u"));
+	CHECK__(parse_event(evlist, "cycles:u"));
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 7c7d20fc503a..26ce30a35191 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -100,7 +100,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	CHECK__(parse_events(evlist, "cycles:u", NULL));
+	CHECK__(parse_event(evlist, "cycles:u"));
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 6f53bee33f7c..2d46af9ef935 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -364,7 +364,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	/* First event */
-	err = parse_events(evlist, "cpu-clock:u", NULL);
+	err = parse_event(evlist, "cpu-clock:u");
 	if (err) {
 		pr_debug("Failed to parse event dummy:u\n");
 		goto out_err;
@@ -375,14 +375,14 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	/* Second event */
 	if (perf_pmu__has_hybrid()) {
 		cycles = "cpu_core/cycles/u";
-		err = parse_events(evlist, cycles, NULL);
+		err = parse_event(evlist, cycles);
 		if (err) {
 			cycles = "cpu_atom/cycles/u";
 			pr_debug("Trying %s\n", cycles);
-			err = parse_events(evlist, cycles, NULL);
+			err = parse_event(evlist, cycles);
 		}
 	} else {
-		err = parse_events(evlist, cycles, NULL);
+		err = parse_event(evlist, cycles);
 	}
 	if (err) {
 		pr_debug("Failed to parse event %s\n", cycles);
@@ -398,7 +398,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 		goto out;
 	}
 
-	err = parse_events(evlist, sched_switch, NULL);
+	err = parse_event(evlist, sched_switch);
 	if (err) {
 		pr_debug("Failed to parse event %s\n", sched_switch);
 		goto out_err;
@@ -428,7 +428,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	evsel__set_sample_bit(cycles_evsel, TIME);
 
 	/* Fourth event */
-	err = parse_events(evlist, "dummy:u", NULL);
+	err = parse_event(evlist, "dummy:u");
 	if (err) {
 		pr_debug("Failed to parse event dummy:u\n");
 		goto out_err;
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index d2c9b09ddb48..e2052f4fed33 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1879,7 +1879,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 		if (asprintf(&event_definition, "bpf-output/no-inherit=1,name=%s/", name) < 0)
 			return ERR_PTR(-ENOMEM);
 
-		err = parse_events(evlist, event_definition, NULL);
+		err = parse_event(evlist, event_definition);
 		free(event_definition);
 
 		if (err) {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dfc7d7a0ec4e..f05e15acd33f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2240,6 +2240,17 @@ int __parse_events(struct evlist *evlist, const char *str,
 	return ret;
 }
 
+int parse_event(struct evlist *evlist, const char *str)
+{
+	struct parse_events_error err;
+	int ret;
+
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	parse_events_error__exit(&err);
+	return ret;
+}
+
 void parse_events_error__init(struct parse_events_error *err)
 {
 	bzero(err, sizeof(*err));
@@ -2256,13 +2267,8 @@ void parse_events_error__exit(struct parse_events_error *err)
 void parse_events_error__handle(struct parse_events_error *err, int idx,
 				char *str, char *help)
 {
-	if (WARN(!str, "WARNING: failed to provide error string\n"))
-		goto out_free;
-	if (!err) {
-		/* Assume caller does not want message printed */
-		pr_debug("event syntax error: %s\n", str);
+	if (WARN(!str || !err, "WARNING: failed to provide error string or struct\n"))
 		goto out_free;
-	}
 	switch (err->num_errors) {
 	case 0:
 		err->idx = idx;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index ba9fa3ddaf6e..7e6a601d9cd0 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -24,15 +24,19 @@ const char *event_type(int type);
 
 int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
+__attribute__((nonnull(1, 2, 3)))
 int __parse_events(struct evlist *evlist, const char *str, struct parse_events_error *error,
 		   struct perf_pmu *fake_pmu);
 
+__attribute__((nonnull))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
 	return __parse_events(evlist, str, err, NULL);
 }
 
+int parse_event(struct evlist *evlist, const char *str);
+
 int parse_events_terms(struct list_head *terms, const char *str);
 int parse_filter(const struct option *opt, const char *str, int unset);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index c28dd50bd571..e1e2d701599c 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -23,7 +23,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 	if (!evlist)
 		return -ENOMEM;
 
-	if (parse_events(evlist, str, NULL))
+	if (parse_event(evlist, str))
 		goto out_delete;
 
 	evsel = evlist__first(evlist);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index b529636ab3ea..7b58f6c7c69d 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -238,7 +238,7 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
 	if (!temp_evlist)
 		return false;
 
-	err = parse_events(temp_evlist, str, NULL);
+	err = parse_event(temp_evlist, str);
 	if (err)
 		goto out_delete;
 
-- 
2.25.1

