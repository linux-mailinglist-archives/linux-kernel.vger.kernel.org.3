Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EAB4E3F80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiCVN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiCVN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:28:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82586E18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:26:48 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 27DA87E2DF;
        Tue, 22 Mar 2022 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647955607;
        bh=SKM43D9jDBq+PWDOPBX3QtOzn+TW4kuM/fe+xnCwC/k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PbUywEleF/ZAh7d/Q0QM2FLLqGcJDHh3Bnp1FuuSZVHvDKGlnXorXzwiTk+H7QyFs
         5kXTKXnyoR7y00+wug7GGo/IiyaYuugAx4JpRBOsRp0pTyhMGjuMxxpcYMk3Lfeqqx
         0UZyJgqhH1yvH7EWrJDwLJ4V3+YiNVzXqYjermxXLrouTvY4OlwTBzOMApswMng4vh
         X4PC6leIptY6ORiiC3hpk1qICmTlOD+UkiyMFg0karoCZfuuxWlZe+alAYCL0xmsAX
         NRnP0WSKSLggQlIhUAZbE/i5GdP/a2KvfAFH6CtkMWUyx7thFLHnUj/RzwK0OmOJus
         5iwSpioO3BNYw==
Message-ID: <81569a1c-a6d3-ceb2-a1f1-f229a024d684@gnuweeb.org>
Date:   Tue, 22 Mar 2022 20:26:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220322121338.GD10306@1wt.eu>
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

On 3/22/22 7:13 PM, Willy Tarreau wrote:
> On Tue, Mar 22, 2022 at 07:02:53PM +0700, Ammar Faizi wrote:
>> I propose the
>> following macro (this is not so much different with other my_syscall macro),
>> expect the 6th argument can be in reg or mem.
>>
>> The "rm" constraint here gives the opportunity for the compiler to use %ebp
>> instead of memory if -fomit-frame-pointer is turned on.
>>
>> #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) \
>> ({                                                         \
>>      long _ret;                                             \
>>      register long _num asm("eax") = (num);                 \
>>      register long _arg1 asm("ebx") = (long)(arg1);         \
>>      register long _arg2 asm("ecx") = (long)(arg2);         \
>>      register long _arg3 asm("edx") = (long)(arg3);         \
>>      register long _arg4 asm("esi") = (long)(arg4);         \
>>      register long _arg5 asm("edi") = (long)(arg5);         \
>>      long _arg6 = (long)(arg6); /* Might be in memory */    \
>>                                                             \
>>      asm volatile (                                         \
>>          "pushl  %[_arg6]\n\t"                              \
>>          "pushl  %%ebp\n\t"                                 \
>>          "movl   4(%%esp), %%ebp\n\t"                       \
>>          "int    $0x80\n\t"                                 \
>>          "popl   %%ebp\n\t"                                 \
>>          "addl   $4,%%esp\n\t"                              \
>>          : "=a"(_ret)                                       \
>>          : "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3),   \
>>            "r"(_arg4),"r"(_arg5), [_arg6]"rm"(_arg6)        \
>>          : "memory", "cc"                                   \
>>      );                                                     \
>>      _ret;                                                  \
>> })
>>
>> What do you think?
> 
> Hmmm indeed that comes back to the existing constructs and is certainly
> more in line with the rest of the code (plus it will not be affected by
> -O0).
> 
> I seem to remember a register allocation issue which kept me away from
> implementing it this way on i386 back then, but given that my focus was
> not as much on i386 as it was on other platforms, it's likely that I have
> not insisted too much and not tried this one which looks like the way to
> go to me.

I turned out GCC refuses to use "rm" if we compile without -fomit-frame-pointer
(e.g. without optimization / -O0). So I will still use "m" here.

-- 
Ammar Faizi
