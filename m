Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800B0484E41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiAEGRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiAEGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D03C0698E0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso15621453ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=on9cMkVsbDIIWgmJUXNGZPB7xxaMgvNoxu0hM4zjpQ4=;
        b=cCPa+SHUCrMw8an8q45ZtRv/i64BmCmjROSrKJPgOM2PlHDZB4+gvUCwJ1zG+hj8fU
         IGxUB7AKkBFoSB9Iq/g5ay3aE4WzGhPsoWQn26bxpPYxsG8MFY2yG2H0Rn0JwycHgoMM
         f+Yu6rhevihqhazqUEML2fUjYVtCw0GRBAa/Jtuvu0haKFsRyHQdnq20hXmax0lUfN60
         JyS6G7j64n3+q1DAcdkOdPw35XZCVVJPVoX9dWmjAdM8FDDYcFwCJkF/wmuJcE/8OOhS
         kcXb95CGgvWhzwN9Gjyj2OWN1UkZrO3kbC7uP7QgfmWOpEpSNx7iFR3WtmpOfoWT+vc6
         4bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=on9cMkVsbDIIWgmJUXNGZPB7xxaMgvNoxu0hM4zjpQ4=;
        b=nxPKk+5BSWZxEGadEB6UcVgiyvkPlJ+dHtkTQfc3Q9ixTiL9iBKUgvb5+0lSwniU8+
         m8PzJKJaRco9V/tqhYa4V9bSvd1U9b56C2hGxjsydX4xvKN81U/ZOxIdRBypRHv3xpP3
         OuShjMKLkz6hvndjrJeldVEggCvV+z4GZfHtdsHSSBGoOTkdk9QIVJfHnAhyezZ6O5VQ
         505CnH4+Ybuy9MAGkPTayPKE5l3Cv4dZiL/KYO3m5sjxqVMNKB5ltkGwZAPjY+VvSH/s
         uUcstAUSmRFgxkRttiFq3/vifub1IjIEnEBDjMTvLGLiQeSV8cAgXMtGdi0tgYJMpylt
         aKtw==
X-Gm-Message-State: AOAM531i/GWQD/SMVTJQiCqpwapF9VR2CA0BsmKNkCfj8zYgMe1QQ2wz
        qxHY1BAvZ0/Zy8gFXQAUYdySYgj/2GQs
X-Google-Smtp-Source: ABdhPJyMIB+6RXZ4fgulTItYs0MJRIuoDNybHTF5irVS16tYmpzKDDP+9Nut1QNjJ9zINgchGiHA954cHJ4D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:9b45:: with SMTP id
 u5mr24170194ybo.76.1641363354738; Tue, 04 Jan 2022 22:15:54 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:50 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-48-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 47/48] perf stat: Correct first_shadow_cpu to return index
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

perf_stat__update_shadow_stats and perf_stat__print_shadow_stats use a
cpu map index rather than a CPU, but first_shadow_cpu is returning the
wrong value for this. Change first_shadow_cpu to
first_shadow_cpu_map_idx to make things agree.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0f192360b6c6..ba95379efcfb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -327,24 +327,23 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static int first_shadow_cpu(struct perf_stat_config *config,
-			    struct evsel *evsel, const struct aggr_cpu_id *id)
+static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
+				struct evsel *evsel, const struct aggr_cpu_id *id)
 {
-	struct perf_cpu_map *cpus;
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
 	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id->cpu;
+		return perf_cpu_map__idx(cpus, id->cpu);
 
 	if (!config->aggr_get_id)
 		return 0;
 
-	cpus = evsel__cpus(evsel);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
 
 		if (aggr_cpu_id__equal(&cpu_id, id))
-			return cpu;
+			return idx;
 	}
 	return 0;
 }
@@ -503,7 +502,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu(config, counter, &id),
+				first_shadow_cpu_map_idx(config, counter, &id),
 				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
@@ -532,7 +531,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu(config, counter, &id),
+					first_shadow_cpu_map_idx(config, counter, &id),
 					&rt_stat);
 		}
 	}
-- 
2.34.1.448.ga2b2bfdf31-goog

