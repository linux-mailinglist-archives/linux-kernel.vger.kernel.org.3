Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF681578F34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiGSAXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiGSAXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:23:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078F33353
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=co6Jv7mgpbM21F/ySZgejVa+xfgfIHwJOW7zyHk6RRw=; b=V9UMmiWLz6B624YTzjx8QNbpsj
        XQ9Gpycq+ffDa9KEvuCt++XuvuqC1bG66/tX+vuXgOJb6jhUEHJkTHZ3eWDFazbn+TLKwfmPyTCMm
        fNAVUkQUpFg80nt4uzdaiKYZmgbreie5sYPYY4pskkzmSiYOf44AVYc9mcIhzCySazBgo2A0TIWF9
        X/HCMRGrdEF0BUwlREeE6kgSqiy8mz0Y5nOWPXoYeDMCrIdWbj7WGikNLSQo/E2z3zlG87VX7333k
        83HNssLQjQYiMG8y8gMJzFN8lotZR/chjwlp4B41/+E5ZGVxX+5+FAR/+j2F1K6WSeVIRwlC4eOSa
        2N/vDlDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDb1H-00DAwU-Nb; Tue, 19 Jul 2022 00:23:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC6F69802A7; Tue, 19 Jul 2022 02:23:22 +0200 (CEST)
Date:   Tue, 19 Jul 2022 02:23:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtX5enG0eN1XUzGR@worktop.programming.kicks-ass.net>
References: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx>
 <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:11:27PM -0700, Linus Torvalds wrote:
> On Mon, Jul 18, 2022 at 5:03 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So it already only adds the pattern to things that have their address
> > taken, not all functions?
> >
> > If so, that's simple enough to sort out: don't do any RSB stack
> > adjustment for those thunks AT ALL.
> >
> > Because they should just then end up with a jump to the "real" target,
> > and that real target will do the RSB stack thing.
> 
> Put another way, let's say that you have a function that looks like this:
> 
>   int silly(void)
>   {
>        return 0;
>   }
> 
> and now you have two cases:
> 
>  - the "direct callable version" of that function looks exactly the
> way it always has looked, and gets the 16 bytes of padding for it, and
> the RSB counting can happen in that padding
> 
>  - the "somebody took the address of this function" creates code that
> has the hash marker before it, and has the hash check, and then does a
> "jmp silly" to actually jump to the real code.
> 
> So what the RSB counting does is just ignore that second case entirely
> as far as the RSB code generation goes. No need to have any padding
> for it at all, it has that (completely different) kCFI padding
> instead.
> 
> Instead, only the "real" silly function gets that RSB code, and the
> "jmp silly" from the kCFI thunk needs to be updated to point to the
> RSB thunk in front of it.
> 
> Yes, yes, it makes indirect calls slightly more expensive than direct
> calls (because that kCFI thing can't just fall through to the real
> thing), but considering all the *other* costs of indirect calls, the
> cost of having that one "jmp" instruction doesn't really seem to
> matter, does it?

So it's like 2:15 am here, so I might not be following things right, but
doesn't the above mean you have to play funny games with what a function
pointer is?

That is, the content of a function pointer (address taken) no longer
match the actual function? That gives grief with things like
static_call(), ftrace and other things that write call instructions
instead of doing indirect calls.


