Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F421484E30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiAEGQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbiAEGPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D843C0617A1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i65-20020a252244000000b0060b2e5fd54cso56204234ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ewN6TgeYhi7NNspT4fCbrjPDfPPrcTRTO0RxDMRaTEI=;
        b=T4QTIVVf6MChV8kYFahTMIlnIWjfDM2Pz4nZGLcvbAgVmMvSnAfRZzR3TWKRnTT8Qg
         uW84zNDkePRuuqvBP+GaSI0aSYMHhSvvV2enYbfYt3qm176fWAtaX7S4FRbee/wIqxp3
         L/k3jjOAbBR0QFqB0Hzdv0thUW4H1DbTmCl596UpOj6qstJuZpl52Rm3aEJV+z/QGSDC
         iE0XS9XqpPzBPfD/Nd/WNjjGkM6MbRnrSmoGo6YVT00qfc8/iTojNxB2ZjuCxRPGsAqB
         lVODIyrsyA0su0WMr/kjGr+UekZnVI/BlKzo35vZS06DZC9TW3l/gGe3wPA8pemnDXwQ
         5CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ewN6TgeYhi7NNspT4fCbrjPDfPPrcTRTO0RxDMRaTEI=;
        b=VWvXizf9KRVTQeu2kXuDXad9730Rz5aOCy8brF6C3uEWPhzUH1SwzuNDmZha2FDvgg
         3XFW8htENGwgWOxiHJVDMVR4KhIDMAiPKePmcZBTptlXnSqcQWbGTRlFrptjf5eshsYk
         Lnv36JK/N4j1eVVIX4sgW1m7V/jNFtDkV0zzq3xyXb5cT3Mq6Mpwota6wIu4TUR2deq0
         pEDN/7Q/SVFTxiwZUFsduvRKino0v7xahh6FePUKN6mzLozeDtEPe4FmTz5IreWdrJMg
         K8ZIf2rtXyYS/uBlvgppZBqOwUjEB4bTl9Nl4bens8sWmDIvoPO0dPurOEHtj303By3G
         xFzA==
X-Gm-Message-State: AOAM530t4ns596ZZv5SPNgtzZRqzsMN2Qdf+v1UQm7yJt02W4L/2cGc4
        G2buUlnSxmz3nC6VA8wrreugWZMsDTNX
X-Google-Smtp-Source: ABdhPJwwG3mTg4oT2fYpRqR1bZ5fv8nAUrwDtQtv9qYKgk1o53MMLlA/bzYOULWt31L4uSwq3pHmdOdhDpKP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:2e0a:: with SMTP id
 u10mr43339373ybu.246.1641363312500; Tue, 04 Jan 2022 22:15:12 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:33 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-31-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 30/48] perf stat: Rename aggr_data cpu to imply it's an index
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

