Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E448C695
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354375AbiALO4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:56:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35826 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354371AbiALO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:56:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDE722113A;
        Wed, 12 Jan 2022 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641999359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KSUB5kk6nqxyfWFyV07yS90dxBEdeusq9/dOu6x3jE=;
        b=l/xiyL8QrWWgcg71BMnXFzBYFg1IlHLPgU1TngGuuVcjuCRidcqSKgkdiURr9OCmM/S8Mz
        yW5vpZpRGS3452NJlNPMWOtgLO1gB9/bZY02dquRSlN+ZaESF51baJKn5t8e7S62jnpUPP
        7Ugi2zWPLYCm7N4nK9ghIxWuHZnGqQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641999359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KSUB5kk6nqxyfWFyV07yS90dxBEdeusq9/dOu6x3jE=;
        b=DXlVaQErcO2qUlP5shtCFtZwdL197gN301t5uJHizZrhYjsqtdJy4MqtyK1PCrTjSjjnOh
        Iw+DKH6oq3uAHgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EAC613B70;
        Wed, 12 Jan 2022 14:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8YT5Jf/r3mF7DwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 12 Jan 2022 14:55:59 +0000
Message-ID: <7bd61a52-57ef-04e4-6298-039308bb8f86@suse.cz>
Date:   Wed, 12 Jan 2022 15:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
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
 <20211201142918.921493-18-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 17/66] mmap: Change zeroing of maple tree in
 __vma_adjust
In-Reply-To: <20211201142918.921493-18-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> Only write to the maple tree if we are not inserting or the insert isn't
> going to overwrite the area to clear.  This avoids spanning writes and
> node coealescing when unnecessary.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 93ed19b2c6ce..c5f92666d145 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -615,6 +615,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	bool vma_changed = false;
>  	long adjust_next = 0;
>  	int remove_next = 0;
> +	unsigned long old_start;
>  
>  	if (next && !insert) {
>  		struct vm_area_struct *exporter = NULL, *importer = NULL;
> @@ -740,25 +741,29 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  			vma_interval_tree_remove(next, root);
>  	}
>  
> +	old_start = vma->vm_start;
>  	if (start != vma->vm_start) {
> -		if (vma->vm_start < start)
> -			vma_mt_szero(mm, vma->vm_start, start);
> -		else
> -			vma_changed = true;
> +		vma_changed = true;

This says vma_changed = true even if vma is shrinking, so below we might do
an unnecessary vma_store(), no?

>  		vma->vm_start = start;
>  	}
>  	if (end != vma->vm_end) {
> -		if (vma->vm_end > end)
> -			vma_mt_szero(mm, end, vma->vm_end);
> -		else
> +		if (vma->vm_end > end) {

In contrast to the above, here vma_changed is only set when expanding
('vma_expand' would be a more descriptive name maybe?). So why are the two
cases handled differently, am I missing something?

> +			if (!insert || (insert && (insert->vm_start != end)))

Note: thanks to lazy evaluation, "insert &&" should be unnecessary?
More importantly: is "insert->vm_start == end" a guarantee that insert
covers the whole interval from end to vma->vm_end? Probably yes, but a
VM_WARN_ON would be in order?

> +				vma_mt_szero(mm, end, vma->vm_end);

I guess it can't happen that insert would cover a later part of this
interval, so we could zero only between end vna insert->vm_start?

> +		} else
>  			vma_changed = true;

Same nit about { } block as previously.

>  		vma->vm_end = end;
>  		if (!next)
>  			mm->highest_vm_end = vm_end_gap(vma);
>  	}
>  
> -	if (vma_changed)
> +	if (vma_changed) {
>  		vma_store(mm, vma);
> +		if (old_start < start) {
> +			if (insert && (insert->vm_start != old_start))
> +				vma_mt_szero(mm, old_start, start);

This condition looks actively wrong, no zeroing at all if insert is NULL?

> +		}
> +	}
>  
>  	vma->vm_pgoff = pgoff;
>  	if (adjust_next) {

