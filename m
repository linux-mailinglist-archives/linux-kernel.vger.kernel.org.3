Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB64E533D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbiCWNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244320AbiCWNiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:38:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076E7890E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:36:40 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h63so1655205iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FQgYBAsErSA0oer7QMlQ/bPAVMnnC+mA8O5EU9gYhE=;
        b=NRryz7C/CBrDgsQBcaN2kMLAwOzoDH2ug5A383MR3vdPIM05sEaWuMxYA+dWsnERtd
         WEF3wo/5Ggo92cgi4BjRtv9NYLZlx6mGxAkPDRtcL+eDzmhIPAvM7SoLiRLPpSGrQckb
         mqXoB1djf+8/rdhZ1rwqKIKZZqmoixyaRhzX1mhxaCDvtl1tUZ3q0/QgMe46t6fa6fTo
         blojXPt48hKe8DzkMltRNkP7i5qekdL/bi0RZYA10fK/EGfeEkI8/Ie2hMr8kl/oBKTb
         sozfGvxECdMjZtgsoRIFkPPmnu2LBB3fz+09DaSryPwEctuNmKI32yvZKOZSFLpMCFNU
         TAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FQgYBAsErSA0oer7QMlQ/bPAVMnnC+mA8O5EU9gYhE=;
        b=QZxcFmKD7YKmQdHUVuds35gzjt/4g/MDnKbszMyNzTLNSVeLM1lnHpEQO4fY64pWLu
         /qTmbo+UwGddoqMKMxESQRaDKh5MoeIkuzO+66pEMsRRV2dmAUVx7AERli/q/MaEq1wQ
         FzXdSPPC8RCISxkjLeF1jeKREdzENlyTL9se6uWAbKnzgIltdL8wlj6CxW0MjYTb3ImJ
         kHfv+AMkz5/PNz/aU/c6Y/uRzJHg7mK2mqg7Dixc0NNXazWmk/wi19czZRUwoqIsjKDs
         sNDGr8FMHLl3cyblgHgLBjwzRPaaqWXYytZC6eK7uy2cT4hityOMqejvoDQCl84tght6
         oIOg==
X-Gm-Message-State: AOAM530wZwgg2tmRE5e5lhX3VCnhuIXRprXILdSzwAtkBulEnP1m9vRO
        XPRXQT8sBNBia3oYasKIA2Tl914TqSIn7Y8MCf8=
X-Google-Smtp-Source: ABdhPJz6vyLn/hfvoZ5H7cTB+dmb5THdx0hRYenJ9lwl09n52Z7nCI+eX+KvZKpsuMSGNFrjCWKcDHmceXzeblftEgc=
X-Received: by 2002:a05:6638:4881:b0:321:6522:2cbd with SMTP id
 ct1-20020a056638488100b0032165222cbdmr3282446jab.9.1648042600126; Wed, 23 Mar
 2022 06:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1643047180.git.andreyknvl@google.com> <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
 <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz> <YjsaaQo5pqmGdBaY@linutronix.de>
In-Reply-To: <YjsaaQo5pqmGdBaY@linutronix.de>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 23 Mar 2022 14:36:29 +0100
Message-ID: <CA+fCnZeG5DbxcnER1yWkJ50605_4E1xPtgeTEsSEc89qUg4w6g@mail.gmail.com>
Subject: Re: [PATCH v6 27/39] kasan, mm: only define ___GFP_SKIP_KASAN_POISON
 with HW_TAGS
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 2:02 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-03-23 12:48:29 [+0100], Vlastimil Babka wrote:
> > > +#ifdef CONFIG_KASAN_HW_TAGS
> > >  #define ___GFP_SKIP_KASAN_POISON   0x1000000u
> > > +#else
> > > +#define ___GFP_SKIP_KASAN_POISON   0
> > > +#endif
> > >  #ifdef CONFIG_LOCKDEP
> > >  #define ___GFP_NOLOCKDEP   0x2000000u
> > >  #else
> > > @@ -251,7 +255,9 @@ struct vm_area_struct;
> > >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> > >
> > >  /* Room for N __GFP_FOO bits */
> > > -#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
> > > +#define __GFP_BITS_SHIFT (24 +                                     \
> > > +                     IS_ENABLED(CONFIG_KASAN_HW_TAGS) +    \
> > > +                     IS_ENABLED(CONFIG_LOCKDEP))
> >
> > This breaks __GFP_NOLOCKDEP, see:
> > https://lore.kernel.org/all/YjoJ4CzB3yfWSV1F@linutronix.de/
>
> This could work because ___GFP_NOLOCKDEP is still 0x2000000u. In
>         ("kasan, page_alloc: allow skipping memory init for HW_TAGS")
>         https://lore.kernel.org/all/0d53efeff345de7d708e0baa0d8829167772521e.1643047180.git.andreyknvl@google.com/
>
> This is replaced with 0x8000000u which breaks lockdep.
>
> Sebastian

Hi Sebastian,

Indeed, sorry for breaking lockdep. Thank you for the report!

I wonder what's the proper fix for this. Perhaps, don't hide KASAN GFP
bits under CONFIG_KASAN_HW_TAGS? And then do:

#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))

Vlastimil, Andrew do you have any preference?

If my suggestion sounds good, Andrew, could you directly apply the
changes? They are needed for these 3 patches:

kasan, page_alloc: allow skipping memory init for HW_TAGS
kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS

As these depend on each other, I can't send separate patches that can
be folded for all 3.

Thanks!
