Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49816525827
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359402AbiELXO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbiELXO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:14:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB8427EB9E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:14:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652397292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0aEuWsANdQLRHrRiGsBWyR4tbeCF0F0+oihoUK5Cya8=;
        b=u461Q4lqyAIKEkFnBZbGWIGY0v3pRsgI0BV3nCBEjTUASwbg/SMzArAa2X+jeWtol/gHZ7
        a8bDAHWL0YZM0/IybLsWfHKahvMxEZjDL3d0laLMLqUS5kjtg3L5aQW6XpSP/KTGHNO+nT
        kEOeaHspWcSrm5LKUcH3BAC7RHd8GgvHiCeWVhTMNnSPuY7wnqPv4FWAg+YoYhMXxpN3JQ
        m5r/PQGVpkZAncK427k7jEa6hDsSE2AeDw9K4gxUUgCCGIuxxtD2EFdmR0G2lJes5zw4dR
        JRkbUUm1tU3sGW6edQoo5XS6ceG29bguW0eiR+oitqjAcmcLr/qVYKUSCIwS1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652397292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0aEuWsANdQLRHrRiGsBWyR4tbeCF0F0+oihoUK5Cya8=;
        b=7sbzSsucjj1+dX1so+YTgeoXx5C4epdXmdUJJ9CCNIAVocXWDAF6qsRzyz1IfJZ1sNGszW
        oDOgW4zFDIneEJDA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
In-Reply-To: <87sfpevl1g.ffs@tglx>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
 <87a6bmx5lt.ffs@tglx> <Yn0YdPNG/Q3lf+4G@hirez.programming.kicks-ass.net>
 <87sfpevl1g.ffs@tglx>
Date:   Fri, 13 May 2022 01:14:51 +0200
Message-ID: <87wneqtkb8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12 2022 at 17:16, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 16:23, Peter Zijlstra wrote:
>> On Thu, May 12, 2022 at 03:06:38PM +0200, Thomas Gleixner wrote:
>>
>>> #define untagged_addr(addr)	({			\
>>> 	u64 __addr = (__force u64)(addr);		\
>>> 							\
>>> 	__addr &= current->thread.lam_untag_mask;	\
>>> 	(__force __typeof__(addr))__addr;		\
>>> })
>>> 
>>> No conditionals, fast _and_ correct. Setting this untag mask up once
>>> when LAM is enabled is not rocket science.
>>
>> But that goes wrong if someone ever wants to untag a kernel address and
>> not use the result for access_ok().
>>
>> I'd feel better about something like:
>>
>> 	s64 __addr = (addr);
>> 	s64 __sign = __addr;
>>
>> 	__sign >>= 63;
>> 	__sign &= lam_untag_mask;
>
> that needs to be
>
>  	__sign &= ~lam_untag_mask;
>
>> 	__addr &= lam_untag_mask;
>> 	__addr |= __sign;
>>
>> 	__addr;
>>
>> Which simply extends bit 63 downwards -- although possibly there's an
>> easier way to do that, this is pretty gross.
>
> For the price of a conditional:
>
>     __addr &= lam_untag_mask;
>     if (__addr & BIT(63))
>         __addr |= ~lam_untag_mask;
>
> Now you have the choice between gross and ugly.

Though we can also replace your flavour of gross with a different
flavour of gross:

	s64 sign = (s64)(addr) >> 63;

	addr ^= sign;
	addr &= mask;
	addr ^= sign;

After twisting my brain around replacing gross by something differently
gross and coming up with the gem above I actually did compile the
variants and discovered that GCC compiles your flavour of gross exactly
to this:

        mov    %rdi,%rax
        sar    $0x3f,%rax
        xor    %rax,%rdi
        and    %rsi,%rdi
        xor    %rdi,%rax

I have to admit that compilers are sometimes pretty smart. I might have
to rethink my prejudice. :)

But then clang converts your flavour of 'gross' to:

     	mov    %rsi,%rax
     	mov    %rsi,%rcx
     	and    %rdi,%rax
     	sar    $0x3f,%rdi
     	not    %rcx
     	and    %rdi,%rcx
     	or     %rcx,%rax

and my explicit flavour to:

      	mov    %rdi,%rax
      	mov    %rdi,%rcx
      	sar    $0x3f,%rcx
      	xor    %rcx,%rax
      	and    %rsi,%rax
      	xor    %rcx,%rax

which is at least slightly less retarted, but still has a pointless mov
there. Note, that this was compiled in user space with noinline
functions. I did some inlined variants as well and clang still insists
on using an extra register for no obvious reason. This might be more
efficient in reality, but I haven't bothered to write a test which
might give an answer via perf.

The ugly with the conditional resolves for both compilers to:

       	mov    %rsi,%rax
       	mov    %rsi,%rcx
       	not    %rcx
       	or     %rdi,%rcx
       	and    %rdi,%rax
       	test   %rdi,%rdi
       	cmovs  %rcx,%rax

At least they agree on that one.

But whatever we chose, it's sad, that we need to have support for
interfaces which swallow any pointer (user or kernel) because otherwise
this really boils down to a single OR resp. AND operation plus the
according mov to retrieve the mask.

Thanks,

        tglx
