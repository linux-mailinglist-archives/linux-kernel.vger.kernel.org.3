Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677B24C6B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiB1Lte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiB1Ltb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:49:31 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6822593BD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:48:52 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id bc27so2263672pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=am2anFkVsG7Bze9aa1vWnJKsuTrnWK6q1iSh7BZsgF8=;
        b=Jip0IPk53So+30XIUMs2CfvnweRALN+JwVNG1WrTMGEowE5C/a8zXwDHJhPj04WrLI
         cQAPc1b0V8sDEQx0OJj9/iSyLDJk+DyMyH3eTfUCMxOtKxpp/nLRJHV2khpgW0mWBjAL
         zTA31kiFhYQkwKdLgEiLa465Zn+dVcSODGz/KKKsI6wxa6Aold4doNku6mJkrXzgn1/s
         nl72LHYsR09xeM8kERKdiBj/T0gMyXncypLlsx5Us2B+QqTJ2aM4b038hNGkl31hm5+v
         +97KqUXNsgLKHy+x/FBL0HI8uSfcjUGtTvlNC0PrC/eE/VqvzSJc4MAMnVdm5xkiXNIH
         +wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=am2anFkVsG7Bze9aa1vWnJKsuTrnWK6q1iSh7BZsgF8=;
        b=kadbrIGyn9aSN8Zg39VdHqHigVQGeLlPqXP6Apmk2d63DsY6enjQCUh7TlE2bbV6cL
         ZPJqtf90qhhfq3mSGqyTfipI8Zxowj/ITncINRw3tUfmp3UniWZPVmUw1Rx1bZdJJMFa
         GrVCOo2zoylYqXeNfrLXFN9osyKf/PU93fNkJayyHwOu65GY2Vb0ER+41oyxkcDhjjUB
         aohNl+BRHDPHs7v0rjzx/1iKmCSGM0iNyzWUqqWrPIfbnU+yxC0UDQnW5DKokPDIvJye
         yRqOGppviRE4ln7nRvnixSYY2QevNTBgWnT0U2Z5+BUA/HU2oyAmJJdytJV/gDK4TYYs
         ibbg==
X-Gm-Message-State: AOAM530I4qMjSM9jonYgVvy47dLBb4L5slTJXv3TxP5EpouSr854DWGH
        /gkhppBD69+fGz72fwfa9wc=
X-Google-Smtp-Source: ABdhPJw4T8HB5OQvaIj0noApGeWbAHbY9BHN7sBqOlmFEtoh3s5hgUo6UWhQYHLnmOLf8PUmFNq4Ng==
X-Received: by 2002:a63:584d:0:b0:370:14d9:8238 with SMTP id i13-20020a63584d000000b0037014d98238mr16675435pgm.166.1646048931891;
        Mon, 28 Feb 2022 03:48:51 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090ad59600b001b7deb42251sm16690979pju.15.2022.02.28.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:48:51 -0800 (PST)
Date:   Mon, 28 Feb 2022 11:48:45 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [PATCH] lib/stackdepot: Use page allocator if both slab and
 memblock is unavailable
Message-ID: <Yhy2ne4TmnSKKE9J@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-3-vbabka@suse.cz>
 <YhrrM7NTYXG5JluY@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <CANpmjNOyVTQZroOEVF_ZLASCtQ=SiC12WGWEwOib3vDk3sCbtw@mail.gmail.com>
 <YhyeaP8lrzKgKm5A@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <CANpmjNOOhuoU7T4UqHbzkRAvM+b-gvt+Qtx41va=9ixGgUSWaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOOhuoU7T4UqHbzkRAvM+b-gvt+Qtx41va=9ixGgUSWaQ@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:50:49AM +0100, Marco Elver wrote:
> On Mon, 28 Feb 2022 at 11:05, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> [...]
> > > This is odd - who is calling stack_depot_init() while neither slab nor
> > > memblock are available?
> >
> > It's not merged yet - but Oliver's patch (2/5) in his series [1] does:
> > If user is debugging cache, it calls stack_depot_init() when creating
> > cache.
> >
> > > @@ -4221,6 +4220,9 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> > >       s->remote_node_defrag_ratio = 1000;
> > >  #endif
> > >
> > > +     if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> > > +             stack_depot_init();
> > > +
> >
> > Oliver's patch series enables stack depot when arch supports stacktrace,
> > to store slab objects' stack traces. (as slub debugging feature.)
> >
> > Because slub debugging is turned on by default, the commit 2dba5eb1c73b
> > ("lib/stackdepot: allow optional init and stack_table allocation by
> > kvmalloc()") made stack_depot_init() can be called later.
> >
> > With Oliver's patch applied, stack_depot_init() can be called in
> > contexts below:
> >
> >   1) only memblock available (for kasan)
> >   2) only buddy available, vmalloc/memblock unavailable (for boot caches)
> >   3) buddy/slab available, vmalloc/memblock unavailable (vmap_area cache)
> >   4) buddy/slab/vmalloc available, memblock unavailable (other caches)
> >
> > SLUB supports enabling debugging for specific cache by passing
> > slub_debug boot parameter. As slab caches can be created in
> > various context, stack_depot_init() should consider all contexts above.
> >
> > Writing this, I realized my patch does not handle case 3).. I'll send v3.
> >
> > [1] https://lore.kernel.org/linux-mm/YhoakP7Kih%2FYUgiN@ip-172-31-19-208.ap-northeast-1.compute.internal/T/#t
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
> >
> > > Do you have a stacktrace?
> >
> > Yeah, here:
> >
> > You can reproduce this on vbabka's slab-stackdepot-v1 branch [2] with
> > slub_debug=U, and CONFIG_STACKDEPOT_ALWAYS_INIT=n
> >
> [...]
> > [    0.000000] Call trace:
> > [    0.000000]  __memset+0x16c/0x188
> > [    0.000000]  stack_depot_init+0xc8/0x100
> > [    0.000000]  __kmem_cache_create+0x454/0x570
> > [    0.000000]  create_boot_cache+0xa0/0xe0
> 
> I think even before this point you have all the information required
> to determine if stackdepot will be required. It's available after
> setup_slub_debug().
> 
> So why can't you just call stack_depot_init() somewhere else and avoid
> all this complexity?
>

You are right. That is much simpler and sound good as SLUB does not
support enabling SLAB_STORE_USER flag when system is up.

I'll try this approach.
Thank you!

> > [    0.000000]  kmem_cache_init+0xf8/0x204
> > [    0.000000]  start_kernel+0x3ec/0x668
> > [    0.000000]  __primary_switched+0xc0/0xc8
> > [    0.000000] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

-- 
Thank you, You are awesome!
Hyeonggon :-)
