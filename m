Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165C64E3FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiCVNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiCVNrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:47:39 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77C2612A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:46:10 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id E54737E2FC;
        Tue, 22 Mar 2022 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647956770;
        bh=HKgnPToOKuDtMd2JSw/Bl1HQmJatv90FvRD6l9jl9jY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pCTjxSUhL5rr31ViBmr/RMoiC2r2s4CGvgFgDjmMFypfINpuGHuLjS+2DNiJ2CiYu
         ahBjCo6pi3R3OngD0DX5g8J9yHOhi9iw5CxPs5eQPFtCh6R8K1v+ay7Nhpktm3b2Bn
         RxkI+I4Ylea+1tv9WjC9PSAHF3IpV+fJuQRNffqoJrNOS7jSApYEFCrBpKknwHp5AH
         VNL0U1x9VGzgXLRFiAINDchQKgTx09w0pcdMqJrGI3eWbSgoN6g5FASYimW2g1jSp4
         +NYHTsF+XIuEyOqqtb+fwpd6HYkXQ89udqUekqH32ASo0xTvV6JKKk1aBJWFCbMuCb
         Yr4IDbYt7jGPA==
Message-ID: <9cfcb296-9dfe-aef1-4209-20a3a95c50ba@gnuweeb.org>
Date:   Tue, 22 Mar 2022 20:45:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>, David Laight <David.Laight@aculab.com>
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
 <81569a1c-a6d3-ceb2-a1f1-f229a024d684@gnuweeb.org>
 <20220322133413.GG10306@1wt.eu>
 <58cb5455-d065-b508-b328-20b57c3a67a7@gnuweeb.org>
 <3b8984ecfbcd4c93aeb468d01728cd74@AcuMS.aculab.com>
 <20220322134100.GH10306@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220322134100.GH10306@1wt.eu>
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

On 3/22/22 8:41 PM, Willy Tarreau wrote:
[...]
>>> When you pushl %ebp, the %esp changes, N(%esp) no longer points to the
>>> 6-th argument.
>>
>> Yep - that is why I wrote the 'push arg6'.
> 
> Got it and you're right indeed, sorry for the noise :-)

Uggh... it seems I hit a GCC bug when playing with -m32 (32-bit code).
I am on Linux x86-64. Compiling without optimization causing GCC stuck
in an endless loop with 100% CPU usage.

I will try to narrow it down and see if I can create a simple reproducer
on this issue.

ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$ gcc --version
gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$ time taskset -c 0 gcc -m32 -ffreestanding -nostdlib -nostartfiles test.c -o test -lgcc
^C

real	0m46.696s
user	0m0.000s
sys	0m0.002s
ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$ time taskset -c 0 gcc -O1 -m32 -ffreestanding -nostdlib -nostartfiles test.c -o test -lgcc

real	0m0.054s
user	0m0.046s
sys	0m0.008s
ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$ time taskset -c 0 gcc -O2 -m32 -ffreestanding -nostdlib -nostartfiles test.c -o test -lgcc

real	0m0.079s
user	0m0.067s
sys	0m0.012s
ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$ time taskset -c 0 gcc -O3 -m32 -ffreestanding -nostdlib -nostartfiles test.c -o test -lgcc

real	0m0.110s
user	0m0.097s
sys	0m0.013s
ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$


-- 
Ammar Faizi
