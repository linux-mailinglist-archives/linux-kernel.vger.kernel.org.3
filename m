Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAD5492548
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiARL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:57:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58112 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiARL5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:57:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF6012113B;
        Tue, 18 Jan 2022 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642507061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdOIwExMHXqbtbeyqn3ZGAfv6Y3eXPT52Bt+lUqM2YQ=;
        b=HNxpo+olws4N68tmxKM7uPCGyjCbWe+2M5z+3bE2+HwKe8uSgPpTL2FFIMaUyEJat+ChdH
        6FP25yN9sAynBbuORor0wlb7V4S4Pd7ZZrGmn0tseJfjRE0F+BFDtmn1JWOgv7sxCHjNqb
        hUi34FP3MyQGy1eCyZ+uDjF4eSMKu14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642507061;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdOIwExMHXqbtbeyqn3ZGAfv6Y3eXPT52Bt+lUqM2YQ=;
        b=am5HsM+vf6EN6GjYRm1BJoGfRSUGnsP6juo6sjbuPrJY6HBeT8IXrm4ut++iyHjwZsCXNG
        5Gg5080RJIj/C5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 795E313B26;
        Tue, 18 Jan 2022 11:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eUe9HDWr5mG6YAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 11:57:41 +0000
Message-ID: <bc55bb89-9986-5271-2e60-a38ec0d44cf0@suse.cz>
Date:   Tue, 18 Jan 2022 12:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 27/66] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
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
 <20211201142918.921493-28-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-28-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> do_brk_munmap() has already aligned the address and has a maple tree
> state to be used.  Use the new do_mas_align_munmap() to avoid
> unnecessary alignment and error checks.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 14190306a483..79b8494d83c6 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2926,12 +2926,15 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct vm_area_struct unmap;
>  	unsigned long unmap_pages;
> -	int ret = 1;
> +	int ret;
>  
>  	arch_unmap(mm, newbrk, oldbrk);
>  
> -	if (likely(vma->vm_start >= newbrk)) { // remove entire mapping(s)
> -		ret = do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
> +	if (likely((vma->vm_end < oldbrk) ||
> +		   ((vma->vm_start == newbrk) && (vma->vm_end == oldbrk)))) {

Can you describe this change of conditions in the commit log as well?

> +		// remove entire mapping(s)
> +		ret = do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
> +					  true);
>  		goto munmap_full_vma;
>  	}
>  

