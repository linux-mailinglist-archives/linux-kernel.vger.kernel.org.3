Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860E9484E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiAEGRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiAEGQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF1C0698D1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i65-20020a252244000000b0060b2e5fd54cso56206183ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Uc3y2XubM268HoD+IkmNJwiXqvYvgqQuPR9NEiJZLmc=;
        b=TunQ7ILrBD09OO6vhhisUQ9Gmuc23oEPz0+0UnkU15+ACG90JwmT/U6cAqXdh/7xGn
         7Yh3IbuVegSfiaI1lgoWc+dfrBEPmzdIHWpmb5heBh3s02Qgvy+mksrkKrkDNVFuOHSR
         gbI4U5doDd1GVWvTaI7KfClnur8XgVkznfb6PRAB++zwwMBPHabARkvty+dYsFkn+guo
         KB/zkNvgkMcI0JShNSI7nUUvqY828jOCYMz+fdJgIMF8JtoHNLAhmCYzMI6n/uakSR0I
         Uf+5k/MrifDRwv5q9XRp2bDztNokKPJqgVTOxhQXBWX7PLsXDty4X2hHMvYSSKR5DXXk
         6u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Uc3y2XubM268HoD+IkmNJwiXqvYvgqQuPR9NEiJZLmc=;
        b=RzsSs6j0eQNAk7vDtPwezMmmO2JpTi+U4Lg30iJoj3ay3AkypJZvKYeFh+Nr9Q+oaw
         0iP2aZXTR30CkMO9gnMglcoPbHYIPn8Y61ZuEGFXLhRPKH+lIefu0c8gv1sn9MD6FW9j
         IOnl/IraR+mr437+R3D8ckV2yxoA7x2IXWgIc7D93QaN40VJVuFBJy952ToZK3DO/XEU
         7zM69VdITLXwQ15lXHdSWXpHHAiDGQmpBXPXf2SN7QRrt4XwnzJjgNTdJZcacrkxhgM2
         fg3hdprPqC55jNcgbh60GcPWhhTYsECv3PA+cqvymhe5A0R6rUBQM75Q7ouAJ1jM48VQ
         kt/w==
X-Gm-Message-State: AOAM530auSeWwi8mkqp7O1usBwpjD/pQeo+qm2XxlbppPCBBDhzSL68F
        TfTSGuj4a2p/8u5ysCHUsoRM7/FF/YQ3
X-Google-Smtp-Source: ABdhPJwdrZInOqy8dqRCsKG/FASRuQyzP+U+K56s2rhUIQVyaIoNf2oxgfDRUJkdpAMUiwM0nwi8+vy6lrUR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:5bd6:: with SMTP id
 p205mr62221904ybb.616.1641363347291; Tue, 04 Jan 2022 22:15:47 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:47 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-45-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 44/48] perf bpf: Rename cpu to cpu_map_idx
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

Synchronize the caller in evsel with the called function.
Shorten 3 lines of code in bperf_read by using
perf_cpu_map__for_each_cpu.
This code is frequently using variables named cpu as cpu map indices,
which doesn't matter as all CPUs are in the CPU map. It is strange in
some cases the cpumap is used at all.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 16 +++++++---------
 tools/perf/util/bpf_counter.h |  4 ++--
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index c17d4a43ce06..ae5bd87ff020 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -265,7 +265,7 @@ static int bpf_program_profiler__read(struct evsel *evsel)
 	return 0;
 }
 
-static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
+static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx,
 					    int fd)
 {
 	struct bpf_prog_profiler_bpf *skel;
@@ -277,7 +277,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
 		assert(skel != NULL);
 
 		ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-					  &cpu, &fd, BPF_ANY);
+					  &cpu_map_idx, &fd, BPF_ANY);
 		if (ret)
 			return ret;
 	}
@@ -566,12 +566,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	return err;
 }
 
-static int bperf__install_pe(struct evsel *evsel, int cpu, int fd)
+static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 {
 	struct bperf_leader_bpf *skel = evsel->leader_skel;
 
 	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-				   &cpu, &fd, BPF_ANY);
+				   &cpu_map_idx, &fd, BPF_ANY);
 }
 
 /*
@@ -623,9 +623,7 @@ static int bperf__read(struct evsel *evsel)
 		case BPERF_FILTER_GLOBAL:
 			assert(i == 0);
 
-			num_cpu = all_cpu_map->nr;
-			for (j = 0; j < num_cpu; j++) {
-				cpu = all_cpu_map->map[j];
+			perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
 				perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
 				perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
 				perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
@@ -757,11 +755,11 @@ static inline bool bpf_counter_skip(struct evsel *evsel)
 		evsel->follower_skel == NULL;
 }
 
-int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd)
+int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 {
 	if (bpf_counter_skip(evsel))
 		return 0;
-	return evsel->bpf_counter_ops->install_pe(evsel, cpu, fd);
+	return evsel->bpf_counter_ops->install_pe(evsel, cpu_map_idx, fd);
 }
 
 int bpf_counter__load(struct evsel *evsel, struct target *target)
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index 65ebaa6694fb..4dbf26408b69 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -16,7 +16,7 @@ typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
 typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
 					   struct target *target);
 typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
-					       int cpu,
+					       int cpu_map_idx,
 					       int fd);
 
 struct bpf_counter_ops {
@@ -40,7 +40,7 @@ int bpf_counter__enable(struct evsel *evsel);
 int bpf_counter__disable(struct evsel *evsel);
 int bpf_counter__read(struct evsel *evsel);
 void bpf_counter__destroy(struct evsel *evsel);
-int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
+int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
 
 #else /* HAVE_BPF_SKEL */
 
-- 
2.34.1.448.ga2b2bfdf31-goog

