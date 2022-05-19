Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4552E0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbiESXvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343814AbiESXvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:51:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C50C167E9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h5so8191279wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRcoMyrslj4bOAY/eW8WGx80U8klEQk6fgVVLvwb9XA=;
        b=n6m8TTgv2IwWJDGLGmsOlLSpsjea2srSEInWca1mtXg54d6wSNG6FLta8vqeZoYVjF
         /beNGSxaZHYhcTmypJY+FnwQ4Ms9qrZrHXlTUbWVEKR9fgIsqRFRWP6/l5vL8v79HD1G
         KRKNRp/J1nf9EHyhGx8rbBJVfh96oLMG+C/AYHuP4nEF5f7Vo7+OE7as3GKJvfQpov1w
         e3r4cvjKK4Sm78f1BK+mIaYW04KIlo3rVjejY4H8IZi/4xLvrMD1OxfIfuQG1ZnKHHxo
         RZvp7baaCu4oemm+MfNvvApShPHL/WNiuWwrt6HoLHmncX4ZHXKynNZ83Zk336wVWM7i
         tMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRcoMyrslj4bOAY/eW8WGx80U8klEQk6fgVVLvwb9XA=;
        b=5aLrVCfCfdyuy5bbWE2/a8dn/s454GRf/9P86O92viTyrzLaRNLZoz4Mg3zBmuj0D2
         xBQFDk/hb3QbCPFjpYEpKca+WVeAk0Vwnd31fwyXzKVjrGGpWt3C9M24bxH5K24jzYvP
         u2TQcaGIsgkGV6ovNZ22OEUe9cm5WfeliRLrtSEEfkXnd4auPkx8AhwDl819UGioXnff
         d3+GpdyOJmtuavwcZqzm5oYeTt4V5MLV3QdlWyINtncS4/6b3PqBA9ymdnVXrssXX9OC
         6EVWcAnaUDynz7qxa/rJT8S3TYEdvLK1Amth5xyxgYYSI3/Y14rwVxf5zTon1ZsqAVsQ
         QqPg==
X-Gm-Message-State: AOAM532pFhqqRahWFcgD46F0nz0hM+dfCVPnT5ek3TouHyHk3WjYXluG
        QwW2aCePGA06WU3RLyDyhrSIkvkrhaKBWZr+IfqDjA==
X-Google-Smtp-Source: ABdhPJzKtQ78ONkLHremZq8wLSoKfoq8D2Wb2ImyXwDE8WvdDA10NMh3Ad8EfD1ZLcOsod7SFwd2cyqonewRi2vdJos=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr6036237wrd.375.1653004271689; Thu, 19
 May 2022 16:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-6-ravi.bangoria@amd.com>
In-Reply-To: <20220519054355.477-6-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 16:50:58 -0700
Message-ID: <CAP-5=fWP42=AW9zr5ULM3_XL4pOhtTcLSr9kjvbRiH_EivO9JA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] perf script ibs: Support new IBS bits in raw trace dump
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Interpret Additional set of IBS register bits while doing
> perf report/script raw dump.
>
> IBS op pmu ex:
>   $ sudo ./perf record -c 130 -a -e ibs_op/l3missonly=1/ --raw-samples
>   $ sudo ./perf report -D
>   ...
>   ibs_op_ctl:     0000004500070008 MaxCnt       128 L3MissOnly 1 En 1
>         Val 1 CntCtl 0=cycles CurCnt        69
>   ibs_op_data:    0000000000710002 CompToRetCtr     2 TagToRetCtr   113
>         BrnRet 0  RipInvalid 0 BrnFuse 0 Microcode 0
>   ibs_op_data2:   0000000000000002 CacheHitSt 0=M-state RmtNode 0
>         DataSrc 2=A peer cache in a near CCX
>   ibs_op_data3:   000000681d1700a1 LdOp 1 StOp 0 DcL1TlbMiss 0
>         DcL2TlbMiss 0 DcL1TlbHit2M 0 DcL1TlbHit1G 1 DcL2TlbHit2M 0
>         DcMiss 1 DcMisAcc 0 DcWcMemAcc 0 DcUcMemAcc 0 DcLockedOp 0
>         DcMissNoMabAlloc 1 DcLinAddrValid 1 DcPhyAddrValid 1
>         DcL2TlbHit1G 0 L2Miss 1 SwPf 0 OpMemWidth  8 bytes
>         OpDcMissOpenMemReqs  7 DcMissLat   104 TlbRefillLat     0
>
> IBS Fetch pmu ex:
>   $ sudo ./perf record -c 130 -a -e ibs_fetch/l3missonly=1/ --raw-samples
>   $ sudo ./perf report -D
>   ...
>   ibs_fetch_ctl:  3c1f00c700080008 MaxCnt     128 Cnt     128 Lat   199
>         En 1 Val 1 Comp 1 IcMiss 1 PhyAddrValid        1 L1TlbPgSz 4KB
>         L1TlbMiss 0 L2TlbMiss 0 RandEn 0 L2Miss 1 L3MissOnly 1
>         FetchOcMiss 1 FetchL3Miss 1
>
> With the DataSrc extensions, the source of data can be decoded among:
>  - Local L3 or other L1/L2 in CCX.
>  - A peer cache in a near CCX.
>  - Data returned from DRAM.
>  - A peer cache in a far CCX.
>  - DRAM address map with "long latency" bit set.
>  - Data returned from MMIO/Config/PCI/APIC.
>  - Extension Memory (S-Link, GenZ, etc - identified by the CS target
>     and/or address map at DF's choice).
>  - Peer Agent Memory.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Looks good, but I think part of the previous patch should also be in this one.

Thanks,
Ian
> ---
>  tools/perf/util/amd-sample-raw.c | 64 +++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
> index 3b623ea6ee7e..63303f583bc0 100644
> --- a/tools/perf/util/amd-sample-raw.c
> +++ b/tools/perf/util/amd-sample-raw.c
> @@ -18,6 +18,7 @@
>  #include "pmu-events/pmu-events.h"
>
>  static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
> +static bool zen4_ibs_extensions;
>
>  static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
>  {
> @@ -39,6 +40,7 @@ static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
>         };
>         const char *ic_miss_str = NULL;
>         const char *l1tlb_pgsz_str = NULL;
> +       char l3_miss_str[sizeof(" L3MissOnly _ FetchOcMiss _ FetchL3Miss _")] = "";
>
>         if (cpu_family == 0x19 && cpu_model < 0x10) {
>                 /*
> @@ -53,12 +55,19 @@ static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
>                 ic_miss_str = ic_miss_strs[reg.ic_miss];
>         }
>
> +       if (zen4_ibs_extensions) {
> +               snprintf(l3_miss_str, sizeof(l3_miss_str),
> +                        " L3MissOnly %d FetchOcMiss %d FetchL3Miss %d",
> +                        reg.l3_miss_only, reg.fetch_oc_miss, reg.fetch_l3_miss);
> +       }
> +
>         printf("ibs_fetch_ctl:\t%016llx MaxCnt %7d Cnt %7d Lat %5d En %d Val %d Comp %d%s "
> -              "PhyAddrValid %d%s L1TlbMiss %d L2TlbMiss %d RandEn %d%s\n",
> +               "PhyAddrValid %d%s L1TlbMiss %d L2TlbMiss %d RandEn %d%s%s\n",
>                 reg.val, reg.fetch_maxcnt << 4, reg.fetch_cnt << 4, reg.fetch_lat,
>                 reg.fetch_en, reg.fetch_val, reg.fetch_comp, ic_miss_str ? : "",
>                 reg.phy_addr_valid, l1tlb_pgsz_str ? : "", reg.l1tlb_miss, reg.l2tlb_miss,
> -               reg.rand_en, reg.fetch_comp ? (reg.fetch_l2_miss ? " L2Miss 1" : " L2Miss 0") : "");
> +               reg.rand_en, reg.fetch_comp ? (reg.fetch_l2_miss ? " L2Miss 1" : " L2Miss 0") : "",
> +               l3_miss_str);
>  }
>
>  static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
> @@ -68,9 +77,15 @@ static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
>
>  static void pr_ibs_op_ctl(union ibs_op_ctl reg)
>  {
> -       printf("ibs_op_ctl:\t%016llx MaxCnt %9d En %d Val %d CntCtl %d=%s CurCnt %9d\n",
> -              reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, reg.op_en, reg.op_val,
> -              reg.cnt_ctl, reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
> +       char l3_miss_only[sizeof(" L3MissOnly _")] = "";
> +
> +       if (zen4_ibs_extensions)
> +               snprintf(l3_miss_only, sizeof(l3_miss_only), " L3MissOnly %d", reg.l3_miss_only);
> +
> +       printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d\n",
> +               reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, l3_miss_only,
> +               reg.op_en, reg.op_val, reg.cnt_ctl,
> +               reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
>  }
>
>  static void pr_ibs_op_data(union ibs_op_data reg)
> @@ -84,7 +99,34 @@ static void pr_ibs_op_data(union ibs_op_data reg)
>                 reg.op_brn_ret, reg.op_rip_invalid, reg.op_brn_fuse, reg.op_microcode);
>  }
>
> -static void pr_ibs_op_data2(union ibs_op_data2 reg)
> +static void pr_ibs_op_data2_extended(union ibs_op_data2 reg)
> +{
> +       static const char * const data_src_str[] = {
> +               "",
> +               " DataSrc 1=Local L3 or other L1/L2 in CCX",
> +               " DataSrc 2=A peer cache in a near CCX",
> +               " DataSrc 3=Data returned from DRAM",
> +               " DataSrc 4=(reserved)",
> +               " DataSrc 5=A peer cache in a far CCX",
> +               " DataSrc 6=DRAM address map with \"long latency\" bit set",
> +               " DataSrc 7=Data returned from MMIO/Config/PCI/APIC",
> +               " DataSrc 8=Extension Memory (S-Link, GenZ, etc)",
> +               " DataSrc 9=(reserved)",
> +               " DataSrc 10=(reserved)",
> +               " DataSrc 11=(reserved)",
> +               " DataSrc 12=Peer Agent Memory",
> +               /* 13 to 31 are reserved. Avoid printing them. */
> +       };
> +       int data_src = (reg.data_src_hi << 3) | reg.data_src_lo;
> +
> +       printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
> +               (data_src == 1 || data_src == 2 || data_src == 5) ?
> +                       (reg.cache_hit_st ? "CacheHitSt 1=O-State " : "CacheHitSt 0=M-state ") : "",
> +               reg.rmt_node,
> +               data_src < (int)ARRAY_SIZE(data_src_str) ? data_src_str[data_src] : "");
> +}
> +
> +static void pr_ibs_op_data2_default(union ibs_op_data2 reg)
>  {
>         static const char * const data_src_str[] = {
>                 "",
> @@ -103,6 +145,13 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
>                reg.rmt_node, data_src_str[reg.data_src_lo]);
>  }
>
> +static void pr_ibs_op_data2(union ibs_op_data2 reg)
> +{
> +       if (zen4_ibs_extensions)
> +               return pr_ibs_op_data2_extended(reg);
> +       pr_ibs_op_data2_default(reg);
> +}
> +
>  static void pr_ibs_op_data3(union ibs_op_data3 reg)
>  {
>         char l2_miss_str[sizeof(" L2Miss _")] = "";
> @@ -279,6 +328,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
>                 pmu_mapping += strlen(pmu_mapping) + 1 /* '\0' */;
>         }
>
> +       if (perf_env__find_pmu_cap(env, 0, "ibs_op", "zen4_ibs_extensions"))
> +               zen4_ibs_extensions = 1;
> +
>         if (ibs_fetch_type || ibs_op_type) {
>                 if (!cpu_family)
>                         parse_cpuid(env);
> --
> 2.27.0
>
