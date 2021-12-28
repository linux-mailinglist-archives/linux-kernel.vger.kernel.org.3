Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BDB480604
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 05:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhL1EvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 23:51:07 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15984 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhL1EvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 23:51:06 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JNMTv63dHzZdtB;
        Tue, 28 Dec 2021 12:47:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 12:51:04 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 12:51:03 +0800
Message-ID: <4ca5a8e4-8edc-3ea4-34f0-26d6ff7c5db4@huawei.com>
Date:   Tue, 28 Dec 2021 12:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] mm: usercopy: Warn vmalloc/module address in
 check_heap_object()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     Nicholas Piggin <npiggin@gmail.com>
References: <20211225120621.13908-1-wangkefeng.wang@huawei.com>
 <20211225120621.13908-3-wangkefeng.wang@huawei.com>
 <fadd9754-ab85-63ec-4d6a-c6490adb5d94@csgroup.eu>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <fadd9754-ab85-63ec-4d6a-c6490adb5d94@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/27 1:33, Christophe Leroy wrote:
>
> Le 25/12/2021 à 13:06, Kefeng Wang a écrit :
>> virt_addr_valid() could be insufficient to validate the virt addr
>> on some architecture, which could lead to potential BUG which has
>> been found on arm64/powerpc64.
>>
>> Let's add WARN_ON to check if the virt addr is passed virt_addr_valid()
>> but is a vmalloc/module address.
> I think that's the responsibility of the architecture and doesn't
> deserve a WARN_ON() in generic code.
>
> The generic code cannot check all what architectures do wrong.
>
> Eventually you can do some testing at startup, maybe with
> CONFIG_DEBUG_VM_PGTABLE, but I don't think we should have such
> verification in functions like check_heap_object()

Ok, we could find other better place to add a virt_to_valid() check

instead of this one.

>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>    mm/usercopy.c | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> index b3de3c4eefba..ce83e0b137dd 100644
>> --- a/mm/usercopy.c
>> +++ b/mm/usercopy.c
>> @@ -228,6 +228,8 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>>    	if (!virt_addr_valid(ptr))
>>    		return;
>>    
>> +	WARN_ON_ONCE(is_vmalloc_or_module_addr(ptr));
>> +
>>    	/*
>>    	 * When CONFIG_HIGHMEM=y, kmap_to_page() will give either the
>>    	 * highmem page or fallback to virt_to_page(). The following
