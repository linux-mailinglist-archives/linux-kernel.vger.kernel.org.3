Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99B4FDAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357435AbiDLJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiDLJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:42:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341B60DAE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:47:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6CD2C21608;
        Tue, 12 Apr 2022 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649753241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E33CS35xOqn/0jMFES+ln46MItDGxXtgyeeOFfPSYHg=;
        b=vD1JMVqoVHrbSfjApv7zRM1vbaDtxY2qKh1Zce3DSp8pnGDyANmbL1p5hISeBHomCZVDsU
        A7B6gQgHXbrKEyQvU+SYNmsHmEFhYfadfMIRf7KMofouj5kmeLIjTfUsZjyMwD433DfsF6
        xUiuImzo3IiDtvuN/G+SFzdIRjD1K70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649753241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E33CS35xOqn/0jMFES+ln46MItDGxXtgyeeOFfPSYHg=;
        b=ONIhPj2uzNWCfXuwgEBX74nJ9V6mJOn8ChK8q6P9aHsUH81STTHiqLpAhmqzvVhB7D5UG5
        6DNtM4YvDXopWHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1770F13780;
        Tue, 12 Apr 2022 08:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gJPwBJk8VWKJHAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Apr 2022 08:47:21 +0000
Message-ID: <4cb92b41-95e1-1666-321e-96ff9e6095bb@suse.cz>
Date:   Tue, 12 Apr 2022 10:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 08/16] mm/rmap: drop "compound" parameter from
 page_add_new_anon_rmap()
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
 <20220329160440.193848-9-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-9-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> New anonymous pages are always mapped natively: only THP/khugepagd code

						khugepaged ^

> maps a new compound anonymous page and passes "true". Otherwise, we're
> just dealing with simple, non-compound pages.
> 
> Let's give the interface clearer semantics and document these.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit:

> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1182,19 +1182,22 @@ void page_add_anon_rmap(struct page *page,
>  }
>  
>  /**
> - * page_add_new_anon_rmap - add pte mapping to a new anonymous page
> + * page_add_new_anon_rmap - add mapping to a new anonymous page
>   * @page:	the page to add the mapping to
>   * @vma:	the vm area in which the mapping is added
>   * @address:	the user virtual address mapped
> - * @compound:	charge the page as compound or small page
> + *
> + * If it's a compound page, it is accounted as a compound page. As the page
> + * is new, it's assume to get mapped exclusively by a single process.
>   *
>   * Same as page_add_anon_rmap but must only be called on *new* pages.
>   * This means the inc-and-test can be bypassed.
>   * Page does not have to be locked.
>   */
>  void page_add_new_anon_rmap(struct page *page,
> -	struct vm_area_struct *vma, unsigned long address, bool compound)
> +	struct vm_area_struct *vma, unsigned long address)
>  {
> +	const bool compound = PageCompound(page);
>  	int nr = compound ? thp_nr_pages(page) : 1;
>  
>  	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);

There's a VM_BUG_ON_PAGE(PageTransCompound(page), page); later in a
!compound branch. Since compound is now determined by the same check, could
be deleted.
