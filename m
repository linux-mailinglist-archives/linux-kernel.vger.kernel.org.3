Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5983A494DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiATMQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:16:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiATMQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:16:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FF182170E;
        Thu, 20 Jan 2022 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642680980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxjCyPB/TvQhq50NprkltYrk8TlOycec4dlTnsG9qZA=;
        b=3bjfKDfvTfOlzkQJwrpwAEUvihELw0gZRTvUB6I23XJKhAXD4mvd2hiDua9ewpcYwTtWM9
        o6rQhsWN0rywimL7gzTiM/GXxKsTXtol0nZbtRx1vNmqt3PcWG2DMUb2en7KPGaQzISEAo
        F4phEP5uKwWJDD7XmYcJGwCUEJGS2OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642680980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxjCyPB/TvQhq50NprkltYrk8TlOycec4dlTnsG9qZA=;
        b=j5evB57e9KE/c3hUml0HBRtDbIzfe9UP68bVpR78IE9oBWnAmEBSXbC+AML0tYWh9Dc5Jj
        p30R0xWifY46M+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9909413B51;
        Thu, 20 Jan 2022 12:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G9aoJJNS6WGlWQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 12:16:19 +0000
Message-ID: <75a30665-9884-ac6d-c526-e7deb1e4e879@suse.cz>
Date:   Thu, 20 Jan 2022 13:16:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
 <20211201142918.921493-57-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 56/66] mm/mlock: Use maple tree iterators instead of
 vma linked list
In-Reply-To: <20211201142918.921493-57-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mlock.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index e263d62ae2d0..feb691eb4c64 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -563,6 +563,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  	unsigned long nstart, end, tmp;
>  	struct vm_area_struct *vma, *prev;
>  	int error;
> +	MA_STATE(mas, &current->mm->mm_mt, start, start);
>  
>  	VM_BUG_ON(offset_in_page(start));
>  	VM_BUG_ON(len != PAGE_ALIGN(len));
> @@ -571,11 +572,11 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  		return -EINVAL;
>  	if (end == start)
>  		return 0;
> -	vma = find_vma(current->mm, start);
> -	if (!vma || vma->vm_start > start)
> +	vma = mas_walk(&mas);
> +	if (!vma)
>  		return -ENOMEM;
>  
> -	prev = vma->vm_prev;
> +	prev = mas_prev(&mas, 0);

Could be only done as an 'else' of the 'if' below?

>  	if (start > vma->vm_start)
>  		prev = vma;
>  
> @@ -597,7 +598,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>  		if (nstart >= end)
>  			break;
>  
> -		vma = prev->vm_next;
> +		vma = find_vma(prev->vm_mm, prev->vm_end);
>  		if (!vma || vma->vm_start != nstart) {
>  			error = -ENOMEM;
>  			break;
> @@ -618,15 +619,12 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long count = 0;
> +	MA_STATE(mas, &mm->mm_mt, start, start);
>  
>  	if (mm == NULL)
>  		mm = current->mm;
>  
> -	vma = find_vma(mm, start);
> -	if (vma == NULL)
> -		return 0;
> -
> -	for (; vma ; vma = vma->vm_next) {
> +	mas_for_each(&mas, vma, start + len) {

Could be for_each_vma_range()?

>  		if (start >= vma->vm_end)
>  			continue;

Unnecessary? (even before this patch, I think?)

>  		if (start + len <=  vma->vm_start)

Unnecessary after your patch?

> @@ -741,6 +739,7 @@ static int apply_mlockall_flags(int flags)
>  {
>  	struct vm_area_struct *vma, *prev = NULL;
>  	vm_flags_t to_add = 0;
> +	unsigned long addr = 0;
>  
>  	current->mm->def_flags &= VM_LOCKED_CLEAR_MASK;
>  	if (flags & MCL_FUTURE) {
> @@ -759,7 +758,7 @@ static int apply_mlockall_flags(int flags)
>  			to_add |= VM_LOCKONFAULT;
>  	}
>  
> -	for (vma = current->mm->mmap; vma ; vma = prev->vm_next) {
> +	mt_for_each(&current->mm->mm_mt, vma, addr, ULONG_MAX) {
>  		vm_flags_t newflags;
>  
>  		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;

