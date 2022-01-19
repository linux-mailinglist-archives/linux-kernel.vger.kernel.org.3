Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7FF493E43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355926AbiASQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:26:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59234 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiASQ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:26:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FF5121126;
        Wed, 19 Jan 2022 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642609566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E63fZnex+QYWg/yAICy72egnOKkZBYns0GaGlwhZloI=;
        b=LuvxsKb7ymWW3zMsC881dMKP8ahssWpNTaVYSh5eMD7WiT3yBjPY0AeD1HDfOVCftIDYHM
        3FfoXdSWo4j7AOgUs43xjj7VTB1rJNOi5SXpGxE7Q1892eRpCpbLp2kCqXXKWw77jxALFF
        hLOMVPDMPeGkQalaaaZB3Fzvv/RMYDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642609566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E63fZnex+QYWg/yAICy72egnOKkZBYns0GaGlwhZloI=;
        b=YoZh3GGZyRyuXu3SlblFiSvyHeu1GbaSDMGQ+6WXcs+FqJMZljtLFyxvCSUxaBPRbcLBDQ
        A5XXdol8I0CM9UCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56B8913F84;
        Wed, 19 Jan 2022 16:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6cd3FJ476GE6IwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 16:26:06 +0000
Message-ID: <e0aa5cc6-0e3c-a642-5b51-66cffd9ea4c5@suse.cz>
Date:   Wed, 19 Jan 2022 17:26:06 +0100
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
 <20211201142918.921493-44-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 43/66] userfaultfd: Use maple tree iterator to iterate
 VMAs
In-Reply-To: <20211201142918.921493-44-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Don't use the mm_struct linked list or the vma->vm_next in prep for removal
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  fs/userfaultfd.c              | 49 ++++++++++++++++++++++-------------
>  include/linux/userfaultfd_k.h |  7 +++--
>  mm/mmap.c                     | 12 ++++-----
>  3 files changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 22bf14ab2d16..2880025598c7 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -606,14 +606,16 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>  	if (release_new_ctx) {
>  		struct vm_area_struct *vma;
>  		struct mm_struct *mm = release_new_ctx->mm;
> +		VMA_ITERATOR(vmi, mm, 0);
>  
>  		/* the various vma->vm_userfaultfd_ctx still points to it */
>  		mmap_write_lock(mm);
> -		for (vma = mm->mmap; vma; vma = vma->vm_next)
> +		for_each_vma(vmi, vma) {
>  			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
>  				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>  				vma->vm_flags &= ~__VM_UFFD_FLAGS;
>  			}
> +		}
>  		mmap_write_unlock(mm);
>  
>  		userfaultfd_ctx_put(release_new_ctx);
> @@ -794,11 +796,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx, struct list_head *unmaps,
>  	return false;
>  }
>  
> -int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> -			   unsigned long start, unsigned long end,
> -			   struct list_head *unmaps)
> +int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
> +			   unsigned long end, struct list_head *unmaps)
>  {
> -	for ( ; vma && vma->vm_start < end; vma = vma->vm_next) {
> +	VMA_ITERATOR(vmi, mm, start);
> +	struct vm_area_struct *vma;
> +
> +	for_each_vma_range(vmi, vma, end) {
>  		struct userfaultfd_unmap_ctx *unmap_ctx;
>  		struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
>  
> @@ -848,6 +852,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  	/* len == 0 means wake all */
>  	struct userfaultfd_wake_range range = { .len = 0, };
>  	unsigned long new_flags;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);

Again, it looks like this could also be VMA_ITERATOR, consistent with the
one above?

>  
>  	WRITE_ONCE(ctx->released, true);
>  
> @@ -864,7 +869,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  	 */
>  	mmap_write_lock(mm);
>  	prev = NULL;
> -	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +	mas_for_each(&mas, vma, ULONG_MAX) {
>  		cond_resched();
>  		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
>  		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
> @@ -1281,6 +1286,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	bool found;
>  	bool basic_ioctls;
>  	unsigned long start, end, vma_end;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
>  
> @@ -1323,7 +1329,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		goto out;
>  
>  	mmap_write_lock(mm);
> -	vma = find_vma_prev(mm, start, &prev);
> +	mas_set(&mas, start);
> +	vma = mas_find(&mas, ULONG_MAX);
>  	if (!vma)
>  		goto out_unlock;
>  
> @@ -1348,7 +1355,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	 */
>  	found = false;
>  	basic_ioctls = false;
> -	for (cur = vma; cur && cur->vm_start < end; cur = cur->vm_next) {
> +	for (cur = vma; cur; cur = mas_next(&mas, end - 1)) {
>  		cond_resched();
>  
>  		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
> @@ -1408,8 +1415,10 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	}
>  	BUG_ON(!found);
>  
> -	if (vma->vm_start < start)
> -		prev = vma;
> +	mas_set(&mas, start);
> +	prev = mas_prev(&mas, 0);
> +	if (prev != vma)
> +		mas_next(&mas, ULONG_MAX);

Hmm non-commented tricky stuff...

>  
>  	ret = 0;
>  	do {
> @@ -1466,8 +1475,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> -		vma = vma->vm_next;
> -	} while (vma && vma->vm_start < end);
> +		vma = mas_next(&mas, end - 1);
> +	} while (vma);
>  out_unlock:
>  	mmap_write_unlock(mm);
>  	mmput(mm);
> @@ -1511,6 +1520,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	bool found;
>  	unsigned long start, end, vma_end;
>  	const void __user *buf = (void __user *)arg;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> @@ -1529,7 +1539,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		goto out;
>  
>  	mmap_write_lock(mm);
> -	vma = find_vma_prev(mm, start, &prev);
> +	mas_set(&mas, start);
> +	vma = mas_find(&mas, ULONG_MAX);
>  	if (!vma)
>  		goto out_unlock;
>  
> @@ -1554,7 +1565,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	 */
>  	found = false;
>  	ret = -EINVAL;
> -	for (cur = vma; cur && cur->vm_start < end; cur = cur->vm_next) {
> +	for (cur = vma; cur; cur = mas_next(&mas, end - 1)) {
>  		cond_resched();
>  
>  		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
> @@ -1574,8 +1585,10 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	}
>  	BUG_ON(!found);
>  
> -	if (vma->vm_start < start)
> -		prev = vma;
> +	mas_set(&mas, start);
> +	prev = mas_prev(&mas, 0);
> +	if (prev != vma)
> +		mas_next(&mas, ULONG_MAX);

Same here.

>  
>  	ret = 0;
>  	do {
> @@ -1640,8 +1653,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> -		vma = vma->vm_next;
> -	} while (vma && vma->vm_start < end);
> +		vma = mas_next(&mas, end - 1);
> +	} while (vma);
>  out_unlock:
>  	mmap_write_unlock(mm);
>  	mmput(mm);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 33cea484d1ad..e0b2ec2c20f2 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -139,9 +139,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *vma,
>  			       unsigned long start,
>  			       unsigned long end);
>  
> -extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  struct list_head *uf);
> +extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
> +				  unsigned long end, struct list_head *uf);
>  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>  				       struct list_head *uf);
>  
> @@ -222,7 +221,7 @@ static inline bool userfaultfd_remove(struct vm_area_struct *vma,
>  	return true;
>  }
>  
> -static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> +static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
>  					 unsigned long start, unsigned long end,
>  					 struct list_head *uf)
>  {
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79b8494d83c6..dde74e0b195d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2449,7 +2449,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  		 * split, despite we could. This is unlikely enough
>  		 * failure that it's not worth optimizing it for.
>  		 */
> -		int error = userfaultfd_unmap_prep(vma, start, end, uf);
> +		int error = userfaultfd_unmap_prep(mm, start, end, uf);
>  
>  		if (error)
>  			return error;
> @@ -2938,10 +2938,7 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  		goto munmap_full_vma;
>  	}
>  
> -	vma_init(&unmap, mm);
> -	unmap.vm_start = newbrk;
> -	unmap.vm_end = oldbrk;
> -	ret = userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
> +	ret = userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
>  	if (ret)
>  		return ret;
>  	ret = 1;
> @@ -2954,6 +2951,9 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  	}
>  
>  	vma->vm_end = newbrk;
> +	vma_init(&unmap, mm);
> +	unmap.vm_start = newbrk;
> +	unmap.vm_end = oldbrk;
>  	if (vma_mas_remove(&unmap, mas))
>  		goto mas_store_fail;
>  
> @@ -2963,7 +2963,7 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  	}
>  
>  	unmap_pages = vma_pages(&unmap);
> -	if (unmap.vm_flags & VM_LOCKED) {
> +	if (vma->vm_flags & VM_LOCKED) {

Hmm is this an unrelated bug fix? As unmap didn't have any vm_flags set even
before this patch, right?

>  		mm->locked_vm -= unmap_pages;
>  		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
>  	}

