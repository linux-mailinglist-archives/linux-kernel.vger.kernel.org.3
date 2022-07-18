Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895785789DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiGRSzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGRSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:55:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20327B36
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:55:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658170503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afKbqenpGLounXqvR8fEhHYYL4+7diHe5lEv1lZPTA8=;
        b=NYcM9YKA6ztrzNJFJAB2E0DhOrCQF1m6NLFmvva5ImQsdDl91CYn4nAPuanFY/bVMIH5V8
        gszeECVVfpHSLZgjPG+QLtiz0iHABwLhcD7uuqwgr9nyolLZOTHE/RkrsiMG9/s3l35dbD
        DoZRQbNydVXkXw3NNlzw1VO0yKGeFKo9uzrv9f3Nvb6eOVwHEdlUMvu904XDHAHV+P5sbl
        gTylX0qEmLFpKyIcljGK7eICc/AlilWJaOVHaSm1ctAF4b4ds5BbreeqUf8Fj2xkwOEYhh
        CgtvpMUCsyXz+zOfo8YAlJrqBTyhAkbiHGZvWsjRTJvh5x7teSzJmJeq/m4Cxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658170503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afKbqenpGLounXqvR8fEhHYYL4+7diHe5lEv1lZPTA8=;
        b=Swrn6KgVrXgbbqduXGxdrj5SIsphMNn2+gX+sIqXieSwZxNfItJkERHAogQ7iAWkA7wgqX
        RAUQYCsRVkxcw/Aw==
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
Subject: Re: [patch 1/3] x86/cpu: Remove segment load from switch_to_new_gdt()
In-Reply-To: <CAHk-=wgFNV17=y3CQo1-FgRT5p04JFTa7RV16TN1RFL8sptZ-Q@mail.gmail.com>
References: <20220716230952.787452088@linutronix.de>
 <20220718173923.891284477@linutronix.de>
 <CAHk-=wgFNV17=y3CQo1-FgRT5p04JFTa7RV16TN1RFL8sptZ-Q@mail.gmail.com>
Date:   Mon, 18 Jul 2022 20:55:03 +0200
Message-ID: <874jzew8s8.ffs@tglx>
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

On Mon, Jul 18 2022 at 11:43, Linus Torvalds wrote:
> So I appreciate the added big comments in this code, but looking at this patch:
> On Mon, Jul 18, 2022 at 10:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> +        * For secondary CPUs this is not a problem because they start
>> +        * already with the direct GDT and the real GSBASE. This invocation
>> +        * is pointless and will be removed in a subsequent step.
>> +        */
>> +       if (IS_ENABLED(CONFIG_X86_64))
>> +               wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
>>  }
>
> ... while those comments are nice and all, I do think this retains the
> basic insanity of having "switch_to_new_gdt()" do magical things on
> x86-64 that don't really match the name.
>
> So honestly, I'd be happier of that whole
>
>        if (IS_ENABLED(CONFIG_X86_64))
>                wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
>
> was migrated to the callers instead. There aren't *that* many callers.
>
> I expect that it is then quite possible that several of the call-sites
> would go "GS_BASE is already correct here, I can remove this".

With the next patch we have only two left. The SMP and the UP case. Let
me look whether the UP needs it at all.

> But even if every single caller keeps that wrmsrl() around, at least
> it wouldn't be hidden behind a function call that has a name that
> implies something completely different is happening.
>
> And no, I don't care *that* deeply, so this is just a suggestion.
>
> But wouldn't it be nice if this function was actually named by what it
> does, rather than by what it used to do back in the i386 days when the
> GDT affected the segment bases?

Yes. Let me come up with a sensible name.

Thanks,

        tglx
