Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE5484E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiAEGP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiAEGPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3089C061799
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b144-20020a253496000000b0060bddc72114so53307176yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=BSYcjgUHghko72edoiIv4G3cjKBzq3ehGryZJE+H8BRTklqIkutZuePSRHPpMV6vBw
         Z06T8Bp1YNRRHloiV7U+1uZP2Bhs5d+lVTRziFfQ1AOLjcQwfiIexNiEc202pyfnMax9
         N9njEIRcEKtKTN1xsAVdtk9zmsWzAoJXPpVbJnBTZzYdCbodW2lknjllCqmCnVvemOci
         aTObHJCt6X4QIUGWKxDuN6UO6RAX/7XbOpdQaYSMetQVQ2PyU5Xr2EldMOS55EGCafWy
         LEgt2OIF8c5qVFS1B/5WOHwH7hrXZ0PVKuZkExuxCVbUTtBpOUW2PzbSueFNDveySNMH
         rMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=FsgEBAY0zTjDiY2CV/Vy2cgK709zpSoIUrZb6LreuvTZGHmXMJtBItCmkYYt+lOECL
         TMRu61kQaI3XwX6wSolvNWdhXZXvvpjRR+X5MqATB6RpzC70RUVBJiG/gajQoq/jb7vU
         01OPHkNa+F6Oa5XD338OAI/lTt08vHiZD15wCFh3KrUIOFs9e+R0MjOlhhJblX5A5Zeb
         hsZC1yJhIoCqpA/JmseCnP3xMejEdIg4CnibaxtZ0hN2GK+5/HpkAxLKUDY0NskErIlL
         ySlpWTSsTzWPEMR6xDkaTN8NRGuFhp7mTspBxKAOlrtbdaPsqkE/gToroT8Avsudeyoo
         Aplw==
X-Gm-Message-State: AOAM533TeGFVPkvByYOBzUBJefBfHGMPLp6HjhNpISDnbXXoR0mPRwAl
        3IAHGDZu22sVRelhd3DBDVLzMkQUKHwq
X-Google-Smtp-Source: ABdhPJyACmhRpL//P3NHuYdqf28x0b4/9Re1ZbBwgLpJRx+vhfd3Aq0crqV0mPEFMOz5FCU1L4iYQZxlghlk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:b5c3:: with SMTP id
 d3mr72174615ybg.665.1641363310263; Tue, 04 Jan 2022 22:15:10 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:32 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-30-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 29/48] perf counts: Switch name cpu to cpu_map_idx
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

Try to reduce confusion in particular when the cpu map doesn't contain
an entry for every CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/counts.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 3e275e9c60d1..5de275194f2b 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -18,21 +18,21 @@ struct perf_counts {
 
 
 static inline struct perf_counts_values*
-perf_counts(struct perf_counts *counts, int cpu, int thread)
+perf_counts(struct perf_counts *counts, int cpu_map_idx, int thread)
 {
-	return xyarray__entry(counts->values, cpu, thread);
+	return xyarray__entry(counts->values, cpu_map_idx, thread);
 }
 
 static inline bool
-perf_counts__is_loaded(struct perf_counts *counts, int cpu, int thread)
+perf_counts__is_loaded(struct perf_counts *counts, int cpu_map_idx, int thread)
 {
-	return *((bool *) xyarray__entry(counts->loaded, cpu, thread));
+	return *((bool *) xyarray__entry(counts->loaded, cpu_map_idx, thread));
 }
 
 static inline void
-perf_counts__set_loaded(struct perf_counts *counts, int cpu, int thread, bool loaded)
+perf_counts__set_loaded(struct perf_counts *counts, int cpu_map_idx, int thread, bool loaded)
 {
-	*((bool *) xyarray__entry(counts->loaded, cpu, thread)) = loaded;
+	*((bool *) xyarray__entry(counts->loaded, cpu_map_idx, thread)) = loaded;
 }
 
 struct perf_counts *perf_counts__new(int ncpus, int nthreads);
-- 
2.34.1.448.ga2b2bfdf31-goog

