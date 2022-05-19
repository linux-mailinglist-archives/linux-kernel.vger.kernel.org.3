Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38552E0CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244246AbiESXrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343776AbiESXr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:47:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE6128161
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:47:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j25so9295550wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPK8wc5zOViATG719VftJnzHbV2j0aW5K7wg+jNhWKg=;
        b=OdTy66Ta0QHJB+ttCi1/JPIkXvmMd0vhCIQ/Y+olgbATvohhIHce9pTkcPFmEIjBgi
         rG0EpbkafRrQxR+IpgVGJCdwT28vMWH8Q+bgHrM2Em37cstckNvzMCGPX5JdnuWKiHnP
         1wxMo5t2VXOtJ9ebhkbD4eNEhko5ff6LRSzxKydfhM9e7+LccjcSC4R0lcHPfACMk3/L
         pOZ3n5im9bhtuLdCTdITtRg/GmqTDqCKCjvJG9/w+IfAqULdrWcc8xYQ4RaLHRhMcSLC
         qsu5xu1YE1h30qil90iTs8mwg2cROF8Znq0QRM7czHE5JCExUdAedWZj4ak9N91veuE4
         m9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPK8wc5zOViATG719VftJnzHbV2j0aW5K7wg+jNhWKg=;
        b=t3BgVFlTkKp0aNqSTdS5/NmlVdF32UxNsPJ9n8wAuZLgoAn5sDWko9rgeuy/NJ8BaK
         Ro13OSiRvwCr5pMNpEimQ6FnY7FUBXTBEYMUpC5gzM7G2n7bJvYN8VDjPW6WSvk5L4Gu
         8MADln8k4uQkGR1Y7dVrNuUME3emr+BYAy3rhFbQ5PQg5GzyRrDnAGQinkQJ7huh2cUy
         bwA+EwVnMH6KzcPeTgS6C9RRlUog8AqdcU5xBRvipShclKpdQ2Gbl2LfjV2vT4Ylcxcw
         0oElo7frXaI+M0LV6R5PWyevoHhTAVlPQe6tkL3UNpqKrgcJAE/tSdvOaMFsQkZj8zDq
         z1EQ==
X-Gm-Message-State: AOAM530swJJlFStL5NjkzfQNwRs0UGvRCulGRPQhgWQBvGu6VceWUN+z
        c1cUq/IP9tHjTn+y0hcUBR0z40NGng1fn4eZSYTcVQ==
X-Google-Smtp-Source: ABdhPJyUKCEf/GzuZtEA40j66mf5zlFXj4Y7JyuPq42sGiR2I6swgRotPczVvOhouaUPQ0E49qHLBPnNGKySLYXFXmI=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr5990109wri.343.1653004041339; Thu, 19
 May 2022 16:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-4-ravi.bangoria@amd.com>
In-Reply-To: <20220519054355.477-4-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 16:47:07 -0700
Message-ID: <CAP-5=fWY+e-HrXmWMAqgucWmVgRBv0F=2NSkSkLgX4CRDYjupg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf/x86/ibs: Add new IBS register bits into header
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
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
> has been introduced in IBS registers to exploit these features. Define
> these new bits into arch/x86/ header.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

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
> 2.27.0
>
