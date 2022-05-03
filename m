Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F87517C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiECEVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiECEVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:21:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C838BFC
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 21:18:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l35-20020a25b323000000b00649eb57cc67so359562ybj.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ee22ixTfu/Bo012jZkIOZL6TsTz0iHERQm9vZ3yNsWA=;
        b=c8+KF+puppDi7Lwvw69cneahhD++zr4NEDsXpTi/mbLS2AKKBkP449Kc0H39TfyusD
         rGS7nYvVmd0IO++AvCmX3pwBA21d4FbnMDE+VHfCtJDbnWAzYuehEE/jD28a+rtTw1WS
         ux/R151hvTK6KMNEpsZMRByIeNXPleMidgeoi1A26GnIOX77Jrfjr+7cAmoaykr/XiGb
         hCCw7mEmiFsufy129uTPQh49ZFjArF4+VwTzMUBr3swQ7kiyI1lU+H6YmfdN+Q1dH0TX
         iaEeKu8mDoIgeZXpn8zCMLnup4qF04jTxjPmo/dPc/jwWPFaEaMHkx9CJXsKFdbdgtkt
         Hcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ee22ixTfu/Bo012jZkIOZL6TsTz0iHERQm9vZ3yNsWA=;
        b=S4olcj/Ul5CUJ9TAJ50Yoh4MF8l9zCN24ThXTgtbAs1lk8ms1aND4EvhAfvwc2tUy8
         5fbJLKt2Wsr0+1UuWQgpI+NWwDcfM223kLsCw6Gd8UnSiIR64Jqu75NWc2S3n7yePOjY
         xzpM4Rnn3Nt9NPD8bSkJyBUiAaHm1xV+mi3mPYJDpxBfSX7kc5RLLcx2qCAR+cvA3oIf
         2eCFivgrQRL14sFFmAO+9t1Wp96mlwIXbz8yYZhmDdzRVfPjgOfYj3OPOODd6dggOYoK
         32XWM4KB5icuwxf5VFL9qGymK29G3y0uNNkq5kofY9e7td4XusKkaObOS/ZFjdjbCswk
         T5pg==
X-Gm-Message-State: AOAM530CRJPeseXjQ7B4HsgOza3IwW9uJLlzkKJVHnO1BwelVNDU1KYt
        wCRSAx/OzT55P9geB5657yAwPgLgsRlM
X-Google-Smtp-Source: ABdhPJxBNoT4Bgk+Mh2KRGQMD1T6e9TCCImbP6hv4oF9fx/eapszNDXOvROriMl8LV1gxKC/gKQTBSZfJQws
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a25:4944:0:b0:648:a796:a2 with SMTP id
 w65-20020a254944000000b00648a79600a2mr13187740yba.123.1651551482390; Mon, 02
 May 2022 21:18:02 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:51 -0700
Message-Id: <20220503041757.2365696-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 0/6] Make evlist CPUs more accurate
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

Based on the thread:
https://lore.kernel.org/linux-perf-users/CAP-5=fVMHzTfKdpWMXtbtx7t14u2f4WzNak+F0Q93cQ7CZfhbg@mail.gmail.com/

First patch is a cherry-pick to avoid a conflict of:
https://lore.kernel.org/linux-perf-users/20220414014642.3308206-2-irogers@google.com/
Second patch makes all_cpus more accurate when there are command line CPUs.
The third patch fixes perf stat metric-only output for uncore metrics.
The fourth patch makes cleans up merging of dummy CPU maps.
The fifth and sixth patch try to make user_requested_cpus and all_cpus
clearer with documentation and by renaming all_cpus.

The code no longer needs to add an intersect function and so the API
is removed and the merged API left unchanged.

v5. Fixes the 1st patch as pointed out by Namhyung Kim
    <namhyung@kernel.org>, adds some further clean-up to it and adds
    reviewed-by Adrian Hunter <adrian.hunter@intel.com> to patch 3.

Ian Rogers (6):
  perf cpumap: Switch to using perf_cpu_map API
  perf evlist: Clear all_cpus before propagating
  perf stat: Avoid printing cpus with no counters
  perf cpumap: Handle dummy maps as empty in subset
  perf evlist: Add to user_requested_cpus documentation
  perf evlist: Rename all_cpus

 tools/lib/perf/cpumap.c                  |  4 +--
 tools/lib/perf/evlist.c                  | 14 +++++---
 tools/lib/perf/include/internal/evlist.h |  5 +--
 tools/perf/builtin-record.c              | 13 +++----
 tools/perf/tests/cpumap.c                | 10 +++++-
 tools/perf/util/bpf_counter_cgroup.c     | 46 +++++++++++-------------
 tools/perf/util/evlist.c                 |  6 ++--
 tools/perf/util/evlist.h                 |  4 +--
 tools/perf/util/stat-display.c           |  7 ++--
 9 files changed, 60 insertions(+), 49 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

