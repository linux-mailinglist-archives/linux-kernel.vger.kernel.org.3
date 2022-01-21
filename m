Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFEA495EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbiAULxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:53:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350256AbiAULwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:52:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 108DB21903;
        Fri, 21 Jan 2022 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642765956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBXYu0zC/5+9Wg4YYivV6m77G7G9QKmuit4G7sanKSE=;
        b=KLc0XHkx9EqTs4kCrlI0TU07W64814HLt66b84p1g+obYAm1w+t66/ih36r3gGiwxqaRa8
        G0R6V9AG9EuHM1mwwBsbiBtdkRDytUa1IXbBFX1Vh2XqoqrSU/bF7zev8AeDUnr2MAbPe7
        LYYV/e4X+YZ1XjWmk49CfM/zz463VCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642765956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBXYu0zC/5+9Wg4YYivV6m77G7G9QKmuit4G7sanKSE=;
        b=+Um68hYOTnHvJ3rtfcNf0PLKuEmDuoSVtWx7Ay56RjwHZKs6+2ZcT3xmeLvCaSmkKUu5Nf
        o5RA0u3R1OrX+8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B528913B9C;
        Fri, 21 Jan 2022 11:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CG54K4Oe6mHzGgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 21 Jan 2022 11:52:35 +0000
Message-ID: <e7c8e1c8-af65-f771-d7ea-4703b1e39fe3@suse.cz>
Date:   Fri, 21 Jan 2022 12:52:35 +0100
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
 <20211201142918.921493-43-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 42/66] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
In-Reply-To: <20211201142918.921493-43-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Remove references to mm_struct linked list and highest_vm_end for when
> they are removed
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  fs/proc/internal.h |  2 +-
>  fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
>  2 files changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 03415f3fb3a8..45b132c609ff 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -290,7 +290,7 @@ struct proc_maps_private {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  #ifdef CONFIG_MMU
> -	struct vm_area_struct *tail_vma;
> +	struct vma_iterator iter;
>  #endif
>  #ifdef CONFIG_NUMA
>  	struct mempolicy *task_mempolicy;
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 300911d6575f..7cc97cdb88c2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -122,12 +122,26 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
>  }
>  #endif
>  
> +static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
> +						loff_t *ppos)
> +{
> +	struct vm_area_struct *vma = vma_next(&priv->iter);

This advances the iterator.

> +
> +	if (vma) {
> +		*ppos = vma->vm_start;

This advances *ppos.

> +	} else {
> +		*ppos = -2UL;
> +		vma = get_gate_vma(priv->mm);
> +	}
> +
> +	return vma;
> +}
> +
>  static void *m_start(struct seq_file *m, loff_t *ppos)
>  {
>  	struct proc_maps_private *priv = m->private;
>  	unsigned long last_addr = *ppos;
>  	struct mm_struct *mm;
> -	struct vm_area_struct *vma;
>  
>  	/* See m_next(). Zero at the start or after lseek. */
>  	if (last_addr == -1UL)
> @@ -151,31 +165,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  		return ERR_PTR(-EINTR);
>  	}
>  
> +	vma_iter_init(&priv->iter, mm, last_addr);
>  	hold_task_mempolicy(priv);
> -	priv->tail_vma = get_gate_vma(mm);
> -
> -	vma = find_vma(mm, last_addr);
> -	if (vma)
> -		return vma;
> +	if (last_addr == -2UL)
> +		return get_gate_vma(mm);
>  
> -	return priv->tail_vma;
> +	return proc_get_vma(priv, ppos);

So here we advance those as part of m_start(), which I think is wrong in the
seqfile API. See seq_read_iter() in fs/seq_file.c how it handles a full
buffer, around the comment "// need a bigger buffer" it will do a stop() and
start() again and that's supposed to get the same vma.
seqfile is tricky, part #220121

>  }
>  
>  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
>  {
> -	struct proc_maps_private *priv = m->private;
> -	struct vm_area_struct *next, *vma = v;
> -
> -	if (vma == priv->tail_vma)
> -		next = NULL;
> -	else if (vma->vm_next)
> -		next = vma->vm_next;
> -	else
> -		next = priv->tail_vma;
> -
> -	*ppos = next ? next->vm_start : -1UL;
> -
> -	return next;
> +	if (*ppos == -2UL) {
> +		*ppos = -1UL;
> +		return NULL;
> +	}
> +	return proc_get_vma(m->private, ppos);
>  }
>  
>  static void m_stop(struct seq_file *m, void *v)
> @@ -843,16 +847,16 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  {
>  	struct proc_maps_private *priv = m->private;
>  	struct mem_size_stats mss;
> -	struct mm_struct *mm;
> +	struct mm_struct *mm = priv->mm;
>  	struct vm_area_struct *vma;
> -	unsigned long last_vma_end = 0;
> +	unsigned long vma_start = 0, last_vma_end = 0;
>  	int ret = 0;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  
>  	priv->task = get_proc_task(priv->inode);
>  	if (!priv->task)
>  		return -ESRCH;
>  
> -	mm = priv->mm;
>  	if (!mm || !mmget_not_zero(mm)) {
>  		ret = -ESRCH;
>  		goto out_put_task;
> @@ -865,8 +869,13 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  		goto out_put_mm;
>  
>  	hold_task_mempolicy(priv);
> +	vma = mas_find(&mas, 0);
> +
> +	if (unlikely(!vma))
> +		goto empty_set;
>  
> -	for (vma = priv->mm->mmap; vma;) {
> +	vma_start = vma->vm_start;
> +	do {
>  		smap_gather_stats(vma, &mss, 0);
>  		last_vma_end = vma->vm_end;
>  
> @@ -875,6 +884,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  		 * access it for write request.
>  		 */
>  		if (mmap_lock_is_contended(mm)) {
> +			mas_pause(&mas);
>  			mmap_read_unlock(mm);
>  			ret = mmap_read_lock_killable(mm);
>  			if (ret) {
> @@ -918,7 +928,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  			 *    contains last_vma_end.
>  			 *    Iterate VMA' from last_vma_end.
>  			 */
> -			vma = find_vma(mm, last_vma_end - 1);
> +			vma = mas_find(&mas, ULONG_MAX);
>  			/* Case 3 above */
>  			if (!vma)
>  				break;
> @@ -932,11 +942,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  				smap_gather_stats(vma, &mss, last_vma_end);
>  		}
>  		/* Case 2 above */
> -		vma = vma->vm_next;
> -	}
> +	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
>  
> -	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
> -			       last_vma_end, 0, 0, 0, 0);
> +empty_set:
> +	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
>  	seq_pad(m, ' ');
>  	seq_puts(m, "[rollup]\n");
>  
> @@ -1229,6 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  		return -ESRCH;
>  	mm = get_task_mm(task);
>  	if (mm) {
> +		MA_STATE(mas, &mm->mm_mt, 0, 0);
>  		struct mmu_notifier_range range;
>  		struct clear_refs_private cp = {
>  			.type = type,
> @@ -1248,7 +1258,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  		}
>  
>  		if (type == CLEAR_REFS_SOFT_DIRTY) {
> -			for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +			mas_for_each(&mas, vma, ULONG_MAX) {
>  				if (!(vma->vm_flags & VM_SOFTDIRTY))
>  					continue;
>  				vma->vm_flags &= ~VM_SOFTDIRTY;
> @@ -1260,8 +1270,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  						0, NULL, mm, 0, -1UL);
>  			mmu_notifier_invalidate_range_start(&range);
>  		}
> -		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
> -				&cp);
> +		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
>  		if (type == CLEAR_REFS_SOFT_DIRTY) {
>  			mmu_notifier_invalidate_range_end(&range);
>  			flush_tlb_mm(mm);

