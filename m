Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5225072F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354641AbiDSQeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiDSQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:34:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA323BF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:31:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E07011F753;
        Tue, 19 Apr 2022 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650385909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO3XX7Rny2nsJoT+gYq0ibjOzFl1Xd4EM1kydabFEzE=;
        b=kjokVUJ3xRC0ikC463fBM8xhon5NE74/yvmE8X96/o1PsvEjmSm80uds6zRrMGyGjszGvm
        rOy1yIYyESFXkRyVxxueBHQrQFCezHrP8mP0NmExj+b1M6/gfZIM5Sx/L/1vU9iqwEdxAq
        CkATQbHpsq0f2Op5GAJyEbE+MCe5CnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650385909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO3XX7Rny2nsJoT+gYq0ibjOzFl1Xd4EM1kydabFEzE=;
        b=T9zksfhxLXx1ImU1UANHvwz0/HZ5i5o86PA59TzsIBJeQPbjUuPRdFLYwkLrmTn4rBRLJg
        EXWdcvejuv6xGpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88124132E7;
        Tue, 19 Apr 2022 16:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wDeNIPXjXmL5VQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 19 Apr 2022 16:31:49 +0000
Message-ID: <3cc33611-a430-1ce4-bb30-7dc62a530cb8@suse.cz>
Date:   Tue, 19 Apr 2022 18:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 14/16] mm: support GUP-triggered unsharing of anonymous
 pages
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
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-15-david@redhat.com>
 <9005b167-db08-c967-463b-5e0e092cbb6c@suse.cz>
 <c003964a-9fa1-b17c-158a-8ccbf4ff8656@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c003964a-9fa1-b17c-158a-8ccbf4ff8656@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 18:29, David Hildenbrand wrote:
>>> @@ -4515,8 +4550,11 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>>>  /* `inline' is required to avoid gcc 4.1.2 build error */
>>>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>>>  {
>>> +	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
>>> +
>>>  	if (vma_is_anonymous(vmf->vma)) {
>>> -		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>>> +		if (unlikely(unshare) &&
>> 
>> Is this condition flipped, should it be "likely(!unshare)"? As the similar
>> code in do_wp_page() does.
> 
> Good catch, this should affect uffd-wp on THP -- it wouldn't trigger as expected. Thanks a lot for finding that!

Yay, glad I was right this time.

>> 
>>> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>>>  			return handle_userfault(vmf, VM_UFFD_WP);
>>>  		return do_huge_pmd_wp_page(vmf);
>>>  	}
>>> @@ -4651,10 +4689,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>>  		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
>>>  		goto unlock;
>>>  	}
>>> -	if (vmf->flags & FAULT_FLAG_WRITE) {
>>> +	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>>>  		if (!pte_write(entry))
>>>  			return do_wp_page(vmf);
>>> -		entry = pte_mkdirty(entry);
>>> +		else if (likely(vmf->flags & FAULT_FLAG_WRITE))
>>> +			entry = pte_mkdirty(entry);
>>>  	}
>>>  	entry = pte_mkyoung(entry);
>>>  	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
>> 
> 
> 
> So the following on top, right?

Looks good!

> diff --git a/mm/memory.c b/mm/memory.c
> index 8b3cb73f5e44..4584c7e87a70 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3137,7 +3137,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>                         free_swap_cache(old_page);
>                 put_page(old_page);
>         }
> -       return page_copied && !unshare ? VM_FAULT_WRITE : 0;
> +       return (page_copied && !unshare) ? VM_FAULT_WRITE : 0;
>  oom_free_new:
>         put_page(new_page);
>  oom:
> @@ -4604,7 +4604,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>         const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
>  
>         if (vma_is_anonymous(vmf->vma)) {
> -               if (unlikely(unshare) &&
> +               if (likely(!unshare) &&
>                     userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>                         return handle_userfault(vmf, VM_UFFD_WP);
>                 return do_huge_pmd_wp_page(vmf);
> 
> 

