Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF54493E80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356205AbiASQoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:44:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiASQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:44:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B4EA11F3BB;
        Wed, 19 Jan 2022 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642610645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62htdXmuMFNEQJ8vfgdgjTijsz/yNwUjsbcznRAfNGE=;
        b=BbO4tRYv/W2B/11dNg8QuPUJ5WXvn4xjjPn5NONSmQ43/G3Hxi/R45rCDYD+mFKcWE21eT
        6vkJtirYbGR+zJXS+QYJoBtjyyACBHsvLWnBNdI4xJn3LZflfF7GZqn37WKgO2aK5MNiXq
        neA93CtcJUHsUrS939/CkTnYBn2guKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642610645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62htdXmuMFNEQJ8vfgdgjTijsz/yNwUjsbcznRAfNGE=;
        b=7okzYG4dJkDQ97l1plmo3lRXKCAmuOr6MEI1veXvfQ15VhO7+iBZnttzebdr1NM2DO0p3W
        hHNTV1ed7mlvYXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 641B913B77;
        Wed, 19 Jan 2022 16:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WblJF9U/6GEDLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 16:44:05 +0000
Message-ID: <8d0e528e-7777-9333-d0dc-b49ce9a746e0@suse.cz>
Date:   Wed, 19 Jan 2022 17:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 45/66] acct: Use VMA iterator instead of linked list
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
 <20211201142918.921493-46-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-46-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The VMA iterator is faster than the linked list.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  kernel/acct.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 3df53cf1dcd5..2e7bf8d41f04 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -535,15 +535,14 @@ void acct_collect(long exitcode, int group_dead)
>  	unsigned long vsize = 0;
>  
>  	if (group_dead && current->mm) {
> +		struct mm_struct *mm = current->mm;
> +		VMA_ITERATOR(vmi, mm, 0);
>  		struct vm_area_struct *vma;
>  
> -		mmap_read_lock(current->mm);
> -		vma = current->mm->mmap;
> -		while (vma) {
> +		mmap_read_lock(mm);
> +		for_each_vma(vmi, vma)
>  			vsize += vma->vm_end - vma->vm_start;
> -			vma = vma->vm_next;
> -		}
> -		mmap_read_unlock(current->mm);
> +		mmap_read_unlock(mm);
>  	}
>  
>  	spin_lock_irq(&current->sighand->siglock);

