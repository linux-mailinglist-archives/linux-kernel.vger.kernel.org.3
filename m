Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0723F578DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiGRWrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiGRWrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:47:40 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6D24BE9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:47:39 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 923C71C0002;
        Mon, 18 Jul 2022 22:47:29 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 18 Jul 2022 15:47:29 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, samitolvanen@google.com
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <87lesqukm5.ffs@tglx>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx>
Message-ID: <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 15:22, Thomas Gleixner wrote:
> On Mon, Jul 18 2022 at 23:18, Peter Zijlstra wrote:
>> On Mon, Jul 18, 2022 at 10:44:14PM +0200, Thomas Gleixner wrote:
>>> And we need input from the Clang folks because their CFI work also 
>>> puts
>>> stuff in front of the function entry, which nicely collides.
>> 
>> Right, I need to go look at the latest kCFI patches, that sorta got
>> side-tracked for working on all the retbleed muck :/
>> 
>> Basically kCFI wants to preface every (indirect callable) function 
>> with:
>> 
>> __cfi_\func:
>> 	int3
>>         movl $0x12345678, %rax
>>         int3
>>         int3
>> \func:
>>         endbr
>> \func_direct:
>> 
>> Ofc, we can still put the whole:
>> 
>> 	sarq	$5, PER_CPU_VAR(__x86_call_depth);
>> 	jmp	\func_direct
>> 
>> thing in front of that. But it does somewhat destroy the version I had
>> that only needs the 10 bytes padding for the sarq.
> 
> Right, because it needs the jump. I was just chatting with Jaoa about
> that over IRC.
> 
> The jump slow things down. Jaoa has ideas and will reply soonish.

So, IIRC, kCFI will do something like this to validate call targets 
based on the hash as described on Peter's e-mail:

func_whatever:
	...
	cmpl $0x\hash, -6(%rax)
	je 1f
	ud2
1:
	call *%rax
	...

Thus the hash will be 6 bytes before the function entry point. Then we 
can get the compiler to emit a padding area before the __cfi_\func 
snippet and, during boot, if the CPU needs the call depth tracking 
mitigation, we:
- move the __cfi_func into the padding area
- patch the call depth tracking snippet ahead of it (overwriting the old 
__cfi_\func:)
- fix the cmpl offset in the caller

func_whatever:
	...
	cmpl $0x\hash, -FIXED_OFFSET(%rax)
	je 1f
	ud2
1:
	call *%rax
	...

This approach is very similar to what we discussed in the past for 
replacing kCFI with FineIBT if CET is available. Also, it would prevent 
the need for any jump and would keep the additional padding area in 10 
bytes.

Tks,
Joao


