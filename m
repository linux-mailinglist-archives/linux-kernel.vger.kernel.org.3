Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E114D5A0B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiHYIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiHYIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:35:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24E7391C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:34:56 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MCx572RYMz1N7Z1;
        Thu, 25 Aug 2022 16:31:23 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 16:34:52 +0800
Message-ID: <80b2d62c-c580-15c5-3c69-e288ce685a51@huawei.com>
Date:   Thu, 25 Aug 2022 16:34:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] genirq: Record dangling hwirq number into struct
 irq_data
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Kelley <mikelley@microsoft.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220825060819.74303-1-liaochang1@huawei.com>
 <CAHp75VdyYY08uwJGi0m4-L9=9rLmFzkeJGTi2-NC=prbgKvo3A@mail.gmail.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <CAHp75VdyYY08uwJGi0m4-L9=9rLmFzkeJGTi2-NC=prbgKvo3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        NICE_REPLY_A,PDS_BTC_ID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/25 16:27, Andy Shevchenko 写道:
> On Thu, Aug 25, 2022 at 9:11 AM Liao Chang <liaochang1@huawei.com> wrote:
> 
> Use spell-checker, please. Or ask somebody for proof-reading of your
> commit messages and comments in the code.
> 
>> Following interrupt allocation process lead to some interrupts are
> 
> leads
> 
>> mapped in the low-level domain(Arm ITS), but they are never been mapped
> 
> never mapped
>   ...or...
> they have never
> 
>> at the higher level.
>>
>> irq_domain_alloc_irqs_hierarchy(.., nr_irqs, ...)
>>   its_irq_domain_alloc(..., nr_irqs, ...)
>>     its_alloc_device_irq(..., nr_irqs, ...)
>>       bitmap_find_free_region(..., get_count_order(nr_irqs))
>>
>> Since ITS domain find a region of zero bits, the length of which must
> 
> finds
> 
>> aligned to power of two. If nr_irqs is 30, the length of zero bits is
> 
> the power
> 
>> actually 32, but only first 30 bits are really mapped.
> 
> the first
> 
>> On teardown, low-level domain only free these interrupts that actually
> 
> the low-level
>    ...or...
> domains
> 
>> mapped, and leave last interrupts dangling in the ITS domain. Thus the
>> ITS device resources are never freed. On device driver reload, dangling
>> interrupts prevent ITS domain from allocating enough resource.
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
>>
>> In short summary, the dangling problem stems from the number of released
>> hwirq is less than the one of allocated hwirq in ITS domain. In order to
> 
> the allocated
> 
>> fix this problem, make irq_data record the number of allocated but
>> unmapped hwirq. If hwirq followed by some unmapped bits, ITS domain
>> record the number of unmapped bits to the last irq_data mapped to higher
>> level, when the last hwirq followed by unmapped hwirq is released, some
>> dangling bit will be clear eventualy, look back the trivial example
> 
> eventually
> 
>> above.
>>
>> Step1: record '2' into the irq_data.dangling of #29 hwirq.
>>
>>            111111111111111111111111111111 11
>>           |<------------0~29------------>|30,31|
>> dangling:  000000000000000000000000000002
>>
>> Step2: no change
>>
>>           1111111111111111 0000000000000 1  11
>>          |<-----0~15----->|<---16~28--->|29|30,31|
>> dangling: 0000000000000000 0000000000000 2
>>
>> Step3: ITS domain will release #30~31 since the irq_data.dangling of #29
>> is '2'.
>>
>>            0000000000000000 0000000000000 0  00
>>           |<-----0~15----->|<---16~28--->|29|30,31|
>> dangling:  0000000000000000 0000000000000 2
> 
>> Fixes: 4615fbc3788dd ("genirq/irqdomain: Don't try to free an interrupt
>> that has no mapping")
> 
> All tags must be one-liners. I.o.w. do not split a tag to multiple lines.
> 
> ...
> 
>> + * @dangling:          amount of dangling hardware interrupt, Arm ITS allocate
>> + *                     hardware interrupt more than expected, aligned to power
>> + *                     of two, so that unsued interrupt number become dangling.
> 
> unused
> becomes
> 
>> + *                     Use this field to record dangling bits follwoing @hwirq.
> 
> following
> 
Appreciate for your help, i will correct them.

-- 
BR,
Liao, Chang
