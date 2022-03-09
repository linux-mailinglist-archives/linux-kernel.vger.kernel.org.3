Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F94D3864
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiCISEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiCISED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:04:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC1B63F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:03:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2FA621118;
        Wed,  9 Mar 2022 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646848982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiWoSBzAEkCGU0Hf+4zaaFdMVIEVCG4nJJMVf7RzVoI=;
        b=CLLWUWSN9ubDbTFaYanIiR0lUrprKcnmy5k7Y81YBtZWKNgVMrYsWVqmZZVtHBhw45MIAg
        78av96XmoTF3brhaxpSiGINy76V+yPR0uia/5I2xMZ7mA/EQohnmtLCU5VHL0hutHEFPeJ
        XAKwnxGZ29FZjSmq9+4fkUbJXqQxVHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646848982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiWoSBzAEkCGU0Hf+4zaaFdMVIEVCG4nJJMVf7RzVoI=;
        b=Q3Obw1A7h7KfmsNKdz9yheW4tCJ3BjzF/XZHK6j4Wxtnm6t04z9OAuHCBvxAdEQ/5ksnOz
        M5yo065GDFt3twDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6897B13D7D;
        Wed,  9 Mar 2022 18:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ENrmGNbrKGIQJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Mar 2022 18:03:02 +0000
Message-ID: <62cd72d5-c072-d159-8de4-95cd0804c7db@suse.cz>
Date:   Wed, 9 Mar 2022 19:03:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 3/9] mm: slightly clarify KSM logic in do_swap_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org
References: <20220131162940.210846-1-david@redhat.com>
 <20220131162940.210846-4-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220131162940.210846-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 17:29, David Hildenbrand wrote:
> Let's make it clearer that KSM might only have to copy a page
> in case we have a page in the swapcache, not if we allocated a fresh
> page and bypassed the swapcache. While at it, add a comment why this is
> usually necessary and merge the two swapcache conditions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


> ---
>  mm/memory.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 923165b4c27e..3c91294cca98 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3615,21 +3615,29 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		goto out_release;
>  	}
>  
> -	/*
> -	 * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
> -	 * release the swapcache from under us.  The page pin, and pte_same
> -	 * test below, are not enough to exclude that.  Even if it is still
> -	 * swapcache, we need to check that the page's swap has not changed.
> -	 */
> -	if (unlikely((!PageSwapCache(page) ||
> -			page_private(page) != entry.val)) && swapcache)
> -		goto out_page;
> -
> -	page = ksm_might_need_to_copy(page, vma, vmf->address);
> -	if (unlikely(!page)) {
> -		ret = VM_FAULT_OOM;
> -		page = swapcache;
> -		goto out_page;
> +	if (swapcache) {
> +		/*
> +		 * Make sure try_to_free_swap or reuse_swap_page or swapoff did
> +		 * not release the swapcache from under us.  The page pin, and
> +		 * pte_same test below, are not enough to exclude that.  Even if
> +		 * it is still swapcache, we need to check that the page's swap
> +		 * has not changed.
> +		 */
> +		if (unlikely(!PageSwapCache(page) ||
> +			     page_private(page) != entry.val))
> +			goto out_page;
> +
> +		/*
> +		 * KSM sometimes has to copy on read faults, for example, if
> +		 * page->index of !PageKSM() pages would be nonlinear inside the
> +		 * anon VMA -- PageKSM() is lost on actual swapout.
> +		 */
> +		page = ksm_might_need_to_copy(page, vma, vmf->address);
> +		if (unlikely(!page)) {
> +			ret = VM_FAULT_OOM;
> +			page = swapcache;
> +			goto out_page;
> +		}
>  	}
>  
>  	cgroup_throttle_swaprate(page, GFP_KERNEL);

