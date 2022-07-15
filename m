Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0B575BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiGOGhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGOGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD642AC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cd7ade3d6so34035457b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AIFcnzKNAWh0YR95RoPUIx3ktwPspiMxJpZ1Mt/N6QE=;
        b=tAoOXv24XNeGrIuZy5uSSDVCq+whkCi6tEGfJKUs2NmibJmoMfvnVm8T4+4fsSmQlm
         xhDEIYLCfmw6yvc8441Y/IqzpaO6JFecGpsi3F9lUBma6HZlU8hQxnSUjjvK8zCULQQ7
         CnWmzDivXc5Ny8DBgI2t8Z9qNiDfQK+rSB1khBFTsSY97K0k1BMXANPwVwI1bxtEY2eA
         uu1ONU39e1e4fcBxpZZ88MMkB5CMqphmcszTKRgnOyed/YBeHadYpzqTR+jyeWgHL91j
         eQcyPRU92d71zNhZje5IC/wIEfroEwLhz0u2O3AA4C4MTiCrQ1lZE0E7Br1Eq3jitqjB
         VDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AIFcnzKNAWh0YR95RoPUIx3ktwPspiMxJpZ1Mt/N6QE=;
        b=nWPJhGusKSZXvvL2mug3W9W+75Dt0R+w7g4wQrcq8BVSLlfVluzMvMk9flotgCOlpd
         dO8DbE3QXtelq+Et3/LZVCj0Rf7WCU4UeXXDczY4QpEY79mdMYi7CUVcFWoiPBGLOGuk
         xOqzMxjnfpzs7uJy5x1zdmSBgpyxtCo+xQoieei2AMQUGHnDx53Cxi41yYJeQXJeKXeH
         zgH/uNWxiTihg0nFPOVBBrGSmQsIcsQuSqg2DQMSvy6ETAbm7PH3UyxTSRRPh/qlQ/d5
         p8DT3VDlyu0RjCsRSXyL/7NSUoZxvAN8J9vKlH3mE0PLO+STv4XuWDyffVFGL9mI6GXR
         CoLA==
X-Gm-Message-State: AJIora82lx/QG9N3zWtPG8TlkIlbtgqO+CJfeIKqVSZJSns/JhpatZzv
        f/AwbZDh/0lqKl7yV9G0WytFbE5tQ0kX
X-Google-Smtp-Source: AGRyM1sGwfLX6O3C9IIcZXOvrN6+z5zcDfJ6paIRGF7rJMxYkEiVPmP2srQ+IH4qJg1M74aota/jWW+kQjjv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a25:d96:0:b0:66e:2d0b:1d45 with SMTP id
 144-20020a250d96000000b0066e2d0b1d45mr12695121ybn.163.1657867033605; Thu, 14
 Jul 2022 23:37:13 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:38 -0700
Message-Id: <20220715063653.3203761-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 00/15] Compress the pmu_event tables
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

jevents.py creates a number of large arrays from the json events. The
arrays contain pointers to strings that need relocating. The
relocations have file size, run time and memory costs. These changes
refactor the pmu_events API so that the storage of the pmu_event
struct isn't exposed. The format is then changed to an offset within a
combined big string, with adjacent pmu_event struct variables being
next to each other in the string separated by \0 - meaning only the
first variable of the struct needs its offset recording.

Some related fixes are contained with the patches. The architecture
jevents.py creates tables for can now be set by the JEVENTS_ARCH make
variable, with a new 'all' that generates the events and metrics for
all architectures.

An example of the improvement to the file size on x86 is:
no jevents - the same 19,579,104bytes
x86 jevents - ~12.5% file size saving 22,088,944bytes vs 25,235,048bytes
all jevents - ~15.8% file size saving 22,821,896bytes vs 27,106,648bytes
default build options plus NO_LIBBFD=1.

I originally suggested fixing this problem in:
https://lore.kernel.org/linux-perf-users/CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com/

Ian Rogers (15):
  perf jevents: Simplify generation of C-string
  perf jevents: Add JEVENTS_ARCH make option
  perf jevent: Add an 'all' architecture argument
  perf jevents: Remove the type/version variables
  perf jevents: Provide path to json file on error
  perf jevents: Sort json files entries
  perf pmu-events: Hide pmu_sys_event_tables
  perf pmu-events: Avoid passing pmu_events_map
  perf pmu-events: Hide pmu_events_map
  perf test: Use full metric resolution
  perf pmu-events: Move test events/metrics to json
  perf pmu-events: Don't assume pmu_event is an array
  perf pmu-events: Hide the pmu_events
  perf metrics: Copy entire pmu_event in find metric
  perf jevents: Compress the pmu_events_table

 tools/perf/arch/arm64/util/pmu.c              |   4 +-
 tools/perf/pmu-events/Build                   |   6 +-
 .../arch/test/test_soc/cpu/metrics.json       |  64 +++
 tools/perf/pmu-events/empty-pmu-events.c      | 204 +++++++-
 tools/perf/pmu-events/jevents.py              | 478 ++++++++++++++----
 tools/perf/pmu-events/pmu-events.h            |  40 +-
 tools/perf/tests/expand-cgroup.c              |  25 +-
 tools/perf/tests/parse-metric.c               |  77 +--
 tools/perf/tests/pmu-events.c                 | 466 +++++++----------
 tools/perf/util/metricgroup.c                 | 275 ++++++----
 tools/perf/util/metricgroup.h                 |   5 +-
 tools/perf/util/pmu.c                         | 139 ++---
 tools/perf/util/pmu.h                         |   8 +-
 tools/perf/util/s390-sample-raw.c             |  50 +-
 14 files changed, 1128 insertions(+), 713 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json

-- 
2.37.0.170.g444d1eabd0-goog

