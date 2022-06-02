Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2784453B116
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiFBAy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiFBAyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:54:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A463BBD2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:54:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso1963049wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XfbFHuT8lffHOFsCPNZHJ2k/5QPMr7ZWhkyndAOr7zM=;
        b=szScU1bIJ+MKTo+woVd7oKUbrDw4tSDt1IVJ2Jse+cVnXrlOmYOAbOGlzK9aE8aSy5
         bw0DR0firoMibJV4oshLBH+VIrZhymCwrMr2I6Iyq/uhRSHvFkVg3cg7Dals6cIjygbJ
         P44DmoqF6PFr5ZOsrZ6YiHW417Wv6fPPVud0FiejoHubRVsYEid3WPNknczQXbK+3NrE
         cIUWyBqhRpFZ5gZEE/pQitQXJNhoTHQ17wMDbWZoBSQG5+GioG4n0gJayFWZh7FSBIWs
         IsN3EcFhx9ZEex3iesYd7L48Ypj4Dm4Gc/wiwsoTh1huM8ed89Y1ncDymlSjXRhcSkDN
         jcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XfbFHuT8lffHOFsCPNZHJ2k/5QPMr7ZWhkyndAOr7zM=;
        b=nZKuDmmcUzOF2bRtI12bXc84MMD5B2P934yLqYaiRzo1FdMIGEAg/xoy7taajfMBYe
         ci5Bi0Lp1gIQHxhrNOsh0TqCKck/Ndg4rzNkYpi+2YdoEVLdUMeZtGW1ykPHuFq3ZbLw
         nPldx8uyIgilRSLEG8CikQ8M/5cbncQWFCnJi7hGLBivwaPdykWkWdJ8ETWF2RfPL0rR
         DrcRxUawdXfioLYO48wy8p7uckEE35VLG+7ZSTeDr7iT4jPe3KcCBXC28Ymz6jVy7ZfR
         toSapZOQsVY350u0Syygs9Q47Cp+Hs694ha0rL+ruD3+JJKH94ELnUR5LzXfTHBdEUJ6
         ajQw==
X-Gm-Message-State: AOAM531VotAendx+5NkGZZmueCM4RczPSyJLelOJztP8GP4nbW/qp6mO
        KYV9/aXFpJarP3aCHT4K8F0yCK+RZpuszNcHreqPWw==
X-Google-Smtp-Source: ABdhPJyIl5btIlrJPVvwcs3X48zN7+SAlqqP9Caw/IyydFfH9Ww0ppLgSkBEavGsJCmFI4QLRPsDT/Ryd8xfFOxCc24=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr30266419wmo.115.1654131260582; Wed, 01
 Jun 2022 17:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220528095933.1784141-1-zhengjun.xing@linux.intel.com> <20220528095933.1784141-2-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220528095933.1784141-2-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 17:54:07 -0700
Message-ID: <CAP-5=fW5+wo3C_48KGsjBaaR3+fcMhxoc_4KwdfnEgbuL7Swyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf vendor events intel: Update metrics for Alderlake
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 2:59 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Update JSON metrics for Alderlake to perf.
>
> It included both P-core and E-core metrics.
>
> P-core metrics based on TMA 4.4 (TMA_Metrics-full.csv)
> E-core metrics based on E-core TMA 2.0 (E-core_TMA_Metrics.csv)
>
> https://download.01.org/perfmon/
>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Tested-by: Ian Rogers <irogers@google.com>

PTAL at:
https://lore.kernel.org/lkml/20220527020653.4160884-1-irogers@google.com/
As the 1e12 fix will fail for say 1e13, whilst the patch above will
work in all cases.

Thanks,
Ian

> ---
> Change log:
>   v2:
>     * Regenerate it with the latest converter tool.
>
>  .../arch/x86/alderlake/adl-metrics.json       | 163 ++++++++++++------
>  1 file changed, 113 insertions(+), 50 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index 6b24958737b5..f8bdf7812b51 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -37,7 +37,7 @@
>      {
>          "BriefDescription": "Fraction of Physical Core issue-slots utili=
zed by this Logical Processor",
>          "MetricExpr": "TOPDOWN.SLOTS / ( TOPDOWN.SLOTS / 2 ) if #SMT_on =
else 1",
> -        "MetricGroup": "SMT",
> +        "MetricGroup": "SMT;TmaL1",
>          "MetricName": "Slots_Utilization",
>          "Unit": "cpu_core"
>      },
> @@ -64,27 +64,20 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Actual per-core usage of the Floating Point=
 execution units (regardless of the vector width)",
> -        "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH=
_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + =
FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKE=
D_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 * CPU_CLK_UNHA=
LTED.DISTRIBUTED )",
> +        "BriefDescription": "Actual per-core usage of the Floating Point=
 non-X87 execution units (regardless of precision or vector-width)",
> +        "MetricExpr": "( FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHE=
D.PORT_1 + FP_ARITH_DISPATCHED.PORT_5 ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTE=
D )",
>          "MetricGroup": "Cor;Flops;HPC",
>          "MetricName": "FP_Arith_Utilization",
> -        "PublicDescription": "Actual per-core usage of the Floating Poin=
t execution units (regardless of the vector width). Values > 1 are possible=
 due to Fused-Multiply Add (FMA) counting.",
> +        "PublicDescription": "Actual per-core usage of the Floating Poin=
t non-X87 execution units (regardless of precision or vector-width). Values=
 > 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common=
; [ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less com=
mon).",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is at least 1 uop executed)",
> +        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is execution) per-core",
>          "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCL=
ES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
>          "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
>          "MetricName": "ILP",
>          "Unit": "cpu_core"
>      },
> -    {
> -        "BriefDescription": "Number of Instructions per non-speculative =
Branch Misprediction (JEClear)",
> -        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
> -        "MetricGroup": "Bad;BadSpec;BrMispredicts",
> -        "MetricName": "IpMispredict",
> -        "Unit": "cpu_core"
> -    },
>      {
>          "BriefDescription": "Core actual clocks when any Logical Process=
or is active on the Physical Core",
>          "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
> @@ -181,6 +174,13 @@
>          "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bi=
t instruction (lower number means higher occurrence rate). May undercount d=
ue to FMA double counting.",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Instructions per Software prefetch instruct=
ion (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurre=
nce rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / cpu_core@SW_PREFETCH_ACCESS.T0=
\\,umask\\=3D0xF@",
> +        "MetricGroup": "Prefetches",
> +        "MetricName": "IpSWPF",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Total number of retired Instructions, Sampl=
e with: INST_RETIRED.PREC_DIST",
>          "MetricExpr": "INST_RETIRED.ANY",
> @@ -188,6 +188,27 @@
>          "MetricName": "Instructions",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Estimated fraction of retirement-cycles dea=
ling with repeat instructions",
> +        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu_core@UOPS_RETIRE=
D.SLOTS\\,cmask\\=3D1@",
> +        "MetricGroup": "Pipeline;Ret",
> +        "MetricName": "Strings_Cycles",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Instructions per a microcode Assist invocat=
ion. See Assists tree node for details (lower number means higher occurrenc=
e rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / cpu_core@ASSISTS.ANY\\,umask\\=
=3D0x1B@",
> +        "MetricGroup": "Pipeline;Ret;Retire",
> +        "MetricName": "IpAssist",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu_core@UOPS_EXECUTED.THR=
EAD\\,cmask\\=3D1@",
> +        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
> +        "MetricName": "Execute",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Average number of Uops issued by front-end =
when it issued something",
>          "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmas=
k\\=3D1@",
> @@ -210,12 +231,26 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Number of Instructions per non-speculative =
DSB miss",
> +        "BriefDescription": "Average number of cycles of a switch from t=
he DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for detai=
ls.",
> +        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu_core@DSB2M=
ITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
> +        "MetricGroup": "DSBmiss",
> +        "MetricName": "DSB_Switch_Cost",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Number of Instructions per non-speculative =
DSB miss (lower number means higher occurrence rate)",
>          "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS"=
,
>          "MetricGroup": "DSBmiss;Fed",
>          "MetricName": "IpDSB_Miss_Ret",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Number of Instructions per non-speculative =
Branch Misprediction (JEClear) (lower number means higher occurrence rate)"=
,
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Bad;BadSpec;BrMispredicts",
> +        "MetricName": "IpMispredict",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Fraction of branches that are non-taken con=
ditionals",
>          "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL=
_BRANCHES",
> @@ -252,11 +287,10 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Actual Average Latency for L1 data-cache mi=
ss demand load instructions (in core cycles)",
> -        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MIS=
S + MEM_LOAD_RETIRED.FB_HIT )",
> +        "BriefDescription": "Actual Average Latency for L1 data-cache mi=
ss demand load operations (in core cycles)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MIS=
S_ANY",
>          "MetricGroup": "Mem;MemoryBound;MemoryLat",
>          "MetricName": "Load_Miss_Real_Latency",
> -        "PublicDescription": "Actual Average Latency for L1 data-cache m=
iss demand load instructions (in core cycles). Latency may be overestimated=
 for multi-load instructions - e.g. repeat strings.",
>          "Unit": "cpu_core"
>      },
>      {
> @@ -266,34 +300,6 @@
>          "MetricName": "MLP",
>          "Unit": "cpu_core"
>      },
> -    {
> -        "BriefDescription": "Average data fill bandwidth to the L1 data =
cache [GB / sec]",
> -        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time=
",
> -        "MetricGroup": "Mem;MemoryBW",
> -        "MetricName": "L1D_Cache_Fill_BW",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Average data fill bandwidth to the L2 cache=
 [GB / sec]",
> -        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time=
",
> -        "MetricGroup": "Mem;MemoryBW",
> -        "MetricName": "L2_Cache_Fill_BW",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Average per-core data fill bandwidth to the=
 L3 cache [GB / sec]",
> -        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / durati=
on_time",
> -        "MetricGroup": "Mem;MemoryBW",
> -        "MetricName": "L3_Cache_Fill_BW",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Average per-core data access bandwidth to t=
he L3 cache [GB / sec]",
> -        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 /=
 duration_time",
> -        "MetricGroup": "Mem;MemoryBW;Offcore",
> -        "MetricName": "L3_Cache_Access_BW",
> -        "Unit": "cpu_core"
> -    },
>      {
>          "BriefDescription": "L1 cache true misses per kilo instruction f=
or retired demand loads",
>          "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.AN=
Y",
> @@ -316,14 +322,14 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "L2 cache misses per kilo instruction for al=
l request types (including speculative)",
> +        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all request types (including speculative)",
>          "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
>          "MetricGroup": "Mem;CacheMisses;Offcore",
>          "MetricName": "L2MPKI_All",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "L2 cache misses per kilo instruction for al=
l demand loads  (including speculative)",
> +        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all demand loads  (including speculative)",
>          "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRE=
D.ANY",
>          "MetricGroup": "Mem;CacheMisses",
>          "MetricName": "L2MPKI_Load",
> @@ -351,7 +357,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Fill Buffer (FB) true hits per kilo instruc=
tions for retired demand loads",
> +        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions=
 for retired demand loads (L1D misses that merge into ongoing miss-handling=
 entries)",
>          "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY=
",
>          "MetricGroup": "Mem;CacheMisses",
>          "MetricName": "FB_HPKI",
> @@ -365,6 +371,62 @@
>          "MetricName": "Page_Walks_Utilization",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L1 data cache [GB / sec]",
> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time=
",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L1D_Cache_Fill_BW",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L2 cache [GB / sec]",
> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time=
",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L2_Cache_Fill_BW",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L3 cache [GB / sec]",
> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / durati=
on_time",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L3_Cache_Fill_BW",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data access bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 /=
 duration_time",
> +        "MetricGroup": "Mem;MemoryBW;Offcore",
> +        "MetricName": "L3_Cache_Access_BW",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L1 data cache [GB / sec]",
> +        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_tim=
e)",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L1D_Cache_Fill_BW_1T",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L2 cache [GB / sec]",
> +        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_tim=
e)",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L2_Cache_Fill_BW_1T",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / durat=
ion_time)",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L3_Cache_Fill_BW_1T",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data access bandwidth to=
 the L3 cache [GB / sec]",
> +        "MetricExpr": "(64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 =
/ duration_time)",
> +        "MetricGroup": "Mem;MemoryBW;Offcore",
> +        "MetricName": "L3_Cache_Access_BW_1T",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Average CPU Utilization",
>          "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
> @@ -384,6 +446,7 @@
>          "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + F=
P_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKE=
D_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_R=
ETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE =
) / 1000000000 ) / duration_time",
>          "MetricGroup": "Cor;Flops;HPC",
>          "MetricName": "GFLOPs",
> +        "PublicDescription": "Giga Floating Point Operations Per Second.=
 Aggregate across all supported options of: FP precisions, scalar and vecto=
r instructions, vector-width and AMX engine.",
>          "Unit": "cpu_core"
>      },
>      {
> @@ -461,7 +524,7 @@
>      },
>      {
>          "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> -        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE=
)",
> +        "MetricExpr": "(TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.COR=
E))",
>          "MetricGroup": "TopdownL1",
>          "MetricName": "Backend_Bound_Aux",
>          "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that UOPS =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.  All of these=
 subevents count backend stalls, in slots, due to a resource limitation.   =
These are not cycle based events and therefore can not be precisely added o=
r subtracted from the Backend_Bound subevents which are cycle based.  These=
 subevents are supplementary to Backend_Bound and can be used to analyze re=
sults from a resource perspective at allocation.  ",
> @@ -608,7 +671,7 @@
>      },
>      {
>          "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "CPU_CLK_UNHALTED.CORE:k / CPU_CLK_UNHALTED.CORE",
> +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALT=
ED.CORE",
>          "MetricName": "Kernel_Utilization",
>          "Unit": "cpu_atom"
>      },
> @@ -620,7 +683,7 @@
>      },
>      {
>          "BriefDescription": "Estimated Pause cost. In percent",
> -        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / ( 5 * CPU_CL=
K_UNHALTED.CORE )",
> +        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / (5 * CPU_CLK=
_UNHALTED.CORE)",
>          "MetricName": "Estimated_Pause_Cost",
>          "Unit": "cpu_atom"
>      },
> --
> 2.25.1
>
