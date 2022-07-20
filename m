Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211057B36E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiGTJAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiGTJAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:00:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB22872B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:00:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658307645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=etRkAHwvk0Yt4QTwR5k4d8TxbYS/cmxaPYmnF5tyJBE=;
        b=KTs6Cji4o4bVnuNJ89tP2WMsiMCVMa8kCeozN7M6HGxit0+CrMPl3rmsCvYp2oG+nR0MG6
        7JjxfWD/dknMoQcdS3ZkezLZsiq5LEpEWo9AN1QTbZt3ldHjGgyq1HEpsZmQW1Uy8VgIEl
        fM9Zm0Dh/Fc3XLLpVWx6TasQgUh+ntT3quLHk4XLwxN6RdKmwdX2q8IHOnAD38A4UyEMTQ
        Dl1UiwFUzAmU31aUOyD/TSHPoriQrdvIqEXmuxOhUPhL+woULyxYWrSPNxzN4yxTkoIJur
        TNUIje1iVFEpGmb5IjF0bmtJGgOoXB33f/vY4u8ZP+5YTTzQFOnjNN5ALNR3tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658307645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=etRkAHwvk0Yt4QTwR5k4d8TxbYS/cmxaPYmnF5tyJBE=;
        b=ITfUnXF2OuRukEvoRM0TFudV7bK9IfOzC7vNK64OnLimIHvGfPfvQ2E5UYDKdawN0zwklP
        xFliR6lUEjU1eYCQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>
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
In-Reply-To: <YtXx8r5zfqZ12M04@worktop.programming.kicks-ass.net>
Date:   Wed, 20 Jul 2022 11:00:44 +0200
Message-ID: <87y1wotayr.ffs@tglx>
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

On Tue, Jul 19 2022 at 01:51, Peter Zijlstra wrote:
> On Mon, Jul 18, 2022 at 03:48:04PM -0700, Sami Tolvanen wrote:
>> On Mon, Jul 18, 2022 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>> > Ofc, we can still put the whole:
>> >
>> >         sarq    $5, PER_CPU_VAR(__x86_call_depth);
>> >         jmp     \func_direct
>> >
>> > thing in front of that.
>> 
>> Sure, that would work.
>
> So if we assume \func starts with ENDBR, and further assume we've fixed
> up every direct jmp/call to land at +4, we can overwrite the ENDBR with
> part of the SARQ, that leaves us 6 more byte, placing the immediate at
> -10 if I'm not mis-counting.
>
> Now, the call sites are:
>
> 41 81 7b fa 78 56 34 12		cmpl	$0x12345678, -6(%r11)
> 74 02				je	1f
> 0f 0b				ud2
> e8 00 00 00 00		1:	call	__x86_indirect_thunk_r11
>
> That means the offset of +10 lands in the middle of the CALL
> instruction, and since we only have 16 thunks there is a limited number
> of byte patterns available there.
>
> This really isn't as nice as the -6 but might just work well enough,
> hmm?

So I added a 32byte padding and put the thunk at the start:

        sarq    $5, PER_CPU_VAR(__x86_call_depth);
        jmp     \func_direct

For sockperf that costs about 1% performance vs. the 16 byte
variant. For mitigations=off it's a ~0.5% drop.

That's on a SKL. Did not check on other systems yet.

Thanks,

        tglx
