Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0DC4C866F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiCAIZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiCAIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA256004D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646123087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OjrXJyKn42EzyN5K6cra49btW5qtOQTOfSL27/rxsI=;
        b=C1wI9ZDmRfNBt+oc57wc+oz8dURKzBeecP5uYdBQnfl27Qdz8VNFOL6+J5pPKp6lYr80me
        McRkEUJqwkztwQA0cU8driEUORE7FaOT/irmN6nFlmEMUSEOyk7Jty+iNaH6HSc2R8CMA0
        2MkntKBwzo6jDR3kbZPio/qlUm89qSM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-ZAHjhpclOVSBrtyjzNHTVw-1; Tue, 01 Mar 2022 03:24:44 -0500
X-MC-Unique: ZAHjhpclOVSBrtyjzNHTVw-1
Received: by mail-wr1-f72.google.com with SMTP id ay18-20020a5d6f12000000b001efe36eb038so1503898wrb.17
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=6OjrXJyKn42EzyN5K6cra49btW5qtOQTOfSL27/rxsI=;
        b=k/YiagG93jro/C5lj1WXwOIJ7sJqWR9hujGKBjwTrovdl/iALGu+XAqkve+wvsJFP0
         TlNmKucigFbcYPs8uIXTUBdjFeR9m/3KHx73el8Tb0mdL9ggUytauXGoChwLjI+9+xKV
         H8F2IfJtbkbtKJUrab9eWCYJvm1h7tCZP9+wfyl68n1kICJyHqBAGtmD0/oiDFTioSs2
         pWFtyj+xI2iyoXzvZBSlkWmhulz+Go5jrso4HIGj05q/kM/YCAZKxARrKILlDrApXGix
         /iym3CKbarhcFaYXyemB/D1850WAwkfMI6tH+is31a0BqmHCML4EYx+Ud0io6M2m0lM0
         YF6g==
X-Gm-Message-State: AOAM530FsfrXx6gfXRqtkT2qnOBqOxcNj3hlGBmPyjazd4AYt9piWEGy
        /9hkh2y5EIkdWIjMxe9sFXqZpHlXOkAvI47uM3IkjVUWpzrEM43QiExLd/OYAM8SrDF0KGQOhLx
        oQ2PaHxVwa0XyAtFFMz+GqB9HResXl+VRNYITx/bI5q/6lZUIbr6eqiejBXXZQdT7u9anKoWr
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr15944094wmq.20.1646123083489;
        Tue, 01 Mar 2022 00:24:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMqOpssS8d6tbOinpqRQItUr5VUMVaKyagMbiQGX3iw2D3lOmjyt8RNWbWp14Ett9P3BUI0Q==
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr15944057wmq.20.1646123083147;
        Tue, 01 Mar 2022 00:24:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5e00:88ce:ad41:cb1b:323? (p200300cbc70e5e0088cead41cb1b0323.dip0.t-ipconnect.de. [2003:cb:c70e:5e00:88ce:ad41:cb1b:323])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm13194841wru.48.2022.03.01.00.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:24:42 -0800 (PST)
Message-ID: <329e01f6-813a-9212-97c9-9440894dcf2c@redhat.com>
Date:   Tue, 1 Mar 2022 09:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
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
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        Khalid Aziz <khalid.aziz@oracle.com>
References: <20220224122614.94921-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 00/13] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
In-Reply-To: <20220224122614.94921-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.22 13:26, David Hildenbrand wrote:
> This series is the result of the discussion on the previous approach [2].
> More information on the general COW issues can be found there. It is based
> on [1], which resides in -mm and -next:
> 	[PATCH v3 0/9] mm: COW fixes part 1: fix the COW security issue for
> 	THP and swap
> 
> I keep the latest state, including some hacky selftest on:
> 	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2
> 
> This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
> on an anonymous page and COW logic fails to detect exclusivity of the page
> to then replacing the anonymous page by a copy in the page table: The
> GUP pin lost synchronicity with the pages mapped into the page tables.
> 
> This issue, including other related COW issues, has been summarized in [3]
> under 3):
> "
>   3. Intra Process Memory Corruptions due to Wrong COW (FOLL_PIN)
> 
>   page_maybe_dma_pinned() is used to check if a page may be pinned for
>   DMA (using FOLL_PIN instead of FOLL_GET). While false positives are
>   tolerable, false negatives are problematic: pages that are pinned for
>   DMA must not be added to the swapcache. If it happens, the (now pinned)
>   page could be faulted back from the swapcache into page tables
>   read-only. Future write-access would detect the pinning and COW the
>   page, losing synchronicity. For the interested reader, this is nicely
>   documented in feb889fb40fa ("mm: don't put pinned pages into the swap
>   cache").
> 
>   Peter reports [8] that page_maybe_dma_pinned() as used is racy in some
>   cases and can result in a violation of the documented semantics:
>   giving false negatives because of the race.
> 
>   There are cases where we call it without properly taking a per-process
>   sequence lock, turning the usage of page_maybe_dma_pinned() racy. While
>   one case (clear_refs SOFTDIRTY tracking, see below) seems to be easy to
>   handle, there is especially one rmap case (shrink_page_list) that's hard
>   to fix: in the rmap world, we're not limited to a single process.
> 
>   The shrink_page_list() issue is really subtle. If we race with
>   someone pinning a page, we can trigger the same issue as in the FOLL_GET
>   case. See the detail section at the end of this mail on a discussion how
>   bad this can bite us with VFIO or other FOLL_PIN user.
> 
>   It's harder to reproduce, but I managed to modify the O_DIRECT
>   reproducer to use io_uring fixed buffers [15] instead, which ends up
>   using FOLL_PIN | FOLL_WRITE | FOLL_LONGTERM to pin buffer pages and can
>   similarly trigger a loss of synchronicity and consequently a memory
>   corruption.
> 
>   Again, the root issue is that a write-fault on a page that has
>   additional references results in a COW and thereby a loss of
>   synchronicity and consequently a memory corruption if two parties
>   believe they are referencing the same page.
> "
> 
> This series makes GUP pins (R/O and R/W) on anonymous pages fully reliable,
> especially also taking care of concurrent pinning via GUP-fast,
> for example, also fully fixing an issue reported regarding NUMA
> balancing [4] recently. While doing that, it further reduces "unnecessary
> COWs", especially when we don't fork()/KSM and don't swapout, and fixes the
> COW security for hugetlb for FOLL_PIN.
> 
> In summary, we track via a pageflag (PG_anon_exclusive) whether a mapped
> anonymous page is exclusive. Exclusive anonymous pages that are mapped
> R/O can directly be mapped R/W by the COW logic in the write fault handler.
> Exclusive anonymous pages that want to be shared (fork(), KSM) first have
> to mark a mapped anonymous page shared -- which will fail if there are
> GUP pins on the page. GUP is only allowed to take a pin on anonymous pages
> that is exclusive. The PT lock is the primary mechanism to synchronize
> modifications of PG_anon_exclusive. GUP-fast is synchronized either via the
> src_mm->write_protect_seq or via clear/invalidate+flush of the relevant
> page table entry.
> 
> Special care has to be taken about swap, migration, and THPs (whereby a
> PMD-mapping can be converted to a PTE mapping and we have to track
> information for subpages). Besides these, we let the rmap code handle most
> magic. For reliable R/O pins of anonymous pages, we need FAULT_FLAG_UNSHARE
> logic as part of our previous approach [2], however, it's now 100% mapcount
> free and I further simplified it a bit.
> 
>   #1 is a fix
>   #3-#7 are mostly rmap preparations for PG_anon_exclusive handling
>   #8 introduces PG_anon_exclusive
>   #9 uses PG_anon_exclusive and make R/W pins of anonymous pages
>    reliable
>   #10 is a preparation for reliable R/O pins
>   #11 and #12 is reused/modified GUP-triggered unsharing for R/O GUP pins
>    make R/O pins of anonymous pages reliable
>   #13 adds sanity check when (un)pinning anonymous pages
> 
> I'm not proud about patch #8, suggestions welcome. Patch #9 contains
> excessive explanations and the main logic for R/W pins. #11 and #12
> resemble what we proposed in the previous approach [2]. I consider the
> general approach of #13 very nice and helpful, and I remember Linus even
> envisioning something like that for finding BUGs, although we might want to
> implement the sanity checks eventually differently
> 
> It passes my growing set of tests for "wrong COW" and "missed COW",
> including the ones in [30 -- I'd really appreciate some experienced eyes
> to take a close look at corner cases. Only tested on x86_64, testing with
> CONT-mapped hugetlb pages on arm64 might be interesting.
> 
> Once we converted relevant users of FOLL_GET (e.g., O_DIRECT) to FOLL_PIN,
> the issue described in [3] under 2) will be fixed as well. Further, once
> that's in place we can streamline our COW logic for hugetlb to rely on
> page_count() as well and fix any possible COW security issues.

Hi,

I did excessive tests on aarch64 with CONT hugetlb pages yesterday and
didn't find any surprises, at least not in these changes. [1]

While thinking on how to get O_DIRECT fixed immediately, I realized the
following:
(1) This series turns FOLL_PIN on anonymous pages completely reliable,
    for any case of GUP+fork (GUP before fork, GUP during fork, GUP
    after fork in child/parent), which is pretty nice IMHO.
(2) For O_DIRECT and friends (FOLL_GET) we primarily care about fixing
    short-term FOLL_WRITE *without* fork(), which are the memory
    corruptions we're experiencing. Long-term FOLL_GET (meaning, even
    staying reliable after fork()) already has a bad smell to it.

Especially, (2) never worked reliably with fork() involved. I came to
the conclusion that this series pretty much fixes (2) already *except*
the swapout case. I might be wrong, but I think it should be possible to
handle that as well, meaning that: a FOLL_GET|FOLL_WRITE on an anonymous
page will be reliable as long as we don't fork().

I'm planning on sending a part3 to cover that, so we don't have to wait
for the FOLL_PIN conversion to get our O_DIRECT reproducers fixed. Stay
tuned.

If there isn't any more feedback, I'll be sending out a v1 soonish.


[1]
https://lkml.kernel.org/r/811c5c8e-b3a2-85d2-049c-717f17c3a03a@redhat.com


-- 
Thanks,

David / dhildenb

