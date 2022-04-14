Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4250078F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiDNHxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiDNHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:53:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2692E6B6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:51:09 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220414075104euoutp01593845ab639bacd9a9a634b532ac4708~ls_vagyg52596225962euoutp01R
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220414075104euoutp01593845ab639bacd9a9a634b532ac4708~ls_vagyg52596225962euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649922664;
        bh=FHNPu6lhFxsecxvMMbBu743VHPqgteK0qVhD3aQWuTw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=fheGvunwJWf/TUg8iO2N0LfcvQGO2Y+7fcgQtajRB6fCv0en/ymWsJiDH4Jen2Rpk
         0/VmJzsf1bNfljXbtt4t9fs0ZHJfw+1YVRDGIYQG1J7Nx6RRY2g4FelwJwSS19wnbR
         ljWLM3OahYhjm66epYUpCn1DeYPqVnUVazch4hZs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220414075103eucas1p13eafd1b1ffaa5591dc34e5ab6990ae2c~ls_u8kgOa2196821968eucas1p1O;
        Thu, 14 Apr 2022 07:51:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.C0.09887.762D7526; Thu, 14
        Apr 2022 08:51:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220414075102eucas1p22a41734bf97d28ebd46cab85ab06050d~ls_uQ0_YH0191901919eucas1p2T;
        Thu, 14 Apr 2022 07:51:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220414075102eusmtrp1d0f7dcc5096cc2f01404f8ca3a227210~ls_uP5qBu2606026060eusmtrp1C;
        Thu, 14 Apr 2022 07:51:02 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-93-6257d2674608
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 98.FA.09522.662D7526; Thu, 14
        Apr 2022 08:51:02 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220414075101eusmtip2630d1b6f1e479ec632b2701463bd3616~ls_tcn9231041510415eusmtip2b;
        Thu, 14 Apr 2022 07:51:01 +0000 (GMT)
Message-ID: <6ccf5f5f-8dc5-16cc-f06c-78401b822a54@samsung.com>
Date:   Thu, 14 Apr 2022 09:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Ylb9rXJyPm8/ao8f@xz-m1.local>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7rpl8KTDD6fkbNYsH4pu8Wc9WvY
        LHbdCLHYd+U3q8XX9b+YLZ5+6mOxmD39BZPFmokLmS0u75rDZnFvzX9Wi4/7gy0Ofl3MaLFl
        /zd2i1mHpS1+/5jD5sDvsXPWXXaPBZtKPTav0PLY9GkSu8eJGb9ZPB4c2szi0dv8js3j49Nb
        LB7v911l85jd95TJ4/MmuQDuKC6blNSczLLUIn27BK6MhWcfMRZcVaiY82EHawPjAakuRk4O
        CQETiRdtHaxdjFwcQgIrGCV2bdzCBuF8YZRYsnsrM0iVkMBnRonfrV4wHT2H/kMVLWeU+DXz
        LwuE85FR4sqD50wgVbwCdhKXr5xlA7FZBFQlvm57ABUXlDg58wkLiC0qkCQxd989sA3CAt4S
        L7ZOB7OZBcQlbj2ZD1YvIqAg8av5FNgCZoGZLBLvD+0Aa2YTMJToetsFtoBTQFviRc8tFohm
        eYntb+cwgzRICBzmlHhwaw4rxN0uEuteHGOHsIUlXh3fAmXLSJye3APUzAFk50v8nWEMEa6Q
        uPZ6DTOEbS1x59wvNpASZgFNifW79CHCjhJX3/9lg+jkk7jxVhDiAj6JSdtAXgEJ80p0tAlB
        VKtJzDq+Dm7nwQuXmCcwKs1CCpRZSJ6fheSXWQh7FzCyrGIUTy0tzk1PLTbKSy3XK07MLS7N
        S9dLzs/dxAhMgaf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8N7sD08S4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwNR938H3uOP61IQXB94fOXvrTEie56wv
        gkvL/0rNdPngXLvHfJcPR9bB1HtSH4s/dCnEXinJ4Lr1nr3D/slCt3nLO6V1t+3PX5DBvOGX
        +I7jP6TFzYMnvCrieR3dvO+Z2KQ2x5m6iwWee1gbtzywTfi/68flzTwmHrPOftih5zN/zVsl
        5+0ltp/7H4c2fKlexTbl3D3j4EvB/pdDdEWn1myoejkjsvh77rRjf+6zXTCtt9++m/nVxNu5
        1mVRzxudTE5t2LxZ/ojNz2uxx4J4+P5sf2m2ZdfLdKU7tu1OdVYVu6feu7LNm1dUaqezylXH
        /UztbBM/uel4B1/c3viKs6nqWaeCmv/RI4Fmub+q/roosRRnJBpqMRcVJwIA6rF7XvADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xe7ppl8KTDA4d1LRYsH4pu8Wc9WvY
        LHbdCLHYd+U3q8XX9b+YLZ5+6mOxmD39BZPFmokLmS0u75rDZnFvzX9Wi4/7gy0Ofl3MaLFl
        /zd2i1mHpS1+/5jD5sDvsXPWXXaPBZtKPTav0PLY9GkSu8eJGb9ZPB4c2szi0dv8js3j49Nb
        LB7v911l85jd95TJ4/MmuQDuKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MhWcfMRZcVaiY82EHawPjAakuRk4OCQETiZ5D/9m6GLk4hASWMko8
        3NzMDpGQkTg5rYEVwhaW+HOtC6roPaPE2UWT2UASvAJ2EpevnAWzWQRUJb5ue8AEEReUODnz
        CQuILSqQJPFi23NGEFtYwFvixdbpzCA2s4C4xK0n88HqRQQUJH41n2IBWcAsMJdF4s2Uq2BX
        CAn0Mkns/OcEYrMJGEp0ve0CW8YpoC3xoucWC8QgM4murV2MELa8xPa3c5gnMArNQnLHLCT7
        ZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAyN927OfmHYzzXn3UO8TIxMF4
        iFGCg1lJhPdmf3iSEG9KYmVValF+fFFpTmrxIUZTYGBMZJYSTc4Hpp68knhDMwNTQxMzSwNT
        SzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmdqXjq9YJHDqb6BYs9/fyzQkx+5/crdVh
        Ph727GvQOZ0l+wsdk2LS12n1dC2LeaZwiN38iZZ4reVasSL/iGqW350PSr7GZ3rETH5rfPfp
        tYPcX42e1oodWvCgU6M278PSkHk/nk45e3WpjO+Lr5bbMqe9M7xnfq9dwf1V7wvnvW57Hj3d
        GdnWepor0GHSzFWPp2WtqTrrfoQ96qbh6TcBR++qmcQu51wr9GSbzbxfJjEpv9r61VQsvuko
        2th9WXzefK9Pl/jnCycn7RSRDl1z493SbSduci9XUbfNWxheaLB8bpoL02xVYf6b6yI/aTDc
        6Nv6J3wa7zKeXfzXpi68cKdnsvHH/Swf5Nb7ZSaKmyixFGckGmoxFxUnAgDqYFaChQMAAA==
X-CMS-MailID: 20220414075102eucas1p22a41734bf97d28ebd46cab85ab06050d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220413140330eucas1p167da41e079712b829ef8237dc27b049c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220413140330eucas1p167da41e079712b829ef8237dc27b049c
References: <20220405014646.13522-1-peterx@redhat.com>
        <20220405014836.14077-1-peterx@redhat.com>
        <CGME20220413140330eucas1p167da41e079712b829ef8237dc27b049c@eucas1p1.samsung.com>
        <710c48c9-406d-e4c5-a394-10501b951316@samsung.com>
        <Ylb9rXJyPm8/ao8f@xz-m1.local>
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 13.04.2022 18:43, Peter Xu wrote:
> On Wed, Apr 13, 2022 at 04:03:28PM +0200, Marek Szyprowski wrote:
>> On 05.04.2022 03:48, Peter Xu wrote:
>>> We used to check against none pte in finish_fault(), with the assumption
>>> that the orig_pte is always none pte.
>>>
>>> This change prepares us to be able to call do_fault() on !none ptes.  For
>>> example, we should allow that to happen for pte marker so that we can restore
>>> information out of the pte markers.
>>>
>>> Let's change the "pte_none" check into detecting changes since we fetched
>>> orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
>>> the pgtable we may not initialize orig_pte at all in handle_pte_fault().
>>>
>>> By default orig_pte will be all zeros however the problem is not all
>>> architectures are using all-zeros for a none pte.  pte_clear() will be the
>>> right thing to use here so that we'll always have a valid orig_pte value
>>> for the whole handle_pte_fault() call.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> This patch landed in today's linux next-202204213 as commit fa6009949163
>> ("mm: check against orig_pte for finish_fault()"). Unfortunately it
>> causes serious system instability on some ARM 32bit machines. I've
>> observed it on all tested boards (various Samsung Exynos based,
>> Raspberry Pi 3b and 4b, even QEMU's virt 32bit machine) when kernel was
>> compiled from multi_v7_defconfig.
> Thanks for the report.
>
>> Here is a crash log from QEMU's ARM 32bit virt machine:
>>
>> 8<--- cut here ---
>> Unable to handle kernel paging request at virtual address e093263c
>> [e093263c] *pgd=42083811, *pte=00000000, *ppte=00000000
>> Internal error: Oops: 807 [#1] SMP ARM
>> Modules linked in:
>> CPU: 1 PID: 37 Comm: kworker/u4:0 Not tainted
>> 5.18.0-rc2-00176-gfa6009949163 #11684
>> Hardware name: Generic DT based system
>> PC is at cpu_ca15_set_pte_ext+0x4c/0x58
>> LR is at handle_mm_fault+0x46c/0xbb0
> I had a feeling that for some reason the pte_clear() isn't working right
> there when it's applying to a kernel stack variable for arm32.  I'm totally
> newbie to arm32, so what I'm reading is this:
>
> https://people.kernel.org/linusw/arm32-page-tables
>
> Especially:
>
> https://protect2.fireeye.com/v1/url?k=35bc90ac-6a27a9bd-35bd1be3-0cc47a31cdbc-b032cb1d178dc691&q=1&e=c82daefb-c86b-4ca1-8db1-cadbdc124ed2&u=https%3A%2F%2Fdflund.se%2F%7Etriad%2Fimages%2Fclassic-mmu-page-table.jpg
>
> It does match with what I read from arm32's proc-v7-2level.S of it, where
> from the comment above cpu_v7_set_pte_ext:
>
>    * - ptep  - pointer to level 2 translation table entry
>    *    (hardware version is stored at +2048 bytes)        <----------
>
> So it seems to me that arm32 needs to store some metadata at offset 0x800
> of any pte_t* pointer passed over to pte_clear(), then it must be a real
> pgtable or it'll write to random places in the kernel, am I correct?
>
> Does it mean that all pte_*() operations upon a kernel stack var will be
> wrong?  I thought it could happen easily in the rest of mm too but I didn't
> yet check much.  The fact shows that it's mostly possible the current code
> just work well with arm32 and no such violation occured yet.
>
> That does sound a bit tricky, IMHO.  But I don't have an immediate solution
> to make it less tricky.. though I have a thought of workaround, by simply
> not calling pte_clear() on the stack var.
>
> Would you try the attached patch to replace this problematic patch? So we
> need to revert commit fa6009949163 and apply the new one.  Please let me
> know whether it'll solve the problem, so far I only compile tested it, but
> I'll run some more test to make sure the uffd-wp scenarios will be working
> right with the new version.

I've reverted fa6009949163 and applied the attached patch on top of 
linux next-20220314. The ARM 32bit issues went away. :)

Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

