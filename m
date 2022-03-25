Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68BA4E7B56
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiCYUG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiCYUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:06:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FA5A0B4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:01:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c15so11649294ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcHqVe2+IHnorpWv/RzZ1aBzI2zJZGTZYxnX1y+9NnA=;
        b=fZBmckr6rrO0L3y5qLMOS6HuCQt2NCvfhJkDIMKmEAAKyd7dzRLJwdbcYdnpCcEZZH
         TZdFfoGUrrIUG5H72M7ch7cB6Vv6OQ2YQAVnuJoXtuwuqDYrUcObMwgO2MDuXbxJXfDa
         trasIfB4GNj0OKTEl6whNvsRnr9Qiiq0nCp3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcHqVe2+IHnorpWv/RzZ1aBzI2zJZGTZYxnX1y+9NnA=;
        b=Y8h/E6yWTZmET85ka1TV7p1GDELlZvZGsaN90ZmLB/LOsYjiqEILGlbJj4dXRPSrQt
         vGZ1Tq99hlfER4yswo0g033sLKJ+Ld9AaC1BjwFXC196ILKq80uf0DECVgcS/ZNGP5Av
         nytFQz2qICMjUYNJdyx9lxs4PrQgri5h0qMeUyzHycvLM3GvnaFBvf/5u6Iw8jqLDwBo
         49gkJ7iGn4N/F8+F98LMwRm8HRnOcc+KSkKiFPErMonk/Dkhk+zSTs8px2AhkNx3gh7+
         n3q+poP2E9Yc8d99t7lxXo/DksweG33E9lhmRPHO7xW6RAm+3vo3wKOzjvZCSg2wfA/o
         5EmA==
X-Gm-Message-State: AOAM531q8ONrry18OrYhT8mrVeWTUrF8jbWM9GBd/a8FLWL+Jfuiw/Gm
        g//Wem9hNP9DgxkdDkXmuBHhfgBzbfXB6ID8Ilc=
X-Google-Smtp-Source: ABdhPJz/mivgKUYSYtZ/IFZYTMmtn0KKeoTzgOVz5ZYh5rJh+cfgMwWZwGeWMjkhEB1BSYQhYQw3hg==
X-Received: by 2002:a2e:6e17:0:b0:249:8c9c:5aef with SMTP id j23-20020a2e6e17000000b002498c9c5aefmr9493132ljc.70.1648238493138;
        Fri, 25 Mar 2022 13:01:33 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g12-20020a05651222cc00b0044a1065ca5fsm806069lfu.304.2022.03.25.13.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 13:01:31 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 17so11653828ljw.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:01:31 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr9704388lja.443.1648238491225; Fri, 25
 Mar 2022 13:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <YjtZAvQnshp1pZIh@zn.tnic>
In-Reply-To: <YjtZAvQnshp1pZIh@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 13:01:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com>
Message-ID: <CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com>
Subject: Re: [GIT PULL] RAS updates for 5.18
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
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

[ I've written this kind of reply multiple times before and I
_thought_ we had something in the docs about this, but I can't find
them, so here goes again ]

On Wed, Mar 23, 2022 at 10:29 AM Borislav Petkov <bp@suse.de> wrote:
>
> But before you do, a git question if I may:
> [.. details removed for brevity..]
> However, when creating the diffstat for the pull request, it would
> add additional files to it from tip/locking/core even if all the
> tip/locking/core changes are already in your master branch:

So what you are describing is a very fundamental thing - your branch
has multiple separate starting points, since you had different
branches that you merged into your tree..

Sometimes having multiple branches doesn't actually cause that,
because the different branches may all have the same base starting
point.

Git calls these things "merge bases", because those starting points is
what you have to take into account when merging, they are the "base"
for actually resolving the differences that come in through multiple
branches.

And git handles that perfectly fine when merging by doing all the
appropriate magic. And "git log" has no problem with it either - you
can list all the commits that are in your head but are *not* in some
arbitrary number of merge bases just fine).

But when you do a "git diff", things are different (and "git
request-pull" basically just does a diff to show what the thing was
about).

A "diff" is fundamentally something you do on two end-points. You have
a beginning, you have an end, and you ask "what changed between these
two end-points".

But that fundamentally means that when you have multiple different
merge bases, and you ask "what changed since the beginning and the
current state", your question is fundamentally ambiguous. There is not
a "the beginning". There are *multiple* beginnings.

So what git will do it to pick _one_ beginning, and just use that.

And that means that yes, the diff will show the changes since that
beginning, but since the end result depends on the _other_ beginning
too, it will show the changes that came from that other beginning as
well.

Sometimes those changes end up being empty, because the "first
beginning" might already have had all of that. So sometimes you might
not even notice that what "git diff" gave you was ambiguous.

So "git request-pull" does both a log (for the shortlog of commits)
and a diff (for the diffstat), and the log should always be correct,
but the diffstat will have this ambiguity problem if you have multiple
merge bases.

> After poking at it a bit more, I found a hint as to what it might be
> complaining about:
>
> $ git diff --stat master...ras_core_for_v5.18_rc1
> warning: master...ras_core_for_v5.18_rc1: multiple merge bases, using 754e0b0e35608ed5206d6a67a791563c631cec07

Yeah, so using that "..." format will warn about how there are
multiple possible merge bases, and point out how it just picked one at
random.

> So it looks like the diffstat for the pull request is created by using
> the -rc4 as the merge base:
>
> $ git diff --stat v5.17-rc4..ras_core_for_v5.18_rc1
> ...
>
> while the correct diffstat should be from the merge-commit onwards:

No. There is no such thing as a *correct* merge base. You had two, and
git picked one of them. In the general case there just isn't a correct
answer.

Now, it turns out that you shouldn't have done a merge at all. I'm not
sure why that commit c0f6799de2a0 ("Merge tip:locking/core into
tip:ras/core") even exists, because it could have been done as a
fast-forward. Did you use "--no-ff" to explicitly not do that?

So *because* you have that pointless merge that could just have been a
fast-forward, you think that "hey, if it had just picked the other
merge base it would all have been fine". But in a normal merge
situation, the two merge bases would both have had some work that
wasn't in the other side, so that's just because you did something
odd.

> So, long story short, what am I doing wrong?

So in the general case, you aren't doing anything wrong: if you merge
multiple real branches, it's just that "git diff" cannot find a single
unique point to use as the base, and you'll get some odd random diff.

But if you are a developer who merges multiple real branches, you
obviously know how to merge things, and one way to sort it out is to
basically do a test-merge just for yourself:

    # WWLS? ("What would Linus See?")
    git branch -b test-merge linus
    git merge my-branch
    git diff -C --stat --summary ORIG_HEAD..
    .. save that away ..

    # go back to your real work, and remove that test-merge
    git checkout <normal-branch>
    git branch -D test-merge

will generate a diffstat of what a merge (which fundamentally knows
how to resolve multiple merge bases) would generate.

(Obviously you can just do the above in a completely separate git tree
too, if you don't like doing those temporary branches that might mess
up your working tree).

The other alternative is to just send me the bogus diffstat - I'm
sadly quite used to it, since a number of people just do "git
request-pull", see that it's odd, don't understand why, and just let
me sort it out.

Now the good news is that people who are afraid of merges and the
above kind of complexity will never actually see this situation. You
can't get multiple merge bases if you don't do any merges yourself.

So this kind of git complexity only happens to people who are supposed
to be able to handle it. You clearly figured out what was going on,
you didn't perhaps just realize the full story.



                  Linus
