Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682AA5A68B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiH3Qs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiH3Qs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:48:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98121B657E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:48:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x27-20020a25ac9b000000b0069140cfbbd9so170682ybi.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=bqWWElpifsVIcRBtLS4h3nAno3DuqAdm5MwVPcG6g2U=;
        b=ohH04+bmBKg6/u4gjhGe4ql6BSMCMzp43mE/vQ1+o8MMfyn3LexUr+otcCJbGXxt5B
         zA73E2gOIwAro0XcudubwXtWJQ1gxhBUgP9JjDi1EPaaK6hwxynzIh4VAsPdb8NmnwLk
         YabXxaYmQb5CeozvGL/q3XcX7nXBzmeY2HPERul/OKs/ikAffbgglH2fGF+HbIkAbhYM
         4F5Cs4d0d/v7fiWbf3yKGY+ER5IDJ8jxf0E6R3oK+Qoo9tghgwwY2E2PrxOnqaEc4Axg
         ITTNacw061mfcumS7EsJDub8SCVYbVvwpbYkKgtSlJLu2B0FGKZUJEYHwD9Nian/1xgv
         ZdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=bqWWElpifsVIcRBtLS4h3nAno3DuqAdm5MwVPcG6g2U=;
        b=dLB8aj6dO7FCCdFLI8HW8RNW/x0Tz73Fs+DCm+XyUWsYQgY6NxXgiJvyLK34MMGzcX
         PV1FhcGyMMrRzs5VwsuWjHNHTgC+jStfc6xbvWO1u+oXE8CgKtZo2AlLdJb77vgsVy5Q
         WyKSU5TeVj2h0VqdUA5uQkH3JN+9+VT+cJeQ7EI/oxSnuCWsRwVGsHsGb+7//223tVSI
         MlzqqnM42gsT8GChTQZA4OV86O8hhGQoHnolOvTZalxZGAuSlk8UxDkF9f4wF8nzitbF
         OuIJsdsC+ieO0dCfpD5u1Tn/4sZ0OHI/vB/nhXWTz5y/m9ahPyvVsp0+KZ+0vy9wRceb
         VpRg==
X-Gm-Message-State: ACgBeo2c6VHtQdjerrH35DSp7RLT7Yxb/AVQohTMdHUsfTcl8hp10xju
        QMJHOza/1bsUZUhAYR73juuQ3H48auEi
X-Google-Smtp-Source: AA6agR5HYPGdfJCmFz6kSepJum8lO1auKcPBMGIAOUdWwb2wB+i9kNM7DUBx1cmoh+TCIyRIFxNSFW2DxAmz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a25:db48:0:b0:696:4274:477b with SMTP id
 g69-20020a25db48000000b006964274477bmr12234993ybf.146.1661878135792; Tue, 30
 Aug 2022 09:48:55 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:38 -0700
Message-Id: <20220830164846.401143-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 0/8] Add core wide metric literal
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com
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

It is possible to optimize metrics when all SMT threads (CPUs) on a
core are measuring events in system wide mode. For example, TMA
metrics [1] defines CORE_CLKS for Sandybrdige as:
    
if SMT is disabled:
  CPU_CLK_UNHALTED.THREAD
if SMT is enabled and recording on all SMT threads (for all processes):
  CPU_CLK_UNHALTED.THREAD_ANY / 2
if SMT is enabled and not recording on all SMT threads:
  (CPU_CLK_UNHALTED.THREAD/2)*
  (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )
    
That is two more events are necessary when not gathering counts on all
SMT threads. To distinguish all SMT threads on a core vs system wide
(all CPUs) call the new property core wide.

As this literal requires the user requested CPUs and system wide to be
present, the parsing of metrics is delayed until after command line
option processing. As events are used to compute the evlist maps, and
metrics create events, the data for core wide must come from the target.

This patch series doesn't correct the Intel metrics to use #core_wide,
which will be done in follow up work. To see the two behaviors
currently you need an Intel CPU between Sandybridge and before
Icelake, then compare the events for tma_backend_bound_percent and
Backend_Bound_SMT where the former assumes recording on all SMT
threads and the latter assumes not recording on all SMT threads. The
future work will just have a single backend bound metric for both
cases determined using #core_wide.

[1] https://download.01.org/perfmon/TMA_Metrics.xlsx Note, #EBS_Mode
is false when recording on all SMT threads and all processes which is
 #core_wide true in this change.

Ian Rogers (8):
  perf smt: Tidy header guard add SPDX
  perf metric: Return early if no CPU PMU table exists
  perf expr: Move the scanner_ctx into the parse_ctx
  perf smt: Compute SMT from topology
  perf topology: Add core_wide
  perf stat: Delay metric parsing
  perf metrics: Wire up core_wide
  perf test: Add basic core_wide expression test

 tools/perf/builtin-stat.c     |  57 +++++++++++++-----
 tools/perf/tests/expr.c       |  37 +++++++++---
 tools/perf/util/cputopo.c     |  61 +++++++++++++++++++
 tools/perf/util/cputopo.h     |   5 ++
 tools/perf/util/expr.c        |  26 ++++----
 tools/perf/util/expr.h        |  14 +++--
 tools/perf/util/expr.l        |   6 +-
 tools/perf/util/metricgroup.c |  92 +++++++++++++++++++++-------
 tools/perf/util/metricgroup.h |   4 +-
 tools/perf/util/smt.c         | 110 ++++++++--------------------------
 tools/perf/util/smt.h         |  19 ++++--
 tools/perf/util/stat-shadow.c |  13 ++--
 tools/perf/util/stat.h        |   2 +
 13 files changed, 286 insertions(+), 160 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

