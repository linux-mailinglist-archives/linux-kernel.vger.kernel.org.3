Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425B24FDCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbiDLKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378180AbiDLKe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:34:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593F5DA5E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:37:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F343D1F858;
        Tue, 12 Apr 2022 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649756229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Acl+0kkqyfmCUx2Q/P6xZ2ciXymcjfnhIA0pF3kbs78=;
        b=V82mBxbDz1XpzhOJbo+q5NDo7RWsgZG44QY+MoYm/qxNVP7Q93eSNVSkNAdWkD8ccpARek
        JEraM47mYtuJf+na1BSpCrnrROCQZPtm6vioyy6wuS3RcruBg534gKlG9cx/Bz+WzFNkid
        5GuiT2j2RSBWsuKHHahWgghq6KlwQQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649756229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Acl+0kkqyfmCUx2Q/P6xZ2ciXymcjfnhIA0pF3kbs78=;
        b=6wKAJct1hLrby0ylhI1ziIkKNEG8+UWgjgWdDIk2MWdODeHqX2weJju5Jz19Rl/nRjoBub
        F52zkDM0rMRq6QAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95F6613A99;
        Tue, 12 Apr 2022 09:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EnvvI0RIVWLqMAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Apr 2022 09:37:08 +0000
Message-ID: <742adeb1-0fa3-a2c8-1c90-ebcdb1e82022@suse.cz>
Date:   Tue, 12 Apr 2022 11:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/16] mm/huge_memory: remove outdated
 VM_WARN_ON_ONCE_PAGE from unmap_page()
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
 <20220329160440.193848-11-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-11-david@redhat.com>
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
> We can already theoretically fail to unmap (still having page_mapped()) in
> case arch_unmap_one() fails, which can happen on sparc. Failures to
> unmap are handled gracefully, just as if there are other references on
> the target page: freezing the refcount in split_huge_page_to_list()
> will fail if still mapped and we'll simply remap.
> 
> In commit 504e070dc08f ("mm: thp: replace DEBUG_VM BUG with VM_WARN when
> unmap fails for split") we already converted to VM_WARN_ON_ONCE_PAGE,
> let's get rid of it completely now.
> 
> This is a preparation for making try_to_migrate() fail on anonymous pages
> with GUP pins, which will make this VM_WARN_ON_ONCE_PAGE trigger more
> frequently.
> 
> Reported-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/huge_memory.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index dd16819c5edc..70298431e128 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2241,8 +2241,6 @@ static void unmap_page(struct page *page)
>  		try_to_migrate(folio, ttu_flags);
>  	else
>  		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
> -
> -	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>  }
>  
>  static void remap_page(struct folio *folio, unsigned long nr)

