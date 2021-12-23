Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053D847DFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347573AbhLWHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbhLWHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7070C0698D1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d205-20020a251dd6000000b0060977416ad4so8519191ybd.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8dsbS5qNAaZwjjgso/tH43ZBCOZXMegiAB2IxZGAtxY=;
        b=PQhAtMAARGULqWwBTpXr3yXhs2ODyw/ITTTon4PBCLboBEqbgmDaHbmw4c6nePmtTs
         uAGCVnve4qdC3HB0ycP8Ffwg3laRq/3wRwQLITuj/NM6ljjzWyV2PuZsqKjsoKC7P0vV
         CxBdrtKujfQ5fKSG12PNfMvK51kmg7PJKeTxB2Hem9rrLzH2ujPUhnK3mh6yxmxEsRBt
         nJSUpYWHia6Jmf9ZYIq1Q4OHllCwz39+BFSwFa6deXzEI6bD2zJdbCJbhwaJNV7xH/7D
         1AQmqj0XFlL3Nzie5Ah66Swk9U5RR578skOC784re3hCuU1+PSmz32lI/J8gkXrBWiRr
         HBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8dsbS5qNAaZwjjgso/tH43ZBCOZXMegiAB2IxZGAtxY=;
        b=5oVY5rcxvur8nWjNjQ5vxZqxAxS1C/MtcC2L934yxZ/754ucicucGdFuqZSdFQQb5a
         DHdnhPDkBs60OaPw94X9M/AsQZ+Ukexn6Sf/QnHsxlf1awRM+DOdh50Jt1n8wz5q8xu5
         zUrcz8DKPiTlTBixCccq/rmzz0kSzSRyazu/QrJThVYigCCAvM60gAqb0TLvfXFjJpat
         88nOIAKwDHAeUanC6mnpRhN6GGMC4FSfaoEQH1WlxUHHwpnDjvJlbRSwjSQwmIaZeiwj
         DrRMghdC3i7bpXirlM1hYx0Ge6Pwdzygbt371Y51lZIbfF8nOpntatKxY2OeRf0bNXV5
         fuUA==
X-Gm-Message-State: AOAM533wCqD8VOFz8grTZfWaDukCzWZ6t7dbt3b8cOZAN4yBC2NY7qZo
        gQ80mEE5bGM0JizXxeouHRHuauR6o5EY
X-Google-Smtp-Source: ABdhPJzWqsoRQMCzJi9y2FpN5S2sgEEMwklh3mJKbN+pS1OAmbSTCoL/av3GIvKVh+8AzLIV6l2ui3xlohJr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:d743:: with SMTP id
 o64mr1575188ybg.81.1640245685068; Wed, 22 Dec 2021 23:48:05 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:39 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-47-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 46/48] perf script: Fix flipped index and cpu
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

perf_counts are accessed by the densely packed index.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index af06fe1271cc..de4af7af34c8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2129,7 +2129,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
 			struct perf_counts_values *counts;
 
-			counts = perf_counts(counter->counts, cpu, thread);
+			counts = perf_counts(counter->counts, idx, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
 				cpu,
-- 
2.34.1.307.g9b7440fafd-goog

