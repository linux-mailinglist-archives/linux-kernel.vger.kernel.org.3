Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED6357A879
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiGSUrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGSUrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ED2C51A08
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658263640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRwyMa+B5BW2EUv7kraKWHnILigjVrz1hOEZkTUv6+Q=;
        b=eTHWXDIQdIkXvO+eJT5RN3BEvbYN2qXewwZXEPP3J1GQKVxdNXBYjeV2iz+Qf+Ra9f6t0E
        LXUYLIDIBOJN0vZaYokgA8lv4bAVA6hYa+moLP24aZjt5DkPdVgkJRMFVhsrMSlUGFZPYD
        TumLZJpW9fRTqcJlwPfXwWRmmTu7nPI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-v7QpffDkPc6Uhzggay8oKA-1; Tue, 19 Jul 2022 16:47:19 -0400
X-MC-Unique: v7QpffDkPc6Uhzggay8oKA-1
Received: by mail-qk1-f197.google.com with SMTP id v13-20020a05620a0f0d00b006b5f0ec742eso4592779qkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nRwyMa+B5BW2EUv7kraKWHnILigjVrz1hOEZkTUv6+Q=;
        b=Km+bJhd+WFS1grIb30vHsMmXb+SUsZEm7Z0uGt89h2HTQLyhN/K4LQ/3jFEXF3etTc
         kHXtHcbrqaeSrCVlnXmMybvzMbS+RMYvEo25MVFBxVvGn9JikWicfHh0fxGdjBIWaJDG
         mkMujcdtGiKiwFnS5g2xcmNhl/X1fd0uReZgEHCZX2dpbuQKxwF7nFBW2lA3BTpaB9Fz
         0As+VTd7yIYs015pSvVe/aAdVOlvQmwsYmYzsBY7mwjDogKSa9qa7P4fpCrOGsyiAStZ
         SHeCUx6LqPxwteX767ImHGdWswtgWE979aPXhTGLuQf/QCkEJabe+9llm2i7d8m2B//w
         N4pQ==
X-Gm-Message-State: AJIora9HoNXNlDrsXC7X4hNmrg3g+0wU6hmQ2ZJTOt8KZ+KivvM08cPP
        ca5ZKMNlEqlJXkEQfNycs8QCpTG3zQQXN73Ew5OEbem4WiJ3e0NhOVVA96FKmCrI4rQWxTq0ch7
        UeNlZflXIcM+0nsTaEssfjFb2
X-Received: by 2002:a05:6214:2525:b0:473:9b:d933 with SMTP id gg5-20020a056214252500b00473009bd933mr26714030qvb.116.1658263638689;
        Tue, 19 Jul 2022 13:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTJ5OUhufabI8GTrMxW72hAJrjyjVDyree1lNBqt4DNxz8udXADFr/vG0mbNE/KSOh9d03Cg==
X-Received: by 2002:a05:6214:2525:b0:473:9b:d933 with SMTP id gg5-20020a056214252500b00473009bd933mr26714013qvb.116.1658263638484;
        Tue, 19 Jul 2022 13:47:18 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id bs43-20020a05620a472b00b006b60dae4da6sm3599qkb.2.2022.07.19.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:17 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:47:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Message-ID: <YtcYVMoSRVxRH70Z@xz-m1.local>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220718120212.3180-2-namit@vmware.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:01:59AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> When userfaultfd makes a PTE writable, it can now change the PTE
> directly, in some cases, without going triggering a page-fault first.
> Yet, doing so might leave the PTE that was write-unprotected as old and
> clean. At least on x86, this would cause a >500 cycles overhead when the
> PTE is first accessed.
> 
> Use MM_CP_WILL_NEED to set the PTE as young and dirty when userfaultfd
> gets a hint that the page is likely to be used. Avoid changing the PTE
> to young and dirty in other cases to avoid excessive writeback and
> messing with the page reclamation logic.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> ---
>  include/linux/mm.h | 2 ++
>  mm/mprotect.c      | 9 ++++++++-
>  mm/userfaultfd.c   | 8 ++++++--
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9cc02a7e503b..4afd75ce5875 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1988,6 +1988,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
>  /* Whether this change is for write protecting */
>  #define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
> +/* Whether to try to mark entries as dirty as they are to be written */
> +#define  MM_CP_WILL_NEED		   (1UL << 4)
>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>  					    MM_CP_UFFD_WP_RESOLVE)
>  
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 996a97e213ad..34c2dfb68c42 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -82,6 +82,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	bool will_need = cp_flags & MM_CP_WILL_NEED;
>  
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  
> @@ -172,6 +173,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  				ptent = pte_clear_uffd_wp(ptent);
>  			}
>  
> +			if (will_need)
> +				ptent = pte_mkyoung(ptent);

For uffd path, UFFD_FLAGS_ACCESS_LIKELY|UFFD_FLAGS_WRITE_LIKELY are new
internal flags used with or without the new feature bit set.  It means even
with !ACCESS_HINT we'll start to set young bit while we used not to?  Is
that some kind of a light abi change?

I'd suggest we only set will_need if ACCESS_HINT is set.

> +
>  			/*
>  			 * In some writable, shared mappings, we might want
>  			 * to catch actual write access -- see
> @@ -187,8 +191,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  			 */
>  			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>  			    !pte_write(ptent) &&
> -			    can_change_pte_writable(vma, addr, ptent))
> +			    can_change_pte_writable(vma, addr, ptent)) {
>  				ptent = pte_mkwrite(ptent);
> +				if (will_need)
> +					ptent = pte_mkdirty(ptent);

Can we make this unconditional?  IOW to cover both:

  (1) When will_need is not set, or
  (2) mprotect() too

David's patch is good in that we merged the unprotect and CoW.  However
that's not complete because the dirty bit ops are missing.

Here IMHO we should have a standalone patch to just add the dirty bit into
this logic when we'll grant write bit.  IMHO it'll make the write+dirty
bits coherent again in all paths.

> +			}
>  
>  			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
>  			if (pte_needs_flush(oldpte, ptent))
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 954c6980b29f..e0492f5f06a0 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -749,6 +749,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  	bool enable_wp = uffd_flags & UFFD_FLAGS_WP;
>  	struct vm_area_struct *dst_vma;
>  	unsigned long page_mask;
> +	unsigned long cp_flags;
>  	struct mmu_gather tlb;
>  	pgprot_t newprot;
>  	int err;
> @@ -795,9 +796,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  	else
>  		newprot = vm_get_page_prot(dst_vma->vm_flags);
>  
> +	cp_flags = enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE;
> +	if (uffd_flags & (UFFD_FLAGS_ACCESS_LIKELY|UFFD_FLAGS_WRITE_LIKELY))
> +		cp_flags |= MM_CP_WILL_NEED;
> +
>  	tlb_gather_mmu(&tlb, dst_mm);
> -	change_protection(&tlb, dst_vma, start, start + len, newprot,
> -			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
> +	change_protection(&tlb, dst_vma, start, start + len, newprot, cp_flags);
>  	tlb_finish_mmu(&tlb);
>  
>  	err = 0;
> -- 
> 2.25.1
> 

-- 
Peter Xu

