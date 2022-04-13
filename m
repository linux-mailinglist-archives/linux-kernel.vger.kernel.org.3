Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED864FF97E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiDMO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiDMO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:58:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07149E0DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:55:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B0F31F869;
        Wed, 13 Apr 2022 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649861745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcWSoqX6MF2jNoXvZrSaKVBHkNeLeKaasZJ9GM7J/mw=;
        b=kRuThKFn7qs28R959Nsasud/3cMNFp1t+MNSDsmA6H9gRax1E7daj2Z19n4AW5dc9KX73p
        pVFMArBKUV/n16ycOsVrppwWNaIJfzv5e04Nt+mFPfVaPUMpDlvzZuCFDyIGiaN8HSjkdJ
        l79GzukUL8K/wwXfaMzci7m3PPUIxFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649861745;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcWSoqX6MF2jNoXvZrSaKVBHkNeLeKaasZJ9GM7J/mw=;
        b=B9nD+lFBRxtBKKHMzUxYi9cEjbZ3h2bXt41cWrObQwxkpZxxDAT08w173fAcYn89XbWEa5
        T5jXysjHroNAULBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31C6813A91;
        Wed, 13 Apr 2022 14:55:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dteZC3HkVmIDJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Apr 2022 14:55:45 +0000
Message-ID: <c410215b-bae4-4bff-bc7b-3d6953e996fd@suse.cz>
Date:   Wed, 13 Apr 2022 16:55:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 11/16] mm/page-flags: reuse PG_mappedtodisk as
 PG_anon_exclusive for PageAnon() pages
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
 <20220329160440.193848-12-david@redhat.com>
 <84c0bcbb-5c8f-d3b2-2a8c-d68462d0bc04@suse.cz>
 <e015a477-89df-5eb1-5fec-b1108c18e4a4@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e015a477-89df-5eb1-5fec-b1108c18e4a4@redhat.com>
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

On 4/13/22 12:28, David Hildenbrand wrote:
> On 13.04.22 10:25, Vlastimil Babka wrote:
>> On 3/29/22 18:04, David Hildenbrand wrote:
>>>   the pin will be fully reliable and stay consistent with the pages
>>>   mapped into the page table, as the bit cannot get cleared (e.g., by
>>>   fork(), KSM) while the page is pinned. For anonymous pages that
>>>   are mapped R/W, PG_anon_exclusive can be assumed to always be set
>>>   because such pages cannot possibly be shared.
>>>
>>>   The page table lock protecting the page table entry is the primary
>>>   synchronization mechanism for PG_anon_exclusive; GUP-fast that does
>>>   not take the PT lock needs special care when trying to clear the
>>>   flag.
>>>
>>>   Page table entry types and PG_anon_exclusive:
>>>   * Present: PG_anon_exclusive applies.
>>>   * Swap: the information is lost. PG_anon_exclusive was cleared.
>>>   * Migration: the entry holds this information instead.
>>>                PG_anon_exclusive was cleared.
>>>   * Device private: PG_anon_exclusive applies.
>>>   * Device exclusive: PG_anon_exclusive applies.
>>>   * HW Poison: PG_anon_exclusive is stale and not changed.
>>>
>>>   If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
>>>   not allowed and the flag will stick around until the page is freed
>>>   and folio->mapping is cleared.
>> 
>> Or also if it's unpinned?
> 
> I'm afraid I didn't get your question. Once the page is no longer
> pinned, we can succeed in clearing PG_anon_exclusive (just like pinning
> never happened). Does that answer your question?

Yeah it looked like a scenario that's oddly missing in that description, yet
probably obvious. Now I feel it's indeed obvious, so nevermind :)

>>> We won't be clearing PG_anon_exclusive on destructive unmapping (i.e.,
>>> zapping) of page table entries, page freeing code will handle that when
>>> also invalidate page->mapping to not indicate PageAnon() anymore.
>>> Letting information about exclusivity stick around will be an important
>>> property when adding sanity checks to unpinning code.
>>>
>>> Note that we properly clear the flag in free_pages_prepare() via
>>> PAGE_FLAGS_CHECK_AT_PREP for each individual subpage of a compound page,
>>> so there is no need to manually clear the flag.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks!
> 
>> 
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3663,6 +3663,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>  		goto out_nomap;
>>>  	}
>>>  
>>> +	/*
>>> +	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
>>> +	 * must never point at an anonymous page in the swapcache that is
>>> +	 * PG_anon_exclusive. Sanity check that this holds and especially, that
>>> +	 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
>>> +	 * check after taking the PT lock and making sure that nobody
>>> +	 * concurrently faulted in this page and set PG_anon_exclusive.
>>> +	 */
>>> +	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>>> +	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
>>> +
>> 
>> Hmm, dunno why not VM_BUG_ON?
> 
> Getting PageAnonExclusive accidentally set by a file system would result
> in an extremely unpleasant security issue. I most surely want to catch
> something like that in any case, especially in the foreseeable future.

OK then.

