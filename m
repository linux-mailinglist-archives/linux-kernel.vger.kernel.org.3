Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442694EA70C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiC2FWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiC2FWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:22:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B9199E2D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:20:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq24so12363926lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXrL0xLSyQXecvNQfhvGNckTeDRtmwC5AuLnoj6aIyk=;
        b=UZIGwhAS05pYmB+VYJpx3L7dlB7t/wp3TC5bIMTmHyCYUxjQ9l3nOazmIDqY72DfsX
         gkX9RTs/KCYKqdAlqm4qERduIWGo/bAtRFjI7/WakEg1Mqid1d9/KOdvMFcSMH01EiLq
         kbGh0iaRKP1JU13btIy6UF3lt/af3yr6y70AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXrL0xLSyQXecvNQfhvGNckTeDRtmwC5AuLnoj6aIyk=;
        b=IcQy01EOASe3WEPwE3Gz/vUwHTZUDnmIr4hHXtjEWQ00Eyb6sXNqj2xEUxtuc4wkpg
         8ph2BF3Wr3IxAS9piE1h0z69LJlu4s7zoQepaDkDG1bo/Ju9V6Oe7z1/th9dzRiJzGe2
         WRYiB+Gvgjg0wSYJwZ+9zAP1rBVqrpAB/IZGOON+w2uz0vebGpuoc+x4mUAJvCJSXbJL
         09aYt3vuCxR2sFzNf6MxU6L4DS55lpE85qQr23GoCbrDqYZkfAHxbHsB1B2gxxSIsclC
         M9C6SLzBYYNNXdKE8wNuXl33Hk9IZwcQ9/HOsnEGy2Dqa8uR4Nno9JemtwAJGNgTNXRa
         zpiA==
X-Gm-Message-State: AOAM532OFyzIFOEK777WiqYPI4pmRnHOPTUX5R34p65ConuQftsxZ1Sa
        XCPf5/zZwvity/zgV80QieXFKueJSudhPxqC
X-Google-Smtp-Source: ABdhPJzl6EEwOLE9w9shTsykXuhNGwAqTSOqAdv3Jh+8iAH/9jqexkt1C1IFaKDeDjEuG3T+XVLlWg==
X-Received: by 2002:a05:6512:2613:b0:448:5164:689d with SMTP id bt19-20020a056512261300b004485164689dmr1012240lfb.526.1648531236860;
        Mon, 28 Mar 2022 22:20:36 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l18-20020a194952000000b00445bf2c3b83sm1857656lfj.58.2022.03.28.22.20.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 22:20:35 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w7so28327125lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:20:35 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr1028168lfj.449.1648531234178; Mon, 28
 Mar 2022 22:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org> <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org> <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
 <87r16lmnsq.fsf@email.froward.int.ebiederm.org> <CAHk-=wiVB8npX4B3D48PjqHjKa8geRjMhcFSgmtYDPp05eZymA@mail.gmail.com>
In-Reply-To: <CAHk-=wiVB8npX4B3D48PjqHjKa8geRjMhcFSgmtYDPp05eZymA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 22:20:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPKKU7zFeg06a05R6abB1tWrHR28z-E5vVvk+2xgXHHA@mail.gmail.com>
Message-ID: <CAHk-=wiPKKU7zFeg06a05R6abB1tWrHR28z-E5vVvk+2xgXHHA@mail.gmail.com>
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 28, 2022 at 9:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So if you have both a branch and a tag named 'xyz', you generally need
> to disambiguate them when you use them. That will make git happy,
> because now it's not ambiguous any more.

On a similar but very different issue: this is not the only kind of
naming ambiguity you can have.

For example, try this insane thing:

    git tag Makefile

that creates a tag called 'Makefile' (pointing to your current HEAD, of course).

Now, guess what happens when you then do

    git log Makefile

that's right - git once again notices that you are doing something ambiguous.

In fact, git will be *so* unhappy about this kind of ambiguity that
(unlike the 'tag vs branch' case) it will not prefer one version of
reality over the other, and simply consider this to be a fatal error,
and say

    fatal: ambiguous argument 'Makefile': both revision and filename
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

and as a result you will hopefully go "Oh, I didn't mean to have that
tag at all" and just remove the bogus tagname.

Because you probably made it by mistake.

But you *can* choose to say

   git log Makefile --

or

   git log refs/tags/Makefile

to make it clear that no, 'Makefile' is not the pathname in the
repository, you really mean the tag 'Makefile'.

Or use

  git log -- Makefile

or

    git log ./Makefile

to say "yeah, I meant the _pathname_ 'Makefile', not the tag".

Or, if you just like playing games, do

    git log Makefile -- Makefile

if you want to track the history of the path 'Makefile' starting at
the tag 'Makefile'.

But don't actually do this for real. There's a reason git notices these things.

Using ambiguous branch names (whether ambiguous with tag-names or with
filenames) is a pain that is not worth it in practice. Git will
notice, and git will allow you to work around it, but it's just a
BadIdea(tm) despite that.

But you probably want to be aware of issues like this if you script
things around git, though.

That "--" form in particular is generally the one you want to use for
scripting, if you want to allow people to do anything they damn well
please. It's the "Give them rope" syntax.

Of course, a much more common reason for "--" for pathname separation,
and one you may already be familiar with, is that you want to see the
history of a pathname that is not *currently* a pathname, but was one
at some point in the past.

So in my current kernel tree, doing

    $ git log arch/nds32/

will actually cause an error, because of "unknown revision or path not
in the working tree".

But if you really want to see the history of that now-deleted
architecture, you do

    $ git log -- arch/nds32/

and it's all good.

This concludes today's sermon on git,

             Linus
