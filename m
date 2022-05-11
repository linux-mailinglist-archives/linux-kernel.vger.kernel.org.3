Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC895522CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbiEKHCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242469AbiEKHBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:01:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C17305B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so9948227b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rLCQIdDIo0hjvRjcVna27zMmwetjRkxV8oX5TRyw2qw=;
        b=MmpIllCb4cEgsGmk9jFaxVuPfuNP7dVZUMN6AowLxFrfOAUOuTpxMRaAM4dIiqfQJ+
         hF7Mg2kFS2aDrHuSKCxlqJd9SgU68/PDP3ps6Q24winnQoTP8AMQiFXB8uPEaCh3bdNu
         dgD8uo7/C1WU7d3oB82rakji2NeHpoDZLmxAAkrV9H7y/AaZORTo9LbOS8H7Ck+CtIxc
         BcMttJ/iVmDuowEqjcs464xcnZW9n0DVUxMnFcHcNZ940TICRy1VZhEGwet4jU+3YlgH
         NAh9HBQsN1aEFrsrAJZjDQaIrsBp5BESIEDP0mZWWgyfq62vC8H2OGs+FG1e4R/EjG/T
         70VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rLCQIdDIo0hjvRjcVna27zMmwetjRkxV8oX5TRyw2qw=;
        b=vHfPzde/1IcTTL7nsx/aYcjvK6qie3yHhHYleibLW07Aqr8gU3IHkHQ9/9Z3hpsp71
         EuahpKqrvFLsypt9LItcalO4+8kuydB8UdBUyUtwgs2g9Qw0fuEAGPtDHjQ0Tf/7YPO8
         qw/ZRYXkFE8RzvTYPHe2pT4p4/B32OVZvldDGH+yQsZSF0bJfRSxDrR9DwyOXbig1k0d
         j4Mrfa6jr9JUeIMf4Epw4umTyElwB0NG1ibEIkVdRlzaxBv/YjZdXh4pTVVFO00Aw4x6
         ODpLJVGAWHr7OobeATgkZ5hNEvL9EjOhimok/FZGpxKEqeHHs/eE2/GhcoQLu66n5x9Y
         x4Pg==
X-Gm-Message-State: AOAM531rHbcRqB4NGe1JGkatElm/6ZZGFIoE++QLBEXukNbwrez/gmAT
        a2mZgLYJEG2i3GFlOiCvML0fRW0u/tcf
X-Google-Smtp-Source: ABdhPJxdAUdl2TKac8QUPTEi0Tv90G7I07/SQAAXXHb0eqJQy5FdMT1rljNRxuHX+q7nsSy3s1YvPw4wYN4I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a81:1606:0:b0:2f7:d623:703 with SMTP id
 6-20020a811606000000b002f7d6230703mr22911108yww.501.1652252506406; Wed, 11
 May 2022 00:01:46 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:30 -0700
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
Message-Id: <20220511070133.710721-5-irogers@google.com>
Mime-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 4/7] perf jevents: Modify match field
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The match_field function looks for json values to append to the event
string. As the C code processes these in order the output order matches
that in the json dictionary. Python json readers read the entire
dictionary and lose the ordering. To make the python and C output
comparable makee the C code first read the extra fields then append them
to the event in an order not determined by their order in the file.

Modify the pmu-events test so that test expectations match the new
order.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c | 82 ++++++++++++++++++++-------------
 tools/perf/tests/pmu-events.c   | 24 +++++-----
 2 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e1f7c7afd435..cee61c4ed59e 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -207,21 +207,6 @@ static struct msrmap {
 	{ NULL, NULL }
 };
 
-static struct field {
-	const char *field;
-	const char *kernel;
-} fields[] = {
-	{ "UMask",	"umask=" },
-	{ "CounterMask", "cmask=" },
-	{ "Invert",	"inv=" },
-	{ "AnyThread",	"any=" },
-	{ "EdgeDetect",	"edge=" },
-	{ "SampleAfterValue", "period=" },
-	{ "FCMask",	"fc_mask=" },
-	{ "PortMask",	"ch_mask=" },
-	{ NULL, NULL }
-};
-
 static void cut_comma(char *map, jsmntok_t *newval)
 {
 	int i;
@@ -233,21 +218,6 @@ static void cut_comma(char *map, jsmntok_t *newval)
 	}
 }
 
-static int match_field(char *map, jsmntok_t *field, int nz,
-		       char **event, jsmntok_t *val)
-{
-	struct field *f;
-	jsmntok_t newval = *val;
-
-	for (f = fields; f->field; f++)
-		if (json_streq(map, field, f->field) && nz) {
-			cut_comma(map, &newval);
-			addfield(map, event, ",", f->kernel, &newval);
-			return 1;
-		}
-	return 0;
-}
-
 static struct msrmap *lookup_msr(char *map, jsmntok_t *val)
 {
 	jsmntok_t newval = *val;
@@ -581,6 +551,14 @@ static int json_events(const char *fn,
 		jsmntok_t *precise = NULL;
 		jsmntok_t *obj = tok++;
 		bool configcode_present = false;
+		char *umask = NULL;
+		char *cmask = NULL;
+		char *inv = NULL;
+		char *any = NULL;
+		char *edge = NULL;
+		char *period = NULL;
+		char *fc_mask = NULL;
+		char *ch_mask = NULL;
 
 		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
 		for (j = 0; j < obj->size; j += 2) {
@@ -596,8 +574,23 @@ static int json_events(const char *fn,
 			       "Expected string value");
 
 			nz = !json_streq(map, val, "0");
-			if (match_field(map, field, nz, &event, val)) {
-				/* ok */
+			/* match_field */
+			if (json_streq(map, field, "UMask") && nz) {
+				addfield(map, &umask, "", "umask=", val);
+			} else if (json_streq(map, field, "CounterMask") && nz) {
+				addfield(map, &cmask, "", "cmask=", val);
+			} else if (json_streq(map, field, "Invert") && nz) {
+				addfield(map, &inv, "", "inv=", val);
+			} else if (json_streq(map, field, "AnyThread") && nz) {
+				addfield(map, &any, "", "any=", val);
+			} else if (json_streq(map, field, "EdgeDetect") && nz) {
+				addfield(map, &edge, "", "edge=", val);
+			} else if (json_streq(map, field, "SampleAfterValue") && nz) {
+				addfield(map, &period, "", "period=", val);
+			} else if (json_streq(map, field, "FCMask") && nz) {
+				addfield(map, &fc_mask, "", "fc_mask=", val);
+			} else if (json_streq(map, field, "PortMask") && nz) {
+				addfield(map, &ch_mask, "", "ch_mask=", val);
 			} else if (json_streq(map, field, "EventCode")) {
 				char *code = NULL;
 				addfield(map, &code, "", "", val);
@@ -690,6 +683,23 @@ static int json_events(const char *fn,
 		else
 			snprintf(buf, sizeof buf, "event=%#llx", eventcode);
 		addfield(map, &event, ",", buf, NULL);
+		if (any)
+			addfield(map, &event, ",", any, NULL);
+		if (ch_mask)
+			addfield(map, &event, ",", ch_mask, NULL);
+		if (cmask)
+			addfield(map, &event, ",", cmask, NULL);
+		if (edge)
+			addfield(map, &event, ",", edge, NULL);
+		if (fc_mask)
+			addfield(map, &event, ",", fc_mask, NULL);
+		if (inv)
+			addfield(map, &event, ",", inv, NULL);
+		if (period)
+			addfield(map, &event, ",", period, NULL);
+		if (umask)
+			addfield(map, &event, ",", umask, NULL);
+
 		if (je.desc && extra_desc)
 			addfield(map, &je.desc, " ", extra_desc, NULL);
 		if (je.long_desc && extra_desc)
@@ -718,6 +728,14 @@ static int json_events(const char *fn,
 		je.event = real_event(je.name, event);
 		err = func(data, &je);
 free_strings:
+		free(umask);
+		free(cmask);
+		free(inv);
+		free(any);
+		free(edge);
+		free(period);
+		free(fc_mask);
+		free(ch_mask);
 		free(event);
 		free(je.desc);
 		free(je.name);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index b74c6ef59e51..f13368569d8b 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -63,33 +63,33 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
 static const struct perf_pmu_test_event segment_reg_loads_any = {
 	.event = {
 		.name = "segment_reg_loads.any",
-		.event = "umask=0x80,period=200000,event=0x6",
+		.event = "event=0x6,period=200000,umask=0x80",
 		.desc = "Number of segment register loads",
 		.topic = "other",
 	},
-	.alias_str = "umask=0x80,period=0x30d40,event=0x6",
+	.alias_str = "event=0x6,period=0x30d40,umask=0x80",
 	.alias_long_desc = "Number of segment register loads",
 };
 
 static const struct perf_pmu_test_event dispatch_blocked_any = {
 	.event = {
 		.name = "dispatch_blocked.any",
-		.event = "umask=0x20,period=200000,event=0x9",
+		.event = "event=0x9,period=200000,umask=0x20",
 		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
 		.topic = "other",
 	},
-	.alias_str = "umask=0x20,period=0x30d40,event=0x9",
+	.alias_str = "event=0x9,period=0x30d40,umask=0x20",
 	.alias_long_desc = "Memory cluster signals to block micro-op dispatch for any reason",
 };
 
 static const struct perf_pmu_test_event eist_trans = {
 	.event = {
 		.name = "eist_trans",
-		.event = "umask=0x0,period=200000,event=0x3a",
+		.event = "event=0x3a,period=200000,umask=0x0",
 		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 		.topic = "other",
 	},
-	.alias_str = "umask=0,period=0x30d40,event=0x3a",
+	.alias_str = "event=0x3a,period=0x30d40,umask=0",
 	.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 };
 
@@ -132,13 +132,13 @@ static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
 static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 	.event = {
 		.name = "unc_cbo_xsnp_response.miss_eviction",
-		.event = "umask=0x81,event=0x22",
+		.event = "event=0x22,umask=0x81",
 		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "umask=0x81,event=0x22",
+	.alias_str = "event=0x22,umask=0x81",
 	.alias_long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 	.matching_pmu = "uncore_cbox_0",
 };
@@ -146,13 +146,13 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 static const struct perf_pmu_test_event uncore_hyphen = {
 	.event = {
 		.name = "event-hyphen",
-		.event = "umask=0x00,event=0xe0",
+		.event = "event=0xe0,umask=0x00",
 		.desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_HYPHEN",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "umask=0,event=0xe0",
+	.alias_str = "event=0xe0,umask=0",
 	.alias_long_desc = "UNC_CBO_HYPHEN",
 	.matching_pmu = "uncore_cbox_0",
 };
@@ -160,13 +160,13 @@ static const struct perf_pmu_test_event uncore_hyphen = {
 static const struct perf_pmu_test_event uncore_two_hyph = {
 	.event = {
 		.name = "event-two-hyph",
-		.event = "umask=0x00,event=0xc0",
+		.event = "event=0xc0,umask=0x00",
 		.desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_TWO_HYPH",
 		.pmu = "uncore_cbox",
 	},
-	.alias_str = "umask=0,event=0xc0",
+	.alias_str = "event=0xc0,umask=0",
 	.alias_long_desc = "UNC_CBO_TWO_HYPH",
 	.matching_pmu = "uncore_cbox_0",
 };
-- 
2.36.0.512.ge40c2bad7a-goog

