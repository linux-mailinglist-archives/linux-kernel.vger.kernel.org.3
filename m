Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612D454B848
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbiFNSIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiFNSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:08:30 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0835862
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:08:30 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l204so16449984ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I7mIzgHlKoo48q72bBYb3vEBCu9Nvd6MDnUH2Y99HDs=;
        b=rueFW7Hw9BW5aiacWVNeDteqBIXmxnNHCNKISJs/aDl7jnTwrNcJrqHjAEU+ozjnbR
         8uNLg/U3OLLjTUWHjjkfGiKsRwqdtpppCZ6Ygx7DdKK2WqDZNolZOI4s+G40ALixMZaF
         LlpPBxi0MX4Nl1LpyZ0wpOAfq71h8fVtHmNRzdbya/rJX38r4NnJQAtI0rI4086LpAKL
         IlRa0CBNAbJIdlI5v8kIQbF2C5qsJoakcX7uFN3I7SkWdExdKM5jqv2bSwjDB94yoVhG
         QYEBI26fURbxppMXaezdRzq3ocqQJqs7yAlgNYIQKiCTI+O8pKsk848mFEgrQQ2NDvx1
         qYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I7mIzgHlKoo48q72bBYb3vEBCu9Nvd6MDnUH2Y99HDs=;
        b=sTCFmkEM5aiY0ZKnArOivxtHUAQdv6qVoa1K0clFzI9cZJR6YeNbQSR3osuuKSMEQJ
         LkY7PIQ9mmkhyWNbqqi8WdSihCLqezVegq7N/dKxJYRGWDfdcFJ6tB02iVQyyp/71PFL
         UqZg7el4Pk0NpZSrgj4rflk2lTFQtsSpsgrwHhfEEl43L+XjFAo7RHKgNdN6q4nKsceH
         +1c5X3+G6JKzs2o6IMbK7WRKDNEs2ykw/27Q0bcHG0JqUwi/SIeD0CDRZ6HRU487dpeg
         VPGf/nm1kPlltop4m8d8Qgb9I1p23N44L3T7WNiOX66Bpw1rYA+YEd+wnq4JXNLimrrV
         3kYA==
X-Gm-Message-State: AJIora8hdJcNw4pPMuslMv2y3gkaY3Fo4PYSqnR+6LQYypSUnrwp9/Ed
        Yrdb489+fhibfmSJ8uw9Sl3/M7Yibdz8lYk3WwKxKg==
X-Google-Smtp-Source: AGRyM1v4Pm0uKutjGFFGG8hxEK6A2MV95t6qGASMp568gSd6ZZcLQLhn3uiQz7zYDJnZy348rz4aUrhLiQObaBcCuI4=
X-Received: by 2002:a25:e68b:0:b0:65c:7aa5:f901 with SMTP id
 d133-20020a25e68b000000b0065c7aa5f901mr6203492ybh.147.1655230108954; Tue, 14
 Jun 2022 11:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
In-Reply-To: <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Jun 2022 20:07:52 +0200
Message-ID: <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Evgenii Stepanov <eugenis@google.com>,
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

On Tue, Jun 14, 2022 at 6:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 14, 2022 at 7:49 AM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > The bigger question I want to raise here is whether we want to
> > discourage passing uninitialized variables to functions in the kernel
> > altogether.
>
> I'm assuming you mean pass by reference.

No, sorry for being unclear. I mean passing by value.
In the given example the prototype of step_into looks as follows (see
https://elixir.bootlin.com/linux/latest/source/fs/namei.c#L1846):

  static const char *step_into(struct nameidata *nd, int flags, struct
dentry *dentry, struct inode *inode, unsigned seq);

, and the local variables `struct inode *inode` and `unsigned seq` are
being passed to it by value, i.e. in certain cases the struct inode
pointer and the unsigned seq are uninitialized.

Does that change anything?

> Some functions are really fundamentally about initializing things, and
> expect uninitialized allocations.

Agreed, there are a lot of functions around that initialize one struct
or another, they are out of the scope.


> What I think might be a good model is to be able to mark such
> arguments as "must be initialized by callee".

This sounds interesting. In the given example I would suggest that the
call to lookup_fast()
(https://elixir.bootlin.com/linux/latest/source/fs/namei.c#L2016)
should be initializing &inode and &seq, so that it is guaranteed that
they are passed initialized into step_into().


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
