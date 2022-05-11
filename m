Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92FC522CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiEKHCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbiEKHBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:01:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01735E157
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8be9326fcso9704767b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GOl/dDyiic3CHN6RpwyPiPKb1wU0VPhBRck28P7ZCHk=;
        b=EnHwC10qwtnV6pxqRJcYnJ49YxvO7SNM936gaY/vUD9nwsdn7XuxHwNK64iZ+h+Fix
         h3I+btR3DZSQ8xyOxoxGB6qWSKczhaCoFnjdHBtUxuju4nkgOyLypfaTl6AzAjGypQMI
         CCIitXJUvLQc8FBX3I1njZS2zgHo0zG9ze2tgKP+0lHT2wTJJmaCX1IDzPyHTL5kSHyi
         1Hmykb+40ppEPYOwmJwY6kJNOC0ibZZ+6b6gXfPAhMCyHJjsmpmMsKPBZkfj0y2wiFYJ
         ORhKqKt7xxIfuToMv4ERtBOfxqzWVg89x8ABummQWCwjzgxE1dYcPvbdyN4L+EcO/SPL
         kdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GOl/dDyiic3CHN6RpwyPiPKb1wU0VPhBRck28P7ZCHk=;
        b=scoXMcLM5HIVkBk7pyInZD5TZjdWhm/4wUmR3lKGXilatnqOJHTEG/psCOtYTyhfpL
         aSLEIw3iuVnFdHCdCRRxGzkPEPIgXxP5sVUEoF8RVPQSMZejPQ+8d3/d88Obu/DQBYW8
         v7lfF1GRJteXhZP31/6iHCnwk78BegrpdqhUDih25MWvZGsGE5i40QmOS/In6SzATzkM
         XS++Tc+uDjMfcfKCEZXlmHqE/g9ZXwamVaaNGqXHi6TKTw0A8jWSAqqEXLLoxNqlnEJc
         nc4lBsSU5WK6SlpQe81E1Ddk/93gqtxTttrvws9ZogrqR6LlgijFleRUb+DLk/NlgFQe
         CKPQ==
X-Gm-Message-State: AOAM533nGx30/aMrkluCr6U4ZR8SCXxbMWR7GV88Hm/kzqM2fucSIGv+
        fe5ls0JiONBCPX/Sv8DVghXYjMJu0tGX
X-Google-Smtp-Source: ABdhPJz6DgNH2KUDVEqruh6QTuP3eHV+0C65QhAonB7KFFGCDZ9k68xvIzb57Q2CYcotHaOjeHpkPVu6UIAq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a25:acd2:0:b0:645:d5c8:b837 with SMTP id
 x18-20020a25acd2000000b00645d5c8b837mr21754737ybd.481.1652252499791; Wed, 11
 May 2022 00:01:39 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:27 -0700
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
Message-Id: <20220511070133.710721-2-irogers@google.com>
Mime-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 1/7] perf jevents: Append PMU description later
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append the PMU information from "Unit" to the description later. This
avoids a problem when "Unit" appears early in a json event and the
information prepends the description rather than being the expected
suffix.

Update the pmu-events test so that expectations now match the improved
output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c | 8 +++++---
 tools/perf/tests/pmu-events.c   | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 159d9eab6e79..e1f7c7afd435 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -652,9 +652,6 @@ static int json_events(const char *fn,
 					for (s = je.pmu; *s; s++)
 						*s = tolower(*s);
 				}
-				addfield(map, &je.desc, ". ", "Unit: ", NULL);
-				addfield(map, &je.desc, "", je.pmu, NULL);
-				addfield(map, &je.desc, "", " ", NULL);
 			} else if (json_streq(map, field, "Filter")) {
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
@@ -697,6 +694,11 @@ static int json_events(const char *fn,
 			addfield(map, &je.desc, " ", extra_desc, NULL);
 		if (je.long_desc && extra_desc)
 			addfield(map, &je.long_desc, " ", extra_desc, NULL);
+		if (je.pmu) {
+			addfield(map, &je.desc, ". ", "Unit: ", NULL);
+			addfield(map, &je.desc, "", je.pmu, NULL);
+			addfield(map, &je.desc, "", " ", NULL);
+		}
 		if (filter)
 			addfield(map, &event, ",", filter, NULL);
 		if (msr != NULL)
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 299a215eb54c..b74c6ef59e51 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -133,7 +133,7 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 	.event = {
 		.name = "unc_cbo_xsnp_response.miss_eviction",
 		.event = "umask=0x81,event=0x22",
-		.desc = "Unit: uncore_cbox A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 		.pmu = "uncore_cbox",
@@ -147,7 +147,7 @@ static const struct perf_pmu_test_event uncore_hyphen = {
 	.event = {
 		.name = "event-hyphen",
 		.event = "umask=0x00,event=0xe0",
-		.desc = "Unit: uncore_cbox UNC_CBO_HYPHEN",
+		.desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_HYPHEN",
 		.pmu = "uncore_cbox",
@@ -161,7 +161,7 @@ static const struct perf_pmu_test_event uncore_two_hyph = {
 	.event = {
 		.name = "event-two-hyph",
 		.event = "umask=0x00,event=0xc0",
-		.desc = "Unit: uncore_cbox UNC_CBO_TWO_HYPH",
+		.desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_TWO_HYPH",
 		.pmu = "uncore_cbox",
-- 
2.36.0.512.ge40c2bad7a-goog

