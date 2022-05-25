Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88C4533D65
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiEYNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiEYNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:10:55 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C1A33AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:10:42 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id u188so4150714vku.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYAICjqRvgyMz1thbRruRdQ1rSG+gF8UeVbCAGqR6E0=;
        b=tjWdemCGcXL6zSwVer93t4YhPEZGVlDpqHlRNLKTKjcGn1caC6oUaDgsHPdE27Ltbf
         goDOX+fFqrk4cQvPxSr1NW1JDvNW6UN72CEzkSTSSqBT1k9/Ejqscv14TfCwu8grFTSW
         7PgnyBg8MGwOMj7kWOV/vc2DJM7MR6nGlyRSLvFHdywIyb15PbxiUVC28MJeGAJOQqHJ
         lzLMMehMATF2VdpopRdyJzEP8QcGGxB5w5UTqATnEJ05y2k77iK7KFb3YLZvzLNfTBcI
         nhS2sd5YztYfiVU9ecxU4+aSE+upSwfj5oFMGAoXM/YLyeLKBtWqWeQBaUvTzINv5oAV
         dpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYAICjqRvgyMz1thbRruRdQ1rSG+gF8UeVbCAGqR6E0=;
        b=fOSqu3usDQ1CauQFH3FG8w/FHy3QtcVThOXk3CTfeS/U9M0X8A4zp1Di5HjToo5iQz
         KZQkfoVoCZupLIZhDyYvbv/Ab4Bo25bLNlVuQ2FiJfmC0CHfe8M540Ixewv5Fg8CaaVU
         TkZf/Q9MO+WDOPj+L3/OSYmlHC/KFN8lIfxN/NZ5wFpxxsilJa2QLvx7iZuGm5Ml0yM9
         uwG7D1wnjLfskYoPYg0f6KyhRFQpx05MqUx7F0+bu7CTu82DX7pVW0N6ymJSOzC7viEN
         6Kkr7ju+6SJ/FSoM/Xas3HVg6bg3PlC+4IwvxAmsAsteeD4O9i+ywgqeLDXJqfgbKJJi
         ub+g==
X-Gm-Message-State: AOAM533+Fp+YjwRvzc1cWsn68OxAxKVaMBigdkU6J2ePMglSS/5qI0cL
        TNBsnQHYKuc90fRt41bOGLhzz0LFozSIXkyeDSb3MA==
X-Google-Smtp-Source: ABdhPJzNsdSB/pGptNhbpgiu+F4Jo/Iyl05S9uS1p5bNl3TFpMIWMNdhSuHIaj+7RexokbcCxtDLUaqISio68WE3DSc=
X-Received: by 2002:a05:6122:221f:b0:343:f3d4:87cb with SMTP id
 bb31-20020a056122221f00b00343f3d487cbmr11449096vkb.13.1653484241747; Wed, 25
 May 2022 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220517001234.3137157-1-eranian@google.com> <YoPOWC0waMuSlvI6@fyu1.sc.intel.com>
 <5a634c10-103e-6f3e-e51b-db26b2bc90a5@intel.com> <YoPa5L2jNYl/sFhw@fyu1.sc.intel.com>
 <0077efdf-ab64-2924-c290-cd940977b818@intel.com> <YoUgKB5svdI/blZa@fyu1.sc.intel.com>
In-Reply-To: <YoUgKB5svdI/blZa@fyu1.sc.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 25 May 2022 16:10:30 +0300
Message-ID: <CABPqkBTU_StuH_zyZ=22wtV5_V8YDnxRpTSjy4Bg0s=mk8PahQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-kernel@vger.kernel.org, babu.moger@amd.com, x86@kernel.org
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

On Wed, May 18, 2022 at 7:36 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> Hi, Babu,
>
> On Tue, May 17, 2022 at 11:10:40AM -0700, Reinette Chatre wrote:
> > On 5/17/2022 10:27 AM, Fenghua Yu wrote:
> > > On Tue, May 17, 2022 at 09:49:22AM -0700, Reinette Chatre wrote:
> > >> On 5/17/2022 9:33 AM, Fenghua Yu wrote:
> > >>> On Mon, May 16, 2022 at 05:12:34PM -0700, Stephane Eranian wrote:
> > >>>> AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:
> > >>> ...
> > >>>> @@ -107,6 +107,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> > >>>>          first_bit = find_first_bit(&val, cbm_len);
> > >>>>          zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> > >>>>
> > >>>> +        /* no need to check bits if arch supports no bits set */
> > >>>> +        if (r->cache.arch_has_empty_bitmaps && val == 0)
> > >>>> +                goto done;
> > >>>> +
> > >>>>          /* Are non-contiguous bitmaps allowed? */
> > >>>>          if (!r->cache.arch_has_sparse_bitmaps &&
> > >>>>              (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
> > >>>> @@ -119,7 +123,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> > >>>>                                      r->cache.min_cbm_bits);
> > >>>>                  return false;
> > >>>>          }
> > >>>> -
> > >>>> +done:
> > >>>>          *data = val;
> > >>>>          return true;
> > >>>>  }
> > >>>
> > >>> Isn't it AMD supports 0 minimal CBM bits? Then should set its min_cbm_bits as 0.
> > >>> Is the following patch a better fix? I don't have AMD machine and cannot
> > >>> test the patch.
> > >>>
> > >>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > >>> index 6055d05af4cc..031d77dd982d 100644
> > >>> --- a/arch/x86/kernel/cpu/resctrl/core.c
> > >>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > >>> @@ -909,6 +909,7 @@ static __init void rdt_init_res_defs_amd(void)
> > >>>                   r->cache.arch_has_sparse_bitmaps = true;
> > >>>                   r->cache.arch_has_empty_bitmaps = true;
> > >>>                   r->cache.arch_has_per_cpu_cfg = true;
> > >>> +                 r->cache.min_cbm_bits = 0;
> > >>>           } else if (r->rid == RDT_RESOURCE_MBA) {
> > >>>                   hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
> > >>>                   hw_res->msr_update = mba_wrmsr_amd;
> > >>
> > >> That is actually what Stephane's V1 [1] did and I proposed that
> > >> he fixes it with (almost) what he has in V2 (I think the check
> > >> can be moved earlier before any bits are searched for).
> > >>
> > >> The reasons why I proposed this change are:
> > >> - min_cbm_bits is a value that is exposed to user space and from the
> > >>   time AMD was supported this has always been 1 for those systems. I
> > >>   do not know how user space uses this value and unless I can be certain
> > >>   making this 0 will not affect user space I would prefer not to
> > >>   make such a change.
> > >
> > > But a user visible mismatch is created by the V2 patch:
> >
> > No. V2 does not create a user visible change, it restores original behavior.
> >
> > > User queries min_cbm_bits and finds it is 1 but turns out 0 can be written
> > > to the schemata.
> > >
> > > Is it an acceptable behavior? Shouldn't user read right min_cbm_bits (0)
> > > on AMD?
> >
> > Original AMD enabling set min_cbm_bits as 1 while also supporting 0 to
> > be written to schemata file. Supporting 0 to be written to schemata file
> > was unintentionally broken during one of the MPAM prep patches. This
> > patch fixes that.
> >
> > You are proposing a change to original AMD support that impacts user
> > space API while I find fixing to restore original behavior to
> > be the safest option. Perhaps Babu could pick the preferred solution
> > and I would step aside if you prefer to go with (an improved) V1.
>
> Is it OK for you to set min_cbm_bits to 0 on AMD?
>
I agree with Fenghua here. The proper fix is my v1 which sets the
min_cbm_bits to the value it should have set to from the beginning.
This field is exposed via resctrl fs and it is still fine if the value
changes. Any app is supposed to read the content of the file and not
hardcode
any value or pre-suppose it is always 1.
