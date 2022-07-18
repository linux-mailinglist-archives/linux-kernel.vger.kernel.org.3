Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0444F578D08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiGRVnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiGRVnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:43:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9DE5D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=84ri3L7vxoeKONeKrrsTY8fmZGZw2c9qZfrOuK5nvJ8=; b=L7/2TkGbjywvBsdmLi3KChZqyP
        N8SUv4rZ7A/xu7lWv1HfdWbJFX7bsywGVBdUK0cp5lt5aoiXme6zR/Hko/ei4SSbFzUcaSoFyZdGO
        o6CCXJAoVm13s1Tr67BmXg8U0Fik9jiEiW/XUJpmabyrc8Z75tdbNvaFyR/zBgkvU8AVEG6F1SAGl
        G9I3SlexPGkESaY8kblbsGZtp2cIu1DC8Fy/jRTNCavBYkeXVddzXADnkJYDDPnWM4m8yr+44bndV
        y82bccQeQymf15mGBtQAkG/GbDFMsNiMAiDjjJwuzBrVp85+BHjVKGeG8Yl9TXHusuHWT8/7VKbk8
        u7TlE7ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDYWa-00D3n4-3W; Mon, 18 Jul 2022 21:43:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B244D9802A7; Mon, 18 Jul 2022 23:43:31 +0200 (CEST)
Date:   Mon, 18 Jul 2022 23:43:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YtXUAykqgRCY2AX3@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx>
 <CAHk-=wgzo-we3gbw1jKbL_cO9CybjwLNKReVxhYybOcpqJMESw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzo-we3gbw1jKbL_cO9CybjwLNKReVxhYybOcpqJMESw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:01:43PM -0700, Linus Torvalds wrote:
> On Mon, Jul 18, 2022 at 1:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Yes, Peter and I came from avoiding a new compiler and the overhead for
> > everyone when putting the padding into the code. We realized only when
> > staring at the perf data that this padding in front of the function
> > might be an acceptable solution. I did some more tests today on different
> > machines with mitigations=off with kernels compiled with and without
> > that padding. I couldn't find a single test case where the result was
> > outside of the usual noise. But then my tests are definitely incomplete.
> 
> Well, it sounds like it most definitely isn't a huge and obvious problem.
> 
> > Yes, I know. But it was horrible enough to find the right spot in that
> > gcc maze. Then I was happy that I figured how to add the boolean
> > option. I let real compiler people take care of the rest. HJL???
> >
> > And we need input from the Clang folks because their CFI work also puts
> > stuff in front of the function entry, which nicely collides.
> 
> Yeah, looking at the gcc sources (I have them locally because it helps
> with the gcc bug reports I've done over the years), that
> ASM_OUTPUT_FUNCTION_PREFIX is very convenient, but it's too late to do
> any inter-function alignment for, because it's already after the usual
> function-alignment output.
> 
> So I guess the padding thing is largely tied together with alignment
> of the function start, so that idea of having different padding and
> alignment bytes doesn't workl that well.
> 
> At least not in that ASM_OUTPUT_FUNCTION_PREFIX model, which is how
> the gcc patch ends up being so small.

FWIW, when I was poking at this last week, I found that -falign-function
only seems to apply to the normal .text section and not to random other
sections with text we create.

Or rather, I was seeind a lot of unaligned functions that all had custom
sections despite explicitly using the (what I thought was a global)
function alignment toggle.
