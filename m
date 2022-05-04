Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24C3519571
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbiEDCW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiEDCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:22:50 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8A2B27C;
        Tue,  3 May 2022 19:19:15 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 4842A1C0004;
        Wed,  4 May 2022 02:19:11 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 03 May 2022 19:19:11 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
In-Reply-To: <20220503220244.vyz5flk3gg3y6rbw@treble>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
 <20220503220244.vyz5flk3gg3y6rbw@treble>
Message-ID: <068cafedb0699383b696ce15d5677979@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> It should be possible to have a non-fatal #UD2 handler.
> 
> See for example how WARN() is implemented with __WARN_FLAGS in
> arch/x86/include/asm/bug.h .
> 
> So hopefully we can just get rid of the need for the "call handler"
> thing altogether.
> 
Nice, I'll look into it. Tks.

>> > Not sure what would happen for "ibt=off"?  Maybe apply_ibt_endbr() could
>> > NOP out all the FineIBT stuff.
>> 
>> Either that, or...
>> 
>> I'm thinking about a way to have FineIBT interchangeable with KCFI.
>> Currently KCFI adds a 4 byte hash + 2 byte nops before function entry, 
>> to
>> allow for proper prototype checking. After that, there should be an 
>> ENDBR of
>> 4 bytes. This gives us 10 bytes in total. Then, my yet to be properly
>> thought idea would be patch these 10 bytes with:
>> 
>> endbr
>> call fineibt_handler_<$HASH>
>> nop
>> 
>> and then, on the caller side, patch the "cmp <$HASH>, -0x6(%r11); je; 
>> ud2;
>> call" sequence with a "sub 0x6, r11; mov $HASH, %r10; call %r11, add 
>> 0x6
>> %r11". This would then allow the kernel to verify if the CPU is IBT 
>> capable
>> on boot time and only then setting the proper scheme.
>> 
>> The downsides of having something like this would be that this sub 
>> r11/add
>> r11 sequence is kinda meh. We can avoid that by having two padding 
>> nops
>> after the original ENDBR, which will be skipped when the function is 
>> reached
>> directly by the linker optimization I'm working on, and that we can 
>> convert
>> into a JMP -offset that makes control flow reach the padding area 
>> before the
>> prologue and from where we can call the fineibt_handler function. The
>> resulting instrumentation would be something like:
>> 
>> 1:
>> call fineibt_handler_<$HASH>
>> jmp 2f
>> <foo>
>> endbr
>> jmp 1b
>> 2:
>> 
>> Also, it would prevent a paranoid user to have both schemes 
>> simultaneously
>> (there are reasons why people could want that).
>> 
>> Any thoughts?
> 
> I'm not really qualified to comment on this too directly since I 
> haven't
> looked very much at the variations on FineIBT/CFI/KCFI, and what the
> protections and drawbacks are for each approach, and when it might even
> make sense to combine them for a "paranoid user".
> 
> Since we have multiple similar and possibly competing technologies 
> being
> discussed, one thing I do want to warn against is that we as kernel
> developers tend to err on the side of giving people too many choices 
> and
> combinations which *never* get used.
> 
> All those unused options can confuse the user and significantly add to
> complexity and maintenance overhead for us.  Especially for invasive
> features like these.
> 
> (Just to be clear, I'm not saying that's happening here, but it's
> something we need to be careful about.)
> 
> Here, documentation is going to be crucial, for both reviewers and
> users.  Something that describes when/why I should use X or Y or X+Y.
> 
> If we truly want to add more options/combos for different use cases 
> then
> we'll also need clear and concise documentation about which
> options/combos would be used under what circumstances.

Yeah, I totally understand/support this concern and I feel the same way. 
While, in this case, I can't see super clear reasons for X+Y, there are 
aspects why someone could prefer X or Y -- so I think that using 
alternatives to flip the instrumentation is a valid consideration. In 
time, taking the chance to be fair on the credits, using alternatives to 
replace KCFI/FineIBT was also Peter's idea, not mine. It looked hard to 
do at first sight because of the caller/callee-side checks differences, 
but since Peter mentioned it, I started trying to solve the puzzle of 
having the best suitable instrumentation that would be changeable. I 
haven't discussed this with anyone yet, but at this point I think it 
might be doable, although not in the most performant shape. Anyway, I'll 
post something here once I have a more solid idea.

And yes, I agree that documentation will be key and I totally see your 
point/understand how confusing I was in my previous e-mail. I'll keep 
that in mind for the next revision. Thanks for pointing it out :)
