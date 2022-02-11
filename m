Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAECD4B2E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353166AbiBKUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:20:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiBKUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:20:12 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA87CF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:20:10 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 8728320A8995
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Marc Zyngier <maz@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <87pmp7volh.wl-maz@kernel.org> <9c3f9a6e-89b6-b73b-032f-e4b4ee6f72ac@omp.ru>
 <58caf8b54828bcc25cfc65220d29b68f@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <394a53e7-ef96-b99d-e7ee-764e6d89bfb5@omp.ru>
Date:   Fri, 11 Feb 2022 23:20:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <58caf8b54828bcc25cfc65220d29b68f@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 9:08 PM, Marc Zyngier wrote:

[...]
>>>> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
>>>> invalid") only calls WARN() when IRQ0 is about to be returned, however
>>>> using IRQ0 is considered invalid (according to Linus) outside the arch/
>>>> code where it's used by the i8253 drivers. Many driver subsystems treat
>>>> 0 specially (e.g. as an indication of the polling mode by libata), so
>>>> the users of platform_get_irq[_byname]() in them would have to filter
>>>> out IRQ0 explicitly and this (quite obviously) doesn't scale...
>>>> Let's finally get this straight and return -EINVAL instead of IRQ0!
>>>>
>>>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>>
>>>> ---
>>>> The patch is against the 'driver-core-linus' branch of Greg Kroah-Hartman's
>>>> 'driver-core.git' repo.
>>>>
>>>>  drivers/base/platform.c |    6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> Index: driver-core/drivers/base/platform.c
>>>> ===================================================================
>>>> --- driver-core.orig/drivers/base/platform.c
>>>> +++ driver-core/drivers/base/platform.c
>>>> @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
>>>>  out_not_found:
>>>>      ret = -ENXIO;
>>>>  out:
>>>> -    WARN(ret == 0, "0 is an invalid IRQ number\n");
>>>> +    if (WARN(!ret, "0 is an invalid IRQ number\n"))
>>>> +        return -EINVAL;
>>>>      return ret;
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
>>>> @@ -445,7 +446,8 @@ static int __platform_get_irq_byname(str
>>>>
>>>>      r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
>>>>      if (r) {
>>>> -        WARN(r->start == 0, "0 is an invalid IRQ number\n");
>>>> +        if (WARN(!r->start, "0 is an invalid IRQ number\n"))
>>>> +            return -EINVAL;
>>>>          return r->start;
>>>>      }
>>>
>>> Geert recently mentioned that a few architectures (such as sh?) still
>>> use IRQ0 as something valid in limited cases.
>>>
>>> From my PoV, this patch is fine, but please be prepared to fix things
>>> in a couple of years when someone decides to boot a recent kernel on
>>> their pet dinosaur. With that in mind:
>>>
>>> Acked-by: Marc Zyngier <maz@kernel.org>
>>
>>    Greg, so would that ACK be enough? Is there a chance this patch
>> gets finally included
>> into 5.17-rc1? Or should I look into fixing the recently found
>> arch/sh/ issue 1st (as you
>> can see, just WARN()'ing about IRQ0 wasn't enough to get this fixed)?
> 
> Fixing SH would be a good thing.

   Patch posted now, see:

https://lore.kernel.org/all/2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru/.

> Thanks,
> 
>         M.

MBR, Sergey
