Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC95019E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiDNRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbiDNRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE75F9C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:15:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 883AE1F747;
        Thu, 14 Apr 2022 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649956503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RI4vY7SM3nGEvLVWVvIyfXvrCtyaLTk6ZtXdIjy/7XI=;
        b=0WIrx6FIqdSAruwf5lhWFHS8dCyQmcvo0Vl1gBzblLGWa3nWwl2QtPL8C/77cock9Bj1CY
        QEFSSfivasMVuzIs0dyRkP48cd+vcIzuQGRT7cmU7HK5K3IQIE/+8unDSvnCQ4lQmmSiI8
        b9SCYyRbCQJQhCjmYYHeN9fuhRuzydA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649956503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RI4vY7SM3nGEvLVWVvIyfXvrCtyaLTk6ZtXdIjy/7XI=;
        b=WUH+I7Uzjz1uKrRfEhnCMZiS3wSqkYgxcOOIqZ9KF0lYMOt75GjoMILRbdgQPyiYUOkDnf
        kEs1jAU7U5ZyuTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 256E213A86;
        Thu, 14 Apr 2022 17:15:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 34VKCJdWWGL/GAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Apr 2022 17:15:03 +0000
Message-ID: <9005b167-db08-c967-463b-5e0e092cbb6c@suse.cz>
Date:   Thu, 14 Apr 2022 19:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-15-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 14/16] mm: support GUP-triggered unsharing of anonymous
 pages
In-Reply-To: <20220329160440.193848-15-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
> on the page table entry will end up replacing the mapped anonymous page
> due to COW, resulting in the GUP pin no longer being consistent with the
> page actually mapped into the page table.
> 
> The possible ways to deal with this situation are:
>  (1) Ignore and pin -- what we do right now.
>  (2) Fail to pin -- which would be rather surprising to callers and
>      could break user space.
>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
>      pins.
> 
> We want to implement 3) because it provides the clearest semantics and
> allows for checking in unpin_user_pages() and friends for possible BUGs:
> when trying to unpin a page that's no longer exclusive, clearly
> something went very wrong and might result in memory corruptions that
> might be hard to debug. So we better have a nice way to spot such
> issues.
> 
> To implement 3), we need a way for GUP to trigger unsharing:
> FAULT_FLAG_UNSHARE. FAULT_FLAG_UNSHARE is only applicable to R/O mapped
> anonymous pages and resembles COW logic during a write fault. However, in
> contrast to a write fault, GUP-triggered unsharing will, for example, still
> maintain the write protection.
> 
> Let's implement FAULT_FLAG_UNSHARE by hooking into the existing write fault
> handlers for all applicable anonymous page types: ordinary pages, THP and
> hugetlb.
> 
> * If FAULT_FLAG_UNSHARE finds a R/O-mapped anonymous page that has been
>   marked exclusive in the meantime by someone else, there is nothing to do.
> * If FAULT_FLAG_UNSHARE finds a R/O-mapped anonymous page that's not
>   marked exclusive, it will try detecting if the process is the exclusive
>   owner. If exclusive, it can be set exclusive similar to reuse logic
>   during write faults via page_move_anon_rmap() and there is nothing
>   else to do; otherwise, we either have to copy and map a fresh,
>   anonymous exclusive page R/O (ordinary pages, hugetlb), or split the
>   THP.
> 
> This commit is heavily based on patches by Andrea.
> 
> Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Modulo a nit and suspected logical bug below.

<snip>

> @@ -3072,6 +3082,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		 * mmu page tables (such as kvm shadow page tables), we want the
>  		 * new page to be mapped directly into the secondary page table.
>  		 */
> +		BUG_ON(unshare && pte_write(entry));
>  		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
>  		update_mmu_cache(vma, vmf->address, vmf->pte);
>  		if (old_page) {
> @@ -3121,7 +3132,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  			free_swap_cache(old_page);
>  		put_page(old_page);
>  	}
> -	return page_copied ? VM_FAULT_WRITE : 0;
> +	return page_copied && !unshare ? VM_FAULT_WRITE : 0;

Could be just me but I would prefer (page_copied && !unshare) as I rarely
see these operators together like this to remember their relative priority
very well.

>  oom_free_new:
>  	put_page(new_page);
>  oom:

<snip>

> @@ -4515,8 +4550,11 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  /* `inline' is required to avoid gcc 4.1.2 build error */
>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  {
> +	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
> +
>  	if (vma_is_anonymous(vmf->vma)) {
> -		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
> +		if (unlikely(unshare) &&

Is this condition flipped, should it be "likely(!unshare)"? As the similar
code in do_wp_page() does.

> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>  			return handle_userfault(vmf, VM_UFFD_WP);
>  		return do_huge_pmd_wp_page(vmf);
>  	}
> @@ -4651,10 +4689,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
>  		goto unlock;
>  	}
> -	if (vmf->flags & FAULT_FLAG_WRITE) {
> +	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>  		if (!pte_write(entry))
>  			return do_wp_page(vmf);
> -		entry = pte_mkdirty(entry);
> +		else if (likely(vmf->flags & FAULT_FLAG_WRITE))
> +			entry = pte_mkdirty(entry);
>  	}
>  	entry = pte_mkyoung(entry);
>  	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
