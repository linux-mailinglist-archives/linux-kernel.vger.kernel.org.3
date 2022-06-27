Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0973755CCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiF0HaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiF0HaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:30:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9926C4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:30:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so8588654pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T3JQxNLuvQFFoKNIfIZgs8zEjLxjZBsob8h8p5OweJg=;
        b=lPB+W2tSDMWq+1L6Am7ZFvdthx6ERZTQU2Tcm2Du9bBL/MpqvyM4QdD71l4J0zfZ52
         J2Nc9onLnJ7TV8e6TahECtPc0WqTNoJ5fFxojTV/a0npssD6smC/aMfJXkvq/hrLh1tu
         M/bd8DTleLjqT33mz+eABsaPHqgQL/UZYZbahhZ2jMixHH+0eR99kqb53s9Xvra8rlBE
         zKmMbVtVT6WwSkO5UbZ4zETbWUi8CUgzaCsDFGh4F+Uxb9m/6KLie3+q+R+1trDk8FmK
         7SKmF3vR6/OelynrUuU7gq1xwyBt3Y8EL9AyTkuYbfUdTsnM/1BpUIG3IWxYtX8fpYb8
         huvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T3JQxNLuvQFFoKNIfIZgs8zEjLxjZBsob8h8p5OweJg=;
        b=YnL8qvYLvFKk85ICpp1BBBx2gOnpTx0YOVRdmCfFc2Qc6X0ADLHjiL3c/NdWaoU+XQ
         MwkFggvWDC/6PDxlAGcQLox2oellW79/Farba/Qds5+MZljz0dsouf34eH5TKaSDfirf
         vwYiI+RTy0O5M/QuuxsonbLQC+1k7XuCicVIAozncbzGYjFXLaNUKTCUXJ2xvznrOLMh
         52QBRofVEVGovp8FzXEo7zH67KQ9kLDy6DGHCNwtvhyBVgqnoT5lbiQl/l+mBxZyLRj6
         2tIEGBOrLz+vjEmrmcmE8mpVMeZpKh3dXTszumTUYJ7hKWW89Ojy2AezBJp5ZWoOeDFa
         R4dw==
X-Gm-Message-State: AJIora/qr6m0yWSADtKhDo0mBvk91eCSo0n3Wr4p7RB86te4TxGo1i93
        aIaXSSE36Y15Ofd/zxVfoPemMQ==
X-Google-Smtp-Source: AGRyM1ux+2OWFeWi4caOV2zZI7kRbo/dHwWgixD1wm1nF7Y0pkcpszbij64LbX7hvCsWu8f9Y5EG6w==
X-Received: by 2002:a17:902:c943:b0:16a:3ab8:3678 with SMTP id i3-20020a170902c94300b0016a3ab83678mr12993743pla.56.1656314999954;
        Mon, 27 Jun 2022 00:29:59 -0700 (PDT)
Received: from [10.4.214.173] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f78a00b0016b80d2fac8sm874902pln.248.2022.06.27.00.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:29:59 -0700 (PDT)
Message-ID: <d68572c8-a12b-1e3a-09d4-7a971ff305d6@bytedance.com>
Date:   Mon, 27 Jun 2022 15:29:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
 <f0cfe169-44fa-5653-d454-149ef286d3bb@arm.com>
 <037fc8c3-9b71-cb83-8882-95d5459a494f@bytedance.com>
 <b46f5390-830d-08fd-0d6d-3fda7d31c36a@arm.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b46f5390-830d-08fd-0d6d-3fda7d31c36a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/27 15:14, Anshuman Khandual wrote:
> 
> 
> On 6/27/22 12:25, Qi Zheng wrote:
>>
>>
>> On 2022/6/27 14:18, Anshuman Khandual wrote:
>>>
>>>
>>> On 6/26/22 20:27, Qi Zheng wrote:
>>>> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
>>>> helper") add set_huge_swap_pte_at() to handle swap entries on
>>>> architectures that support hugepages consisting of contiguous ptes.
>>>> And currently the set_huge_swap_pte_at() is only overridden by arm64.
>>>>
>>>> The set_huge_swap_pte_at() provide a sz parameter to help determine
>>>> the number of entries to be updated. But in fact, all hugetlb swap
>>>> entries contain pfn information, so we can find the corresponding
>>>> folio through the pfn recorded in the swap entry, then the folio_size()
>>>> is the number of entries that need to be updated.
>>>>
>>>> And considering that users will easily cause bugs by ignoring the
>>>> difference between set_huge_swap_pte_at() and set_huge_pte_at().
>>>> Let's handle swap entries in set_huge_pte_at() and remove the
>>>> set_huge_swap_pte_at(), then we can call set_huge_pte_at()
>>>> anywhere, which simplifies our coding.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    arch/arm64/include/asm/hugetlb.h |  3 ---
>>>>    arch/arm64/mm/hugetlbpage.c      | 34 ++++++++++++++++----------------
>>>>    include/linux/hugetlb.h          | 13 ------------
>>>>    mm/hugetlb.c                     |  8 +++-----
>>>>    mm/rmap.c                        | 11 +++--------
>>>>    5 files changed, 23 insertions(+), 46 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>>>> index 1fd2846dbefe..d20f5da2d76f 100644
>>>> --- a/arch/arm64/include/asm/hugetlb.h
>>>> +++ b/arch/arm64/include/asm/hugetlb.h
>>>> @@ -46,9 +46,6 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>>>                   pte_t *ptep, unsigned long sz);
>>>>    #define __HAVE_ARCH_HUGE_PTEP_GET
>>>>    extern pte_t huge_ptep_get(pte_t *ptep);
>>>> -extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>>>> -                 pte_t *ptep, pte_t pte, unsigned long sz);
>>>> -#define set_huge_swap_pte_at set_huge_swap_pte_at
>>>>      void __init arm64_hugetlb_cma_reserve(void);
>>>>    diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>>> index c9e076683e5d..58b89b9d13e0 100644
>>>> --- a/arch/arm64/mm/hugetlbpage.c
>>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>>> @@ -238,6 +238,13 @@ static void clear_flush(struct mm_struct *mm,
>>>>        flush_tlb_range(&vma, saddr, addr);
>>>>    }
>>>>    +static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
>>>> +{
>>>> +    VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
>>>> +
>>>> +    return page_folio(pfn_to_page(swp_offset(entry)));
>>>> +}
>>>
>>> Extracting this huge page size from swap entry is an additional operation which
>>> will increase the over all cost for set_huge_swap_pte_at(). At present the size
>>
>> Hmm, I think this cost is very small. And replacing
>> set_huge_swap_pte_at() by transparently handling swap entries helps
>> reduce possible bugs, which is worthwhile.
> 
> Possible bugs ? There are just six call sites for this function.

For the swap entry of hugetlb, we need to remember that we should
call set_huge_swap_pte_at() instead of set_huge_pte_at() every
time. And the difference between the two is only on arm64, other
architectures should not need to pay attention to this.

> Although this proposed patch is functionally correct, I dont see
> a valid enough reason to increase the overall cost in the path.

-- 
Thanks,
Qi
