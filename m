Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D82C4A5244
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiAaWVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:21:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:40799 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbiAaWVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:21:33 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 20VMDZ8D023795;
        Mon, 31 Jan 2022 16:13:35 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 20VMDXsA023794;
        Mon, 31 Jan 2022 16:13:33 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 31 Jan 2022 16:13:33 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     apinski@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile & __COUNTER__
Message-ID: <20220131221333.GR614@gate.crashing.org>
References: <20220114010526.1776605-1-ndesaulniers@google.com> <YeQei0xNzMq7bFdg@zn.tnic> <20220118192256.jzk5dnceeusq7x7u@treble> <20220118230120.pivvson7qekfiqic@treble> <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com> <20220125233128.GT614@gate.crashing.org> <CAKwvOdnB=OfCc_31b=PMjxKewvb3CV2WDwhMWrigviWaHrGMhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnB=OfCc_31b=PMjxKewvb3CV2WDwhMWrigviWaHrGMhw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:45:20PM -0800, Nick Desaulniers wrote:
> On Tue, Jan 25, 2022 at 3:34 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > Hi!
> >
> > On Mon, Jan 24, 2022 at 03:26:36PM -0800, Nick Desaulniers wrote:
> > > I'm more confident that we can remove the `volatile` keyword (I was
> > > thinking about adding a new diagnostic to clang to warn that volatile
> > > is redundate+implied for asm goto or inline asm that doesn't have
> > > outputs) though that's not the problem here and will probably generate
> > > some kernel wide cleanup before we could enable such a flag.
> >
> > Its main value is that it would discourage users from thinking volatile
> > is magic.  Seriously worth some pain!
> 
> https://reviews.llvm.org/D118297
> PTAL

""
  Really the volatile asm-qualifier exists only to signal that an asm
  statement should not be DCE'd (when it has outputs but they are unused),
  CSE'd, or LICM'd. It is not a general compiler barrier.

It means that the asm has a side effect (one unknown to the compiler),
so it must be executed in the real machine just where it would be in the
abstract machine.  It *can* be CSEd, it *can* be DCEd, it can even be
optimised by LICM in certain cases: but it has to be executed as often
(and in the same order etc.) in the resulting machine code as it would
be if you single-stepped through the source code by hand.

Those are fine examples if you add "in most cases" (and that they are
just examples, it's not an exhaustive list).

Thanks,


Segher
