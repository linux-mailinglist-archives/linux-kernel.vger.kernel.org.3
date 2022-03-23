Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BA4E5A92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344885AbiCWVWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiCWVWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:22:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2985644
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E13D2B820C5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 21:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D880C340EE;
        Wed, 23 Mar 2022 21:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648070469;
        bh=pi4TsVzQEBzAwpJQOAYodMLonLQpZSt0gqr4sMg+vN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFGFG1ApYl/SfF0lPexzaDWCb3nM7r0Q1oJaR4DWf34eUD1IdXXzArV5VsHEeDzkx
         jals1gSGpf1j4r5E+jG7aLG0ljiJ4j9qmS13NuVq5Qjcbi782RoAKBrKgOOXGyStGr
         f4nHE5kKMLC/fJAc/ABzSnB6LEv1UTucf4wqTRBsMHXT8OLtrC7ZOkVVb4AaJoKplP
         oGu9U5DcC/aMXgIyFsAi9k918VU87xWdBDfLvYO0rr7V3+Wc+auC4qN0tHoUcgm9sm
         9QacqXJLRd/WNbzWAWQRuGfzfVozPsws8uKQWcBTaS16QBqf8/W6/gEopsyA7iH3ZU
         bo2GrGLZmb11Q==
Date:   Wed, 23 Mar 2022 14:21:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tim Murray <timmurray@google.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YjuPQ36A4W553ai1@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
 <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com>
 <CAHk-=whGKUyJpi0dTQJjyJxdmG+WCeKkJJyycpOaUW0De17h_Q@mail.gmail.com>
 <YjtKRAgFmBfgU0al@google.com>
 <CAHk-=wi99R8i=uvHiHo3jjZPzg6oTJW1rin3ekuPbuccS5XZqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi99R8i=uvHiHo3jjZPzg6oTJW1rin3ekuPbuccS5XZqA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Linus Torvalds wrote:
> On Wed, Mar 23, 2022 at 9:26 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > OTOH, I was suspecting the major contetion would be
> >         f2fs_lock_op -> f2fs_down_read(&sbi->cp_rwsem);
> > , which was used for most of filesystem operations.
> 
> Very possible, I was just looking at a random one in f2fs/file.c
> obviously with no actual numbers in hand.
> 
> In general, I really hate seeing specialized locks, but this f2fs use
> case is in some ways worse than other ad-hoc locks I've seen - simply
> because it's been one whole-sale conversion of "down_read/write()" to
> "f2fs_down_read/write()" - regardless of _which_ lock is being locked.
> 
> (Now, it's not all bad news - in other respects it's much better than
> some ad-hoc locking: at least you still will participate in lockdep,
> and you use the actual low-level locking primitives instead of making
> up your own and getting memory ordering wrong).
> 
> But basically I think it would have been much nicer if you would have
> done this for just the _one_ lock that mattered, whichever lock that
> might be. Partly as documentation, and partly so that maybe some day
> you can split that lock up (or maybe notice cases where you can avoid
> it entirely).
> 
> For example, if it's really just f2fs_lock_op() that needs this, the
> special "wait_event(trylock)" hack could have been entirely local to
> just *that*, rather than affecting all the other locks too.
> 
> And the very first f2fs_lock_op() case I find, I see that the lock is
> pointless. Again, that's unlikely to be the *cause* of any of these
> problems, but the fact that I've now looked at two of the f2fs locks,
> and gone "the locking seems to be pointlessly badly done" does imply
> that the problem isn't "down_read()", it's the use.
> 
> That other lock I reacted to was the f2fs_lock_op(sbi) at the top of
> f2fs_new_inode().
> 
> Look, you have a new inode that you just allocated, that nobody else
> can yet access.
> 
> And the only thing that that f2fs_lock_op(sbi) -> f2fs_unlock_op(sbi)
> sequence protects is the f2fs_alloc_nid() for that new inode.
> 
> Ok, so maybe f2fs_alloc_nid() needs that lock?
> 
> No it doesn't. It already has
> 
>  - &nm_i->nid_list_lock spinlock for its own in-memory internal NID caches
> 
> *and* when that fails
> 
>  - &NM_I(sbi)->build_lock for protecting all of f2fs_build_free_nids()
> 
> *and* inside of that lock
> 
>  - f2fs_down_read(&nm_i->nat_tree_lock) for protecting the NAT tree structures.
> 
> So I see two major issues in the very first user of that
> f2fs_lock_op() that I look at:
> 
>  (a) it seems to be entirely unnecessary

Actually, when I took a look at the above path, indeed, f2fs_lock_op in
f2fs_new_inode may be unnecessary at all aligned to your points. Even, that
might hurt performance since we get f2fs_lock_op twice before dealing with
dentries like f2fs_add_link. Let me test a bit whether there's any regression
if I remove f2fs_lock_op in f2fs_new_inode.

> 
>  (b) it is a classic case of "multiple nested locks".
> 
> Now, it's possible that I'm wrong on (a) and there's some odd reason
> that lock is needed (maybe there is a lock ordering problem for one of
> the other locks between readers and writers, and the op-lock acts as a
> mutual exclusion for that).
> 
> But (b) really is a classic problem case for locking: nested locks are
> *much* more likely to cause horrible contention, because not any
> contention in any of the locks will end up affecting the others (and
> you easily get "bunching up" of different processes when they get
> synchronized with each other thanks to the inner lock).
> 
> Nested locking is often required, but it's one of those things where
> you just need to be aware that they can be horribly bad for
> performance, _particularly_ if an inner lock sees contention and
> essentially "transfers" that contention to an outer lock.
> 
> Maybe I've been unlucky. Maybe the two cases I happened to look at
> were just completely harmless, and very unusual. But the fact that I'm
> two-for-two and go "that locking looks like a prime candidate to be
> fixed" makes me suspect there's a lot of low-hanging fruit in there.

Thank you so much for taking the time to write this great advise. Let me dig
more whether there's anything that I can relax the lock use-cases further.
(tbh, I haven't reviewed them for a long time due to focusing on stability
issues mostly.)

> 
> And that whole "wait_event(trylock)" thing is a symptom of problematic
> f2fs locking, rather than a solution to it.

Understood. If I can avoid lock contention upfront, definitely it wouldn't
need to apply rwsem change at all. Let me take some time to think about how to
move forward.

> 
>                  Linus
