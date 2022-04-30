Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577C515ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbiD3G1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382206AbiD3G1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:27:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7896FCFE7B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f84aeb403fso86609797b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b34dyzAkv3FpeidZX/hRwae+MMN4Fpbu6ur7DPv1sVY=;
        b=hfLIL3a4Zhyyg3Nc2LxQ8wkrEYWraDLuY33gtpHXcSjAROtxwWSNuXWNoYgOgSw20m
         0+DB+YjgUYpjZQXDSb+TYy5nApOeR9ChnhcPR77D52Jb2xiCS6gr39wJ7BuA5lUpW7S6
         2XQXEigKXZNKefV3Qi+NqtplyP6VnyHZYvloh1lRlrGViDW3qdXXAAX6WqeuNBA4M+Ef
         x+n/WqFMozmxM0KnfddJL0rzgoTTpUwa9dnjG7T7b8xwlmNLekjz+hWYmb21LKC9UbXv
         sh0fHsDR/BqKByFiaxUF1xnIuh+7znh0ApsYAmYS2rKsdJCuj04OFbYLsXHyN9vtRrSK
         HdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b34dyzAkv3FpeidZX/hRwae+MMN4Fpbu6ur7DPv1sVY=;
        b=399v+YmEkM12YV/wbRS0qyByxitMupW2Amh3zSUKL+2tqEddnIvz+G8ZNoD5hNiSL/
         mYxTJHVmdTGdQcb6rvZ3dZUsI1y3kVHISxf9p8oDil6jHaUEkEsKniCEnu8XRuak4Nk6
         b47AP/VEWi4gEDqw2gwzWaiG6B9hNoTTgohmtTocFWb0Nkxy5De+XI9tD5NWPYrKjWSj
         hxcoXKBBg6SOQWDl1KzxUalPOmET4litAPtRU+/6Gswmhws5hNFpT97OE0U0HHzWJOJI
         v2ggJ1ePEFpqEY6lZNI84H/Bp11G3NOlLn07jkaqyO57AFxMgG4AAL621/8U1s2cVNOT
         wMYg==
X-Gm-Message-State: AOAM533OZD9OelZyhxkNEl62jqJiYLt+vJQmdzt6jv7Ushi/SQPLODG1
        JIsu2QbnEp9qmAJOsEfBpPG0AVLCEJQ8
X-Google-Smtp-Source: ABdhPJxJRQJNZzDBHJN5YDt1lFxHqwUQLyivISTont2ekEDl8igflw9m4NtiuFCJeFVuGHhCDiRVX/QeMkHf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:df8a:0:b0:647:4954:83e8 with SMTP id
 w132-20020a25df8a000000b00647495483e8mr2482748ybg.526.1651299822443; Fri, 29
 Apr 2022 23:23:42 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:23 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-6-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 5/6] perf evlist: Add to user_requested_cpus documentation
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document a key use-case in propagation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/evlist.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index e3e64f37db7b..74541bd87aa9 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -21,7 +21,8 @@ struct perf_evlist {
 	bool			 has_user_cpus;
 	/**
 	 * The cpus passed from the command line or all online CPUs by
-	 * default.
+	 * default. For evsels with no or dummy cpu maps, this cpu map replaces
+	 * their cpus during propagation.
 	 */
 	struct perf_cpu_map	*user_requested_cpus;
 	/** The union of all evsel cpu maps. */
-- 
2.36.0.464.gb9c8b46e94-goog

