Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0975316AD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiEWUQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiEWUQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:16:12 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C110554
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:16:08 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id tETGnTFRzAym2tETGnHes4; Mon, 23 May 2022 22:16:07 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 23 May 2022 22:16:07 +0200
X-ME-IP: 86.243.180.246
Message-ID: <00061a71-4d7c-0605-80b5-3d909fc3dfaa@wanadoo.fr>
Date:   Mon, 23 May 2022 22:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] kbuild: Add an option to enable -O1 and speed-up
 compilation time
Content-Language: en-GB
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dan.carpenter@oracle.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
References: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
 <CAKwvOdneqUvq+Nz_zPmJmuPFfAvWQgnzrw1AJt=WqQF2hThF-A@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAKwvOdneqUvq+Nz_zPmJmuPFfAvWQgnzrw1AJt=WqQF2hThF-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/05/2022 à 20:26, Nick Desaulniers a écrit :
> On Sat, May 21, 2022 at 2:04 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Add a new compilation option which speeds-up compilation time.
>> This can be useful when using static checker such as smatch or build-bots.
>> In such cases, the speed and quality of the generated code is not
>> important.
>>
>> Using -O0 would be even better, but unfortunately, building fails with
>> this option.
> 
> Which is a tragedy.
> 
> As with the Rust series, I'm not a fan of this (or
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3):
> https://lore.kernel.org/lkml/CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com/
> 
> These feel more like attempts to wrap every conceivable command line
> flag in a kconfig option, which makes me think of that meme from
> Jurassic Park: "your scientists were so preoccupied with whether or
> not they could, they didn't stop to think if they should."
> Not a fan.  I'd ask for measurements, but that would be a request for
> a "rock fetching quest" for something I still wouldn't be a fan of.

Hi,

some preliminary tests gave roughly a 5% build time speed-up with -O1.
That is to say that the impact seems quite limited, after all.
This was done on building /drivers/net/ or /drivers/net/ethernet/ only.

I don't have numbers for the impact on memory consumption.

Given the feedbacks on -O1 which is unlikely to be able to build a full 
kernel and your position on yet another option for a very specific use 
case, I won't push the idea further.

I'll keep it in my own tree for (small) build time improvement when 
running smatch.

The idea of turning off a subset of -O2 options would just be some too 
fine tuning. I'll certainly try it for my own use, but it would end to 
an un-understandable list of flags in Makefile.
-O1 (or -O0) was simple. A more complex solution is way too much.


Thanks for your feedbacks.

CJ

> 
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   Makefile     | 5 ++++-
>>   init/Kconfig | 8 ++++++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 1f8bef92868f..14467386f947 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -817,7 +817,10 @@ KBUILD_CFLAGS      += $(call cc-disable-warning, format-truncation)
>>   KBUILD_CFLAGS  += $(call cc-disable-warning, format-overflow)
>>   KBUILD_CFLAGS  += $(call cc-disable-warning, address-of-packed-member)
>>
>> -ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
>> +ifdef CONFIG_CC_OPTIMIZE_FOR_COMPILATION_SPEED
>> +KBUILD_CFLAGS += -O1
>> +KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 1
>> +else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
>>   KBUILD_CFLAGS += -O2
>>   KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 2
>>   else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
>> diff --git a/init/Kconfig b/init/Kconfig
>> index a96776a9b080..3177a1830c9a 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1384,6 +1384,14 @@ choice
>>          prompt "Compiler optimization level"
>>          default CC_OPTIMIZE_FOR_PERFORMANCE
>>
>> +config CC_OPTIMIZE_FOR_COMPILATION_SPEED
>> +       bool "Optimize for compilation speed (-O1)"
>> +       help
>> +         This option can be useful when running a static checker such as smatch
>> +         or a build-bot.
>> +         Compilation time is slighly faster than -O2 and it requires less
> 
> s/slighly/slightly/

Thanks for taking time for a full review, even on something you are not 
fan on. This is really appreciated.

CJ

> 
>> +         memory.
>> +
>>   config CC_OPTIMIZE_FOR_PERFORMANCE
>>          bool "Optimize for performance (-O2)"
>>          help
>> --
>> 2.34.1
>>
> 
> 

