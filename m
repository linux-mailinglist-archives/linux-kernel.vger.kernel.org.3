Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE054C382
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbiFOIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244606AbiFOIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:30:57 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1E3701B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:30:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-313a8a8b95aso53748177b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yBrLrrbB7N+dJmN/Zm3Jq2wM5G5mIz03WeoDowy0F+c=;
        b=dhDlTYQSLiKIQdlGoTCb6bey/8VFAgeBXR92Cpgqpx/p0x6EIjheozl59uoXsVIZiQ
         ED4+qGQKJJmefgVxMqB4RN+c6kvA0jZ9M+ZKEKrdNEhLv5ep/mwj551cDQysqHCNrla9
         LfoV/LMYATPCf52uimgjnRbyk9m3FUiPmaON4+fCzNwH3CpE/CEE1K5tb7d5WEPN2J5m
         Qgi8V87ORNFD1c8k84SadUbE7EaI3kS5e3lObMqK5sRUIYMPNmD1oAwrnK3/U141iCFh
         OKMIUiJAMvG2CBZUKUcO8u2MSvBliXG3TNdUEFsAEdbm+Vm3EyofqJaGnQKbZiEXetu4
         GhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yBrLrrbB7N+dJmN/Zm3Jq2wM5G5mIz03WeoDowy0F+c=;
        b=oeaN2TW4LSXbgGJ+GtpVfAm0t1hazGnzO5H3yFEsny4Y8Hyg6f/IsUirgx4mfceyom
         LjNUeb41f0MCTcmgKudVPq88i6iQ/fGvKIKKXutE36W3C9ik1Jzoqo1eozY9Zvd5A3N2
         JHZDh+2xg+XZnXlz5oQgJf835o0vNnm7/3QqRuCOJOwpWrua4UwzS7/0N2FMkLTkb5nB
         tATzRT5kaOidzIyrS1SOfR0w6kBxkEyIx7Cc7WLJSWClNzDIGDSq/jYVhllfebIM3ebS
         5ZfUKKUph2t1beNtkZL6ZBrKAsFa+6FRXT0DQ5hSjvzhv1eFVZwhY2G2upXlkm2iwUN4
         YrSQ==
X-Gm-Message-State: AJIora8Z5zSqo+eFWqgl5VaZO7Bd2KrAtFXHP7mq3gdCwFtqAE+btHqm
        PTth8WK7XFQUhYMQil5Wnqz+tc5ZXpYgD8ja6inRRp4W2vomeQ==
X-Google-Smtp-Source: AGRyM1tMKLl238Lto9ecz9/dxuNSJvC5VIAUdSklLaNmA+R25yiebC9xkOG2Vsb3kIlZnLJOU7IQB7OW9S6A+RRgdpY=
X-Received: by 2002:a81:db53:0:b0:30c:49c0:7f3f with SMTP id
 b19-20020a81db53000000b0030c49c07f3fmr10032711ywn.461.1655281854115; Wed, 15
 Jun 2022 01:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com>
 <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com>
 <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com> <20220614214039.GA25951@gate.crashing.org>
In-Reply-To: <20220614214039.GA25951@gate.crashing.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 15 Jun 2022 10:30:17 +0200
Message-ID: <CAG_fn=UPyoySbzbLQnJkgbfcSkyCD11M=e+W4-T_WoQCXEPFGA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:45 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Tue, Jun 14, 2022 at 10:19:53PM +0200, Alexander Potapenko wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > char *kmalloc(int size);
> >
> > char *kmalloc_or_not(int flag, int size, char *p) {
> >   if (flag)
> >     return kmalloc(size);
> >   else
> >     return p;
> > }
> >
> > char global[16];
> >
> > char *p(int flag) {
> >   char *c;
> >   int size;
> >   if (flag)
> >     return kmalloc_or_not(1, 4, c);
> >   else
> >     return kmalloc_or_not(0, size, global);
> > }
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Since C11, lvalue conversion of an automatic variable that does not have
> its address taken is explicitly undefined behaviour (6.3.2.1/2).  So in
> function "p", both where "c" and where "size" are passed causes UB (so
> that executing "p" always causes UB btw).

Thanks for this reference to the standard. I've received another one
off-list, which lets the variables be address-taken:

6.2.4/6: "If an initialization is specified for the object, it is
performed each time the declaration or compound literal is reached in
the execution of the block; otherwise, the value becomes indeterminate
each time the declaration is reached."
3.19.2/1: "indeterminate value: either an unspecified value or a trap
representation"
6.2.6.1/5: "Certain object representations need not represent a value
of the object type. If the stored value of an object has such a
representation and is read by an lvalue expression that does not have
character type, the behavior is undefined. If such a representation is
produced by a side effect that modifies all or any part of the object
by an lvalue expression that does not have character type, the
behavior is undefined. [Footnote: Thus, an automatic variable can be
initialized to a trap representation without causing undefined
behavior, but the value of the variable cannot be used until a proper
value is stored in it.] Such a representation is called a trap
representation."


> > In this example `size` is passed into kmalloc_or_not() initialized,
> > however it is never used, so the code probably has defined behavior.
>
> No such luck: the passing itself already causes UB.

Looks like I've been missing this fact all the time.

> GCC does not warn, it has already optimised the code to what you expect
> by the time this warning is done.  If you use -fno-inline it does warn
> for both "c" and "size" (via -Wmaybe-uninitialized).
>
> But it is still UB!  All bets are off, no compiler can do any correct
> translation of your program, since there *is none*.

Then it makes sense for us to report non-trivial cases where
uninitialized values are actually passed to functions.
As Evgenii mentions, trivial inlinable cases are optimized away before
KMSAN instrumentation kicks in, so we won't be reporting them.

>
> Segher



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
