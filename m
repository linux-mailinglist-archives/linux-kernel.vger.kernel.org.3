Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4198E495D11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379780AbiAUJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:51:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37786 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAUJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:51:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B88871F884;
        Fri, 21 Jan 2022 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642758698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3TztOpgm9Ikx4CBHMNKVa/URwQROwDVM4fT1vsEWy4=;
        b=cv21lt9V0GrwOrelsUFMtw8ww5SpxhlR24oDMyT9nW+U4PfJcDriS6CYYG+SqSd30/9Bx1
        DsFzF1Nt0yUOU2hThmwdy8tpZOLKpe9wN4oDF1o1pSF8JnXya6pwNjX36Cfywh0+b6bl6w
        IvwaZwBZ9QuNZQDlMmkw1F/B5XF3ApY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642758698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3TztOpgm9Ikx4CBHMNKVa/URwQROwDVM4fT1vsEWy4=;
        b=qUaAkqA90fUI2q2AVp/A1EHSLwKU7zcbgSLuG880aUtdKe0NkHEdpF8xjIfnzGxXMpe5Ki
        vzlVpVoe6+W5SVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 762D913C32;
        Fri, 21 Jan 2022 09:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5dzIGyqC6mENXQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 21 Jan 2022 09:51:38 +0000
Message-ID: <dd3c0c6a-41d5-ffdb-f361-13fcd7982b6a@suse.cz>
Date:   Fri, 21 Jan 2022 10:51:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 66/66] mm/mmap: Drop range_has_overlap() function
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
 <20211201142918.921493-67-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-67-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Since there is no longer a linked list, the range_has_overlap() function
> is identical to the find_vma_intersection() function.  There is only one
> place that actually needs the previous vma, so just use vma_prev() in
> that one case.

I guess that was written before some further changes and now it's removing
just one user that doesn't care about pprev.

> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 28 +---------------------------
>  1 file changed, 1 insertion(+), 27 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e13c6ef76697..4dfe2f92796e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -420,30 +420,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
>  }
>  
> -/*
> - * range_has_overlap() - Check the @start - @end range for overlapping VMAs and
> - * sets up a pointer to the previous VMA
> - * @mm: the mm struct
> - * @start: the start address of the range
> - * @end: the end address of the range
> - * @pprev: the pointer to the pointer of the previous VMA
> - *
> - * Returns: True if there is an overlapping VMA, false otherwise
> - */
> -static inline
> -bool range_has_overlap(struct mm_struct *mm, unsigned long start,
> -		       unsigned long end, struct vm_area_struct **pprev)
> -{
> -	struct vm_area_struct *existing;
> -
> -	MA_STATE(mas, &mm->mm_mt, start, start);
> -	rcu_read_lock();
> -	existing = mas_find(&mas, end - 1);
> -	*pprev = mas_prev(&mas, 0);
> -	rcu_read_unlock();
> -	return existing ? true : false;
> -}
> -
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
>  		unsigned long addr, unsigned long end)
>  {
> @@ -3188,9 +3164,7 @@ void exit_mmap(struct mm_struct *mm)
>   */
>  int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
> -	struct vm_area_struct *prev;
> -
> -	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
> +	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
>  		return -ENOMEM;
>  
>  	if ((vma->vm_flags & VM_ACCOUNT) &&

