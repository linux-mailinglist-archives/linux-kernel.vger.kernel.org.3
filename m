Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E006849B822
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583002AbiAYQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:00:30 -0500
Received: from foss.arm.com ([217.140.110.172]:52452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1582888AbiAYP7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:59:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A30AA1FB;
        Tue, 25 Jan 2022 07:58:57 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F883F793;
        Tue, 25 Jan 2022 07:58:55 -0800 (PST)
Date:   Tue, 25 Jan 2022 15:58:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acme@redhat.com, Borislav Petkov <bp@alien8.de>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/7] linkage: better symbol aliasing
Message-ID: <YfAeO+8R+XiYtr8l@FVFF77S0Q05N>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
 <CAMj1kXGCFFHzZAqhfmJthGCe6uhFsrHwzK0QyOfrGw7_kNbjWQ@mail.gmail.com>
 <YfAbMY6U4UpyrerB@FVFF77S0Q05N>
 <CAMj1kXEyzNMWiQFiZW1_QTApmuHfot82USC=Q8nP27sVm+WMMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEyzNMWiQFiZW1_QTApmuHfot82USC=Q8nP27sVm+WMMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:49:03PM +0100, Ard Biesheuvel wrote:
> On Tue, 25 Jan 2022 at 16:46, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 04:28:11PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 25 Jan 2022 at 12:32, Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > This series aims to make symbol aliasing simpler and more consistent.
> > > > The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> > > > SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> > > > that e.g.
> > > >
> > > >     SYM_FUNC_START(func)
> > > >     SYM_FUNC_START_ALIAS(alias1)
> > > >     SYM_FUNC_START_ALIAS(alias2)
> > > >         ... asm insns ...
> > > >     SYM_FUNC_END(func)
> > > >     SYM_FUNC_END_ALIAS(alias1)
> > > >     SYM_FUNC_END_ALIAS(alias2)
> > > >     EXPORT_SYMBOL(alias1)
> > > >     EXPORT_SYMBOL(alias2)
> > > >
> > > > ... can become:
> > > >
> > > >     SYM_FUNC_START(name)
> > > >         ... asm insns ...
> > > >     SYM_FUNC_END(name)
> > > >
> > > >     SYM_FUNC_ALIAS(alias1, func)
> > > >     EXPORT_SYMBOL(alias1)
> > > >
> > > >     SYM_FUNC_ALIAS(alias2, func)
> > > >     EXPORT_SYMBOL(alias2)
> > > >
> > > > This avoids repetition and hopefully make it easier to ensure
> > > > consistency (e.g. so each function has a single canonical name and
> > > > associated metadata).
> > > >
> > >
> > > I take it this affects the sizes of the alias ELF symbols? Does that matter?
> >
> > The alias should be given the same size as the original symbol, unless I've
> > made an error. If you look at patch 3:
> >
> > * In SYM_FUNC_START(name), via SYM_ENTRY_AT(name, ...), we create a local label
> >   for the start of the function: .L____sym_entry__##name
> >
> > * In SYM_FUNC_END(name), via SYM_END_AT(name, ...), we create a local label for
> >   the end of the function: .L____sym_end__##name
> >
> > * In SYM_FUNC_ALIAS*(alias,name), we define the start and end of the alias as
> >   the start and end of the original symbol using those local labels, e.g.
> >
> >   | #define SYM_FUNC_ALIAS(alias, name)                                     \
> >   |         SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_GLOBAL)      \
> >   |         SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
> >
> > Note that:
> >
> > * SYM_FUNC_START() uses SYM_START(), which uses SYM_ENTRY_AT()
> > * SYM_FUNC_END() uses SYM_END(), which uses SYM_END_AT()
> >
> > ... so the definition of tha alias is ultimately structurally identical to the
> > definition of the canoncial name, at least for now.
> >
> 
> Ah right, apologies for not looking more carefully - I assumed the
> changed placement implied that the aliases had zero size.

NP; I didn't make that clear in the cover letter, and now it's written up and
archived for future reference. :)

> And ultimately, I don't think there is an obviously correct answer
> anyway, it's just the [apparently non-existent] change in behavior I
> was curious about.

FWIW, I hadn't really considered whether we actually need that for the aliases;
it was jsut the path of least resistance implementation-wise, and I'd like to
be able to use the local labls for the bounds in future for other annotations
and sanity-checks.

Thanks,
Mark.
