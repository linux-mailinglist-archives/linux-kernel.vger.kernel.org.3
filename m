Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2785B46F4CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhLIUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:25:24 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:46874 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLIUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:25:23 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 243B5208EDA3
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
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <59f08001-7e1e-7fe2-28ba-045972bbae90@omp.ru>
Date:   Thu, 9 Dec 2021 23:21:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YbJhu53WEmotslox@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 11:06 PM, Andy Shevchenko wrote:

>> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
>> invalid") only calls WARN() when IRQ0 is about to be returned, however
>> using IRQ0 is considered invalid (according to Linus) outside the arch/
>> code where it's used by the i8253 drivers. Many driver subsystems treat
>> 0 specially (e.g. as an indication of the polling mode by libata), so
>> the users of platform_get_irq[_byname]() in them would have to filter
>> out IRQ0 explicitly and this (quite obviously) doesn't scale...
>> Let's finally get this straight and return -EINVAL instead of IRQ0!
> 
> You are changing the return value of platform_get_irq_optional().
> The problem here is the proposed change doesn't bring any value in such
> case. platform_get_irq_optional() should be able (at the end of the day)
> to return 3 types of values (as other APIs do):
> 	 > 0: success
> 	== 0: IRQ not found
> 	 < 0: an error that must be consumed by the caller

   I remember that was in your patch that got reverted right after being merged. ;-)
IMHO returning both error code and 0 on failure is a sign of a misdesigned API, it
makes the failure check unnecessarily complex and error prone.

> 0 is unexpected result for non-optional APIs and there you may try to play
> tricks (like replacing it by error code).
> 
> There was a discussion around the topic:
> https://lore.kernel.org/lkml/20210331144526.19439-1-andriy.shevchenko@linux.intel.com/T/#u

   I don't see much of the discussion there...

> Wanna help?

   No, I'm afraid you're on your own here... 

>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> 
> Not sure.

   Why? It fixes gthe IRQ0 problem, so that you don't have to check for IRQ0 in many callers
(for the subsytems that treat 0 as s/th special, like polling mode)... If you have something
to improve, you can do that atop of this patch...

MBR, Sergey
