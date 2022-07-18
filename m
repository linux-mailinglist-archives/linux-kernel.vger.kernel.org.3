Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC82578E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiGRXpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiGRXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:45:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCA2F3BB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:45:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bf9so22006703lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kd1pjqPM9ag7B8S0toUlWHe+Ol5D4OzpHkcJ2hKq2VE=;
        b=ES+7yKd340DUG6D91g/8WMO4hYKqzPc4ZLoeDhf66DqsObPiTqbc2vsscdjnL7GEEo
         kDrQ+ZcGMEol/1Yw11W0QKc0MRem3xm6eMysP7Dc6MOzGj95lSd6JC0f3KBXs8ynsKXD
         /51XYyHiNYjy2uvGVqVE/f0dzoD3V7xFQql6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kd1pjqPM9ag7B8S0toUlWHe+Ol5D4OzpHkcJ2hKq2VE=;
        b=Xj4doedAG7ygo3Z0HNVehXE7qHLI8zKUz8JNEDAZqZdeaPmRnIYuFNWN0hVJGDIDkK
         ldsRFZCIMNRCCf82WW/T413NIkpLTxHvtj43w731qlR3PBJHgwzSfusQd1Vpgxv3EVQN
         lfewp3gO+7heY7DVGUFm8/oSKRG9wuYU6p3PSdWc9fRjGapT0mSheSF5jdAscdDEMJFA
         30OqaN+r38n7duaRV0iBCKdOR/IfhjnwvZWWQbMGyR9kt3C46bnXzMw/gvrtvbEF7vUH
         19DUVWi9NmknVXFKgzqy4qpQOd6If4wc9tJQnOGX23qxAn4hFkG8vd6+0vySe94HLhXI
         +JdA==
X-Gm-Message-State: AJIora/falu/3ORiE61ROrQVm1o+AyKWPEiJEfffzU91cL9dV5MpNgJL
        xX2h2m4ZodYD8PhDbojFGR6366FixTH2xX6JKfM=
X-Google-Smtp-Source: AGRyM1usTpWngNYLEgQk66/TrArXuaCKp1O1/FUefCtzICl4W2MLVcdkzZKCvjQcl55AjqYLhOScUg==
X-Received: by 2002:a05:6512:3b1e:b0:489:cf4b:5125 with SMTP id f30-20020a0565123b1e00b00489cf4b5125mr15574020lfv.657.1658187906260;
        Mon, 18 Jul 2022 16:45:06 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05651c168900b0025d5eb5dde7sm2254838ljb.104.2022.07.18.16.45.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 16:45:05 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x10so15066532ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:45:05 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr24528345wrw.274.1658187592380; Mon, 18
 Jul 2022 16:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com> <87ilnuuiw8.ffs@tglx>
In-Reply-To: <87ilnuuiw8.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 16:39:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5+HFaATLoo7f-vtZLhazx-gb+--Z7dC3y_O7PCOFN9w@mail.gmail.com>
Message-ID: <CAHk-=wg5+HFaATLoo7f-vtZLhazx-gb+--Z7dC3y_O7PCOFN9w@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 3:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> That's bad. The function entry should be 16 byte aligned and as I just
> learned for AMD the ideal alignment would be possibly 32 byte as that's
> their I-fetch width.

In general, the L1 cache line size is likely the only "ideal" alignment.

Even if (I think) intel fetches just 16 bytes per cycle from the L1 I$
when decoding, being cacheline aligned still means that the L2->L1
transfer for the beginning of the function starts out better.

But Intel's current optimization many actually end sup having special rules:

   When executing code from the Decoded Icache, direct branches that
are mostly taken should have all their instruction bytes in a 64B
cache line and nearer the end of that cache line. Their targets should
be at or near the beginning of a 64B cache line.

   When executing code from the legacy decode pipeline, direct
branches that are mostly taken should have all their instruction bytes
in a 16B aligned chunk of memory and nearer the end of that 16B
aligned chunk. Their targets should be at or near the beginning of a
16B aligned chunk of memory.

So note how the branch itself should be at the end of the chunk, but
the branch _target_ should be at the beginning of the chunk. And the
chunk size is 16 bytes for decoding new instructions, and 64 bytes for
predecoded.

I suspect that for the kernel, and for the beginning of the function
(ie the target case), the 16-byte thing is still the main thing.
Because the L0 I$ ("uop cache", "Decoded Icache", whatever you want to
call it) is probably too small for a lot of kernel loads where user
space has flushed things in between system calls or faults.

Older versions of the intel code just said "All branch targets should
be 16-byte aligned".

So I think 16 bytes for function alignment ends up being what we
generally want, but yes, it's slowly changing. AMD fetches 32-byte
chunks, and Intel has that 64-bit predecode thing.

           Linus
