Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2969587005
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiHASBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiHASBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:01:50 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70109FCE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:01:47 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id IZjdo9v61vbzbIZjdofJ15; Mon, 01 Aug 2022 20:01:46 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 01 Aug 2022 20:01:46 +0200
X-ME-IP: 90.11.190.129
Message-ID: <f8f2d73a-4801-fd49-b028-7a643f61ab24@wanadoo.fr>
Date:   Mon, 1 Aug 2022 20:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] timers: Optimize usleep_range()
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <a896e176f0f0b819f8ec5ab8935355d01a642506.1659126514.git.christophe.jaillet@wanadoo.fr>
 <03c2bbe795fe4ddcab66eb852bae3715@AcuMS.aculab.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <03c2bbe795fe4ddcab66eb852bae3715@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/08/2022 à 10:18, David Laight a écrit :
> From: Christophe JAILLET
>> Sent: 29 July 2022 21:29
>>
>> Most of the time the 'min' and 'max' parameters of usleep_range() are
>> constant. We can take advantage of it to pre-compute at compile time
>> some values otherwise computer at run-time in usleep_range_state().
>>
>> Replace usleep_range_state() by a new __nsleep_range_delta_state() function
>> that takes as parameters the pre-computed values.
>>
>> The main benefit is to save a few instructions, especially 2
>> multiplications (x1000 when converting us to ns).
> ...
>>    53                   	push   %rbx
>>    48 89 fb             	mov    %rdi,%rbx
>>    81 e5 cc 00 00 00    	and    $0xcc,%ebp
>> - 49 29 dc             	sub    %rbx,%r12              ; (max - min)
>> - 4d 69 e4 e8 03 00 00 	imul   $0x3e8,%r12,%r12       ; us --> ns (x 1000)
>>    48 83 ec 68          	sub    $0x68,%rsp
>>    48 c7 44 24 08 b3 8a 	movq   $0x41b58ab3,0x8(%rsp)
>>    b5 41
>> @@ -10721,18 +10719,16 @@
>>    31 c0                	xor    %eax,%eax
>>    e8 00 00 00 00       	call   ...
>>    e8 00 00 00 00       	call   ...
>> - 49 89 c0             	mov    %rax,%r8
>> - 48 69 c3 e8 03 00 00 	imul   $0x3e8,%rbx,%rax       ; us --> ns (x 1000)
>> + 48 01 d8             	add    %rbx,%rax
>> + 48 89 44 24 28       	mov    %rax,0x28(%rsp)
>>    65 48 8b 1c 25 00 00 	mov    %gs:0x0,%rbx
>>    00 00
>> - 4c 01 c0             	add    %r8,%rax
>> - 48 89 44 24 28       	mov    %rax,0x28(%rsp)
>>    e8 00 00 00 00       	call   ...
> ...
> 
> Is that really measurable in any test?

I don't think so, even on 32 bits arch.

> Integer multiply is one clock on almost every modern cpu.
> 
> By the time you've allowed for superscaler cpu there is
> probably no difference at all on anything except the simplest
> cpus.

My point is that it is a low hanging fruit.
Just moving some simple computations from one function to another, to 
have the compiler do the job instead of at runtime.

I won't argue the value of the patch itself.
I spotted a potential opportunity and proposed a patch for it.

If someone finds it valuable enough, just take it.
If no-one care, just forget about it.

Both alternative are fine for me.

Best regards,
CJ

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 

