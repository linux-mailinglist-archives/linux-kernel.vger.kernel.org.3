Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D2578C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiGRVTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiGRVTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:19:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BB6140
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ojAdpjQGp2/6VYLGnXT12hikGpG6gvDnZkT4uGicFqw=; b=D3nT8KtLVXRCDD6/hVTgPzvdPU
        ot4deF0owRDntiYLw2XNF6CmF6DOerxOsQ0EvSE6wiLvkQnFtfGkHhV15gaVRGvNppMeNAJyRYfiO
        A4f95ZPkLl7gtylrxikqu5hV8Uk2s0alEBdH804MTTNw1aFLgKwZioYbUyNthC6F1/qx1koTVKrj9
        lJwq9XkdkAheEJd5AGdubbq8eMoeBXEhWdIQAUEfpoSgyZCi+hEcNHXRhPJuKIWc7Y4kLjViOFazA
        blBe6io9P4nxrX89d7gujAsevL4Cf/YoSFxdA//W0vgdnMOomlr8GL/h5ghQnvXrLXtq2CBqfls8h
        7A6ZhXNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDY8X-00D2dE-Sd; Mon, 18 Jul 2022 21:18:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B0B49802A7; Mon, 18 Jul 2022 23:18:40 +0200 (CEST)
Date:   Mon, 18 Jul 2022 23:18:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
        Daniel Borkmann <daniel@iogearbox.net>, samitolvanen@google.com
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7xmup5t.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:44:14PM +0200, Thomas Gleixner wrote:

> > I do think that for generality, the "-mforce-function-padding" option
> > should perhaps take as an argument how much padding (and how much
> > alignment) to force:
> >
> >     -mforce-function-padding=5:16
> >
> > would force 5 bytes of minimum padding, and align functions to 16
> > bytes. It should be easy to generate (no more complexity than your
> > current one) by just making the output do
> >
> >         .skip 5,0xcc
> >         .palign 4,0xcc
> >
> > and now you can specify that you only need X bytes of padding, for example.
> 
> Yes, I know. But it was horrible enough to find the right spot in that
> gcc maze. Then I was happy that I figured how to add the boolean
> option. I let real compiler people take care of the rest. HJL???
> 
> And we need input from the Clang folks because their CFI work also puts
> stuff in front of the function entry, which nicely collides.

Right, I need to go look at the latest kCFI patches, that sorta got
side-tracked for working on all the retbleed muck :/

Basically kCFI wants to preface every (indirect callable) function with:

__cfi_\func:
	int3
        movl $0x12345678, %rax
        int3
        int3
\func:
        endbr
\func_direct:

Ofc, we can still put the whole:

	sarq	$5, PER_CPU_VAR(__x86_call_depth);
	jmp	\func_direct

thing in front of that. But it does somewhat destroy the version I had
that only needs the 10 bytes padding for the sarq.
