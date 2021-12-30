Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24E481A52
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhL3HXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbhL3HW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AFCC0613B4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e137-20020a25378f000000b0060c1f2f4939so23370123yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wNEaBrVID5KM3S+MlzNQlzdEQtierpy9+J1kdBtC9c0=;
        b=TTTFh460x4r9b2VRMxOY8iKhybAM8PiJtFbVyaJQ+0BhAnhyoi4p3/ga9+9CtkRtVy
         7fnbaxN5FngrrBPE0JsqS5uiBRuG4mUEBWmxFJhHxhcaoJToebYhWvBO9e/IAAYGw28P
         O+PnpVudpwOjp+vWqKDhiOL0P2TVFNdrvgGNBIUOOpSSQfe+0+aSCzyQ9V8q3jXL/qQE
         oIsCcVPuZHbUq8JCeDnMwJksVHihpJ3qkSsLaakJ8C8f4vKc5y3SStdkzKgq0+jysypY
         BQM6bQedr+nfmGzX2/uyMeWM1yl+qtNiO/PrDS4msW2sE2j8YFmmkr6E3RP26YmCYCDn
         KiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wNEaBrVID5KM3S+MlzNQlzdEQtierpy9+J1kdBtC9c0=;
        b=T/XgRJlSOLb6cRF3OPfhExBf4WfNHDxHd3yPXLeAADDflDTNE+crU7Ctdgk7+6sTwB
         jG1SLT4WL7dEeRCk4t3AzVQI1GGVZmS3QzvsxKYI7OfQDDKk1TeCo/9acDQZ9LQDcuNu
         Pd4I8OkKHWflu2Xo83cA4ex39Cof3GPdkgD+7M1qmxK20OOQeUmxjuo5Z1KDtq/CTojE
         zc3mFP0RjgmTXkklZW+N0BCBmV1m57cDIQ8K0sAkBuIe5eDkFeL94UV7qeX0CXgucOei
         EUf/sA3S81QxuxSBEFHTDfcoAAkiUx6pZywxVDz7cdlqbh6gFlRSoloX0pchJWnpgNcC
         JzjQ==
X-Gm-Message-State: AOAM532dTiaIEJQ/o2OFIVZGrDBDoMLB6dn/taA6HYFKZRA1shd3ziCL
        ovSYiD6YyjK7pYRYKeRuIL7x1Cw/XXgt
X-Google-Smtp-Source: ABdhPJxW/7qLOvo7GcinKItCT/Oygb6bQu4X+oSp1J9l+1rucFRcLP4p2ZKPHw7ErmPDD8fVB6XK875oPE7y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:a06a:: with SMTP id
 x97mr40512043ybh.411.1640848941095; Wed, 29 Dec 2021 23:22:21 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:23 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-43-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 41/48] perf stat: Correct check_per_pkg cpu
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

Code was incorrectly using the cpu map index as the CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f7f9757eba23..86ab427e87fc 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -292,11 +292,12 @@ static bool pkg_id_equal(const void *__key1, const void *__key2,
 	return *key1 == *key2;
 }
 
-static int check_per_pkg(struct evsel *counter,
-			 struct perf_counts_values *vals, int cpu, bool *skip)
+static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
+			 int cpu_map_idx, bool *skip)
 {
 	struct hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
+	int cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
 	int s, d, ret = 0;
 	uint64_t *key;
 
-- 
2.34.1.448.ga2b2bfdf31-goog

