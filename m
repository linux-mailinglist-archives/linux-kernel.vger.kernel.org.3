Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34B7466B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359733AbhLBVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:15:24 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:49130 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358668AbhLBVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:15:23 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru AA6AA207D577
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <YaEJUiZRhkGRZqpt@kroah.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f08072e8-df0a-95b4-0937-47e5763b40dc@omp.ru>
Date:   Fri, 3 Dec 2021 00:11:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YaEJUiZRhkGRZqpt@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/26/21 7:20 PM, Greg Kroah-Hartman wrote:

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
> 
> You need to get approval from the interrrupt developers for this type of
> change, as it is a change and might break existing platforms, right?

   Well, that's always possible... :-)

   I do remember we had issues with the serial driver on the Alchemy MIPS SoCs
back in the 2.6.1x time frame: UART0 used IRQ0 there and the serial driver treated
0 as an indication of the polling mode, IIRC... Now Alchemies have the SoC IRQ0
mapped to the Linux IRQ8, so this is not a problem anymore (the 1st 8 IRQs are
mapped to the MIPS CPU IRQs and IRQ0 isn't even used)...

> thanks,
> 
> greg k-h

MBR, Sergey
