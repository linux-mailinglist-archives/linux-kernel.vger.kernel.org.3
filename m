Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0E536653
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiE0RG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbiE0RG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:06:28 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6945E11466
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:06:25 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id udPonJN5ZYwJ7udPonx02N; Fri, 27 May 2022 19:06:23 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 27 May 2022 19:06:23 +0200
X-ME-IP: 90.11.191.102
Message-ID: <4a924319-f3d8-8ce5-b3a3-bdd8e79837a7@wanadoo.fr>
Date:   Fri, 27 May 2022 19:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] most: Directly use ida_alloc()/free()
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Randy Dunlap <rdunlap@infradead.org>, keliu <liuke94@huawei.com>,
        gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        linux-kernel@vger.kernel.org
References: <20220527083309.2553087-1-liuke94@huawei.com>
 <7b0181da-7327-0594-ce9a-9601aca56909@infradead.org>
 <01d80abf-61c3-d4fd-190e-716400230d7d@wanadoo.fr>
In-Reply-To: <01d80abf-61c3-d4fd-190e-716400230d7d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/05/2022 à 18:50, Christophe JAILLET a écrit :
> Le 27/05/2022 à 17:37, Randy Dunlap a écrit :
>>
>>
>> On 5/27/22 01:33, keliu wrote:
>>> Use ida_alloc()/ida_free() instead of deprecated
>>> ida_simple_get()/ida_simple_remove() .
>>>
>>> Signed-off-by: keliu <liuke94@huawei.com>
>>
>> The Signed-off-by: needs a more complete name (unless that is your 
>> full name).
>>
>> Do any of Christophe's comments apply here?
> 
> Hi,
> 
> This one looks fine. Thanks keliu.
> 
> Should I nitpick, there is an extra <space> in the commit description 
> before the final "." :)
> 
> 
> In fact, I'm sure of who can give a Reviewed-by: or Acked-by: tag. So up 

Typo: read: ... I'm NOT sure ...

> to now, I only comment in-line when I go through patches randomly picked 
> on the linext-kernel ML.
> 
> I think it is mainly for maintainer, but if anyone can give them, I'll 
> be glad to add them if it helps in the process.
> 
> CJ
> 
> 
>>
>> thanks.
>>
>>> ---
>>>   drivers/most/core.c      | 10 +++++-----
>>>   drivers/most/most_cdev.c |  6 +++---
>>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/most/core.c b/drivers/most/core.c
>>> index e4412c7d25b0..81d60d4ee8c2 100644
>>> --- a/drivers/most/core.c
>>> +++ b/drivers/most/core.c
>>> @@ -1286,7 +1286,7 @@ int most_register_interface(struct 
>>> most_interface *iface)
>>>           !iface->poison_channel || (iface->num_channels > 
>>> MAX_CHANNELS))
>>>           return -EINVAL;
>>> -    id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
>>> +    id = ida_alloc(&mdev_id, GFP_KERNEL);
>>>       if (id < 0) {
>>>           dev_err(iface->dev, "Failed to allocate device ID\n");
>>>           return id;
>>> @@ -1294,7 +1294,7 @@ int most_register_interface(struct 
>>> most_interface *iface)
>>>       iface->p = kzalloc(sizeof(*iface->p), GFP_KERNEL);
>>>       if (!iface->p) {
>>> -        ida_simple_remove(&mdev_id, id);
>>> +        ida_free(&mdev_id, id);
>>>           return -ENOMEM;
>>>       }
>>> @@ -1308,7 +1308,7 @@ int most_register_interface(struct 
>>> most_interface *iface)
>>>           dev_err(iface->dev, "Failed to register interface device\n");
>>>           kfree(iface->p);
>>>           put_device(iface->dev);
>>> -        ida_simple_remove(&mdev_id, id);
>>> +        ida_free(&mdev_id, id);
>>>           return -ENOMEM;
>>>       }
>>> @@ -1366,7 +1366,7 @@ int most_register_interface(struct 
>>> most_interface *iface)
>>>       }
>>>       kfree(iface->p);
>>>       device_unregister(iface->dev);
>>> -    ida_simple_remove(&mdev_id, id);
>>> +    ida_free(&mdev_id, id);
>>>       return -ENOMEM;
>>>   }
>>>   EXPORT_SYMBOL_GPL(most_register_interface);
>>> @@ -1397,7 +1397,7 @@ void most_deregister_interface(struct 
>>> most_interface *iface)
>>>           device_unregister(&c->dev);
>>>       }
>>> -    ida_simple_remove(&mdev_id, iface->p->dev_id);
>>> +    ida_free(&mdev_id, iface->p->dev_id);
>>>       kfree(iface->p);
>>>       device_unregister(iface->dev);
>>>   }
>>> diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
>>> index 3722f9abd7b9..27913b1c8128 100644
>>> --- a/drivers/most/most_cdev.c
>>> +++ b/drivers/most/most_cdev.c
>>> @@ -100,7 +100,7 @@ static void destroy_cdev(struct comp_channel *c)
>>>   static void destroy_channel(struct comp_channel *c)
>>>   {
>>> -    ida_simple_remove(&comp.minor_id, MINOR(c->devno));
>>> +    ida_free(&comp.minor_id, MINOR(c->devno));
>>>       kfifo_free(&c->fifo);
>>>       kfree(c);
>>>   }
>>> @@ -424,7 +424,7 @@ static int comp_probe(struct most_interface 
>>> *iface, int channel_id,
>>>       if (c)
>>>           return -EEXIST;
>>> -    current_minor = ida_simple_get(&comp.minor_id, 0, 0, GFP_KERNEL);
>>> +    current_minor = ida_alloc(&comp.minor_id, GFP_KERNEL);
>>>       if (current_minor < 0)
>>>           return current_minor;
>>> @@ -471,7 +471,7 @@ static int comp_probe(struct most_interface 
>>> *iface, int channel_id,
>>>   err_free_c:
>>>       kfree(c);
>>>   err_remove_ida:
>>> -    ida_simple_remove(&comp.minor_id, current_minor);
>>> +    ida_free(&comp.minor_id, current_minor);
>>>       return retval;
>>>   }
>>
> 
> 
