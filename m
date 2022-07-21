Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD16457D345
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiGUS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUS2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:28:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEDD8C77F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D9JpqZEU53bh6AtYjF7r1cnDZYnRyvg5wYCppRK50vo=; b=WOvbUVqcHiJQyqPbaLBzH6gyBy
        aMUPEUk5TqIKVTz5C1g0IRBwPoRCrUAyjfSn+Bx+yMweT6Ycj251VGuOthWvlPHpQn25BLZSx3Zzi
        ok8Xy6aKFfU9eUmPC5Zp6GX2S+fvUhsV4uhAyS7PpeSOLtOhR6mD6n7ubwLbvTQrJpGinJ2PUR5Lo
        j3xmwcwVmCjm6++q7ZLFgaZrBQZYa9X0FRNasXzQ7Xkyv20c9wUXElXCWgcoO7NZuPjRNbrmvUZsj
        /f/NHmKAp3YPV9hNmoaZ0aDGgxi8CT4kVx1/1nbGTAdIn9lIcEbQ3pyyI9NhO22LWYHhJJUfPpHtm
        xaqgwTcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEatF-00FZ2w-Q1; Thu, 21 Jul 2022 18:27:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 333DB980BD2; Thu, 21 Jul 2022 20:27:12 +0200 (CEST)
Date:   Thu, 21 Jul 2022 20:27:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtmagFcae43wzwCf@worktop.programming.kicks-ass.net>
References: <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
 <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:06:42AM -0700, Linus Torvalds wrote:
> On Thu, Jul 21, 2022 at 10:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > this seems to work, let me go hack the kernel..
> 
> Am I missing something?
> 
> Isn't this generating
> 
>         movl $~IMM,%r10d
>         negl %r10d
>         cmpl %r10d,-4(%calldest)
> 
> for the sequence?
> 
> That seems bogus for two reasons:
> 
>  (a) 'neg' is not the opposite of '~'. Did you mean 'notl' or did you mean '-'?
> 
>      Or am I missing something entirely?

No, you're right, I'm being daft again.

>  (b) since you have that r10 use anyway, why can't you just generate the simpler
> 
>         movl $-IMM,%r10d
>         addl -4(%calldest),%r10d
> 
>      instead? You only need ZF anyway.

Right, lemme see if I can wrangle llvm to generate that.

>      Maybe you need to add some "r10 is clobbered" thing, I don't know.

R11,R11 are caller-saved, and since this is the actual call site, the
caller must already have saved them or marked them clobbered.
