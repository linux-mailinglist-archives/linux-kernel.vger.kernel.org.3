Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDD53C07B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiFBVtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239500AbiFBVtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:49:07 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E771DA73;
        Thu,  2 Jun 2022 14:49:06 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso8445488fac.8;
        Thu, 02 Jun 2022 14:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKkACeUL3LnAeVi71plphhcyfzIMOc+gua2iqwocQuA=;
        b=O1DzTtfrK8Mk05CimMPCEVEO9G6WQDcJ6YC9hgeivVx3a0c8eX4Nkb9qSNHSssJIcE
         OuPE+92gOJTiqRTlPqxoFdSjswJaW46gTPJwwKuMUdqR1MIGFQEXNM8TdEzwLp8ivXuu
         op/Hea0F5vCzXWcDmOTiYFtAUi/11w7yz3IWzCZGgMYyc20amfTo7EwAZhqVT+2DP/RD
         YCXi6wC9Yy05bPc/U4PuG0pymnaZeIZBqaVt+97JlsDUK2a20NvvIfKPTaqK9RmS26wZ
         HuoIhaQHlyj35BNs0XblmtZRfE3ubAJulXHpfhwrBad4YWMNdQsaNF1AoQ34jW15YeyB
         xeeg==
X-Gm-Message-State: AOAM5304Hc9FweEspfN7D/iw5O3OdhEmnyyfL669lYaXFrZNZUOpSszN
        oC+fzcLA2zyA3YfcX5TV6ZtBKWQEoR+OZU0ViCw=
X-Google-Smtp-Source: ABdhPJzTNfwNLPb8t0j70UsQFfAD6cHsQLI7RL+cnbz+YeaJwJGN8IdT7M9aEL4pg2fsFIUwircwniQqkK3pSNX4NwI=
X-Received: by 2002:a05:6871:215:b0:f1:8bf5:23ab with SMTP id
 t21-20020a056871021500b000f18bf523abmr3875055oad.92.1654206545995; Thu, 02
 Jun 2022 14:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220601032608.1034-1-ravi.bangoria@amd.com> <20220601032608.1034-7-ravi.bangoria@amd.com>
In-Reply-To: <20220601032608.1034-7-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Jun 2022 14:48:55 -0700
Message-ID: <CAM9d7ch3UOgT0mcF6Sxde5dHUOS9ux7DwG7sE8+s5Das54cHzw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf/x86/ibs: Add new IBS register bits into header
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 8:30 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
> has been introduced in IBS registers to exploit these features. Define
> these new bits into arch/x86/ header.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Acked-by: Ian Rogers <irogers@google.com>

Isn't it a part of kernel changes?

Thanks,
Namhyung


> ---
>  arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
> index aabdbb5ab920..f3eb098d63d4 100644
> --- a/arch/x86/include/asm/amd-ibs.h
> +++ b/arch/x86/include/asm/amd-ibs.h
> @@ -29,7 +29,10 @@ union ibs_fetch_ctl {
>                         rand_en:1,      /* 57: random tagging enable */
>                         fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
>                                          *      (needs IbsFetchComp) */
> -                       reserved:5;     /* 59-63: reserved */
> +                       l3_miss_only:1, /* 59: Collect L3 miss samples only */
> +                       fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
> +                       fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
> +                       reserved:2;     /* 62-63: reserved */
>         };
>  };
>
> @@ -38,14 +41,14 @@ union ibs_op_ctl {
>         __u64 val;
>         struct {
>                 __u64   opmaxcnt:16,    /* 0-15: periodic op max. count */
> -                       reserved0:1,    /* 16: reserved */
> +                       l3_miss_only:1, /* 16: Collect L3 miss samples only */
>                         op_en:1,        /* 17: op sampling enable */
>                         op_val:1,       /* 18: op sample valid */
>                         cnt_ctl:1,      /* 19: periodic op counter control */
>                         opmaxcnt_ext:7, /* 20-26: upper 7 bits of periodic op maximum count */
> -                       reserved1:5,    /* 27-31: reserved */
> +                       reserved0:5,    /* 27-31: reserved */
>                         opcurcnt:27,    /* 32-58: periodic op counter current count */
> -                       reserved2:5;    /* 59-63: reserved */
> +                       reserved1:5;    /* 59-63: reserved */
>         };
>  };
>
> @@ -71,11 +74,12 @@ union ibs_op_data {
>  union ibs_op_data2 {
>         __u64 val;
>         struct {
> -               __u64   data_src:3,     /* 0-2: data source */
> +               __u64   data_src_lo:3,  /* 0-2: data source low */
>                         reserved0:1,    /* 3: reserved */
>                         rmt_node:1,     /* 4: destination node */
>                         cache_hit_st:1, /* 5: cache hit state */
> -                       reserved1:57;   /* 5-63: reserved */
> +                       data_src_hi:2,  /* 6-7: data source high */
> +                       reserved1:56;   /* 8-63: reserved */
>         };
>  };
>
> --
> 2.31.1
>
