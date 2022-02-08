Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E027D4AD10F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiBHFdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiBHFKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:10:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189DC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:10:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD0A61584
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B4DC004E1;
        Tue,  8 Feb 2022 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644297041;
        bh=hQU4kALbv8KReTh+8inR9J8N9ipY/aO4u1IHOAkwfxU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AaHpKKIOHX7xGKlrNU/X66cmgsQQpMgqyIeBeVpubFjbKqUfPGCX4eDl445Hwgzlz
         4xF0K0WYTjNzvHP5Yjb/zIQP9aaW8LL+wBIC9uNwlPAJmJjroHwVzb9AGq3OdG90Pl
         cmXpUh5ldSBYapjDtyYzhsz4t0JTGP5cAGrVlkhMB/9GfnNUsV9KpGj1i/C2DagM7l
         Tvj/FkqWuQ7Sclpo2s9g0Zv2Ah+zo4RMPfwX5js7oUTKxoeD0P1ctZFnHt5I2+ZgKg
         7WBbHxIcrk8wSLHn+UJB6MJdP4f+KUqqwismbaFSuMdqsE0gyr+dIjlqBO3peK4oFV
         3mblRv79ySLVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A78805C0348; Mon,  7 Feb 2022 21:10:40 -0800 (PST)
Date:   Mon, 7 Feb 2022 21:10:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/42] nolibc: update to resync with out-of-tree project
Message-ID: <20220208051040.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220207162354.14293-1-w@1wt.eu>
 <20220208000028.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220208044150.GA18521@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208044150.GA18521@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:41:50AM +0100, Willy Tarreau wrote:
> On Mon, Feb 07, 2022 at 04:00:28PM -0800, Paul E. McKenney wrote:
> > I queued these from email to get some time on them.  If an update is
> > needed (for example, based on discussion with David Laight), please feel
> > free to send me an update and I can drop the current set in favor of a
> > new version.
> 
> OK thanks!
> 
> > Good stuff, by the way, thank you!!!
> 
> thanks ;-)
> 
> > Hmmm...  I should make rcutorture able to smoke-test this.  My thought
> > would be to add some code to rcutorture's init.c that tried out the
> > system calls.
> 
> I don't think we should abuse rcutorture to test nolibc, however you
> could decide that rcutorture could benefit from some improvements
> (take arguments, parse env or /proc/cmdline, report some info such
> as syscall errors etc).
> 
> > But I bet that you already have some test code.  ;-)
> 
> Actually my testing remains limited in terms of reproducibility. For
> most syscalls I used to just modify a simple test file (hello.c) to
> update the syscall and generally run it under strace; in addition,
> my preinit code builds with it and all my kernels rely on it, which
> gives me extra confidence I didn't break common stuff.
> 
> I've thought about starting to create a real test suite for all these
> calls, either just one syscall or function per file (for easier testing),
> or one test file per test unit (e.g. one for stdlib, one for sys, etc),
> or maybe something in between.

I am mainly looking for a regression test I can run, with or without
rcutorture.  ;-)

> > One approach would be to place the test code in tools/nolibc, and
> > have rcutorture's init.c either #include that or link to it.
> 
> There could be an interesting idea to develop here. While I don't find
> it logical to abuse rcutorture for this, we could instead consider a
> more general init-based test suite that could cover various aspects
> including syscalls and rcutorture. We could let the user choose at
> build time what to implement (so that we don't waste testing time on
> the libc aspect when rcutorture is needed for example), and/or force
> tests on the cmdline (convenient under qemu for example). It could
> also be used to verify if some syscalls were dropped due to some
> config options being turned off.
> 
> I was thinking about having just a numbered suite that iterates over
> numerous tests and provides a test number, a function/syscall name,
> a variant and a result. Something that could easily be copy-pasted
> to ease reporting of breakage.
> 
> This could be especially helpful to port to other architectures. For
> example we're still missing PPC and I don't have much experience there
> (the only one I have access to runs and old version of AIX). And a
> test suite could easily tell if something is broken such as a
> non-implemented syscall.

All excellent points!

> I was hesitant about where to place such a test suite, because I didn't
> want to pollute the include files with tests. In the out-of-tree code
> there's already a "hello.c" file and I started to think about moving the
> rest to include/. But your proposal of tools/nolibc makes sense in that
> it would keep the suite separate from the include files. Actually I'd
> rather put that under tools/testing/selftests/nolibc. With this done,
> I think it would remove some maintenance burden and I could probably
> just kill the out-of-tree project and consider that the up-to-date one
> is in the kernel.

Agreed, tools/testing/selftests/nolibc makes a lot of sense.  As does
having things in-tree, especially given that it seems to have several
contributors now, which presumably means at least that many users.

> > Thoughts?  Especially thoughts about better testing approaches?
> 
> Hehe, each time I think I'm done for a while on this project, you
> manage to fuel me with many interesting ideas for improvements ;-)

"It is a service I provide."  ;-)

							Thanx, Paul
