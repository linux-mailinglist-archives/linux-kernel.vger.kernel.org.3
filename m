Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A889447F329
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 13:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhLYMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 07:00:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33915 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhLYMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 07:00:24 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JLjCx00W9zcc1r;
        Sat, 25 Dec 2021 19:59:56 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 20:00:22 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 20:00:21 +0800
Message-ID: <4b4f142a-8d32-e6f5-b9ff-8905bcefb77d@huawei.com>
Date:   Sat, 25 Dec 2021 20:00:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Revert "mm/usercopy: Drop extra is_vmalloc_or_module()
 check"
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <20211223102126.161848-1-wangkefeng.wang@huawei.com>
 <ffd77bcf-b9d8-956c-9f83-14b9f0b496e7@csgroup.eu>
 <96fe1826-aeaf-4ea0-9f01-03d6b3933b34@huawei.com>
 <6e2ddc83-bec3-fdd4-4d91-3ade0de0b7c8@csgroup.eu>
 <ccf311bd-c0ed-3e42-8057-849a9c3e9a98@huawei.com>
 <1640429980.38ev9qg7xc.astroid@bobo.none>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <1640429980.38ev9qg7xc.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/25 19:04, Nicholas Piggin wrote:
> Excerpts from Kefeng Wang's message of December 25, 2021 12:05 pm:
>
...
>>> Can you try that ?
>>>
>>> #define virt_addr_valid(kaddr)	((kaddr & PAGE_OFFSET) == PAGE_OFFSET &&
>>> pfn_valid(virt_to_pfn(kaddr)))
>> I got this commit,
>>
>> commit 4dd7554a6456d124c85e0a4ad156625b71390b5c
>>
>> Author: Nicholas Piggin <npiggin@gmail.com>
>> Date:   Wed Jul 24 18:46:37 2019 +1000
>>
>>       powerpc/64: Add VIRTUAL_BUG_ON checks for __va and __pa addresses
>>
>>       Ensure __va is given a physical address below PAGE_OFFSET, and __pa is
>>       given a virtual address above PAGE_OFFSET.
>>
>> It has check the PAGE_OFFSET in __pa,  will test it and resend the
>> patch(with above warning changes).
> What did you get with this commit? Is this what causes the crash?

I mean that your patch does the check to make sure the virt addr should 
above PAGE_OFFSET,

and we can add the check in the virt_addr_valid too.

>
> riscv for example with flatmem also relies on pfn_valid to do the right
> thing, so as far as I can see the check should exclude vmalloc addresses
> and it's just a matter of virt_addr_valid not to give virt_to_pfn an
> address < PAGE_OFFSET.
>
> If we take riscv's implementation
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 254687258f42..7713188516a6 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -132,7 +132,10 @@ static inline bool pfn_valid(unsigned long pfn)
>   #define virt_to_page(kaddr)    pfn_to_page(virt_to_pfn(kaddr))
>   #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
>   
> -#define virt_addr_valid(kaddr) pfn_valid(virt_to_pfn(kaddr))
> +#define virt_addr_valid(vaddr) ({                                      \
> +       unsigned long _addr = (unsigned long)vaddr;                     \
> +       (unsigned long)(_addr) >= PAGE_OFFSET && pfn_valid(virt_to_pfn(_addr)); \
> +})
Yes, I send a new v2  with this change, thanks
>   
>   /*
>    * On Book-E parts we need __va to parse the device tree and we can't
>
> .
