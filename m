Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA154F6329
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiDFPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiDFPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:23:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC92C125
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:31:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 7so2293083pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JivIJ9eJFl6ReMqvRxBkSXywrh2gm+BL+Pz8HnhfVKA=;
        b=SYUssvqCo9/x5lZgSgRLKjvT3ofPg3+jqn1NM8jSI8Rs25K5whdKrXXHnPANhATFLE
         5EtUrN5ksGdPoJGNTK/xv+rhZhvnSynLZ2yKGyhaNZNSvmTcPEvxsMO2uMInM9x29WnJ
         5FpUD5DT++QfpjbKXTPneJT5gQ5Twe0BXK2k8ltpjYpa40HGLaZuZE3DBZnvuLiOEGRZ
         xa75LBK7VhmCAHVJ0dTAUSu1XsLnNZnhS/uWZ3gLkSe9JvIkTz61QeqFNgDSx4emUrft
         zzoS+m1PFyyHa7MOq3p0piA6azNX0oK6JxzN72DCS6lxwBPGaYtP6vvntI2uFiI79xtu
         IMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JivIJ9eJFl6ReMqvRxBkSXywrh2gm+BL+Pz8HnhfVKA=;
        b=QsV7qj++SRuX+CEd1RinjF8b1+/RfkyboXDLnQ1XC359nv3sMCOXfQE/g97i35dGOM
         5xkijIXhSxt3ded7h8ejkXUYODP3XalWu8jsUR3r/8hawsjGlta2hbQUNmLKMHoQZxZL
         JUOMrq6tzO65BXsN+WLjU4Ei4fSZVas10ukeuiWG4n+itniRVeyhR+74EJs482Rg9whH
         VdJT4Gu0CnhoDG2zJMj7tZ3fqm5NUDJfMi9dlLkE1nN5wuW5krlnDXD+Pc04jQHjLQD6
         ykLJ6g+FvPWFsvAiS+WJ+fmMlegqWcaGu19lVhAJdx8oZPxTfbbj7/iPe3R4M+EnFEpK
         Ggxg==
X-Gm-Message-State: AOAM5339bJuXYRSYQ7CEAhwj9bJd410amBoWk+OJ8tHMRdEmWVxe00Mz
        COl3/iG7vr6MDhGypjZ5z2c=
X-Google-Smtp-Source: ABdhPJwtzVRDwYjwykTmRY0R2aTS2E1ALKl7Gj9EcBgG6ZyWVSpxz7qdHlj/b3U9zaiKn8ASGMpe1A==
X-Received: by 2002:a63:af02:0:b0:386:5aa9:a88c with SMTP id w2-20020a63af02000000b003865aa9a88cmr6742199pge.533.1649248301754;
        Wed, 06 Apr 2022 05:31:41 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78009000000b004fde2dd78b0sm14506928pfi.109.2022.04.06.05.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:31:40 -0700 (PDT)
Date:   Wed, 6 Apr 2022 21:31:32 +0900
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
Message-ID: <Yk2IJDk5RcO+R3QY@hyeyoo>
References: <YkpgjgM/aSXd29uj@hyeyoo>
 <Ykqn2z9UVfxFwiU+@elver.google.com>
 <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
 <CANpmjNMupGGbTDD-ZEY=acTbqguvWgLzb1ZVRbG9TyuF50Ch+Q@mail.gmail.com>
 <Ykui2prpzkMvaWBa@hyeyoo>
 <YkwjCUbTbRqslphe@elver.google.com>
 <YkzHG64zxu+nWbg3@hyeyoo>
 <Yk1Qf73cufW6LjOW@elver.google.com>
 <Yk1+jZjfaJK3Jwwf@hyeyoo>
 <Yk2EZwGwlXc+vJy7@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk2EZwGwlXc+vJy7@elver.google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 02:15:35PM +0200, Marco Elver wrote:
> On Wed, Apr 06, 2022 at 08:50PM +0900, Hyeonggon Yoo wrote:
> [...]
> > > I'd prefer fixing it as close to the root-cause (in kmem_obj_info()) to
> > > avoid that.
> > > 
> > > What do you prefer?
> > 
> > Then what about something like this?
> > 
> > kmem_obj_info(object) {
> > 	if (object is from kfence)
> > 		__kfence_obj_info()
> > 	else
> > 		__kmem_obj_info()
> > }
> 
> How about the below?
> 
> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From b1c756f522cfecf6f5016581839c693eccaa5827 Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Tue, 5 Apr 2022 12:43:48 +0200
> Subject: [PATCH RFC] kfence, slab, slub: support kmem_obj_info() with KFENCE
>  objects
> 
> Calling kmem_obj_info() on KFENCE objects has been producing garbage
> data due to the object not actually being maintained by SLAB or SLUB.
> 
> Fix this by asking KFENCE to copy missing KFENCE-specific information to
> struct kmem_obj_info when the object was allocated by KFENCE. For
> completeness, make kmem_dump_obj() show if it's a KFENCE object.
>

This changelog need to be updated.
Otherwise the code looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> Link: https://lore.kernel.org/all/20220323090520.GG16885@xsang-OptiPlex-9020/
> Fixes: b89fb5ef0ce6 ("mm, kfence: insert KFENCE hooks for SLUB")
> Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kfence.h | 24 +++++++++++++++++++++
>  mm/kfence/core.c       | 21 -------------------
>  mm/kfence/kfence.h     | 21 +++++++++++++++++++
>  mm/kfence/report.c     | 47 ++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.c              |  2 +-
>  mm/slab.h              |  2 +-
>  mm/slab_common.c       |  9 ++++++++
>  mm/slob.c              |  2 +-
>  mm/slub.c              |  2 +-
>  9 files changed, 105 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index f49e64222628..726857a4b680 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -204,6 +204,22 @@ static __always_inline __must_check bool kfence_free(void *addr)
>   */
>  bool __must_check kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs);
>  
> +#ifdef CONFIG_PRINTK
> +struct kmem_obj_info;
> +/**
> + * __kfence_obj_info() - fill kmem_obj_info struct
> + * @kpp: kmem_obj_info to be filled
> + * @object: the object
> + *
> + * Return:
> + * * false - not a KFENCE object
> + * * true - a KFENCE object, filled @kpp
> + *
> + * Copies information to @kpp for KFENCE objects.
> + */
> +bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
> +#endif
> +
>  #else /* CONFIG_KFENCE */
>  
>  static inline bool is_kfence_address(const void *addr) { return false; }
> @@ -221,6 +237,14 @@ static inline bool __must_check kfence_handle_page_fault(unsigned long addr, boo
>  	return false;
>  }
>  
> +#ifdef CONFIG_PRINTK
> +struct kmem_obj_info;
> +static inline bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> +{
> +	return false;
> +}
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
> index f93a7b2a338b..f5a6d8ba3e21 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -273,3 +273,50 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
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
> +	for (j = 0; i < track->num_stack_entries && j < KS_ADDRS_COUNT; ++i, ++j)
> +		kp_stack[j] = (void *)track->stack_entries[i];
> +	if (j < KS_ADDRS_COUNT)
> +		kp_stack[j] = NULL;
> +}
> +
> +bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> +{
> +	struct kfence_metadata *meta = addr_to_metadata((unsigned long)object);
> +	unsigned long flags;
> +
> +	if (!meta)
> +		return false;
> +
> +	/*
> +	 * If state is UNUSED at least show the pointer requested; the rest
> +	 * would be garbage data.
> +	 */
> +	kpp->kp_ptr = object;
> +
> +	/* Requesting info an a never-used object is almost certainly a bug. */
> +	if (WARN_ON(meta->state == KFENCE_OBJECT_UNUSED))
> +		return true;
> +
> +	raw_spin_lock_irqsave(&meta->lock, flags);
> +
> +	kpp->kp_slab = slab;
> +	kpp->kp_slab_cache = meta->cache;
> +	kpp->kp_objp = (void *)meta->addr;
> +	kfence_to_kp_stack(&meta->alloc_track, kpp->kp_stack);
> +	if (meta->state == KFENCE_OBJECT_FREED)
> +		kfence_to_kp_stack(&meta->free_track, kpp->kp_free_stack);
> +	/* get_stack_skipnr() ensures the first entry is outside allocator. */
> +	kpp->kp_ret = kpp->kp_stack[0];
> +
> +	raw_spin_unlock_irqrestore(&meta->lock, flags);
> +
> +	return true;
> +}
> +#endif
> diff --git a/mm/slab.c b/mm/slab.c
> index b04e40078bdf..0edb474edef1 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3665,7 +3665,7 @@ EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  #endif /* CONFIG_NUMA */
>  
>  #ifdef CONFIG_PRINTK
> -void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> +void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  {
>  	struct kmem_cache *cachep;
>  	unsigned int objnr;
> diff --git a/mm/slab.h b/mm/slab.h
> index fd7ae2024897..95eb34174c1b 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -868,7 +868,7 @@ struct kmem_obj_info {
>  	void *kp_stack[KS_ADDRS_COUNT];
>  	void *kp_free_stack[KS_ADDRS_COUNT];
>  };
> -void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
> +void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
>  #endif
>  
>  #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6ee64d6208b3..2b3206a2c3b5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -555,6 +555,13 @@ bool kmem_valid_obj(void *object)
>  }
>  EXPORT_SYMBOL_GPL(kmem_valid_obj);
>  
> +static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> +{
> +	if (__kfence_obj_info(kpp, object, slab))
> +		return;
> +	__kmem_obj_info(kpp, object, slab);
> +}
> +
>  /**
>   * kmem_dump_obj - Print available slab provenance information
>   * @object: slab object for which to find provenance information.
> @@ -590,6 +597,8 @@ void kmem_dump_obj(void *object)
>  		pr_cont(" slab%s %s", cp, kp.kp_slab_cache->name);
>  	else
>  		pr_cont(" slab%s", cp);
> +	if (is_kfence_address(object))
> +		pr_cont(" (kfence)");
>  	if (kp.kp_objp)
>  		pr_cont(" start %px", kp.kp_objp);
>  	if (kp.kp_data_offset)
> diff --git a/mm/slob.c b/mm/slob.c
> index dfa6808dff36..40ea6e2d4ccd 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -463,7 +463,7 @@ static void slob_free(void *block, int size)
>  }
>  
>  #ifdef CONFIG_PRINTK
> -void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> +void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  {
>  	kpp->kp_ptr = object;
>  	kpp->kp_slab = slab;
> diff --git a/mm/slub.c b/mm/slub.c
> index 74d92aa4a3a2..ed5c2c03a47a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4312,7 +4312,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>  }
>  
>  #ifdef CONFIG_PRINTK
> -void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
> +void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  {
>  	void *base;
>  	int __maybe_unused i;
> -- 
> 2.35.1.1094.g7c7d902a7c-goog
> 

-- 
Thanks,
Hyeonggon
