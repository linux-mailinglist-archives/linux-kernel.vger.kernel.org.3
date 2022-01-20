Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC93F494D81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiATL67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:58:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34620 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiATL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:58:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20F7C1F3A9;
        Thu, 20 Jan 2022 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642679928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0bE+QNoeXrZ/9XBe6IJhaAGFRXVIa34iInEL3UPifI=;
        b=wWHVQhQfZHaR4A49v0RdYHWzgIymU/So/8WdcmuQv/BaZiUUP4qRmgcFFkqX5rtj9C/xg6
        tpstC1fszBfkAeKClTTuxqgaTtQOu5PeI/Tkhqnj4lZgNWgkVNLobX7BYJLK6HZKRthL5d
        fEhJnKyn7Mg2TZUPqAUdE0DTthzLxRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642679928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0bE+QNoeXrZ/9XBe6IJhaAGFRXVIa34iInEL3UPifI=;
        b=scLZd7lihVsYbP2S+UchL/cWnLdV0qwCmRtrjJA/1OjSYYbz6ZsHzywfA2rCBob+4wZu/M
        ABvuhyKQMSnLApBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C754E13B51;
        Thu, 20 Jan 2022 11:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yD3RL3dO6WGvUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 11:58:47 +0000
Message-ID: <10798a7d-e157-03c2-abf4-f005a3507cae@suse.cz>
Date:   Thu, 20 Jan 2022 12:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
 <20211201142918.921493-56-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
In-Reply-To: <20211201142918.921493-56-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mempolicy.c | 53 ++++++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10e9c87260ed..0e2d918f4f30 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -377,9 +377,10 @@ void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new)
>  void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
>  {
>  	struct vm_area_struct *vma;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);

VMA_ITERATOR?

>  
>  	mmap_write_lock(mm);
> -	for (vma = mm->mmap; vma; vma = vma->vm_next)
> +	mas_for_each(&mas, vma, ULONG_MAX)
>  		mpol_rebind_policy(vma->vm_policy, new);
>  	mmap_write_unlock(mm);
>  }
> @@ -652,7 +653,7 @@ static unsigned long change_prot_numa(struct vm_area_struct *vma,
>  static int queue_pages_test_walk(unsigned long start, unsigned long end,
>  				struct mm_walk *walk)
>  {
> -	struct vm_area_struct *vma = walk->vma;
> +	struct vm_area_struct *next, *vma = walk->vma;
>  	struct queue_pages *qp = walk->private;
>  	unsigned long endvma = vma->vm_end;
>  	unsigned long flags = qp->flags;
> @@ -667,9 +668,10 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>  			/* hole at head side of range */
>  			return -EFAULT;
>  	}
> +	next = find_vma(vma->vm_mm, vma->vm_end);
>  	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
>  		((vma->vm_end < qp->end) &&
> -		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
> +		(!next || vma->vm_end < next->vm_start)))
>  		/* hole at middle or tail of range */
>  		return -EFAULT;
>  
> @@ -783,28 +785,24 @@ static int vma_replace_policy(struct vm_area_struct *vma,
>  static int mbind_range(struct mm_struct *mm, unsigned long start,
>  		       unsigned long end, struct mempolicy *new_pol)
>  {
> -	struct vm_area_struct *next;
> +	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
>  	struct vm_area_struct *prev;
>  	struct vm_area_struct *vma;
>  	int err = 0;
>  	pgoff_t pgoff;
> -	unsigned long vmstart;
> -	unsigned long vmend;
> -
> -	vma = find_vma(mm, start);
> -	VM_BUG_ON(!vma);
>  
> -	prev = vma->vm_prev;
> -	if (start > vma->vm_start)
> -		prev = vma;
> +	prev = mas_find_rev(&mas, 0);
> +	if (prev && (start < prev->vm_end))
> +		vma = prev;
> +	else
> +		vma = mas_next(&mas, end - 1);
>  
> -	for (; vma && vma->vm_start < end; prev = vma, vma = next) {
> -		next = vma->vm_next;
> -		vmstart = max(start, vma->vm_start);
> -		vmend   = min(end, vma->vm_end);
> +	do {
> +		unsigned long vmstart = max(start, vma->vm_start);
> +		unsigned long vmend = min(end, vma->vm_end);

What if vma is null? Shouldn't this rather be a "for (; vma; vma =
mas_next(...)"

>  
>  		if (mpol_equal(vma_policy(vma), new_pol))
> -			continue;
> +			goto next;
>  
>  		pgoff = vma->vm_pgoff +
>  			((vmstart - vma->vm_start) >> PAGE_SHIFT);
> @@ -812,8 +810,8 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
>  				 vma->anon_vma, vma->vm_file, pgoff,
>  				 new_pol, vma->vm_userfaultfd_ctx);
>  		if (prev) {
> +			mas_pause(&mas);
>  			vma = prev;
> -			next = vma->vm_next;
>  			if (mpol_equal(vma_policy(vma), new_pol))
>  				continue;
>  			/* vma_merge() joined vma && vma->next, case 8 */
> @@ -823,19 +821,23 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
>  			err = split_vma(vma->vm_mm, vma, vmstart, 1);
>  			if (err)
>  				goto out;
> +			mas_pause(&mas);
>  		}
>  		if (vma->vm_end != vmend) {
>  			err = split_vma(vma->vm_mm, vma, vmend, 0);
>  			if (err)
>  				goto out;
> +			/* mas_pause() unnecessary as the loop is ending */
>  		}
> - replace:
> +replace:
>  		err = vma_replace_policy(vma, new_pol);
>  		if (err)
>  			goto out;
> -	}
> +next:
> +		prev = vma;
> +	} while ((vma = mas_next(&mas, end - 1)) != NULL);
>  
> - out:
> +out:
>  	return err;
>  }
>  
> @@ -1053,6 +1055,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  			   int flags)
>  {
>  	nodemask_t nmask;
> +	struct vm_area_struct *vma;
>  	LIST_HEAD(pagelist);
>  	int err = 0;
>  	struct migration_target_control mtc = {
> @@ -1068,8 +1071,9 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  	 * need migration.  Between passing in the full user address
>  	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
>  	 */
> +	vma = find_vma(mm, 0);
>  	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
> -	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
> +	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
>  			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
>  
>  	if (!list_empty(&pagelist)) {
> @@ -1198,13 +1202,12 @@ static struct page *new_page(struct page *page, unsigned long start)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long address;
> +	MA_STATE(mas, &current->mm->mm_mt, start, start);
>  
> -	vma = find_vma(current->mm, start);
> -	while (vma) {
> +	mas_for_each(&mas, vma, ULONG_MAX) {
>  		address = page_address_in_vma(page, vma);
>  		if (address != -EFAULT)
>  			break;
> -		vma = vma->vm_next;
>  	}
>  
>  	if (PageHuge(page)) {

