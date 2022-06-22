Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D9554608
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353776AbiFVJCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiFVJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:02:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885D37BD5;
        Wed, 22 Jun 2022 02:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DE1AB81CBF;
        Wed, 22 Jun 2022 09:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9158BC34114;
        Wed, 22 Jun 2022 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888563;
        bh=Kp00LHfC1mYkuniYsZS/lSb2xs0mf8PbEYvivI4r6pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mw1oXqgc/P9xaWQrYULrVMjaO8nmm1rponOi0V4mgtMHvXIL96Q+mCYU75ZquJOFf
         3JO75nVgSfUBOu+7e9SN94BUBvQ3YJJUUD6BjH2SdUSDE5NgpBAg90RsqVi/Jm0hXI
         7RXOaYCwgloHBqHGYJeMMAk5n7flUH774uPTWtOdazOiO4hzNc/AvNwSrbXaxSj57Y
         b8Fh2NhZmbKUa6kpOVddj9OkKYoKcSnGEnWAJTmnf/mzaisTDHi643ec0EsINMPEaZ
         qscgR+Y+yPANZWsvDX9S0CHLh85MqqAot/DTjhu+WWmF4zihAvM1uTzk/kP98ioWOU
         Ua7AAJF0DOv3g==
Message-ID: <deac1d48-493c-c637-c00c-d6f09f56b074@kernel.org>
Date:   Wed, 22 Jun 2022 11:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mips: lantiq: Add missing of_node_put() in irq.c
Content-Language: en-US
To:     Liang He <windhl@126.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     john@phrozen.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220615153339.3970658-1-windhl@126.com>
 <20220621152119.GB12322@alpha.franken.de>
 <5b777944.84cc.18186e4f5ba.Coremail.windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <5b777944.84cc.18186e4f5ba.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 17:32, Liang He wrote:
> 
> 
> At 2022-06-21 23:21:19, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de> wrote:
>> On Wed, Jun 15, 2022 at 11:33:39PM +0800, Liang He wrote:
>>> In icu_of_init(), of_find_compatible_node() will return a node
>>> pointer with refcount incremented. We should use of_node_put()
>>> when it is not used anymore.
>>>
>>> Signed-off-by: Liang He <windhl@126.com>
>>> ---
>>>  arch/mips/lantiq/irq.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
>>> index b732495f138a..62f1b20a2169 100644
>>> --- a/arch/mips/lantiq/irq.c
>>> +++ b/arch/mips/lantiq/irq.c
>>> @@ -396,6 +396,9 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
>>>  
>>>  		ret = of_property_read_u32_array(eiu_node, "lantiq,eiu-irqs",
>>>  						ltq_eiu_irq, exin_avail);
>>> +						
>>
>> trailing whitespaces
>>
>>> +		of_node_put(eiu_node);
>>> +						
>>
>> trailing whitespaces
>>
>>>  		if (ret)
>>>  			panic("failed to load external irq resources");
>>>  
>>> @@ -409,6 +412,9 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
>>>  			panic("Failed to remap eiu memory");
>>>  	}
>>>  
>>> +	/* if eiu_node&of_address_to_resource */
>>> +	of_node_put(eiu_node);
>>> +
>>
>> if I'm not mistaken you are freeing the taken reference twice. Shouldn't
>> it work by only adding the last of_node_put() ?
>>
>> Thomas.
> 
> Hi, Thomas.
> 
> Thanks very much for your effort to review and apply my patches.
> 
> You are right, this patch is wrong and only the last put is needed.
> 
> I will send a new patch: removing trailing whitspace and the first put.
> 
> Thans again.

Thomas,

Before applying the patch please check it carefully. Previous evidence
[1][2] suggests that not it was not even compiled.



[1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/

[2]
https://lore.kernel.org/all/16f9a971.44e5.1817068ee3c.Coremail.windhl@126.com/


Best regards,
Krzysztof
