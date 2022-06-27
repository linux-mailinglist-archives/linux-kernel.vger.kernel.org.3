Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE155D79E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiF0Gz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiF0Gz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:55:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2BA2DE0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:55:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso9636486pjz.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s6YskhKblBTp6d670n0jUd5N1jVCJFrPSjByo6zg+n4=;
        b=iSYaiX/dx41GqEc0XwQdpzKEEbHBUo9kx8Vgzp9oZKa00sHUJh62oNgysgOzrmkJDZ
         +oCrpo19mNHhUz7L/tjW4p3PLH8+eIsWY1Xt4VIVulxeZJWdS6XJKHHeZAzpTsgggpoq
         X+YPxjaAe7YB31/TJsLpXN6WYsSx15i8hR1rNWz5TyntA1jmAgEKdztNsfay9vh5gY0e
         KlnXNKKV/Hqc+8rAULiQlB0cxozLlBRuPqxRO8zNIGx8Iu36PTLDYToBCgRrMhi0Z8gO
         hcqnEEPfRNztvyJtdGp8WWNC2sElnhLGjmp4aowBJgDqMkN/CeIbqhkONZOP1Pl+mk1t
         2XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s6YskhKblBTp6d670n0jUd5N1jVCJFrPSjByo6zg+n4=;
        b=ABuL0BeQaf+cxqPXl5TcpcHXE4ihJKYupiOoFYiZXyhw47Z2DBLSFjo5MDN02EYvR5
         FpXZtYttnqvcyGLtNyAM4N5ERPrcHh18dINFuJ+Sjwil66JLoP262L26rgOGlzSxSMoa
         8dmWwVsfgfxkztqdBp7WCgVyme5SUdMREQuhXNysRuQsbdPOzNl+VYc1q91oVjsLezOa
         4FX+n0BtUhW9FQNxd5gHotLKES2DpY+Bng1j6IYKgheqnqsQSb5ENmGi4ndbb+llysM0
         V+Wy8F6ZHZw2aa9au3H//A54qDYDLmNXEyPrXuZDWIC2RzOeQZXbrgi7IL0ZHsLjLH2G
         f4vg==
X-Gm-Message-State: AJIora+tB/oP3SxHNiNMjNayIHGtVfyEBGyzBvbWE58OEb/ojeDQiFnT
        Km1eVjBzLsXsvbzJwF4JdS7Pqw==
X-Google-Smtp-Source: AGRyM1vhoRU/LPowseuW576E5KPJwNpI7Hlzq51YcTSiqutzHyiBJhj5MmrUhAowVihcR5nXchQXvA==
X-Received: by 2002:a17:90a:1c09:b0:1ea:91d4:5a7f with SMTP id s9-20020a17090a1c0900b001ea91d45a7fmr19569048pjs.232.1656312956629;
        Sun, 26 Jun 2022 23:55:56 -0700 (PDT)
Received: from [10.4.214.173] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0040cff9def93sm6224491pga.66.2022.06.26.23.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:55:56 -0700 (PDT)
Message-ID: <037fc8c3-9b71-cb83-8882-95d5459a494f@bytedance.com>
Date:   Mon, 27 Jun 2022 14:55:50 +0800
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <f0cfe169-44fa-5653-d454-149ef286d3bb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/27 14:18, Anshuman Khandual wrote:
> 
> 
> On 6/26/22 20:27, Qi Zheng wrote:
>> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
>> helper") add set_huge_swap_pte_at() to handle swap entries on
>> architectures that support hugepages consisting of contiguous ptes.
>> And currently the set_huge_swap_pte_at() is only overridden by arm64.
>>
>> The set_huge_swap_pte_at() provide a sz parameter to help determine
>> the number of entries to be updated. But in fact, all hugetlb swap
>> entries contain pfn information, so we can find the corresponding
>> folio through the pfn recorded in the swap entry, then the folio_size()
>> is the number of entries that need to be updated.
>>
>> And considering that users will easily cause bugs by ignoring the
>> difference between set_huge_swap_pte_at() and set_huge_pte_at().
>> Let's handle swap entries in set_huge_pte_at() and remove the
>> set_huge_swap_pte_at(), then we can call set_huge_pte_at()
>> anywhere, which simplifies our coding.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h |  3 ---
>>   arch/arm64/mm/hugetlbpage.c      | 34 ++++++++++++++++----------------
>>   include/linux/hugetlb.h          | 13 ------------
>>   mm/hugetlb.c                     |  8 +++-----
>>   mm/rmap.c                        | 11 +++--------
>>   5 files changed, 23 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index 1fd2846dbefe..d20f5da2d76f 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -46,9 +46,6 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>   			   pte_t *ptep, unsigned long sz);
>>   #define __HAVE_ARCH_HUGE_PTEP_GET
>>   extern pte_t huge_ptep_get(pte_t *ptep);
>> -extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>> -				 pte_t *ptep, pte_t pte, unsigned long sz);
>> -#define set_huge_swap_pte_at set_huge_swap_pte_at
>>   
>>   void __init arm64_hugetlb_cma_reserve(void);
>>   
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index c9e076683e5d..58b89b9d13e0 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -238,6 +238,13 @@ static void clear_flush(struct mm_struct *mm,
>>   	flush_tlb_range(&vma, saddr, addr);
>>   }
>>   
>> +static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
>> +{
>> +	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
>> +
>> +	return page_folio(pfn_to_page(swp_offset(entry)));
>> +}
> 
> Extracting this huge page size from swap entry is an additional operation which
> will increase the over all cost for set_huge_swap_pte_at(). At present the size

Hmm, I think this cost is very small. And replacing
set_huge_swap_pte_at() by transparently handling swap entries helps
reduce possible bugs, which is worthwhile.

> value is readily available near set_huge_swap_pte_at() call sites.

-- 
Thanks,
Qi
