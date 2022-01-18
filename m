Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85A4923DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiARKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:40:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiARKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:39:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2ADF1F3A1;
        Tue, 18 Jan 2022 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642502397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHPUwbtFeoE0ORf/ZOnFmdOiPu1cHwxOX55EXE7/xBs=;
        b=Al4aMfDnRCunydLsj2lCJfrlUrJvAtQiR8queTeqgAqjWyhlCFX5BrLjPeOJALEyZXnl4A
        w20jgEJP+2tSPYyj1be2AahY4YrbwppwADLL0acCHKBvhSLdGZdWnhYlDfCLA9kv/MKRH/
        LevSF8DxkG5P+9Pec6Rbd0YHCV5xh1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642502397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHPUwbtFeoE0ORf/ZOnFmdOiPu1cHwxOX55EXE7/xBs=;
        b=pa8NSMY3/oCpDERwBrDj716mVVNZYLoDBdfaMNindBEGnunAwcEsjqBGk7EuIJ8Yg5/73f
        Oj6iXNVsK3eIl6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 564F213DC7;
        Tue, 18 Jan 2022 10:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hivrE/2Y5mHiMQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 10:39:57 +0000
Message-ID: <e7476b15-d35e-8af0-24f2-9a7bbe082035@suse.cz>
Date:   Tue, 18 Jan 2022 11:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Vlastimil Babka <vbabka@suse.cz>
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
 <20211201142918.921493-27-Liam.Howlett@oracle.com>
Content-Language: en-US
Subject: Re: [PATCH v4 26/66] mm/mmap: Reorganize munmap to use maple states
In-Reply-To: <20211201142918.921493-27-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
> do_mas_align_munmap().
> 
> do_munmap() is a wrapper to create a maple state for any callers that
> have not been converted to the maple tree.
> 
> do_mas_munmap() takes a maple state to mumap a range.  This is just a
> small function which checks for error conditions and aligns the end of
> the range.
> 
> do_mas_align_munmap() uses the aligned range to mumap a range.
> do_mas_align_munmap() starts with the first VMA in the range, then finds
> the last VMA in the range.  Both start and end are split if necessary.
> Then the VMAs are unlocked and removed from the linked list at the same
> time.  Followed by a single tree operation of overwriting the area in
> with a NULL.  Finally, the detached list is unmapped and freed.
> 
> By reorganizing the munmap calls as outlined, it is now possible to
> avoid extra work of aligning pre-aligned callers which are known to be
> safe, avoid extra VMA lookups or tree walks for modifications.
> 
> detach_vmas_to_be_unmapped() is no longer used, so drop this code.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

<snip>

> -/* Munmap is split into 2 main parts -- this part which finds
> - * what needs doing, and the areas themselves, which do the
> - * work.  This now handles partial unmappings.
> - * Jeremy Fitzhardinge <jeremy@goop.org>
> +/*
> + * do_mas_align_munmap() - munmap the aligned region from @start to @end.
> + * @mas: The maple_state, ideally set up to alter the correct tree location.
> + * @vma: The starting vm_area_struct
> + * @mm: The mm_struct
> + * @start: The aligned start address to munmap.
> + * @end: The aligned end address to munmap.
> + * @uf: The userfaultfd list_head
> + * @downgrade: Set to true to attempt a downwrite of the mmap_sem

s/downwrite/write downgrade/?

> + *
> + * @mas must be locked before calling this function.  If @downgrade is true,
> + * check return code for potential release of the lock.

How is 'mas' locked? The downgrade still calls  mmap_write_downgrade(mm). It
should say "mm's mmap_lock should be write locked" no?

>   */
> -int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> -		struct list_head *uf, bool downgrade)
> +static int
> +do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
> +		    struct mm_struct *mm, unsigned long start,
> +		    unsigned long end, struct list_head *uf, bool downgrade)
>  {
> -	unsigned long end;
> -	struct vm_area_struct *vma, *prev, *last;
> -
> -	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
> -		return -EINVAL;
> -
> -	len = PAGE_ALIGN(len);
> -	end = start + len;
> -	if (len == 0)
> -		return -EINVAL;
> -
> -	 /* arch_unmap() might do unmaps itself.  */
> -	arch_unmap(mm, start, end);
> -
> -	/* Find the first overlapping VMA where start < vma->vm_end */
> -	vma = find_vma_intersection(mm, start, end);
> -	if (!vma)
> -		return 0;
> -	prev = vma->vm_prev;
> +	struct vm_area_struct *prev, *last;
>  	/* we have start < vma->vm_end  */
>  
>  	/*
> @@ -2458,16 +2418,26 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  		if (error)
>  			return error;
>  		prev = vma;
> +		vma = __vma_next(mm, prev);
> +		mas->index = start;
> +		mas_reset(mas);
> +	} else {
> +		prev = vma->vm_prev;
>  	}
>  
> +	if (vma->vm_end >= end)
> +		last = vma;
> +	else
> +		last = find_vma_intersection(mm, end - 1, end);
> +
>  	/* Does it split the last one? */
> -	last = find_vma(mm, end);
> -	if (last && end > last->vm_start) {
> +	if (last && end < last->vm_end) {
>  		int error = __split_vma(mm, last, end, 1);
>  		if (error)
>  			return error;
> +		vma = __vma_next(mm, prev);

Should be needed only if last == vma?

> +		mas_reset(mas);
>  	}
> -	vma = __vma_next(mm, prev);
>  
>  	if (unlikely(uf)) {
>  		/*
> @@ -2480,22 +2450,47 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  		 * failure that it's not worth optimizing it for.
>  		 */
>  		int error = userfaultfd_unmap_prep(vma, start, end, uf);
> +
>  		if (error)
>  			return error;
>  	}
>  
>  	/*
> -	 * unlock any mlock()ed ranges before detaching vmas
> +	 * unlock any mlock()ed ranges before detaching vmas, count the number
> +	 * of VMAs to be dropped, and return the tail entry of the affected
> +	 * area.
>  	 */
> -	if (mm->locked_vm)
> -		unlock_range(vma, end);
> +	mm->map_count -= unlock_range(vma, &last, end);
> +	/* Drop removed area from the tree */
> +	mas_store_gfp(mas, NULL, GFP_KERNEL);
>  
> -	/* Detach vmas from the MM linked list and remove from the mm tree*/
> -	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
> -		downgrade = false;
> +	/* Detach vmas from the MM linked list */
> +	vma->vm_prev = NULL;
> +	if (prev)
> +		prev->vm_next = last->vm_next;
> +	else
> +		mm->mmap = last->vm_next;
>  
> -	if (downgrade)
> -		mmap_write_downgrade(mm);
> +	if (last->vm_next) {
> +		last->vm_next->vm_prev = prev;
> +		last->vm_next = NULL;
> +	} else
> +		mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
> +
> +	/*
> +	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
> +	 * VM_GROWSUP VMA. Such VMAs can change their size under
> +	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
> +	 */
> +	if (downgrade) {
> +		if (last && (last->vm_flags & VM_GROWSDOWN))
> +			downgrade = false;
> +		else if (prev && (prev->vm_flags & VM_GROWSUP))
> +			downgrade = false;
> +		else {
> +			mmap_write_downgrade(mm);
> +		}

remove { } brackets?

> +	}
>  
>  	unmap_region(mm, vma, prev, start, end);
>  
> @@ -2505,10 +2500,61 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	return downgrade ? 1 : 0;
>  }
>  
> +/*
> + * do_mas_munmap() - munmap a given range.
> + * @mas: The maple state
> + * @mm: The mm_struct
> + * @start: The start address to munmap
> + * @len: The length of the range to munmap
> + * @uf: The userfaultfd list_head
> + * @downgrade: set to true if the user wants to attempt to write_downgrade the
> + * mmap_sem
> + *
> + * This function takes a @mas that is in the correct state to remove the
> + * mapping(s).  The @len will be aligned and any arch_unmap work will be
> + * preformed.
> + * @mas must be locked. @mas may be unlocked if @degraded is true.
> + *
> + * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
> + */
> +int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
> +		  unsigned long start, size_t len, struct list_head *uf,
> +		  bool downgrade)
> +{
> +	unsigned long end;
> +	struct vm_area_struct *vma;
> +
> +	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
> +		return -EINVAL;
> +
> +	end = start + PAGE_ALIGN(len);
> +	if (end == start)
> +		return -EINVAL;
> +
> +	 /* arch_unmap() might do unmaps itself.  */
> +	arch_unmap(mm, start, end);
> +
> +	/* Find the first overlapping VMA */
> +	vma = mas_find(mas, end - 1);
> +	if (!vma)
> +		return 0;
> +
> +	mas->last = end - 1;

Why not set this before mas_find() above? Hm but that takes its own second
parameter instead of looking at mas->last. To be honest, I'm a bit confused
wrt the role of mas->last in the API. Perhaps another suggestion for the
"how to improve docs" discussion earlier. Or maybe I just missed/forgot it.

> +	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
> +}
> +

<snip>

> diff --git a/mm/mremap.c b/mm/mremap.c
> index 002eec83e91e..b09e107cd18b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -978,20 +978,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	/*
>  	 * Always allow a shrinking remap: that just unmaps
>  	 * the unnecessary pages..
> -	 * __do_munmap does all the needed commit accounting, and
> +	 * do_mas_munmap does all the needed commit accounting, and
>  	 * downgrades mmap_lock to read if so directed.
>  	 */
>  	if (old_len >= new_len) {
>  		int retval;
> +		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
>  
> -		retval = __do_munmap(mm, addr+new_len, old_len - new_len,
> -				  &uf_unmap, true);
> -		if (retval < 0 && old_len != new_len) {
> -			ret = retval;
> -			goto out;
> +		retval = do_mas_munmap(&mas, mm, addr + new_len,
> +				       old_len - new_len, &uf_unmap, true);
>  		/* Returning 1 indicates mmap_lock is downgraded to read. */
> -		} else if (retval == 1)
> +		if (retval == 1) {
>  			downgraded = true;
> +		} else if (retval < 0 && old_len != new_len) {
> +			ret = retval;
> +			goto out;
> +		}
> +
>  		ret = addr;
>  		goto out;
>  	}
> @@ -1006,7 +1009,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	}
>  
>  	/* old_len exactly to the end of the area..
> -	 */
> +	*/

Spurious edit?

>  	if (old_len == vma->vm_end - addr) {
>  		/* can we just expand the current mapping? */
>  		if (vma_expandable(vma, new_len - old_len)) {
> @@ -1048,9 +1051,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  			map_flags |= MAP_SHARED;
>  
>  		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
> -					vma->vm_pgoff +
> -					((addr - vma->vm_start) >> PAGE_SHIFT),
> -					map_flags);
> +					     vma->vm_pgoff +
> +					     ((addr - vma->vm_start) >> PAGE_SHIFT),
> +					     map_flags);

And this?

>  		if (IS_ERR_VALUE(new_addr)) {
>  			ret = new_addr;
>  			goto out;


