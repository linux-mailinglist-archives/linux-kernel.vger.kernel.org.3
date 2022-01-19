Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B42493F72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356578AbiASR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:59:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37940 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356582AbiASR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:58:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 199681F3BB;
        Wed, 19 Jan 2022 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642615135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sL7bQReqqpYk/4hfvZZT9e2QTJVtMEps9OOT26NGMrc=;
        b=IO7qIfLZHIzaJ9CsSXDuk2w8Dy2e2zb7Cz/0r7d6n188YEixV/Lap7jwpZomeEIeg1rj2m
        47FUugAZOwuxNfORrlVlCwxD/6bEvkpC2WjJeC1cJqMMJx2YFLLb7jwg6Bw4ZtqEzOTtFo
        +G85wAgqEcbxHwPxNZZrhzA/KUgR8SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642615135;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sL7bQReqqpYk/4hfvZZT9e2QTJVtMEps9OOT26NGMrc=;
        b=rRVjbq19U/eqCAFBmmkPBPJSpG5N+V00f94YOp56evcc8NKQMJOP74w3NK4L+VKAw797A0
        xoe+9vX9kL3gjZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD42113E15;
        Wed, 19 Jan 2022 17:58:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n6r0LF5R6GEITwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 17:58:54 +0000
Message-ID: <5dfd4ff3-082f-5621-01b0-cf789eff8835@suse.cz>
Date:   Wed, 19 Jan 2022 18:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 52/66] mm/ksm: Use maple tree iterators instead of vma
 linked list
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
 <20211201142918.921493-53-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-53-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/ksm.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 0662093237e4..d309249c95a4 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -973,11 +973,13 @@ static int unmerge_and_remove_all_rmap_items(void)
>  						struct mm_slot, mm_list);
>  	spin_unlock(&ksm_mmlist_lock);
>  
> -	for (mm_slot = ksm_scan.mm_slot;
> -			mm_slot != &ksm_mm_head; mm_slot = ksm_scan.mm_slot) {
> +	for (mm_slot = ksm_scan.mm_slot; mm_slot != &ksm_mm_head;
> +	     mm_slot = ksm_scan.mm_slot) {
> +		MA_STATE(mas, &mm_slot->mm->mm_mt, 0, 0);

VMA_ITERATOR would be a bit shorter.

> +
>  		mm = mm_slot->mm;
>  		mmap_read_lock(mm);
> -		for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +		mas_for_each(&mas, vma, ULONG_MAX) {
>  			if (ksm_test_exit(mm))
>  				break;
>  			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
> @@ -2226,6 +2228,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  	struct vm_area_struct *vma;
>  	struct rmap_item *rmap_item;
>  	int nid;
> +	MA_STATE(mas, NULL, 0, 0);
>  
>  	if (list_empty(&ksm_mm_head.mm_list))
>  		return NULL;
> @@ -2283,13 +2286,14 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  	}
>  
>  	mm = slot->mm;
> +	mas.tree = &mm->mm_mt;
> +	mas_set(&mas, ksm_scan.address);
> +
>  	mmap_read_lock(mm);
>  	if (ksm_test_exit(mm))
> -		vma = NULL;
> -	else
> -		vma = find_vma(mm, ksm_scan.address);
> +		goto no_vmas;
>  
> -	for (; vma; vma = vma->vm_next) {
> +	mas_for_each(&mas, vma, ULONG_MAX) {
>  		if (!(vma->vm_flags & VM_MERGEABLE))
>  			continue;
>  		if (ksm_scan.address < vma->vm_start)
> @@ -2327,6 +2331,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  	}
>  
>  	if (ksm_test_exit(mm)) {
> +no_vmas:
>  		ksm_scan.address = 0;
>  		ksm_scan.rmap_list = &slot->rmap_list;
>  	}

