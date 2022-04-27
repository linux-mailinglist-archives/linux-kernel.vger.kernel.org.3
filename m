Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94303512226
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiD0TLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiD0TLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:11:02 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F880227
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:59:43 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru E307C20B0E77
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
References: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
 <YmfNi3j/sL9PdByv@kroah.com>
Organization: Open Mobile Platform
Message-ID: <d0a51ca4-e535-01cc-fb08-2a59ad2e50dd@omp.ru>
Date:   Wed, 27 Apr 2022 21:59:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YmfNi3j/sL9PdByv@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 4/26/22 1:46 PM, Greg Kroah-Hartman wrote:

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
>> Acked-by: Marc Zyngier <maz@kernel.org>

[...]

> Ok, let's try this now.

   Well, better late than never! :-)

> Worst case, we revert it later :)

   Please just don't revert it outright on the 1st issue report -- give me time
to look at the issue(s) reported...
   BTW, I've CC'ed you on the SH patch that avoids using IRQ0. Please help to
merge it (v1/v2 were posted on February 11th and there was no motion since then)!

> thanks,
> 
> greg k-h

MBR, Sergey
