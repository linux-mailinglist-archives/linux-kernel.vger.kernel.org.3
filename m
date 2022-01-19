Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4BB493232
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350578AbiASBQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:16:07 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31102 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiASBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:16:06 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jdng41pwRz1FCfC;
        Wed, 19 Jan 2022 09:12:16 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 09:16:01 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 09:15:56 +0800
Message-ID: <8a24ef1d-1c93-416d-cfbe-e63aacfb25cc@huawei.com>
Date:   Wed, 19 Jan 2022 09:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] powerpc: Fix virt_addr_valid() check
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <20211225120621.13908-1-wangkefeng.wang@huawei.com>
 <20211225120621.13908-2-wangkefeng.wang@huawei.com>
 <09ed46a5-6df3-ffc0-8243-61612c06153a@huawei.com>
 <1641871726.fshx7g5r92.astroid@bobo.none>
 <ca351bfc-3507-11ad-73f1-79ca772b55fd@csgroup.eu>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ca351bfc-3507-11ad-73f1-79ca772b55fd@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/1/11 14:04, Christophe Leroy wrote:
>
> Le 11/01/2022 à 05:37, Nicholas Piggin a écrit :
>> Excerpts from Kefeng Wang's message of January 8, 2022 9:58 pm:
>>> Hi PPC maintainers， ping..
>> Hmm. I might have confused myself about this. I'm going back and
>> trying to work out what I was thinking when I suggested it. This
>> works on 64e because vmalloc space is below the kernel linear map,
>> right?
>>
>> On 64s it is the other way around and it is still possible to enable
>> flatmem on 64s. Altough we might just not hit the problem there because
>> __pa() will not mask away the vmalloc offset for 64s so it will still
>> return something that's outside the pfn_valid range for flatmem. That's
>> very subtle though.
> That's the way it works on PPC32 at least, so for me it's not chocking
> to have it work the same way on PPC64s.
>
> The main issue here is the way __pa() works. On PPC32 __pa = va -
> PAGE_OFFSET, so it works correctly for any address.
> On PPC64, __pa() works by masking out the 2 top bits instead of
> substracting PAGE_OFFSET, so the test must add a verification that we
> really have the 2 top bits set at first. This is what (addr >=
> PAGE_OFFSET) does. Once this first test is done, we can perfectly rely
> on pfn_valid() just like PPC32, I see absolutely no point in an
> additionnal test checking the addr is below KERN_VIRT_START.


Hi Christophe and Nicholas， for ppc32， I think we need check the upper 
limit,

eg,  addr >= PAGE_OFFSET && addr < high_memory

arch/powerpc/mm/mem.c:  high_memory = (void *) __va(max_low_pfn * 
PAGE_SIZE);

for ppc32 max_low_pfn is the upper low memory pfn,  and For ppc64, 
high_memory is

the max memory pfn, it looks good too, correct me if I'm wrong, if the 
above check

is ok, I will send a new v3,  thanks.




>
>
>> The checks added to __pa actually don't prevent vmalloc memory from
>> being passed to it either on 64s, only a more basic test.
> That's correct. It is the role of pfn_valid() to check that.
>
> Christophe
>
>> I think 64s wants (addr >= PAGE_OFFSET && addr < KERN_VIRT_START) as
>> the condition.  Could possibly add that check to __pa as well to
>> catch vmalloc addresses.
>>
>> Thanks,
>> Nick
>>
>>
