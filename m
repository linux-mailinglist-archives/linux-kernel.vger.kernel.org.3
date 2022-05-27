Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA495367D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354604AbiE0UEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiE0UEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:04:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C74140F5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:03:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o9so3257086wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iHl433hjW84N++rR8CJUHJfpoYG5cuR613AIr9lyYM4=;
        b=VrjWxlUoteFybS/VLRDLXgTnNJJRT34u6V0DpCndpnz0GhaT8nIb7DspvaBFV3H75A
         z9cFsgWlJdLOUHiqFkmofbMbDGL4DoBJbiac3/MC0V22sRWdtJECm5d3dudMT0kDlcm8
         i700dwV7MjvR7p6jUcg14b2Z3f+h63thVnWwmZ45KrOe9Kzpxb9cCWPCTx1Cun57S1yT
         JT3itDT64UqFzGoOlxo2p+kczSVXJLgHkpezIvBnTUYfrgVpvxBjCdMUVExGxbiRFms6
         Mpcq5AfY0AE3Wjsg3mwnBkeWIAXN6BJ1QVDTdvLzuleY36r3gfgKvW65b1TNokXonQA5
         h3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iHl433hjW84N++rR8CJUHJfpoYG5cuR613AIr9lyYM4=;
        b=ATsYAyiX5qS3m8Z2k8GiA3bUA50VTz35fMPXfN76ylZMeNo/wLVZSj4D0GRbzhFN3M
         SSu2BTDZeAyhA47BbV3le7JxEzXUiPSrATJzff/NejGIP1e9WsrG6PblhcQYVW2AT0OS
         p7coOm1BhpeKSD2RCQgQ3h+Dr2Mgmp79zKUg2aZFuitQvHAePcgyiBGLVNwmx0eSMEjF
         UIoFWCgeRLWMJ5qwzSpsNOZxKILlZV/C/Y/UbzzId6eZAtH03TDHFiOvU4l4XJy6j/21
         V26Psc95bo1e4coBq3wNr8/ZLB7GImN9WPaYBMU6xo6iEvwhHIiBiMt+JX+L+1tPVvIb
         zEFg==
X-Gm-Message-State: AOAM531lO6VT2aA48ZWdM8oNKK/awUIZdk2kexfuXQiQLADhodHrL9B5
        oqGuDjWY5w0T7lmVwctKyLoqHIOM9iCOUqHEMIb9wA==
X-Google-Smtp-Source: ABdhPJxGXXf3Wgk8p1/nlj9+Qqu+ULQ/AfWzcmZ+2FuBQJhach1CI504Cy1dT6NQZnWDPSpNM0+AFXg+A2w2dz1Ht8M=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr8345748wmo.115.1653681837732; Fri, 27 May
 2022 13:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220525091013.1704887-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220525091013.1704887-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 27 May 2022 13:03:44 -0700
Message-ID: <CAP-5=fWhJq-f2Hx2ONCYcb2Veyi3-1jFcCiS28PnmGA0MX0yqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf vendor events intel: Add metrics for Sapphirerapids
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

On Wed, May 25, 2022 at 2:10 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Add JSON metrics for Sapphirerapids to perf.
>
> Based on TMA4.4 metrics.
>
> https://download.01.org/perfmon/TMA_Metrics-full.csv

There's nothing wrong with this and the next change. There is an
outstanding PR for the converter script [1] which will cause some
reformatting changes here. To avoid churn we could regenerate with
those changes.

Thanks,
Ian

[1] https://github.com/intel/event-converter-for-linux-perf/pull/13

> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 530 ++++++++++++++++++
>  1 file changed, 530 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/spr-met=
rics.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> new file mode 100644
> index 000000000000..d0f2d948901c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> @@ -0,0 +1,530 @@
> +[
> +    {
> +        "BriefDescription": "Total pipeline cost of branch related instr=
uctions (used for program control-flow including function calls)",
> +        "MetricExpr": "100 * (( BR_INST_RETIRED.COND + 3 * BR_INST_RETIR=
ED.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2=
 * BR_INST_RETIRED.NEAR_CALL) ) / TOPDOWN.SLOTS)",
> +        "MetricGroup": "Ret",
> +        "MetricName": "Branching_Overhead"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle (per Logical Process=
or)",
> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> +        "MetricGroup": "Ret;Summary",
> +        "MetricName": "IPC"
> +    },
> +    {
> +        "BriefDescription": "Cycles Per Instruction (per Logical Process=
or)",
> +        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)"=
,
> +        "MetricGroup": "Pipeline;Mem",
> +        "MetricName": "CPI"
> +    },
> +    {
> +        "BriefDescription": "Per-Logical Processor actual clocks when th=
e Logical Processor is active.",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
> +        "MetricGroup": "Pipeline",
> +        "MetricName": "CLKS"
> +    },
> +    {
> +        "BriefDescription": "Total issue-pipeline slots (per-Physical Co=
re till ICL; per-Logical Processor ICL onward)",
> +        "MetricExpr": "TOPDOWN.SLOTS",
> +        "MetricGroup": "TmaL1",
> +        "MetricName": "SLOTS"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Physical Core issue-slots utili=
zed by this Logical Processor",
> +        "MetricExpr": "TOPDOWN.SLOTS / ( TOPDOWN.SLOTS / 2 ) if #SMT_on =
else 1",
> +        "MetricGroup": "SMT;TmaL1",
> +        "MetricName": "Slots_Utilization"
> +    },
> +    {
> +        "BriefDescription": "The ratio of Executed- by Issued-Uops",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
> +        "MetricGroup": "Cor;Pipeline",
> +        "MetricName": "Execute_per_Issue",
> +        "PublicDescription": "The ratio of Executed- by Issued-Uops. Rat=
io > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate=
 of \"execute\" at rename stage."
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle across hyper-threads=
 (per physical core)",
> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "Ret;SMT;TmaL1",
> +        "MetricName": "CoreIPC"
> +    },
> +    {
> +        "BriefDescription": "Floating Point Operations Per Cycle",
> +        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF ) + 2=
 * ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.COMP=
LEX_SCALAR_HALF ) + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARI=
TH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED2.128B_PA=
CKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRE=
D.512B_PACKED_DOUBLE ) + 16 * ( FP_ARITH_INST_RETIRED2.256B_PACKED_HALF + F=
P_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) + 32 * FP_ARITH_INST_RETIRED2.512=
B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16 ) / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "Ret;Flops",
> +        "MetricName": "FLOPc"
> +    },
> +    {
> +        "BriefDescription": "Actual per-core usage of the Floating Point=
 non-X87 execution units (regardless of precision or vector-width)",
> +        "MetricExpr": "( FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHE=
D.PORT_1 + FP_ARITH_DISPATCHED.PORT_5 ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTE=
D )",
> +        "MetricGroup": "Cor;Flops;HPC",
> +        "MetricName": "FP_Arith_Utilization",
> +        "PublicDescription": "Actual per-core usage of the Floating Poin=
t non-X87 execution units (regardless of precision or vector-width). Values=
 > 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common=
; [ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less com=
mon)."
> +    },
> +    {
> +        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is execution) per-core",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCL=
ES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
> +        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
> +        "MetricName": "ILP"
> +    },
> +    {
> +        "BriefDescription": "Core actual clocks when any Logical Process=
or is active on the Physical Core",
> +        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "SMT",
> +        "MetricName": "CORE_CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Load (lower number means h=
igher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpLoad"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Store (lower number means =
higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpStore"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Branches;Fed;InsType",
> +        "MetricName": "IpBranch"
> +    },
> +    {
> +        "BriefDescription": "Instructions per (near) call (lower number =
means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
> +        "MetricGroup": "Branches;Fed;PGO",
> +        "MetricName": "IpCall"
> +    },
> +    {
> +        "BriefDescription": "Instruction per taken branch",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
> +        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO",
> +        "MetricName": "IpTB"
> +    },
> +    {
> +        "BriefDescription": "Branch instructions per taken branch. ",
> +        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NE=
AR_TAKEN",
> +        "MetricGroup": "Branches;Fed;PGO",
> +        "MetricName": "BpTkBranch"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Floating Point (FP) Operat=
ion (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED=
2.SCALAR_HALF ) + 2 * ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH=
_INST_RETIRED2.COMPLEX_SCALAR_HALF ) + 4 * ( FP_ARITH_INST_RETIRED.128B_PAC=
KED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_IN=
ST_RETIRED2.128B_PACKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + F=
P_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * ( FP_ARITH_INST_RETIRED2.2=
56B_PACKED_HALF + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) + 32 * FP_ARIT=
H_INST_RETIRED2.512B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16 )",
> +        "MetricGroup": "Flops;InsType",
> +        "MetricName": "IpFLOP"
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic instruction =
(lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / ( (FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCA=
LAR) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.12=
8B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST=
_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.VECTOR) )",
> +        "MetricGroup": "Flops;InsType",
> +        "MetricName": "IpArith",
> +        "PublicDescription": "Instructions per FP Arithmetic instruction=
 (lower number means higher occurrence rate). May undercount due to FMA dou=
ble counting. Approximated prior to BDW."
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic Scalar Singl=
e-Precision instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE",
> +        "MetricGroup": "Flops;FpScalar;InsType",
> +        "MetricName": "IpArith_Scalar_SP",
> +        "PublicDescription": "Instructions per FP Arithmetic Scalar Sing=
le-Precision instruction (lower number means higher occurrence rate). May u=
ndercount due to FMA double counting."
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic Scalar Doubl=
e-Precision instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_D=
OUBLE",
> +        "MetricGroup": "Flops;FpScalar;InsType",
> +        "MetricName": "IpArith_Scalar_DP",
> +        "PublicDescription": "Instructions per FP Arithmetic Scalar Doub=
le-Precision instruction (lower number means higher occurrence rate). May u=
ndercount due to FMA double counting."
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-=
bit instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.128B_P=
ACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED2.128B_PACKED_HALF )",
> +        "MetricGroup": "Flops;FpVector;InsType",
> +        "MetricName": "IpArith_AVX128",
> +        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128=
-bit instruction (lower number means higher occurrence rate). May undercoun=
t due to FMA double counting."
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit=
 instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.256B_P=
ACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED2.256B_PACKED_HALF )",
> +        "MetricGroup": "Flops;FpVector;InsType",
> +        "MetricName": "IpArith_AVX256",
> +        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bi=
t instruction (lower number means higher occurrence rate). May undercount d=
ue to FMA double counting."
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit =
instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.512B_P=
ACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED2.512B_PACKED_HALF )",
> +        "MetricGroup": "Flops;FpVector;InsType",
> +        "MetricName": "IpArith_AVX512",
> +        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit=
 instruction (lower number means higher occurrence rate). May undercount du=
e to FMA double counting."
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic AMX operatio=
n (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.BF16",
> +        "MetricGroup": "Flops;FpVector;InsType;Server",
> +        "MetricName": "IpArith_AMX_F16",
> +        "PublicDescription": "Instructions per FP Arithmetic AMX operati=
on (lower number means higher occurrence rate). Operations factored per mat=
rices' sizes of the AMX instructions."
> +    },
> +    {
> +        "BriefDescription": "Instructions per Integer Arithmetic AMX ope=
ration (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / AMX_OPS_RETIRED.INT8",
> +        "MetricGroup": "IntVector;InsType;Server",
> +        "MetricName": "IpArith_AMX_Int8",
> +        "PublicDescription": "Instructions per Integer Arithmetic AMX op=
eration (lower number means higher occurrence rate). Operations factored pe=
r matrices' sizes of the AMX instructions."
> +    },
> +    {
> +        "BriefDescription": "Instructions per Software prefetch instruct=
ion (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurre=
nce rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,um=
ask\\=3D0xF@",
> +        "MetricGroup": "Prefetches",
> +        "MetricName": "IpSWPF"
> +    },
> +    {
> +        "BriefDescription": "Total number of retired Instructions, Sampl=
e with: INST_RETIRED.PREC_DIST",
> +        "MetricExpr": "INST_RETIRED.ANY",
> +        "MetricGroup": "Summary;TmaL1",
> +        "MetricName": "Instructions"
> +    },
> +    {
> +        "BriefDescription": "Estimated fraction of retirement-cycles dea=
ling with repeat instructions",
> +        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLO=
TS\\,cmask\\=3D1@",
> +        "MetricGroup": "Pipeline;Ret",
> +        "MetricName": "Strings_Cycles"
> +    },
> +    {
> +        "BriefDescription": "Instructions per a microcode Assist invocat=
ion. See Assists tree node for details (lower number means higher occurrenc=
e rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / cpu@ASSISTS.ANY\\,umask\\=3D0x=
1B@",
> +        "MetricGroup": "Pipeline;Ret;Retire",
> +        "MetricName": "IpAssist"
> +    },
> +    {
> +        "BriefDescription": "",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@",
> +        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
> +        "MetricName": "Execute"
> +    },
> +    {
> +        "BriefDescription": "Average number of Uops issued by front-end =
when it issued something",
> +        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=
=3D1@",
> +        "MetricGroup": "Fed;FetchBW",
> +        "MetricName": "Fetch_UpC"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Uops delivered by the DSB (aka =
Decoded ICache; or Uop Cache)",
> +        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + ID=
Q.MS_UOPS)",
> +        "MetricGroup": "DSB;Fed;FetchBW",
> +        "MetricName": "DSB_Coverage"
> +    },
> +    {
> +        "BriefDescription": "Average number of cycles of a switch from t=
he DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for detai=
ls.",
> +        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_S=
WITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge\\=3D1@",
> +        "MetricGroup": "DSBmiss",
> +        "MetricName": "DSB_Switch_Cost"
> +    },
> +    {
> +        "BriefDescription": "Number of Instructions per non-speculative =
DSB miss (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS"=
,
> +        "MetricGroup": "DSBmiss;Fed",
> +        "MetricName": "IpDSB_Miss_Ret"
> +    },
> +    {
> +        "BriefDescription": "Number of Instructions per non-speculative =
Branch Misprediction (JEClear) (lower number means higher occurrence rate)"=
,
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Bad;BadSpec;BrMispredicts",
> +        "MetricName": "IpMispredict"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are non-taken con=
ditionals",
> +        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL=
_BRANCHES",
> +        "MetricGroup": "Bad;Branches;CodeGen;PGO",
> +        "MetricName": "Cond_NT"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are taken conditi=
onals",
> +        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_=
BRANCHES",
> +        "MetricGroup": "Bad;Branches;CodeGen;PGO",
> +        "MetricName": "Cond_TK"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are CALL or RET",
> +        "MetricExpr": "( BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEA=
R_RETURN ) / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Bad;Branches",
> +        "MetricName": "CallRet"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are unconditional=
 (direct or indirect) jumps",
> +        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.CON=
D_TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Bad;Branches",
> +        "MetricName": "Jump"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches of other types (not in=
dividually covered by other metrics in Info.Branches group)",
> +        "MetricExpr": "1 - ( (BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETI=
RED.ALL_BRANCHES) + (BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BRANC=
HES) + (( BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_RETURN ) / BR_IN=
ST_RETIRED.ALL_BRANCHES) + ((BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.C=
OND_TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES) =
)",
> +        "MetricGroup": "Bad;Branches",
> +        "MetricName": "Other_Branches"
> +    },
> +    {
> +        "BriefDescription": "Actual Average Latency for L1 data-cache mi=
ss demand load operations (in core cycles)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MIS=
S_ANY",
> +        "MetricGroup": "Mem;MemoryBound;MemoryLat",
> +        "MetricName": "Load_Miss_Real_Latency"
> +    },
> +    {
> +        "BriefDescription": "Memory-Level-Parallelism (average number of=
 L1 miss demand load when there is at least one such miss. Per-Logical Proc=
essor)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYC=
LES",
> +        "MetricGroup": "Mem;MemoryBound;MemoryBW",
> +        "MetricName": "MLP"
> +    },
> +    {
> +        "BriefDescription": "L1 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.AN=
Y",
> +        "MetricGroup": "Mem;CacheMisses",
> +        "MetricName": "L1MPKI"
> +    },
> +    {
> +        "BriefDescription": "L1 cache true misses per kilo instruction f=
or all demand loads (including speculative)",
> +        "MetricExpr": "1000 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED=
.ANY",
> +        "MetricGroup": "Mem;CacheMisses",
> +        "MetricName": "L1MPKI_Load"
> +    },
> +    {
> +        "BriefDescription": "L2 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.AN=
Y",
> +        "MetricGroup": "Mem;Backend;CacheMisses",
> +        "MetricName": "L2MPKI"
> +    },
> +    {
> +        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all request types (including speculative)",
> +        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
> +        "MetricGroup": "Mem;CacheMisses;Offcore",
> +        "MetricName": "L2MPKI_All"
> +    },
> +    {
> +        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all demand loads  (including speculative)",
> +        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRE=
D.ANY",
> +        "MetricGroup": "Mem;CacheMisses",
> +        "MetricName": "L2MPKI_Load"
> +    },
> +    {
> +        "BriefDescription": "L2 cache hits per kilo instruction for all =
request types (including speculative)",
> +        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / =
INST_RETIRED.ANY",
> +        "MetricGroup": "Mem;CacheMisses",
> +        "MetricName": "L2HPKI_All"
> +    },
> +    {
> +        "BriefDescription": "L2 cache hits per kilo instruction for all =
demand loads  (including speculative)",
> +        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED=
.ANY",
> +        "MetricGroup": "Mem;CacheMisses",
> +        "MetricName": "L2HPKI_Load"
> +    },
> +    {
> +        "BriefDescription": "L3 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.AN=
Y",
> +        "MetricGroup": "Mem;CacheMisses",
> +        "MetricName": "L3MPKI"
> +    },
> +    {
> +        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions=
 for retired demand loads (L1D misses that merge into ongoing miss-handling=
 entries)",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY=
",
> +        "MetricGroup": "Mem;CacheMisses",
> +        "MetricName": "FB_HPKI"
> +    },
> +    {
> +        "BriefDescription": "Utilization of the core's Page Walker(s) se=
rving STLB misses triggered by instruction/Load/Store accesses",
> +        "MetricConstraint": "NO_NMI_WATCHDOG",
> +        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WAL=
K_PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 4 * CPU_CLK_UNHALTED.DISTR=
IBUTED )",
> +        "MetricGroup": "Mem;MemoryTLB",
> +        "MetricName": "Page_Walks_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L1 data cache [GB / sec]",
> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time=
",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L1D_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L2 cache [GB / sec]",
> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time=
",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L2_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L3 cache [GB / sec]",
> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / durati=
on_time",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L3_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data access bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 /=
 duration_time",
> +        "MetricGroup": "Mem;MemoryBW;Offcore",
> +        "MetricName": "L3_Cache_Access_BW"
> +    },
> +    {
> +        "BriefDescription": "Rate of silent evictions from the L2 cache =
per Kilo instruction where the evicted lines are dropped (no writeback to L=
3 or memory)",
> +        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
> +        "MetricGroup": "L2Evicts;Mem;Server",
> +        "MetricName": "L2_Evictions_Silent_PKI"
> +    },
> +    {
> +        "BriefDescription": "Rate of non silent evictions from the L2 ca=
che per Kilo instruction",
> +        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY=
",
> +        "MetricGroup": "L2Evicts;Mem;Server",
> +        "MetricName": "L2_Evictions_NonSilent_PKI"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L1 data cache [GB / sec]",
> +        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_tim=
e)",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L1D_Cache_Fill_BW_1T"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L2 cache [GB / sec]",
> +        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_tim=
e)",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L2_Cache_Fill_BW_1T"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / durat=
ion_time)",
> +        "MetricGroup": "Mem;MemoryBW",
> +        "MetricName": "L3_Cache_Fill_BW_1T"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data access bandwidth to=
 the L3 cache [GB / sec]",
> +        "MetricExpr": "(64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 =
/ duration_time)",
> +        "MetricGroup": "Mem;MemoryBW;Offcore",
> +        "MetricName": "L3_Cache_Access_BW_1T"
> +    },
> +    {
> +        "BriefDescription": "Average CPU Utilization",
> +        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
> +        "MetricGroup": "HPC;Summary",
> +        "MetricName": "CPU_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Measured Average Frequency for unhalted pro=
cessors [GHz]",
> +        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_T=
SC) * msr@tsc@ / 1000000000 / duration_time",
> +        "MetricGroup": "Summary;Power",
> +        "MetricName": "Average_Frequency"
> +    },
> +    {
> +        "BriefDescription": "Giga Floating Point Operations Per Second",
> +        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + F=
P_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR_HALF ) +=
 2 * ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED2.CO=
MPLEX_SCALAR_HALF ) + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_A=
RITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED2.128B_=
PACKED_HALF + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETI=
RED.512B_PACKED_DOUBLE ) + 16 * ( FP_ARITH_INST_RETIRED2.256B_PACKED_HALF +=
 FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) + 32 * FP_ARITH_INST_RETIRED2.5=
12B_PACKED_HALF + 4 * AMX_OPS_RETIRED.BF16 ) / 1000000000 ) / duration_time=
",
> +        "MetricGroup": "Cor;Flops;HPC",
> +        "MetricName": "GFLOPs",
> +        "PublicDescription": "Giga Floating Point Operations Per Second.=
 Aggregate across all supported options of: FP precisions, scalar and vecto=
r instructions, vector-width and AMX engine."
> +    },
> +    {
> +        "BriefDescription": "Tera Integer (matrix) Operations Per Second=
",
> +        "MetricExpr": "( 8 * AMX_OPS_RETIRED.INT8 /  1000000000000 ) / d=
uration_time",
> +        "MetricGroup": "Cor;HPC;IntVector;Server",
> +        "MetricName": "TIOPS"
> +    },
> +    {
> +        "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TS=
C",
> +        "MetricGroup": "Power",
> +        "MetricName": "Turbo_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles where both hardware Logi=
cal Processors were active",
> +        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_=
UNHALTED.REF_DISTRIBUTED if #SMT_on else 0",
> +        "MetricGroup": "SMT",
> +        "MetricName": "SMT_2T_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles spent in the Operating S=
ystem (OS) Kernel mode",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.TH=
READ",
> +        "MetricGroup": "OS",
> +        "MetricName": "Kernel_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Cycles Per Instruction for the Operating Sy=
stem (OS) Kernel mode",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:=
k",
> +        "MetricGroup": "OS",
> +        "MetricName": "Kernel_CPI"
> +    },
> +    {
> +        "BriefDescription": "Average external Memory Bandwidth Use for r=
eads and writes [GB / sec]",
> +        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@=
cas_count_write@ ) / 1000000000 ) / duration_time",
> +        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
> +        "MetricName": "DRAM_BW_Use"
> +    },
> +    {
> +        "BriefDescription": "Average latency of data read request to ext=
ernal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetch=
es",
> +        "MetricExpr": "1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD =
/ UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( uncore_cha_0@event\\=3D0x1@ / durat=
ion_time )",
> +        "MetricGroup": "Mem;MemoryLat;SoC",
> +        "MetricName": "MEM_Read_Latency"
> +    },
> +    {
> +        "BriefDescription": "Average number of parallel data read reques=
ts to external memory. Accounts for demand loads and L1/L2 prefetches",
> +        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@UNC_CHA_T=
OR_OCCUPANCY.IA_MISS_DRD\\,thresh\\=3D1@",
> +        "MetricGroup": "Mem;MemoryBW;SoC",
> +        "MetricName": "MEM_Parallel_Reads"
> +    },
> +    {
> +        "BriefDescription": "Average latency of data read request to ext=
ernal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/=
L2 data-read prefetches",
> +        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / uncore_cha_0@event\\=3D0x1@=
 )",
> +        "MetricGroup": "Mem;MemoryLat;SoC;Server",
> +        "MetricName": "MEM_PMM_Read_Latency"
> +    },
> +    {
> +        "BriefDescription": "Average latency of data read request to ext=
ernal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 dat=
a-read prefetches",
> +        "MetricExpr": " 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD=
_DDR / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR ) / uncore_cha_0@event\\=3D0x1@"=
,
> +        "MetricGroup": "Mem;MemoryLat;SoC;Server",
> +        "MetricName": "MEM_DRAM_Read_Latency"
> +    },
> +    {
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads=
 [GB / sec]",
> +        "MetricExpr": "( ( 64 * UNC_M_PMM_RPQ_INSERTS / 1000000000 ) / d=
uration_time )",
> +        "MetricGroup": "Mem;MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Read_BW"
> +    },
> +    {
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Write=
s [GB / sec]",
> +        "MetricExpr": "( ( 64 * UNC_M_PMM_WPQ_INSERTS / 1000000000 ) / d=
uration_time )",
> +        "MetricGroup": "Mem;MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Write_BW"
> +    },
> +    {
> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use =
for Writes [GB / sec]",
> +        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000=
 / duration_time",
> +        "MetricGroup": "IoBW;Mem;SoC;Server",
> +        "MetricName": "IO_Write_BW"
> +    },
> +    {
> +        "BriefDescription": "Socket actual clocks when any core is activ=
e on that socket",
> +        "MetricExpr": "uncore_cha_0@event\\=3D0x1@",
> +        "MetricGroup": "SoC",
> +        "MetricName": "Socket_CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Far Branch ( Far Branches =
apply upon transition from application to operating system, handling interr=
upts, exceptions) [lower number means higher occurrence rate]",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
> +        "MetricGroup": "Branches;OS",
> +        "MetricName": "IpFarBranch"
> +    },
> +    {
> +        "BriefDescription": "C1 residency percent per core",
> +        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C1_Core_Residency"
> +    },
> +    {
> +        "BriefDescription": "C6 residency percent per core",
> +        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Core_Residency"
> +    },
> +    {
> +        "BriefDescription": "C2 residency percent per package",
> +        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C2_Pkg_Residency"
> +    },
> +    {
> +        "BriefDescription": "C6 residency percent per package",
> +        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Pkg_Residency"
> +    }
> +]
> --
> 2.25.1
>
