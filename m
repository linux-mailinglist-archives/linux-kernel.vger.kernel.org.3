Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69272494DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbiATMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:24:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36506 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiATMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:23:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A18A1F76B;
        Thu, 20 Jan 2022 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642681411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAqWepW1sim3fFWmWCAhrRaH9v8z2bH1DSUyDF5D4cw=;
        b=Sc30tvY6t5HsQ1xrgT7MlE4INw7MuoZFcL007skkYzXOeq4sB5DTHl1k11FDdXBuajLdGO
        kRqh6CygtAd3DpqfDPJdhPFN3PZOnbGtiBFqtBAbJfSmEsgKMbJtdDsTU6kpIf8nQAbWqe
        rt6VGSHdZpcnR66qFikzWaDTipEom/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642681411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAqWepW1sim3fFWmWCAhrRaH9v8z2bH1DSUyDF5D4cw=;
        b=a4Vh9fhZuoEW1hXDZKhJO1MNIKklof6wLFwmn7G238WJOFH5esiE4fe6DwtAQSXaxk83LE
        /DR/XjO9fwZ9GxCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19F5813E9E;
        Thu, 20 Jan 2022 12:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QKKIBUNU6WHnXAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 12:23:31 +0000
Message-ID: <c0409a4c-0cec-0b7c-594e-199ac6a787c4@suse.cz>
Date:   Thu, 20 Jan 2022 13:23:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 57/66] mm/mprotect: Use maple tree navigation instead
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
 <20211201142918.921493-58-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-58-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mprotect.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index e552f5e0ccbd..7af58fd467c6 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -528,6 +528,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  	const int grows = prot & (PROT_GROWSDOWN|PROT_GROWSUP);
>  	const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
>  				(prot & PROT_READ);
> +	MA_STATE(mas, &current->mm->mm_mt, start, start);
>  
>  	start = untagged_addr(start);
>  
> @@ -559,7 +560,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  	if ((pkey != -1) && !mm_pkey_is_allocated(current->mm, pkey))
>  		goto out;
>  
> -	vma = find_vma(current->mm, start);
> +	vma = mas_find(&mas, ULONG_MAX);
>  	error = -ENOMEM;
>  	if (!vma)
>  		goto out;
> @@ -585,7 +586,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  	if (start > vma->vm_start)
>  		prev = vma;
>  	else
> -		prev = vma->vm_prev;
> +		prev = mas_prev(&mas, 0);
>  
>  	for (nstart = start ; ; ) {
>  		unsigned long mask_off_old_flags;
> @@ -647,7 +648,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		if (nstart >= end)
>  			goto out;
>  
> -		vma = prev->vm_next;
> +		vma = find_vma(current->mm, prev->vm_end);
>  		if (!vma || vma->vm_start != nstart) {
>  			error = -ENOMEM;
>  			goto out;

