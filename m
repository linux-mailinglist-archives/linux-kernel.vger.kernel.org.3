Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E524888DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiAILbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:31:46 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:60122 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiAILbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:31:45 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 0442E20E3CB6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <YbJhu53WEmotslox@smile.fi.intel.com>
 <59f08001-7e1e-7fe2-28ba-045972bbae90@omp.ru>
 <YbM3T29wPZFLMu1D@smile.fi.intel.com>
 <8a415980-990b-abae-6f60-dedd0c199583@omp.ru>
 <CAHp75VddS225riMvTD36M4UNKC=zKYLCmUdJsACvWbf7=8CqRA@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a45b348e-3d98-2343-6648-b2ec817bb236@omp.ru>
Date:   Sun, 9 Jan 2022 14:31:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VddS225riMvTD36M4UNKC=zKYLCmUdJsACvWbf7=8CqRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 1:09 PM, Andy Shevchenko wrote:

>>>>> Wanna help?
>>>>
>>>>    No, I'm afraid you're on your own here...
>>
>>    Tell me please, how far you've got with this by now?
>>    (I've already started to add the fixups to your patch -- unfortunately, this change has to be
>> done atomically, not piecemeal.)

   Now I'm doing "the 2nd pass" over the platform_get_irq_optional() patch, and I think I'm done
with the 2nd, platform_get_irq_byname_optional() patch... Expecting to post those 2 early next week.

> I just returned from vacation and will have another one soon, I don't
> think I will be doing much for the next couple of weeks.

   You've settled in well -- having (several!) vacations while I've been doing your homework for you
during my holidays. B-)

>>>>>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
>>>>>
>>>>> Not sure.
>>>>
>>>>    Why? It fixes gthe IRQ0 problem, so that you don't have to check for IRQ0 in many callers
>>>> (for the subsytems that treat 0 as s/th special, like polling mode)... If you have something
>>>> to improve, you can do that atop of this patch...
>>>
>>> Because first we need to fix all users of platform_get_irq_optional().
>>
>>    I still don't understand why your issue should be fixed 1st -- but I don't really care about
>> the order...
> 
> See my other comments on the discussion.
> The rough roadmap is:
> 1) check which drivers are still subjects of vIRQ0 which is retrieved
> via IRQ resource

   We have WARN() added for that -- which isn't even limited to the static IRQ resources...

> 2) fix them accordingly (for example, by transforming to IRQ domains)

   I think we may choose to do a quick workaround, with the IRQ domain transformation somewhat
deferred...

> 3) convert platform_get_irq() and Co (including optional variants) to
> follow the pattern
>  a) non-optional APIs never return 0
>  b) optional APIs return negative error, or positive vIRQ or 0 when
> IRQ not found

   Yeah, and that means that we should 1st convert your platform_do_get_irq() (I'm renaming it)to not return 0 on IRQ0 -- in order to avoid the ambiguity with the "IRQ not found" outcome.

> Alternatively you may put a big comment in the drivers first and use
> platform_get_resource() for retrieving IRQ0 without WARN(). Then they
> will be subject to fix later on.

  No -- that would be a step backward, I think...

MBR, Sergey
