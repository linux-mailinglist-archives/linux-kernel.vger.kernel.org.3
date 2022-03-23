Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74104E4CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbiCWGbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCWGbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:31:17 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F43554B5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:29:48 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.71.26])
        by gnuweeb.org (Postfix) with ESMTPSA id E2BE57E342;
        Wed, 23 Mar 2022 06:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648016987;
        bh=rTYefPkm+7jh3YIcnrUKbBW9z+mAVw1UIN7o+WWdb6g=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
        b=t0UH9wr/A8UAyjs5YliU2fVLk2EdDwauQN1d5rIafsqmJvmDsRIqhhUdBeyxEXGYB
         17688upkz47HJcZV9s8yT33VGgTByJHsdWQQE109w68t9w+TZYQRR8bcCgpFCLuUl2
         U7WUb03B/zgOdI2o+stWvpmqb8vDMcw06vCtQ6tQmZZ1hAiMhCtaSB8fNrczxSPU3a
         ejE6x6GxivbB9fX2evVsclML/a/z8TI2n/LC6ny5hCAA+tMSSxaO0X089WOKTWlXii
         wgABX5JvJuR3uvODbLh2B8fX81o79u71FZ23S2gPS2BmxSooy8D3bWJH0ppbrD1nz6
         l0CRZY4NiTgyQ==
Message-ID: <2eba5687-6b63-ceb2-3fbd-3d236727ea11@gnuweeb.org>
Date:   Wed, 23 Mar 2022 13:29:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     David Laight <David.Laight@ACULAB.COM>, 'Willy Tarreau' <w@1wt.eu>
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
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
 <22fd9709b3a64a548226741b682ca155@AcuMS.aculab.com>
Content-Language: en-US
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
In-Reply-To: <22fd9709b3a64a548226741b682ca155@AcuMS.aculab.com>
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

On 3/22/22 8:37 PM, David Laight wrote:
> dunno, 'asm' register variables are rather more horrid and
> should probably only be used (for asm statements) when there aren't
> suitable register constraints.
> 
> (I'm sure there is a comment about that in the gcc docs.)

^ Hey David, yes you're right, that is very interesting...

I hit a GCC bug when playing with syscall6() implementation here.

Using register variables for all inputs for syscall6() causing GCC 11.2
stuck in an endless loop with 100% CPU usage. Reproducible with several
versions of GCC.

In GCC 6.3, the syscall6() implementation above yields ICE (Internal
Compiler Error):
```
   <source>: In function '__sys_mmap':
   <source>:35:1: error: unable to find a register to spill
    }
    ^
   <source>:35:1: error: this is the insn:
   (insn 14 13 30 2 (set (reg:SI 95 [92])
           (mem/c:SI (plus:SI (reg/f:SI 16 argp)
                   (const_int 28 [0x1c])) [1 offset+0 S4 A32])) <source>:33 86 {*movsi_internal}
        (expr_list:REG_DEAD (reg:SI 16 argp)
           (nil)))
   <source>:35: confused by earlier errors, bailing out
   Compiler returned: 1
```
See the full show here: https://godbolt.org/z/dYeKaYWY3

Using the appropriate constraints, it compiles nicely, now it looks
like this:
```
   #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
   ({								\
   	long _eax  = (long)(num);				\
   	long _arg6 = (long)(arg6); /* Always be in memory */	\
   	asm volatile (						\
   		"pushl	%[_arg6]\n\t"				\
   		"pushl	%%ebp\n\t"				\
   		"movl	4(%%esp), %%ebp\n\t"			\
   		"int	$0x80\n\t"				\
   		"popl	%%ebp\n\t"				\
   		"addl	$4,%%esp\n\t"				\
   		: "+a"(_eax)		/* %eax */		\
   		: "b"(arg1),		/* %ebx */		\
   		  "c"(arg2),		/* %ecx */		\
   		  "d"(arg3),		/* %edx */		\
   		  "S"(arg4),		/* %esi */		\
   		  "D"(arg5),		/* %edi */		\
   		  [_arg6]"m"(_arg6)	/* memory */		\
   		: "memory", "cc"				\
   	);							\
   	_eax;							\
   })
```
Link: https://godbolt.org/z/ozGbYWbPY

Will use that in the next patchset version.

-- 
Ammar Faizi

