Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CC4A54D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiBAB7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiBAB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:59:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A305EC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:59:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso30351091ybp.23
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jjTIKTNwlbdUfKQQLpBBqZLfYyiurd3UD+6/q3EsxeY=;
        b=SgGXHc6l/NChuruR/Znx1yY1jOn+GKwvwdUuv5gSPy//Q8LK63S2sUOCteTb4tpyCw
         exWeLoPCxysTBLAM9WsI4FXpr2LrjAEpA1aoCqZpEaWahurnUChfHxq95uuwsnaWOr6+
         cGVdOnEE12iMc9cZ+680/aDbpEseQ3OHGbi2S1h8b8/bqbKRtfo3F4ALTpOCbY+Sbts6
         D1Umqhe+I3KV+ykbtQHnjzLBK89IXpwG4+HomjGhz5Ls8Q8DOP5VAERxTazlPDepA5IO
         rgGk5jaAg4rULEtr0q3Ht5R0pghGACuK8DffgFSqU0wPes2qBMByfBwGI4Qohq/3vrpi
         SH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jjTIKTNwlbdUfKQQLpBBqZLfYyiurd3UD+6/q3EsxeY=;
        b=wyUHno0MJatYl0qlhwQ/kJQT7e52N+t54/urZS7DCXThnJVOn5p84ut4zqeJoDe30O
         oVUVnqwq2lSWJ3YuX++cibR6wKPHJb2tga3eN5kXX7tMpeLbF8vJpEjppy4guiIt5JdN
         135Xm2A2GgQnF2/0mJNmMix/IZP4z4tNu1YU09l72hziZl7BbqUBfPeL4jTIxjXziMpx
         V39RBYZtBfoBIdhsGPHGo/RLR5fQZv8gBVyz67tIdXmhbgmOK6sP8Z84Z5ZQTvDj2ZxR
         r+96lfe9SRl9cu1EXsMcuiDFf57c/girdXoWl+5IJUiHugvWJbK54XFzp1V+BolRRsZT
         ZWLA==
X-Gm-Message-State: AOAM531HC9YLgmV9MOtTP+nRRfyheQIWBCGLDB418Cw3t1pPJ9Ij243G
        yhDzJgIVfI2x2R6yJ3NmrKz8rqCrsaEf
X-Google-Smtp-Source: ABdhPJybJ7Wds9M0NPE50LtV5ZgsuBVohcuH5D+qNSy+WRFNjy6cN/ycspgv7rBkVVLkj3ChvWjOmJEjaqnR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b14e:bc64:b7f6:5d4b])
 (user=irogers job=sendgmr) by 2002:a25:df4e:: with SMTP id
 w75mr25582591ybg.747.1643680743748; Mon, 31 Jan 2022 17:59:03 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:58:32 -0800
Message-Id: <20220201015858.1226914-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 00/26] Update Intel events and metrics
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fetch and update Intel events and metrics using the script at:
https://github.com/intel/event-converter-for-linux-perf/pull/10
Generated events and metrics were added 1-by-1 and tested as much as
possible. Sometimes event data is the same but the files were
regenerated so the script improvements or a stable ordering would
occur. A particular improvement is to reintroduce TMA/Topdown metrics
generated from the full version of the spreadsheet.

v2. Addresses an issue with TMA metrics for broadwell-de and adds
    Kan's reviewed-by, except on the broadwell-de patch that is updated
    for the metrics.

Ian Rogers (26):
  perf test: Allow skip for all metrics test
  perf vendor events: Update metrics for SkyLake Server
  perf vendor events: Update metrics for Broadwell DE
  perf vendor events: Update metrics for CascadelakeX
  perf vendor events: Update metrics for HaswellX
  perf vendor events: Update metrics for Ivybridge
  perf vendor events: Update for Westmere EP-DP
  perf vendor events: Update metrics for IcelakeX
  perf vendor events: Update for Bonnell
  perf vendor events: Update metrics for Broadwell
  perf vendor events: Update metrics for BroadwellX
  perf vendor events: Update for Goldmont
  perf vendor events: Update for GoldmontPlus
  perf vendor events: Update metrics for Haswell
  perf vendor events: Update metrics for Icelake
  perf vendor events: Update metrics for Ivytown
  perf vendor events: Update metrics for Jaketown
  perf vendor events: Update Knights Landing
  perf vendor events: Update Nehalem EP
  perf vendor events: Update metrics for Skylake
  perf vendor events: Update Sandybridge
  perf vendor events: Update Silvermont
  perf vendor events: Update Tigerlake
  perf vendor events: Update Westmere EP-SP
  perf vendor events: Update Westmere EX
  perf vendor events: Update TremontX

 .../pmu-events/arch/x86/bonnell/cache.json    |  748 +--
 .../arch/x86/bonnell/floating-point.json      |  274 +-
 .../pmu-events/arch/x86/bonnell/frontend.json |   96 +-
 .../pmu-events/arch/x86/bonnell/memory.json   |  152 +-
 .../pmu-events/arch/x86/bonnell/other.json    |  452 +-
 .../pmu-events/arch/x86/bonnell/pipeline.json |  402 +-
 .../arch/x86/bonnell/virtual-memory.json      |  126 +-
 .../arch/x86/broadwell/bdw-metrics.json       |  353 +-
 .../pmu-events/arch/x86/broadwell/cache.json  | 4713 +++++++++--------
 .../arch/x86/broadwell/floating-point.json    |  235 +-
 .../arch/x86/broadwell/frontend.json          |  361 +-
 .../pmu-events/arch/x86/broadwell/memory.json | 4312 +++++++--------
 .../pmu-events/arch/x86/broadwell/other.json  |   42 +-
 .../arch/x86/broadwell/pipeline.json          | 1903 ++++---
 .../arch/x86/broadwell/virtual-memory.json    |  412 +-
 .../arch/x86/broadwellde/bdwde-metrics.json   |  407 +-
 .../arch/x86/broadwellde/cache.json           | 1122 ++--
 .../arch/x86/broadwellde/floating-point.json  |  222 +-
 .../arch/x86/broadwellde/frontend.json        |  335 +-
 .../arch/x86/broadwellde/memory.json          |  608 +--
 .../arch/x86/broadwellde/other.json           |   28 +-
 .../arch/x86/broadwellde/pipeline.json        | 1892 ++++---
 .../arch/x86/broadwellde/virtual-memory.json  |  394 +-
 .../arch/x86/broadwellx/bdx-metrics.json      |  351 +-
 .../pmu-events/arch/x86/broadwellx/cache.json | 1300 ++---
 .../arch/x86/broadwellx/floating-point.json   |  224 +-
 .../arch/x86/broadwellx/frontend.json         |  335 +-
 .../arch/x86/broadwellx/memory.json           |  974 ++--
 .../pmu-events/arch/x86/broadwellx/other.json |   28 +-
 .../arch/x86/broadwellx/pipeline.json         | 1891 ++++---
 .../arch/x86/broadwellx/virtual-memory.json   |  394 +-
 .../arch/x86/cascadelakex/cache.json          |  967 ++--
 .../arch/x86/cascadelakex/clx-metrics.json    |  469 +-
 .../arch/x86/cascadelakex/floating-point.json |   50 +-
 .../arch/x86/cascadelakex/frontend.json       |   18 +-
 .../arch/x86/cascadelakex/memory.json         | 1008 ++--
 .../arch/x86/cascadelakex/other.json          |  952 ++--
 .../arch/x86/cascadelakex/pipeline.json       |   11 +
 .../arch/x86/cascadelakex/uncore-other.json   |   23 +
 .../pmu-events/arch/x86/goldmont/cache.json   | 1466 +++--
 .../arch/x86/goldmont/floating-point.json     |   33 +
 .../arch/x86/goldmont/frontend.json           |   78 +-
 .../pmu-events/arch/x86/goldmont/memory.json  |   38 +-
 .../pmu-events/arch/x86/goldmont/other.json   |   92 +-
 .../arch/x86/goldmont/pipeline.json           |  538 +-
 .../arch/x86/goldmont/virtual-memory.json     |   94 +-
 .../arch/x86/goldmontplus/cache.json          | 1730 +++---
 .../arch/x86/goldmontplus/floating-point.json |   38 +
 .../arch/x86/goldmontplus/frontend.json       |   88 +-
 .../arch/x86/goldmontplus/memory.json         |   44 +-
 .../arch/x86/goldmontplus/other.json          |  106 +-
 .../arch/x86/goldmontplus/pipeline.json       |  616 +--
 .../arch/x86/goldmontplus/virtual-memory.json |  214 +-
 .../pmu-events/arch/x86/haswell/cache.json    | 1446 +++--
 .../arch/x86/haswell/floating-point.json      |  129 +-
 .../pmu-events/arch/x86/haswell/frontend.json |  362 +-
 .../arch/x86/haswell/hsw-metrics.json         |  265 +-
 .../pmu-events/arch/x86/haswell/memory.json   | 1004 ++--
 .../pmu-events/arch/x86/haswell/other.json    |   40 +-
 .../pmu-events/arch/x86/haswell/pipeline.json | 1796 +++----
 .../arch/x86/haswell/uncore-cache.json        |  252 +
 .../arch/x86/haswell/uncore-other.json        |   69 +
 .../pmu-events/arch/x86/haswell/uncore.json   |  374 --
 .../arch/x86/haswell/virtual-memory.json      |  552 +-
 .../pmu-events/arch/x86/haswellx/cache.json   | 1434 ++---
 .../arch/x86/haswellx/floating-point.json     |  116 +-
 .../arch/x86/haswellx/frontend.json           |  336 +-
 .../arch/x86/haswellx/hsx-metrics.json        |  263 +-
 .../pmu-events/arch/x86/haswellx/memory.json  | 1070 ++--
 .../pmu-events/arch/x86/haswellx/other.json   |   28 +-
 .../arch/x86/haswellx/pipeline.json           | 1763 +++---
 .../arch/x86/haswellx/virtual-memory.json     |  512 +-
 .../pmu-events/arch/x86/icelake/cache.json    |  658 +--
 .../arch/x86/icelake/floating-point.json      |   69 +-
 .../pmu-events/arch/x86/icelake/frontend.json |  449 +-
 .../arch/x86/icelake/icl-metrics.json         |  338 +-
 .../pmu-events/arch/x86/icelake/memory.json   |  591 ++-
 .../pmu-events/arch/x86/icelake/other.json    |  630 +--
 .../pmu-events/arch/x86/icelake/pipeline.json | 1081 ++--
 .../arch/x86/icelake/virtual-memory.json      |  178 +-
 .../pmu-events/arch/x86/icelakex/cache.json   |  851 +--
 .../arch/x86/icelakex/floating-point.json     |   51 +-
 .../arch/x86/icelakex/frontend.json           |  501 +-
 .../arch/x86/icelakex/icx-metrics.json        |  304 +-
 .../pmu-events/arch/x86/icelakex/memory.json  |  601 ++-
 .../pmu-events/arch/x86/icelakex/other.json   |  794 ++-
 .../arch/x86/icelakex/pipeline.json           | 1112 ++--
 .../arch/x86/icelakex/uncore-other.json       |   61 +-
 .../arch/x86/icelakex/virtual-memory.json     |  150 +-
 .../pmu-events/arch/x86/ivybridge/cache.json  | 1446 ++---
 .../arch/x86/ivybridge/floating-point.json    |  212 +-
 .../arch/x86/ivybridge/frontend.json          |  386 +-
 .../arch/x86/ivybridge/ivb-metrics.json       |  287 +-
 .../pmu-events/arch/x86/ivybridge/memory.json |  290 +-
 .../pmu-events/arch/x86/ivybridge/other.json  |   42 +-
 .../arch/x86/ivybridge/pipeline.json          | 1769 +++----
 .../arch/x86/ivybridge/uncore-cache.json      |  252 +
 .../arch/x86/ivybridge/uncore-other.json      |   91 +
 .../pmu-events/arch/x86/ivybridge/uncore.json |  314 --
 .../arch/x86/ivybridge/virtual-memory.json    |  208 +-
 .../pmu-events/arch/x86/ivytown/cache.json    | 1594 +++---
 .../arch/x86/ivytown/floating-point.json      |  212 +-
 .../pmu-events/arch/x86/ivytown/frontend.json |  386 +-
 .../arch/x86/ivytown/ivt-metrics.json         |  277 +-
 .../pmu-events/arch/x86/ivytown/memory.json   |  562 +-
 .../pmu-events/arch/x86/ivytown/other.json    |   42 +-
 .../pmu-events/arch/x86/ivytown/pipeline.json | 1769 +++----
 .../arch/x86/ivytown/virtual-memory.json      |  232 +-
 .../pmu-events/arch/x86/jaketown/cache.json   | 1582 +++---
 .../arch/x86/jaketown/floating-point.json     |  160 +-
 .../arch/x86/jaketown/frontend.json           |  363 +-
 .../arch/x86/jaketown/jkt-metrics.json        |  140 +-
 .../pmu-events/arch/x86/jaketown/memory.json  |  478 +-
 .../pmu-events/arch/x86/jaketown/other.json   |   58 +-
 .../arch/x86/jaketown/pipeline.json           | 1556 +++---
 .../arch/x86/jaketown/virtual-memory.json     |  178 +-
 .../arch/x86/knightslanding/cache.json        | 2602 +++++----
 .../x86/knightslanding/floating-point.json    |   29 +
 .../arch/x86/knightslanding/frontend.json     |   48 +-
 .../arch/x86/knightslanding/memory.json       | 1226 ++---
 .../arch/x86/knightslanding/pipeline.json     |  465 +-
 .../x86/knightslanding/virtual-memory.json    |   68 +-
 .../pmu-events/arch/x86/nehalemep/cache.json  | 3062 +++++------
 .../arch/x86/nehalemep/floating-point.json    |  180 +-
 .../arch/x86/nehalemep/frontend.json          |   18 +-
 .../pmu-events/arch/x86/nehalemep/memory.json |  670 +--
 .../pmu-events/arch/x86/nehalemep/other.json  |  156 +-
 .../arch/x86/nehalemep/pipeline.json          |  764 +--
 .../arch/x86/nehalemep/virtual-memory.json    |   90 +-
 .../arch/x86/sandybridge/cache.json           | 2298 ++++----
 .../arch/x86/sandybridge/floating-point.json  |  172 +-
 .../arch/x86/sandybridge/frontend.json        |  365 +-
 .../arch/x86/sandybridge/memory.json          |  520 +-
 .../arch/x86/sandybridge/other.json           |   66 +-
 .../arch/x86/sandybridge/pipeline.json        | 1634 +++---
 .../arch/x86/sandybridge/snb-metrics.json     |  150 +-
 .../arch/x86/sandybridge/uncore-cache.json    |  252 +
 .../arch/x86/sandybridge/uncore-other.json    |   91 +
 .../arch/x86/sandybridge/uncore.json          |  314 --
 .../arch/x86/sandybridge/virtual-memory.json  |  160 +-
 .../pmu-events/arch/x86/silvermont/cache.json |  940 ++--
 .../arch/x86/silvermont/floating-point.json   |   11 +
 .../arch/x86/silvermont/frontend.json         |   75 +-
 .../arch/x86/silvermont/memory.json           |    8 +-
 .../pmu-events/arch/x86/silvermont/other.json |   20 +-
 .../arch/x86/silvermont/pipeline.json         |  422 +-
 .../arch/x86/silvermont/virtual-memory.json   |   76 +-
 .../pmu-events/arch/x86/skylake/cache.json    | 2611 ++++-----
 .../arch/x86/skylake/floating-point.json      |   48 +-
 .../pmu-events/arch/x86/skylake/frontend.json |  578 +-
 .../pmu-events/arch/x86/skylake/memory.json   | 1566 +++---
 .../pmu-events/arch/x86/skylake/other.json    |   46 +-
 .../pmu-events/arch/x86/skylake/pipeline.json | 1083 ++--
 .../arch/x86/skylake/skl-metrics.json         |  497 +-
 .../arch/x86/skylake/virtual-memory.json      |  274 +-
 .../pmu-events/arch/x86/skylakex/cache.json   |  111 +-
 .../arch/x86/skylakex/floating-point.json     |   24 +-
 .../arch/x86/skylakex/frontend.json           |   18 +-
 .../pmu-events/arch/x86/skylakex/memory.json  |   96 +-
 .../arch/x86/skylakex/pipeline.json           |   11 +
 .../arch/x86/skylakex/skx-metrics.json        |  461 +-
 .../arch/x86/skylakex/uncore-other.json       |   23 +
 .../pmu-events/arch/x86/tigerlake/cache.json  |   44 +-
 .../arch/x86/tigerlake/floating-point.json    |   11 +-
 .../arch/x86/tigerlake/frontend.json          |   17 +-
 .../arch/x86/tigerlake/pipeline.json          |   37 +-
 .../pmu-events/arch/x86/tremontx/cache.json   |  282 +-
 .../arch/x86/tremontx/floating-point.json     |   24 +
 .../arch/x86/tremontx/frontend.json           |   97 +-
 .../pmu-events/arch/x86/tremontx/memory.json  |  449 +-
 .../pmu-events/arch/x86/tremontx/other.json   | 1786 ++++++-
 .../arch/x86/tremontx/pipeline.json           |  341 +-
 .../arch/x86/tremontx/uncore-memory.json      |  156 +-
 .../arch/x86/tremontx/uncore-other.json       | 2045 ++++++-
 .../arch/x86/tremontx/virtual-memory.json     |  320 +-
 .../arch/x86/westmereep-dp/cache.json         | 2734 +++++-----
 .../x86/westmereep-dp/floating-point.json     |  180 +-
 .../arch/x86/westmereep-dp/frontend.json      |   18 +-
 .../arch/x86/westmereep-dp/memory.json        |  686 +--
 .../arch/x86/westmereep-dp/other.json         |  238 +-
 .../arch/x86/westmereep-dp/pipeline.json      |  780 +--
 .../x86/westmereep-dp/virtual-memory.json     |  138 +-
 .../arch/x86/westmereep-sp/cache.json         | 3142 +++++------
 .../x86/westmereep-sp/floating-point.json     |  180 +-
 .../arch/x86/westmereep-sp/frontend.json      |   18 +-
 .../arch/x86/westmereep-sp/memory.json        |  670 +--
 .../arch/x86/westmereep-sp/other.json         |  238 +-
 .../arch/x86/westmereep-sp/pipeline.json      |  780 +--
 .../x86/westmereep-sp/virtual-memory.json     |  120 +-
 .../pmu-events/arch/x86/westmereex/cache.json | 3142 +++++------
 .../arch/x86/westmereex/floating-point.json   |  180 +-
 .../arch/x86/westmereex/frontend.json         |   18 +-
 .../arch/x86/westmereex/memory.json           |  676 +--
 .../pmu-events/arch/x86/westmereex/other.json |  238 +-
 .../arch/x86/westmereex/pipeline.json         |  784 ++-
 .../arch/x86/westmereex/virtual-memory.json   |  138 +-
 tools/perf/tests/shell/stat_all_metrics.sh    |   10 +-
 197 files changed, 61336 insertions(+), 52655 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/floating-point.json

-- 
2.35.0.rc2.247.g8bbb082509-goog

