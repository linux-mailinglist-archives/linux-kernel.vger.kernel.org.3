Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285184FFDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiDMSbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDMSbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:31:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E88517C0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:28:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93C96218A2;
        Wed, 13 Apr 2022 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649874519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bovZqnW3J0sEXG7lYTUTR5FPz9PnssVKHBXSHW46LQ0=;
        b=PQonp1i35SxnZ2dbgKPu3HjVNiKFgwCjk0Yh/iC11NYQyLAqbnpig19Z+LdAFK4p+2jRda
        J1i8MRR7zXduEY3aLb9/L5inQLHGmK8oxFd4TOgNuYLCbAy0HEgouveF+1gnxE8d5zKREg
        oB4WQHUYTqAXFZj5wiLfQVkpcKZxCPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649874519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bovZqnW3J0sEXG7lYTUTR5FPz9PnssVKHBXSHW46LQ0=;
        b=bC5OHzIBPmRa6JH5hnumHiSVp/pd20Rk3/Qi2UIFsm29TVOpl3WO0cRiqVRpx5iZGa1ReW
        n/UZWOyvYCj7ISCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F63713A91;
        Wed, 13 Apr 2022 18:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fRF8BlcWV2IhdAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Apr 2022 18:28:39 +0000
Message-ID: <5fc7d007-e59b-de8d-4d88-3f1b5adfa95b@suse.cz>
Date:   Wed, 13 Apr 2022 20:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 12/16] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
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
 <20220329160440.193848-13-david@redhat.com>
 <012e3889-563b-e7fc-c2e3-e7a6373a55ac@suse.cz>
 <2ae0a409-3d6d-9f6a-09e8-2f6867a4069a@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2ae0a409-3d6d-9f6a-09e8-2f6867a4069a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 18:39, David Hildenbrand wrote:
>>> @@ -3035,10 +3083,19 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>>>  
>>>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>>>  	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
>>> +
>>> +	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>>> +	if (anon_exclusive && page_try_share_anon_rmap(page)) {
>>> +		set_pmd_at(mm, address, pvmw->pmd, pmdval);
>>> +		return;
>> 
>> I am admittedly not too familiar with this code, but looks like this means
>> we fail to migrate the THP, right? But we don't seem to be telling the
>> caller, which is try_to_migrate_one(), so it will continue and not terminate
>> the walk and return false?
> 
> Right, we're not returning "false". Returning "false" would be an
> optimization to make rmap_walk_anon() fail faster.

Ah right, that's what I missed, it's an optimization and we will realize
elsewhere afterwards that the page has still mappings and we can't migrate...

> But, after all, the THP is exclusive (-> single mapping), so
> anon_vma_interval_tree_foreach() would most probably not have a lot work
> to do either way I'd assume?
> 
> In  any case, once we return from try_to_migrate(), the page will still
> be mapped.
> 

