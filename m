Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485CF49C885
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiAZLVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:21:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:60260 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233637AbiAZLVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:21:37 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 20QBDv5f023172;
        Wed, 26 Jan 2022 05:13:57 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 20QBDtdZ023171;
        Wed, 26 Jan 2022 05:13:55 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 26 Jan 2022 05:13:55 -0600
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
        linux-toolchains@vger.kernel.org, apinski@marvell.com
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile & __COUNTER__
Message-ID: <20220126111355.GU614@gate.crashing.org>
References: <20220114010526.1776605-1-ndesaulniers@google.com> <YeQei0xNzMq7bFdg@zn.tnic> <20220118192256.jzk5dnceeusq7x7u@treble> <20220118230120.pivvson7qekfiqic@treble> <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com> <20220125233128.GT614@gate.crashing.org> <CAKwvOd=P0VAFrrUXV0z5dES9hYP2b8-KwTzyG5=ezeUve=K3QA@mail.gmail.com> <CAKwvOdnBT74081nCw2hcm2dxCacV0ume_noZ0=Q6e0UiBDF7wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnBT74081nCw2hcm2dxCacV0ume_noZ0=Q6e0UiBDF7wg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Jan 25, 2022 at 06:12:20PM -0800, Nick Desaulniers wrote:
> Andrew clarified (thanks Andrew!) that %= can't be used as I imagined
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104236#c4
> and that I think was alluded to in
> commit 3d1e236022cc ("objtool: Prevent GCC from merging annotate_unreachable()")
> which is fine, so I'll just need to keep usage of __COUNTER__.

Aha.  Yes, %= *outputs* a unique number.  Before the assembler output
is written %= is just a string (like any other piece of output
template).  The output template is used for three things:

1) Inline assembler statements with different output templates are not
considered identical;
2) Newlines and assembler statement separators (semicolons for most
assembler dialects) are used to estimate the size of the machine code
generated.  This is a pessimistic estimate, but within reason: for
example you can write a million byte output with just a few characters
of input, if you want to sabotage yourself;
3) The output template is used at output time.

The mentioned commit's message says "unfortunately older versions of GCC
don't support it" which is mistaken.

If you want two identical inline asm statements to not be considered
identical by the compiler, you have to make them not identical.  Like by
using __COUNTER__ for example, yes :-)


Segher
