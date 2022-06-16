Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EFD54DCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359378AbiFPIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFPIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:17:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D460F09
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:17:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8456621BF7;
        Thu, 16 Jun 2022 08:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655367460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qGPX7MTMU1nEcbjw7EL8VlSReTqwBY1xsksWILdsP0=;
        b=RtbgEVSFwcdi9SYguzqXJB55PAm8FK4/PRTTUo4X3HyNfq3ea9CMF8J2nkx/ztxOsIJs9P
        VLAl10K4pG9hfax9PKNKVriwWk0Ap8U1ph9/vU8fSHrwNBDMbYPe1BHbNRMdCj9C/gg1ea
        o5jYAzWEcXa4918AF6H94ipBuV0Yu3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655367460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qGPX7MTMU1nEcbjw7EL8VlSReTqwBY1xsksWILdsP0=;
        b=eqguhdLFSMo1ii5DgbRoEU7pI2lWOFtTaFdbwglPwle79qoFJLd8La/OltEc7/Xm09DciO
        lOohQoWlNjPewFBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 529761344E;
        Thu, 16 Jun 2022 08:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KDl/EyTnqmJgLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Jun 2022 08:17:40 +0000
Message-ID: <e4ab8e0e-dfe7-556d-d8f4-f017cf0db59e@suse.cz>
Date:   Thu, 16 Jun 2022 10:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/2] [PATCH 1/2] mm: refactor of vma_merge()
Content-Language: en-US
To:     =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org
References: <20220603145719.1012094-1-matenajakub@gmail.com>
 <20220603145719.1012094-2-matenajakub@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220603145719.1012094-2-matenajakub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 16:57, Jakub Matěna wrote:
> Refactor vma_merge() to make it shorter and more understandable.
> Main change is the elimination of code duplicity in the case of
> merge next check. This is done by first doing checks and caching
> the results before executing the merge itself. The variable 'area' is
> divided into 'mid' and 'res' as previously it was used for two purposes,
> as the middle VMA between prev and next and also as the result of the
> merge itself. Exit paths are also unified.
> 
> Signed-off-by: Jakub Matěna <matenajakub@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 87 +++++++++++++++++++++++--------------------------------
>  1 file changed, 37 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 313b57d55a63..91100fdc400a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1170,8 +1170,10 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>  			struct anon_vma_name *anon_name)
>  {
>  	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> -	struct vm_area_struct *area, *next;
> -	int err;
> +	struct vm_area_struct *mid, *next, *res;
> +	int err = -1;
> +	bool merge_prev = false;
> +	bool merge_next = false;
>  
>  	/*
>  	 * We later require that vma->vm_flags == vm_flags,
> @@ -1181,75 +1183,60 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>  		return NULL;
>  
>  	next = find_vma(mm, prev ? prev->vm_end : 0);
> -	area = next;
> -	if (area && area->vm_end == end)		/* cases 6, 7, 8 */
> +	mid = next;
> +	if (next && next->vm_end == end)		/* cases 6, 7, 8 */
>  		next = find_vma(mm, next->vm_end);
>  
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(area && end > area->vm_end);
> +	VM_WARN_ON(mid && end > mid->vm_end);
>  	VM_WARN_ON(addr >= end);
>  
> -	/*
> -	 * Can it merge with the predecessor?
> -	 */
> +	/* Can we merge the predecessor? */
>  	if (prev && prev->vm_end == addr &&
>  			mpol_equal(vma_policy(prev), policy) &&
>  			can_vma_merge_after(prev, vm_flags,
>  					    anon_vma, file, pgoff,
>  					    vm_userfaultfd_ctx, anon_name)) {
> -		/*
> -		 * OK, it can.  Can we now merge in the successor as well?
> -		 */
> -		if (next && end == next->vm_start &&
> -				mpol_equal(policy, vma_policy(next)) &&
> -				can_vma_merge_before(next, vm_flags,
> -						     anon_vma, file,
> -						     pgoff+pglen,
> -						     vm_userfaultfd_ctx, anon_name) &&
> -				is_mergeable_anon_vma(prev->anon_vma,
> -						      next->anon_vma, NULL)) {
> -							/* cases 1, 6 */
> -			err = __vma_adjust(prev, prev->vm_start,
> -					 next->vm_end, prev->vm_pgoff, NULL,
> -					 prev);
> -		} else					/* cases 2, 5, 7 */
> -			err = __vma_adjust(prev, prev->vm_start,
> -					 end, prev->vm_pgoff, NULL, prev);
> -		if (err)
> -			return NULL;
> -		khugepaged_enter_vma(prev, vm_flags);
> -		return prev;
> +		merge_prev = true;
>  	}
> -
> -	/*
> -	 * Can this new request be merged in front of next?
> -	 */
> +	/* Can we merge the successor? */
>  	if (next && end == next->vm_start &&
>  			mpol_equal(policy, vma_policy(next)) &&
>  			can_vma_merge_before(next, vm_flags,
>  					     anon_vma, file, pgoff+pglen,
>  					     vm_userfaultfd_ctx, anon_name)) {
> +		merge_next = true;
> +	}
> +	/* Can we merge both the predecessor and the successor? */
> +	if (merge_prev && merge_next &&
> +			is_mergeable_anon_vma(prev->anon_vma,
> +				next->anon_vma, NULL)) {	 /* cases 1, 6 */
> +		err = __vma_adjust(prev, prev->vm_start,
> +					next->vm_end, prev->vm_pgoff, NULL,
> +					prev);
> +		res = prev;
> +	} else if (merge_prev) {			/* cases 2, 5, 7 */
> +		err = __vma_adjust(prev, prev->vm_start,
> +					end, prev->vm_pgoff, NULL, prev);
> +		res = prev;
> +	} else if (merge_next) {
>  		if (prev && addr < prev->vm_end)	/* case 4 */
>  			err = __vma_adjust(prev, prev->vm_start,
> -					 addr, prev->vm_pgoff, NULL, next);
> -		else {					/* cases 3, 8 */
> -			err = __vma_adjust(area, addr, next->vm_end,
> -					 next->vm_pgoff - pglen, NULL, next);
> -			/*
> -			 * In case 3 area is already equal to next and
> -			 * this is a noop, but in case 8 "area" has
> -			 * been removed and next was expanded over it.
> -			 */
> -			area = next;
> -		}
> -		if (err)
> -			return NULL;
> -		khugepaged_enter_vma(area, vm_flags);
> -		return area;
> +					addr, prev->vm_pgoff, NULL, next);
> +		else					/* cases 3, 8 */
> +			err = __vma_adjust(mid, addr, next->vm_end,
> +					next->vm_pgoff - pglen, NULL, next);
> +		res = next;
>  	}
>  
> -	return NULL;
> +	/*
> +	 * Cannot merge with predecessor or successor or error in __vma_adjust?
> +	 */
> +	if (err)
> +		return NULL;
> +	khugepaged_enter_vma(res, vm_flags);
> +	return res;
>  }
>  
>  /*

