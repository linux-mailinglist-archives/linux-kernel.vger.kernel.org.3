Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63903591C34
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiHMSEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiHMSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C5024BC7;
        Sat, 13 Aug 2022 11:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E63E60F21;
        Sat, 13 Aug 2022 18:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96221C433D6;
        Sat, 13 Aug 2022 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660413838;
        bh=LW0WsvI44YjlO0JrIFH51DdrccN4k9zbLcQRC93MHhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qn4yvixeKZFr5T5fEX1GJwmHbENG8132bO+Ok6f0tlgUsGPFHA1forgYS1MRWIsKh
         my2aP/qrS7w3cB0CqIz9lHe314Hv6YCKr5KCHgzUeOt3A+sf+fGoagHhYkhsYZ7gKR
         0OIZMuhViZVTH0tc+MjTy8X5S/pzVTEbVvwny5IxQL/c5s3m+2+nocgPuOvvuRbPKH
         kPFyvywB4oB9DGrqh47spKgPKYvTScufkc1aNQiVw1/vAxof8wntKp/hpV/RLQ07zL
         d4E0tSmBuNL9y2qx857BO2TZScthnMfat8KUn0UXan7kmxM8eiB+wFhDSuxctB7hok
         bNyng5BYXAUQw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A3F7E4035A; Sat, 13 Aug 2022 15:03:55 -0300 (-03)
Date:   Sat, 13 Aug 2022 15:03:55 -0300
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
Subject: Re: [PATCH v5 00/14] Compress the pmu_event tables
Message-ID: <Yvfni9lsQ9HljF49@kernel.org>
References: <20220812230949.683239-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
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

Em Fri, Aug 12, 2022 at 04:09:35PM -0700, Ian Rogers escreveu:
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

Applied locally, going thru further tests.

- Arnaldo
 
> I originally suggested fixing this problem in:
> https://lore.kernel.org/linux-perf-users/CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com/
> 
> v5. Renamed two functions to be more inline with the code and added
>     extra commit message detail on the event sorting order as
>     suggested by John Garry <john.garry@huawei.com>.
> v4. Fixed an issue with the empty-pmu-events.c spotted by John Garry
>     <john.garry@huawei.com>.
> v3. Fix an ARM build issue with a missed weak symbol. Perform some
>     pytype clean up.
> v2. Split the substring folding optimization to its own patch and
>     comment tweaks as suggested by Namhyung Kim
>     <namhyung@kernel.org>. Recompute the file size savings with the
>     latest json events and metrics.
> 
> Ian Rogers (14):
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
>  .../arch/test/test_soc/cpu/metrics.json       |  64 +++
>  tools/perf/pmu-events/empty-pmu-events.c      | 204 +++++++-
>  tools/perf/pmu-events/jevents.py              | 478 +++++++++++++++---
>  tools/perf/pmu-events/pmu-events.h            |  40 +-
>  tools/perf/tests/expand-cgroup.c              |  25 +-
>  tools/perf/tests/parse-metric.c               |  77 +--
>  tools/perf/tests/pmu-events.c                 | 466 +++++++----------
>  tools/perf/util/metricgroup.c                 | 275 ++++++----
>  tools/perf/util/metricgroup.h                 |   5 +-
>  tools/perf/util/pmu.c                         | 139 ++---
>  tools/perf/util/pmu.h                         |  10 +-
>  tools/perf/util/s390-sample-raw.c             |  50 +-
>  13 files changed, 1131 insertions(+), 706 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
> 
> -- 
> 2.37.1.595.g718a3a8f04-goog

-- 

- Arnaldo
