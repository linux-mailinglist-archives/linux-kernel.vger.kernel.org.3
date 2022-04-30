Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA1515AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382176AbiD3G1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241361AbiD3G05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:26:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B15CFE43
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 7-20020a250c07000000b0064137917a4eso9166337ybm.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qM0CcLJJrKpW2Wkspbw9oc4+0PMtIaoOGCh2yb1+c8Y=;
        b=VBOkfSXM46pJ80dgupLJN/D1Z7T4yXWGOJ+DI1vGk++6kp1gHBu561dvEsfHpL5o2f
         7wiKW8+aiHaP+tw9Vc/BpMDSEtzCsCQUrc/SFTRggF4GHyZ2stzGv2Pe1hJpYg0uGJSn
         tB7jYNqDPL+x7qRlKddqqk3hZnQU9/O59T9eBocCbDUDIYsscz5b8RlIPoVS6gKUoYOo
         LsRcFKjlm22Tqo1jSDyrWsEevSiiOYcAgJZ6mcKSuF+1e1SOe+iTlqhDMTYDc8F4R659
         hIPKUlZNRDKRI5ijUWBupwo5z/zVsb7qjGmsgfxL5E+IPP2XJgt2W3sxeAdrF5oueksY
         024w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qM0CcLJJrKpW2Wkspbw9oc4+0PMtIaoOGCh2yb1+c8Y=;
        b=xLMooxB/2QJlxEG+keQ6gbUDgoVipTzV1/CGyovcwMBWWyFWTeyw1hvvhyvYazFatN
         sMH5wz6uu9QFOFKBMJMCGllxAOEfqr9G8hIA/HaNOncpvJFwSAS4JWpMZCbmD+turt5d
         r3EDFPZwtvCKlZPWGlEds9BkvSfWnQL0yK7IKl2gdTQsTQ6phgt7Z4HwnU59azgC7soP
         oYhoDAq30ZnN8IncEoaeyjdwHokT7A0DFuLA+kFSPTJBvCWIYfiB41ro7tRlEJHoR7UX
         HEI4pCIAxO05hEg9UnEwl7Uqf4cXsrhx6/zQnG0sECrKT4Oi3+J14qCyVLCHqvmwHMkM
         Vgcg==
X-Gm-Message-State: AOAM5311LBVHmyl0KGnqWCtfG3m8AorEGq14tdkv4fWp97bFCMEwpQ5k
        My9U6e/4JFxagd/X3JkCptLkwuiKTHSZ
X-Google-Smtp-Source: ABdhPJyJgzcdDR0Vabh1YpL71QKZ80jgYwvO35Fkq3RG6FcWK2FDtt70eli+OZlIVxeHRUcVSfpDNWMn1I1n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a81:7b05:0:b0:2f4:e45a:b06e with SMTP id
 w5-20020a817b05000000b002f4e45ab06emr2725986ywc.458.1651299816033; Fri, 29
 Apr 2022 23:23:36 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:20 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-3-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 2/6] perf evlist: Clear all_cpus before propagating
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

all_cpus is merged into during propagation. Initially all_cpus is set
from PMU sysfs. perf_evlist__set_maps will recompute it and change
evsel->cpus to user_requested_cpus if they are given. If all_cpus isn't
cleared then the union of the user_requested_cpus and PMU sysfs values
is set to all_cpus, whereas just user_requested_cpus is necessary. To
avoid this make all_cpus empty prior to propagation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index a09315538a30..974b4585f93e 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -59,6 +59,10 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
+	/* Recomputing all_cpus, so start with a blank slate. */
+	perf_cpu_map__put(evlist->all_cpus);
+	evlist->all_cpus = NULL;
+
 	perf_evlist__for_each_evsel(evlist, evsel)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
-- 
2.36.0.464.gb9c8b46e94-goog

