Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316A0473F87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhLNJdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhLNJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:33:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED7C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:33:30 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D40A01EC0298;
        Tue, 14 Dec 2021 10:33:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639474405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IUU3KyuG0y6AIPf35/7xcu7MThUOtKdYlxLaIrajhXE=;
        b=a8Z7HroF2N9rzpeG7SXfYKFurn9U3EisdaD8J+q5vSYNNDs4PbyLYD1NbK+duO91EHwQsL
        Ksr1/XYAC0VlT/lHJRcx+jUXypaIc8YSCs1O8Dg/hfE+lRd89lcyfTJmpy8dV9OWIT8hhB
        iUMoV2Z6AqZYMXFn6hxk6HwpuxVhxzk=
Date:   Tue, 14 Dec 2021 10:33:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86/db: Change __this_cpu_read() to this_cpu_read()
 in hw_breakpoint_active()
Message-ID: <Ybhk5uRdxIKtWcQP@zn.tnic>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-2-jiangshanlai@gmail.com>
 <YbeaXT1Y80baey3t@zn.tnic>
 <CAJhGHyB=VY-m7fJ+bapWgPsczhH0q9oeMmCTP5cOYJAP0VW5ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyB=VY-m7fJ+bapWgPsczhH0q9oeMmCTP5cOYJAP0VW5ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:51:23AM +0800, Lai Jiangshan wrote:
> The commit message was checked via VIM spellchecker.  It did highlight
> denylist, noinstr, noinstrument, complexify, and a lot more.
> 
> There are too many false-negative results from VIM spellchecker, and

I don't know how your vim is configured but my vim spellchecker
highlights only those words which I mentioned.

> I searched denylist, complexify via google and they are used by some
> other places so I kept them.

And this is where the problem is: you can't just search for words on the
net and whether someone used them or created them and then assume that
the reader would know them and understand what you mean.

Writing commit messages is not an exercise in creative writing. Rather,
your commit messages must be *maximally* *understandable* to the
reviewer so that she/he doesn't have to

a) decipher your commit message
b) decipher your diff

because that's twice the work.

So the goal is to explain why you're doing a change in the clearest way
possible - not do fancy.

Also, even if you use known words, there's this other problem with
formulation: a sentence full of only correct words doesn't make it
understandable to others. So try to stick to simple, even boring
formulations - you can be sure the reader would know what you mean.

> I'm sorry for not searching in the kernel tree to find a proper
> word for noinstrument, not searching the web for better words for
> denylist, complexify.
> 
> I will change a spellchecker and improve my English.

Thanks for the effort!

> What I wanted to say in this paragraph is that why I chose this way to fix
> it since there are several ways/policies to fix it.
> 
> "Changing __this_cpu_read() to this_cpu_read() is fit for" this policy.
> 
> I don't think it can be seen in the diff.

What "policy"? Fit for what?

This is what I mean: the formulation sounds weird and it makes me wonder
what you're *actually* trying to say?

> > I don't really follow the argument for why this_cpu_read();

See, Peter has a hard time understanding your reasoning either.

> >        /*
> >         * Must not hit a breakpoint in check_preempt_disabled()
> >         */
> >        return raw_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
> 
> Although, this comment is describing raw_cpu_read() obviously, I often
> can't get which code is a comment in other places referring to due
> to later changes with new code added and removed.

Each comment must belong to the code it comments - otherwise it needs to
be fixed/removed.

In this particular case, it could be over hw_breakpoint_active() too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
