Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96864E5726
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245677AbiCWRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbiCWRIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:08:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B174DD7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:07:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k21so3788575lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlrAr0XGIkCPHJPtx2Tduug/t/fZJ/9Vzuvrk/N2Q/Q=;
        b=hqUvDc/QeHQ/xjFHfG7JAjDu4YLkDG/f7uB5ksXCiZ1ZlTw5C3L78mZ1/srJPloc6x
         ZOAi94hYrH0w5BZzgyEhUX8+R+4z9fJu6uRrr2IvYVfyozbYpV6MWARLRlat8qVa8F09
         yL0AxhRmGiFSkxscQQ2/yvVsTtqmAI+fY1bN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlrAr0XGIkCPHJPtx2Tduug/t/fZJ/9Vzuvrk/N2Q/Q=;
        b=6eJsH8tNNs8uDxwk/GNeXNbl6w1ZZcRahVTnpPbbBXeToZTiOvLZFudsANOLW3LaiH
         ogWxJoFoSWB+IcOENqW3Oq+DlvSz0RKnYE2e13+0X/f3zqlrkyfyFSlebzbHx7fOowyt
         rYNE6ja8UFd5KgVzcKypnW699axgms9o/8hkfI4WSwfWOEO/wGbxRamhDK0sCCfvqG1k
         9fUPwE4gEVzMAMuO2rGHN5s91cVUdO6jko3U8vYBj4BYgiZikX0O8B9VIZay3V0i0wvq
         yWCLNv5HkEojzBpYsSf1KI/q5cjJ6azso0fLZqYlev+ykXsrTzJ4T3Gl3cM6nIWb8BuG
         hIOA==
X-Gm-Message-State: AOAM530dpN49X2HZr1SY3zgZpVFzLpsC2qzn1rxU9WmKW9oiJoLqHXl5
        6tm7ZOG8J9z5Cb2XSkLvYQdqaMsFriTS9a/5jR8=
X-Google-Smtp-Source: ABdhPJxUTh9cTtgs7HiqgTxWfNzyJdE+/rgrLF1c47QxDbYUVhfDEmf6O4ivybE/DKScWVy1aq83fw==
X-Received: by 2002:a05:6512:1152:b0:44a:1e39:50f4 with SMTP id m18-20020a056512115200b0044a1e3950f4mr632122lfg.402.1648055220666;
        Wed, 23 Mar 2022 10:07:00 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q9-20020a196e49000000b0044a3e9639f7sm42415lfk.75.2022.03.23.10.06.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:06:59 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id o6so2762808ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:06:59 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr811787lji.291.1648055219283; Wed, 23 Mar
 2022 10:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <YjjihIZuvZpUjaSs@google.com> <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com> <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com>
 <CAHk-=whGKUyJpi0dTQJjyJxdmG+WCeKkJJyycpOaUW0De17h_Q@mail.gmail.com> <YjtKRAgFmBfgU0al@google.com>
In-Reply-To: <YjtKRAgFmBfgU0al@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 10:06:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi99R8i=uvHiHo3jjZPzg6oTJW1rin3ekuPbuccS5XZqA@mail.gmail.com>
Message-ID: <CAHk-=wi99R8i=uvHiHo3jjZPzg6oTJW1rin3ekuPbuccS5XZqA@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.18
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Tim Murray <timmurray@google.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 9:26 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> OTOH, I was suspecting the major contetion would be
>         f2fs_lock_op -> f2fs_down_read(&sbi->cp_rwsem);
> , which was used for most of filesystem operations.

Very possible, I was just looking at a random one in f2fs/file.c
obviously with no actual numbers in hand.

In general, I really hate seeing specialized locks, but this f2fs use
case is in some ways worse than other ad-hoc locks I've seen - simply
because it's been one whole-sale conversion of "down_read/write()" to
"f2fs_down_read/write()" - regardless of _which_ lock is being locked.

(Now, it's not all bad news - in other respects it's much better than
some ad-hoc locking: at least you still will participate in lockdep,
and you use the actual low-level locking primitives instead of making
up your own and getting memory ordering wrong).

But basically I think it would have been much nicer if you would have
done this for just the _one_ lock that mattered, whichever lock that
might be. Partly as documentation, and partly so that maybe some day
you can split that lock up (or maybe notice cases where you can avoid
it entirely).

For example, if it's really just f2fs_lock_op() that needs this, the
special "wait_event(trylock)" hack could have been entirely local to
just *that*, rather than affecting all the other locks too.

And the very first f2fs_lock_op() case I find, I see that the lock is
pointless. Again, that's unlikely to be the *cause* of any of these
problems, but the fact that I've now looked at two of the f2fs locks,
and gone "the locking seems to be pointlessly badly done" does imply
that the problem isn't "down_read()", it's the use.

That other lock I reacted to was the f2fs_lock_op(sbi) at the top of
f2fs_new_inode().

Look, you have a new inode that you just allocated, that nobody else
can yet access.

And the only thing that that f2fs_lock_op(sbi) -> f2fs_unlock_op(sbi)
sequence protects is the f2fs_alloc_nid() for that new inode.

Ok, so maybe f2fs_alloc_nid() needs that lock?

No it doesn't. It already has

 - &nm_i->nid_list_lock spinlock for its own in-memory internal NID caches

*and* when that fails

 - &NM_I(sbi)->build_lock for protecting all of f2fs_build_free_nids()

*and* inside of that lock

 - f2fs_down_read(&nm_i->nat_tree_lock) for protecting the NAT tree structures.

So I see two major issues in the very first user of that
f2fs_lock_op() that I look at:

 (a) it seems to be entirely unnecessary

 (b) it is a classic case of "multiple nested locks".

Now, it's possible that I'm wrong on (a) and there's some odd reason
that lock is needed (maybe there is a lock ordering problem for one of
the other locks between readers and writers, and the op-lock acts as a
mutual exclusion for that).

But (b) really is a classic problem case for locking: nested locks are
*much* more likely to cause horrible contention, because not any
contention in any of the locks will end up affecting the others (and
you easily get "bunching up" of different processes when they get
synchronized with each other thanks to the inner lock).

Nested locking is often required, but it's one of those things where
you just need to be aware that they can be horribly bad for
performance, _particularly_ if an inner lock sees contention and
essentially "transfers" that contention to an outer lock.

Maybe I've been unlucky. Maybe the two cases I happened to look at
were just completely harmless, and very unusual. But the fact that I'm
two-for-two and go "that locking looks like a prime candidate to be
fixed" makes me suspect there's a lot of low-hanging fruit in there.

And that whole "wait_event(trylock)" thing is a symptom of problematic
f2fs locking, rather than a solution to it.

                 Linus
