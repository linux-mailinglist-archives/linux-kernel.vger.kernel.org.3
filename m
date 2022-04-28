Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49836513C47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351614AbiD1UCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351574AbiD1UCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:02:33 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E87BF319
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:59:15 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru D722022F0625
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
References: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
 <YmfNi3j/sL9PdByv@kroah.com> <d0a51ca4-e535-01cc-fb08-2a59ad2e50dd@omp.ru>
 <YmowldgtcBvwkS1M@kroah.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a1791b43-b480-eb3c-c389-d613650dd02b@omp.ru>
Date:   Thu, 28 Apr 2022 22:59:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YmowldgtcBvwkS1M@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 9:13 AM, Greg Kroah-Hartman wrote:

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
>>>> Acked-by: Marc Zyngier <maz@kernel.org>
>>
>> [...]
>>
>>> Ok, let's try this now.
>>
>>    Well, better late than never! :-)
>>
>>> Worst case, we revert it later :)
>>
>>    Please just don't revert it outright on the 1st issue report -- give me time
>> to look at the issue(s) reported...
>>    BTW, I've CC'ed you on the SH patch that avoids using IRQ0. Please help to
>> merge it (v1/v2 were posted on February 11th and there was no motion since then)!
> 
> I can't merge that until a sh maintainer acks it.

   Hm, looking at the arch/sh/ commit history, you've recently merged couple patches
without any ACKs from the SH people. ;-) What concerns you in this case, me touching
the assembly code? Who's worth looping in on that patch, do you think, maybe Andrew
Morton or Linus himself?

> Is that arch even still alive?

   Well, considering J-core should be still alive (there's #jcore channel on Libera.chat,
where you can find Rich Felker as dalias), arch/sh/ must be still alive too...
   It probably needs the better maintainers though... :-)

> thanks,
> 
> greg k-h

MBR, Sergey
