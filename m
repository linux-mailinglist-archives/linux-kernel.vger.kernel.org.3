Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813CC584837
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiG1W2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiG1W2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:28:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FDF79ECC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so27462767b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ETr0ImHhwUdJX2BkgmsBul/UHH73JiSQwKeA9GsTDe0=;
        b=RT02s468km4lLI9wYrRupqP5panMrSRtmFOmilNZOnKYGxIgV//8B59ZaEwcudiuhH
         ZQuyQR4Gn8rpYmORnAEwGNk6lxCTt6YqFO9D52w1yIuhxxfdvA9MheEcKR9w6+x9L+/X
         a8l8mNWkbXVfp17MgzRMC9JXzEP7IlSacLxjLeTtkGmy3nTeIah/OkHbgWse38L5Uu18
         rAycKGCNxDl0uXP+Xgty6D1ztsJ7l7HqnhWoiWcL3o3h7o3RFu/emxmW3jt9qJ4JAFxq
         8HXcns8C3sDF1NnrysKyaB/mPgXXSqoXoDXF8FqQoBeQOO7GlEYTn9MvIji1lH9OLBC8
         A/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ETr0ImHhwUdJX2BkgmsBul/UHH73JiSQwKeA9GsTDe0=;
        b=l8+Lk8IOD9bXiwiJ13PkTlNRAj2SXNrYCI2ktXfjHjdZ14bMaH9QRkOIyx1rObw+QG
         gZoO3Ow4JljKbygye+Nj+DgxiaCpGrYac+Y6uX5czhxw8ERdhOsSr68YXpAWyIr5Ohtp
         4a0TEfZPZw3fLKDoPBtLNBE9K7J0osu4qeglHnsysTQfkngyrlj47b0SXDIBcEiSlPOS
         dZ/0+Par4ACfq0gtjKVSrKdDOb+EiGq6CAshQq9V05o/Lc+PfG/GzN/zxYVrOh8jcBLv
         1ATuwyxz+s+IYf6BsuHf0iTUzr296x3qKQphqOxgtRdM4GhZdo4CxuZX9Hx0x7pwST/5
         yW2Q==
X-Gm-Message-State: ACgBeo01sDWc9VkJk6K+QToXZeeaxdwvBnUh9mM6ky8KmPYRmiKKoqFb
        BKFE31vEVYP2XhuVLE9saChrSXpJYM1R
X-Google-Smtp-Source: AA6agR6HP7ek8z/XQavgHza6DQ1Q8SZSFxK/sHeUkjT0cmIJ2DbP2xQyJTxjwiVuy7pC5/UuoQWCobzDIKsa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a25:f50a:0:b0:66f:4f74:1417 with SMTP id
 a10-20020a25f50a000000b0066f4f741417mr642286ybe.64.1659047319851; Thu, 28 Jul
 2022 15:28:39 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:19 -0700
Message-Id: <20220728222835.3254224-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 00/16] Compress the pmu_event tables
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

v2. Split the substring folding optimization to its own patch and
    comment tweaks as suggested by Namhyung Kim
    <namhyung@kernel.org>. Recompute the file size savings with the
    latest json events and metrics.

Ian Rogers (16):
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
 tools/perf/pmu-events/jevents.py              | 485 +++++++++++++++---
 tools/perf/pmu-events/pmu-events.h            |  40 +-
 tools/perf/tests/expand-cgroup.c              |  25 +-
 tools/perf/tests/parse-metric.c               |  77 +--
 tools/perf/tests/pmu-events.c                 | 466 +++++++----------
 tools/perf/util/metricgroup.c                 | 275 ++++++----
 tools/perf/util/metricgroup.h                 |   5 +-
 tools/perf/util/pmu.c                         | 139 ++---
 tools/perf/util/pmu.h                         |   8 +-
 tools/perf/util/s390-sample-raw.c             |  50 +-
 14 files changed, 1135 insertions(+), 713 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json

-- 
2.37.1.455.g008518b4e5-goog

