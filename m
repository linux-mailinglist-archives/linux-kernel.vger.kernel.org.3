Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3334AB222
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiBFUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 15:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiBFUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:40:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9DC06173B;
        Sun,  6 Feb 2022 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=APvwVB5sJ+LJehHRNtv8FonVED1MX6GFXOyxpmO5zOU=; b=RceeUVHbGMz1Xh8JwkCZIzCOmj
        jG90mV/LUL6woArPGmcuuZd+7mT2CZL+DqZ9pJ8OLztRl9iom7owr14n7IME/YEhj4nSdKMJhfwAc
        Sh2/6FJDcOF6zjkKgVxLxIuMIu5pj+Z6+zkXEuEKz3oFi81GdstPitKm//UG+TKmwUpbgpha2D0Vk
        vYcPMjvKlH5CawzKvnbAJy+sPCu51cHFLCRB1WLvo8ZUswq8a38oRM0sFQWCI3uM0ahg1dg5T3wS0
        2SEL3oqPDNA8q+AU2hUIIcMaq4ucZgEKyjZPcqPmrwlN4SMfCbWaAYv2oBdIkNnDZrgPqKiChI1uK
        60c763NQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGoKW-007Xbu-D0; Sun, 06 Feb 2022 20:40:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D420300470;
        Sun,  6 Feb 2022 21:40:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5505E21378EDF; Sun,  6 Feb 2022 21:40:15 +0100 (CET)
Date:   Sun, 6 Feb 2022 21:40:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <YgAyL2D25nweODX3@hirez.programming.kicks-ass.net>
References: <20220202001918.4104428-1-keescook@chromium.org>
 <20220206115816.GA23216@worktop.programming.kicks-ass.net>
 <202202060819.3C86C47DCA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202060819.3C86C47DCA@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 08:46:47AM -0800, Kees Cook wrote:
> On Sun, Feb 06, 2022 at 12:58:16PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 01, 2022 at 04:19:18PM -0800, Kees Cook wrote:
> > > Is it correct to exclude .noinstr.text here? That means any functions called in
> > > there will have their stack utilization untracked. This doesn't seem right to me,
> > > though. Shouldn't stackleak_track_stack() just be marked noinstr instead?
> > 
> > This patch is right. stackleak_track_stack() cannot be marked noinstr
> > becaues it accesses things that might not be there.
> 
> Hmm, as in "current()" may not be available/sane?

Exactly the case; if we lift the PTI address space swizzle, we start
with C without having the kernel mapped or even the per-cpu segment
offset set. So things like current will explode.

The whole noinstr thing was invented to get back to C as portable
Assembler, with the express purpose to lift a bunch of entry code to C.

> > Consider what happens if we pull the PTI page-table swap into the
> > noinstr C part.
> 
> Yeah, I see your point. I suspect the reason this all currently works
> is because stackleak is supposed to only instrument leaf functions that
> have sufficiently large (default 100 bytes) stack usage.
> 
> What sorts of things may end up in .noinstr.text that are 100+ byte stack
> leaf functions that would be end up deeper in the call stack? (i.e. what
> could get missed from stack depth tracking?) Interrupt handling comes
> to mind, but I'd expect that to make further calls (i.e. not a leaf).

All the syscall/exception/interrupt entry stuff is noinstr; I don't
think we have huge stackframes, but with all that in C that's much
easier to do than with then in asm.

If you worry about this, it should be possible to have objtool warn
about excessive stack frames for noinstr code I suppose, it already
tracks the stack anyway.

