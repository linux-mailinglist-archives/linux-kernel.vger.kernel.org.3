Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F468513E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbiD1V7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348288AbiD1V7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:59:19 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E9580C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:56:03 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c15so2271941uav.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykl24436SaU3yo8134eJXPByhNLIxnoisxRIQCMfPNU=;
        b=OYu5UJiojOCJcf+bfjl+7mPHz/EWWUDTzXAD/6tENRmjCYCZ90t03VyG4kKPUSUIik
         Tp6T67U+oz784+GfWsihRuRDungG+sOW09ZOInLUUjAJeO2POKKWQrE8f1JrakYe3IYV
         T/wBJVKrp2c8LiiMg5BWOtletnbd3OjIBOkGOu8TSriEDHvQcsliMsI0Y+gPmFL/fmnY
         l7r6xLRLmfkNjeLcH4NXNggVpyO3SWIdhB8RX/uBrKtWyonF16GR3Uat1yndrGEsB6yQ
         QbE9aucSPGz1jBJ6UGo1By1znTJTtiPmFHqpuxypaXfDkmttIcPJuDYhw9GSiF5rrmqO
         8sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykl24436SaU3yo8134eJXPByhNLIxnoisxRIQCMfPNU=;
        b=0cryUO3OS3QHePKZUadu49Mrz4ZxCERLUxNu5D1+yCCPYcU7iJDbnnqr9dWL+gXyMM
         dRMShcM/yOsP7d2eO1pogo49XqLlewc+a2f6z+d7gehOS60CC/brOaOtBeQtfVnGXmiv
         WSM+Yatdii5JIQeHusMvlyrcnb67n/PsToOiYMDzblWZogjpQa64gW1l3BmJo1/0L484
         o/cL12cUnD82did5cfJBDR/umQxMa46Ujevy6XQAQH613ZxdJpyF40sa3R1UhL5hlYgb
         FNNQdK9gNTbta99nuduz4oatPGBleUV7tjAbRonQOQQ8JCV9/fe4LcVFkW8HQ4QlH7GF
         m7MQ==
X-Gm-Message-State: AOAM533R0cS7QYbW4ceUI9eeEEe1OVNsOEMSJJBjomckna42T11vICVt
        RQjDeytDNS4v9QVVrQUGDPpwVXG0ahKjbieLtOjncQ==
X-Google-Smtp-Source: ABdhPJx0EqFUFPkWRHxfFBGbweZrmSs8OVh4W2+Tz0hiwIBGnXxj8QBMaPt7l0rXQZfXNnDthfcm5PZzBs2XYv2CYIg=
X-Received: by 2002:ab0:7308:0:b0:35f:acfb:c011 with SMTP id
 v8-20020ab07308000000b0035facfbc011mr10636031uao.51.1651182962546; Thu, 28
 Apr 2022 14:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220427195820.1716975-1-pcc@google.com> <20220427195820.1716975-2-pcc@google.com>
 <20220427132738.fdca02736b5d067c92185c5b@linux-foundation.org>
In-Reply-To: <20220427132738.fdca02736b5d067c92185c5b@linux-foundation.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 28 Apr 2022 14:55:51 -0700
Message-ID: <CAMn1gO4sdaqZDoa0CErkTOaP=z2Y_ZitPck9opdXNbexdLaVOg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: make minimum slab alignment a runtime property
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>, roman.gushchin@linux.dev,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
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

On Wed, Apr 27, 2022 at 1:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 27 Apr 2022 12:58:20 -0700 Peter Collingbourne <pcc@google.com> wrote:
>
> > When CONFIG_KASAN_HW_TAGS is enabled we currently increase the minimum
> > slab alignment to 16. This happens even if MTE is not supported in
> > hardware or disabled via kasan=off, which creates an unnecessary
> > memory overhead in those cases. Eliminate this overhead by making
> > the minimum slab alignment a runtime property and only aligning to
> > 16 if KASAN is enabled at runtime.
> >
> > On a DragonBoard 845c (non-MTE hardware) with a kernel built with
> > CONFIG_KASAN_HW_TAGS, waiting for quiescence after a full Android
> > boot I see the following Slab measurements in /proc/meminfo (median
> > of 3 reboots):
> >
> > ...
> >
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3009,10 +3009,9 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
> >       objp += obj_offset(cachep);
> >       if (cachep->ctor && cachep->flags & SLAB_POISON)
> >               cachep->ctor(objp);
> > -     if (ARCH_SLAB_MINALIGN &&
> > -         ((unsigned long)objp & (ARCH_SLAB_MINALIGN-1))) {
> > -             pr_err("0x%px: not aligned to ARCH_SLAB_MINALIGN=%d\n",
> > -                    objp, (int)ARCH_SLAB_MINALIGN);
> > +     if ((unsigned long)objp & (arch_slab_minalign() - 1)) {
> > +             pr_err("0x%px: not aligned to arch_slab_minalign()=%d\n", objp,
> > +                    (int)arch_slab_minalign());
>
> printf/printk know about size_t.  Use %zu, no cast needed.  But...
>
> >       }
> >       return objp;
> >  }
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 2b3206a2c3b5..33cc49810a54 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -154,8 +154,7 @@ static unsigned int calculate_alignment(slab_flags_t flags,
> >               align = max(align, ralign);
> >       }
> >
> > -     if (align < ARCH_SLAB_MINALIGN)
> > -             align = ARCH_SLAB_MINALIGN;
> > +     align = max_t(size_t, align, arch_slab_minalign());
>
> max_t/min_t are nature's way of telling us "you screwed up the types".
>
> So what type _is_ slab alignment?  size_t seems sensible, but the code
> prefers unsigned int.  So how about we stick with that?
>
>
> This compiles.  Still some max_t's in slob.c because I was too lazy to
> go fix the type of ARCH_KMALLOC_MINALIGN.
>
> Shrug, I don't know if we can be bothered.   You decide :)

Hi Andrew,

No strong opinions here. I'm happy with the fixup that you added to
your tree on top of my patch.

Peter
