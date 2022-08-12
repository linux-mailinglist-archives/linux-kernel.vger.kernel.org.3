Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B685590B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiHLFgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiHLFgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:36:39 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E79A97E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:36:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660282596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZuu4JKanrK9WtGq9SBh0Kx2qNswGCSgniVQ5SpQxP8=;
        b=mOXMTI68/7dNSrAZVku387J9GdZLyC8BLqHJ6m4r4dxBztgMLGQsHpyTRHTgftWypWrAgD
        cqulEYQBWXMy+oWO7LXaLZ07chXGEn4muUI36KK3grRQl8JOQEVDpQT/xc9yO4n02zik2i
        yYmfWAgdGRW2KI1FMnFFXqjJ5AHpXgc=
MIME-Version: 1.0
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <YvQzeUUvBVUYh8cn@monkey>
Date:   Fri, 12 Aug 2022 13:36:19 +0800
Cc:     Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0097C4FB-89B3-4CF5-9F61-D017CFE566BB@linux.dev>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
 <A74A816B-2EDD-411D-86F7-E7D5B507FAEE@linux.dev> <YvQzeUUvBVUYh8cn@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 11, 2022, at 06:38, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 08/10/22 14:20, Muchun Song wrote:
>>> On Aug 9, 2022, at 05:28, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>>>=20
>>> When creating hugetlb pages, the hugetlb code must first allocate
>>> contiguous pages from a low level allocator such as buddy, cma or
>>> memblock.  The pages returned from these low level allocators are
>>> ref counted.  This creates potential issues with other code taking
>>> speculative references on these pages before they can be transformed =
to
>>> a hugetlb page.  This issue has been addressed with methods and code
>>> such as that provided in [1].
>>>=20
>>> Recent discussions about vmemmap freeing [2] have indicated that it
>>> would be beneficial to freeze all sub pages, including the head page
>>> of pages returned from low level allocators before converting to a
>>> hugetlb page.  This helps avoid races if want to replace the page
>>> containing vmemmap for the head page.
>>>=20
>>> There have been proposals to change at least the buddy allocator to
>>> return frozen pages as described at [3].  If such a change is made, =
it
>>> can be employed by the hugetlb code.  However, as mentioned above
>>> hugetlb uses several low level allocators so each would need to be
>>> modified to return frozen pages.  For now, we can manually freeze =
the
>>> returned pages.  This is done in two places:
>>> 1) alloc_buddy_huge_page, only the returned head page is ref =
counted.
>>>  We freeze the head page, retrying once in the VERY rare case where
>>>  there may be an inflated ref count.
>>> 2) prep_compound_gigantic_page, for gigantic pages the current code
>>>  freezes all pages except the head page.  New code will simply =
freeze
>>>  the head page as well.
>>>=20
>>> In a few other places, code checks for inflated ref counts on newly
>>> allocated hugetlb pages.  With the modifications to freeze after
>>> allocating, this code can be removed.
>>>=20
>>> After hugetlb pages are freshly allocated, they are often added to =
the
>>> hugetlb free lists.  Since these pages were previously ref counted, =
this
>>> was done via put_page() which would end up calling the hugetlb
>>> destructor: free_huge_page.  With changes to freeze pages, we simply
>>> call free_huge_page directly to add the pages to the free list.
>>>=20
>>> In a few other places, freshly allocated hugetlb pages were =
immediately
>>> put into use, and the expectation was they were already ref counted. =
 In
>>> these cases, we must manually ref count the page.
>>>=20
>>> [1] =
https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@orac=
le.com/
>>> [2] =
https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@ora=
cle.com/
>>> [3] =
https://lore.kernel.org/linux-mm/20220531150611.1303156-1-willy@infradead.=
org/
>>>=20
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>> mm/hugetlb.c | 97 =
+++++++++++++++++++---------------------------------
>>> 1 file changed, 35 insertions(+), 62 deletions(-)
>>>=20
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 28516881a1b2..6b90d85d545b 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1769,13 +1769,12 @@ static bool =
__prep_compound_gigantic_page(struct page *page, unsigned int order,
>>> {
>>> 	int i, j;
>>> 	int nr_pages =3D 1 << order;
>>> -	struct page *p =3D page + 1;
>>> +	struct page *p =3D page;
>>>=20
>>> 	/* we rely on prep_new_huge_page to set the destructor */
>>> 	set_compound_order(page, order);
>>> -	__ClearPageReserved(page);
>>> 	__SetPageHead(page);
>>> -	for (i =3D 1; i < nr_pages; i++, p =3D mem_map_next(p, page, i)) =
{
>>> +	for (i =3D 0; i < nr_pages; i++, p =3D mem_map_next(p, page, i)) =
{
>>> 		/*
>>> 		 * For gigantic hugepages allocated through bootmem at
>>> 		 * boot, it's safer to be consistent with the =
not-gigantic
>>> @@ -1814,7 +1813,8 @@ static bool =
__prep_compound_gigantic_page(struct page *page, unsigned int order,
>>> 		} else {
>>> 			VM_BUG_ON_PAGE(page_count(p), p);
>>> 		}
>>> -		set_compound_head(p, page);
>>> +		if (i !=3D 0)
>>> +			set_compound_head(p, page);
>>> 	}
>>> 	atomic_set(compound_mapcount_ptr(page), -1);
>>> 	atomic_set(compound_pincount_ptr(page), 0);
>>> @@ -1918,6 +1918,7 @@ static struct page =
*alloc_buddy_huge_page(struct hstate *h,
>>> 	int order =3D huge_page_order(h);
>>> 	struct page *page;
>>> 	bool alloc_try_hard =3D true;
>>> +	bool retry =3D true;
>>>=20
>>> 	/*
>>> 	 * By default we always try hard to allocate the page with
>>> @@ -1933,7 +1934,21 @@ static struct page =
*alloc_buddy_huge_page(struct hstate *h,
>>> 		gfp_mask |=3D __GFP_RETRY_MAYFAIL;
>>> 	if (nid =3D=3D NUMA_NO_NODE)
>>> 		nid =3D numa_mem_id();
>>> +retry:
>>> 	page =3D __alloc_pages(gfp_mask, order, nid, nmask);
>>> +
>>> +	/* Freeze head page */
>>> +	if (!page_ref_freeze(page, 1)) {
>>=20
>> Hi Mike,
>>=20
>> I saw Mattew has introduced a new helper alloc_frozen_pages() in =
thread [1] to allocate a
>> frozen page. Then we do not need to handle an unexpected refcount =
case, which
>> should be easy. Is there any consideration why we do not choose =
alloc_frozen_pages()?
>=20
> I asked Matthew about these efforts before creating this patch.  At =
the
> time, there were issues with the first version of his patch series and
> he wasn't sure when he would get around to looking into those issues.
>=20
> I then decided to proceed with manually freezing pages after =
allocation.
> The thought was that alloc_frozen_pages() could be added when it =
became
> available.  The 'downstream changes' to deal with pages that have zero
> ref count should remain the same.  IMO, these downstream changes are =
the
> more important parts of this patch.
>=20
> Shortly after sending this patch, Matthew took another look at his
> series and discovered the source of issues.  He then sent this v2
> series.  Matthew will correct me if this is not accurate.

Thanks Mike, it is really clear to me.

>=20
>>=20
>> [1] =
https://lore.kernel.org/linux-mm/20220809171854.3725722-15-willy@infradead=
.org/T/#u
>>=20
>=20
> I am happy to wait until Matthew's series moves forward, and then use
> the new interface.

I agree. Let=E2=80=99s wait together.

Muchun

>=20
> --=20
> Mike Kravetz

