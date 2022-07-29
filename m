Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87623584CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiG2HoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiG2HoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928665666
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id jx17-20020a17090b46d100b001f33b230098so260305pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1Wg9cHm2UMgNHmJrbWYqWjDLkwNy+fZSAbVTsV+UQns=;
        b=imxY0j49nHkgRuVEtqcu1lSRSM5vwuyb3SjeUn8WrBKKWgIK3aBc/DJkUn0uVgqwOh
         Ej0opAKoYwLjSbESFDo0kegDOw4cDV0ByjwDcaEb6ChpE7xPt2dRxOjNZCN74daQ6OTF
         8t37Vx+QadrW8tIzFFrrZG7lRomzlJ7cQsjdFeQmXPwnlSXdqoqJvbhVyX31Qa8Ybn4v
         V10uDxd0aNexsoDvQTOuXWxJ4ZGA2aQjrkkDzW+9zzNx6B3m4wqlza2fBJIMKZIGfXxq
         CPmT9NEsvcORRgNR4d0aIXB0JJN5C9i+yR1gseWIHqK6ALt4WvQy++imDh4cGjVOu6vQ
         QdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1Wg9cHm2UMgNHmJrbWYqWjDLkwNy+fZSAbVTsV+UQns=;
        b=HZSdZUy/PYdajux/rVgi3QOg7V1Pj4oGYx131OjHj1H9s7uK4IYNBAA/V70B0XLhK/
         tnuKmsjoD7atIrT41wB+JNN6Ta58mXrDfFFCUgeC9dESXv0W88cx2zzlbDn73+x7nDwA
         AX4Uchfz9OPTZ54RXe0acV3EGpcU2vTXX9FJTB3Ci1ypXt+kQzsuNt2UuHCEAN+6O6Go
         8t3sIS6/MSQTIeUDZRBBM8u5MpVox4i7/zpfH3IsYillB2IUZM3tlxhSPL/YxXxr05pu
         OQdVq4w6tLAy5rPYzBOul0QU9fOBzsv9uo27ME/q429olgg00TJO87yh9bdZYQDky2G1
         jNYw==
X-Gm-Message-State: AJIora88vSdjIXooz2KzZy18FUwRt82KQIJ0NjG82q7qv44ovdEfkgZX
        wmCxtpGuNsQXbDlU2hGFz3h5KGCEIUUB
X-Google-Smtp-Source: AGRyM1s5Kyemr2tcw/wnsGgnx2UTjqJzLMWlkCo84p8rnvtDM0dFBbz53/1DqEA7btgqXB4XxzCpKr2k1GtG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1ac7:b0:52b:37ac:442c with SMTP
 id f7-20020a056a001ac700b0052b37ac442cmr2234362pfv.76.1659080641572; Fri, 29
 Jul 2022 00:44:01 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:34 -0700
Message-Id: <20220729074351.138260-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 00/17] Compress the pmu_event tables
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
2.37.1.455.g008518b4e5-goog

