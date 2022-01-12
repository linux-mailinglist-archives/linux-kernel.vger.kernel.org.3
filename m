Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA1348CA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355809AbiALRyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:54:00 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:49460 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355808AbiALRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:53:56 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 5784E205F304
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
 <87pmp7volh.wl-maz@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9c3f9a6e-89b6-b73b-032f-e4b4ee6f72ac@omp.ru>
Date:   Wed, 12 Jan 2022 20:53:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87pmp7volh.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 12:26 PM, Marc Zyngier wrote:

> [Adding Geert]
> 
> On Sat, 06 Nov 2021 20:26:47 +0000,
> Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>>
>> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
>> invalid") only calls WARN() when IRQ0 is about to be returned, however
>> using IRQ0 is considered invalid (according to Linus) outside the arch/
>> code where it's used by the i8253 drivers. Many driver subsystems treat
>> 0 specially (e.g. as an indication of the polling mode by libata), so
>> the users of platform_get_irq[_byname]() in them would have to filter
>> out IRQ0 explicitly and this (quite obviously) doesn't scale...
>> Let's finally get this straight and return -EINVAL instead of IRQ0!
>>
>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> The patch is against the 'driver-core-linus' branch of Greg Kroah-Hartman's
>> 'driver-core.git' repo.
>>
>>  drivers/base/platform.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> Index: driver-core/drivers/base/platform.c
>> ===================================================================
>> --- driver-core.orig/drivers/base/platform.c
>> +++ driver-core/drivers/base/platform.c
>> @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
>>  out_not_found:
>>  	ret = -ENXIO;
>>  out:
>> -	WARN(ret == 0, "0 is an invalid IRQ number\n");
>> +	if (WARN(!ret, "0 is an invalid IRQ number\n"))
>> +		return -EINVAL;
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
>> @@ -445,7 +446,8 @@ static int __platform_get_irq_byname(str
>>  
>>  	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
>>  	if (r) {
>> -		WARN(r->start == 0, "0 is an invalid IRQ number\n");
>> +		if (WARN(!r->start, "0 is an invalid IRQ number\n"))
>> +			return -EINVAL;
>>  		return r->start;
>>  	}
> 
> Geert recently mentioned that a few architectures (such as sh?) still
> use IRQ0 as something valid in limited cases.
> 
> From my PoV, this patch is fine, but please be prepared to fix things
> in a couple of years when someone decides to boot a recent kernel on
> their pet dinosaur. With that in mind:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

   Greg, so would that ACK be enough? Is there a chance this patch gets finally included
into 5.17-rc1? Or should I look into fixing the recently found arch/sh/ issue 1st (as you
can see, just WARN()'ing about IRQ0 wasn't enough to get this fixed)?

> 	M.

MBR, Sergey
