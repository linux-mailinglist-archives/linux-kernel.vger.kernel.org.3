Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96257BFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiGTVgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGTVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:36:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6331F2C5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pBly/RcMnnqar2Q10nf85mwKMvO+4aD4A0MydXAxm1A=; b=huYq9eF2cD7yraAZoWOnmj2JK1
        ceavaMLgJcDAuNsxb8KZIwh8oGtfOZYvU+haSjR7OuBUWbKZ4bDu2APQGKsxYUVkKwwXvuTVg+nDX
        Jxn06L5jj8NZEy0hPF2yGhHlFFihJG6xGveEVIYPKLarQXIKXjsyqNJ+BuZsyM8dUV3JY9SsMc6S3
        biTOMMKSNXqqIzWNNeAaZKclkyERicyqBEFaXbUmRZC9H5UfYlRdnXE14AZVyCLF8qeaw4E7xUr9V
        CgY8T4CqaK2k4omm6B3NVHaT/wVUYl9qDTwfsar7NOdNEELfgJLVwRQgHYBcnK75nbZH0xgLnPOSP
        cbz6Ik1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEHMY-00EoaY-3e; Wed, 20 Jul 2022 21:36:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3F26980BBE; Wed, 20 Jul 2022 23:36:08 +0200 (CEST)
Date:   Wed, 20 Jul 2022 23:36:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <Yth1SHozzxY0al7Y@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <20220720125736.48164a14@gandalf.local.home>
 <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
 <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net>
 <20220720135016.3178ffc6@gandalf.local.home>
 <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
 <202207201219.8EA905372@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207201219.8EA905372@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 12:36:38PM -0700, Kees Cook wrote:
> On Wed, Jul 20, 2022 at 11:07:26AM -0700, Linus Torvalds wrote:
> > On Wed, Jul 20, 2022 at 10:50 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > [    2.464117] missing return thunk: lkdtm_rodata_do_nothing+0x0/0x8-lkdtm_rodata_do_nothing+0x5/0x8: e9 00 00 00 00
> > 
> > Well, that looks like a "jmp" instruction that has never been relocated.
> 
> Peter, Josh, and I drilled down into this recently[1] and discussed
> some solutions[2].
> 
> This test is doing what's expected: it needed an arch-agnostic way to do
> a "return", and when the way to do that changed, it also changed (which
> would normally be good, but in this case broke it). It's been happily
> being used as part of the per-section architectural behavior testing[3]
> of execution-vs-expected-memory-permissions for quite a long while now.
> 
> I'd rather not remove it (or do it dynamically) since the point is to
> test what has been generated by the toolchain/build process and stuffed
> into the .rodata section. i.e. making sure gadgets there can't be
> executed, that the boot-time section permission-setting works correctly,
> etc. Before the retbleed mitigation, this test worked for all
> architectures; I'd hate to regress it. :(
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net/
> [2] https://lore.kernel.org/lkml/20220713213133.455599-1-keescook@chromium.org/
> [3] e.g. https://linux.kernelci.org/test/plan/id/62d61ee8ef31e0f0faa39bff/

Josh posted this:

  https://lkml.kernel.org/r/8ec0039712f252693049c70ed3891d39a2357112.1658155446.git.jpoimboe@kernel.org

which I picked up today; barring robot fail I'll push it to x86/urgent
tomorrow.
