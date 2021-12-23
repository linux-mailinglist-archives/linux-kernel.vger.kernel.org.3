Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2747DFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbhLWHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347233AbhLWHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6FC061763
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d205-20020a251dd6000000b0060977416ad4so8517563ybd.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7KMW6WRtr7zGKUVYDJaGbIMwO/xb3TdjfWdejoRFxZk=;
        b=PD4AhddK0yCJrWHFUVFzF6fy/Hy7kE5hAz32UsxLOp2AWaiATpdPZNCESgd7gmZh+0
         JD9szVEZUwVwVIovJ8uhUR86l/3obJU0BPy0vtKl5hh/RzQIxNRTRLuKGDvT5HhD/yOY
         7CkPaB8T0BMkbm834BJKnDbYDjVJ6M72NJOIPfDmDT0/XJ8FQ0wSOKcrz1Wd3rBBrUbR
         Bqk8D0IIq5X+1wZ3FpVNLhVw7Qq54DrrbCECNH/qXk7Dl2u/AZHZkMRE6RED9In2ibgw
         C5Z3sPDQck0XHpCGjAL4/8F0gNSwBg3zIh80bnxvN8HFHtOSeMh62yc6uD8f8ZPBSSSd
         rtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7KMW6WRtr7zGKUVYDJaGbIMwO/xb3TdjfWdejoRFxZk=;
        b=AO4TvqQKjGv9OVsDQyWtwLpOwQLRr6zX6BymS/6bnKn03HhR18H+QglTW6pVEKPa2f
         qUqvqXaYmtMtMQE37iCFQlr2As62UJAWB8HNMuvQ7LCBrVxTID8u7krpI5xG9r0b6DdV
         UhfHT3RGBUllelCFwfNPr0+PCPxmF5jvSUol2eOsTFdZMuqeKPLuWSzBhYu0szTUu81d
         MROTTxUxzIUQswBUyxdppvyrzVLco8M8bZfn6ZCFsgAdB2GZ5zmp+4HNStmj+nWkpw3e
         EsnfTPLBXNrkRY+Bm0RzxMjHSv15qQwQrzVqRWaT+v/f0dbTnc6F6K72FZeTr4lrrDgG
         tskw==
X-Gm-Message-State: AOAM5323dwVaC0nOjZlLF0oDLFJaNrQHk9jyMGwoF7IYgr0Eg7SHFn83
        9rKrJto4fW8D/HdtUiyIxA8n58ltrFTE
X-Google-Smtp-Source: ABdhPJy1JMKjOvk17SbJ4unY+bdUb6VxzdlzcVN9x0G1cd9E8XUWweez9IQ3dMvk09C8NWl/FjP22s3abygL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:da06:: with SMTP id
 n6mr1734069ybf.763.1640245652081; Wed, 22 Dec 2021 23:47:32 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:26 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-34-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 33/48] libperf: Allow NULL in perf_cpu_map__idx
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

Return -1, not found, if NULL is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 3c36a06771af..eacea3ab965a 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -270,8 +270,13 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 {
-	int low = 0, high = cpus->nr;
+	int low, high;
 
+	if (!cpus)
+		return -1;
+
+	low = 0;
+	high = cpus->nr;
 	while (low < high) {
 		int idx = (low + high) / 2,
 		    cpu_at_idx = cpus->map[idx];
-- 
2.34.1.307.g9b7440fafd-goog

