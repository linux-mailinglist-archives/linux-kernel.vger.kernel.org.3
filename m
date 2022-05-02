Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E68C5175A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386654AbiEBRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386634AbiEBRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:21:21 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72596B7D4;
        Mon,  2 May 2022 10:17:48 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id BA33C1BF205;
        Mon,  2 May 2022 17:17:42 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 02 May 2022 10:17:42 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
In-Reply-To: <20220429013704.4n4lmadpstdioe7a@treble>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
Message-ID: <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 18:37, Josh Poimboeuf wrote:
> On Tue, Apr 19, 2022 at 05:42:31PM -0700, joao@overdrivepizza.com 
> wrote:
>> +void __noendbr __fineibt_handler(void){
>> +	unsigned i;
>> +	unsigned long flags;
>> +	bool skip;
>> +	void * ret;
>> +	void * caller;
>> +
>> +	DO_ALL_PUSHS;
> 
> So this function isn't C ABI compliant, right? e.g. the compiler just
> calls the handler without regard for preserving registers?
> 
> If this function is going to be implemented in C, it should probably
> have an asm thunk wrapper which can properly save/restore the registers
> before calling into the C version.
> 
> Even better, if the compiler did an invalid op (UD2?), which I think 
> you
> mentioned elsewhere, instead of calling the handler directly, and there
> were a way for the trap code to properly detect it as a FineIBT
> violation, we could get rid of the pushes/pops, plus the uaccess 
> objtool
> warning from patch 7, plus I'm guessing a bunch of noinstr validation
> warnings.

Cool, I'll try to come up with something!

> 
>> +
>> +	spin_lock_irqsave(&fineibt_lock, flags);
>> +	skip = false;
>> +
>> +	asm("\t movq 0x90(%%rsp),%0" : "=r"(ret));
>> +	asm("\t movq 0x98(%%rsp),%0" : "=r"(caller));
> 
> This is making some questionable assumptions about the stack layout.
> 
> I assume this function is still in the prototype stage ;-)

Yeah, this is just a messy instrumentation to get reports about 
mismatching prototypes (as the ones reported further down the series).

The issue with having the call is that it bloats the binary, so the ud2 
is 3-bytes-per-function better. Yet, we may consider a FINEIBT_DEBUG 
config, which can then enable a handler. This would be useful together 
with a fuzzer or a stress tool to cover possible control-flow paths 
within the kernel and map mismatching prototypes more properly I guess.

> 
>> +	if(!skip) {
>> +		printk("FineIBT violation: %px:%px:%u\n", ret, caller,
>> +				vlts_next);
>> +	}
>> +	DO_ALL_POPS;
>> +}
> 
> Right now this handler just does a printk if it hasn't already for this
> caller/callee combo, and then resumes control.  Which is fine for
> debugging, but it really needs to behave similarly to an IBT violation,
> by panicking unless "ibt=warn" on the cmdline.
> 
> Not sure what would happen for "ibt=off"?  Maybe apply_ibt_endbr() 
> could
> NOP out all the FineIBT stuff.

Either that, or...

I'm thinking about a way to have FineIBT interchangeable with KCFI. 
Currently KCFI adds a 4 byte hash + 2 byte nops before function entry, 
to allow for proper prototype checking. After that, there should be an 
ENDBR of 4 bytes. This gives us 10 bytes in total. Then, my yet to be 
properly thought idea would be patch these 10 bytes with:

endbr
call fineibt_handler_<$HASH>
nop

and then, on the caller side, patch the "cmp <$HASH>, -0x6(%r11); je; 
ud2; call" sequence with a "sub 0x6, r11; mov $HASH, %r10; call %r11, 
add 0x6 %r11". This would then allow the kernel to verify if the CPU is 
IBT capable on boot time and only then setting the proper scheme.

The downsides of having something like this would be that this sub 
r11/add r11 sequence is kinda meh. We can avoid that by having two 
padding nops after the original ENDBR, which will be skipped when the 
function is reached directly by the linker optimization I'm working on, 
and that we can convert into a JMP -offset that makes control flow reach 
the padding area before the prologue and from where we can call the 
fineibt_handler function. The resulting instrumentation would be 
something like:

1:
call fineibt_handler_<$HASH>
jmp 2f
<foo>
endbr
jmp 1b
2:

Also, it would prevent a paranoid user to have both schemes 
simultaneously (there are reasons why people could want that).

Any thoughts?
