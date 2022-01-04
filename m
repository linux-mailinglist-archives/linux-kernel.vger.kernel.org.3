Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517F848488B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiADT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:28:05 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:45966 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiADT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:28:04 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru E28C92063EC5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <YbJhu53WEmotslox@smile.fi.intel.com>
 <59f08001-7e1e-7fe2-28ba-045972bbae90@omp.ru>
 <YbM3T29wPZFLMu1D@smile.fi.intel.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <8a415980-990b-abae-6f60-dedd0c199583@omp.ru>
Date:   Tue, 4 Jan 2022 22:27:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YbM3T29wPZFLMu1D@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 2:17 PM, Andy Shevchenko wrote:

[...]
>>>> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
>>>> invalid") only calls WARN() when IRQ0 is about to be returned, however
>>>> using IRQ0 is considered invalid (according to Linus) outside the arch/
>>>> code where it's used by the i8253 drivers. Many driver subsystems treat
>>>> 0 specially (e.g. as an indication of the polling mode by libata), so
>>>> the users of platform_get_irq[_byname]() in them would have to filter
>>>> out IRQ0 explicitly and this (quite obviously) doesn't scale...
>>>> Let's finally get this straight and return -EINVAL instead of IRQ0!
>>>
>>> You are changing the return value of platform_get_irq_optional().
>>> The problem here is the proposed change doesn't bring any value in such
>>> case. platform_get_irq_optional() should be able (at the end of the day)
>>> to return 3 types of values (as other APIs do):
>>> 	 > 0: success
>>> 	== 0: IRQ not found
>>> 	 < 0: an error that must be consumed by the caller
>>
>>    I remember that was in your patch that got reverted right after being merged. ;-)
>> IMHO returning both error code and 0 on failure is a sign of a misdesigned API, it
>> makes the failure check unnecessarily complex and error prone.
> 
> I dunno what you are talking about when you mentioned "0 on failure" because 0
> is not the failure, that's what I'm trying to tell.

   OK.
 
>>> 0 is unexpected result for non-optional APIs and there you may try to play
>>> tricks (like replacing it by error code).
>>>
>>> There was a discussion around the topic:
>>> https://lore.kernel.org/lkml/20210331144526.19439-1-andriy.shevchenko@linux.intel.com/T/#u
>>
>>    I don't see much of the discussion there...
> 
> Indeed, it was split between two threads. Another one is this:
> https://lore.kernel.org/linux-serial/20210407101713.8694-1-andriy.shevchenko@linux.intel.com/T/#u

   OK.

>>> Wanna help?
>>
>>    No, I'm afraid you're on your own here... 

   Tell me please, how far you've got with this by now?
   (I've already started to add the fixups to your patch -- unfortunately, this change has to be
done atomically, not piecemeal.)

>>>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
>>>
>>> Not sure.
>>
>>    Why? It fixes gthe IRQ0 problem, so that you don't have to check for IRQ0 in many callers
>> (for the subsytems that treat 0 as s/th special, like polling mode)... If you have something
>> to improve, you can do that atop of this patch...
> 
> Because first we need to fix all users of platform_get_irq_optional().

   I still don't understand why your issue should be fixed 1st -- but I don't really care about
the order...

MBR, Sergey
