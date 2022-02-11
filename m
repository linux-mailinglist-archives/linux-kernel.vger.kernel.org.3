Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334034B2EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353319AbiBKUqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:46:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiBKUqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:46:36 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B61A2;
        Fri, 11 Feb 2022 12:46:33 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru CF85C20AC19D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] sh: avoid using IRQ0 on SH3/4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>
References: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
 <63f06bf0-fc7b-3c5c-8af9-5adfd7628354@omp.ru>
 <dde846f0-1324-7fde-ef92-eb72d4200b50@physik.fu-berlin.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e4c1aec0-e8a0-4577-d12b-8e4efedbf7e6@omp.ru>
Date:   Fri, 11 Feb 2022 23:46:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dde846f0-1324-7fde-ef92-eb72d4200b50@physik.fu-berlin.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 11:30 PM, John Paul Adrian Glaubitz wrote:

[...]
>>> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
>>> and the code supporting SH3/4 SoCs maps the IRQ #s starting at 0 -- modify
>>> that code to start the IRQ #s from 16 instead.
>>>
>>> [1] https://lore.kernel.org/all/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> ---
>>> The patch is against Linus Torvalds' 'linux.git' repo.
>>>
>>>  arch/sh/kernel/cpu/sh3/entry.S |    4 ++--
>>>  include/linux/sh_intc.h        |    6 +++---
>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> Index: linux/arch/sh/kernel/cpu/sh3/entry.S
>>> ===================================================================
>>> --- linux.orig/arch/sh/kernel/cpu/sh3/entry.S
>>> +++ linux/arch/sh/kernel/cpu/sh3/entry.S
>>> @@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
>>>  	mov	r4, r0		! save vector->jmp table offset for later
>>>  
>>>  	shlr2	r4		! vector to IRQ# conversion
>>> -	add	#-0x10, r4
>>>  
>>> -	cmp/pz	r4		! is it a valid IRQ?
>>> +	mov	#0x10, r5
>>> +	cmp/ge	r5, r4		! is it a valid IRQ?
>>
>>    Maybe I should've used cmp/hs... my 1st try at SH assembly! :-)

   Yeah, cmp/hs seems m ore correct as we don't subtract any more...

> I can test your revised patch next week on my SH7785LCR.

   Please do, although testing on the AP-SH4A* bords would be a bit more
interesting, as they actually use IRQ0 for the SMSC911x chip...
   Maybe you have SH7786 base board, by chance? 

> Thanks,
> Adrian

MBR, Sergey
