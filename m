Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD5D578DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiGRXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbiGRXAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:00:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FB3340F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658185175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRQgoUbWlCEHhtfsKhy1JNqLu3+h5kACXL2L6BNUSuY=;
        b=D00lgYW1CO1cj58Oej4VSqyofF6YehWYC9vLaGH47VKEIsBbdbBStnaN4TQd12drkue5TH
        tpCm0CcszjBgnk1GcLeD4QERVeDoO3ds1xUA/eOtKGFIU3hamoEI0JabtKuKHQu35ZCPbP
        j4w45P77KvedADqsea0+FY/vnJ+vYrJJYy8SIWzi8sTj3mQBe1U6h+jP8LGUaLMVbDDRJD
        oE/QYdQFXLiGhK5Korwo7aZZd/+yP8mBOQbMfo1Pfiz8hBaMXtVE95nur+n1HW/LDGHaQt
        8W4HJlKgmK+JClgXdhfKsLNkdmDzJHOpPUNleXnaskMpVcnp2HELnZCwdPVjzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658185175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRQgoUbWlCEHhtfsKhy1JNqLu3+h5kACXL2L6BNUSuY=;
        b=30bUySOHEf6spJn6GWQrwyo2s5oy9JCuXIZgjHL2TjScBxhO2HqDdxrKVtFucmiPt73n20
        4oHOLZ/gwU82npBA==
To:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com>
Date:   Tue, 19 Jul 2022 00:59:35 +0200
Message-ID: <87ilnuuiw8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18 2022 at 15:48, Sami Tolvanen wrote:
> On Mon, Jul 18, 2022 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Jul 18, 2022 at 10:44:14PM +0200, Thomas Gleixner wrote:
>> > And we need input from the Clang folks because their CFI work also puts
>> > stuff in front of the function entry, which nicely collides.
>>
>> Right, I need to go look at the latest kCFI patches, that sorta got
>> side-tracked for working on all the retbleed muck :/
>>
>> Basically kCFI wants to preface every (indirect callable) function with:
>>
>> __cfi_\func:
>>         int3
>>         movl $0x12345678, %rax
>>         int3
>>         int3
>> \func:
>
> Yes, and in order to avoid scattering the code with call target
> gadgets, the preamble should remain immediately before the function.
>
>> Ofc, we can still put the whole:
>>
>>         sarq    $5, PER_CPU_VAR(__x86_call_depth);
>>         jmp     \func_direct
>>
>> thing in front of that.
>
> Sure, that would work.
>
>> But it does somewhat destroy the version I had that only needs the
>> 10 bytes padding for the sarq.
>
> There's also the question of how function alignment should work in the
> KCFI case. Currently, the __cfi_ preamble is 16-byte aligned, which
> obviously means the function itself isn't.

That's bad. The function entry should be 16 byte aligned and as I just
learned for AMD the ideal alignment would be possibly 32 byte as that's
their I-fetch width. But my experiments with 16 bytes alignment
independent of the padding muck is benefitial for both AMD and Intel
over the 4 byte alignment we have right now.

This really needs a lot of thought and performance analysis before we
commit to anything here. Peter's an my investigations have shown how
sensitive this is.

We can't just add stuff without taking the whole picture into account
(independent of the proposed padding muck).

Thanks,

        tglx
