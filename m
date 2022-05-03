Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594FD517C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiECEWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiECEVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:21:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25F3CA4C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 21:18:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f16f3a7c34so151109777b3.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 21:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b34dyzAkv3FpeidZX/hRwae+MMN4Fpbu6ur7DPv1sVY=;
        b=dLAMg9xp1Bq+8oU3LmNvjKFIrXLGRCu8ItgNKNl0yBRM/IPgPUjZR4T9cwl4AjprKX
         VH2eP91Vr9upMXDatSrCR7UCNj+lSpjaCv/Q6bGAzT4okUalpNpTa4OQ7JEh7PQO6nS7
         XJoxtC1aL/9MLXcCnlh9iqm2wqoTb1C7IDB97XRTMQhHCMFJadDYzRBqRpv2A+Ot/Muv
         dHlAdyMc23yT/+tjQCHZzD6WBXnVUVfoCYXXfHFt5eeNNzbdq+iMvYTa7dkVy16dCqs1
         2/bM4Jr69/xn/SONvckwuQpya2n84ceLgapNYrSDvgCX1OrMfqfImxGEuz8M6N6cpQOA
         e+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b34dyzAkv3FpeidZX/hRwae+MMN4Fpbu6ur7DPv1sVY=;
        b=7vaSdidLPfHiV6rKPg6xIAAgS9ghcPmjFGNj+374BJRucR5+moqnf/B+0xeZ6Sd+sV
         M8T5aZW4r3PuRD2OgO7Q7Pe5TNcWp4WsmQNChsHlkRtBgqsNB9MNMqZJ4RXTbn9kOkxl
         RHrKSxIIfBhnsMHnYrh7bsEYq0jbgdVzBOixnqBlPeEBHIl9H/4ChKgZUWaM9DE8cqjA
         LoN5G4sGzx5aWcE1U6zE4QsBzDRxkHdXEExZ7WEblROW2qTJyRnbIrPNLwqF2N2xA0vD
         PZEdOBprbdZk58aKo/RZP0HmQwWMwFlP24GDX/WP2cN/cRriODjISkjl2AKUXpE8QFQg
         zWcQ==
X-Gm-Message-State: AOAM530rAu3E98nJadVbF/D95lg+8H2TZjgAwcGBGKeNWGVSHCE8QoDG
        5WqBEiC4sRoOUPqX8KPXn4wiIQ6hJsZ7
X-Google-Smtp-Source: ABdhPJyoF2H6Ud94AgIlUYETrlX7d0C8Y18ge1BtOFYyIMXyyoBHWH5yQIbJtH6V5bU9IQmL3ldGrs8QkD4Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a25:250c:0:b0:645:781c:3ec4 with SMTP id
 l12-20020a25250c000000b00645781c3ec4mr11902163ybl.143.1651551493698; Mon, 02
 May 2022 21:18:13 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:56 -0700
In-Reply-To: <20220503041757.2365696-1-irogers@google.com>
Message-Id: <20220503041757.2365696-6-irogers@google.com>
Mime-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 5/6] perf evlist: Add to user_requested_cpus documentation
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

