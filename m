Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E9493E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356236AbiASQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:47:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57342 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiASQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:47:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC9F01F3BC;
        Wed, 19 Jan 2022 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642610847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjJ3ktaNdYSegyHdKVMGnjgtmvKLsfVFGp2ETAO7WAo=;
        b=C3heU29HxtNr5BHLL9mQ2eUgu7bn1m60AhS2BPlfw4iGhItpUyMlWa99/U73lbJmxsEi0X
        cy/oLEMQchZ4t4umRq7oamJBl85zZs06K0XD9Hs7f6pfZbTNEFaiCBjeuM655ngC2UOxad
        ZuCAruENiJ9GD2cpC8LUuY/+XL8SPYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642610847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjJ3ktaNdYSegyHdKVMGnjgtmvKLsfVFGp2ETAO7WAo=;
        b=mQ5yOIpSiWXqQ1B7dva0lqZDD7B/EtUKVlgnCp0qq0DBkkDQ9IBUaUqLUmUwN48zSSPEQi
        hhz/zbdy+VTQM0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67BDB13B77;
        Wed, 19 Jan 2022 16:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wv45GJ9A6GGeLQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 16:47:27 +0000
Message-ID: <fee66042-29d1-15b3-ff99-f234d4537dba@suse.cz>
Date:   Wed, 19 Jan 2022 17:47:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 46/66] perf: Use VMA iterator
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
 <20211201142918.921493-47-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-47-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The VMA iterator is faster than the linked list and removing the linked
> list will shrink the vm_area_struct.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  kernel/events/core.c    | 3 ++-
>  kernel/events/uprobes.c | 9 ++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 523106a506ee..d839ba79fe5c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10218,8 +10218,9 @@ static void perf_addr_filter_apply(struct perf_addr_filter *filter,
>  				   struct perf_addr_filter_range *fr)
>  {
>  	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
>  
> -	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +	for_each_vma(vmi, vma) {
>  		if (!vma->vm_file)
>  			continue;
>  
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 6357c3580d07..5dee6c41f36d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -356,9 +356,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
>  static struct vm_area_struct *
>  find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
>  {
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *tmp;
>  
> -	for (tmp = mm->mmap; tmp; tmp = tmp->vm_next)
> +	for_each_vma(vmi, tmp)
>  		if (valid_ref_ctr_vma(uprobe, tmp))
>  			return tmp;
>  
> @@ -1237,11 +1238,12 @@ int uprobe_apply(struct inode *inode, loff_t offset,
>  
>  static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  {
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>  	int err = 0;
>  
>  	mmap_read_lock(mm);
> -	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +	for_each_vma(vmi, vma) {
>  		unsigned long vaddr;
>  		loff_t offset;
>  
> @@ -1989,9 +1991,10 @@ bool uprobe_deny_signal(void)
>  
>  static void mmf_recalc_uprobes(struct mm_struct *mm)
>  {
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>  
> -	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +	for_each_vma(vmi, vma) {
>  		if (!valid_vma(vma, false))
>  			continue;
>  		/*

