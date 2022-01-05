Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D12484E35
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbiAEGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiAEGPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F56C06137E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k130-20020a255688000000b0060c3dcae580so50722585ybb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dr21UIWlWh08GpstPSt0DXreHsY1rvRjUlHXGQMgUUQ=;
        b=N23I1Y95+IicYXElTikWu4ibqxH7undrAZt9c6XkFA26KOXh0Cabt0ke3IUWLQCo6y
         MuY+49CfMYdz60bdKosSoQKvvW4T3gKUqNUjUCMPYN4+3DkWpaRE6B51xA8h2cTEUmIs
         hrksTXQr2bqb9F2RP89sVD8TZ9JZpVCT0cF3Xh5k3eRCo7v78OHCJF4nelsV6dg7OihL
         VOVgRzbICB5QffqLSPPd0CoRWGLZp9/HoHMmA667/6DkUZ8rNZF1xPAkECY9bTSCxR8i
         727Gsx7Xm3oxcNtenH3PISyWYd64hCiCGEpjbuQITvKHVj8fphmH4KpcwH9rrsgHTCHM
         welg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dr21UIWlWh08GpstPSt0DXreHsY1rvRjUlHXGQMgUUQ=;
        b=vmem4tp9yuoOD8e6QGMkM08uhnswgdiC5kWZ+5UYvxZybnCIBXOQur++Q59Uukmi1g
         wgbAyUEPRo8MWTN2WM6SUGIR/Hi9Mk7qq9nHDzQCjMtlybc57eURUB08yPSlkhOkkny0
         +5JhTWsHWnb8v7Cg+RoQAw1KvSeGr9ibSQZkzByLb03yjDpvKU2l7kMfR8Qo0Q9vhazL
         vYshWYWyhIzlIsgN0PGvGOj5oO/Pj9nijLFIxJaNxVaYeafUAto0aQdGBKMMxk+ba/0j
         bkbOJIJ0+J5G4NhgYt9sHwpYqhyJPZLiQNpNp675fMKmfqeVyVkdZBGw+QPSheocxuzt
         2t3Q==
X-Gm-Message-State: AOAM533pLkZqdW8sr8LZEYJSptyVxjM3O1YIYAo4+HIS5SEWEFBgUoAa
        Dxs0TH8hc9HM5H0fE9kanomltnl17Vvu
X-Google-Smtp-Source: ABdhPJzzjxoIEQAHd/uTP0ntUzzsxqof28Ml9SvqSkhMxWMruzLausY445YH2gXdmRvC1CCS2Sz01vE6I/81
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:2442:: with SMTP id
 k63mr42725045ybk.180.1641363325070; Tue, 04 Jan 2022 22:15:25 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:38 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-36-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 35/48] perf evsel: Pass cpu not cpu map index to synthesize
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

evsel__write_stat_event was incorrectly passing a cpu map index rather
than a CPU to perf_event__synthesize_stat.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f31bc34bd4cc..ec252579b587 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -327,10 +327,11 @@ static int write_stat_round_event(u64 tm, u64 type)
 
 #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
-static int evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
+static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 thread,
 				   struct perf_counts_values *count)
 {
-	struct perf_sample_id *sid = SID(counter, cpu, thread);
+	struct perf_sample_id *sid = SID(counter, cpu_map_idx, thread);
+	int cpu = perf_cpu_map__cpu(evsel__cpus(counter), cpu_map_idx);
 
 	return perf_event__synthesize_stat(NULL, cpu, thread, sid->id, count,
 					   process_synthesized_event, NULL);
-- 
2.34.1.448.ga2b2bfdf31-goog

