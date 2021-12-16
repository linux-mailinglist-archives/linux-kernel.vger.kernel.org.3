Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C48477025
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhLPLZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:25:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44306 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhLPLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:25:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26D7521125;
        Thu, 16 Dec 2021 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639653923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLM4J1Uo3U42MVd/ve0LtaF2cbher6WIDV9t5yc+OTo=;
        b=k1e+6/qwT68sXH/4qc9rBC2PeulnudFKlMor+/Ciap0NO0S2j6Uc1JVNPy3gakGZiTfVIZ
        YvvC6R3Ioih2lv99NW8vA1c/4rnJS4BWQv57zRLCi97JywQ9S+8cLijFGKmtNSdudr8xaE
        7HrCIKlAG4B0vhJ5uhHtez7vJvzuCxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639653923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLM4J1Uo3U42MVd/ve0LtaF2cbher6WIDV9t5yc+OTo=;
        b=MPMo21AOq1BNhw6hy9XdjMknyxjquHpKbja5OpL9rJ4FnD13wtl3dmJxRXPu1IN/V7EZke
        FlT4tM2C7m0x0FCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D135D13B4B;
        Thu, 16 Dec 2021 11:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9AZgMiIiu2HNOAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Dec 2021 11:25:22 +0000
Message-ID: <7c94f5ed-12f9-6afa-bf33-c28849e627ac@suse.cz>
Date:   Thu, 16 Dec 2021 12:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 14/66] proc: Remove VMA rbtree use from nommu
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
 <20211201142918.921493-15-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-15-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> These users of the rbtree should probably have been walks of the
> linked list, but convert them to use walks of the maple tree.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index a6d21fc0033c..2fd06f52b6a4 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -20,15 +20,13 @@
>   */
>  void task_mem(struct seq_file *m, struct mm_struct *mm)
>  {
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>  	struct vm_region *region;
> -	struct rb_node *p;
>  	unsigned long bytes = 0, sbytes = 0, slack = 0, size;
> -        
> -	mmap_read_lock(mm);
> -	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
> -		vma = rb_entry(p, struct vm_area_struct, vm_rb);
>  
> +	mmap_read_lock(mm);
> +	for_each_vma(vmi, vma) {
>  		bytes += kobjsize(vma);
>  
>  		region = vma->vm_region;
> @@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  
>  unsigned long task_vsize(struct mm_struct *mm)
>  {
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
> -	struct rb_node *p;
>  	unsigned long vsize = 0;
>  
>  	mmap_read_lock(mm);
> -	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
> -		vma = rb_entry(p, struct vm_area_struct, vm_rb);
> +	for_each_vma(vmi, vma)
>  		vsize += vma->vm_end - vma->vm_start;
> -	}
>  	mmap_read_unlock(mm);
>  	return vsize;
>  }
> @@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
>  			 unsigned long *shared, unsigned long *text,
>  			 unsigned long *data, unsigned long *resident)
>  {
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>  	struct vm_region *region;
> -	struct rb_node *p;
>  	unsigned long size = kobjsize(mm);
>  
>  	mmap_read_lock(mm);
> -	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
> -		vma = rb_entry(p, struct vm_area_struct, vm_rb);
> +	for_each_vma(vmi, vma) {
>  		size += kobjsize(vma);
>  		region = vma->vm_region;
>  		if (region) {
> @@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
>   */
>  static int show_map(struct seq_file *m, void *_p)
>  {
> -	struct rb_node *p = _p;
> -
> -	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
> +	return nommu_vma_show(m, _p);
>  }
>  
>  static void *m_start(struct seq_file *m, loff_t *pos)
>  {
>  	struct proc_maps_private *priv = m->private;
>  	struct mm_struct *mm;
> -	struct rb_node *p;
> -	loff_t n = *pos;
> +	struct vm_area_struct *vma;
> +	unsigned long addr = *pos;
> +
> +	/* See m_next(). Zero at the start or after lseek. */
> +	if (addr == -1UL)
> +		return NULL;
>  
>  	/* pin the task and mm whilst we play with them */
>  	priv->task = get_proc_task(priv->inode);
> @@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
>  		return ERR_PTR(-EINTR);
>  	}
>  
> -	/* start from the Nth VMA */
> -	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
> -		if (n-- == 0)
> -			return p;
> +	/* start the next element from addr */
> +	vma = find_vma(mm, addr);
> +	if (vma)
> +		return vma;
>  
>  	mmap_read_unlock(mm);
>  	mmput(mm);
> @@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
>  
>  static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
>  {
> -	struct rb_node *p = _p;
> +	struct vm_area_struct *vma = _p;
>  
> -	(*pos)++;
> -	return p ? rb_next(p) : NULL;
> +	*pos = vma->vm_end;
> +	return find_vma(vma->vm_mm, vma->vm_end);
>  }
>  
>  static const struct seq_operations proc_pid_maps_ops = {

