Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15335AFE0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiIGHuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiIGHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:49:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75A710F7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:49:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMvSX4bjhzmWLd;
        Wed,  7 Sep 2022 15:45:48 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 15:49:23 +0800
Message-ID: <eafd4aa5-eee9-3fb9-357b-721780d894d8@huawei.com>
Date:   Wed, 7 Sep 2022 15:49:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V2] irqchip/gic-v3-its: Reclaim the dangling bits in LPI
 maps
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>
References: <20220831023332.191368-1-liaochang1@huawei.com>
 <87o7vtrb2i.wl-maz@kernel.org>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87o7vtrb2i.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        NICE_REPLY_A,PDS_BTC_ID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc, thanks for comment.

在 2022/9/6 1:21, Marc Zyngier 写道:
> On Wed, 31 Aug 2022 03:33:32 +0100,
> Liao Chang <liaochang1@huawei.com> wrote:
>>
>> Following interrupt allocation process leads to some interrupts are
>> mapped in the low-level domain(Arm ITS), but they have never mapped
>> at the higher level.
>>
>> irq_domain_alloc_irqs_hierarchy(.., nr_irqs, ...)
>>   its_irq_domain_alloc(..., nr_irqs, ...)
>>     its_alloc_device_irq(..., nr_irqs, ...)
>>       bitmap_find_free_region(..., get_count_order(nr_irqs))
>>
>> Since ITS domain finds a region of zero bits, the length of which must
>> aligned to the power of two. If nr_irqs is 30, the length of zero bits
>> is actually 32, but the first 30 bits are really mapped.
>>
>> On teardown, the low-level domain only free these interrupts that
>> actually mapped, and leave last interrupts dangling in the ITS domain.
>> Thus the ITS device resources are never freed. On device driver reload,
>> dangling interrupts prevent ITS domain from allocating enough resource.
>>
>> irq_domain_free_irqs_hierarchy(..., nr_irqs, ...)
>>   its_irq_domain_free(..., irq_base + i, 1)
>>     bitmap_release_region(..., irq_base + i, get_count_order(1))
>>
>> John reported this problem to LKML and Marc provided a solution and fix
>> it in the generic code, see the discussion from Link tag. Marc's patch
>> fix John's problem, but does not take care of some corner case, look one
>> example below.
>>
>> Step1: 32 interrupts allocated in LPI domain, but return the first 30 to
>> higher driver.
>>
>>    111111111111111111111111111111 11
>>   |<------------0~29------------>|30,31|
>>
>> Step2: interrupt #16~28 are released one by one, then #0~15 and #29~31
>> still be there.
>>
>>    1111111111111111 0000000000000 1  11
>>   |<-----0~15----->|<---16~28--->|29|30,31|
>>
>> Step#: on driver teardown, generic code will invoke ITS domain code
>> twice. The first time, #0~15 will be released, the second one, only #29
>> will be released(1 align to power of two).
>>
>>    0000000000000000 0000000000000 0  11
>>   |<-----0~15----->|<---16~28--->|29|30,31|
> 
> Which driver is doing this? This really looks like a driver bug to
> only free a portion of its MSI allocation, and that's definitely not
> something that is commonly done.

Yes, this scenario is manipulated. I use this example to prove why current ITS
allocation is buggy, that is the number of interrupt driver is about to release
have to be equal with the number of allocation **last time**, even though the total
number is same, pesudo code below reflects this problem.

[Correct usage]
virq = irq_domain_alloc_irqs(...,0,30,...)  // 32 bits are allocated actually.
irq_domain_free_irqs(virq, 30)    // 32 bits are released actually.

[Incorrect usage]
virq = irq_domain_alloc_irqs(...,0,30,...)
for(i = 0; i < 30; i++)
	irq_domain_free_irqs(virq + i, 1)
// driver release 30 irq, but last 2 bits are dangling due to alignment.

> 
> Even worse, this can result in some LPIs being released behind the
> driver's back, exactly due to this power-of-two alignment.
> 
> It seems to me that you are trying to solve a problem that only exists
> for a buggy driver. Please point me to the upstream code that has such
> behaviour and explain why this can't be fixed in that driver itself.

I indeed find no upstream code has such buggy behaviour, thanks for pointing out
this important and undocumented rule, it is very helpful to me, please ignore this
patch.

> 
> Thanks,
> 
> 	M.
> 

-- 
BR,
Liao, Chang
