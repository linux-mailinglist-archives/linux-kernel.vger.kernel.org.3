Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2534C350C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiBXSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBXSwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:52:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE41B3A62
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:52:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 977DA1F37C;
        Thu, 24 Feb 2022 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645728719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWL2ymMXzhtYV2FqG6zUwVLCGd+IyASqK02HQkXlZQc=;
        b=PGxZw3+8pDiR4425mJIUDwjKIFfjSeMuJxB41Puafs52WdOLHuo0S0kPXm9LHAY/LVQb+8
        VqYQONN+IfTK8TCqDj6zhqjF0LcU9VRbE6x6Hy8azWu4dIQm3WNoc2fOcg0EgXcuijWeo8
        dDDh5KAMLC5Rknrdv98jAL1NIFIAsW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645728719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWL2ymMXzhtYV2FqG6zUwVLCGd+IyASqK02HQkXlZQc=;
        b=QP9dqPTyC9GvRLFa09MmJUA9KoMdOIcWsxZPKSzOddp5v1PQLrfZNQ1/bKvAyciKx8czbl
        UuwoftHQRV2b3XCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5357313B27;
        Thu, 24 Feb 2022 18:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id quuxE8/TF2KrNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Feb 2022 18:51:59 +0000
Message-ID: <00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz>
Date:   Thu, 24 Feb 2022 19:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shy828301@gmail.com, David Hildenbrand <david@redhat.com>
References: <20210514093007.4117906-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] mm/huge_memory.c: add missing read-only THP checking
 in transparent_hugepage_enabled()
In-Reply-To: <20210514093007.4117906-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 11:30, Miaohe Lin wrote:
> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
> (non-shmem) FS"), read-only THP file mapping is supported. But it
> forgot to add checking for it in transparent_hugepage_enabled().
> To fix it, we add checking for read-only THP file mapping and also
> introduce helper transhuge_vma_enabled() to check whether thp is
> enabled for specified vma to reduce duplicated code. We rename
> transparent_hugepage_enabled to transparent_hugepage_active to make
> the code easier to follow as suggested by David Hildenbrand.
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

FYI, I stumbled upon needing this for my reproducer for the read()
corruption [1] to work, and I think it's still not ideal. I also needed
madvise(MADV_HUGEPAGE) for the executable file mapping to make sure
khugepaged acts on my process. Yeah, commit 99cb0dbd47a1 suggests madvise.
Yet, khugepaged will happily collapse file mappings even without madvise
anyway. However, it might not know about the mm at all unless
__khugepaged_enter() has been applied at least on one of its vma's.
madvise() is one way to do it for executable file mappings, but it can also
happen through e.g. do_huge_pmd_anonymous_page() on another mapping, which
has nothing to do with the file mapping.
So what I'm trying to say is that we are somewhat inconsistent - the rules
to consider a vma in khugepaged seem to be clear and result of admin
configuration and madvise, but the rules to consider a mm for khugepaged
(which is the only way to collapse file mappings) are not completely
identical and there might be "random luck" involved.

[1] https://lore.kernel.org/all/df3b5d1c-a36b-2c73-3e27-99e74983de3a@suse.cz/

> ---
> v3->v4:
>   collect Reviewed-by tag
>   define transhuge_vma_enabled next to transhuge_vma_suitable
> ---
>  fs/proc/task_mmu.c      |  2 +-
>  include/linux/huge_mm.h | 57 +++++++++++++++++++++++++----------------
>  mm/huge_memory.c        | 11 +++++++-
>  mm/khugepaged.c         |  4 +--
>  mm/shmem.c              |  3 +--
>  5 files changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index fc9784544b24..7389df326edd 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -832,7 +832,7 @@ static int show_smap(struct seq_file *m, void *v)
>  	__show_smap(m, &mss, false);
>  
>  	seq_printf(m, "THPeligible:    %d\n",
> -		   transparent_hugepage_enabled(vma));
> +		   transparent_hugepage_active(vma));
>  
>  	if (arch_pkeys_enabled())
>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 0a526f211fec..7b7f7b52ccb8 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -115,9 +115,34 @@ extern struct kobj_attribute shmem_enabled_attr;
>  
>  extern unsigned long transparent_hugepage_flags;
>  
> +static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> +		unsigned long haddr)
> +{
> +	/* Don't have to check pgoff for anonymous vma */
> +	if (!vma_is_anonymous(vma)) {
> +		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> +				HPAGE_PMD_NR))
> +			return false;
> +	}
> +
> +	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> +		return false;
> +	return true;
> +}
> +
> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> +					  unsigned long vm_flags)
> +{
> +	/* Explicitly disabled through madvise. */
> +	if ((vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +		return false;
> +	return true;
> +}
> +
>  /*
>   * to be used on vmas which are known to support THP.
> - * Use transparent_hugepage_enabled otherwise
> + * Use transparent_hugepage_active otherwise
>   */
>  static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
> @@ -128,15 +153,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
>  		return false;
>  
> -	if (vma->vm_flags & VM_NOHUGEPAGE)
> +	if (!transhuge_vma_enabled(vma, vma->vm_flags))
>  		return false;
>  
>  	if (vma_is_temporary_stack(vma))
>  		return false;
>  
> -	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -		return false;
> -
>  	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>  		return true;
>  
> @@ -150,22 +172,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> -bool transparent_hugepage_enabled(struct vm_area_struct *vma);
> -
> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> -		unsigned long haddr)
> -{
> -	/* Don't have to check pgoff for anonymous vma */
> -	if (!vma_is_anonymous(vma)) {
> -		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> -				HPAGE_PMD_NR))
> -			return false;
> -	}
> -
> -	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> -		return false;
> -	return true;
> -}
> +bool transparent_hugepage_active(struct vm_area_struct *vma);
>  
>  #define transparent_hugepage_use_zero_page()				\
>  	(transparent_hugepage_flags &					\
> @@ -351,7 +358,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> -static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> +static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
>  	return false;
>  }
> @@ -362,6 +369,12 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  	return false;
>  }
>  
> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> +					  unsigned long vm_flags)
> +{
> +	return false;
> +}
> +
>  static inline void prep_transhuge_page(struct page *page) {}
>  
>  static inline bool is_transparent_hugepage(struct page *page)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 76ca1eb2a223..4f37867eed12 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -63,7 +63,14 @@ static struct shrinker deferred_split_shrinker;
>  static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>  
> -bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> +static inline bool file_thp_enabled(struct vm_area_struct *vma)
> +{
> +	return transhuge_vma_enabled(vma, vma->vm_flags) && vma->vm_file &&
> +	       !inode_is_open_for_write(vma->vm_file->f_inode) &&
> +	       (vma->vm_flags & VM_EXEC);
> +}
> +
> +bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
>  	/* The addr is used to check if the vma size fits */
>  	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> @@ -74,6 +81,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>  		return __transparent_hugepage_enabled(vma);
>  	if (vma_is_shmem(vma))
>  		return shmem_huge_enabled(vma);
> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
> +		return file_thp_enabled(vma);
>  
>  	return false;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6c0185fdd815..d97b20fad6e8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -442,9 +442,7 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
>  static bool hugepage_vma_check(struct vm_area_struct *vma,
>  			       unsigned long vm_flags)
>  {
> -	/* Explicitly disabled through madvise. */
> -	if ((vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +	if (!transhuge_vma_enabled(vma, vm_flags))
>  		return false;
>  
>  	/* Enabled via shmem mount options or sysfs settings. */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a08cedefbfaa..1dcbec313c70 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4032,8 +4032,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>  	loff_t i_size;
>  	pgoff_t off;
>  
> -	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +	if (!transhuge_vma_enabled(vma, vma->vm_flags))
>  		return false;
>  	if (shmem_huge == SHMEM_HUGE_FORCE)
>  		return true;

