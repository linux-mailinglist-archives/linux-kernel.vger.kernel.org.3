Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498BE475DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbhLOQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:40:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhLOQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:40:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3843A212BD;
        Wed, 15 Dec 2021 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639586406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PR/MemBldbTR728L096igmJMG3fo/uDTHlayL6mBYe4=;
        b=GQBBxdmBohS+o4ZBWp2/gqq4lzHNiZVSy1JPMq7MDWlpGnyALVbQFCf6utnQfj5mKLSQRA
        v/GHxV0ypGS2TAVlVA+VGjN0iSqtbbhAqWNetEInSPhdzxk6Wg6KAjHs7wCNCx2ILVT7QP
        sHkFEQZFJUayuDJ9mKcV/vyROUFBYSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639586406;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PR/MemBldbTR728L096igmJMG3fo/uDTHlayL6mBYe4=;
        b=nUwFhiF2wk6jrKHkh37AqVjYosXXTLnHXPQxO8djKhM2ieN2aTJtfUGmu/9CqIa2u0izfo
        xALB7V3InBlRjQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD51913B75;
        Wed, 15 Dec 2021 16:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vj1KNWUaumGdJgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Dec 2021 16:40:05 +0000
Message-ID: <92ef4cae-ccfb-d952-6b36-71036329e8da@suse.cz>
Date:   Wed, 15 Dec 2021 17:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 10/66] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
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
 <20211201142918.921493-11-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-11-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the maple tree's advanced API and a maple state to walk the tree
> for the entry at the address of the next vma, then use the maple state
> to walk back one entry to find the previous entry.
> 
> Add kernel documentation comments for this API.

Additional note: the previous patch for find_vma() mentioned "Using the
maple tree interface mt_find() will handle the RCU locking" while
find_vma_prev() uses the advanced maple tree API, thus IIUC without RCU
locking, and doesn't add its own. This can easily result in a bug,
especially if the documentation comments don't mention it at all?

> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/mmap.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6a7502f74190..8425ab573770 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2454,23 +2454,27 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  }
>  EXPORT_SYMBOL(find_vma);
>  
> -/*
> - * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
> +/**
> + * find_vma_prev() - Find the VMA for a given address, or the next vma and
> + * set %pprev to the previous VMA, if any.
> + * @mm: The mm_struct to check
> + * @addr: The address
> + * @pprev: The pointer to set to the previous VMA
> + *
> + * Returns: The VMA associated with @addr, or the next vma.
> + * May return %NULL in the case of no vma at addr or above.
>   */
>  struct vm_area_struct *
>  find_vma_prev(struct mm_struct *mm, unsigned long addr,
>  			struct vm_area_struct **pprev)
>  {
>  	struct vm_area_struct *vma;
> +	MA_STATE(mas, &mm->mm_mt, addr, addr);
>  
> -	vma = find_vma(mm, addr);
> -	if (vma) {
> -		*pprev = vma->vm_prev;
> -	} else {
> -		struct rb_node *rb_node = rb_last(&mm->mm_rb);
> -
> -		*pprev = rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : NULL;
> -	}
> +	vma = mas_walk(&mas);
> +	*pprev = mas_prev(&mas, 0);
> +	if (!vma)
> +		vma = mas_next(&mas, ULONG_MAX);
>  	return vma;
>  }
>  

