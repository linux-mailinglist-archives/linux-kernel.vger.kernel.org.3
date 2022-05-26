Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F53534FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbiEZNXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiEZNX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:23:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856ED809B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:23:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t28so1315087pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uIxK9C61XlALbRdAEap35isITmKB6SHb6MKDHxeJOLA=;
        b=5mVneQRp1xgwPMnkJY6c5qQOroCs4jkOmuB9nncRs6fnUnqyrV2qBEWAqFA4BlwtUC
         tNk4NQJQ9i8iGVyHA9cLgFkJMqkvKyJ+7tO1CIKcgxf5tU/582UcN0Z31SNXHI4JKOI4
         pR4tmus62ZuFKjxr716UdilEuC2KqELG5u4EWEA4p767IMO8AU4AQzs3yUsXuAHDg1b7
         bCTXKv9Ef3RwWLQqcSeu685UB9RgSlZfZsUgO7EAceXYWWRfWG5BRK22cr9v5bCZLzPS
         +Y5lMZRxHpza8sCLGVPIm6VIDKfI1QZcgvheff8mw/ARbDc04ty8Y/z+sWrHem30BrPK
         TFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uIxK9C61XlALbRdAEap35isITmKB6SHb6MKDHxeJOLA=;
        b=a8Mai8IZDXHVuKtZat3PLy/JX2QUBua2RcnPrvsDfsXG+UDQfVYjszfA4h+/ek/m0C
         QcLx1qSzKtcmLdC4bzElUL/PNUzgcJPOJkM+DcHRGT3Z9zZb5p1+qMtush8MiJpiZ3k0
         poOIfq7Tnyle3lTdpbZm5EDJ6oLlZ7MLl440YFuiIhZuWqQlZf9aneKY3Ii0MbPqHttb
         CWYXH9Hhh+6rj8Aolhdld/+wvj78XLjW5g//EmkMjfb5ktiyspkD7BSFg3PAv9gp5FeU
         Tl5CSX3ZHB6+4Dy1oKjW7/NKcUB24xhE1PQ6mt9ubNUy4FUfumWRVbkJf6BqSRrrwAm3
         VhHA==
X-Gm-Message-State: AOAM531P8AsR0Js2mXPuLwMUVItmGyKsr3OeLvPY/iNgZKIan/e45/vI
        C3djFpaacGCATiES0VsNy3kigQ==
X-Google-Smtp-Source: ABdhPJzUrv4dGJ8J9vc1WC0Q9OXpx/OXKpRQGjeT72+MR01RZZUs3WzAUHoH+DvZD0GUDeMnYtmgOQ==
X-Received: by 2002:aa7:8d47:0:b0:4f6:a7f9:1ead with SMTP id s7-20020aa78d47000000b004f6a7f91eadmr38855819pfe.42.1653571407802;
        Thu, 26 May 2022 06:23:27 -0700 (PDT)
Received: from [10.5.103.226] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090abb9000b001e09cab8893sm3584055pjr.42.2022.05.26.06.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 06:23:27 -0700 (PDT)
Message-ID: <f2dc775e-a8a0-ed08-6c6e-8b98e5bee085@bytedance.com>
Date:   Thu, 26 May 2022 21:23:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220526113350.30806-1-linmiaohe@huawei.com>
 <09f38cf3-282a-61fa-9916-057b01b57d30@bytedance.com>
 <CA+CK2bC0cUACMbSDFhxxPEv2J2pgEvVk=n=Pu00OgLadjNhEMA@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CA+CK2bC0cUACMbSDFhxxPEv2J2pgEvVk=n=Pu00OgLadjNhEMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/26 9:11 PM, Pasha Tatashin wrote:
> On Thu, May 26, 2022 at 9:04 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>
>>
>> On 2022/5/26 7:33 PM, Miaohe Lin wrote:
>>> ptep is unmapped too early, so ptep will be accessed while it's unmapped.
>>> Fix it by deferring pte_unmap() until page table checking is done.
>>
>> In the beginning, page_table_check only supported x86_64, so there
>> is no problem. But then the commit 3fee229a8eb9 ("riscv/mm: enable
>> ARCH_SUPPORTS_PAGE_TABLE_CHECK") added support for riscv-32, it is
>> indeed a problem in this case.
> 
> pte_unmap() is needed only with  CONFIG_HIGHPTE. I do not see this
> config for  riskv-32?

My bad, but it's better to call pte_unmap() after the check is done.

> 
> Pasha
> 
>>
>> So:
>>
>> Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>>>
>>> Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    mm/page_table_check.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
>>> index 3692bea2ea2c..971c3129b0e3 100644
>>> --- a/mm/page_table_check.c
>>> +++ b/mm/page_table_check.c
>>> @@ -234,11 +234,11 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
>>>                pte_t *ptep = pte_offset_map(&pmd, addr);
>>>                unsigned long i;
>>>
>>> -             pte_unmap(ptep);
>>>                for (i = 0; i < PTRS_PER_PTE; i++) {
>>>                        __page_table_check_pte_clear(mm, addr, *ptep);
>>>                        addr += PAGE_SIZE;
>>>                        ptep++;
>>>                }
>>> +             pte_unmap(ptep);
>>>        }
>>>    }
>>
>> --
>> Thanks,
>> Qi

-- 
Thanks,
Qi
