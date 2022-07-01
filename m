Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B4562995
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiGADdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiGADdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:33:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B664D56
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:33:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so1439640pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0RbhlQu5Lj33FkKpTCALwxiT19xHuxjedeqLg966TRQ=;
        b=8MrRY8duJ7qkg1Etwk0C2j1flrSV8JYBfbsmEQJVtflyYRB752y9M2T1zr/iwyN3y6
         qxweo8PXtcRJA1SaMPA5mqRKlQOeit0nWhA8KqnWVZXU2F2XnNgpnAzkotLTo+3tex/P
         L4yeVoAtgdQte7oC6+Kv8YrZVGlItj7tXs2qRJFBe6yORJVMkIPr5nMSG+o9U6SzcL2g
         1PP7RDh0aNPCh5v4BvLB57F7uvNo4LLV/v1PocTM5bRFLcByLLus53P9MCcX7fJvWKmg
         Ke5S1AbWlSiNlgQ/e72cUmW9BkyCGg2HhseGkh5Lx7NtclInWKrqsPLq1WDQMWgkD4ZN
         yNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0RbhlQu5Lj33FkKpTCALwxiT19xHuxjedeqLg966TRQ=;
        b=Kng3/n8Z+KSrltOk7tSfvTQI66ULRhi32gmKMh0tVlYdVge+R56LTq3ToWkmi4foaS
         vKZ8c6t1EUBxB5SY3doqehS7XtvmKKhfNDIcYKPJO8iAplkZQFI37e+RNJ5PLTrXBryR
         3cqZSBaG/smXL9mvGDi2FxFS+l3wRLbdEsMXGQ39L/vCB3/CVhVfXxFvs/Dp/5IzIS5b
         VWuHJrTU+0nRqB/9QJohR6KfXbjf44uQu4xhFq2HEstXXHMgxBFcSxofjZ//BzHcMHan
         kNsB/7NEjbb1wvFvi2JfBKKHKlCVzdmYZ7RpqS5RJxBuGMFOAJPWgmEVzdGt1f6KKLYD
         ThaQ==
X-Gm-Message-State: AJIora+1xUB771pCMth9PtZqD3nODzMvjdwtRCzw4ykiCBxGSpFI/Kkt
        ITGDlM/vhxcxk9kvrXFeIZLxxQ==
X-Google-Smtp-Source: AGRyM1uVRCG88+A5TaUeokbKzEosxObBg5qSQ9Z1B0Iar7+QnbXU+ch3RBvpx8BytOT2FqON1yvh1g==
X-Received: by 2002:a17:90b:4c05:b0:1ef:203e:6da0 with SMTP id na5-20020a17090b4c0500b001ef203e6da0mr12556119pjb.227.1656646380164;
        Thu, 30 Jun 2022 20:33:00 -0700 (PDT)
Received: from smtpclient.apple ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g8-20020a62e308000000b005251ff30dccsm14321796pfh.160.2022.06.30.20.32.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 20:32:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an explicit
 shift argument.
From:   Muchun Song <songmuchun@bytedance.com>
In-Reply-To: <CADrL8HWuF-yXvgdJW7wWQSMU0GsRg3gttHykhV7=1VYSxfzkag@mail.gmail.com>
Date:   Fri, 1 Jul 2022 11:32:51 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhengqi.arch@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA7A662E-B266-42A8-AC51-C063F260A386@bytedance.com>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com> <YroYaWVvNZJvtqsH@monkey>
 <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net> <Yry+PPHSat2uN+aG@monkey>
 <CADrL8HX9OkuWzpODBzHx-6-7_SLJ1YCCe5HxXdPa4ibqeQZu3A@mail.gmail.com>
 <YrzRLVQaYtYAYsEa@monkey> <Yr1uUmfA/iWO740v@FVFYT0MHHV2J.usts.net>
 <CADrL8HWuF-yXvgdJW7wWQSMU0GsRg3gttHykhV7=1VYSxfzkag@mail.gmail.com>
To:     James Houghton <jthoughton@google.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 1, 2022, at 00:23, James Houghton <jthoughton@google.com> =
wrote:
>=20
> On Thu, Jun 30, 2022 at 2:35 AM Muchun Song <songmuchun@bytedance.com> =
wrote:
>>=20
>> On Wed, Jun 29, 2022 at 03:24:45PM -0700, Mike Kravetz wrote:
>>> On 06/29/22 14:39, James Houghton wrote:
>>>> On Wed, Jun 29, 2022 at 2:04 PM Mike Kravetz =
<mike.kravetz@oracle.com> wrote:
>>>>>=20
>>>>> On 06/29/22 14:09, Muchun Song wrote:
>>>>>> On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
>>>>>>> On 06/24/22 17:36, James Houghton wrote:
>>>>>>>> This is needed to handle PTL locking with high-granularity =
mapping. We
>>>>>>>> won't always be using the PMD-level PTL even if we're using the =
2M
>>>>>>>> hugepage hstate. It's possible that we're dealing with 4K PTEs, =
in which
>>>>>>>> case, we need to lock the PTL for the 4K PTE.
>>>>>>>=20
>>>>>>> I'm not really sure why this would be required.
>>>>>>> Why not use the PMD level lock for 4K PTEs? Seems that would =
scale better
>>>>>>> with less contention than using the more coarse mm lock.
>>>>>>>=20
>>>>>>=20
>>>>>> Your words make me thing of another question unrelated to this =
patch.
>>>>>> We __know__ that arm64 supports continues PTE HugeTLB. =
huge_pte_lockptr()
>>>>>> did not consider this case, in this case, those HugeTLB pages are =
contended
>>>>>> with mm lock. Seems we should optimize this case. Something like:
>>>>>>=20
>>>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>>>> index 0d790fa3f297..68a1e071bfc0 100644
>>>>>> --- a/include/linux/hugetlb.h
>>>>>> +++ b/include/linux/hugetlb.h
>>>>>> @@ -893,7 +893,7 @@ static inline gfp_t =
htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>>>>>> static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>>>>>> struct mm_struct *mm, pte_t *pte)
>>>>>> {
>>>>>> - if (huge_page_size(h) =3D=3D PMD_SIZE)
>>>>>> + if (huge_page_size(h) <=3D PMD_SIZE)
>>>>>> return pmd_lockptr(mm, (pmd_t *) pte);
>>>>>> VM_BUG_ON(huge_page_size(h) =3D=3D PAGE_SIZE);
>>>>>> return &mm->page_table_lock;
>>>>>>=20
>>>>>> I did not check if elsewhere needs to be changed as well. Just a =
primary
>>>>>> thought.
>>>>=20
>>>> I'm not sure if this works. If hugetlb_pte_size(hpte) is PAGE_SIZE,
>>>> then `hpte.ptep` will be a pte_t, not a pmd_t -- I assume that =
breaks
>>>> things. So I think, when doing a HugeTLB PT walk down to PAGE_SIZE, =
we
>>>> need to separately keep track of the location of the PMD so that we
>>>> can use it to get the PMD lock.
>>>=20
>>> I assume Muchun was talking about changing this in current code =
(before
>>> your changes) where huge_page_size(h) can not be PAGE_SIZE.
>>>=20
>>=20
>> Yes, that's what I meant.
>=20
> Right -- but I think my point still stands. If `huge_page_size(h)` is
> CONT_PTE_SIZE, then the `pte_t *` passed to `huge_pte_lockptr` will
> *actually* point to a `pte_t` and not a `pmd_t` (I'm pretty sure the

Right. It is a pte in this case.

> distinction is important). So it seems like we need to separately keep
> track of the real pmd_t that is being used in the CONT_PTE_SIZE case

If we want to find pmd_t from pte_t, I think we can introduce a new =
field
in struct page just like the thread [1] does.

[1] =
https://lore.kernel.org/lkml/20211110105428.32458-7-zhengqi.arch@bytedance=
.com/

> (and therefore, when considering HGM, the PAGE_SIZE case).
>=20
> However, we *can* make this optimization for CONT_PMD_SIZE (maybe this
> is what you originally meant, Muchun?), so instead of
> `huge_page_size(h) =3D=3D PMD_SIZE`, we could do `huge_page_size(h) >=3D=

> PMD_SIZE && huge_page_size(h) < PUD_SIZE`.

Right. It is a good start to optimize CONT_PMD_SIZE case.

Thanks.

>=20
>>=20
>> Thanks.

