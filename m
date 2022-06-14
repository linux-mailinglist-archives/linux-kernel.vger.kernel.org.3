Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3854BB64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357755AbiFNUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358051AbiFNUUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:20:32 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C924974
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:20:30 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id t32so16982202ybt.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ARM5wUedhzNDGSfluB0ZEvytB7HNG0S9RsFwKj8ik/4=;
        b=R0EOyLJjH9igU47Vcr2w25NtncFWmtmJHAXhnb5b0Fl8hPd064VuqpVAczfMhuNqaU
         Re1TGwI2OGmuIpYS/O/Qj4ddBfbadAS/NkEvQBJvI1LKzItc1eLemkbgk3m4l+BR1KDF
         cqK7St+LU8i7RLui1/2WC59UMtuIr/0Up/E8LchN8px21vEHGAQTnvHFEIRh8OTnKdhg
         mmepj+YRt2MfvCFpforx3aOdUH8EacRUZZOgXZqcYmljKy83TQdqTyT42RFUKppV97m9
         QFcXzSGKLevq7cZzFakwOxQhB9gJRfQb6u41dE9WccfptM9KTmlfmXaGika2/4QFEM5I
         RfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARM5wUedhzNDGSfluB0ZEvytB7HNG0S9RsFwKj8ik/4=;
        b=yTOp5ENgE62+evPTjyj6Ntx2OL/rShifWd4P1HAETH3Muf0vihbSGWqBUqvnsIrzX2
         NlcPZiOCsUIS5qC2Bl4EPey3G/3zhjvSK97dquFwm0yby0B6w1n0oYVev7QhN/fw1QmH
         SzSfiDeJlAzlWvYMlX6z1tPNImcXT7yjxFehVLPeJP7XBS2xErHIQJ2KYer1eWIslZes
         ml1ebtKWsQY9vxdncqSjiKkxLRBx4T8Atv0MRW25pp6JiM/VZ6UVyt/wBw8pXL10k1Dl
         6BNY9tmxRfhcqxdeCkb/hNHCl64rheDJ5t1XqukY4oULLQbMW1tfrPdd9g/2iinxCBQW
         s61Q==
X-Gm-Message-State: AJIora/lqyiandHoBrp86rUBO+Uj6szOkmtAyFayoEVnC3jvsYwGciVG
        Oibwce1GSWygx2tXxpeoCKYldlLipl+keSOi/yLzig==
X-Google-Smtp-Source: AGRyM1uoRQJDRQly7W6sdIqsVN8kRskDMxbuFyQoYccjKNgjAA0Y9fNvYeFUOy8a41hiwm4lqNGH4ZV2ktE4XENG+Ic=
X-Received: by 2002:a05:6902:1007:b0:665:197a:a3a8 with SMTP id
 w7-20020a056902100700b00665197aa3a8mr6177688ybt.274.1655238028988; Tue, 14
 Jun 2022 13:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com> <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com>
In-Reply-To: <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Jun 2022 22:19:53 +0200
Message-ID: <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com>
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

On Tue, Jun 14, 2022 at 8:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 14, 2022 at 11:08 AM Alexander Potapenko <glider@google.com> =
wrote:
> >
> > On Tue, Jun 14, 2022 at 6:48 PM Linus Torvalds
> > >
> > > I'm assuming you mean pass by reference.
> >
> > No, sorry for being unclear. I mean passing by value.
>
> Pass-by-value most definitely should warn about uninitialized variables.
>
> > In the given example the prototype of step_into looks as follows (see
> > https://elixir.bootlin.com/linux/latest/source/fs/namei.c#L1846):
> >
> >   static const char *step_into(struct nameidata *nd, int flags, struct
> > dentry *dentry, struct inode *inode, unsigned seq);
> >
> > , and the local variables `struct inode *inode` and `unsigned seq` are
> > being passed to it by value, i.e. in certain cases the struct inode
> > pointer and the unsigned seq are uninitialized.
>
> Then those cases should warn. No question about it.

What about the cases where these uninitialized values are never used
in the callee?
step_into() is one of the instances from the kernel, but here is a
distilled example from https://godbolt.org/z/s1oPve6d4:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
char *kmalloc(int size);

char *kmalloc_or_not(int flag, int size, char *p) {
  if (flag)
    return kmalloc(size);
  else
    return p;
}

char global[16];

char *p(int flag) {
  char *c;
  int size;
  if (flag)
    return kmalloc_or_not(1, 4, c);
  else
    return kmalloc_or_not(0, size, global);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In this example `size` is passed into kmalloc_or_not() initialized,
however it is never used, so the code probably has defined behavior.
In this particular case Clang's -Winitialized is able to notice that
`size` is uninitialized, but in more complex cases it cannot.

> I assume the only reason they don't warn right now is that the
> compiler doesn't see that they are uninitialized, possibly due to some
> earlier pass-by-reference use.

That's right, and here is where dynamic analysis comes to the rescue.
So should we let KMSAN catch such cases and consider them bugs^W
smelly code patterns that need to be fixed?

>
>              Linus



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
