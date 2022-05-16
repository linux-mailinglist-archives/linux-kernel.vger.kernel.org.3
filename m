Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CDB528DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbiEPTHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345310AbiEPTHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:07:51 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A723EBBB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:07:44 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id q2so16553339vsr.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWAxrdR5MaSIJGf1NCsnDGoP/pNAH3dgri1jIig7/WQ=;
        b=L1OO3ikPxUsnuvk24K4xQi1xBtQU5QlI4zglvV9yqAOl96PTxDQGihV1q2Vusvjmcg
         LZ61nVpJZFYYCN1hTZ+nOqMfotiYuW8hmszKGw/dPQkEtIz0SwLiqufD8jf3bT6wFrtL
         cV1K3IPnjquDDje0HNge23VzT8BByiJu5VWRC9vWSkL1JW0W8Qq4aBgTqqYYXNrwc9pJ
         UlLDpFE2vSZIMS/YJeTiy9FyGeRK6sNKURqKyjSy3aq7yeuMDYcMt+TpuISLvuXsAFbQ
         8ZyMRBZ13frZxQlSB4NKqjyD5OJkqYlD8gab0EVuSG/UWp2vXmN37CCicdSt8BCqy9TF
         adkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWAxrdR5MaSIJGf1NCsnDGoP/pNAH3dgri1jIig7/WQ=;
        b=5oDgpUdd++wAwjBC02fqyNU3onJRTd6LOcFu5K6EYe9rvrpnIAaWE/EsbHiSHaTzh7
         ZjhuIKXMVhXrP9+jt8mVgMXvs+GmamJGOmjCylv/WG/1A9ADjblYt6sI5QRgj7DqfPyr
         4Aobp2h7crnfFip5/SSEAw8YTlr9du/RatHcqleF2kzRdOQPkhsZQSy4+0vKW6CSPSZp
         g2/EVdn1sL84qYvrfKaRrynLpPGSGtZw54RIS/mo3r1+dy1ygJURErkgJ981b5Hbb1gm
         jepwMB/3Q57esLt9bSmJAn6UbNNVXrX0YHDRULRaeVjOQ9VlESMsLyqcE8+PDE8//FAm
         aEyg==
X-Gm-Message-State: AOAM532HUxbSnHruwiGXk8CzEA+Oa75PV9sjor8l1ddCJcc42/qZGJ3P
        9jlpa89Lt4rc3NAZy/uCvfwEeHTSAay8v3x8Ho6kPA==
X-Google-Smtp-Source: ABdhPJwee0oI/+FmObmF/G2EFZNGI6WxUkLk8QqpAL5/6WIAApO3QDVZplosgHsUFK7DMPE2z/cNQe5iDY90h7LvMHM=
X-Received: by 2002:a05:6102:32c7:b0:335:7d41:23e4 with SMTP id
 o7-20020a05610232c700b003357d4123e4mr5820031vss.67.1652728063519; Mon, 16 May
 2022 12:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220516055055.2734840-1-eranian@google.com> <ccbd2401-0de4-d4e1-2e41-92865113560d@intel.com>
In-Reply-To: <ccbd2401-0de4-d4e1-2e41-92865113560d@intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 16 May 2022 12:07:31 -0700
Message-ID: <CABPqkBQcBGmbyO2QTxnmVWwuWvk8brFaXi6J18xk0EyB70ZAtA@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: fix min_cbm_bits for AMD
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        babu.moger@amd.com, "x86@kernel.org" <x86@kernel.org>
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

On Mon, May 16, 2022 at 9:35 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> + x86 maintainers
>
> Hi Stephane,
>
> Thank you very much for catching this. While the fix is onto something
> I would prefer the fix to be obvious and not a side effect of bit
> checking in an empty bitmap.
>
Are you asking for me to add a comment on the modified line or are you asking
for a change in cbm_validate()? There, I could add an empty_bitmask check to
that if.

> When resubmitting, please ensure the subject starts with an uppercase letter.
>
ok.

> Also, when resubmitting, could you please add x86@kernel.org? The resctrl
> patches are routed upstream by the x86 architecture maintainers.
>
ok.

> On 5/15/2022 10:50 PM, Stephane Eranian wrote:
> > AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:
>
> Please watch the line lengths. Getting a pass from
> scripts/checkpatch.pl would help.
>
> >
> >       r->cache.arch_has_empty_bitmaps = true;
> >
>
> With the above the needed information is present. Changing min_cbm_bits
> is not required.
>
> > However given the unified code in cbm_validate(), checking for
> >
> >     val == 0 && !arch_has_empty_bitmaps
> >
> > is not enough because you also have in cbm_validate():
> >       if ((zero_bit - first_bit) < r->cache.min_cbm_bits)
>
> You are correct, but that relies on checking of bits in a bitmap
> where no bits are set so this fix relies on the failure cases of the earlier
> find_first_bit() and find_next_zero_bit() to be used. I find that it
> obscures the scenario being handled.
>
> The code should be clear and to that end I think it would be simpler to
> explicitly check that an empty bitmap is provided and not search
> for bits at all when that is the case.
>
> Something like this before the bit parsing starts:
>         if (r->cache.arch_has_empty_bitmaps && val == 0)
>                 goto done;
>
>         /* Skip bit parsing */
>
> done:
>         *data = val;
>         return true;
>
> >
> > Default value for if r->cache.min_cbm_bits = 1
> >
> > Leading to:
> >
> > $ cd /sys/fs/resctrl
> > $ mkdir foo
> > $ cd foo
> > $ echo L3:0=0 > schemata
> > -bash: echo: write error: Invalid argument
> >
> > Patch initializes r->cache.min_cbm_bits to 0 for AMD.
> >
>
> Seems like a Fixes tag is needed.
> Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")
>
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index bb1c3f5f60c8..14782361ebb7 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -897,6 +897,7 @@ static __init void rdt_init_res_defs_amd(void)
> >                       r->cache.arch_has_sparse_bitmaps = true;
> >                       r->cache.arch_has_empty_bitmaps = true;
> >                       r->cache.arch_has_per_cpu_cfg = true;
> > +                     r->cache.min_cbm_bits = 0;
> >               } else if (r->rid == RDT_RESOURCE_MBA) {
> >                       hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
> >                       hw_res->msr_update = mba_wrmsr_amd;
>
> Reinette
