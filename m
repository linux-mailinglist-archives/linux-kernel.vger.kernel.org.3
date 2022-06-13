Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097B548215
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbiFMIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiFMIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:47:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A4EE26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q199-20020a25d9d0000000b00664af83bee9so2584721ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+TZFSQCPo2Ju+GzmGovbnxDwp60NNa1c3IUVi64MUwE=;
        b=m2G85oiUaIgx7yZjFlW1pWdakJHDEGzddu/k0tEqME2rscMJFMI+H8NuW+pc2shBsH
         BdMeTQCNahkzQAHbQu0AvzTcS9EMNjYttG0/RVkKMRqW55ssuntWP4JwNXrDGgiV1cvF
         bxzbInrxhDHCdhv2miJwkekNpQh5of+v9yCy1kfT1sunfMTjEKrb2yOL6/ow+9gQvq9D
         nZSfWiYAeeL1l2iwCzw1nEulcFpTO3k/ilDtBfmo3Zrv/0Qa+u7iLcZExFfJ+P3Ib73g
         sDf0qnD83q+5lYDQ/WdIVjOX/ZDkElteX7LHSuahBInWSLVLPT2kfBzM438uOK5s5bNO
         fGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+TZFSQCPo2Ju+GzmGovbnxDwp60NNa1c3IUVi64MUwE=;
        b=Y97+SlQtLmzgNamvm2XUQyrPQxfo0XyLL/0Ady/O0NFEEGmOixW1C/boWB2qv+snxy
         06NTEt+FWj2bRnzO8RPiew/Cw6gz5lX3Azg6Nx0f2r1LoHPm0Yq1MWKzmNFsaWCJt2kv
         5H4HDchbLXGIq4BH/zhH1Xoac2WcLzF0/UhbVphWtP9LhIBY+7o8xmIhq7ouxsGfmJWI
         VsdJpRNXcGl7HEphTbxOckOjZoZNQpmbavhI94QpTUOqM34yARuhd25MIRbKcm3xnJGy
         HVWraoMzTElN46mCHA9E2AxR0ooiAiOtLwTreB1EEPmDVuAGMmJ2tZF6ivcRaijhpPPN
         fUFA==
X-Gm-Message-State: AOAM533EzlLNr3xJSO/TIq0YF0Eb+ShdGu42XH476s3994KikjGPEWFd
        17SNvw7n9wp8jxvK3jJlwwKMPnZ86S2V
X-Google-Smtp-Source: ABdhPJwSSqRhSBjwM5FE3KlSNKSPK1Bh8G9cCaBSGRqGDpSFwbXBYZ+bGM5GWkMHxTj+CRVGZ7NhoZp56Ncl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1256:a8b4:594a:9164])
 (user=irogers job=sendgmr) by 2002:a25:e68b:0:b0:65c:7aa5:f901 with SMTP id
 d133-20020a25e68b000000b0065c7aa5f901mr57398720ybh.147.1655110066202; Mon, 13
 Jun 2022 01:47:46 -0700 (PDT)
Date:   Mon, 13 Jun 2022 01:47:34 -0700
In-Reply-To: <20220613084739.1159111-1-irogers@google.com>
Message-Id: <20220613084739.1159111-2-irogers@google.com>
Mime-Version: 1.0
References: <20220613084739.1159111-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 1/6] perf cpumap: Const map for max
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows max to be used with const perf_cpu_maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 2 +-
 tools/lib/perf/include/perf/cpumap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 384d5e076ee4..6cd0be7c1bb4 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -309,7 +309,7 @@ bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
-struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
+struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
 		.cpu = -1
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 24de795b09bb..03aceb72a783 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -23,7 +23,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
-LIBPERF_API struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map);
+LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
-- 
2.36.1.476.g0c4daa206d-goog

