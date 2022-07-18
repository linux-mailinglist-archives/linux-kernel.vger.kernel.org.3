Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBD577C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiGRHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGRHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:36:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E8811C24
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:36:23 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LmYZn5h29zVg2M;
        Mon, 18 Jul 2022 15:32:33 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 15:35:47 +0800
Received: from [10.67.77.105] (10.67.77.105) by dggpemm500003.china.huawei.com
 (7.185.36.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Jul
 2022 15:35:47 +0800
Message-ID: <945e4200-9555-b6a4-5588-0d1c1b0be152@hisilicon.com>
Date:   Mon, 18 Jul 2022 15:35:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] drivers: irqchip: Allocate alignment addr by
 ITS_BASER.Page_size
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, <lizixian@hisilicon.com>
References: <1657955136-6622-1-git-send-email-wangwudi@hisilicon.com>
 <87tu7h4d78.wl-maz@kernel.org>
From:   wangwudi <wangwudi@hisilicon.com>
In-Reply-To: <87tu7h4d78.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.105]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

在 2022/7/16 17:30, Marc Zyngier 写道:
> On Sat, 16 Jul 2022 08:05:36 +0100,
> wangwudi <wangwudi@hisilicon.com> wrote:
>>
>> The description of the ITS_BASER.Physical_Address field in the ARM GIC spec is as 
>> follows:
>> "The address must be aligned to the size specified in the Page Size field."
>> The Page_Size field in ITS_BASER might be RO.
>>
>> Currently, the address is aligned based on the system page_size, not the HW 
>> Page_Size field. In some case, this is in contradiction with the spec.
>>
>> For example:
>> ITS_BASER.Page_Size indicate 16K, and kernel page size is 4K.
>> If HW need 4K-size memory, the driver may alloc a 4K aligned address.
>> This has been proven in hardware.
> 
> Ah, interesting bug. Thanks for bringing this up. Can you describe how
> this occurs? I suspect you are using indirect tables.
> 

Sure. In the system, kernel page size is 4K, and ITS_BASER.Page_Size is 16K.

As you suspected, HW used indirect VPE table and indication supports a small
number of vpeids, like 2-bits vpeid. So that HW requires only less than 4K-
size memory, and 16K aligned base address. But driver alloctes 4K aligend base
address.

>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: wangwudi <wangwudi@hisilicon.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 5ff09de6c48f..0e25e887d45c 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2310,6 +2310,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>>  		order = get_order(GITS_BASER_PAGES_MAX * psz);
>>  	}
>>  
>> +	if ((psz > PAGE_SIZE) && (PAGE_ORDER_TO_SIZE(order) < psz)) {
>> +		order = get_order(psz);
>> +	}
>>  	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, order);
>>  	if (!page)
>>  		return -ENOMEM;
> 
> However, I don't see how you end-up with the incorrect value here.
> 
> * No indirect table:
> 	alloc_its_tables():
> 		order = get_order(baser->psz);
> 
> * Indirect tables:
> 	alloc_its_tables():
> 		order = get_order(baser->psz);
> 	its_parse_indirect_baser():
> 		new_order = *order;
> 		new_order = max_t(u32, get_order(esz << ids), new_order);
> 
> So in both cases, we should end-up with order >= get_order(psz).
Yes, totally agree.

> 
> Clearly, I'm missing a path, but your commit message doesn't make it
> obvious. Can you please enlighten me?
> 
My commit is based on the premise:
"alloc_pages_node gives a size-aligend address".
For example, if HW apply for 4K-size memory, then allocated address is 4K
aligned.

> Thanks,
> 
> 	M.
> 

