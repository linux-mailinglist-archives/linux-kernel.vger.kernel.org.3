Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C684E7D94
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiCYUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiCYUlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:41:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1288174BA5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:40:19 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89AA81F38D;
        Fri, 25 Mar 2022 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648240818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9M7QZdRGdE3YhShW86pT5r5ZtL5gB0GDJS64qnrEpE=;
        b=vJAmFgPtWS50PZHhxtvZdmj6RtHoiDKqEab6QuQ9Vc1Zp49IAuWFPe363NH7XHnlNnfsWk
        jFeYkPayJo0cuLJcbIv4jw0KZZldnosVu9hieoVAx65JtNCTq+ybhpKdpJeco+B1rTr4rG
        mA3sbCiT9kovlU42xDGeXONef+DToDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648240818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9M7QZdRGdE3YhShW86pT5r5ZtL5gB0GDJS64qnrEpE=;
        b=h3rXLjyaC/ZqwcpGYJjD7wri1DbiBkxRd2ZnL4tMGL11NPgiNEoHE8l1rOnN3KSDfTlzZ+
        CnESB79E8EPNF5Bw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7AF1213873;
        Fri, 25 Mar 2022 20:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nTn6HbIoPmIHDAAAGKfGzw
        (envelope-from <bp@suse.de>); Fri, 25 Mar 2022 20:40:18 +0000
Date:   Fri, 25 Mar 2022 21:40:13 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RAS updates for 5.18
Message-ID: <Yj4orVIbqcyTQcY7@zn.tnic>
References: <YjtZAvQnshp1pZIh@zn.tnic>
 <CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:01:15PM -0700, Linus Torvalds wrote:
> [ I've written this kind of reply multiple times before and I
> _thought_ we had something in the docs about this, but I can't find
> them, so here goes again ]

Thanks!

I had a faint notion that I had read you telling people that their
diffstat was bogus but I couldn't find anything relevant for the short
time I was searching.

How about I start a maintainers-specific documentation in
Documentation/process/ - we already have maintainer handbooks there -
and put that there?

I'm sure it'll come up again and it'll be easier to point to it next
time...

> On Wed, Mar 23, 2022 at 10:29 AM Borislav Petkov <bp@suse.de> wrote:

<snip detailed explanation - thanks for taking the time!>

> But that fundamentally means that when you have multiple different
> merge bases, and you ask "what changed since the beginning and the
> current state", your question is fundamentally ambiguous. There is not
> a "the beginning". There are *multiple* beginnings.

Aaaha, there it is. I suspected it was something fundamental...

> So what git will do it to pick _one_ beginning, and just use that.
> 
> And that means that yes, the diff will show the changes since that
> beginning, but since the end result depends on the _other_ beginning
> too, it will show the changes that came from that other beginning as
> well.

Right.

...

> No. There is no such thing as a *correct* merge base. You had two, and
> git picked one of them. In the general case there just isn't a correct
> answer.
>
> Now, it turns out that you shouldn't have done a merge at all. I'm not
> sure why that commit c0f6799de2a0 ("Merge tip:locking/core into
> tip:ras/core") even exists, because it could have been done as a
> fast-forward. Did you use "--no-ff" to explicitly not do that?

Well, let me recreate the situation:

$ git checkout -b ras/core v5.17-rc4 
Switched to a new branch 'ras/core'

$ git merge tip/locking/core
Auto-merging MAINTAINERS
Merge made by the 'ort' strategy.
 MAINTAINERS                                          |  1 +
 arch/x86/include/asm/cpumask.h                       | 10 ++++++++++
 arch/x86/include/asm/ptrace.h                        |  2 +-
 include/asm-generic/bitops/instrumented-atomic.h     | 12 ++++++------
 include/asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
 include/linux/atomic/atomic-arch-fallback.h          | 38 +++++++++++++++++++++++++++++++++-----
 include/linux/cpumask.h                              | 18 +++++++++---------
 include/linux/jump_label.h                           | 13 ++++---------
 include/linux/local_lock_internal.h                  |  6 +++---
 init/Kconfig                                         |  1 +
 kernel/locking/lockdep.c                             | 43 +++++++++++++++++++++++++------------------
 kernel/locking/lockdep_internals.h                   |  6 ++++--
 kernel/locking/lockdep_proc.c                        | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 kernel/locking/percpu-rwsem.c                        |  5 +++--
 kernel/locking/rwsem.c                               |  2 +-
 scripts/atomic/fallbacks/read_acquire                | 11 ++++++++++-
 scripts/atomic/fallbacks/set_release                 |  7 ++++++-
 17 files changed, 168 insertions(+), 74 deletions(-)

so that tip/locking/core branch is based on v5.17-rc1 and has locking,
etc stuff which I needed in ras/core. Thus the merge. And git does a
merge commit.

If I try to make it do a --ff, it still does a merge commit:

$ git merge --ff tip/locking/core
Auto-merging MAINTAINERS
Merge made by the 'ort' strategy.
 MAINTAINERS                                          |  1 +
 arch/x86/include/asm/cpumask.h                       | 10 ++++++++++
 arch/x86/include/asm/ptrace.h                        |  2 +-
 include/asm-generic/bitops/instrumented-atomic.h     | 12 ++++++------
 include/asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
 include/linux/atomic/atomic-arch-fallback.h          | 38 +++++++++++++++++++++++++++++++++-----
 include/linux/cpumask.h                              | 18 +++++++++---------
 include/linux/jump_label.h                           | 13 ++++---------
 include/linux/local_lock_internal.h                  |  6 +++---
 init/Kconfig                                         |  1 +
 kernel/locking/lockdep.c                             | 43 +++++++++++++++++++++++++------------------
 kernel/locking/lockdep_internals.h                   |  6 ++++--
 kernel/locking/lockdep_proc.c                        | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 kernel/locking/percpu-rwsem.c                        |  5 +++--
 kernel/locking/rwsem.c                               |  2 +-
 scripts/atomic/fallbacks/read_acquire                | 11 ++++++++++-
 scripts/atomic/fallbacks/set_release                 |  7 ++++++-
 17 files changed, 168 insertions(+), 74 deletions(-)

so I don't see how to do a fast-forward thing here.

> So *because* you have that pointless merge that could just have been a
> fast-forward, you think that "hey, if it had just picked the other
> merge base it would all have been fine". But in a normal merge
> situation, the two merge bases would both have had some work that
> wasn't in the other side, so that's just because you did something
> odd.

Right.

I guess my strategy for the future should be: either make sure branches
have a common merge base or generate a "fake" diffstat.

> So in the general case, you aren't doing anything wrong: if you merge
> multiple real branches, it's just that "git diff" cannot find a single
> unique point to use as the base, and you'll get some odd random diff.

Right.
 
> But if you are a developer who merges multiple real branches, you
> obviously know how to merge things, and one way to sort it out is to
> basically do a test-merge just for yourself:
> 
>     # WWLS? ("What would Linus See?")
>     git branch -b test-merge linus
>     git merge my-branch
>     git diff -C --stat --summary ORIG_HEAD..
>     .. save that away ..
> 
>     # go back to your real work, and remove that test-merge
>     git checkout <normal-branch>
>     git branch -D test-merge
> 
> will generate a diffstat of what a merge (which fundamentally knows
> how to resolve multiple merge bases) would generate.

Yes, as a matter of fact I did that before sending you this email and
the diffstat it issued when doing the "git merge my-branch" into your
tree was the one I was expecting. I guess yeah, that's the way I should
be creating the diffstat when I have this situation in the future. Thx!

> The other alternative is to just send me the bogus diffstat - I'm
> sadly quite used to it, since a number of people just do "git
> request-pull", see that it's odd, don't understand why, and just let
> me sort it out.

Yeah, unlikely. I wanted to know what is going on so you got this email
with a question instead. :-)

> Now the good news is that people who are afraid of merges and the
> above kind of complexity will never actually see this situation. You
> can't get multiple merge bases if you don't do any merges yourself.
> 
> So this kind of git complexity only happens to people who are supposed
> to be able to handle it. You clearly figured out what was going on,
> you didn't perhaps just realize the full story.

Thanks for taking the time and explaining - it was very helpful!

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
