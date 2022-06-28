Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005A55DA75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiF1HnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiF1HnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:43:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942012CE15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:42:57 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXGgy2R0gzTgDr;
        Tue, 28 Jun 2022 15:39:26 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 15:42:55 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 15:42:55 +0800
Subject: Re: [PATCH V12 01/10] APCI: irq: Add support for multiple GSI domains
To:     Marc Zyngier <maz@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
 <1655273250-23495-2-git-send-email-lvjianmin@loongson.cn>
 <87k09ipfe2.wl-maz@kernel.org>
 <0247b7d5-aca9-5db1-e712-4783ee672110@loongson.cn>
 <87fsk2p8b5.wl-maz@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ae3e0bc7-67c3-8f05-d3ba-98cab9b75117@huawei.com>
Date:   Tue, 28 Jun 2022 15:42:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87fsk2p8b5.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/18 18:36, Marc Zyngier wrote:
[...]
>>>> --- a/drivers/acpi/irq.c
>>>> +++ b/drivers/acpi/irq.c
>>>> @@ -12,7 +12,7 @@
>>>>      enum acpi_irq_model_id acpi_irq_model;
>>>>    -static struct fwnode_handle *acpi_gsi_domain_id;
>>>> +static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
>>>>      /**
>>>>     * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>>>> @@ -26,10 +26,7 @@
>>>>     */
>>>>    int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>>    {
>>>> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
>>>> -							DOMAIN_BUS_ANY);
>>>> -
>>>> -	*irq = irq_find_mapping(d, gsi);
>>>> +	*irq = acpi_register_gsi(NULL, gsi, -1, -1);
>>>
>>> What is this?
>>>
>>> - This wasn't part of my initial patch, and randomly changing patches
>>>     without mentioning it isn't acceptable
>>>
>>> - you *cannot* trigger a registration here, as this isn't what the API
>>>     advertises
>>>
>>> - what makes you think that passing random values (NULL, -1... )to
>>>     acpi_register_gsi() is an acceptable thing to do?
>>>
>>> The original patch had:
>>>
>>> @@ -26,8 +26,10 @@ static struct fwnode_handle *acpi_gsi_domain_id;
>>>      */
>>>     int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>     {
>>> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
>>> -							DOMAIN_BUS_ANY);
>>> +	struct irq_domain *d;
>>> +
>>> +	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
>>> +				     DOMAIN_BUS_ANY);
>>>       	*irq = irq_find_mapping(d, gsi);
>>>     	/*
>>>
>>> and I don't think it needs anything else. If something breaks, let's
>>> discuss it, but don't abuse the API nor the fact that I usually don't
>>> review my own patches to sneak things in...
>>>
>>
>> Sorry, Marc, I don't know how to communicate with you for my change
>> here before submitting the patch, maybe I should mention it in the
>> patch commit or code.
> 
> It should at least be discussed first, like you are doing it here.
> 
>> When I use the patch, I found that acpi_gsi_to_irq in driver/acpi/irq.c
>> only handle existed mapping and will return -EINVAL if mapping not
>> found. When I test on my machine, a calling stack is as following:
>>
>>
>> acpi_bus_init
>> ->acpi_enable_subsystem
>>    ->acpi_ev_install_xrupt_handlers
>>      ->acpi_ev_install_sci_handler
>>        ->acpi_os_install_interrupt_handler
>>          ->acpi_gsi_to_irq
>>
>>
>> the acpi_gsi_to_irq returned -EINVAL because of no mapping found. I
>> looked into acpi_gsi_to_irq of x86, acpi_register_gsi is called in it
>> so that new mapping for gsi is created if no mapping is found.
> 
> So it looks like we have a discrepancy between the x86 and ARM on that
> front.
> 
> Lorenzo, Hanjun, can you please have a look at this and shed some
> light on what the expected behaviour is? It looks like we never
> encountered an issue with this on arm64, which tends to indicate that
> we don't usually use the above path.

Sorry for the late reply, I just noticed this tomorrow.

As you said, we never encountered Jianmin's issue on ARM64 hardware,
for the call stack which Jianmin shows, acpi_ev_install_xrupt_handlers()
is only called for non-reduced ACPI hardware, but ARM64 is always
defined as reduced ACPI hardware in the ACPI spec, from the first
supported version of ACPI spec for ARM.

Jianmin, is the LoongArch using the redunced hardware mode in ACPI?
if it's using SCI interrupt, I think not, correct me if I'm wrong.

> 
>> I looked into generic acpi_register_gsi, the existed mapping will be
>> checked first by calling irq_find_mapping, so I think calling
>> acpi_register_gsi in acpi_gsi_to_irq can address the problem.
>>
>> But you're right, I'm wrong that I passed random value of -1 to
>> acpi_register_gsi. I don't find a right way to address the problem
>> without changing acpi_gsi_to_irq. I'll continue to work for the
>> problem.
> 
> At the very least, this should be indirected so that the existing
> behaviour isn't affected, no matter how badly broken arm64 may or may
> not be here. Please have a look at the patch below that should help
> you with this.

Looks good to me, I will review and test the v13 patch set.

Thanks
Hanjun
