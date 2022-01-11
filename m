Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB2448ABA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbiAKKpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:45:24 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:64111 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:45:22 -0500
X-KPN-MessageId: 654e8b14-72cb-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 654e8b14-72cb-11ec-8a6e-005056ab378f;
        Tue, 11 Jan 2022 11:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=DNU5kyg9B76HoPrKsJCxW+1fueB3ZwD8DJg/bPrU7pM=;
        b=h72ZZvTTXnoYGdZA6Aqo1MMIIrbzULHcDFvU9oLX/FtUvtgS8jJmnneVO6MydfFr2QPHISnrl8+1R
         yq5OLQL+J4NQ2PrH+GXeJOdrqdUN2P9LP9J409fzr4qGMUXGTR47XunszGUZqqmD+zTs1JjgP2puPB
         0+zX8YGXclXA3ly8Mgp4tC9Jvxo1cZ2ltqWbUbmGzMxP5rsUrM6uZgDcVV4BZRur5SPa7/2pHlX7kn
         nfgZtZH5GrFevKgLsiiwQhtoK7EcZDeYjA2g9seZ9GB+brFTIfnuRhqzP7hj+nxdVzogDqNI2X6YJw
         wzVd5t2nM+98WttizLta1LqdMrPTTwg==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|u+I40HJwljc7t/vrfbWCoa3s1rnHlR1pvCkPFfCONUmOtYPt5AS+8NPSibTnred
 pu0KQPa73n2utS+ZLHXqrSg==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 9298eb8d-72cb-11ec-81f5-005056ab7447;
        Tue, 11 Jan 2022 11:45:20 +0100 (CET)
Message-ID: <df687e82-3e9e-4df6-ac3c-ee2e1355779c@xs4all.nl>
Date:   Tue, 11 Jan 2022 11:45:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v2 06/13] media: davinci: vpif: Use
 platform_get_irq_optional() to get the interrupt
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220111002314.15213-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <0bfff433-e216-6f9d-d225-9f07ac48013a@xs4all.nl>
 <CA+V-a8sszaUP6o6LJgDX49oPGVQFOc6G0vtY3p6sz4JNm=xB4A@mail.gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CA+V-a8sszaUP6o6LJgDX49oPGVQFOc6G0vtY3p6sz4JNm=xB4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 11:43, Lad, Prabhakar wrote:
> Hi Hans,
> 
> On Tue, Jan 11, 2022 at 10:25 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>>
>> Hi Prabhakar,
>>
>> On 11/01/2022 01:23, Lad Prabhakar wrote:
>>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
>>> allocation of IRQ resources in DT core code, this causes an issue
>>> when using hierarchical interrupt domains using "interrupts" property
>>> in the node as this bypasses the hierarchical setup and messes up the
>>> irq chaining.
>>>
>>> In preparation for removal of static setup of IRQ resource from DT core
>>> code use platform_get_irq_optional().
>>>
>>> While at it, propagate error code in case devm_request_irq() fails
>>> instead of returning -EINVAL in vpif_display.c.
>>
>> Please note that this patch clashes with [1], for which I just posted a PR [2].
>>
> Ouch, I think I had a comment for patch#2 which needed to be addressed
> (I was nitpicking anyway) so I was hoping this will go in first.

Patch 2 was fine since that change makes sense when looking at patch 3.

> 
>> So once [2] is merged you'll need to rebase this patch.
>>
> Ok, do you want me to just re-send this patch alone or the entire series?

Either works.

Regards,

	Hans

> 
> Cheers,
> Prabhakar
> 
>> Regards,
>>
>>         Hans
>>
>> [1] https://patchwork.linuxtv.org/project/linux-media/list/?series=7000
>> [2] https://patchwork.linuxtv.org/project/linux-media/patch/63d723aa-b6a3-ff42-c3e4-f1fcb979be11@xs4all.nl/
>>
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> v1->v2
>>> * Used DEFINE_RES_IRQ_NAMED() macro
>>> * Considered IRQ0 as no IRQ.
>>> ---
>>>  drivers/media/platform/davinci/vpif.c         | 18 ++++++++------
>>>  drivers/media/platform/davinci/vpif_capture.c | 24 ++++++++++++-------
>>>  drivers/media/platform/davinci/vpif_display.c | 21 ++++++++++------
>>>  3 files changed, 40 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
>>> index 5a89d885d0e3..2dbb464399cc 100644
>>> --- a/drivers/media/platform/davinci/vpif.c
>>> +++ b/drivers/media/platform/davinci/vpif.c
>>> @@ -20,8 +20,10 @@
>>>  #include <linux/err.h>
>>>  #include <linux/init.h>
>>>  #include <linux/io.h>
>>> +#include <linux/irq.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/module.h>
>>> +#include <linux/of.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/spinlock.h>
>>> @@ -425,9 +427,10 @@ EXPORT_SYMBOL(vpif_channel_getfid);
>>>
>>>  static int vpif_probe(struct platform_device *pdev)
>>>  {
>>> -     static struct resource *res_irq;
>>> +     static struct resource res_irq;
>>>       struct platform_device *pdev_capture, *pdev_display;
>>>       struct device_node *endpoint = NULL;
>>> +     int irq;
>>>
>>>       vpif_base = devm_platform_ioremap_resource(pdev, 0);
>>>       if (IS_ERR(vpif_base))
>>> @@ -453,19 +456,20 @@ static int vpif_probe(struct platform_device *pdev)
>>>        * For DT platforms, manually create platform_devices for
>>>        * capture/display drivers.
>>>        */
>>> -     res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>> -     if (!res_irq) {
>>> -             dev_warn(&pdev->dev, "Missing IRQ resource.\n");
>>> +     irq = platform_get_irq(pdev, 0);
>>> +     if (irq < 0) {
>>>               pm_runtime_put(&pdev->dev);
>>> -             return -EINVAL;
>>> +             return irq;
>>>       }
>>> +     res_irq = (struct resource)DEFINE_RES_IRQ_NAMED(irq, of_node_full_name(pdev->dev.of_node));
>>> +     res_irq.flags |= irq_get_trigger_type(irq);
>>>
>>>       pdev_capture = devm_kzalloc(&pdev->dev, sizeof(*pdev_capture),
>>>                                   GFP_KERNEL);
>>>       if (pdev_capture) {
>>>               pdev_capture->name = "vpif_capture";
>>>               pdev_capture->id = -1;
>>> -             pdev_capture->resource = res_irq;
>>> +             pdev_capture->resource = &res_irq;
>>>               pdev_capture->num_resources = 1;
>>>               pdev_capture->dev.dma_mask = pdev->dev.dma_mask;
>>>               pdev_capture->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
>>> @@ -480,7 +484,7 @@ static int vpif_probe(struct platform_device *pdev)
>>>       if (pdev_display) {
>>>               pdev_display->name = "vpif_display";
>>>               pdev_display->id = -1;
>>> -             pdev_display->resource = res_irq;
>>> +             pdev_display->resource = &res_irq;
>>>               pdev_display->num_resources = 1;
>>>               pdev_display->dev.dma_mask = pdev->dev.dma_mask;
>>>               pdev_display->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
>>> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
>>> index 8fe55374c5a3..aaf8a0ec98ff 100644
>>> --- a/drivers/media/platform/davinci/vpif_capture.c
>>> +++ b/drivers/media/platform/davinci/vpif_capture.c
>>> @@ -1607,7 +1607,6 @@ static __init int vpif_probe(struct platform_device *pdev)
>>>  {
>>>       struct vpif_subdev_info *subdevdata;
>>>       struct i2c_adapter *i2c_adap;
>>> -     struct resource *res;
>>>       int subdev_count;
>>>       int res_idx = 0;
>>>       int i, err;
>>> @@ -1632,15 +1631,22 @@ static __init int vpif_probe(struct platform_device *pdev)
>>>               goto vpif_free;
>>>       }
>>>
>>> -     while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
>>> -             err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
>>> -                                     IRQF_SHARED, VPIF_DRIVER_NAME,
>>> -                                     (void *)(&vpif_obj.dev[res_idx]->
>>> -                                     channel_id));
>>> -             if (err) {
>>> -                     err = -EINVAL;
>>> +     while (1) {
>>> +             int irq;
>>> +
>>> +             err = platform_get_irq_optional(pdev, res_idx);
>>> +             if (err < 0 && err != -ENXIO)
>>> +                     goto vpif_unregister;
>>> +             if (err > 0)
>>> +                     irq = err;
>>> +             else
>>> +                     break;
>>> +
>>> +             err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
>>> +                                    IRQF_SHARED, VPIF_DRIVER_NAME,
>>> +                                    (void *)(&vpif_obj.dev[res_idx]->channel_id));
>>> +             if (err)
>>>                       goto vpif_unregister;
>>> -             }
>>>               res_idx++;
>>>       }
>>>
>>> diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
>>> index 59f6b782e104..c4a0c4a4448c 100644
>>> --- a/drivers/media/platform/davinci/vpif_display.c
>>> +++ b/drivers/media/platform/davinci/vpif_display.c
>>> @@ -1221,7 +1221,6 @@ static __init int vpif_probe(struct platform_device *pdev)
>>>  {
>>>       struct vpif_subdev_info *subdevdata;
>>>       struct i2c_adapter *i2c_adap;
>>> -     struct resource *res;
>>>       int subdev_count;
>>>       int res_idx = 0;
>>>       int i, err;
>>> @@ -1245,13 +1244,21 @@ static __init int vpif_probe(struct platform_device *pdev)
>>>               goto vpif_free;
>>>       }
>>>
>>> -     while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
>>> -             err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
>>> -                                     IRQF_SHARED, VPIF_DRIVER_NAME,
>>> -                                     (void *)(&vpif_obj.dev[res_idx]->
>>> -                                     channel_id));
>>> +     while (1) {
>>> +             int irq;
>>> +
>>> +             err = platform_get_irq_optional(pdev, res_idx);
>>> +             if (err < 0 && err != -ENXIO)
>>> +                     goto vpif_unregister;
>>> +             if (err > 0)
>>> +                     irq = err;
>>> +             else
>>> +                     break;
>>> +
>>> +             err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
>>> +                                    IRQF_SHARED, VPIF_DRIVER_NAME,
>>> +                                    (void *)(&vpif_obj.dev[res_idx]->channel_id));
>>>               if (err) {
>>> -                     err = -EINVAL;
>>>                       vpif_err("VPIF IRQ request failed\n");
>>>                       goto vpif_unregister;
>>>               }
>>

