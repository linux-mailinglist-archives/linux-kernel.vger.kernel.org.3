Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8635E4CB84A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiCCIGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiCCIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A8AF16F946
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646294768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+18ccVHSZPVWlkZVYCx2J+hQLbKBpCK4Sp27aR5tQA=;
        b=Mp7CA32XBwiWYF1EgS1sTooFq/xqKZN7BJopTf7xkvBzlCsSCsGIbpd+kqO2Ao093poQF2
        W3gTo/KHsrSkJ4IE57jY1+rcIHWbyZ3Oe2h5aq4MYV8Fi+atUrMjxkODU3Ty/TpvattS7j
        Iwn6lyNVYCTY6gwVA3ss6SzcsBOg0ks=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-IpOpfMLaPhy2eGqvsI5Tig-1; Thu, 03 Mar 2022 03:06:05 -0500
X-MC-Unique: IpOpfMLaPhy2eGqvsI5Tig-1
Received: by mail-wm1-f70.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso2895679wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=O+18ccVHSZPVWlkZVYCx2J+hQLbKBpCK4Sp27aR5tQA=;
        b=Uf8dnV1oskgViJ1QVv0Y0mjiHN/f2eui++naemFDIA1XP632cC9kaSvkfuv5mFJ4yC
         BmXJ6Uaq90I9qmnEnLXbDJKpdvCQcikLAXHomljFgiVhcoyMgS4f1Netehza/opjRrMD
         Q8eY5eoemqCDJ34nST5CHtAxKkdpkFIQFtflatEsW87SKYu0YesAhl5hoav9d9mEyGdo
         no7gRISqCGprUt53GXWRxxmZNejBAxux25uu068dj3dqJ4VZR7Sanw2GtxhT0gS/uyJ/
         Tuo6O+M9AdSh/E8zDQAhGjxbOMrkDUMWsFSvNECAF783dQjbbLMouF6b5CO0ggtI5GWc
         L7TA==
X-Gm-Message-State: AOAM533ALpOFdAMMbg37vy1JCQzkNNwcChKCrzCWuQizt07pfLV8z0JD
        s28uS0GvVCYjsI+fdLtHK7zc6HZ696h1OGcBVUW4OLqWcALEGcM+4/6Jq4g0KFnU8r2n4EcOu9U
        nX3OZ4F4iS/qMJqUh7OB8PGS9
X-Received: by 2002:a1c:2644:0:b0:381:10f:503 with SMTP id m65-20020a1c2644000000b00381010f0503mr2758710wmm.188.1646294764253;
        Thu, 03 Mar 2022 00:06:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBSCJejeZJTX7rxYuswh4iEdesD4zS33EME8Lxvp5LQCRJwDndCVEPQpFlIXC0CKjKrPt6EA==
X-Received: by 2002:a1c:2644:0:b0:381:10f:503 with SMTP id m65-20020a1c2644000000b00381010f0503mr2758674wmm.188.1646294763867;
        Thu, 03 Mar 2022 00:06:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:3600:f39a:d830:baab:42f0? (p200300cbc7063600f39ad830baab42f0.dip0.t-ipconnect.de. [2003:cb:c706:3600:f39a:d830:baab:42f0])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm1293716wrs.16.2022.03.03.00.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:06:03 -0800 (PST)
Message-ID: <461e4d2b-9aa2-50d4-2c78-3f7fb3f6a2f6@redhat.com>
Date:   Thu, 3 Mar 2022 09:06:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-13-david@redhat.com>
 <20220302165559.GU219866@nvidia.com>
 <fb895ba3-9d7e-7421-d5c6-f5e7a2d1231a@redhat.com>
 <0a159b65-cb80-c8eb-7ad1-24b83813531f@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 12/13] mm/gup: trigger FAULT_FLAG_UNSHARE when
 R/O-pinning a possibly shared anonymous page
In-Reply-To: <0a159b65-cb80-c8eb-7ad1-24b83813531f@nvidia.com>
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

On 03.03.22 02:47, John Hubbard wrote:
> On 3/2/22 12:38, David Hildenbrand wrote:
> ...
>> BUT, once we actually write to the private mapping via the page table,
>> the GUP pin would go out of sync with the now-anonymous page mapped into
>> the page table. However, I'm having a hard time answering what's
>> actually expected?
>>
>> It's really hard to tell what the user wants with MAP_PRIVATE file
>> mappings and stumbles over a !anon page (no modifications so far):
>>
>> (a) I want a R/O pin to observe file modifications.
>> (b) I want the R/O pin to *not* observe file modifications but observe
>>      my (eventual? if any) private modifications,
>>
> 
> On this aspect, I think it is easier than trying to discern user
> intentions. Because it is less a question of what the user wants, and
> more a question of how mmap(2) is specified. And the man page clearly
> indicates that the user has no right to expect to see file
> modifications. Here's the excerpt:
> 
> "MAP_PRIVATE
> 	
> Create  a private copy-on-write mapping.  Updates to the mapping are not
> visible to other processes mapping the same file, and are not carried
> through to the underlying file.  It is unspecified whether changes  made
> to the file after the mmap() call are visible in the mapped region.
> "
> 
>> Of course, if we already wrote to that page and now have an anon page,
>> it's easy: we are already no longer following file changes.
> 
> Yes, and in fact, I've always thought that the way this was written
> means that it should be treated as a snapshot of the file contents,
> and no longer reliably connected in either direction to the page(s).

Thanks John, that's extremely helpful. I forgot about these MAP_PRIVATE
mmap() details -- they help a lot to clarify which semantics to provide.

So what we could do is:

a) Extend FAULT_FLAG_UNSHARE to also unshare an !anon page in
   a MAP_RPIVATE mapping, replacing it with an (exclusive) anon page.
   R/O PTE permissions are maintained, just like unsharing in the
   context of this series.

b) Similarly trigger FAULT_FLAG_UNSHARE from GUP when trying to take a
   R/O pin (FOLL_PIN) on a R/O-mapped !anon page in a MAP_PRIVATE
   mapping.

c) Make R/O pins consistently use "FOLL_PIN" instead, getting rid of
   FOLL_FORCE|FOLL_WRITE.


Of course, we can't detect MAP_PRIVATE vs. MAP_SHARED in GUP-fast (no
VMA), so we'd always have to fallback in GUP-fast in case we intend to
FOLL_PIN a R/O-mapped !anon page. That would imply that essentially any
R/O pins (FOLL_PIN) would have to fallback to ordinary GUP. BUT, I mean
we require FOLL_FORCE|FOLL_WRITE right now, which is not any different,
so ...

One optimization would be to trigger b) only for FOLL_LONGTERM. For
!FOLL_LONGTERM there are "in theory" absolutely no guarantees which data
will be observed if we modify concurrently to e.g., O_DIRECT IMHO. But
that would require some more thought.

Of course, that's all material for another journey, although it should
be mostly straight forward.

-- 
Thanks,

David / dhildenb

