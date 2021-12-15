Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2E47594D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbhLONFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:05:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33944 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhLONFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:05:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E48E5210F9;
        Wed, 15 Dec 2021 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639573518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WZ7nRsuN4bYhjGYGsm47Qu2gogklXkj+EKNuYHnkws=;
        b=J6B0+a9DJfkCACkP88ddk6JSJuUUhF4fjAFg/nt20Jpuui4FmUV5I/u/yWoeg6/9p2s4Zr
        xIRxFB7bMTqhcLh7eQcVfPhXp+9BszglpQ+5XYkz1bNCBmsukPntv9x7caQ7Po3rSVha8j
        U/PC4611ge1+exTk9d5SSGczCSqfrX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639573518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WZ7nRsuN4bYhjGYGsm47Qu2gogklXkj+EKNuYHnkws=;
        b=L6SCc7mRFgXJJTauzA/J5DTKgZH14kayFsjdNpeqwqXV1dlXv2wFx3EikV+GLrP2Rgr43O
        g42EpK2umnd7BpAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1E4E1330B;
        Wed, 15 Dec 2021 13:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fznBJg7ouWFiQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Dec 2021 13:05:18 +0000
Message-ID: <4207b5a3-efac-40f3-6b42-6713c9283cdd@suse.cz>
Date:   Wed, 15 Dec 2021 14:05:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
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
 <20211201142918.921493-10-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 09/66] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
In-Reply-To: <20211201142918.921493-10-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Using the maple tree interface mt_find() will handle the RCU locking and
> will start searching at the address up to the limit, ULONG_MAX in this
> case.
> 
> Add kernel documentation to this API.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Note below:

> ---
>  mm/mmap.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index de78fc0ce809..6a7502f74190 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2429,10 +2429,16 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  
>  EXPORT_SYMBOL(get_unmapped_area);
>  
> -/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> +/**
> + * find_vma() - Find the VMA for a given address, or the next vma.
> + * @mm: The mm_struct to check
> + * @addr: The address
> + *
> + * Returns: The VMA associated with addr, or the next vma.
> + * May return %NULL in the case of no vma at addr or above.
> + */
>  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {
> -	struct rb_node *rb_node;
>  	struct vm_area_struct *vma;
>  
>  	mmap_assert_locked(mm);
> @@ -2441,22 +2447,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  	if (likely(vma))
>  		return vma;
>  
> -	rb_node = mm->mm_rb.rb_node;
> -
> -	while (rb_node) {
> -		struct vm_area_struct *tmp;
> -
> -		tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
> -
> -		if (tmp->vm_end > addr) {
> -			vma = tmp;
> -			if (tmp->vm_start <= addr)
> -				break;
> -			rb_node = rb_node->rb_left;
> -		} else
> -			rb_node = rb_node->rb_right;
> -	}
> -
> +	vma = mt_find(&mm->mm_mt, &addr, ULONG_MAX);

This updates addr to the end of vma->vm_end.

>  	if (vma)
>  		vmacache_update(addr, vma);

And here vmacache is updated with the updated addr, which wasn't done
before. This AFAIU has two consequences:

- the original addr will not be cached, so this whole vma lookup will not be
cached and will always resort to maple tree search. Possibly affecting any
measurements you made. Especially the vmacache removal later in the series
might now look like it makes not much of a performance difference - but
vmcache is effectively dysfunctional.

- the future lookup of address vma->vm_end will return this vma, although
the address doesn't belong to it. Wouldn't be surprised if this caused
infrequent mysterious bugs?

Both will resolve with vmacache removal later, but better still fix this.

Vlastimil

>  	return vma;

