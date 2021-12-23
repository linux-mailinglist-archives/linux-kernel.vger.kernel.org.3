Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323B847DFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbhLWHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347215AbhLWHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29930C061353
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w9-20020a25c709000000b00608a9489fc1so8586964ybe.20
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hkPo8liTuI9h6KOorTG0Q0VnFokCocOgWRmiktw00dU=;
        b=Xcj0ee+hgy+nDCYG/rsM91+FuuqQSJiMSCzMOM5SkpY53T4DzkFC3flZLbcPQJ0xOW
         ucf2StOzgxlmQWFBtpk07akH+Ih91uqwgd1SMQCB2yVnBLHsYRa+avn6wgPFt0kjsNpr
         YwbBXIrJUuKVqeYyf/FM/YHOI0xj9btID3ki+m/EGWmg+sNQYCI07g79MZCdpOAU/BVP
         7xrCMsCuo94Fz14MPRqjNXM3IgUKSoibZqYXoQlX7f4LfI/d9uARzppArHlhFKv0NNPP
         godVNKuyjvowcHh5mfHlqzEk2VHtLkw1SGFdfboDj6XRovc2Lq4bIDiSIU5UWJUDkBe0
         Qlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hkPo8liTuI9h6KOorTG0Q0VnFokCocOgWRmiktw00dU=;
        b=cOMqtsak1y2TzqiLZcVaK0KXALB5SXyT/qEghQSZPQhs1pBzXGfg6TAU/DFLm7Z3oO
         MlRwtRj5ANZXmawKcjdsas4evXXr6z7VYteGtePrHyc4J74v/Ro+H5Qray8Yb7uTZntV
         Pxy9fOA+pQPP+KGWHYH3d9ycv9jnRUZgBhGxVn2QQdNFKvFVpwliAlj1CgB/dE+E+buu
         MrYjTqXmgXRS+oRb02+P5Qbf+zkYOXqmMO7QTJ52cof/ul4KkWAcE4HOSLeTt1YJyGnF
         PKNY1h08MuevLmVXXjPDTkA7dNfElphNvZMZjSX2NS0b0327kVXtrVB0yWxj/SUOQS3k
         uZew==
X-Gm-Message-State: AOAM531En0gkEql+ogm17cg3vcBaSHh6jpsQaPhL8L/nCRaxvXd1mWBF
        GP/v5HPt53ijaa7aU5XLRqTB8/dL7kgt
X-Google-Smtp-Source: ABdhPJxp6t3w/qnJ+v3zw2zyM1duZWB+B4DWIZtTNpflJlX6sZOLZwc2wLe7o4mryuVEonh3x19x1ZBXjNXr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:50cf:: with SMTP id
 e198mr1803293ybb.508.1640245644353; Wed, 22 Dec 2021 23:47:24 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:23 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-31-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 30/48] perf stat: Rename aggr_data cpu to imply it's an index
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to make cpu maps less error prone.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c       |  2 +-
 tools/perf/util/stat-display.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 563a9ba8954f..4b510a1f27d4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1057,7 +1057,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *md = &evlist->mmap[i];
 
-		if (md->core.cpu == cpu)
+		if (md->core.cpu_map_idx == cpu)
 			return md;
 	}
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 821511ba22cc..4f93591aaa76 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -626,7 +626,7 @@ struct aggr_data {
 	u64 ena, run, val;
 	struct aggr_cpu_id id;
 	int nr;
-	int cpu;
+	int cpu_map_idx;
 };
 
 static void aggr_cb(struct perf_stat_config *config,
@@ -878,9 +878,9 @@ static void counter_cb(struct perf_stat_config *config __maybe_unused,
 {
 	struct aggr_data *ad = data;
 
-	ad->val += perf_counts(counter->counts, ad->cpu, 0)->val;
-	ad->ena += perf_counts(counter->counts, ad->cpu, 0)->ena;
-	ad->run += perf_counts(counter->counts, ad->cpu, 0)->run;
+	ad->val += perf_counts(counter->counts, ad->cpu_map_idx, 0)->val;
+	ad->ena += perf_counts(counter->counts, ad->cpu_map_idx, 0)->ena;
+	ad->run += perf_counts(counter->counts, ad->cpu_map_idx, 0)->run;
 }
 
 /*
@@ -897,7 +897,7 @@ static void print_counter(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 
 	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-		struct aggr_data ad = { .cpu = cpu };
+		struct aggr_data ad = { .cpu_map_idx = cpu };
 
 		if (!collect_data(config, counter, counter_cb, &ad))
 			return;
-- 
2.34.1.307.g9b7440fafd-goog

