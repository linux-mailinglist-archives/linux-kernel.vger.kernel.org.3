Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF30589AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbiHDK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiHDK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:59:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7013E33
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:59:05 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lz5GL5vpnz67RRb;
        Thu,  4 Aug 2022 18:54:50 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 12:59:03 +0200
Received: from [10.195.34.58] (10.195.34.58) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 4 Aug
 2022 11:59:03 +0100
Message-ID: <17b5e57b-326e-11c1-d8c7-87f3d3d7d0ff@huawei.com>
Date:   Thu, 4 Aug 2022 11:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: PCI MSI issue with reinserting a driver
From:   John Garry <john.garry@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <shenyang39@huawei.com>,
        "zhanjie (F)" <zhanjie9@hisilicon.com>
References: <cc224272-15db-968b-46a0-95951e11b23f@huawei.com>
 <87o8h3lj0n.wl-maz@kernel.org>
 <a80b9be0-c455-c852-ddac-3f514a15e896@huawei.com>
 <8a54fdd0-950b-f801-e83d-750aef73ab3c@huawei.com>
 <4848792ce8c9ed7490e2205281a3cbda@kernel.org>
 <28c56995-501a-880b-e6dd-ac76b8290c2c@huawei.com>
 <3d3d0155e66429968cb4f6b4feeae4b3@kernel.org>
 <fd88ce05-8aee-5b1f-5ab6-be88fa53d3aa@huawei.com>
In-Reply-To: <fd88ce05-8aee-5b1f-5ab6-be88fa53d3aa@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.34.58]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 10:45, John Garry wrote:

Hi Marc,

Just a friendly reminder that we still have the issue with reinseting a 
PCI driver which does not allocate a power-of-2 MSIs.

> On 03/02/2021 17:23, Marc Zyngier wrote:
>>>
>>> Before:
>>>  In free path, we have:
>>>      its_irq_domain_free(nvecs = 27)
>>>        bitmap_release_region(count order = 5 == 32bits)
>>>
>>> Current:
>>>  In free path, we have:
>>>      its_irq_domain_free(nvecs = 1) for free each 27 vecs
>>>        bitmap_release_region(count order = 0 == 1bit)
>>
>> Right. I was focusing on the patch and blindly ignored the explanation
>> at the top of the email. Apologies for that.
> 
> Yeah, it was a distraction.
> 
>>
>> I'm not overly keen on handling this in the ITS though, and I'd rather
>> we try and do it in the generic code. How about this (compile tested
>> only)?
>>
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 6aacd342cd14..cfccad83c2df 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -1399,8 +1399,19 @@ static void 
>> irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
>>           return;
>>
>>       for (i = 0; i < nr_irqs; i++) {
>> -        if (irq_domain_get_irq_data(domain, irq_base + i))
>> -            domain->ops->free(domain, irq_base + i, 1);
>> +        int n ;
>> +
>> +        /* Find the largest possible span of IRQs to free in one go */
>> +        for (n = 0;
>> +             ((i + n) < nr_irqs &&
>> +              irq_domain_get_irq_data(domain, irq_base + i + n));
>> +             n++);
>> +
>> +        if (!n)
>> +            continue;
>> +
>> +        domain->ops->free(domain, irq_base + i, n);
>> +        i += n;
>>       }
>>   }
> 
> That fixed my problem.
> 
> For my benefit, if MSIs must be allocated in power of 2, could we check 
> a flag for the dealloc method? Like, if MSI domain, then do as before 
> 4615fbc3788d. But I'm not sure on the specific scenario which that 
> commit fixed. Or even whether you want specifics like that in core code.

Thanks,
John
