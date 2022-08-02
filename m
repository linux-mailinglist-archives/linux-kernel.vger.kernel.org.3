Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD055879CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiHBJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbiHBJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:25:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C891EAE0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:25:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw1so12914282plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tvPPMOJRG4zHjiM0Ldtb3zWLvSm3WI5LJDg+HchmZLc=;
        b=Go+vOylz8iFZsox5ugUMHMcQufmwVHJ8iBipY/2fFG4cvprnUfYe4VjhdcnHMcLGMU
         K6w2j+8lVu9hxz6/mRPyGV/or0XTfMI0MFob0LgUrfVl/hXEb4jQj4Be7/b9tyAdKC5L
         1onl1bp6xUk1cutaiA4iggK2X36frjTITQk3TNnkvz0GGArTYlMQpDAJzk0z/XbnuLiy
         paAP+F47Z/BnNWYWNHfi/afEy97ZBoJnuyCf+KQDX12RupWfY/tHhCP24gD/oagCR9yN
         RJ4IvWNFQvNIa3aIgcQq2d7I/dHQIu7WU5ZnHJPoV2hvhAo49UE9XxOqjHnp/YEsg1z8
         hJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvPPMOJRG4zHjiM0Ldtb3zWLvSm3WI5LJDg+HchmZLc=;
        b=krj7HpQy1fbhT2NEARAVks1IEsnLgJZumsW55xLvqkZXH4ecZyXDUU1gmmPxyXwara
         XM6sd/3hv/jpb8vSj8f8heK0FzzJyn7AEFeZjOOXIPmNCI07jcIfmEqZfuadi0lQziEl
         pPsTW0ek+GWvXyrB7I8CcFdMZpdb5QRzOM/WagQiVvIdiD16RBBwXZ3ACTUKn5got06Y
         srNyvIR0SfXztO5lNaXfDmdQNWUiET/dMnqImccekV2RLoo26Uv/K9BaiENXO1awHxro
         0Ltao2MXD4uN8erWQEWMVwzGku9vT+6ctiTNsv6ETlzscEFJq0oYrbEYG/GB/XjkPVGe
         gIbQ==
X-Gm-Message-State: ACgBeo0KHQFMMvKW9Ty4G6X9HKv0W9e/UeC2ApER2IRmU9xBcm3/t7z1
        tzbwr5QjW4loPHJY2sH8xNs=
X-Google-Smtp-Source: AA6agR4jA9bVMUnjys7lzvzQPS11pIOI9xt66u9sv8QHCx8kzFILb9+weVJfhcHw2aliWQFwnV24cg==
X-Received: by 2002:a17:90a:317:b0:1f3:8ad:52aa with SMTP id 23-20020a17090a031700b001f308ad52aamr23755693pje.106.1659432347397;
        Tue, 02 Aug 2022 02:25:47 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a604e00b001f4f40763b1sm4813476pjm.29.2022.08.02.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 02:25:46 -0700 (PDT)
Date:   Tue, 2 Aug 2022 18:25:01 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/16] mm/slab_common: move definition of __ksize() to
 mm/slab.h
Message-ID: <YujtbRjDFRwXIbbT@hyeyoo>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-16-42.hyeyoo@gmail.com>
 <35ee9435-97b4-4161-b21c-15467b56d004@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ee9435-97b4-4161-b21c-15467b56d004@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 01:47:23PM +0200, Vlastimil Babka wrote:
> On 7/12/22 15:39, Hyeonggon Yoo wrote:
> > __ksize() is only called by KASAN. Remove export symbol and move
> > definition to mm/slab.h as we don't want to grow its callers.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit: The subject and changelog should probably say declaration, not definition.

Ah, right. will do.
Thanks!

> 
> > ---
> >  include/linux/slab.h |  1 -
> >  mm/slab.h            |  2 ++
> >  mm/slab_common.c     | 11 +----------
> >  mm/slob.c            |  1 -
> >  4 files changed, 3 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 4ee5b2fed164..701fe538650f 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -187,7 +187,6 @@ int kmem_cache_shrink(struct kmem_cache *s);
> >  void * __must_check krealloc(const void *objp, size_t new_size, gfp_t flags) __alloc_size(2);
> >  void kfree(const void *objp);
> >  void kfree_sensitive(const void *objp);
> > -size_t __ksize(const void *objp);
> >  size_t ksize(const void *objp);
> >  #ifdef CONFIG_PRINTK
> >  bool kmem_valid_obj(void *object);
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 9193e9c1f040..ad634e02b3cb 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -678,6 +678,8 @@ void free_large_kmalloc(struct folio *folio, void *object);
> >  
> >  #endif /* CONFIG_SLOB */
> >  
> > +size_t __ksize(const void *objp);
> > +
> >  static inline size_t slab_ksize(const struct kmem_cache *s)
> >  {
> >  #ifndef CONFIG_SLUB
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index c01c6b8f0d34..1f8db7959366 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1003,15 +1003,7 @@ void kfree(const void *object)
> >  }
> >  EXPORT_SYMBOL(kfree);
> >  
> > -/**
> > - * __ksize -- Uninstrumented ksize.
> > - * @objp: pointer to the object
> > - *
> > - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> > - * safety checks as ksize() with KASAN instrumentation enabled.
> > - *
> > - * Return: size of the actual memory used by @objp in bytes
> > - */
> > +/* Uninstrumented ksize. Only called by KASAN. */
> >  size_t __ksize(const void *object)
> >  {
> >  	struct folio *folio;
> > @@ -1026,7 +1018,6 @@ size_t __ksize(const void *object)
> >  
> >  	return slab_ksize(folio_slab(folio)->slab_cache);
> >  }
> > -EXPORT_SYMBOL(__ksize);
> >  #endif /* !CONFIG_SLOB */
> >  
> >  gfp_t kmalloc_fix_flags(gfp_t flags)
> > diff --git a/mm/slob.c b/mm/slob.c
> > index 97a4d2407f96..91d6e2b19929 100644
> > --- a/mm/slob.c
> > +++ b/mm/slob.c
> > @@ -584,7 +584,6 @@ size_t __ksize(const void *block)
> >  	m = (unsigned int *)(block - align);
> >  	return SLOB_UNITS(*m) * SLOB_UNIT;
> >  }
> > -EXPORT_SYMBOL(__ksize);
> >  
> >  int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
> >  {
> 

-- 
Thanks,
Hyeonggon
