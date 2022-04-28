Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF935127E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiD1ADx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbiD1ADt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:03:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20897DAB8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:00:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g19so5827665lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVJapQpQ5E9fCd/8+tW7JYOKU2HdcGDq0gA7B9hFSRA=;
        b=SYq6Z5uHlCh0AR0o8aSWpGo+VVT8rVnt1AIJxBaVSZrb+W3FbwiioPwqo/+2BXuwcs
         svy1XXaEfGZacXJHICmwVBDBGbqCxHQnQ47fPborxvGIRWvs8wsh/tLoG+/GdVlWe7FW
         tEekfuwhxFJZfeghS0ot/yxZX6MI45eVvv7gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVJapQpQ5E9fCd/8+tW7JYOKU2HdcGDq0gA7B9hFSRA=;
        b=MUao141FTnytfgPYeIMlxIlfwxbv8g/7on809YXgza+xZUKxWmHg3uFCFpETRE5iGa
         hDt1Ha9Mda7p/0vlOLNeNTmv4jYh6M/Ar6n61VrzGDG5RV0B1ydJo+B6bu6ofHKeKVS+
         kToobxiGS0BjTQp/jdFBlcGHRwz3gC8G4Vtls3sGqVZGdTqELDuI+j6Gl6FdqhCYpakL
         D4O/pWFKzL0I6COWxuEw2Csv6RuOQfz8vl1dw9FSnVoXZWlgX6PCkYaMItQPkahsW0XN
         OL4qs9i9LQ3Sy3a+3YEbjW6ioUZHglbw48hz7fev69taxu+k2unSsUIqnsaX7sPW8jAn
         ZTuA==
X-Gm-Message-State: AOAM533bFUsxLi3gfM5Eu+thjL49eM3Fn1dg3IHgcfpQy4v3Kjh1e1u2
        gXRarIrnPVfAyTHGvlbKQ8BfH1lv+YS7xrzB1Sc=
X-Google-Smtp-Source: ABdhPJwivT0YbrjT48jiyOBKTZNd0Rxjdo5/tI1BD6LApun2qBqWdMQ9AzRi95vpJ1ssXkNSzkFh3A==
X-Received: by 2002:a05:6512:3f89:b0:44a:f5bf:ec7e with SMTP id x9-20020a0565123f8900b0044af5bfec7emr22198406lfa.671.1651104034949;
        Wed, 27 Apr 2022 17:00:34 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y21-20020a056512045500b00472053b2dcfsm1285020lfk.48.2022.04.27.17.00.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 17:00:33 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 17so4694369lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:00:33 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr19472567ljh.152.1651104032758; Wed, 27
 Apr 2022 17:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
 <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com> <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
In-Reply-To: <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 17:00:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
Message-ID: <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 3:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I really think
>
>  (a) you are mis-reading the standard by attributing too strong logic
> to paperwork that is English prose and not so exact
>
>  (b) documenting Linux as not doing what you are mis-reading it for is
> only encouraging others to mis-read it too
>
> The whole "arbitrary writes have to be all-or-nothing wrt all other
> system calls" is simply not realistic, and has never been. Not just
> not in Linux, but in *ANY* operating system that POSIX was meant to
> describe.

Side note: a lot of those "atomic" things in that documentation have
come from a history of signal handling atomicity issues, and from all
the issues people had with (a) user-space threading implementations
and (b) emulation layers from non-Unixy environments.

So when they say that things like "rename()" has to be all-or-nothing,
it's to clarify that you can't emulate it as a "link and delete
original" kind of operation (which old UNIX *did* do) and claim to be
POSIX.

Because while the end result of rename() and link()+unlink()might be
similar, people did rely on that whole "use rename as a way to create
an atomic marker in the filesystem" (which is a very traditional UNIX
pattern).

So "rename()" has to be atomic, and the legacy behavior of link+unlink
is not valid in POSIX.

Similarly, you can't implement "pread()" as a "lseek+read+lseek back",
because that doesn't work if somebody else is doing another "pread()"
on the same file descriptor concurrently.

Again, people *did* implement exactly those kinds of implementations
of "pread()", and yes, they were broken for both signals and for
threading.

So there's "atomicity" and then there is "atomicity".

That "all or nothing" can be a very practical thing to describe
*roughly* how it must work on a higher level, or it can be a
theoretical "transactional" thing that works literally like a database
where the operation happens in full and you must not see any
intermediate state.

And no, "write()" and friends have never ever been about some
transactional operation where you can't see how the file grows as it
is being written to. That kind of atomicity has simply never existed,
not even in theory.

So when you see POSIX saying that a "read()" system call is "atomic",
you should *not* see it as a transaction thing, but see it in the
historical context of "people used to do threading libraries in user
space, and since they didn't want a big read() to block all other
threads, they'd split it up into many smaller reads and now another
thread *also* doing 'read()' system calls would see the data it read
being not one contiguous region, but multiple regions where the file
position changed in the middle".

Similarly, a "read()" system call will not be interrupted by a signal
in the middle, where the signal handler would do a "lseek()" or
another "read()", and now the original "read()" data suddenly is
affected.

That's why things like that whole "f_pos is atomic" is a big deal.

Because there literally were threading libraries (and badly emulated
environments) where that *WASN'T* the case, and _that_ is why POSIX
then talks about it.

So think of POSIX not as some hard set of "this is exactly how things
work and we describe every detail".

Instead, treat it a bit like historians treat Herodotus - interpreting
his histories by taking the issues of the time into account.  POSIX is
trying to clarify and document the problems of the time it was
written, and taking other things for granted.

                 Linus
