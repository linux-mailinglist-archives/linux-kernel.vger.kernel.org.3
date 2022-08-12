Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB99591785
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiHLXJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHLXJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:09:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE6A9AFD6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:09:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f58599ad3so18401737b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=xXzpXjvRspHe6EqAJ0peWZDoMV+SEU1E7aT46p0dEiM=;
        b=TyWfgnmLLl7dTdjM1raYv8gMUESt6Aj574QPgYwVLf2vMvMgGeRBcHTn4a+F28Zysm
         8+lFUYM0uTOu7+ZQHwVJLB9Q/lxTCzNZpN0Y7GhNNxsY2h+fOkEmLbE8y2pb38FbhiOb
         laHlPAo7l3JePG3RZcReoLMrHc9eLpLdqZ/Yqa8c2k895dazcC3w31dIHJg9FoHh8WkC
         Bx/EuVlH4SbyeofrDsTqVQVM5gs8WX+QhE1rzKNKVgwXx6ey6B74iZjoSBFHKj+rl9M+
         EuxyyDdzqcAczAAb5Mj5p5QdIRbDsg0A42yTkz6ui/7K8LZ01ncIH/72NV/G+EewbS0i
         H8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=xXzpXjvRspHe6EqAJ0peWZDoMV+SEU1E7aT46p0dEiM=;
        b=mLvewQOFng/DrZkmqY+168t0C+/TynR3C7feDIENNXNQy9onroS6JzWBgj2YPf9Kwk
         7vO7fEuzVCu0yKe2BQbfGKlsqWRMCAWfe7blEvu3GVRzaSPXLh3jWCrg+tWG8+VQrMT/
         t+fUIV8UoDV44H7Qj17nQsJlynUyac3IWdpUxMDmfsJZDTqHf9ZAOH9lVYKXn0LkEoyA
         9HNr4SQX2ZzjzQvCJDUmfR7rVoVhk1b/DzoBgJe/xZWyAaEMf2mh8G5v4Oyij4yHTufu
         KCIPhGaIxG8F87IAi9Qn5GnbEeqoWCniymqT70HXVcGdI2f4mkj/MJ8KdYOhZvQiTZfJ
         dgIA==
X-Gm-Message-State: ACgBeo281RAenmvicaWMRWNIGM/bPK5oPztiJ7g1F7jlRu3khOFAJyMQ
        pLOX6XWG8gt4J8fv4ldR13CBBJ9lSIBw
X-Google-Smtp-Source: AA6agR4LutrHhrE6oQnlgGroLFarxMNNHW2HnxKZNw5B1WQq0kn0vV42MbXicpOjvjfxnhUeBm9qhm7Ooqzc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a25:230d:0:b0:677:116d:afdb with SMTP id
 j13-20020a25230d000000b00677116dafdbmr5100760ybj.551.1660345793786; Fri, 12
 Aug 2022 16:09:53 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:35 -0700
Message-Id: <20220812230949.683239-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 00/14] Compress the pmu_event tables
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
no jevents - the same 19,788,464bytes
x86 jevents - ~16.7% file size saving 23,744,288bytes vs 28,502,632bytes
all jevents - ~19.5% file size saving 24,469,056bytes vs 30,379,920bytes
default build options plus NO_LIBBFD=1.

I originally suggested fixing this problem in:
https://lore.kernel.org/linux-perf-users/CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com/

v5. Renamed two functions to be more inline with the code and added
    extra commit message detail on the event sorting order as
    suggested by John Garry <john.garry@huawei.com>.
v4. Fixed an issue with the empty-pmu-events.c spotted by John Garry
    <john.garry@huawei.com>.
v3. Fix an ARM build issue with a missed weak symbol. Perform some
    pytype clean up.
v2. Split the substring folding optimization to its own patch and
    comment tweaks as suggested by Namhyung Kim
    <namhyung@kernel.org>. Recompute the file size savings with the
    latest json events and metrics.

Ian Rogers (14):
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
 .../arch/test/test_soc/cpu/metrics.json       |  64 +++
 tools/perf/pmu-events/empty-pmu-events.c      | 204 +++++++-
 tools/perf/pmu-events/jevents.py              | 478 +++++++++++++++---
 tools/perf/pmu-events/pmu-events.h            |  40 +-
 tools/perf/tests/expand-cgroup.c              |  25 +-
 tools/perf/tests/parse-metric.c               |  77 +--
 tools/perf/tests/pmu-events.c                 | 466 +++++++----------
 tools/perf/util/metricgroup.c                 | 275 ++++++----
 tools/perf/util/metricgroup.h                 |   5 +-
 tools/perf/util/pmu.c                         | 139 ++---
 tools/perf/util/pmu.h                         |  10 +-
 tools/perf/util/s390-sample-raw.c             |  50 +-
 13 files changed, 1131 insertions(+), 706 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json

-- 
2.37.1.595.g718a3a8f04-goog

