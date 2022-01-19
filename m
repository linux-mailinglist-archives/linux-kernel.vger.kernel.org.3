Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5788493E93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356229AbiASQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:49:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57826 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356170AbiASQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:49:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3E441F3A8;
        Wed, 19 Jan 2022 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642610995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyHLINDUQ4p2y/yWxMmsPLf/SDRFaxvEY50CdZCSCAo=;
        b=HgKhSItFK+7qVaAWcHB1Pqtrbi7X9C5aSs8zeHcGH4nrShattVgbbUJkxCX4seNIYtFtBF
        APm9WVcYO/rxGZ6LELfGI3eMY55KFNx1fRIQBMJlyAkZl+hLavMDPi3hdtXLTw/Wc/v3l0
        Tm9vQpVcJv8F+4wpDYgmJVFwl4jufvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642610995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyHLINDUQ4p2y/yWxMmsPLf/SDRFaxvEY50CdZCSCAo=;
        b=rBs4LAEl5PYjRPK4HOPx59oD3ebulig9ISiwAY7pY4ywLF6mOV9mfp2KVmydW7v1Zv0F/z
        UD39kX5wZ6AKxQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0A1A13B77;
        Wed, 19 Jan 2022 16:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /jp1KjJB6GHtLgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 16:49:54 +0000
Message-ID: <ae9da909-0d21-c2aa-fc69-764ebba29672@suse.cz>
Date:   Wed, 19 Jan 2022 17:49:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 47/66] sched: Use maple tree iterator to walk VMAs
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
 <20211201142918.921493-48-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-48-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The linked list is slower than walking the VMAs using the maple tree.
> We can't use the VMA iterator here because it doesn't support
> moving to an earlier position.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  kernel/sched/fair.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6d9435..39bb4a6c8507 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2672,6 +2672,7 @@ static void task_numa_work(struct callback_head *work)
>  	struct task_struct *p = current;
>  	struct mm_struct *mm = p->mm;
>  	u64 runtime = p->se.sum_exec_runtime;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  	struct vm_area_struct *vma;
>  	unsigned long start, end;
>  	unsigned long nr_pte_updates = 0;
> @@ -2728,13 +2729,16 @@ static void task_numa_work(struct callback_head *work)
>  
>  	if (!mmap_read_trylock(mm))
>  		return;
> -	vma = find_vma(mm, start);
> +	mas_set(&mas, start);
> +	vma = mas_find(&mas, ULONG_MAX);
>  	if (!vma) {
>  		reset_ptenuma_scan(p);
>  		start = 0;
> -		vma = mm->mmap;
> +		mas_set(&mas, start);
> +		vma = mas_find(&mas, ULONG_MAX);
>  	}
> -	for (; vma; vma = vma->vm_next) {
> +
> +	for (; vma; vma = mas_find(&mas, ULONG_MAX)) {
>  		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
>  			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
>  			continue;

