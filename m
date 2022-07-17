Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1360D577880
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 23:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiGQVxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 17:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGQVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 17:53:32 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF2381263D;
        Sun, 17 Jul 2022 14:53:31 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26HLjA69019105;
        Sun, 17 Jul 2022 16:45:10 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26HLj9EJ019104;
        Sun, 17 Jul 2022 16:45:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 17 Jul 2022 16:45:08 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
Message-ID: <20220717214508.GD25951@gate.crashing.org>
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com> <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com> <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com> <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com> <20220717205615.GC25951@gate.crashing.org> <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 02:11:52PM -0700, Linus Torvalds wrote:
> On Sun, Jul 17, 2022 at 2:00 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > Calling mem* on a volatile object (or a struct containing one) is not
> > valid.  I opened gcc.gnu.org/PR106335.
> 
> Well, that very quickly got marked as a duplicate of a decade-old bug.
> 
> So I guess we shouldn't expect this to be fixed any time soon.

It shouldn't be all that hard to implement.  GCC wants all ports to
define their own mem* because these functions are so critical for
performance, but it isn't hard to do a straightforward by-field copy
for assignments if using memcpy would not be valid at all.  Also, if
we would have this we could make a compiler flag saying to always
open-code this, getting rid of this annoyance (namely, that extetnal
mem* are required) for -ffreestanding.

> That said, your test-case of copying the whole structure is very
> different from the one in the kernel that works on them one structure
> member at a time.
> 
> I can *kind of* see the logic that when you do a whole struct
> assignment, it turns into a "memcpy" without regard for volatile
> members. You're not actually accessing the volatile members in some
> particular order, so the struct assignment arguably does not really
> have an access ordering that needs to be preserved.

The order is not defined, correct.  But a "volatile int" can only be
accessed as an int, and an external memcpy will typically use different
size accesses, and can even access some fields more than once (or
partially); all not okay for a volatile object.

> But the kernel code in question very much does access the members
> individually, and so I think that the compiler quite unequivocally did
> something horribly horribly bad by turning them into a memset.
> 
> So I don't think your test-case is really particularly good, and maybe
> that's why that old bug has languished for over a decade - people
> didn't realize just *how* incredibly broken it was.

People haven't looked at my test case for all that time, it sprouted
from my demented mind just minutes ago ;-)  The purpose of writing it
this way was to make sure that memcpy will be called for this (on any
target etc.), not some shorter and/or smarter thing.

I don't know what the real reason is that this bugs hasn't been fixed
yet.  It should be quite easy to make this more correct.  In
<https://patchwork.ozlabs.org/project/gcc/patch/1408617247-21558-1-git-send-email-james.greenhalgh@arm.com/#843066>
Richard suggested doing it in the frontend, which seems reasonable (but
more work than the patch there).

There have been no follow-up patches as far as I can see :-(


Segher
