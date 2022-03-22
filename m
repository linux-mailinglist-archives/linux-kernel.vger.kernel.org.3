Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2921A4E3E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiCVMEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiCVME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:04:29 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC3923E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:03:02 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 6DA6E7E308;
        Tue, 22 Mar 2022 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647950581;
        bh=ZQJLnPz+HIze1L/LflEJoR20vMyXMwvNahO4vlcWCnQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=dLsuuOGV+8ZBwuvsEC2HBuXMQE+Xn8Lg4T02mmYnNCpHVATJa7Ma8TOsD5GmYwWNt
         43UxIyR8OErh32Ao8p7G97hP3/urxGAMwybm/Ob7lrDzc5ME8Smv1/ZJxiOJSUyiun
         jxA3glPl86F+W2iTX0Cohd2YyZ/sNYWwQp1od2rfG6fo8bO8G2pjgcIrAEq6D38v3K
         5nVp6YnAcd7+9wigAhz/qymTN39BN3eqPUYil/TLa29AmfUR9ZpFxoqrSdSQ01iJts
         01j0X4QzyWbUoYM2jjySnfKLibjJgOUQW/Qsz1c6Ru0Zs3JEEn3E31BPoUDJdYjCeH
         mFRrBry7B57mA==
Message-ID: <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
Date:   Tue, 22 Mar 2022 19:02:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>, Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
In-Reply-To: <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
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

On 3/22/22 6:39 PM, David Laight wrote:
>> +	__asm__ volatile (
>> +		"pushl	%[arg6]\n\t"
>> +		"pushl	%%ebp\n\t"
>> +		"movl	4(%%esp), %%ebp\n\t"
>> +		"int	$0x80\n\t"
>> +		"popl	%%ebp\n\t"
>> +		"addl	$4,%%esp\n\t"
>> +		: "=a"(eax)
>> +		: "a"(eax), "b"(ebx), "c"(ecx), "d"(edx), "S"(esi), "D"(edi),
> 
> Does having "=a" for an output constraint and "a" for an input
> constraint actually DTRT?
> There is a special syntax for tying input and output to
> the same register.
> Or you could use "+a"(nr_rval) and 'return nr_rval'.

Well, I agree with your previous email. Now since we no longer use a #pragma
optimize with -fomit-frame-pointer, the function is not needed. I propose the
following macro (this is not so much different with other my_syscall macro),
expect the 6th argument can be in reg or mem.

The "rm" constraint here gives the opportunity for the compiler to use %ebp
instead of memory if -fomit-frame-pointer is turned on.

#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) \
({                                                         \
     long _ret;                                             \
     register long _num asm("eax") = (num);                 \
     register long _arg1 asm("ebx") = (long)(arg1);         \
     register long _arg2 asm("ecx") = (long)(arg2);         \
     register long _arg3 asm("edx") = (long)(arg3);         \
     register long _arg4 asm("esi") = (long)(arg4);         \
     register long _arg5 asm("edi") = (long)(arg5);         \
     long _arg6 = (long)(arg6); /* Might be in memory */    \
                                                            \
     asm volatile (                                         \
         "pushl  %[_arg6]\n\t"                              \
         "pushl  %%ebp\n\t"                                 \
         "movl   4(%%esp), %%ebp\n\t"                       \
         "int    $0x80\n\t"                                 \
         "popl   %%ebp\n\t"                                 \
         "addl   $4,%%esp\n\t"                              \
         : "=a"(_ret)                                       \
         : "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3),   \
           "r"(_arg4),"r"(_arg5), [_arg6]"rm"(_arg6)        \
         : "memory", "cc"                                   \
     );                                                     \
     _ret;                                                  \
})

What do you think?

-- 
Ammar Faizi
