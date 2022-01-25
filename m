Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15E49BFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiAYXje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:39:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:54754 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234898AbiAYXjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:39:31 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 20PNVUiB032739;
        Tue, 25 Jan 2022 17:31:30 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 20PNVSKH032738;
        Tue, 25 Jan 2022 17:31:28 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 25 Jan 2022 17:31:28 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20220125233128.GT614@gate.crashing.org>
References: <20220114010526.1776605-1-ndesaulniers@google.com> <YeQei0xNzMq7bFdg@zn.tnic> <20220118192256.jzk5dnceeusq7x7u@treble> <20220118230120.pivvson7qekfiqic@treble> <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Jan 24, 2022 at 03:26:36PM -0800, Nick Desaulniers wrote:
> I noticed in that report and
> https://lore.kernel.org/lkml/202201190702.XNSXrMTK-lkp@intel.com/
> that gcc-9 was used.  I wonder if %= has been fixed in gcc-10+? Have
> there been other reports with gcc-10+ for my patch?

None of the %= code (which is trivial) has been changed since 1992.

> If this is fixed in gcc-10, then we can probably add a comment with a
> FIXME link to the issue or commit to replace __COUNTER__ with %= one
> day.  If not, then we can probably come up with a reduced test case
> for the GCC devs to take a look at, then add the FIXME comment to
> kernel sources.

Please open a PR?

> I'm more confident that we can remove the `volatile` keyword (I was
> thinking about adding a new diagnostic to clang to warn that volatile
> is redundate+implied for asm goto or inline asm that doesn't have
> outputs) though that's not the problem here and will probably generate
> some kernel wide cleanup before we could enable such a flag.

Its main value is that it would discourage users from thinking volatile
is magic.  Seriously worth some pain!

> Perhaps
> there are known compiler versions that still require the keyword for
> those cases for some reason.

It was removed from compiler-gcc.h in 3347acc6fcd4 (which changed the
minimum required GCC version to GCC 5).


Segher
