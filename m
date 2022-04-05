Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29C4F527C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850487AbiDFCxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836202AbiDFAfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:35:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0A56231
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:48:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 2so865552pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OHn1VfLfejIXT6yPJ3XPtqopm1nUsKduprqcCKNvFYE=;
        b=QC1ItIW7eMIJ1tIWMRHMJ9HMv5GYn/khiFuFUr5fEnrLj0zJcfU1XO74xewkGovC3L
         pnwTNpSPYJTlUascWdjTaVaJtNxeH3CRQC33eHlIlrJkbZ5lk6NkOVLMbiNQiVKUFoPl
         ZdI+K/FZ6K7Y7icQAqAdoVsqc3sbwuGubLo73id14SN2WFcZU7Vmnw3VmkWknLsLhhye
         37KIorNbJDvR4MppD2NJeNYfO/IstW+pzdk3KbNRjAH5gYyvzXMtDi2qFRB7PrYUbIW8
         FHJG6gxRW4kVKDL0tVwhGYI0udjlgPEZzz1Iamgn+G2uI57We6mZR/mhHghw5+MvJsyv
         YqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OHn1VfLfejIXT6yPJ3XPtqopm1nUsKduprqcCKNvFYE=;
        b=4QKqbQNzzUQe98mZm0Vv91FhWLItIVBrpuTY+lO5+82k2ji2YFBpkWncMkCFkPYDQZ
         S1fgVCJiccfTrdJWqJMb6BR2OgIxsZKnmoEkar5fMnmegX5Q7O3BJIoCt7LUmLVDP7F1
         WYMPS8s9WwZUJgRVQjOMpopo8vlR5hX+6/gKK5NuixQc2bW+gqjE7KKPAruF5NTYWBMy
         2R3axBho4t6nL3TrByJDVdSoigJIaFzZ8ZJT5iDIRO4m1Urrt9oQ1Wk+GWneYfy/tKHS
         ShrIpmFlu1MHqKtjS4SIxuwxxVcstVW2+IohKA4YjijZ9SAF8IrDmg77t9o0xs5tII7x
         uKtg==
X-Gm-Message-State: AOAM531YbRsggX77nESc6TEHVsJPq/H/w8L8N+hVEoatRrWDpBmgN5EB
        UbMvg3x6SIAAOviOcUPKz3k=
X-Google-Smtp-Source: ABdhPJx80fufmR7GW+M149oEL0xQmbFLcOW2yBOkjm2jYm+mDKBZ8IAkuITtUacK8+Y0Akxz2dR46g==
X-Received: by 2002:a17:902:ba8c:b0:14f:d9b7:ab4 with SMTP id k12-20020a170902ba8c00b0014fd9b70ab4mr5666784pls.23.1649198883655;
        Tue, 05 Apr 2022 15:48:03 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id r24-20020a62e418000000b004fde0e5610dsm12644072pfh.210.2022.04.05.15.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 15:48:02 -0700 (PDT)
Date:   Wed, 6 Apr 2022 07:47:55 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zqiang <qiang.zhang@windriver.com>, linux-mm@kvack.org
Subject: Re: [mm/slub] 555b8c8cb3:
 WARNING:at_lib/stackdepot.c:#stack_depot_fetch
Message-ID: <YkzHG64zxu+nWbg3@hyeyoo>
References: <20220323090520.GG16885@xsang-OptiPlex-9020>
 <20220324095218.GA2108184@odroid>
 <YkcfNjZJSXNsAlLt@hyeyoo>
 <YkpgjgM/aSXd29uj@hyeyoo>
 <Ykqn2z9UVfxFwiU+@elver.google.com>
 <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
 <CANpmjNMupGGbTDD-ZEY=acTbqguvWgLzb1ZVRbG9TyuF50Ch+Q@mail.gmail.com>
 <Ykui2prpzkMvaWBa@hyeyoo>
 <YkwjCUbTbRqslphe@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkwjCUbTbRqslphe@elver.google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:07:53PM +0200, Marco Elver wrote:
> On Tue, Apr 05, 2022 at 11:00AM +0900, Hyeonggon Yoo wrote:
> > On Mon, Apr 04, 2022 at 05:18:16PM +0200, Marco Elver wrote:
> > > On Mon, 4 Apr 2022 at 16:20, Vlastimil Babka <vbabka@suse.cz> wrote:
> [...]
> > > > But here we are in mem_dump_obj() -> kmem_dump_obj() -> kmem_obj_info().
> > > > Because kmem_valid_obj() returned true, fooled by folio_test_slab()
> > > > returning true because of the /* Set required slab fields. */ code.
> > > > Yet the illusion is not perfect and we read garbage instead of a valid
> > > > stackdepot handle.
> > > >
> > > > IMHO we should e.g. add the appropriate is_kfence_address() test into
> > > > kmem_valid_obj(), to exclude kfence-allocated objects? Sounds much simpler
> > > > than trying to extend the illusion further to make kmem_dump_obj() work?
> > > > Instead kfence could add its own specific handler to mem_dump_obj() to print
> > > > its debugging data?
> > > 
> > > I think this explanation makes sense!  Indeed, KFENCE already records
> > > allocation stacks internally anyway, so it should be straightforward
> > > to convince it to just print that.
> > >
> > 
> > Thank you both! Yeah the explanation makes sense... thats why KASAN/KCSAN couldn't yield anything -- it was not overwritten.
> > 
> > I'm writing a fix and will test if the bug disappears.
> > This may take few days.
>

I did check the bug is not reproduced after simple fix. (reproduced 0 of 373)
This approach was right.

> The below should fix it -- I'd like to make kmem_obj_info() do something
> useful for KFENCE objects.
>

Agreed.

> I lightly tested it by calling mem_dump_obj() on a KFENCE object, and
> prior to the below patch it'd produce garbage data.
> 
> Does that look reasonable to you?
> 
> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From 09f32964284110846ded8ade9a1a2bfcb17dc58e Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Tue, 5 Apr 2022 12:43:48 +0200
> Subject: [PATCH RFC] kfence, slab, slub: support kmem_obj_info() with KFENCE
>  objects
> 
> Calling kmem_obj_info() on KFENCE objects has been producing garbage
> data due to the object not actually being maintained by SLAB or SLUB.
> 
> Fix this by asking KFENCE to copy missing KFENCE-specific information to
> struct kmem_obj_info when the object was allocated by KFENCE.
> 
> Link: https://lore.kernel.org/all/20220323090520.GG16885@xsang-OptiPlex-9020/
> Fixes: b89fb5ef0ce6 ("mm, kfence: insert KFENCE hooks for SLUB")
> Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kfence.h | 22 ++++++++++++++++++++++
>  mm/kfence/core.c       | 21 ---------------------
>  mm/kfence/kfence.h     | 21 +++++++++++++++++++++
>  mm/kfence/report.c     | 34 ++++++++++++++++++++++++++++++++++
>  mm/slab.c              |  4 ++++
>  mm/slub.c              |  4 ++++
>  6 files changed, 85 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index f49e64222628..4a7c633cb219 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -204,6 +204,23 @@ static __always_inline __must_check bool kfence_free(void *addr)
>   */
>  bool __must_check kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs);
>  
> +#ifdef CONFIG_PRINTK
> +struct kmem_obj_info;
> +/**
> + * kfence_kmem_obj_info() - fill kmem_obj_info struct
> + * @kpp: kmem_obj_info to be filled
> + * @object: the object
> + *
> + * Return:
> + * * false - not a KFENCE object
> + * * true - a KFENCE object and filled @kpp
> + *
> + * Copies information to @kpp that kmem_obj_info() is unable to populate for
> + * KFENCE objects.
> + */
> +bool kfence_kmem_obj_info(struct kmem_obj_info *kpp, void *object);
> +#endif
> +
>  #else /* CONFIG_KFENCE */
>  
>  static inline bool is_kfence_address(const void *addr) { return false; }
> @@ -221,6 +238,11 @@ static inline bool __must_check kfence_handle_page_fault(unsigned long addr, boo
>  	return false;
>  }
>  
> +#ifdef CONFIG_PRINTK
> +struct kmem_obj_info;
> +static inline bool kfence_kmem_obj_info(struct kmem_obj_info *kpp, void *object) { return false; }
> +#endif
> +
>  #endif
>  
>  #endif /* _LINUX_KFENCE_H */
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index a203747ad2c0..9b2b5f56f4ae 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -231,27 +231,6 @@ static bool kfence_unprotect(unsigned long addr)
>  	return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), false));
>  }
>  
> -static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
> -{
> -	long index;
> -
> -	/* The checks do not affect performance; only called from slow-paths. */
> -
> -	if (!is_kfence_address((void *)addr))
> -		return NULL;
> -
> -	/*
> -	 * May be an invalid index if called with an address at the edge of
> -	 * __kfence_pool, in which case we would report an "invalid access"
> -	 * error.
> -	 */
> -	index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
> -	if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
> -		return NULL;
> -
> -	return &kfence_metadata[index];
> -}
> -
>  static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
>  {
>  	unsigned long offset = (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 9a6c4b1b12a8..600f2e2431d6 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -96,6 +96,27 @@ struct kfence_metadata {
>  
>  extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
>  
> +static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
> +{
> +	long index;
> +
> +	/* The checks do not affect performance; only called from slow-paths. */
> +
> +	if (!is_kfence_address((void *)addr))
> +		return NULL;
> +
> +	/*
> +	 * May be an invalid index if called with an address at the edge of
> +	 * __kfence_pool, in which case we would report an "invalid access"
> +	 * error.
> +	 */
> +	index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
> +	if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
> +		return NULL;
> +
> +	return &kfence_metadata[index];
> +}
> +
>  /* KFENCE error types for report generation. */
>  enum kfence_error_type {
>  	KFENCE_ERROR_OOB,		/* Detected a out-of-bounds access. */
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index f93a7b2a338b..5887fa610c9d 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -273,3 +273,37 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
>  	/* We encountered a memory safety error, taint the kernel! */
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
>  }
> +
> +#ifdef CONFIG_PRINTK
> +static void kfence_to_kp_stack(const struct kfence_track *track, void **kp_stack)
> +{
> +	int i, j;
> +
> +	i = get_stack_skipnr(track->stack_entries, track->num_stack_entries, NULL);
> +	for (j = 0; i < track->num_stack_entries && j < KS_ADDRS_COUNT - 1; ++i, ++j)

why KS_ADDRS_COUNT - 1 instead of KS_ADDRS_COUNT?

> +		kp_stack[j] = (void *)track->stack_entries[i];
> +	kp_stack[j] = NULL;
> +}
> +
> +bool kfence_kmem_obj_info(struct kmem_obj_info *kpp, void *object)
> +{
> +	const struct kfence_metadata *meta = addr_to_metadata((unsigned long)object);
> +
> +	if (!meta)
> +		return false;
> +
> +	/* Requesting info an a never-used object is almost certainly a bug. */
> +	if (WARN_ON(meta->state == KFENCE_OBJECT_UNUSED))
> +		return true;
> +
> +	kpp->kp_objp = (void *)meta->addr;
> +

no need to take meta->lock here?

> +	kfence_to_kp_stack(&meta->alloc_track, kpp->kp_stack);
> +	if (meta->state == KFENCE_OBJECT_FREED)
> +		kfence_to_kp_stack(&meta->free_track, kpp->kp_free_stack);
> +	/* get_stack_skipnr() ensures the first entry is outside allocator. */
> +	kpp->kp_ret = kpp->kp_stack[0];
> +
> +	return true;
> +}

kfence_kmem_obj_info() does not set kp_data_offset. kp_data_offset
may not be zero when e.g.) mem_dump_obj(&rhp->func); in rcutorture case. 

BTW, I would prefer implementing something like kfence_obj_info()
(called by kmem_dump_obj() and called instead of kmem_obj_info())
for better readability.

And when mem_dump_obj() is called, I guess it's for debugging purpose.
I think it would be better to let user know the object is allocated
from kfence pool. maybe adding if (is_kfence_address(object)) pr_cont(" kfence");
in kmem_dump_obj() would be enough?

Thanks!
Hyeonggon

> +#endif
> diff --git a/mm/slab.c b/mm/slab.c
> index b04e40078bdf..4d44b094e0ab 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3675,6 +3675,10 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  	kpp->kp_slab = slab;
>  	cachep = slab->slab_cache;
>  	kpp->kp_slab_cache = cachep;
> +
> +	if (kfence_kmem_obj_info(kpp, object))
> +		return;
> +
>  	objp = object - obj_offset(cachep);
>  	kpp->kp_data_offset = obj_offset(cachep);
>  	slab = virt_to_slab(objp);
> diff --git a/mm/slub.c b/mm/slub.c
> index 74d92aa4a3a2..c7d2cfd60b87 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4325,6 +4325,10 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  	kpp->kp_ptr = object;
>  	kpp->kp_slab = slab;
>  	kpp->kp_slab_cache = s;
> +
> +	if (kfence_kmem_obj_info(kpp, object))
> +		return;
> +
>  	base = slab_address(slab);
>  	objp0 = kasan_reset_tag(object);
>  #ifdef CONFIG_SLUB_DEBUG
> -- 
> 2.35.1.1094.g7c7d902a7c-goog
> 
