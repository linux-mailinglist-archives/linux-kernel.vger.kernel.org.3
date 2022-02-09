Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1F34AFD84
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiBITbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:31:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiBITbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:31:16 -0500
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6037C0219A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:22:57 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id HsQsnZO3wbnFGHsQtncXNY; Wed, 09 Feb 2022 20:15:16 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 09 Feb 2022 20:15:16 +0100
X-ME-IP: 90.126.236.122
Message-ID: <9c563d78-f883-65ee-9e7b-cf44e3b238e8@wanadoo.fr>
Date:   Wed, 9 Feb 2022 20:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Content-Language: en-GB
To:     David Laight <David.Laight@ACULAB.COM>,
        'Jiapeng Chong' <jiapeng.chong@linux.alibaba.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220121114955.96979-1-jiapeng.chong@linux.alibaba.com>
 <03591933cc384d7e91ede82f0cdd76a8@AcuMS.aculab.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <03591933cc384d7e91ede82f0cdd76a8@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/01/2022 à 14:34, David Laight a écrit :
> From: Jiapeng Chong
>> Sent: 21 January 2022 11:50
>> Subject: [PATCH] staging: pi433: using div64_u64() instead of do_div()
>>
>> Clean the following coccicheck warning:
>>
>> ./drivers/staging/pi433/rf69.c:286:1-7: WARNING: do_div() does a
>> 64-by-32 division, please consider using div64_u64 instead.
> 
> That is one of patchcheck's worse warnings.
> 
> You need to check the domain of the divisor, not its type.
> 
> do_div() exists to avoid expensive 64bit divides when the
> divisor is small.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 

Moreover, the patch is broken by itself.

See [1] were it was already reported that do_div() and div64_u64() don't 
have the same calling convention.

Looks that div64_u64() and div64_ul() works the same way.


CJ

[1]: 
https://lore.kernel.org/linux-kernel/20211117112559.jix3hmx7uwqmuryg@pengutronix.de/ 

