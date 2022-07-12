Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB15718AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiGLLfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiGLLfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:35:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21709AB6AC;
        Tue, 12 Jul 2022 04:35:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e15so9730593edj.2;
        Tue, 12 Jul 2022 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2306r08UL88WXFh16DD/rF6VBrRybeEsXUNdTvd7R7Q=;
        b=ZdWgTp15ToSVeJLI0XeBbGV84yyCwSJJrjQ4KZXYEWrPc3ROKa3Wu+XWxyodxYDF6A
         Qni7HNM6OceIE5s5AtTy+wjFejDLDbsWmt99rDcgsOq4yo1ABuETomWtJlfSlK8dmKHs
         fPm25put1FcFeHKkK06HzZM1epZ6KJIPbz/wzvu3g8P2lZfSWRZmgBMGOgp2+vMD+Fux
         J4tyeAG/76lvKfa3OcFKmYhb9zk6QeNU8pMMVboSgDdKOvBN6mIjGId5NpZvIguwzToi
         a//9zsXGVUoqVcV4tDT1j42O+3bx2GmPzdE9Uw2DMeAqU/IMHTHyIzxG/xhII2aviOsu
         X8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2306r08UL88WXFh16DD/rF6VBrRybeEsXUNdTvd7R7Q=;
        b=Ko+XuchNtHF91tIUe4zwuTchiMiCG2/Cq95ADmLqz0Zs+ccuec/cujkXvs7+0Jir7S
         VoDQAz6W1P3YeVOc6N8lQgECYhlwblxlC+N1z2k6liQsbKZl7ZQ1w6oYFtL0mOlWYbgZ
         IbpF8I7twi6wmzoc9ocZ6ntmc4mc4cSTbWbyxJwyMKZ9IgwRXx8LIOcTMZ48VYadNKUy
         PfipIEgB/zIaYWQVMv/rmegXDrilXN/9sfhBAws89VXYZTm64mbakhq2ZeV8omqbN3Jx
         GXOnYkxUu+H3nLxs0MwsZMlZEwopTw9zKrNNlyHFdGguJuOESPzl/eG6HhMQPvupsFYs
         F0zw==
X-Gm-Message-State: AJIora8jAzEwxEu9TLiTaa4Tn3up6T7tfYQSYjRJkic5lw39xAf6iGAo
        JU6Y5uYkTU8On+Q3UHIYjlQ=
X-Google-Smtp-Source: AGRyM1tclALhdmUzWgOMcdWCbX6KAAZfhENKhVFbYajNSExs+UQE2ptnl4qcA8p4GiQkuQ8lRUGdZQ==
X-Received: by 2002:aa7:c84a:0:b0:437:bc9c:af63 with SMTP id g10-20020aa7c84a000000b00437bc9caf63mr30038901edt.370.1657625735685;
        Tue, 12 Jul 2022 04:35:35 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id ez24-20020a1709070bd800b0072b1e27888asm3762994ejc.50.2022.07.12.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:35:35 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 12 Jul 2022 13:35:25 +0200
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        eranian@google.com, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 00/14] perf mem/c2c: Add support for AMD
Message-ID: <Ys1cfZgL4TyWazRm@krava>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616113638.900-1-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:06:23PM +0530, Ravi Bangoria wrote:
> Perf mem and c2c tools are wrappers around perf record with mem load/
> store events. IBS tagged load/store sample provides most of the
> information needed for these tools. Enable support for these tools on
> AMD Zen processors based on IBS Op pmu.
> 
> There are some limitations though: Only load/store instructions provide
> mem/c2c information. However, IBS does not provide a way to choose a
> particular type of instruction to tag. This results in many non-LS
> instructions being tagged which appear as N/A. IBS, being an uncore pmu
> from kernel point of view[1], does not support per process monitoring.
> Thus, perf mem/c2c on AMD are currently supported in per-cpu mode only.
> 
> Example:
>   $ sudo ./perf mem record -- -c 10000
>   ^C[ perf record: Woken up 227 times to write data ]
>   [ perf record: Captured and wrote 58.760 MB perf.data (836978 samples) ]
> 
>   $ sudo ./perf mem report -F mem,sample,snoop
>   Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
>   Memory access                  Samples  Snoop
>   N/A                             700620  N/A
>   L1 hit                          126675  N/A
>   L2 hit                             424  N/A
>   L3 hit                             664  HitM
>   L3 hit                              10  N/A
>   Local RAM hit                        2  N/A
>   Remote RAM (1 hop) hit            8558  N/A
>   Remote Cache (1 hop) hit             3  N/A
>   Remote Cache (1 hop) hit             2  HitM
>   Remote Cache (2 hops) hit            10  HitM
>   Remote Cache (2 hops) hit             6  N/A
>   Uncached hit                         4  N/A
> 
> Prepared on amd/perf/core (9886142c7a22) + IBS Zen4 enhancement patches[2]
> 
> [1]: https://lore.kernel.org/lkml/20220113134743.1292-1-ravi.bangoria@amd.com
> [2]: https://lore.kernel.org/lkml/20220604044519.594-1-ravi.bangoria@amd.com
> 
> v1: https://lore.kernel.org/lkml/20220525093938.4101-1-ravi.bangoria@amd.com
> v1->v2:
>  - Instead of defining macros to extract IBS register bits, use existing
>    bitfield definitions. Zen4 has introduced additional set of bits in
>    IBS registers which this series also exploits and thus this series
>    now depends on IBS Zen4 enhancement patchset.
>  - Add support for PERF_SAMPLE_WEIGHT_STRUCT. While opening a new event,
>    perf tool starts with a set of attributes and goes on reverting some
>    attributes in a predefined order until it succeeds or run out or all
>    attempts. Here, 1st attempt includes WEIGHT_STRUCT and exclude_guest
>    which always fails because IBS does not support guest filtering. The
>    problem however is, perf reverts WEIGHT_STRUCT but keeps trying with
>    exclude_guest. Thus, although, this series enables WEIGHT_STRUCT
>    support from kernel, using it from the perf tool need more changes.
>    I'll try to address this bug later.
>  - Introduce __PERF_SAMPLE_CALLCHAIN_EARLY to hint generic perf driver
>    that physical address is set by arch pmu driver and should not be
>    overwritten.
> 
> 
> Ravi Bangoria (14):
>   perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
>   perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
>   perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
>   perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
>   perf/x86/amd: Support PERF_SAMPLE_ADDR
>   perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
>   perf tool: Sync include/uapi/linux/perf_event.h header
>   perf tool: Sync arch/x86/include/asm/amd-ibs.h header
>   perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
>   perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
>   perf mem/c2c: Add load store event mappings for AMD
>   perf mem/c2c: Avoid printing empty lines for unsupported events
>   perf mem: Use more generic term for LFB
>   perf script: Add missing fields in usage hint

tools part looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  arch/x86/events/amd/ibs.c                | 372 ++++++++++++++++++++++-
>  arch/x86/include/asm/amd-ibs.h           |  16 +
>  include/uapi/linux/perf_event.h          |   5 +-
>  kernel/events/core.c                     |   4 +-
>  tools/arch/x86/include/asm/amd-ibs.h     |  16 +
>  tools/include/uapi/linux/perf_event.h    |   5 +-
>  tools/perf/Documentation/perf-c2c.txt    |  14 +-
>  tools/perf/Documentation/perf-mem.txt    |   3 +-
>  tools/perf/Documentation/perf-record.txt |   1 +
>  tools/perf/arch/x86/util/mem-events.c    |  31 +-
>  tools/perf/builtin-c2c.c                 |   1 +
>  tools/perf/builtin-mem.c                 |   1 +
>  tools/perf/builtin-script.c              |   7 +-
>  tools/perf/util/mem-events.c             |  17 +-
>  14 files changed, 467 insertions(+), 26 deletions(-)
> 
> -- 
> 2.31.1
> 
