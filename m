Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35F4E60C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349067AbiCXJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiCXJBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:01:50 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E5972E1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:00:19 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id 47FC67E6FF;
        Thu, 24 Mar 2022 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648112418;
        bh=RrYToTS3ZUOh2cUKEiBGqlhtdbPXGZlb2By1N74obmo=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=liz7mWAmJ0S+3flucrB8nF3mKNESBOr0EBylNIiPsZsOTO/gu4z8jHDS6Ranpxxqj
         8WHPpIjZLgGPMDGMsHUj0mekpUf8EPGL/YRTwoCse7231O8ouA/+9fg/qt3riMqWQp
         3qJFHaqfNUiOdBj7zosyyJlXM0ZdRMKfN0Pvx3+bjVaNBi+6DU7nAp0GGlhl3TYo22
         xOobEsFDI0xgT899OwhwWYOfaF8EKLdEa7noAKUFB/jMxG/4v1BYCj4TmQSkYuWeIS
         Bni97cNJ2RoPJOJIg8AuaF9roVJPy0nceXrX6PW1yWssqyeIe3/nU3QQe69yHK7xKj
         SIbV6OC5+sIFQ==
Message-ID: <266d7b7b-b803-51de-280e-35e16aa82248@gnuweeb.org>
Date:   Thu, 24 Mar 2022 16:00:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        David Laight <David.Laight@aculab.com>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
 <20220324073039.140946-5-ammarfaizi2@gnuweeb.org>
 <20220324075728.GC18586@1wt.eu>
 <CAOG64qMwKYHLrUVro1gFhYqHvm8wq5DUdO7QfK5gG2TKhfnNhA@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v1 04/11] tools/nolibc: x86-64: Use appropriate register
 constraints if exist
In-Reply-To: <CAOG64qMwKYHLrUVro1gFhYqHvm8wq5DUdO7QfK5gG2TKhfnNhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 3:33 PM, Alviro Iskandar Setiawan wrote:
> On Thu, Mar 24, 2022 at 2:57 PM Willy Tarreau <w@1wt.eu> wrote:
>> On Thu, Mar 24, 2022 at 02:30:32PM +0700, Ammar Faizi wrote:
>>> Use appropriate register constraints if exist. Don't use register
>>> variables for all inputs.
>>>
>>> Register variables with "r" constraint should be used when we need to
>>> pass data through a specific register to extended inline assembly that
>>> doesn't have a specific register constraint associated with it (anything
>>> outside %rax, %rbx, %rcx, %rdx, %rsi, %rdi).
>>>
>>> It also simplifies the macro definition.
>>
>> I'm a bit bothered by this one because I went the exact opposite route
>> in the early design precisely because I found that the current one was
>> simpler. [...]
> [...]
>> I'd say that if there is any technical benefit in doing this (occasional
>> code improvement or better support for older or exotic compilers), I'd say
>> "ok go for it", but if it's only a matter of taste, I'm not convinced at
>> all and am rather seeing this as a regression. Now if there's rough
>> consensus around this approach I'll abide, but then I'd request that other
>> archs are adapted as well so that we don't keep a different approach only
>> for these two ones.
> 
> I don't see any technical benefit for x86-64, so I don't think there
> is a need in doing this. Though I personally prefer to use register
> constraints if they exist instead of register variables for everything
> (oh yeah, matter of taste since I don't have any technical argument to
> say it's better respecting the resulting codegen). The only real issue
> is for the syscall6() implementation on i386 as we've been bitten by a
> real compiler issue. In short, I am neutral on this change.

OK then, I will drop this patch in the next version. I agree that it
doesn't really show any technical benefit and there is no danger in
doing the current implementation.

And yes, the syscall6() for i386 is somewhat problematic and we've a
confirmed bug that lives in many versions of GCC and it's not even fixed
in the current trunk. It's proven that using register constraints can
be a valid workaround to deal with this bug.

2022-03-23 13:50:18 UTC, Jakub Jelinek wrote:
> Anyway, with the "b" etc. constraints (which is a good idea to use on
> x86 when it has single register constraints for those but can't be used
> on other arches which do not have such constraints) you just trigger
> slightly different path in the RA, [...]
See the discussion here:
    
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105032#c7

^^^ That is only for syscall6() on i386.

As such, I will drop this patch and another one that does this on i386.

Thanks!
-- 
Ammar Faizi
