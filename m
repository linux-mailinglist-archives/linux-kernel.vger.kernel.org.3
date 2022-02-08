Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB664AD113
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiBHFd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiBHFOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:14:50 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42312C0401E9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:14:49 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2185EhAW019039;
        Tue, 8 Feb 2022 06:14:43 +0100
Date:   Tue, 8 Feb 2022 06:14:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@aculab.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/42] tools/nolibc/types: move the FD_* functions to
 macros in types.h
Message-ID: <20220208051443.GB18521@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
 <20220207162354.14293-12-w@1wt.eu>
 <083fac943c8c422a9f667f6b0371153c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083fac943c8c422a9f667f6b0371153c@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Feb 07, 2022 at 05:05:21PM +0000, David Laight wrote:
> From: Willy Tarreau
> > Sent: 07 February 2022 16:23
> > 
> > FD_SET, FD_CLR, FD_ISSET, FD_ZERO are supposed to be macros and not
> > functions.
> 
> Are you sure?
> I'd have thought they could be either.
> There are certainly systems where they are functions.

I've rechecked and you're right, they can be both. But I now remember
why I mentioned this, I used to have some early userland code that used
to redefine these based on #ifndef FD_CLR and that started to fail to
build depending on the include order (i.e. macro defined first, then
nolibc being included from another file).

> They can be implemented as an array of fd numbers rather than a bitmap.

I didn't think about the array of FDs but I see how that can be done,
indeed!

> > In addition we already have a file dedicated to such macros
> > and types used by syscalls, it's types.h, so let's move them
> > there and turn them to macros. FD_CLR() and FD_ISSET() were missing,
> > so they were added. FD_ZERO() now deals with its own loop so that it
> > doesn't rely on memset() that sets one byte at a time.
> > 
> ....
> > +#define FD_CLR(fd, set) do {                                            \
> > +		int __fd = (int)(fd);                                   \
> > +		fd_set *__set = (fd_set *)(set);                        \
> 
> I'm not sure you really want either cast.
> They are just likely to hide some horrid bugs.

I generally hate casts exactly for the reason you mentioned, but wanted
to stick as close as possible to the equivalent of the original function.
However now that there are these local variables the casts are not needed
anymore at all and I agree we should drop them. I'll do that.

> +		if (__fd >= 0 && __fd < FD_SETSIZE)                     \
> +			__set->fd32[__fd / 32] &= ~(1U << (__fd & 31)); \
> +	} while (0)
> +
> 
> Do you need the range check?
> I don't think glibc has one.
> Things just break in obscure ways when you use select on big fd.

Sadly, some versions of glibc have enforced such checks "recently".
I've seen code that used to work fine for 20 years with arbitrary
fd_set array lengths start to break because the libc was seeing some
out-of-bounds accesses, to the point that I finally completely stopped
using select() around 2013, and also stopped using FD_SET/FD_CLR to
manipulate arbitrary bitmaps and implement my own instead (see the
__FD_ELT macro in glibc for this).

The select(2) man page says:

  An fd_set is a fixed size buffer.  Executing FD_CLR() or FD_SET() with
  a value of fd that is negative or is equal to or larger than FD_SETSIZE
  will result in undefined behavior.  

The main reason for the check here in fact is to avoid annoying compiler
warnings such as -Warray-bounds and limit side effects if FDs are not
tested immediately before being passed to FD_SET (we're supposed to be
dealing with ugly early code where tests are often non-existent). I
think it's a reasonable compromise. I would also be fine with only
keeping the test on (fd >= 0) and dropping the one on FD_SETSIZE though.

Paul, I'll send a V2 of that patch once updated.

Thank you!
Willy
