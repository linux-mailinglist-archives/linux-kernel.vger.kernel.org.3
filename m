Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD4F4E3E20
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiCVMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiCVMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:09:09 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F76184ECE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:07:42 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id F29957E308;
        Tue, 22 Mar 2022 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647950861;
        bh=6+Vksk11nsg1faQTkiQCnBBB8df1qVnWOn2yS0BMZik=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=BbQy2doFPp/k3wyxs9aSPO2wEus9iNM6OnCQFsA4LaUig2IIEBWtt+C+utsdua2xM
         qBwTkUddH5lM0BfZKhkHmUBMpIVSDsPtqLcFrEcig9XhJnv0FAZdQX5h92O58k/Ub8
         alHRhOoC50U4OKWB3HUCxpPC/DKZQqkzn3NCqQf9rMVjqRitUC0EV3QIZ9GNCwHVUZ
         NquJroGm9W/ksrRSVwC6aqRHz7UHuvZfosXT4JaHw407aEPLc2/xDGnOx6QJKWS41i
         HM5o3T1wUWgV+5+/vs91oTXoyME7gmhWm9wvpprbt/VBfYU+0Y+3LbzlqS+o2kLSb1
         d+HJSWh+hsZGg==
Message-ID: <bbd23799-3fce-7029-782b-16c5ae8a0f3a@gnuweeb.org>
Date:   Tue, 22 Mar 2022 19:07:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
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
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
In-Reply-To: <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 7:02 PM, Ammar Faizi wrote:
> Well, I agree with your previous email. Now since we no longer use a #pragma
> optimize with -fomit-frame-pointer, the function is not needed. I propose the
> following macro (this is not so much different with other my_syscall macro),
> expect the 6th argument can be in reg or mem.
> 
> The "rm" constraint here gives the opportunity for the compiler to use %ebp
> instead of memory if -fomit-frame-pointer is turned on.
> 
> #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) \
> ({                                                         \
>      long _ret;                                             \
>      register long _num asm("eax") = (num);                 \
>      register long _arg1 asm("ebx") = (long)(arg1);         \
>      register long _arg2 asm("ecx") = (long)(arg2);         \
>      register long _arg3 asm("edx") = (long)(arg3);         \
>      register long _arg4 asm("esi") = (long)(arg4);         \
>      register long _arg5 asm("edi") = (long)(arg5);         \
>      long _arg6 = (long)(arg6); /* Might be in memory */    \
>                                                             \
>      asm volatile (                                         \
>          "pushl  %[_arg6]\n\t"                              \
>          "pushl  %%ebp\n\t"                                 \
>          "movl   4(%%esp), %%ebp\n\t"                       \
>          "int    $0x80\n\t"                                 \
>          "popl   %%ebp\n\t"                                 \
>          "addl   $4,%%esp\n\t"                              \
>          : "=a"(_ret)                                       \
>          : "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3),   \
>            "r"(_arg4),"r"(_arg5), [_arg6]"rm"(_arg6)        \
>          : "memory", "cc"                                   \
>      );                                                     \
>      _ret;                                                  \
> })
> 
> What do you think?
> 

For the following code:

   int main()
   {
     mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
     return 0;
   }

GCC generates this:

   00001000 <main>:
     1000: push   %ebp
     1001: mov    $0xc0,%eax
     1006: mov    $0x1000,%ecx
     100b: mov    $0x3,%edx
     1010: push   %edi
     1011: xor    %ebp,%ebp
     1013: mov    $0xffffffff,%edi
     1018: push   %esi
     1019: mov    $0x22,%esi
     101e: push   %ebx
     101f: xor    %ebx,%ebx
     1021: push   %ebp        <--- arg6 here
     1022: push   %ebp
     1023: mov    0x4(%esp),%ebp
     1027: int    $0x80
     1029: pop    %ebp
     102a: add    $0x4,%esp
     102d: xor    %eax,%eax
     102f: pop    %ebx
     1030: pop    %esi
     1031: pop    %edi
     1032: pop    %ebp
     1033: ret

-- 
Ammar Faizi
