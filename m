Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508C2481A47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhL3HWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbhL3HWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C68C06137B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:54 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u6-20020a63ef06000000b00341c8aa06d8so2763899pgh.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ewN6TgeYhi7NNspT4fCbrjPDfPPrcTRTO0RxDMRaTEI=;
        b=INzSbn3pkxSj2o5rY/D2ZDHKiMG80XuFQV1LdJh951/si0ZNvb2AQ/U8J01hhPUcip
         O4YIgbs5JOUpysdzNjoTE+e1bYWE0QhhGSrmhekuQLSyeuXFeLNHRXgLI6z5rORfe5rL
         /JvOaK/8/+nxPMe0QcNX43yTndBbtabg8tnrfCR/xKmAEjc7/ntldHYPidBQCpYhqt9W
         eVMXK0k8df5ymmhFgydv9CnHZlVm96sEswqhFAkTfdlbT0ZrUgJjDaNfKoGWhUEMcjDK
         KNPzlUm1D0bTZFwRjNxXU4vt3u9OIFi+YN5QgSJFbl/uEQRFxIH4JUviryG9zXNqoalp
         /1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ewN6TgeYhi7NNspT4fCbrjPDfPPrcTRTO0RxDMRaTEI=;
        b=c58AY5bDM52fvCWlK2+qOPUinWh9jRGAOux3TRYYHiw9h8Zq18fcldyI8MNQgrPzkZ
         aOc9DVN21sNa51IMGa5t7+w4YVfH75K7UjPdzp1u2tnPf8TkCyneO5gOktofv1KcYIQK
         tRgg1D5OSqqGclH6aq1LF3I3C4yJAJUJpsoZ6wW68sp7LwJOahJiPjZVVLvkOwTLdHoD
         weN6XKPTGpF9OejBi5VDw7E41pfxUvAutt+mPTdB2uRHQYyGmZXLbGQzQY+H7qDnceAz
         8EXY2kN/Tq0cf9oLQJKW5nBjd7UeY1SA4co515xWj5QZ7ylBtpSVkQLypSRxZW27k6Xs
         AwQg==
X-Gm-Message-State: AOAM530fSSfQOUTebuRcPiubREvexEukqnDWdMOhHaoa75dxDD62EX4H
        ee0wvWxQk3hGHHoJxcssb8aNBEgXesae
X-Google-Smtp-Source: ABdhPJxwC04VkqtH3R7KdDCbDUTQi3SLQnP/SiPOIZUMZfH2icNrN1mdP2zY7pRXNCkZkVNGG4IDRp1xSH3H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a17:90a:638a:: with SMTP id
 f10mr36302623pjj.187.1640848913549; Wed, 29 Dec 2021 23:21:53 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:12 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-32-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 30/48] perf stat: Rename aggr_data cpu to imply it's an index
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to make cpu maps less error prone.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f48d1678861c..7e933a8fee68 100644
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
2.34.1.448.ga2b2bfdf31-goog

