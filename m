Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E784D2998
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiCIHii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiCIHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:38:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 298B92717
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646811451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xqkH3oVL9p4jfQYfTW2XbKPGZRPmKZlORb9Agr/qsY=;
        b=DavUelJ4QtQNibaJO6guAnABk+fHNwgYXtKCEJJ+gU/vxapVZ8iASwxSqxuyxw3mpYxs27
        B/EP0abFMmvkuwayHBfWMbrFYdCkMFfXC7FEkRGw0QdVmBzCVaBCA4zZt9HGxq7Y3o0dsi
        HxjisDneR2X8MSEpEBxkIlk841xl3jk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-qxQ7kbzUN7CGKUF4QGD80g-1; Wed, 09 Mar 2022 02:37:30 -0500
X-MC-Unique: qxQ7kbzUN7CGKUF4QGD80g-1
Received: by mail-wm1-f72.google.com with SMTP id 3-20020a05600c230300b00384e15ceae4so2233448wmo.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 23:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=/xqkH3oVL9p4jfQYfTW2XbKPGZRPmKZlORb9Agr/qsY=;
        b=DAC/iNP6YycRay6ArlCxkodXoeNSRyeOfC/kaTb9MNGcXs8HzDU5bFCw+T370TALag
         yW32q8JIIdznTSsq5+LBWOljxhFSx1cFcVRzZPDjwyz/RcHcf6GOJnoutSltf7mEXxwI
         U54GAXQwEm6+/lvs20YsOl2XQ8953iur3VzagfTF4IFtm+06qW26Q2lUhNZTUZsrEXJm
         eL7M9iLyWGToTkm+4smwLdYVuKGPJaJPkb86v3j0j6unl5zVU0wAPjmQVj8b3FY+1Mvm
         uQjeBzvrnLs6LcJa39iclnpjfN4Ym6y1GI6Qj1j7GOH4n+d9++W7rFzPRPy99nMauy21
         AZ7A==
X-Gm-Message-State: AOAM530f4RsWSDfhZYoIE3KwxC5z9S1cYhxuTEX52heQjEjFZYEo8dmz
        V567KTgQUds8gIrHZAWcxwd+BuE8H3A52r5xOrnOD6nrHL63NpLGyn8a52mRZzc7jrLPeC4tjDT
        6mXz/siwqloZZYPsmwjuikc5q
X-Received: by 2002:a5d:4b85:0:b0:1f0:9661:9263 with SMTP id b5-20020a5d4b85000000b001f096619263mr14688742wrt.574.1646811449045;
        Tue, 08 Mar 2022 23:37:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOlrviz9RjlGPBY0KzahPHU9TEBH8kOrTT9CDYYf1GGPqDEUq7J2Nna3VzMSPJn958D/4mRA==
X-Received: by 2002:a5d:4b85:0:b0:1f0:9661:9263 with SMTP id b5-20020a5d4b85000000b001f096619263mr14688700wrt.574.1646811448671;
        Tue, 08 Mar 2022 23:37:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6300:8418:c653:d01f:3bd2? (p200300cbc70763008418c653d01f3bd2.dip0.t-ipconnect.de. [2003:cb:c707:6300:8418:c653:d01f:3bd2])
        by smtp.gmail.com with ESMTPSA id m11-20020adff38b000000b001ef879a5930sm890520wro.61.2022.03.08.23.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 23:37:28 -0800 (PST)
Message-ID: <89ae59de-5b74-22b6-0076-c1a9a6fa62e7@redhat.com>
Date:   Wed, 9 Mar 2022 08:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <461e4d2b-9aa2-50d4-2c78-3f7fb3f6a2f6@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 12/13] mm/gup: trigger FAULT_FLAG_UNSHARE when
 R/O-pinning a possibly shared anonymous page
In-Reply-To: <461e4d2b-9aa2-50d4-2c78-3f7fb3f6a2f6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.22 09:06, David Hildenbrand wrote:
> On 03.03.22 02:47, John Hubbard wrote:
>> On 3/2/22 12:38, David Hildenbrand wrote:
>> ...
>>> BUT, once we actually write to the private mapping via the page table,
>>> the GUP pin would go out of sync with the now-anonymous page mapped into
>>> the page table. However, I'm having a hard time answering what's
>>> actually expected?
>>>
>>> It's really hard to tell what the user wants with MAP_PRIVATE file
>>> mappings and stumbles over a !anon page (no modifications so far):
>>>
>>> (a) I want a R/O pin to observe file modifications.
>>> (b) I want the R/O pin to *not* observe file modifications but observe
>>>      my (eventual? if any) private modifications,
>>>
>>
>> On this aspect, I think it is easier than trying to discern user
>> intentions. Because it is less a question of what the user wants, and
>> more a question of how mmap(2) is specified. And the man page clearly
>> indicates that the user has no right to expect to see file
>> modifications. Here's the excerpt:
>>
>> "MAP_PRIVATE
>> 	
>> Create  a private copy-on-write mapping.  Updates to the mapping are not
>> visible to other processes mapping the same file, and are not carried
>> through to the underlying file.  It is unspecified whether changes  made
>> to the file after the mmap() call are visible in the mapped region.
>> "
>>
>>> Of course, if we already wrote to that page and now have an anon page,
>>> it's easy: we are already no longer following file changes.
>>
>> Yes, and in fact, I've always thought that the way this was written
>> means that it should be treated as a snapshot of the file contents,
>> and no longer reliably connected in either direction to the page(s).
> 
> Thanks John, that's extremely helpful. I forgot about these MAP_PRIVATE
> mmap() details -- they help a lot to clarify which semantics to provide.
> 
> So what we could do is:
> 
> a) Extend FAULT_FLAG_UNSHARE to also unshare an !anon page in
>    a MAP_RPIVATE mapping, replacing it with an (exclusive) anon page.
>    R/O PTE permissions are maintained, just like unsharing in the
>    context of this series.
> 
> b) Similarly trigger FAULT_FLAG_UNSHARE from GUP when trying to take a
>    R/O pin (FOLL_PIN) on a R/O-mapped !anon page in a MAP_PRIVATE
>    mapping.
> 
> c) Make R/O pins consistently use "FOLL_PIN" instead, getting rid of
>    FOLL_FORCE|FOLL_WRITE.
> 
> 
> Of course, we can't detect MAP_PRIVATE vs. MAP_SHARED in GUP-fast (no
> VMA), so we'd always have to fallback in GUP-fast in case we intend to
> FOLL_PIN a R/O-mapped !anon page. That would imply that essentially any
> R/O pins (FOLL_PIN) would have to fallback to ordinary GUP. BUT, I mean
> we require FOLL_FORCE|FOLL_WRITE right now, which is not any different,
> so ...
> 
> One optimization would be to trigger b) only for FOLL_LONGTERM. For
> !FOLL_LONGTERM there are "in theory" absolutely no guarantees which data
> will be observed if we modify concurrently to e.g., O_DIRECT IMHO. But
> that would require some more thought.
> 
> Of course, that's all material for another journey, although it should
> be mostly straight forward.
> 

Just a slight clarification after stumbling over shared zeropage code in
follow_page_pte(): we do seem to support pinning the shared zeropage at
least on the GUP-slow path. While I haven't played with it, I assume
we'd have to implement+trigger unsharing in case we'd want to take a R/O
pin on the shared zeropage.

Of course, similar to file-backed MAP_PRIVATE handling, this is out of
the scope of this series ("This change implies that whenever user space
wrote to a private mapping (IOW, we have an anonymous page mapped), that
GUP pins will
always remain consistent: reliable R/O GUP pins of anonymous pages.").

-- 
Thanks,

David / dhildenb

