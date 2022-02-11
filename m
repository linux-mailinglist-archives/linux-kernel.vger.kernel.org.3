Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97D44B2E73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353227AbiBKUam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:30:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353223AbiBKUak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:30:40 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F50B4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:30:38 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nIcYq-001xkD-Mm; Fri, 11 Feb 2022 21:30:32 +0100
Received: from p57ae5b61.dip0.t-ipconnect.de ([87.174.91.97] helo=[192.168.178.35])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nIcYq-002EU7-G5; Fri, 11 Feb 2022 21:30:32 +0100
Message-ID: <dde846f0-1324-7fde-ef92-eb72d4200b50@physik.fu-berlin.de>
Date:   Fri, 11 Feb 2022 21:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
References: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
 <63f06bf0-fc7b-3c5c-8af9-5adfd7628354@omp.ru>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <63f06bf0-fc7b-3c5c-8af9-5adfd7628354@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.174.91.97
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey!

On 2/11/22 21:28, Sergey Shtylyov wrote:
> On 2/11/22 11:15 PM, Sergey Shtylyov wrote:
> 
>> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
>> and the code supporting SH3/4 SoCs maps the IRQ #s starting at 0 -- modify
>> that code to start the IRQ #s from 16 instead.
>>
>> [1] https://lore.kernel.org/all/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> The patch is against Linus Torvalds' 'linux.git' repo.
>>
>>  arch/sh/kernel/cpu/sh3/entry.S |    4 ++--
>>  include/linux/sh_intc.h        |    6 +++---
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> Index: linux/arch/sh/kernel/cpu/sh3/entry.S
>> ===================================================================
>> --- linux.orig/arch/sh/kernel/cpu/sh3/entry.S
>> +++ linux/arch/sh/kernel/cpu/sh3/entry.S
>> @@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
>>  	mov	r4, r0		! save vector->jmp table offset for later
>>  
>>  	shlr2	r4		! vector to IRQ# conversion
>> -	add	#-0x10, r4
>>  
>> -	cmp/pz	r4		! is it a valid IRQ?
>> +	mov	#0x10, r5
>> +	cmp/ge	r5, r4		! is it a valid IRQ?
> 
>    Maybe I should've used cmp/hs... my 1st try at SH assembly! :-)

I can test your revised patch next week on my SH7785LCR.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

