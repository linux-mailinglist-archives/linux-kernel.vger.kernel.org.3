Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C987A52FDFD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348653AbiEUPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245137AbiEUPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED57427B16
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653148324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MiSSwi9xuJZ/cdu5ca2FrAQepB/n8ZjvRH3BZI2eDME=;
        b=CgM5bmVSD8DBTqWRjDia3+wjOFnya8LHS05DuKpnx9tHqN9AYcdqmGtE1A/a43Vxq8Ze+s
        mv+gq0ceXxttYRL6IevqoAESblU9sDFJWWYkKNkAJKPbrYY1sljQ3urX5bg3Xr3ljCPXcQ
        AfADoKrP+rwGcLCcrPGbDk821NaevvE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-48mQRWDLPkSIb8RURku9Wg-1; Sat, 21 May 2022 11:52:03 -0400
X-MC-Unique: 48mQRWDLPkSIb8RURku9Wg-1
Received: by mail-ed1-f72.google.com with SMTP id s9-20020aa7d789000000b0042ab9d77febso7563158edq.16
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=MiSSwi9xuJZ/cdu5ca2FrAQepB/n8ZjvRH3BZI2eDME=;
        b=QE4wg+DK8gPqUmEkgaGcebrKZKI9YNG48jkMVWSAilmqrbUNWw39SkJjiq3jKFVomb
         jT+BnYpUQhQkQJ84wWX2FFw6RDUul/HLDB66coSHB0qNK9me9l7uHS3xAQdU16BTxURn
         txLhA0V1WJ9QMjXqHyGmo9bzxQqwkS1CubQW72td5Kg20cYAc0RlH/54ZGHddlnmORu4
         GhkICdK57uxqAmLAJqTMri+vL/GEaWblrF5JQr1kSZHU+4PM4R42U4KoyjUtQ6HqtzN8
         d/NpVqCObw2s4w4Ez8ktQzrc2yiLsqXS3C6VLW/zlr2l5YvVzwYI8cdFdN3ANa8w6XCW
         rClA==
X-Gm-Message-State: AOAM532XX4iNK9Vo/uTgVzKMFpbTjMzdpVWBkRUgAOjcARLKcBxnh9fe
        F3vXufA0gnvUwg0W/yWQyQ4s5rIELrciB3gXxEAVA90uS02ynxCxQgoyKK3DEP2THvwMdKSyTVX
        yCZMsGIpehE5p3xSlypM5bK3/
X-Received: by 2002:aa7:d38f:0:b0:42a:a2e6:90d9 with SMTP id x15-20020aa7d38f000000b0042aa2e690d9mr16029555edq.305.1653148321980;
        Sat, 21 May 2022 08:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4xkzaG+uCKjuzlqbWkg8yEWYTiB8UbHwNK2rqRkeJUZK5IAmfpUQKhgxr7TOVUyWMyhjOwQ==
X-Received: by 2002:aa7:d38f:0:b0:42a:a2e6:90d9 with SMTP id x15-20020aa7d38f000000b0042aa2e690d9mr16029531edq.305.1653148321697;
        Sat, 21 May 2022 08:52:01 -0700 (PDT)
Received: from [172.29.4.249] ([45.90.93.190])
        by smtp.gmail.com with ESMTPSA id c62-20020a509fc4000000b0042aae3f282esm5714786edf.65.2022.05.21.08.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 08:52:01 -0700 (PDT)
Message-ID: <b025ddd5-aca2-f3e2-6a4f-24a1b4eda985@redhat.com>
Date:   Sat, 21 May 2022 17:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
 <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
 <YognlSdHAKgnkPPY@google.com>
 <b36a728c-03a1-0e07-b6d2-9515e647416f@oracle.com>
 <YokEEAemXTwTSZh5@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
In-Reply-To: <YokEEAemXTwTSZh5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.22 17:24, Minchan Kim wrote:
> On Fri, May 20, 2022 at 05:04:22PM -0700, Mike Kravetz wrote:
>> On 5/20/22 16:43, Minchan Kim wrote:
>>> On Fri, May 20, 2022 at 04:31:31PM -0700, Mike Kravetz wrote:
>>>> On 5/20/22 15:56, John Hubbard wrote:
>>>>> On 5/20/22 15:19, Minchan Kim wrote:
>>>>>> The memory offline would be an issue so we shouldn't allow pinning of any
>>>>>> pages in *movable zone*.
>>>>>>
>>>>>> Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
>>>>>> problem to allow pinning on those area. The matter is what target range
>>>>>> on alloc_contig_range is backed by CMA or movable zone and usecases.
>>>>>>
>>>>>> IOW, movable zone should be never allowed. But CMA case, if pages
>>>>>> are used by normal process memory instead of hugeTLB, we shouldn't
>>>>>> allow longterm pinning since someone can claim those memory suddenly.
>>>>>> However, we are fine to allow longterm pinning if the CMA memory
>>>>>> already claimed and mapped at userspace(hugeTLB case IIUC).
>>>>>>
>>>>>
>>>>> From Mike's comments and yours, plus a rather quick reading of some
>>>>> CMA-related code in mm/hugetlb.c (free_gigantic_page(), alloc_gigantic_pages()), the following seems true:
>>>>>
>>>>> a) hugetlbfs can allocate pages *from* CMA, via cma_alloc()
>>>>>
>>>>> b) while hugetlbfs is using those CMA-allocated pages, it is debatable
>>>>> whether those pages should be allowed to be long term pinned. That's
>>>>> because there are two cases:
>>>>>
>>>>>     Case 1: pages are longterm pinned, then released, all while
>>>>>             owned by hugetlbfs. No problem.
>>>>>
>>>>>     Case 2: pages are longterm pinned, but then hugetlbfs releases the
>>>>>             pages entirely (via unmounting hugetlbfs, I presume). In
>>>>>             this case, we now have CMA page that are long-term pinned,
>>>>>             and that's the state we want to avoid.
>>>>
>>>> I do not think case 2 can happen.  A hugetlb page can only be changed back
>>>> to 'normal' (buddy) pages when ref count goes to zero.
>>>>
>>>> It should also be noted that hugetlb code sets up the CMA area from which
>>>> hugetlb pages can be allocated.  This area is never unreserved/freed.
>>>>
>>>> I do not think there is a reason to disallow long term pinning of hugetlb
>>>> pages allocated from THE hugetlb CMA area.

Hm. We primarily use CMA for gigantic pages only IIRC. Ordinary huge
pages come via the buddy.

Assume we allocated a (movable) 2MiB huge page ordinarily via the buddy
and it ended up on that CMA area by pure luck (as it's movable). If we'd
allow to pin it long-term, allocating a gigantic page from the
designated CMA area would fail.

So we'd want to allow long-term pinning a gigantic page but we'd not
want to allow long-term pinning an ordinary huge page. We'd want to
migrate the latter away.


The general rules are:

ZONE_MOVABLE: nobody is allowed to place unmovable allocations there; it
could prevent memory offlining/unplug.

CMA: nobody *but the designated owner* is allowed to place unmovable
memory there; it could prevent the actual owner to allocate contiguous
memory.

As explained above, it gets a bit weird if the owner (hugetlb) deals
with different allocation types (huge vs. gigantic pages).
>> Unless I do not understand, normal movable memory allocations can fall
>> back to CMA areas?

Yes, just like ZONE_MOVABLE IIRC.

> 
> In the case, Yes, it would be fallback if gfp_flag was __GFP_MOVABLE.
> 
> If HugeTLB support it(I think so), pin_user_pages with FOLL_LONGTERM
> will migrate the page out of movable/CMA before the longterm pinning
> so IMHO, we shouldn't have the problem.

As explained, the tricky bit would be hitting a gigantic page that's
valid to reside permanently on the designated CMA area. IIRC, some
gigantic pages are indeed movable, but we never place them on
ZONE_MOVABLE because migration is unlikely to work in practice.


-- 
Thanks,

David / dhildenb

