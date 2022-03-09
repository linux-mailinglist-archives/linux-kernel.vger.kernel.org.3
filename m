Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF34D384B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiCIRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiCIRy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:54:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A57AC917
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:53:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E5281F381;
        Wed,  9 Mar 2022 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646848404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQbgQmZ6PRHPb/9wR++IbmiOxljvQwct8K2X9mbk5jg=;
        b=C1eeXWQPn86L5oKEGsqyB8X+5jm+AkbFjj8A/jy5ohgpA0rRXoxyucl+j0uDj8YluASb0c
        J6cXWftiuLwrDJpCjPdZkkTfDA4MgjFo6tLBm4UIi4jqdv35QMqezz5L7nuTZzNpl6Ky8c
        jUNKIalEebze1bILSnzjdXTJlF8ZPYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646848404;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQbgQmZ6PRHPb/9wR++IbmiOxljvQwct8K2X9mbk5jg=;
        b=prd1Aae/Nv629+iQjFG0ODrORuaA/bsFppCrzs1vV+lk+cZOmlEg7PO7dWejlbAoBi8Znl
        3YoQ1CLVdY8EokCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B125C13D7A;
        Wed,  9 Mar 2022 17:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DpcIKpPpKGJdIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Mar 2022 17:53:23 +0000
Message-ID: <feccf0e4-61c4-3292-bd87-ff59c4fa0ec6@suse.cz>
Date:   Wed, 9 Mar 2022 18:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 2/9] mm: optimize do_wp_page() for fresh pages in local
 LRU pagevecs
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
 <20220131162940.210846-3-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220131162940.210846-3-david@redhat.com>
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
> For example, if a page just got swapped in via a read fault, the LRU
> pagevecs might still hold a reference to the page. If we trigger a
> write fault on such a page, the additional reference from the LRU
> pagevecs will prohibit reusing the page.
> 
> Let's conditionally drain the local LRU pagevecs when we stumble over a
> !PageLRU() page. We cannot easily drain remote LRU pagevecs and it might
> not be desirable performance-wise. Consequently, this will only avoid
> copying in some cases.
> 
> Add a simple "page_count(page) > 3" check first but keep the
> "page_count(page) > 1 + PageSwapCache(page)" check in place, as
> we want to minimize cases where we remove a page from the swapcache but
> won't be able to reuse it, for example, because another process has it
> mapped R/O, to not affect reclaim.
> 
> We cannot easily handle the following cases and we will always have to
> copy:
> 
> (1) The page is referenced in the LRU pagevecs of other CPUs. We really
>     would have to drain the LRU pagevecs of all CPUs -- most probably
>     copying is much cheaper.
> 
> (2) The page is already PageLRU() but is getting moved between LRU
>     lists, for example, for activation (e.g., mark_page_accessed()),
>     deactivation (MADV_COLD), or lazyfree (MADV_FREE). We'd have to
>     drain mostly unconditionally, which might be bad performance-wise.
>     Most probably this won't happen too often in practice.
> 
> Note that there are other reasons why an anon page might temporarily not
> be PageLRU(): for example, compaction and migration have to isolate LRU
> pages from the LRU lists first (isolate_lru_page()), moving them to
> temporary local lists and clearing PageLRU() and holding an additional
> reference on the page. In that case, we'll always copy.
> 
> This change seems to be fairly effective with the reproducer [1] shared
> by Nadav, as long as writeback is done synchronously, for example, using
> zram. However, with asynchronous writeback, we'll usually fail to free the
> swapcache because the page is still under writeback: something we cannot
> easily optimize for, and maybe it's not really relevant in practice.
> 
> [1] https://lkml.kernel.org/r/0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmail.com
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
