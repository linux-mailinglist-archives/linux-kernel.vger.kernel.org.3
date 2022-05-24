Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCED532290
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiEXFlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiEXFlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:41:17 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEFB26AD3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1653370867; bh=GWUSG80uMKJQGJDBdWfDSlGvhK3zw5IeGPqEh98zoes=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lsi6UHkbt8rN1g9x3EgAClnd00T9TZ+dY46ZTuKqiaryvOLwhOLmk6NvhMBNFqqy6
         mEomqDvW8LbNhptiUcpEFIE6FufFZKDKgJ/0mESmsXVHaP6VWHoyvbYunF1ia5UIEu
         mzle4fkEtOTW2xeDYCBPuTpqFD9QoIHOe5lfCyJU=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id BCD2A60074;
        Tue, 24 May 2022 13:41:07 +0800 (CST)
Message-ID: <c939b102-6e96-5be2-e41d-9ef028e5a50e@xen0n.name>
Date:   Tue, 24 May 2022 13:41:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH] irqchip/loongson-liointc: Fix an error handling path in
 liointc_init()
To:     Huacai Chen <chenhuacai@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <1c4e81eda5f9651f581f1554629d334f1afda841.1653227039.git.christophe.jaillet@wanadoo.fr>
 <CAAhV-H73Gj-KDjLuqCtasX5dtBRTHe_8s51wR1mrd=_rBF_XZA@mail.gmail.com>
 <CAAhV-H4Z4Ujif3UcSeSUMdT6SR0hVQnLCCzdGhg27mrtW4OvnQ@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H4Z4Ujif3UcSeSUMdT6SR0hVQnLCCzdGhg27mrtW4OvnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On 5/24/22 11:47, Huacai Chen wrote:
> Hi, Christophe,
>
> On Tue, May 24, 2022 at 10:50 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>> Hi, Christophe,
>>
>> On Sun, May 22, 2022 at 9:44 PM Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr> wrote:
>>> If a of_property_match_string() call fails, we still need to release some
>>> resources.
>>> Add the corresponding goto instead of a direct return.
>> Your patch is correct, but 807e93d0ecbb hasn't been upstream, I don't
>> know how to handle it.
>>
>> Huacai
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
> I've squash your patch to the original one and add a Co-developed-by:,
> not sure it is the best solution. Thanks.
You could also "Reported-by" and/or "Suggested-by", to give proper 
credit. Mention of this mail thread (link to lore.kernel.org archive 
maybe) in the commit message is good too.
>
> Huacai
>>>                          priv->core_isr[i] = of_iomap(node, index);
>>>                  }
>>> --
>>> 2.34.1
>>>
