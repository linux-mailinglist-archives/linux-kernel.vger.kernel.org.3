Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73248DB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiAMPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:53:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45154 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiAMPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:53:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6133E210E5;
        Thu, 13 Jan 2022 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642089223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRyKVn9oAArPiGZTScKS2AmfaUC17G7x1Q0RykZuPpo=;
        b=Ukp2DqCWl3/SXEkw/uChS/4ujylzLogJWIepRPRFXQgQusqf6v+bJUtLIPFSUtDC3IbSxQ
        ug/B8fC603mdw1Qh4Lg+uKY+dxY9Npb7qhn/Qdlh5SrwPnAlHWghsfVJt5cN466gvCAGot
        65yuAzx+neiWb0vkTI/hy3AnjXp4gjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642089223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRyKVn9oAArPiGZTScKS2AmfaUC17G7x1Q0RykZuPpo=;
        b=KmEA4WXIxndfly852MtreifSli0ul5OwzOl41v+il5daQYTk/6+uuZV2wLCxj77sHC46Kh
        bgkpOjXGixBh+uAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22C911330C;
        Thu, 13 Jan 2022 15:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 36C2BwdL4GEfIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Jan 2022 15:53:43 +0000
Message-ID: <252fddef-209a-66b3-31f8-e58024c35b60@suse.cz>
Date:   Thu, 13 Jan 2022 16:53:42 +0100
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
 <20211201142918.921493-23-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 22/66] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
In-Reply-To: <20211201142918.921493-23-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Move find_vma_intersection() to mmap.c and change implementation to
> maple tree.
> 
> When searching for a vma within a range, it is easier to use the maple
> tree interface.  This means the find_vma() call changes to a special
> case of the find_vma_intersection().
> 
> Exported for kvm module.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  include/linux/mm.h | 25 ++++++-------------------
>  mm/mmap.c          | 38 ++++++++++++++++++++++++++++----------
>  2 files changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c08f6d541b8a..39a947f29f6d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2812,26 +2812,13 @@ extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long add
>  extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
>  					     struct vm_area_struct **pprev);
>  
> -/**
> - * find_vma_intersection() - Look up the first VMA which intersects the interval
> - * @mm: The process address space.
> - * @start_addr: The inclusive start user address.
> - * @end_addr: The exclusive end user address.
> - *
> - * Returns: The first VMA within the provided range, %NULL otherwise.  Assumes
> - * start_addr < end_addr.
> +/*
> + * Look up the first VMA which intersects the interval [start_addr, end_addr)
> + * NULL if none.  Assume start_addr < end_addr.
>   */
> -static inline
> -struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
> -					     unsigned long start_addr,
> -					     unsigned long end_addr)
> -{
> -	struct vm_area_struct *vma = find_vma(mm, start_addr);
> -
> -	if (vma && end_addr <= vma->vm_start)
> -		vma = NULL;
> -	return vma;
> -}
> +extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
> +						    unsigned long start_addr,
> +						    unsigned long end_addr);
>  
>  /**
>   * vma_lookup() - Find a VMA at a specific address
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e4c8ce377f2c..c06c5b850e1e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2003,29 +2003,47 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  EXPORT_SYMBOL(get_unmapped_area);
>  
>  /**
> - * find_vma() - Find the VMA for a given address, or the next vma.
> - * @mm: The mm_struct to check
> - * @addr: The address
> + * find_vma_intersection() - Look up the first VMA which intersects the interval
> + * @mm: The process address space.
> + * @start_addr: The inclusive start user address.
> + * @end_addr: The exclusive end user address.
>   *
> - * Returns: The VMA associated with addr, or the next vma.
> - * May return %NULL in the case of no vma at addr or above.
> + * Returns: The first VMA within the provided range, %NULL otherwise.  Assumes
> + * start_addr < end_addr.
>   */
> -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
> +					     unsigned long start_addr,
> +					     unsigned long end_addr)
>  {
>  	struct vm_area_struct *vma;
> -	MA_STATE(mas, &mm->mm_mt, addr, addr);
> +	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
>  
>  	mmap_assert_locked(mm);
>  	/* Check the cache first. */
> -	vma = vmacache_find(mm, addr);
> +	vma = vmacache_find(mm, start_addr);
>  	if (likely(vma))
>  		return vma;
>  
> -	vma = mas_find(&mas, -1);
> +	vma = mas_find(&mas, end_addr - 1);
>  	if (vma)
> -		vmacache_update(addr, vma);
> +		vmacache_update(mas.index, vma);
>  	return vma;
>  }
> +EXPORT_SYMBOL(find_vma_intersection);
> +
> +/**
> + * find_vma() - Find the VMA for a given address, or the next vma.
> + * @mm:  The mm_struct to check
> + * @addr: The address
> + *
> + * Returns: The VMA associated with addr, or the next vma.
> + * May return NULL in the case of no vma at addr or above.
> + */
> +inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)

I think the inline does nothing here (except maybe for LTO builds). Callers
will do a function call to find_vma() and then probably that causes another
function call (likely a tail call) to find_vma_intersection().
You'd have to put this definition of find_vma() to include/linux/mm.h to
make the callers inline it and just add the 0 parameter before doing a
function call of find_vma_intersection() - which would make sense.

> +{
> +	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX

Nit: this comment syntax using //.

> +	return find_vma_intersection(mm, addr, 0);
> +}
>  EXPORT_SYMBOL(find_vma);
>  
>  /**

