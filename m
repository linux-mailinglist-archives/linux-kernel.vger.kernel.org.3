Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4238054CF11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbiFOQyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFOQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:54:12 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 065B936158;
        Wed, 15 Jun 2022 09:54:10 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 25FGkua9031580;
        Wed, 15 Jun 2022 11:46:56 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 25FGktYk031577;
        Wed, 15 Jun 2022 11:46:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 15 Jun 2022 11:46:55 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
Message-ID: <20220615164655.GC25951@gate.crashing.org>
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com> <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com> <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com> <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com> <20220614214039.GA25951@gate.crashing.org> <CAG_fn=UPyoySbzbLQnJkgbfcSkyCD11M=e+W4-T_WoQCXEPFGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UPyoySbzbLQnJkgbfcSkyCD11M=e+W4-T_WoQCXEPFGA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Jun 15, 2022 at 10:30:17AM +0200, Alexander Potapenko wrote:
> On Tue, Jun 14, 2022 at 11:45 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > Since C11, lvalue conversion of an automatic variable that does not have
> > its address taken is explicitly undefined behaviour (6.3.2.1/2).  So in
> > function "p", both where "c" and where "size" are passed causes UB (so
> > that executing "p" always causes UB btw).
> 
> Thanks for this reference to the standard. I've received another one
> off-list, which lets the variables be address-taken:
> 
> 6.2.4/6: "If an initialization is specified for the object, it is
> performed each time the declaration or compound literal is reached in
> the execution of the block; otherwise, the value becomes indeterminate
> each time the declaration is reached."
> 3.19.2/1: "indeterminate value: either an unspecified value or a trap
> representation"
> 6.2.6.1/5: "Certain object representations need not represent a value
> of the object type. If the stored value of an object has such a
> representation and is read by an lvalue expression that does not have
> character type, the behavior is undefined. If such a representation is
> produced by a side effect that modifies all or any part of the object
> by an lvalue expression that does not have character type, the
> behavior is undefined. [Footnote: Thus, an automatic variable can be
> initialized to a trap representation without causing undefined
> behavior, but the value of the variable cannot be used until a proper
> value is stored in it.] Such a representation is called a trap
> representation."

That only affects types that have trap representations though, which
importantly explicitly does not include unsigned types without padding
bits, and unsigned char always.

Some people (on the standards committee) think all uninitialised uses
should be UB.  And some think not.  But since C11 we have this new
explicit UB for automatic variables that don't have their address taken.

(The background of that is the Itanium NaT (not-a-thing) bit in its
registers; without this new clause compilers for Itanium needed to
initialise many things that they now do not, with some readings of the
standard anyway :-) )

> > GCC does not warn, it has already optimised the code to what you expect
> > by the time this warning is done.  If you use -fno-inline it does warn
> > for both "c" and "size" (via -Wmaybe-uninitialized).
> >
> > But it is still UB!  All bets are off, no compiler can do any correct
> > translation of your program, since there *is none*.
> 
> Then it makes sense for us to report non-trivial cases where
> uninitialized values are actually passed to functions.

Yes, and IMO it makes sense to report this to compilers as well, if they
do not yet warn for some simple cases.

Cheers,


Segher
