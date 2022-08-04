Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967B658A323
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiHDWS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiHDWSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915A6557E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:18:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r4-20020a259a44000000b006775138624fso568519ybo.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=afC7m49cjNfKDxx8SRPAftfupGqIsHHSQyDvra4Q74g=;
        b=CqW4EiBCmYXpfUtrQRvcQaz5Q4DGGhdN8MMUkCCndOkLlx8ei6pVCaZSYTdlIjdqs4
         pOcgU3gQ3sPQQ1fLCsSFzE3hz7bAabNShOANl77wHOJlKRCzRBQtf77Z8/r0t4elcdh8
         I76XePBMLGTX6JOW2gZRcxNxrccF7UuxBqc8+GlBRhSE0tWOC///k90zNhLJyhsiDBSo
         0uMP7Cp1fe4JNXOdaewLAJCdoEGRe6h/jGN+MTbLEwALYHT3W2oZGTK6qt28bHpOpcMQ
         gKF2f2qZCWg8HAnm4Z1TTmx/wKKZ+/+UvSYcpmbMqH6slpvlE2EfXUb8vp3ZoiGDwPS5
         IXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=afC7m49cjNfKDxx8SRPAftfupGqIsHHSQyDvra4Q74g=;
        b=H1zsYnzHQamcjA8jCyLD1jO5cyUgvqHr8WO872TtNQibyfscbkJjdEbxACf5RUAUVv
         1hDtRCARUopI6474KUdPSjId/cQwSEAAS/LKKu+hOt47ztesRBpX7//Q9EespYOiokwJ
         zEPYphsE2SJnWXVGfShHaY4cAs36c1VX9NF05PL4zBlr5L/fatcz8418Nwp3mi0VLYbq
         3wfxPk2qsxm5GyzFluLiKgCgJZO9ZiJFuq/32wtGe1tmnKHjxuyFnnc/t65T0qKN3+tQ
         p15kfYvvcFDpC5KQ/ZMArd6D4u2Z0Q/ZSkTyyCkba3XYunC5fuP7Hc0rfItKg0uuQ/nL
         8Dhw==
X-Gm-Message-State: ACgBeo21cUyNjt7F90j6z3J3J/lM+YboopE2kDLVc1w7mCtFKiPM6sjK
        /tWqlslmPhqCLO0noGrL8/vQHLBdQyYK
X-Google-Smtp-Source: AA6agR6UoJ/B+2t1DjsHDMitDONdMTz4cKVsLmeoKn5GZnjn7ld+Z8DVU59sOS/S/vjvdrH8gamESJxt0Cpy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:e90d:0:b0:676:b468:9902 with SMTP id
 n13-20020a25e90d000000b00676b4689902mr3178382ybd.379.1659651502489; Thu, 04
 Aug 2022 15:18:22 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:17:59 -0700
Message-Id: <20220804221816.1802790-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 00/17]  Compress the pmu_event tables
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
no jevents - the same 19,788,464bytes
x86 jevents - ~16.7% file size saving 23,744,288bytes vs 28,502,632bytes
all jevents - ~19.5% file size saving 24,469,056bytes vs 30,379,920bytes
default build options plus NO_LIBBFD=1.

I originally suggested fixing this problem in:
https://lore.kernel.org/linux-perf-users/CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com/

v4. Fixed an issue with the empty-pmu-events.c spotted by John Garry
    <john.garry@huawei.com>.
v3. Fix an ARM build issue with a missed weak symbol. Perform some
    pytype clean up.
v2. Split the substring folding optimization to its own patch and
    comment tweaks as suggested by Namhyung Kim
    <namhyung@kernel.org>. Recompute the file size savings with the
    latest json events and metrics.

Ian Rogers (17):
  perf jevents: Clean up pytype warnings
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
  perf jevents: Fold strings optimization

 tools/perf/arch/arm64/util/pmu.c              |   4 +-
 tools/perf/pmu-events/Build                   |   6 +-
 .../arch/test/test_soc/cpu/metrics.json       |  64 +++
 tools/perf/pmu-events/empty-pmu-events.c      | 204 +++++++-
 tools/perf/pmu-events/jevents.py              | 495 ++++++++++++++----
 tools/perf/pmu-events/pmu-events.h            |  40 +-
 tools/perf/tests/expand-cgroup.c              |  25 +-
 tools/perf/tests/parse-metric.c               |  77 +--
 tools/perf/tests/pmu-events.c                 | 466 +++++++----------
 tools/perf/util/metricgroup.c                 | 275 ++++++----
 tools/perf/util/metricgroup.h                 |   5 +-
 tools/perf/util/pmu.c                         | 139 ++---
 tools/perf/util/pmu.h                         |   8 +-
 tools/perf/util/s390-sample-raw.c             |  50 +-
 14 files changed, 1140 insertions(+), 718 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json

-- 
2.37.1.559.g78731f0fdb-goog

