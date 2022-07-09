Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC856C960
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 14:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGIM1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIM1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 08:27:51 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB16101D2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 05:27:49 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb8d.dynamic.kabel-deutschland.de [95.90.235.141])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 85BA661EA1923;
        Sat,  9 Jul 2022 14:27:46 +0200 (CEST)
Message-ID: <8caea951-5781-92f5-0d12-bd0e66452b77@molgen.mpg.de>
Date:   Sat, 9 Jul 2022 14:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v2] lib/bitmap: Make parameter len unsigned
To:     Yury Norov <yury.norov@gmail.com>
References: <20220708075239.9057-1-pmenzel@molgen.mpg.de>
 <YshBa/87hSAZwIP3@yury-laptop>
Content-Language: en-US
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YshBa/87hSAZwIP3@yury-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yuri,


Thank you for your reply, and sorry for all the failure messages the
first version created.

Am 08.07.22 um 16:38 schrieb Yury Norov:
> On Fri, Jul 08, 2022 at 09:52:40AM +0200, Paul Menzel wrote:
>> The length is non-negative, so make it unsigned.
>> 
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

> Can you please tell more about your motivation for fixing 
> __bitmap_set?

It’s just about semantics(?) that a count can’t be negative, and only 
seems to generate tiny smaller code (less instructions):

```
__bitmap_set: 
__bitmap_set:
         movl    %esi, %eax 
movl    %esi, %eax
         movq    %rdi, %r8                                     <
         movl    %esi, %ecx 
movl    %esi, %ecx
         movl    %edx, %edi                                    | 
movl    %esi, %r8d
                                                               > 
movl    $64, %esi
                                                               > 
andl    $63, %ecx
         shrl    $6, %eax 
shrl    $6, %eax
         andl    $63, %esi                                     | 
movl    %edx, %r9d
         movq    $-1, %rdx                                     | 
leaq    (%rdi,%rax,8), %rax
         leaq    (%r8,%rax,8), %rax                            | 
subl    %ecx, %esi
         leal    -64(%rsi,%rdi), %r8d                          | 
movq    $-1, %rdi
         salq    %cl, %rdx                                     | 
salq    %cl, %rdi
         testl   %r8d, %r8d                                    | 
cmpl    %edx, %esi
         js      .L88                                          | 
ja      .L85
         movl    %r8d, %r9d                                    <
         shrl    $6, %r9d                                      <
         leal    1(%r9), %esi                                  <
         leaq    (%rax,%rsi,8), %rsi                           <
.L86:                                                           .L86:
         orq     %rdx, (%rax)                                  | 
subl    %esi, %edx
                                                               > 
orq     %rdi, (%rax)
                                                               > 
movl    $64, %esi
         addq    $8, %rax 
addq    $8, %rax
         movq    $-1, %rdx                                     | 
movq    $-1, %rdi
         cmpq    %rsi, %rax                                    | 
cmpl    $63, %edx
         jne     .L86                                          | 
ja      .L86
         sall    $6, %r9d                                      <
         subl    %r9d, %r8d                                    <
.L85:                                                           .L85:
         testl   %r8d, %r8d                                    | 
testl   %edx, %edx
         je      .L84 
je      .L84
         addl    %edi, %ecx                                    | 
leal    (%r8,%r9), %ecx
         movq    $-1, %rax                                     | 
movq    $-1, %rdx
         negl    %ecx 
negl    %ecx
         shrq    %cl, %rax                                     | 
shrq    %cl, %rdx
         andq    %rax, %rdx                                    | 
andq    %rdx, %rdi
         orq     %rdx, (%rsi)                                  | 
orq     %rdi, (%rax)
.L84:                                                           .L84:
         ret                                                             ret
.L88:                                                         <
         movq    %rax, %rsi                                    <
         movl    %edi, %r8d                                    <
         jmp     .L85                                          <
         .size   __bitmap_set, .-__bitmap_set 
.size   __bitmap_set, .-__bitmap_set
         .p2align 4 
.p2align 4
         .globl  __bitmap_clear 
.globl  __bitmap_clear
         .type   __bitmap_clear, @function 
.type   __bitmap_clear, @function
```

     $ diff lib/bitmap.1.S lib/bitmap.2.S | diffstat
      unknown |   55 ++++++++++++++++++++++++-------------------------------
      1 file changed, 24 insertions(+), 31 deletions(-)

> The following __bitmap_clear has the same problem, and
> bitmap_parse{,_user}, and bitmap_print_to_pagebuf, and 
> bitmap_parselist...

Indeed.

> Is there a particular problem that is resolved after fixing 
> __bitmap_set()?
> 
> I'm OK if this is a single patch, but for a cleanup work it would be
> more logical to clean everything in a single patch/series...
If you agree, I can change the other places too.


Kind regards,

Paul
