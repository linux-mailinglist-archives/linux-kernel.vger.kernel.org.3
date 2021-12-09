Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD56A46EC53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhLIP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:58:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33744 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbhLIP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:57:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69C74210FF;
        Thu,  9 Dec 2021 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639065264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AirTl4zzb+ByVFQqyjWDo2/YusdyzMaM/JV9rnLAGhg=;
        b=ZmP+VnU+b1W746U8flhMFpjdkMRwi9alKI2iVvMT2FowgOicY90ed0irLm+PGcqpTOC4vy
        b1HPOF2bJIetNz8ZmIIUbeNugWcQCRujlYrbV7VP6YPpMTu5QHxgnNtgeGtrmmhSjFyRtm
        UBBHWcWtCYBtugvb/WmwEhKNNqp4Kqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639065264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AirTl4zzb+ByVFQqyjWDo2/YusdyzMaM/JV9rnLAGhg=;
        b=MkkCrAJNyfx8FI+8r16J08CYAGBJsJsWZJ8pXT+nSAB9qMRShj/SDFoyA7n9WALRP07hwC
        D7ROczCSAO4e6PCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E4A313343;
        Thu,  9 Dec 2021 15:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eF2YBrAmsmHCUAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Dec 2021 15:54:24 +0000
Message-ID: <ffbb5843-4c5a-99c1-12a6-2ff3ae818e3c@suse.cz>
Date:   Thu, 9 Dec 2021 16:54:23 +0100
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
 <20211201142918.921493-9-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 08/66] mmap: Use the VMA iterator in
 count_vma_pages_range()
In-Reply-To: <20211201142918.921493-9-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This simplifies the implementation and is faster than using the linked
> list.

You mean faster because more cache friendly?
OTOH you do max(addr, vma->vm_start) which wasn't the case.

I doubt it matters though and yeah it's much simpler...

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>

Btw, no signed-off-by Liam?

I now also notice some other patches (e.g. patch 4) have From: and s-o-b by
Liam followed by Matthew, despite it's Liam sending them. I guess that's
less of an issue than the missing one.

Anyway something for you to check and make consistent in the whole series, I
won't point it out individually.

> ---
>  mm/mmap.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9fee6e6b276f..de78fc0ce809 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -669,29 +669,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
>  
>  	return 0;
>  }
> +
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
>  		unsigned long addr, unsigned long end)
>  {
> -	unsigned long nr_pages = 0;
> +	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
> +	unsigned long nr_pages = 0;
>  
> -	/* Find first overlapping mapping */
> -	vma = find_vma_intersection(mm, addr, end);
> -	if (!vma)
> -		return 0;
> -
> -	nr_pages = (min(end, vma->vm_end) -
> -		max(addr, vma->vm_start)) >> PAGE_SHIFT;
> -
> -	/* Iterate over the rest of the overlaps */
> -	for (vma = vma->vm_next; vma; vma = vma->vm_next) {
> -		unsigned long overlap_len;
> -
> -		if (vma->vm_start > end)
> -			break;
> +	for_each_vma_range(vmi, vma, end) {
> +		unsigned long vm_start = max(addr, vma->vm_start);
> +		unsigned long vm_end = min(end, vma->vm_end);
>  
> -		overlap_len = min(end, vma->vm_end) - vma->vm_start;
> -		nr_pages += overlap_len >> PAGE_SHIFT;
> +		nr_pages += (vm_end - vm_start) / PAGE_SIZE;
>  	}
>  
>  	return nr_pages;

