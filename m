Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8206C481A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhL3HW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbhL3HWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u130-20020a254788000000b0060a9645f781so30256161yba.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dr21UIWlWh08GpstPSt0DXreHsY1rvRjUlHXGQMgUUQ=;
        b=EzlOdQL0P3mQ5LLCjUBdScAdR4k8fbx3t1xiYbAGiLzrvhfYRNamUq3myYjTNbMt1z
         z1iM60q9zjlaQAcoCGdA/MylPvkoXxci2/mhvMITTMVzxFMmy1kLRBKwKSdlzO0kFLac
         rmX36ofvYh41GcgwoFMXtS3/igsv10WDIviUoefVvtAGryPH4lySTaSqzi51hQVUXRp+
         ocpdbQPHx5fHXPwVKhz5QvLiwYbqfx4x5Q5vidzBlB7alneeRNnVq+/RWxS64bjPHZdY
         MsTjekbO8bobE8pPkFVDaDAAyl1NvvRu7QWxrniO69RQBLBeqhVDpkbID3vcTO0EI6LS
         iryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dr21UIWlWh08GpstPSt0DXreHsY1rvRjUlHXGQMgUUQ=;
        b=y4wx/NwmIzpYnNawsT4DFZ9AkIr/1sFpJ5lnwh4C9C2zuG0Pk5HS6CvKmsGeOuSBdP
         zxYBLj3TLaOSi5dFwoztK39logwVP6BaeVlEFKO5t3Uazeg/aQNeF1PxBgKbgkuq1RKG
         fUs/vOC8W/u2gNS6cXdXZnWoc3EOFJipftGqKqod5S1EvJqmNmMTDATxuYTXXkwEZRCn
         Di27Q/rLJr+Eyw+jkBxaPqYsi8ew1QWianHnj//For44ClyONfSgTEpPBJtM9l3LV/ax
         TO56ArUIyOFz9zLeBx015wd/HuXObhvqbZz1APjqMO28SKjvrKM1DO209XH+/3MqRD1A
         x8ig==
X-Gm-Message-State: AOAM533IEKwJORHwZldtO3jayK9PcINTMnlNYqMSfBYEQsPLIZChTHx7
        r2ZG5NJRmoGL3LtvAYSmew3fd+HNvZRw
X-Google-Smtp-Source: ABdhPJyRfLGpoQ9H9fJ2Morzmd7n7bmZUL51X8hObRibMpoPCIExOKmteY86oNxmXqhmcVFjCo2lIJ4u9b0N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:7287:: with SMTP id
 n129mr36420396ybc.351.1640848926039; Wed, 29 Dec 2021 23:22:06 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:17 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-37-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 35/48] perf evsel: Pass cpu not cpu map index to synthesize
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

