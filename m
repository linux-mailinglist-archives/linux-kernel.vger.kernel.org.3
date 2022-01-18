Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5649255E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiARMGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:06:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59048 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiARMGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:06:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 565762170E;
        Tue, 18 Jan 2022 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642507604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2xKgPhezzRuZwYQ+n4efRtt2KvBOTUDARMY7HE84mQ=;
        b=xSZPxN9I4xP8ssF45/LUEbesbGAIzMEz2GAVafLG2gtsMVBLgyclySdRY5DiOxyhTxNsKV
        ipaJ4kBxSY4yaogGK/kfE6QmY55RBTbgninHzGQEC2ehXszDpXrC/MjVnhyhcLga1x34Di
        moVhDDHz+ARXF8H6KcNJhXBpYscTU0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642507604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2xKgPhezzRuZwYQ+n4efRtt2KvBOTUDARMY7HE84mQ=;
        b=yibk3U/hzzDq41kFWWL0X3EGWaztjgPSaO5rT2TEKTecyuE/13IJDyE8BGQuDCZecnzTrb
        Vib+PDgA4MrESkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CF2013B26;
        Tue, 18 Jan 2022 12:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOJXAlSt5mErZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 12:06:44 +0000
Message-ID: <89288cbb-2a54-a35b-785e-2b9f71da604b@suse.cz>
Date:   Tue, 18 Jan 2022 13:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 29/66] parisc: Remove mmap linked list from cache
 handling
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
 <20211201142918.921493-30-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-30-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the VMA iterator instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  arch/parisc/kernel/cache.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> index 94150b91c96f..c3a8d29b6f9f 100644
> --- a/arch/parisc/kernel/cache.c
> +++ b/arch/parisc/kernel/cache.c
> @@ -519,9 +519,11 @@ static inline unsigned long mm_total_size(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long usize = 0;
> +	VMA_ITERATOR(vmi, mm, 0);
>  
> -	for (vma = mm->mmap; vma; vma = vma->vm_next)
> +	for_each_vma(vmi, vma)
>  		usize += vma->vm_end - vma->vm_start;
> +
>  	return usize;
>  }
>  
> @@ -570,6 +572,7 @@ static void flush_user_cache_tlb(struct vm_area_struct *vma,
>  void flush_cache_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
>  
>  	/* Flushing the whole cache on each cpu takes forever on
>  	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
> @@ -583,13 +586,13 @@ void flush_cache_mm(struct mm_struct *mm)
>  
>  	preempt_disable();
>  	if (mm->context == mfsp(3)) {
> -		for (vma = mm->mmap; vma; vma = vma->vm_next)
> +		for_each_vma(vmi, vma)
>  			flush_user_cache_tlb(vma, vma->vm_start, vma->vm_end);
>  		preempt_enable();
>  		return;
>  	}
>  
> -	for (vma = mm->mmap; vma; vma = vma->vm_next)
> +	for_each_vma(vmi, vma)
>  		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
>  	preempt_enable();
>  }

