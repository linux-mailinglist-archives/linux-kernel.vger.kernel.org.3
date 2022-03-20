Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9A4E1C24
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbiCTPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiCTPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:05:57 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23810EB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:04:22 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.4])
        by gnuweeb.org (Postfix) with ESMTPSA id 4EBE17E2DA;
        Sun, 20 Mar 2022 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647788661;
        bh=KLLyJlTg8Kh9KZF5IRbm0662lOq7PeTUPfZKT4sNVEg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=FqO1IW11GAyvJsc83NNz14DVFfn3i26xV3PuQu6wC+UcTxx+TZQ5g06TYEpAhdm9J
         P5panWybU2h05ExCNvlVmIeptNpiAb+aX1ewutJ7mK6eNgbcMp/LVrXnonvl8Y9J97
         pWszC7Sriu4zBvCqCp8lqE9VKfPVsuRPqaF/sQVtgg1fJJEVi/qKxWtjT3NQpYdapH
         O75op3eIMBVaZvaGVcsmlb1iBmNhVyjn4CUJ+r63ILXpzmITch0U6F65cLrlQOWqls
         oXC9kG4NHw50qAfQvhvRqRFFJ5CMEhWazh/HIxzmCOH1nDY6HCWQdIpcI0om3R5d1r
         LS2ewanUAJovA==
Message-ID: <263c1f21-c0d6-deb1-d45e-66fd35715447@gnuweeb.org>
Date:   Sun, 20 Mar 2022 22:04:14 +0700
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
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
 <2e335ac54db44f1d8496583d97f9dab0@AcuMS.aculab.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6
 arguments
In-Reply-To: <2e335ac54db44f1d8496583d97f9dab0@AcuMS.aculab.com>
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

On 3/20/22 8:10 PM, David Laight wrote:
> From: Ammar Faizi
>> Sent: 20 March 2022 09:38
>>
>> In i386, the 6th argument of syscall goes in %ebp. However, both Clang
>> and GCC cannot use %ebp in the clobber list and in the "r" constraint
>> without using -fomit-frame-pointer. To make it always available for any
>> kind of compilation, the below workaround is implemented.
>>
>> For clang (the Assembly statement can't clobber %ebp):
>>    1) Save the %ebp value to the redzone area -4(%esp).
> 
> i386 doesn't have a redzone.
> If you get a signal it will trash -4(%sp)

OK, I missed that one. Thanks for reviewing this.

>> For GCC, fortunately it has a #pragma that can force a specific function
>> to be compiled with -fomit-frame-pointer, so it can always use "r"(var)
>> where `var` is a variable bound to %ebp.
> 
> How is that going to work for an inlined functon?

It works, but obviously the inline modifier here is just a hint for the
compiler, not a requirement. I just took a look at the GCC generated code.
It doesn't inline the ____do_syscall6() despite it's marked as inline.

I think this one shouldn't be marked as inline. I will remove the inline
in the next version.

> And using xchg is slow - it is always locked.
> 
> One possibility might be to do:
> 	push arg6
> 	push %ebp
> 	mov  %ebp, 4(%sp)

Did you mean `mov 4(%esp), %ebp`?

> 	int  0x80
> 	pop  %ebp
> 	add  %esp,4

I think your solution is better than the xchg approach (with the 3rd line
fixed). Will take this in for the next version.

> Although I'm not sure you really want to allocate 4k pages
> for every malloc() call.
> 
> Probably better to write a mini 'libc' that uses sbrk()
> and a best fit scan of a linear free list.

^ This part is addressed by Willy's response. I will still go with mmap()
in the next version.

And yes, we do waste space for small allocations here, but we don't hit
the scale that the waste space will cause problem.

-- 
Ammar Faizi
