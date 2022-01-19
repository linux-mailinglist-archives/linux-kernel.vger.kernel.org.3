Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC43549393B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354016AbiASLHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:07:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44634 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354027AbiASLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:07:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 717A6212C2;
        Wed, 19 Jan 2022 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642590420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7s1cYTv7Y/FjbTSAc0sveKigpkrprMLr4cF2U4Mu5o=;
        b=eFndhYkYz+ZsKaKD9OjE+wpr5l8Tvx7Nd4SXCxjgMQyNnM1KhYdaROqW7Y1HxcwECR81Rs
        yZvsL166fIpQlit/N7bq73GJBYTWrngqvaodRO6VIKOOLTv9qndPsmlr177FTv+PUWLkmq
        nrIpPJIBslu4Sx5JXDHt8qYmVPeqK2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642590420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7s1cYTv7Y/FjbTSAc0sveKigpkrprMLr4cF2U4Mu5o=;
        b=zqyU8Os9T6/yvUMpjFQPRY52cKXqmS53Cw+PTNr28BCc2AR6Y+CuYWQBFHr57KzEBkqqhK
        5k4/FBmknJrkgcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4EC913B4A;
        Wed, 19 Jan 2022 11:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J4oSN9Pw52EYXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 11:06:59 +0000
Message-ID: <5c67e6b5-8287-1b35-a6f6-b6f117290457@suse.cz>
Date:   Wed, 19 Jan 2022 12:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 40/66] exec: Use VMA iterator instead of linked list
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
 <20211201142918.921493-41-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-41-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Remove a use of the vm_next list by doing the initial lookup with the
> VMA iterator and then using it to find the next entry.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/exec.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index fee18b63ed35..f033745c148a 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -680,6 +680,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  	unsigned long length = old_end - old_start;
>  	unsigned long new_start = old_start - shift;
>  	unsigned long new_end = old_end - shift;
> +	VMA_ITERATOR(vmi, mm, new_start);
> +	struct vm_area_struct *next;
>  	struct mmu_gather tlb;
>  
>  	BUG_ON(new_start > new_end);
> @@ -688,7 +690,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  	 * ensure there are no vmas between where we want to go
>  	 * and where we are
>  	 */
> -	if (vma != find_vma(mm, new_start))
> +	if (vma != vma_next(&vmi))
>  		return -EFAULT;
>  
>  	/*
> @@ -707,12 +709,13 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm);
> +	next = vma_next(&vmi);
>  	if (new_end > old_start) {
>  		/*
>  		 * when the old and new regions overlap clear from new_end.
>  		 */
>  		free_pgd_range(&tlb, new_end, old_end, new_end,
> -			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
> +			next ? next->vm_start : USER_PGTABLES_CEILING);
>  	} else {
>  		/*
>  		 * otherwise, clean from old_start; this is done to not touch
> @@ -721,7 +724,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  		 * for the others its just a little faster.
>  		 */
>  		free_pgd_range(&tlb, old_start, old_end, new_end,
> -			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
> +			next ? next->vm_start : USER_PGTABLES_CEILING);
>  	}
>  	tlb_finish_mmu(&tlb);
>  

