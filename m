Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02050BEF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiDVRsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiDVRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:47:50 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA930DF0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:44:55 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id v133so8089631vsv.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B5OLyPzDad+a9/JvoswRLL9dkqWt3XLCqj2yVlzJ3g=;
        b=EXx39caVzrDVxXmzeFHNJ/VpA0Vf9nhcaUODJblSmmzfQCqSIclIq3k/72jlhOe7xU
         mxS7DiSX8wD9WeA0yp1NbvWAVdMNUxuU4gaIzQh8JJ8fyCnu0l5lwI1ZT5DQmvo3o/GL
         giMkmhaOpRIcD3Pxc/WQ0G8uNs49u4slv1VqwwKj8ILUDMpg4P2Gy0pNs+Rl8wxHkt2u
         AaT3fwMdeZX7l84TVbveI7BoObbfwdo20kpJqU2PgPdBHaSHTHXSz6+BpCsCPepPwYib
         Pzvv+mS2caK2fXnFrZHgiNJflVFXQzaIMwIiG9huu4nfjIBK80wyF276rcBbBNxqduav
         T9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B5OLyPzDad+a9/JvoswRLL9dkqWt3XLCqj2yVlzJ3g=;
        b=gHUKOTnutZmbtAq4dNMcb1RbeiWakWEH1gHQ4Jc13KG6xfn5VZhN1LrdH7cLrXncW3
         CKXzYEeFNkQHxBvGOdTxv5jb3JCH60yj25QgiGQBRVv+Gfgqp6WIZcfp1r226UQn6jAX
         OSVi0zx1h+bppfu7XgiSbncIfcj1Iq4+18AdS/RfmIXZvjm81OLdLsOFnJeO8eb6aba0
         qnHxV743zD4aYXhjwpAAjmHCV+7AJqD0zmTTZAJCindmrq2EVL2wrMBrpTeDjuYhweqy
         86yuMoSMJqqs6D+Zs+DjikAsenDsEQKbELZkCyjzcfwC76rBSUIeKk4PIRLMTQFdzoqI
         q+NQ==
X-Gm-Message-State: AOAM532vtIMTBqtxqFNtldSODB9Zuce1vMJi4Z3nvXxm1zv3HnTkT+2z
        2jtcjo4YhO3FAal9MgDKZJ9qa9iqTTfylm+1ovIonw==
X-Google-Smtp-Source: ABdhPJy/drKzRgAnJKsyet9UFIFe9YFVUJ6n+nx0nVlvY8ge39RLxem+hEvlIrX4RwcQ7fJ7ieneEfTfETa2SyrnmFY=
X-Received: by 2002:a05:6102:390e:b0:324:c2b1:f077 with SMTP id
 e14-20020a056102390e00b00324c2b1f077mr1825856vsu.67.1650649219372; Fri, 22
 Apr 2022 10:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220421031738.3168157-1-pcc@google.com> <YmFORWyMAVacycu5@hyeyoo>
 <CAMn1gO5xHZvFSSsW5sTVaUBN_gS-cYYNMG3PnpgCmh7kk_Zx7Q@mail.gmail.com>
 <YmKiDt12Xb/KXX3z@hyeyoo> <CA+fCnZdTPiH_jeiiHCqdTcUdcJ0qajQ0MvqHWTJ1er7w6ABq5A@mail.gmail.com>
In-Reply-To: <CA+fCnZdTPiH_jeiiHCqdTcUdcJ0qajQ0MvqHWTJ1er7w6ABq5A@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 22 Apr 2022 10:40:08 -0700
Message-ID: <CAMn1gO4WOcFqwkcAFi1mXbBrPxz-BqgQ027unx31iCO2fyL=2A@mail.gmail.com>
Subject: Re: [PATCH] mm: make minimum slab alignment a runtime property
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>, cl@linux.org,
        roman.gushchin@linux.dev, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:09 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Fri, Apr 22, 2022 at 2:39 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > > > kasan_hw_tags_enabled() is also false when kasan is just not initialized yet.
> > > > What about writing a new helper something like kasan_is_disabled()
> > > > instead?
> > >
> > > The decision of whether to enable KASAN is made early, before the slab
> > > allocator is initialized (start_kernel -> smp_prepare_boot_cpu ->
> > > kasan_init_hw_tags vs start_kernel -> mm_init -> kmem_cache_init). If
> > > you think about it, this needs to be the case for KASAN to operate
> > > correctly because it influences the behavior of the slab allocator via
> > > the kasan_*poison* hooks. So I don't think we can end up calling this
> > > function before then.
> >
> > Sounds not bad. I wanted to make sure the value of arch_slab_minaligned()
> > is not changed during its execution.
> >
> > Just some part of me thought something like this would be more
> > intuitive/robust.
> >
> > if (systems_supports_mte() && kasan_arg != KASAN_ARG_OFF)
> >         return MTE_GRANULE_SIZE;
> > else
> >         return __alignof__(unsigned long long);
>
> Hi Hyeonggon,
>
> We could add and use kasan_hw_rags_requested(), which would return
> (systems_supports_mte() && kasan_arg != KASAN_ARG_OFF).
>
> However, I'm not sure we will get a fully static behavior:
> systems_supports_mte() also only starts returning proper result at
> some point during CPU bring-up if I'm not mistaken.
>
> Thanks!

Yes, either way we are going to rely on something that hasn't
obviously been initialized yet, so I think we should stick with what I
have since it's used by the rest of the KASAN code as well.

Peter
