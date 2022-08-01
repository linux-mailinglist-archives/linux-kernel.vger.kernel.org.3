Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8098B586D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiHAPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiHAPTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:19:21 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1EE237C7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:19:20 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id r4so1766196vkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nx2PcYaiHqW1lYHUUeUhS477dvADEb3MkfTTwtrPOSw=;
        b=k+/kYR5se5jVtdGNjaAb1TYy8yHoKB3ZOYEAOhfaEUnMxddq52yiGUcpCAszR+f8OY
         E684j66WnJnMMkaXk5uXI6lyoszZYiEJujdlw08cQA/o2cM0SnsSPE3aym2QY5ri/XN3
         6NROXuDBz/ayX8HrX9UWRCqfT32ZqttKvoNuK/wPnlnNK4zaRHpDVe+A4nMpWWutG83R
         4i/eaK+V6/NG8C1gKi0d6dgJFnp7YpoKtgyUh4vXLXC460v4GikCi9yaMy+FEEJB9tlK
         yy29JZmUtNNd33Ld+8Wk20wPxrVgn7s4tL1ll628UOwuSyeYo0Z9crqfC+gEtYGyEU+x
         9crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nx2PcYaiHqW1lYHUUeUhS477dvADEb3MkfTTwtrPOSw=;
        b=TtOE7xAtpsrWBnnAtuDDNV2DmXRCvKeU89CrOTdJnKJziYf1pzM+YGgvNw3ApfhHEd
         hAE76HWJ04yKnzZHjDTRbs0xy2qYz/y6X+Itw32uQJWK/IckmOnLF+fBuei3LtM3onP0
         allMbLOJ5l/xsa2wEr7FfziUEqnDy26OGVfLPMi/Z4uIS3OoBXXeny3OLuXgkPNJz1fR
         5wb0ddWLHI1xdaf4LNuTJchin8KtRn8iRfRY3fMPrRjk/XujyWJonVyWNwujP3Vbmzfv
         to33pSLo2/hGiloodHRQUya8OGZoJrwDV0kecNHbmIBzosK06xJU6CxREtwlDwZxDtOY
         oZTQ==
X-Gm-Message-State: ACgBeo0V4oh+4epfcrbHoQfXw56UABKFUwpq7vPhvBqBpGGet6kAe6+u
        NyhAruWBnkcEe+Zv/Tg1cFPnAAlP89LI8KryHw6b+A==
X-Google-Smtp-Source: AA6agR6F/nAFrpseFKhU1HHqyctxIpyiHif+qSObpPjczQ35kWUud7JNZO6gKPiUeHXot1DUR4PDV/AVQHVZbX1eqCM=
X-Received: by 2002:a1f:b60f:0:b0:377:4f57:fb19 with SMTP id
 g15-20020a1fb60f000000b003774f57fb19mr2809231vkf.26.1659367159450; Mon, 01
 Aug 2022 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBTU_StuH_zyZ=22wtV5_V8YDnxRpTSjy4Bg0s=mk8PahQ@mail.gmail.com>
 <20220725194743.173159-1-babu.moger@amd.com> <5a7abe15-5d0d-6ff0-3248-e6fcd6b92d7d@amd.com>
In-Reply-To: <5a7abe15-5d0d-6ff0-3248-e6fcd6b92d7d@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 1 Aug 2022 18:19:07 +0300
Message-ID: <CABPqkBRjJEVAxBdG3i4f9rW6DDjq9YTE6Bp7Y+PmyedC_k1y9Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
To:     babu.moger@amd.com
Cc:     fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 5:58 PM Moger, Babu <babu.moger@amd.com> wrote:
>
>
> On 7/25/22 14:47, Babu Moger wrote:
> > Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
> >
> > Sorry, I didn't see this thread. Just noticed going thru the archives.
> > Replying using "git send-email" to the thread.
> >
> > Thanks Stephane for the patch. Thanks Fenghua and Reinette for your comments.
> >
> > Stephane, Are you planning to re-submit the patch with Fenghua's proposal?
> > If not I will resubmit with my current patch-set.
>
Haven't had a chance to ge to this yet. But it's been ongoing for a
while, so I am fine
with Fenghua's proposal at this point.

> Didn't see Stephan's response yet. I will add this patch in my QoS series.
>
> Stephan, Let me know if you want me to add your "Signed-off-by".
>
Sure. Thanks.

> Thanks
>
> Babu
>
> >
> > I agree with Fenghua's proposal. Here is my proposal with slight modification.
> >
> > Thanks
> >
> > ==================================================================================
> >
> > Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> >
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index bb1c3f5f60c8..a5c51a14fbce 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >                       .rid                    = RDT_RESOURCE_L3,
> >                       .name                   = "L3",
> >                       .cache_level            = 3,
> > -                     .cache = {
> > -                             .min_cbm_bits   = 1,
> > -                     },
> >                       .domains                = domain_init(RDT_RESOURCE_L3),
> >                       .parse_ctrlval          = parse_cbm,
> >                       .format_str             = "%d=%0*x",
> > @@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >                       .rid                    = RDT_RESOURCE_L2,
> >                       .name                   = "L2",
> >                       .cache_level            = 2,
> > -                     .cache = {
> > -                             .min_cbm_bits   = 1,
> > -                     },
> >                       .domains                = domain_init(RDT_RESOURCE_L2),
> >                       .parse_ctrlval          = parse_cbm,
> >                       .format_str             = "%d=%0*x",
> > @@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
> >                       r->cache.arch_has_sparse_bitmaps = false;
> >                       r->cache.arch_has_empty_bitmaps = false;
> >                       r->cache.arch_has_per_cpu_cfg = false;
> > +                     r->cache.min_cbm_bits = 1;
> >               } else if (r->rid == RDT_RESOURCE_MBA) {
> >                       hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
> >                       hw_res->msr_update = mba_wrmsr_intel;
> > @@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
> >                       r->cache.arch_has_sparse_bitmaps = true;
> >                       r->cache.arch_has_empty_bitmaps = true;
> >                       r->cache.arch_has_per_cpu_cfg = true;
> > +                     r->cache.min_cbm_bits = 0;
> >               } else if (r->rid == RDT_RESOURCE_MBA) {
> >                       hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
> >                       hw_res->msr_update = mba_wrmsr_amd;
>
> --
> Thanks
> Babu Moger
>
