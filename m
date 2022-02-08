Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF14AD0BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiBHFcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbiBHEl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:41:58 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3332BC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:41:56 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2184foVR018745;
        Tue, 8 Feb 2022 05:41:50 +0100
Date:   Tue, 8 Feb 2022 05:41:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/42] nolibc: update to resync with out-of-tree project
Message-ID: <20220208044150.GA18521@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
 <20220208000028.GG4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208000028.GG4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:00:28PM -0800, Paul E. McKenney wrote:
> I queued these from email to get some time on them.  If an update is
> needed (for example, based on discussion with David Laight), please feel
> free to send me an update and I can drop the current set in favor of a
> new version.

OK thanks!

> Good stuff, by the way, thank you!!!

thanks ;-)

> Hmmm...  I should make rcutorture able to smoke-test this.  My thought
> would be to add some code to rcutorture's init.c that tried out the
> system calls.

I don't think we should abuse rcutorture to test nolibc, however you
could decide that rcutorture could benefit from some improvements
(take arguments, parse env or /proc/cmdline, report some info such
as syscall errors etc).

> But I bet that you already have some test code.  ;-)

Actually my testing remains limited in terms of reproducibility. For
most syscalls I used to just modify a simple test file (hello.c) to
update the syscall and generally run it under strace; in addition,
my preinit code builds with it and all my kernels rely on it, which
gives me extra confidence I didn't break common stuff.

I've thought about starting to create a real test suite for all these
calls, either just one syscall or function per file (for easier testing),
or one test file per test unit (e.g. one for stdlib, one for sys, etc),
or maybe something in between.

> One approach would be to place the test code in tools/nolibc, and
> have rcutorture's init.c either #include that or link to it.

There could be an interesting idea to develop here. While I don't find
it logical to abuse rcutorture for this, we could instead consider a
more general init-based test suite that could cover various aspects
including syscalls and rcutorture. We could let the user choose at
build time what to implement (so that we don't waste testing time on
the libc aspect when rcutorture is needed for example), and/or force
tests on the cmdline (convenient under qemu for example). It could
also be used to verify if some syscalls were dropped due to some
config options being turned off.

I was thinking about having just a numbered suite that iterates over
numerous tests and provides a test number, a function/syscall name,
a variant and a result. Something that could easily be copy-pasted
to ease reporting of breakage.

This could be especially helpful to port to other architectures. For
example we're still missing PPC and I don't have much experience there
(the only one I have access to runs and old version of AIX). And a
test suite could easily tell if something is broken such as a
non-implemented syscall.

I was hesitant about where to place such a test suite, because I didn't
want to pollute the include files with tests. In the out-of-tree code
there's already a "hello.c" file and I started to think about moving the
rest to include/. But your proposal of tools/nolibc makes sense in that
it would keep the suite separate from the include files. Actually I'd
rather put that under tools/testing/selftests/nolibc. With this done,
I think it would remove some maintenance burden and I could probably
just kill the out-of-tree project and consider that the up-to-date one
is in the kernel.

> Thoughts?  Especially thoughts about better testing approaches?

Hehe, each time I think I'm done for a while on this project, you
manage to fuel me with many interesting ideas for improvements ;-)

Cheers,
Willy
