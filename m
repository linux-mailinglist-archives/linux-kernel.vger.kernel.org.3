Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EDA481A48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhL3HWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbhL3HWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFDC061378
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e2-20020a25d302000000b0060c57942183so22010890ybf.18
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=ZHSo2QogBeCKktE3N/YyE3guPCcf/h1gw/biq5AKmUg4GzLO2669grdN+V+1ag5H99
         c9w2XJWVYAwtx7P2SqJ/xO56ij3QK1S0NzXUvKQxC7XhO0N8O8RoNxGetqs7QkUqPHCS
         58pxmqY8UZUpFb60FfOhNHmDYw1EPGUdByWzIamAxyO6vJhLZzfilDHYwzNTxvAWvTGU
         UDtvUfmm4b5qWzn5oUT/eR9b83N4dQPJKT0Y+8xGxkXfU/neI2ieuSG8gfbE5zBocxK+
         PGOZ5+qDjoWM0lO2LiAZc0g6RjweagNlLMIsnjL49ujCCKDm/ZO79snV4QhczPjC3GaY
         yswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=2Cud+klKWMx0rdElKj5kb1DJ18L1Zpxm/SvpkRkQr0UYJ6vlGVEIpxrG0sYZR8vZiE
         mxTojoX01RnfDvHfCioGfDUV0loha6favTQLK3iFAUZZmoJP1rn0Jnp9Z0QWFZ7R7Uq/
         G9w/eT7AaCUQgDNCepeCkkARbmxJrr+yVOa4/92SK23Kfox9AiGMooK/GToo4D4S4/jp
         MfLOM9PwwlHGt2UBpH851Gz9L2gx6iCZ+tMqtUJ9yx0oV5EtRwVd4cfVU/kY+zHxejLp
         J4peOnJyFwqjpxAsQ7sk6anTrF7NEJPNrNwZHaoeSmblk+f7qpT25CURIKELt0SP0Fi5
         8GQA==
X-Gm-Message-State: AOAM531EgZsJ1qGMqD0Dl2gVVbIObyBqDdSp3+oSA7LtHwqRN779etuZ
        bGpJjpz61Q6j/+5s1RemSKyWpshOLakP
X-Google-Smtp-Source: ABdhPJyMMa/s/OfZP2MysxB1hBFAyWLxl400jCqqJknIeMSBDfgAktkYlZ98Gg7nJoVPdSu9G6g8w6ryMdDj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:510:: with SMTP id 16mr24785663ybf.247.1640848910686;
 Wed, 29 Dec 2021 23:21:50 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:11 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-31-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 29/48] perf counts: Switch name cpu to cpu_map_idx
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

