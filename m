Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1775B493F56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356507AbiASRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:48:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37186 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356525AbiASRsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:48:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DE451F3C0;
        Wed, 19 Jan 2022 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642614510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rja0rd1IUylof69oFT2eERzDlpMcUeihM+dvReC85pw=;
        b=AR+ECaI9bU5lZlO/2/M6SbhaeDsdJdwFrikCyjbZSsU9QyCuP2enGfUaU9I9YXfoQAsOHl
        lXox5/Qful2IiLo8OvH0XKtKCfd2rSFDDcN0qewE9N/5+NenxF/L36qqU913eoCeMaqBjU
        3un2Bz4aFPlEaeO49mwS3i6u/SMhDYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642614510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rja0rd1IUylof69oFT2eERzDlpMcUeihM+dvReC85pw=;
        b=zlHTiNkoibAlygfENeY3giyX8P5HUH78MyMn9COLEv7Py3wKtMDjRnjM/7SbmJsCoLkNlm
        NgpMRnPZcflCSbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C501913E15;
        Wed, 19 Jan 2022 17:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EArILe1O6GGTSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 17:48:29 +0000
Message-ID: <e331709e-e650-d28c-e86a-11e188cef1bd@suse.cz>
Date:   Wed, 19 Jan 2022 18:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 51/66] mm/khugepaged: Use maple tree iterators instead
 of vma linked list
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
 <20211201142918.921493-52-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-52-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Ah, got tired of copy/pasting for a number of patches, I see :)

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/huge_memory.c | 4 ++--
>  mm/khugepaged.c  | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e5483347291c..f0f4ff5239ef 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2270,11 +2270,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>  	split_huge_pmd_if_needed(vma, end);
>  
>  	/*
> -	 * If we're also updating the vma->vm_next->vm_start,
> +	 * If we're also updating the vma_next(vma)->vm_start,

vma_next() takes an iterator, not vma, though.

>  	 * check if we need to split it.
>  	 */
>  	if (adjust_next > 0) {
> -		struct vm_area_struct *next = vma->vm_next;
> +		struct vm_area_struct *next = find_vma(vma->vm_mm, vma->vm_end);
>  		unsigned long nstart = next->vm_start;
>  		nstart += adjust_next;
>  		split_huge_pmd_if_needed(next, nstart);
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0ff7d72cdd1d..8f0633481791 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2083,6 +2083,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  	struct mm_struct *mm;
>  	struct vm_area_struct *vma;
>  	int progress = 0;
> +	unsigned long address;
>  
>  	VM_BUG_ON(!pages);
>  	lockdep_assert_held(&khugepaged_mm_lock);
> @@ -2106,11 +2107,13 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  	vma = NULL;
>  	if (unlikely(!mmap_read_trylock(mm)))
>  		goto breakouterloop_mmap_lock;
> -	if (likely(!khugepaged_test_exit(mm)))
> -		vma = find_vma(mm, khugepaged_scan.address);
>  
>  	progress++;
> -	for (; vma; vma = vma->vm_next) {
> +	if (unlikely(khugepaged_test_exit(mm)))
> +		goto breakouterloop;
> +
> +	address = khugepaged_scan.address;
> +	mt_for_each(&mm->mm_mt, vma, address, ULONG_MAX) {

Why not via mas_for_each()?

>  		unsigned long hstart, hend;
>  
>  		cond_resched();

