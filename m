Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5C515AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiD3G0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiD3G0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:26:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADCCFBBF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d22-20020a25add6000000b00645d796034fso9173833ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ilFEwIrkZL4LC9Sgb4TefT5GSI3sDjL/JSRtfwvlYk8=;
        b=XKxfKiZWKR26TghXaE9JP/9B5Y+sDfK8pIqWwQVnmRr6tCybeUfbhZjxRpo0ucJoo/
         HTpIgSk64JCRj/FOflHY/fZXfzW6VC7cvQ2zlrJLdJlWGheLb9PgBsTqCzpB6JL1UG9j
         vGRXPlYkNgQO84nOlc6SdulmwuBBYiL1lGrgt6Y0K4GvsTvEIMF6bUwMy1DSQ1VjSZrV
         q6dc0BEbETWghfoSGWwNDCXUZCr+fC0Mswr9CRsnJZNJ8ENNnMsRGY/KifCHphJHTfJY
         VfY1dZQOk620wlICkjZiha3wuTpC/d5dD+5+YUFXQmFc/0smlYICvBuJmuYb7X18BmCy
         vCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ilFEwIrkZL4LC9Sgb4TefT5GSI3sDjL/JSRtfwvlYk8=;
        b=lVkECVIrXc6kpQQrjNa5GTr5uOJYnlQQefASuf0niDnLIuu/I1Ftm5YjR1qzP0sbeW
         Wt6u3lunTvez2U4JpUtWOzFhhQTBU+8RA5po1Ow3LI/QVUjUbPfHdyky62prrNVPhwNG
         HYxfm/X0xqxcQZ4DLJD2rNw0gxfnnu3H1PnrPxU34gOJTimLU16irpD004o43WD4Y/rS
         s46Dr90nThcT1w2TXd1n6zulNKYF/JNsSUyFL6vvuXpCkr1//2C8va1Sfkec3CMFLbSA
         y5uGhzz6nRmdeHvB2X6J3z5whv2HqNKKJP/NEGY7jonLbG/wcYM53buWzzs01MzcpUnR
         fHLw==
X-Gm-Message-State: AOAM530cbwRN28/dQ1ZKnFChUL0hxpF+dqSqjh+q1HvlCvblQpErBiN8
        gRHHMS6uqLp2/qT+kZY1dHByBnIEcW6p
X-Google-Smtp-Source: ABdhPJxVabPnLRHKvnLALt55nPTm67ZCtR+e4Nldv4elgYdhSGX2Db3giMv00gcSHR4wcL9mKDMfLYiP6UHF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:6a05:0:b0:648:f6c0:2c19 with SMTP id
 f5-20020a256a05000000b00648f6c02c19mr2504236ybc.55.1651299811215; Fri, 29 Apr
 2022 23:23:31 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:18 -0700
Message-Id: <20220430062324.1565215-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 0/6] Make evlist CPUs more accurate
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
is removed and the merged API left unchangaged.

Ian Rogers (6):
  perf cpumap: Switch to using perf_cpu_map API
  perf evlist: Clear all_cpus before propagating
  perf stat: Avoid printing cpus with no counters
  perf cpumap: Handle dummy maps as empty in subset
  perf evlist: Add to user_requested_cpus documentation
  perf evlist: Rename all_cpus

 tools/lib/perf/cpumap.c                  |  4 +--
 tools/lib/perf/evlist.c                  | 14 ++++++----
 tools/lib/perf/include/internal/evlist.h |  5 ++--
 tools/perf/builtin-record.c              | 13 +++++----
 tools/perf/tests/cpumap.c                | 10 ++++++-
 tools/perf/util/bpf_counter_cgroup.c     | 35 ++++++++++++------------
 tools/perf/util/evlist.c                 |  6 ++--
 tools/perf/util/evlist.h                 |  4 +--
 tools/perf/util/stat-display.c           |  7 +++--
 9 files changed, 56 insertions(+), 42 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

