Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1665925C8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiHNRYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA41CFDE
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 10:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14CD60CFA
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1435FC433C1;
        Sun, 14 Aug 2022 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660497886;
        bh=p2LxvXFENTwgYcSS5Yn41GhqMEj0WPOKR7omYPD4ZQs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ieTX89ubKqkNiVqgx3tNirYvshyeY4ozDpTfYqnTABaYxQmyStC0HEKMfQv8jldHB
         r8iPx+LptMgJY1IZFo2sMpr4XsQ/NDW+i4JZ+5kAMHFODSK0Tg9eH4Lfbyf3dJRIgm
         4BURkkmrrfCM/6EJwD3v6U9mefbn10UW368IeMSb/d1h5PyTTqAujQHGylhPClh/Lj
         GBnouAQvIg6mIzw+5vIfQHO3Hrq94sf2QFZLxgOOooI0QTVnNZpwAk6kAJsLwK+ZWs
         KC3Z+aT4lye58lCRyagKQVEjMxmiSdvyrzvF51PKXAXRkyWw/ffyd5Zhrh7/ZkjFUX
         ghkAOFyXR8Ncg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AFFF55C033A; Sun, 14 Aug 2022 10:24:45 -0700 (PDT)
Date:   Sun, 14 Aug 2022 10:24:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <20220814172445.GR2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yvd8L0qIbLarxrOQ@gmail.com>
 <YvfQUGLGY7cfZ9gf@zn.tnic>
 <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
 <YvjtkidVZg2sBY0R@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvjtkidVZg2sBY0R@zn.tnic>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 02:41:54PM +0200, Borislav Petkov wrote:
> On Sat, Aug 13, 2022 at 01:27:40PM -0700, Linus Torvalds wrote:
> > On Sat, Aug 13, 2022 at 9:25 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > That task_struct.sighand is marked __rcu and thus noderef and sparse
> > > complains:
> > 
> > I think that RCU marking is misleading.
> > 
> > Doing a
> > 
> >         git grep -e '->sighand'
> > 
> > shows that we basically never treat that as some kind of RCU pointer.
> > 
> > Adding a
> > 
> >         grep -i rcu
> > 
> > to the above shows that we have a couple of places that do this
> > carefully, but they are the exception rather than the rule.
> > 
> > I think the issue is that "current->sighand" is always safe (and that
> > "me->sighand" is the same thing), and that sighand has RCU-delayed
> > freeing so that __lock_task_sighand() can safely try to take the lock
> > of another process' sighand.
> > 
> > And we have no real way to explain to sparse that *some* cases are
> > fine, others are not and need the sighand lock (after that careful
> > __lock_task_sighand thing).
> 
> Sounds to me like that sparse check was not such a good idea in the
> first place. Especially since the 0day bot is probably warning about all
> those cases where we try to lock ->sighand.
> 
> It was added by
> 
> 913292c97d75 ("sched.h: Annotate sighand_struct with __rcu")
> 
> Lemme add the involved parties to Cc.

If it is causing more trouble than it is worth, then I have not objection
to taking a different approach.

							Thanx, Paul
