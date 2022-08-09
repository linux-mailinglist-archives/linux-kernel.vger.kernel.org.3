Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2958E059
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiHITmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344786AbiHITku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:40:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE26192A3;
        Tue,  9 Aug 2022 12:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61CBACE1940;
        Tue,  9 Aug 2022 19:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE5FC433C1;
        Tue,  9 Aug 2022 19:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660074045;
        bh=uYCj2fqjYbwtL2lFWjkg5SkjMyVCEb7wPisPHuzCDLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=leDc97sQDo22G2jWJJBU6Cu/vePNJt2EGMn2FH/jo8ikBG9iMLcyCU8u9Iny2RiIF
         w8rpXNwRwZjB1ZUiztfVEZX+B071eEU5kdGOXZdj55Zjod6arJ/CBVAk7jAp2l3K3M
         fsQcbFfw3tsH5f6FkmMUvD4QqkIqJyUBFxnL1Jrz9JaxID26ZiCOvSckS+ubEe/Ur4
         q2NVStg2K2PpSMMAr6G1i8ZOUZere4Up4SpEjmIfIPug5AfcEBwBqjSEQqbH7XT/6N
         oVahUBLhttGXI0oC/MWRZUJrYR8vo0QM2eIBH9uCSv1DQ8ONljeLrf6sKtyQSc7KZH
         MoB2YX4QrQIqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 249284035A; Tue,  9 Aug 2022 16:40:43 -0300 (-03)
Date:   Tue, 9 Aug 2022 16:40:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 00/17]  Compress the pmu_event tables
Message-ID: <YvK4O9U6tjTJqqxX@kernel.org>
References: <20220804221816.1802790-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 04, 2022 at 03:17:59PM -0700, Ian Rogers escreveu:
> jevents.py creates a number of large arrays from the json events. The
> arrays contain pointers to strings that need relocating. The
> relocations have file size, run time and memory costs. These changes
> refactor the pmu_events API so that the storage of the pmu_event
> struct isn't exposed. The format is then changed to an offset within a
> combined big string, with adjacent pmu_event struct variables being
> next to each other in the string separated by \0 - meaning only the
> first variable of the struct needs its offset recording.
> 
> Some related fixes are contained with the patches. The architecture
> jevents.py creates tables for can now be set by the JEVENTS_ARCH make
> variable, with a new 'all' that generates the events and metrics for
> all architectures.
> 
> An example of the improvement to the file size on x86 is:
> no jevents - the same 19,788,464bytes
> x86 jevents - ~16.7% file size saving 23,744,288bytes vs 28,502,632bytes
> all jevents - ~19.5% file size saving 24,469,056bytes vs 30,379,920bytes
> default build options plus NO_LIBBFD=1.

Applied the first four patches, waiting for the review comments to be
discussed.

- Arnaldo
 
> I originally suggested fixing this problem in:
> https://lore.kernel.org/linux-perf-users/CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com/
> 
> v4. Fixed an issue with the empty-pmu-events.c spotted by John Garry
>     <john.garry@huawei.com>.
> v3. Fix an ARM build issue with a missed weak symbol. Perform some
>     pytype clean up.
> v2. Split the substring folding optimization to its own patch and
>     comment tweaks as suggested by Namhyung Kim
>     <namhyung@kernel.org>. Recompute the file size savings with the
>     latest json events and metrics.
> 
> Ian Rogers (17):
>   perf jevents: Clean up pytype warnings
>   perf jevents: Simplify generation of C-string
>   perf jevents: Add JEVENTS_ARCH make option
>   perf jevent: Add an 'all' architecture argument
>   perf jevents: Remove the type/version variables
>   perf jevents: Provide path to json file on error
>   perf jevents: Sort json files entries
>   perf pmu-events: Hide pmu_sys_event_tables
>   perf pmu-events: Avoid passing pmu_events_map
>   perf pmu-events: Hide pmu_events_map
>   perf test: Use full metric resolution
>   perf pmu-events: Move test events/metrics to json
>   perf pmu-events: Don't assume pmu_event is an array
>   perf pmu-events: Hide the pmu_events
>   perf metrics: Copy entire pmu_event in find metric
>   perf jevents: Compress the pmu_events_table
>   perf jevents: Fold strings optimization
> 
>  tools/perf/arch/arm64/util/pmu.c              |   4 +-
>  tools/perf/pmu-events/Build                   |   6 +-
>  .../arch/test/test_soc/cpu/metrics.json       |  64 +++
>  tools/perf/pmu-events/empty-pmu-events.c      | 204 +++++++-
>  tools/perf/pmu-events/jevents.py              | 495 ++++++++++++++----
>  tools/perf/pmu-events/pmu-events.h            |  40 +-
>  tools/perf/tests/expand-cgroup.c              |  25 +-
>  tools/perf/tests/parse-metric.c               |  77 +--
>  tools/perf/tests/pmu-events.c                 | 466 +++++++----------
>  tools/perf/util/metricgroup.c                 | 275 ++++++----
>  tools/perf/util/metricgroup.h                 |   5 +-
>  tools/perf/util/pmu.c                         | 139 ++---
>  tools/perf/util/pmu.h                         |   8 +-
>  tools/perf/util/s390-sample-raw.c             |  50 +-
>  14 files changed, 1140 insertions(+), 718 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
> 
> -- 
> 2.37.1.559.g78731f0fdb-goog

-- 

- Arnaldo
