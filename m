Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164FA5A67B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiH3Psc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3PsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563DEB6032
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661874501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbOHhoGxSCdY0/v0Y5mT98E8ZAdTtYHYoFgDmUTVqfA=;
        b=SgKbxPNvPpNXZYxCOIScOyscI0lwQkloYTXf+wI/9BTqPzWndtkwSCDHqT1rIY9bHrtaH+
        BDR9l7NCNarHt19mWVsMfhTTAdzStoXO7S/Gsv8Nr34e5K/ZkyzFrJedtIidOElihyZiVf
        NAYJF/urotMdmIk/Xvp5lIhK9hA6C/s=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-G8yEFCfMMlaTh6J6_E2-8w-1; Tue, 30 Aug 2022 11:48:18 -0400
X-MC-Unique: G8yEFCfMMlaTh6J6_E2-8w-1
Received: by mail-ua1-f72.google.com with SMTP id p4-20020a9f2b04000000b0039f2ed5774aso3653946uaj.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=mbOHhoGxSCdY0/v0Y5mT98E8ZAdTtYHYoFgDmUTVqfA=;
        b=5eZPXNfGwug38s0zUVui9hkWExKC56rTEbIOV68E9BzEuwc3ckciQoR5/UpE1Ha+1u
         eySYsXftjh5X3dZYO8Ewbn6tfTEZTe502ti7aq5w6lC5gge6mSQL7xASL56eAeFBIwFs
         o4dQPRGEVChtllx0ajvsnd0n6gicxDsQ3TDqRE+1f1myKUCy1jXkQzF+P5Yz+/e70JsJ
         MsbwPa04I5Sw0HXAMBA/9XuuLCftaBT14HUAZYP1d0spFsh1U+7S4AzEvVT6/jYkuVW0
         d+qf2m175ouu0csCkkFAGT2qWW2qCb5x0Jz//dYiLYGzvhxUp7kJybZBj6kCK+B26FRQ
         cOag==
X-Gm-Message-State: ACgBeo0aCLHuIMuNe0w8FzE8wwzL768IcI0Vn4o4sNuLXNOBcQDkGZAe
        kAGFUG0nw5IXzhgeXpmZ7gIbYGpjjaMxKPBdP4nLbG8FubirN/MrOyhTZjmy6Kdz8vEi5lDkBEF
        ExglixEUQ7zi3TzBtDV9QA+kUVLZP8x/4OkqoUtht
X-Received: by 2002:a1f:91c4:0:b0:394:8136:c142 with SMTP id t187-20020a1f91c4000000b003948136c142mr2700552vkd.21.1661874497501;
        Tue, 30 Aug 2022 08:48:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR54VZeIrBA6rFYE7McHjwk5q/BP0aEB1ftzlEXS3iHyd3qCAZ/+vUQr5wimdPxPp3/PKNr8KQKESFGNgYEqpIg=
X-Received: by 2002:a1f:91c4:0:b0:394:8136:c142 with SMTP id
 t187-20020a1f91c4000000b003948136c142mr2700543vkd.21.1661874497282; Tue, 30
 Aug 2022 08:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220829154805.1205507-1-mlombard@redhat.com> <Yw3lXaDTfvJcEM4Q@linutronix.de>
In-Reply-To: <Yw3lXaDTfvJcEM4Q@linutronix.de>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Tue, 30 Aug 2022 17:48:06 +0200
Message-ID: <CAFL455=4SBhJ4LpiPQr+PmL2ShuTpR=bAo8JVfe-2x3cg85cbQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 30. 8. 2022 v 12:24 odes=C3=ADlatel Sebastian Andrzej Siewior
<bigeasy@linutronix.de> napsal:
>
> On 2022-08-29 17:48:05 [+0200], Maurizio Lombardi wrote:
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 862dbd9af4f5..d46ee90651d2 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2681,30 +2681,34 @@ struct slub_flush_work {
> >       bool skip;
> >  };
> >
> > +static void flush_cpu_slab(void *d)
> > +{
> > +     struct kmem_cache *s =3D d;
> > +     struct kmem_cache_cpu *c =3D this_cpu_ptr(s->cpu_slab);
> > +
> > +     if (c->slab)
> > +             flush_slab(s, c);
> > +
> > +     unfreeze_partials(s);
> > +}
> =E2=80=A6
> > @@ -2721,13 +2725,18 @@ static void flush_all_cpus_locked(struct kmem_c=
ache *s)
> >       lockdep_assert_cpus_held();
> >       mutex_lock(&flush_lock);
> >
> > +     if (in_task()) {
> > +             on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>
> This blocks with disabled preemption until it completes flush_cpu_slab()
> on all CPUs.
> That function acquires a local_lock_t which can not be
> acquired from in-IRQ which is where this function will be invoked due to
> on_each_cpu_cond().

Hmm, this is not good indeed. I guess I should have used for_each_online_cp=
u()
instead of on_each_cpu_cond().

>
> Couldn't we instead use a workqueue with that WQ_MEM_RECLAIM bit? It may
> reclaim memory after all ;)

That should also fix it, do you think it would be ok to allocate a workqueu=
e in
in kmem_cache_init() ?

Thanks,
Maurizio

