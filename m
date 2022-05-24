Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F453228B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiEXFhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiEXFhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:37:05 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1365D0A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:37:03 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id tNE3nOHw4P8AptNE4nN8eg; Tue, 24 May 2022 07:37:01 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 24 May 2022 07:37:01 +0200
X-ME-IP: 90.11.191.102
Message-ID: <1a1bd5ac-9094-4e8b-718a-ee70c2e89624@wanadoo.fr>
Date:   Tue, 24 May 2022 07:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] irqchip/loongson-liointc: Fix an error handling path in
 liointc_init()
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     dan.carpenter@oracle.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <1c4e81eda5f9651f581f1554629d334f1afda841.1653227039.git.christophe.jaillet@wanadoo.fr>
 <CAAhV-H73Gj-KDjLuqCtasX5dtBRTHe_8s51wR1mrd=_rBF_XZA@mail.gmail.com>
 <CAAhV-H4Z4Ujif3UcSeSUMdT6SR0hVQnLCCzdGhg27mrtW4OvnQ@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAAhV-H4Z4Ujif3UcSeSUMdT6SR0hVQnLCCzdGhg27mrtW4OvnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/05/2022 à 05:47, Huacai Chen a écrit :
> Hi, Christophe,
> 
> On Tue, May 24, 2022 at 10:50 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>>
>> Hi, Christophe,
>>
>> On Sun, May 22, 2022 at 9:44 PM Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr> wrote:
>>>
>>> If a of_property_match_string() call fails, we still need to release some
>>> resources.
>>> Add the corresponding goto instead of a direct return.
>> Your patch is correct, but 807e93d0ecbb hasn't been upstream, I don't
>> know how to handle it.
>>
>> Huacai
>>>
>>> Fixes: 807e93d0ecbb ("irqchip/loongson-liointc: Add ACPI init support")
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>   drivers/irqchip/irq-loongson-liointc.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
>>> index ff3cb5b05710..2227b702a81d 100644
>>> --- a/drivers/irqchip/irq-loongson-liointc.c
>>> +++ b/drivers/irqchip/irq-loongson-liointc.c
>>> @@ -185,8 +185,10 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>>>                          int index = of_property_match_string(node,
>>>                                          "reg-names", core_reg_names[i]);
>>>
>>> -                       if (index < 0)
>>> -                               return -EINVAL;
>>> +                       if (index < 0) {
>>> +                               err = -EINVAL;
>>> +                               goto out_iounmap;
>>> +                       }
> Just goto out_iounmap is OK, because it returns -EINVAL at last.

Yes, agreed.

> I've squash your patch to the original one and add a Co-developed-by:,
> not sure it is the best solution. Thanks.

Squashing in the original patch is fine for me. It is what is usually 
done in such cases.

The Co-developed-by: is maybe a bit to much. I've just fixed a bug that 
can't happen (IMHO) in real life. I'll let you decide what is more relevant.
With or without the tag is fine for me as well.

CJ


> 
> Huacai
>>>
>>>                          priv->core_isr[i] = of_iomap(node, index);
>>>                  }
>>> --
>>> 2.34.1
>>>
> 

