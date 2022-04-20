Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37801508934
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378987AbiDTN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379023AbiDTN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014326FF;
        Wed, 20 Apr 2022 06:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A55861A51;
        Wed, 20 Apr 2022 13:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9748C385A0;
        Wed, 20 Apr 2022 13:24:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ULX6+t9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650461094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zViedf6BdiM4N8cQIaCXVT7SDe0/tNGlIcqUURYcAYo=;
        b=ULX6+t9a/xxPf4XzndnIwSFsYT5uvJpuLLc2zAsEzslp56ek1vg8kNusNcqCina89HNUQj
        tOTWG62irY7DedbldzdwUfOr9vD0oC9i17vTjXdyhH3igO2AuA5KuxdeVenbkDAe3PU24M
        FaKDQBzUXupl2lyEVh0PsBcUAM0h48U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 65fa884e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 20 Apr 2022 13:24:54 +0000 (UTC)
Date:   Wed, 20 Apr 2022 15:24:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jann Horn <jannh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>
Subject: Re: [PATCH] random: add fork_event sysctl for polling VM forks
Message-ID: <YmAJoGtqA3PMrZmD@zx2c4.com>
References: <20220419160407.1740458-1-Jason@zx2c4.com>
 <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
 <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com>
 <CAG48ez2X72XkpxaEDmzykewreuhk8=5t5L5b2Qdr1dn8LcFutw@mail.gmail.com>
 <CAHmME9q+mDw6n3FNJLvoZoD3UsX-G5PvTwb5L7h_M9RFKNemSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9q+mDw6n3FNJLvoZoD3UsX-G5PvTwb5L7h_M9RFKNemSw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Wed, Apr 20, 2022 at 02:15:45AM +0200, Jason A. Donenfeld wrote:
> Hi Jann,
> 
> On Tue, Apr 19, 2022 at 9:45 PM Jann Horn <jannh@google.com> wrote:
> > AFAIK this also means that if you make an epoll watch for
> > /proc/sys/kernel/random/fork_event, and then call poll() *on the epoll
> > fd* for some reason, that will probably already consume the event; and
> > if you then try to actually receive the epoll event via epoll_wait(),
> > it'll already be gone (because epoll tries to re-poll the "ready"
> > files to figure out what state those files are at now). Similarly if
> > you try to create an epoll watch for an FD that already has an event
> > pending: Installing the watch will call the ->poll handler once,
> > resetting the file's state, and the following epoll_wait() will call
> > ->poll again and think the event is already gone. See the call paths
> > to vfs_poll() in fs/eventpoll.c.
> >
> > Maybe we don't care about such exotic usage, and are willing to accept
> > the UAPI inconsistency and slight epoll breakage of plumbing
> > edge-triggered polling through APIs designed for level-triggered
> > polling. IDK.
> 
> Hmm, I see. The thing is, this is _already_ what's done for
> domainname/hostname. It's how the sysctl poll handler was "designed".
> So our options here are:
> 
> a) Remove this quirky behavior from domainname/hostname and start
> over. This would potentially break userspace, but maybe nobody uses
> this? No idea, but sounds risky.
> 
> b) Apply this commit as-is, because it's using the API as the API was
> designed, and call it a day.
> 
> c) Apply this commit as-is, because it's using the API as the API was
> designed, and then later try to fix up the epoll behavior on this.
> 
> Of these, (a) seems like a non-starter. (c) is most appealing, but it
> sounds like it might not actually be possible?
> 
> Jason

I actually tried to verify your concern but didn't have success doing
so.

Both of these worked:

        int efd = epoll_create1(0);
        assert(efd >= 0);
        struct epoll_event event = {
                .data.fd = open("/proc/sys/kernel/random/fork_event", O_RDONLY)
        };
        assert(event.data.fd >= 0);
        assert(epoll_ctl(efd, EPOLL_CTL_ADD, event.data.fd, &event) == 0);
        for (;;) {
                assert(epoll_wait(efd, &event, 1, -1) == 1);
                puts("vm fork detected");
        }

And:

        int efd = epoll_create1(0);
        assert(efd >= 0);
        struct epoll_event event = {
                .data.fd = open("/proc/sys/kernel/random/fork_event", O_RDONLY)
        };
        assert(event.data.fd >= 0);
        assert(epoll_ctl(efd, EPOLL_CTL_ADD, event.data.fd, &event) == 0);
        for (;;) {
                assert(poll(&(struct pollfd){ .fd = efd, .events = POLLIN }, 1, -1) == 1);
                puts("vm fork detected");
        }

It also worked if I added EPOLLET to the epoll_event. It did not work if
I removed POLLIN from the pollfd event.

Maybe I'm missing some subtlety. But what exactly is broken? (Either
way, it doesn't change the (a) vs (c) calculus in my previous email.)

Jason
