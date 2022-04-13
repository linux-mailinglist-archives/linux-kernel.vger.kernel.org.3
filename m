Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD54FFB17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiDMQW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiDMQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D4832E083
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649866832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQ64bLtEVZ+APpRlTSXSaScluxess+bMVBlFs6Kt68A=;
        b=bqIjedFfOyKMk7pUW6H2cxY7SkdVNtnOd+F8U343oCR+YXC7CWf3bWEyGyx2/aIPTUKESD
        pnIi4jBApAerXAeRmVcNVW9jApw4Dkim2Y07k3BU+s8rgNZ2Y6b/WdoKlMwBEAP9QG9iI+
        ZRr0sgqBQukMh8Ge/satS8unI8ecVtE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-_TeO9B0SOVKw52_wm5Wkyg-1; Wed, 13 Apr 2022 12:20:31 -0400
X-MC-Unique: _TeO9B0SOVKw52_wm5Wkyg-1
Received: by mail-wr1-f70.google.com with SMTP id r10-20020adfc10a000000b00207a2c7bcf6so509209wre.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=dQ64bLtEVZ+APpRlTSXSaScluxess+bMVBlFs6Kt68A=;
        b=AbTAZpV5uR19fnEADEmqejL7eHwcAqx95Dcy1YLqT4wo0sPXQMXVqUajfCTomhK45l
         u/y4KmXwfPFSN6jFQ+Ut+a0vgnqlKU44E23yEOKoWc2TAVYfqyVNIuzxqVKgU7UhNoiF
         CcoBITFayF0ul7w5jpczekYXhUtWVEMcY69t7P2iwivI0HKKpLp3vSY8Odp0G8yHk+vw
         GZEG+BSNG9riBnHm6i3X1IZ6ahD/tMUCAXVuhDNM6jHJHf87N41pTP9sjczYZNII6nMn
         Z5ttTp7QhqtgKDdLSyOeFDU5pj8zp5AGNez+/xEHGvQKTzhxAadCNft8vZGn7TPjWA/N
         pb3w==
X-Gm-Message-State: AOAM531ZTBQ9A9Ti+gVxVLuga8+T5bVHxOoXfEiGjZPMvU8u0hcSmpcE
        Zx6s43bU+6ORlSRVhHDZLjvQ7+yic9gfpxePYhzqfq7hzLWw33wDwsAvFt5sg5PaKHIBb4KYa/k
        KMRILmFxuxpMIPpxluHNU2I8i
X-Received: by 2002:a7b:c350:0:b0:38c:6d3c:6c8 with SMTP id l16-20020a7bc350000000b0038c6d3c06c8mr9082269wmj.45.1649866830183;
        Wed, 13 Apr 2022 09:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbrrSYAH6xBT3EvIXb/61ZOGSr7pOKzCt5GDKiyQdvREB4rw53ZUTMAhXOGOzlf05bfV7LKQ==
X-Received: by 2002:a7b:c350:0:b0:38c:6d3c:6c8 with SMTP id l16-20020a7bc350000000b0038c6d3c06c8mr9082233wmj.45.1649866829941;
        Wed, 13 Apr 2022 09:20:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b0038e9c60f0e7sm2845408wme.28.2022.04.13.09.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:20:29 -0700 (PDT)
Message-ID: <a37351a3-fb02-0709-1f4b-81525be34f05@redhat.com>
Date:   Wed, 13 Apr 2022 18:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <4cb92b41-95e1-1666-321e-96ff9e6095bb@suse.cz>
 <368902ab-8d3f-5d62-581e-1ff930bcefa0@redhat.com>
 <YlbBXiVezzVw+NZZ@casper.infradead.org>
 <0c9d2c39-5080-a855-8ecd-e2c1bd1179fa@redhat.com>
 <YlbGswXaIRblKN9j@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 08/16] mm/rmap: drop "compound" parameter from
 page_add_new_anon_rmap()
In-Reply-To: <YlbGswXaIRblKN9j@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 14:48, Matthew Wilcox wrote:
> On Wed, Apr 13, 2022 at 02:28:38PM +0200, David Hildenbrand wrote:
>> On 13.04.22 14:26, Matthew Wilcox wrote:
>>> On Tue, Apr 12, 2022 at 11:37:09AM +0200, David Hildenbrand wrote:
>>>> On 12.04.22 10:47, Vlastimil Babka wrote:
>>>>> There's a VM_BUG_ON_PAGE(PageTransCompound(page), page); later in a
>>>>> !compound branch. Since compound is now determined by the same check, could
>>>>> be deleted.
>>>>
>>>> Yes, eventually we could get rid of both VM_BUG_ON_PAGE() on both
>>>> branches and add a single VM_BUG_ON_PAGE(PageTail(page), page) check on
>>>> the compound branch. (we could also make sure that we're not given a
>>>> hugetlb page)
>>>
>>> As a rule of thumb, if you find yourself wanting to add
>>> VM_BUG_ON_PAGE(PageTail(page), page), you probably want to change the
>>> interface to take a folio.
>>
>> Yeah, I had the same in mind. Might be a reasonable addon on top --
>> although it would stick out in the rmap code a bit because most
>> functions deal with both, folios and subpages.
> 
> I have the start of a series which starts looking at the fault path
> to see where it makes sense to use folios and where it makes sense to
> use pages.
> 
> We're (generally) faulting on a PTE, so we need the precise page to
> be returned in vmf->page.  However vmf->cow_page can/should be a
> folio (because it's definitely not a tail page).  That trickles
> down into copy_present_page() (new_page and prealloc both become folios)
> and so page_add_new_anon_rmap() then looks like a good target to
> take a folio.
> 
> The finish_fault() -> do_set_pte() -> page_add_new_anon_rmap() looks
> like the only kind of strange place where we don't necessarily have a
> folio (all the others we just allocated it).
> 

That's an interesting point. In this patch I'm assuming that we don't
have a compound page here (see below).

Which makes sense, because as the interface states "Same as
page_add_anon_rmap but must only be called on *new* pages.".

At least to me it would be weird to allocate a new compound page to then
pass a subpage to do_set_pte() page_add_new_anon_rmap().


And in fact, inside page_add_new_anon_rmap(compound=false) we have

/* Anon THP always mapped first with PMD */
VM_BUG_ON_PAGE(PageTransCompound(page), page);


which makes sure that we cannot have a compound page here, but in fact a
folio.

So unless I am missing something, do_set_pte() should in fact have a
folio here unless BUG?

-- 
Thanks,

David / dhildenb

