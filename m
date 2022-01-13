Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186D48D85E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiAMM7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:59:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiAMM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:59:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98EF71F3A5;
        Thu, 13 Jan 2022 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642078759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vv3YGXMT8AxGWpW+Dzy/8zLb0WnXvt8taPrphfNVQtA=;
        b=lergYT++iWpyZ9mBW4jtxhKHhRPWR2pEzD1/xhiB14BULP0+LOzu7nIbezcnzuUcQ4lunk
        e2zNFTMjFjhjyu49YA8u3EcWyajXX0lEpq/NAA7idB1I4nXMZN3dO8Kjwr3abqidaUtxNb
        ivDRLTOcjLPSqX1eCdAtcmlwA2TvbBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642078759;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vv3YGXMT8AxGWpW+Dzy/8zLb0WnXvt8taPrphfNVQtA=;
        b=tgkgj0wdrBILIa1KQLK+943OqbiqvyJBoYwg+0+8LtUw9d+/bLpw/tLJyMMRs8F4ysxsYV
        LKnF+uv6mRdWGaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 493AA13FB3;
        Thu, 13 Jan 2022 12:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nvQkESci4GFUUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Jan 2022 12:59:19 +0000
Message-ID: <90334a13-8a4a-d8bd-4971-e56b77ff9001@suse.cz>
Date:   Thu, 13 Jan 2022 13:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-22-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 21/66] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
In-Reply-To: <20211201142918.921493-22-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Avoid allocating a new VMA when it a vma modification can occur.  When a
> brk() can expand or contract a VMA, then the single store operation will
> only modify one index of the maple tree instead of causing a node to
> split or coalesce.  This avoids unnecessary allocations/frees of maple
> tree nodes and VMAs.
> 
> Use the advanced API for the maple tree to avoid unnecessary walks of
> the tree.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 258 +++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 207 insertions(+), 51 deletions(-)
> 
> +static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
> +			unsigned long addr, unsigned long len,
> +			unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma, *prev;
> -	pgoff_t pgoff = addr >> PAGE_SHIFT;
> +	struct vm_area_struct *prev = NULL;
>  	int error;
>  	unsigned long mapped_addr;
>  	validate_mm_mt(mm);
> @@ -2740,11 +2854,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
>  	if (error)
>  		return error;
>  
> -	/* Clear old maps, set up prev and uf */
> -	if (munmap_vma_range(mm, addr, len, &prev, uf))
> -		return -ENOMEM;
> -
> -	/* Check against address space limits *after* clearing old maps... */
> +	/* Check against address space limits by the changed size */

Can that cause spurious ENOMEM because now the check assumes 'len' worth of
purely new pages and no reuse?

>  	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
>  		return -ENOMEM;
>  
> @@ -2754,28 +2864,57 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
>  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
>  		return -ENOMEM;
>  
> -	/* Can we just expand an old private anonymous mapping? */
> -	vma = vma_merge(mm, prev, addr, addr + len, flags,
> -			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
> -	if (vma)
> -		goto out;
> +	mas->last = addr + len - 1;
> +	if (vma) {
> +		/* Expand the existing vma if possible; almost never a singular
> +		 * list, so this will almost always fail. */
>  
> -	/*
> -	 * create a vma struct for an anonymous mapping
> -	 */
> -	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		vm_unacct_memory(len >> PAGE_SHIFT);
> -		return -ENOMEM;
> +		if ((!vma->anon_vma ||
> +		     list_is_singular(&vma->anon_vma_chain)) &&

Hmm I feel uneasy about this part that mimics what vma_merge() does. Looks
like something e.g. we can easily forget to adjust when changing vma_merge()
itself.
Is this optimization worth the trouble given the comment above "so this will
almost always fail"?

> +		     ((vma->vm_flags & ~VM_SOFTDIRTY) == flags)){
> +			mas->index = vma->vm_start;
> +
> +			vma_adjust_trans_huge(vma, addr, addr + len, 0);
> +			if (vma->anon_vma) {
> +				anon_vma_lock_write(vma->anon_vma);
> +				anon_vma_interval_tree_pre_update_vma(vma);
> +			}
> +			vma->vm_end = addr + len;
> +			vma->vm_flags |= VM_SOFTDIRTY;
> +			if (mas_store_gfp(mas, vma, GFP_KERNEL))
> +				goto mas_mod_fail;
> +
> +			if (vma->anon_vma) {
> +				anon_vma_interval_tree_post_update_vma(vma);
> +				anon_vma_unlock_write(vma->anon_vma);
> +			}
> +			khugepaged_enter_vma_merge(vma, flags);
> +			goto out;
> +		}
> +		prev = vma;
>  	}
> +	mas->index = addr;
> +	mas_walk(mas);
> +
> +	/* create a vma struct for an anonymous mapping */
> +	vma = vm_area_alloc(mm);
> +	if (!vma)
> +		goto vma_alloc_fail;
>  
>  	vma_set_anonymous(vma);
>  	vma->vm_start = addr;
>  	vma->vm_end = addr + len;
> -	vma->vm_pgoff = pgoff;
> +	vma->vm_pgoff = addr >> PAGE_SHIFT;
>  	vma->vm_flags = flags;
>  	vma->vm_page_prot = vm_get_page_prot(flags);
> -	vma_link(mm, vma, prev);
> +	if (vma_mas_store(vma, mas))
> +		goto mas_store_fail;
> +
> +	if (!prev)
> +		prev = mas_prev(mas, 0);
> +
> +	__vma_link_list(mm, vma, prev);
> +	mm->map_count++;
>  out:
>  	perf_event_mmap(vma);
>  	mm->total_vm += len >> PAGE_SHIFT;
> @@ -2785,15 +2924,31 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
>  	vma->vm_flags |= VM_SOFTDIRTY;
>  	validate_mm_mt(mm);
>  	return 0;
> +
> +mas_store_fail:
> +	vm_area_free(vma);
> +vma_alloc_fail:
> +	vm_unacct_memory(len >> PAGE_SHIFT);
> +	return -ENOMEM;
> +
> +mas_mod_fail:
> +	vma->vm_end = addr;
> +	if (vma->anon_vma) {
> +		anon_vma_interval_tree_post_update_vma(vma);
> +		anon_vma_unlock_write(vma->anon_vma);
> +	}
> +	return -ENOMEM;
> +
>  }
>  
>  int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = NULL;
>  	unsigned long len;
>  	int ret;
>  	bool populate;
> -	LIST_HEAD(uf);
> +	MA_STATE(mas, &mm->mm_mt, addr, addr);
>  
>  	len = PAGE_ALIGN(request);
>  	if (len < request)
> @@ -2804,10 +2959,11 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>  
> -	ret = do_brk_flags(addr, len, flags, &uf);
> +	// This vma left intentionally blank.

This comment using unintentionally bad syntax (// vs /* */)

Also if we leave it blank it means this path won't ever expand an existing
vma, while previously it could succeed the vma_merge, no? Or all callers of
vm_brk_flags() in a scenario where there's no expand anyway? Maybe just have
a more verbose comment...

> +	mas_walk(&mas);
> +	ret = do_brk_flags(&mas, vma, addr, len, flags);
>  	populate = ((mm->def_flags & VM_LOCKED) != 0);
>  	mmap_write_unlock(mm);
> -	userfaultfd_unmap_complete(mm, &uf);

Looks like this part is removed completely from vm_brk_flags() paths?

OK it seems the whole patch makes some asumption that vm_brk_flags() never
has to unmap a pre-existing area, and in the brk() syscall this is now
delegated to do_brk_munmap(), and do_brk_flags() loses the support. While it
might be safe, it should be discussed in the patch that vm_brk_flags()
didn't actually need to support the unmap part, because x y z. And best if
there are some DEBUG_VM based assertions supporting that.

But then again, is the optimized scenario happening often enough to warrant it?

>  	if (populate && !ret)
>  		mm_populate(addr, len);
>  	return ret;

