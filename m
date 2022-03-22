Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B657D4E3FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiCVNim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiCVNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:38:40 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115AA8149C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:37:13 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 1B5A87E2DF;
        Tue, 22 Mar 2022 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647956232;
        bh=rdpf/p3ar7K9SXDVVY5DTl/I+9COgvsp49f/GNyK6hY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bKpeIMhIsX9hq3a6t0f7FmQmDmMlAQQPdMMlhyxYQSP4NhbGEkm8gBydHVEWdsJKR
         kPBh3ubs96E9zdJg+orETKQw9ZkaBbtILykeSYY+lbpxXJt4Jx7iEqi2ORF8VZaEQH
         VErXh2lbZBJc6FtyuXXz1l9yRlJXoTZjM8oXVs+BmIJns81D8HXJ/+FTb2MQiTAl/d
         1PHFsmr9on7Y6o4yfF3GwU6n8jvJxUNQq+whBsh0ds4zZQu34vFv45ko3NsOQhRKGY
         kpi8X72V7B2fiJ+0K3LGyf99B3DQtugASb5ad/jcrC8iFUIPFiVzn5zObidNI0lI64
         4H8jpGLaitBPA==
Message-ID: <58cb5455-d065-b508-b328-20b57c3a67a7@gnuweeb.org>
Date:   Tue, 22 Mar 2022 20:37:03 +0700
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
 <81569a1c-a6d3-ceb2-a1f1-f229a024d684@gnuweeb.org>
 <20220322133413.GG10306@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220322133413.GG10306@1wt.eu>
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

On 3/22/22 8:34 PM, Willy Tarreau wrote:
>> I turned out GCC refuses to use "rm" if we compile without -fomit-frame-pointer
>> (e.g. without optimization / -O0). So I will still use "m" here.
> 
> OK that's fine. then you can probably simplify it like this:
> 
>        long _arg6 = (long)(arg6); /* Might be in memory */    \
>                                                               \
>        asm volatile (                                         \
>            "pushl  %%ebp\n\t"                                 \
>            "movl   %[_arg6], %%ebp\n\t"                       \
>            "int    $0x80\n\t"                                 \
>            "popl   %%ebp\n\t"                                 \
>            : "=a"(_ret)                                       \
>            : "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3),   \
>              "r"(_arg4),"r"(_arg5), [_arg6]"m"(_arg6)        \
>            : "memory", "cc"                                   \
>        );                                                     \
> 
> See ? no more push, no more addl, direct load from memory.

Uggh... I crafted the same code like you suggested before, but then
I realized it's buggy, it's buggy because %[_arg6] may live in N(%esp).

When you pushl %ebp, the %esp changes, N(%esp) no longer points to the
6-th argument.

-- 
Ammar Faizi
