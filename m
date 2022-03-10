Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF844D43A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbiCJJmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiCJJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:42:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBC850048
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:41:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A2201F441;
        Thu, 10 Mar 2022 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646905297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dM+aQbQ1wyhu6vHFToiv7SxO6mhzbdA+ydL1e2axks=;
        b=CYBGfYpMk4O82Vn/9uFc8VwVbh5xIy+MiegfowqwK2e4fMtXYI3fwVlsyxBkVSG8h1HoQ3
        +Cub8yYGR9uowtsaMRhmGa66TBCTKvzVC+Cy6O2CpiaF6ebXjw3gAnNI5oK4yO+lpfldXE
        +e74zYdogqWlVd2jZOCuNVidcl6P610=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646905297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dM+aQbQ1wyhu6vHFToiv7SxO6mhzbdA+ydL1e2axks=;
        b=fbfwyGsMvGbc9SQ29JIS9x5a/ojOftwxJhk5BIBLZ2wJRhi5rb86nMzMXdwI73BM4aMsj1
        W4OsjrTm74d79hBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BBB813FA3;
        Thu, 10 Mar 2022 09:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HDUZIdDHKWI/WQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Mar 2022 09:41:36 +0000
Message-ID: <5b108bbb-0ddc-0f46-1b4b-6ceaa95727f2@suse.cz>
Date:   Thu, 10 Mar 2022 10:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 4/9] mm: streamline COW logic in do_swap_page()
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
 <20220131162940.210846-5-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220131162940.210846-5-david@redhat.com>
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
> Currently we have a different COW logic when:
> * triggering a read-fault to swapin first and then trigger a write-fault
>   -> do_swap_page() + do_wp_page()
> * triggering a write-fault to swapin
>   -> do_swap_page() + do_wp_page() only if we fail reuse in do_swap_page()
> 
> The COW logic in do_swap_page() is different than our reuse logic in
> do_wp_page(). The COW logic in do_wp_page() -- page_count() == 1 --  makes
> currently sure that we certainly don't have a remaining reference, e.g.,
> via GUP, on the target page we want to reuse: if there is any unexpected
> reference, we have to copy to avoid information leaks.
> 
> As do_swap_page() behaves differently, in environments with swap enabled we
> can currently have an unintended information leak from the parent to the
> child, similar as known from CVE-2020-29374:
> 
> 	1. Parent writes to anonymous page
> 	-> Page is mapped writable and modified
> 	2. Page is swapped out
> 	-> Page is unmapped and replaced by swap entry
> 	3. fork()
> 	-> Swap entries are copied to child
> 	4. Child pins page R/O
> 	-> Page is mapped R/O into child
> 	5. Child unmaps page
> 	-> Child still holds GUP reference
> 	6. Parent writes to page
> 	-> Page is reused in do_swap_page()
> 	-> Child can observe changes
> 
> Exchanging 2. and 3. should have the same effect.
> 
> Let's apply the same COW logic as in do_wp_page(), conditionally trying to
> remove the page from the swapcache after freeing the swap entry, however,
> before actually mapping our page. We can change the order now that
> we use try_to_free_swap(), which doesn't care about the mapcount,
> instead of reuse_swap_page().
> 
> To handle references from the LRU pagevecs, conditionally drain the local
> LRU pagevecs when required, however, don't consider the page_count() when
> deciding whether to drain to keep it simple for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
