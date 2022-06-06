Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DAC53F2C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiFFXrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiFFXrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:47:09 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A031C03A9;
        Mon,  6 Jun 2022 16:47:08 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id q184so4890647oia.1;
        Mon, 06 Jun 2022 16:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feTs37C7gOoBTTvu4J4a/W8wj3saqfjkYK0ShR5TDGk=;
        b=Umu+7byJWB9JIeXcD5JzJ49rSzi+MWEqrwi+D6xkqrBuMQ/emB4cXMIHz7U7jYsx1I
         hcHAHAEQSaHEsQzuAGTPemE3nvud0ZVWEX+vkSjCfqAVKqPpTbqbFW6RMakGOCEUy9zr
         UhYGQjOe8d51JHP8QoQcn3RrZZGKOiqbOMeYXgNekr/aeJ1R3zRDufNEvXYfCFX2Kw9h
         VcvM6Baclsf7f+8GaO9D8nT9r1/F1NrARE2ThrwG8WDBUIeP4/5EqdD8jWhoYHIgWEaT
         R8oQEifNS6cSBxTFlLMJgn83vN+dliVAVDr7v4MqmHJ9Nwu45wvFQ4+kYfSI7Cka2OWD
         nQPQ==
X-Gm-Message-State: AOAM531so2QwLXtanKjwa6z9auKyW5JpWn6g8QNWE5CYo8ZsKJvVsPRW
        euBjd+urgrQZydTjzj7JGsyBaD2xOcRQSIDBuTA=
X-Google-Smtp-Source: ABdhPJyX087fQzsTb3cXqKlb3FHK2Usv3XxADxcZZ2DHMAR5vJqY0T/MEU7O04GUb3RZAcXb5O+l6CPjG3dEbhSI0RQ=
X-Received: by 2002:a05:6808:1a01:b0:32b:1f24:9213 with SMTP id
 bk1-20020a0568081a0100b0032b1f249213mr15031643oib.92.1654559227850; Mon, 06
 Jun 2022 16:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220604044519.594-1-ravi.bangoria@amd.com>
In-Reply-To: <20220604044519.594-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 6 Jun 2022 16:46:57 -0700
Message-ID: <CAM9d7ci9Th4Aye51G+X5F12BiDXTnffZdj-A+HGRfUX_nWuQdw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] perf/amd: Zen4 IBS extensions support (tool changes)
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rrichter@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>, like.xu.linux@gmail.com,
        x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Fri, Jun 3, 2022 at 9:46 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Kernel side of changes have already been applied to linus/master
> (except amd-ibs.h header). This series contains perf tool changes.
>
> v5: https://lore.kernel.org/lkml/20220601032608.1034-1-ravi.bangoria@amd.com
> v5->v6:
>  - Use macros instead of magic numbers for IBS l3missonly bits
>  - Use asprintf() instead of allocating memory and copying data manually
>  - Add Reviewed-by Kan Liang (patch 2-5).
>
> Patches prepared on acme/perf/core (9dde6cadb92b5)
>
> Original cover letter:
>
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 Miss Filtering capability. Both are
> indicated by CPUID_Fn8000001B_EAX bit 11.
>
> DataSrc extension provides additional data source details for tagged
> load/store operations. Add support for these new bits in perf report/
> script raw-dump.
>
> IBS L3 miss filtering works by tagging an instruction on IBS counter
> overflow and generating an NMI if the tagged instruction causes an L3
> miss. Samples without an L3 miss are discarded and counter is reset
> with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
> This helps in reducing sampling overhead when user is interested only
> in such samples. One of the use case of such filtered samples is to
> feed data to page-migration daemon in tiered memory systems.
>
> Add support for L3 miss filtering in IBS driver via new pmu attribute
> "l3missonly". Example usage:
>
>   # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5
>   # perf report -D
>
> Some important points to keep in mind while using L3 miss filtering:
> 1. Hw internally reset sampling period when tagged instruction does
>    not cause L3 miss. But there is no way to reconstruct aggregated
>    sampling period when this happens.
> 2. L3 miss is not the actual event being counted. Rather, IBS will
>    count fetch, cycles or uOps depending on the configuration. Thus
>    sampling period have no direct connection to L3 misses.
>
> 1st causes sampling period skew. Thus, I've added warning message at
> perf record:
>
>   # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
>   WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
>   and tagged operation does not cause L3 Miss. This causes sampling period skew.
>
> User can configure smaller sampling period to get more samples while
> using l3missonly.
>
>
> Ravi Bangoria (8):
>   perf record ibs: Warn about sampling period skew
>   perf tool: Parse pmu caps sysfs only once
>   perf headers: Pass "cpu" pmu name while printing caps
>   perf headers: Store pmu caps in an array of strings
>   perf headers: Record non-cpu pmu capabilities
>   perf/x86/ibs: Add new IBS register bits into header
>   perf tool ibs: Sync amd ibs header file
>   perf script ibs: Support new IBS bits in raw trace dump

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  arch/x86/include/asm/amd-ibs.h                |  16 +-
>  tools/arch/x86/include/asm/amd-ibs.h          |  16 +-
>  .../Documentation/perf.data-file-format.txt   |  10 +-
>  tools/perf/arch/x86/util/evsel.c              |  52 +++++
>  tools/perf/builtin-inject.c                   |   2 +-
>  tools/perf/util/amd-sample-raw.c              |  68 ++++++-
>  tools/perf/util/env.c                         |  62 +++++-
>  tools/perf/util/env.h                         |  14 +-
>  tools/perf/util/evsel.c                       |   7 +
>  tools/perf/util/evsel.h                       |   1 +
>  tools/perf/util/header.c                      | 189 ++++++++++--------
>  tools/perf/util/header.h                      |   2 +-
>  tools/perf/util/pmu.c                         |  15 +-
>  tools/perf/util/pmu.h                         |   2 +
>  14 files changed, 329 insertions(+), 127 deletions(-)
>
> --
> 2.31.1
>
