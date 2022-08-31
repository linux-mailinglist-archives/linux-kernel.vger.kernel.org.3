Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629E25A788A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiHaIHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiHaIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99696BCE8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661933256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSnF52SfmuOINnaqDpTQuzzr8jWMSKcPsAm32mHJfIw=;
        b=Vj6yG0b9figFZ30UB2iBOu4ncsDX4CQkANM7rrdT7wW+vKqy77RJSx6D8PMczbBNgXar5n
        Dhy64/CPQWMXbaWupnhOM5MC4RWJLNZqevFBrL9BsUd7fayna08yOHYEg9MrrpZFIcZhN7
        lQILzdkX8WastRyLO/nCjhB4e9ZGwcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-4pGQfj10MeKDKpXsOTUSBw-1; Wed, 31 Aug 2022 04:07:27 -0400
X-MC-Unique: 4pGQfj10MeKDKpXsOTUSBw-1
Received: by mail-wm1-f69.google.com with SMTP id n7-20020a1c2707000000b003a638356355so7961378wmn.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=qSnF52SfmuOINnaqDpTQuzzr8jWMSKcPsAm32mHJfIw=;
        b=lxJcE/dVaEq36xY6TJucyNDxDQNT8s4WukC7Dxq1nebYJwYawct73hAfK8JdZ0L8Lc
         Pvd2iqMh6gCH8UJ+7I6BiCZbexP6KDHkfmjjxqKaUifIN/NV6jHt4ZA0qi4yEG4p8YGv
         11uD9k6k7ZeN36MsSQ1lB5jlzoy4ImHq6XfOjIKXWsMz1ehU7tDOhT7DRHJzhq20WHYd
         uV6ieod0vBuRAELat4fhMkixQcC3TmjxSLLrtBpD9a81aGb7ejL2BmAonvklwAuugmUb
         +/NCkJB3lNMKS5Qb0gT12pb7tzMkIvrxKJ78Uw0SsPbpuQnIqctAhxrfzXDSE8H2qR5j
         oo+Q==
X-Gm-Message-State: ACgBeo1KEDUg27gEcuArPicF+gNRMQ8bScXOP548RiwSKA4/RBhszJgx
        BciOHFzEItMG2p5vaHUBs6T1Rh30BvzZtbW/+STQuaEpAXv1eOvgMUwdr+4PRs9LMiX0y375Eju
        1F19PKGgg8S0BemHj2BGWFlUr
X-Received: by 2002:a5d:6609:0:b0:226:ced9:be58 with SMTP id n9-20020a5d6609000000b00226ced9be58mr10588873wru.80.1661933246546;
        Wed, 31 Aug 2022 01:07:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+zr9SDOfnc1BY3rtMb1gu5hLqgKvvag/QnKqwKnaFC0qeDT8qfFIWYdUn7DntJxak7IMJmg==
X-Received: by 2002:a5d:6609:0:b0:226:ced9:be58 with SMTP id n9-20020a5d6609000000b00226ced9be58mr10588845wru.80.1661933246233;
        Wed, 31 Aug 2022 01:07:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b002253fd19a6asm13439906wrh.18.2022.08.31.01.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 01:07:25 -0700 (PDT)
Message-ID: <739dc825-ece3-a59f-adc5-65861676e0ae@redhat.com>
Date:   Wed, 31 Aug 2022 10:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <608934d4-466d-975e-6458-34a91ccb4669@redhat.com> <Yw5AOZ/Kc5f3UP+s@monkey>
 <Yw6Bpsow+gUMlHCU@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
In-Reply-To: <Yw6Bpsow+gUMlHCU@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 23:31, Mike Kravetz wrote:
> On 08/30/22 09:52, Mike Kravetz wrote:
>> On 08/30/22 10:11, David Hildenbrand wrote:
>>> On 30.08.22 01:40, Mike Kravetz wrote:
>>>> During discussions of this series [1], it was suggested that hugetlb
>>>> handling code in follow_page_mask could be simplified.  At the beginning
>>>
>>> Feel free to use a Suggested-by if you consider it appropriate.
>>>
>>>> of follow_page_mask, there currently is a call to follow_huge_addr which
>>>> 'may' handle hugetlb pages.  ia64 is the only architecture which provides
>>>> a follow_huge_addr routine that does not return error.  Instead, at each
>>>> level of the page table a check is made for a hugetlb entry.  If a hugetlb
>>>> entry is found, a call to a routine associated with that entry is made.
>>>>
>>>> Currently, there are two checks for hugetlb entries at each page table
>>>> level.  The first check is of the form:
>>>> 	if (p?d_huge())
>>>> 		page = follow_huge_p?d();
>>>> the second check is of the form:
>>>> 	if (is_hugepd())
>>>> 		page = follow_huge_pd().
>>>
>>> BTW, what about all this hugepd stuff in mm/pagewalk.c?
>>>
>>> Isn't this all dead code as we're essentially routing all hugetlb VMAs
>>> via walk_hugetlb_range? [yes, all that hugepd stuff in generic code that
>>> overcomplicates stuff has been annoying me for a long time]
>>
>> I am 'happy' to look at cleaning up that code next.  Perhaps I will just
>> create a cleanup series.
>>
> 
> Technically, that code is not dead IIUC.  The call to walk_hugetlb_range in
> __walk_page_range is as follows:
> 
> 	if (vma && is_vm_hugetlb_page(vma)) {
> 		if (ops->hugetlb_entry)
> 			err = walk_hugetlb_range(start, end, walk);
> 	} else
> 		err = walk_pgd_range(start, end, walk);
> 
> We also have the interface walk_page_range_novma() that will call
> __walk_page_range without a value for vma.  So, in that case we would
> end up calling walk_pgd_range, etc.  walk_pgd_range and related routines
> do have those checks such as:
> 
> 		if (is_hugepd(__hugepd(pmd_val(*pmd))))
> 			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
> 
> So, it looks like in this case we would process 'hugepd' entries but not
> 'normal' hugetlb entries.  That does not seem right.

:/ walking a hugetlb range without knowing whether it's a hugetlb range
is certainly questionable.


> 
> Christophe Leroy added this code with commit e17eae2b8399 "mm: pagewalk: fix
> walk for hugepage tables".  This was part of the series "Convert powerpc to
> GENERIC_PTDUMP".  And, the ptdump code uses the walk_page_range_novma
> interface.  So, this code is certainly not dead.

Hm, that commit doesn't actually mention how it can happen, what exactly
will happen ("crazy result") and if it ever happened.

> 
> Adding Christophe on Cc:
> 
> Christophe do you know if is_hugepd is true for all hugetlb entries, not
> just hugepd?
> 
> On systems without hugepd entries, I guess ptdump skips all hugetlb entries.
> Sigh!

IIUC, the idea of ptdump_walk_pgd() is to dump page tables even outside
VMAs (for debugging purposes?).

I cannot convince myself that that's a good idea when only holding the
mmap lock in read mode, because we can just see page tables getting
freed concurrently e.g., during concurrent munmap() ... while holding
the mmap lock in read we may only walk inside VMA boundaries.

That then raises the questions if we're only calling this on special MMs
(e.g., init_mm) whereby we cannot really see concurrent munmap() and
where we shouldn't have hugetlb mappings or hugepd entries.

-- 
Thanks,

David / dhildenb

