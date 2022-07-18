Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE9578BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiGRUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiGRUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:44:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9FC7669
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:44:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658177055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCfpsH+YIeoBDSo9l/9CiEeIZBcdyDS+zXLItAzmWy0=;
        b=HiA9jGM2sbXd+WoNaPeI9JJKaVTDIFSlmke6HvJy6RCgoegIUL/NyY7cT3o8VlgNvaBG7t
        mWmnA1OWygV8eMAq5iy5fXc4+cQqdSNub8dZT8nUXgC/QTa/kPaugg/yimRi9Cg438oR8/
        s/B/Os9Uqh80AkljfCYkGnzDZEZaP/WXT48PWFThaOHbkFnWlfJAhPQjKQ3IFPNDrTShh3
        SAyRnaRG8TBhGdxS5lqq889Qtn3YT+ftJWUKx+5Qtq4iLAox/ynRvdXskARX6tZzPxi7rx
        Uo/9MUaYIKYguLqbvsnAxQ7zc3kcykpj+ZWu8JTox6te9SSwTmH0smQPuJ8r2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658177055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCfpsH+YIeoBDSo9l/9CiEeIZBcdyDS+zXLItAzmWy0=;
        b=JVZe6S0chTZWAlHNZiD5kg2+sRMhZH6wYRiK37IwC6NB3lRIZQjKUAHHPgdpH9Rex+1aY6
        EKnJ0adDWQgZwWAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
Date:   Mon, 18 Jul 2022 22:44:14 +0200
Message-ID: <87o7xmup5t.ffs@tglx>
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

On Mon, Jul 18 2022 at 12:51, Linus Torvalds wrote:
> On Mon, Jul 18, 2022 at 12:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Let the compiler add a 16 byte padding in front of each function entry
>> point and put the call depth accounting there. That avoids calling out
>> into the module area and reduces ITLB pressure.
>
> Ooh.
>
> I actually like this a lot better.
>
> Could we just say "use this instead if you have SKL and care about the issue?"
>
> I don't hate your module thunk trick, but this does seem *so* much
> simpler, and if it performs better anyway, it really does seem like
> the better approach.

Yes, Peter and I came from avoiding a new compiler and the overhead for
everyone when putting the padding into the code. We realized only when
staring at the perf data that this padding in front of the function
might be an acceptable solution. I did some more tests today on different
machines with mitigations=off with kernels compiled with and without
that padding. I couldn't find a single test case where the result was
outside of the usual noise. But then my tests are definitely incomplete.

> And people and distros who care would have an easy time adding that
> simple compiler patch instead.
>
> I do think that for generality, the "-mforce-function-padding" option
> should perhaps take as an argument how much padding (and how much
> alignment) to force:
>
>     -mforce-function-padding=5:16
>
> would force 5 bytes of minimum padding, and align functions to 16
> bytes. It should be easy to generate (no more complexity than your
> current one) by just making the output do
>
>         .skip 5,0xcc
>         .palign 4,0xcc
>
> and now you can specify that you only need X bytes of padding, for example.

Yes, I know. But it was horrible enough to find the right spot in that
gcc maze. Then I was happy that I figured how to add the boolean
option. I let real compiler people take care of the rest. HJL???

And we need input from the Clang folks because their CFI work also puts
stuff in front of the function entry, which nicely collides.

Thanks,

        tglx
