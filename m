Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36D550319
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 07:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiFRF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 01:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiFRF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:58:32 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90544EDD4;
        Fri, 17 Jun 2022 22:58:30 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y17so4239714ilj.11;
        Fri, 17 Jun 2022 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DoXrvmARzpcu70b8xixzSRDkUeRb3CHYW5cwPvaz0gg=;
        b=SxLEpZGrEW0KeSJ94LopSHGMJ8WsaYKF5m7zNWZfbfF1DR6YkCsziWy2VS0pFvxglQ
         /QAkZMfGZyInSCg8e6FS/L+he5TGVgTwB+QX1nWKq2JYI5WVqvAvFiv0oYCLpS06L5Yd
         6l75DEmB+EDeuD2/IVePgX+lP+8zoe9/tBQI82KKZ1pbfEFsqdMtP47MBNR/B7LWkvLg
         vp/TOUe4nqvJ+UACN5tiWGSQnOOczfdlIEY9OHUTg25WE+9s6l9LbfM4ZytT4WOj9qQK
         eo5UOv/0SH3DAB7TcFgpXXXl4HDe2oeVqfsW2trtjNWwRWpLQdNPD5hYCUoQXtkHnJ8Z
         jCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DoXrvmARzpcu70b8xixzSRDkUeRb3CHYW5cwPvaz0gg=;
        b=FGSEQkLQLds0MwYLyI8EiKUGCs8uztIu7n9kC5vdIWoRqIFrnRHpEkeTsn2a6aeONU
         8f118yymV8/op2IO3NUmQMway/BEyRuGa0uhJZb6AN8/Latk8VI7N8ek6pci4NMulOZ6
         uI6KElmkQiF8Mt+0ZsxJqlPehQAP8/ewCrNsw0IR5HLweXupgr4VbuWqK6shBNriImK1
         lc3WK/UNZDANzg0K+yeM3hQuS1BAf3DIcw1v10uUaJPw5K8RXZLG1yZifZW76A5R9c6g
         ySpTJ61k7Qr1f9w+Wexw9GBE4SUHSemfXEd0cySt9zh9hxaQi0MV9T+Use0cR2i8M6B8
         Fe9w==
X-Gm-Message-State: AJIora/m+qX7/Z8ISNnzWrtX2Gd+esrgbv5Hu7tqMqyY/oXCyFj4F4XI
        f93DYTIwzzr6f1rgvO7GAoo78o50WioTcHfsq24=
X-Google-Smtp-Source: AGRyM1sxJuiw21Pj5PT7yT8PySn95IoeqFmyHSMOhzBmabqL2+OTVLzZpIP0MKygupfzSPqdv8juE+/CTwm8Xg9FqCA=
X-Received: by 2002:a05:6e02:f86:b0:2d8:dc34:8694 with SMTP id
 v6-20020a056e020f8600b002d8dc348694mr4171997ilo.245.1655531909882; Fri, 17
 Jun 2022 22:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz> <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
 <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
 <CA+icZUWZKGEQ_VbnRL03SRAicEMi4r4J0dLRgXJgHvRg7DBM7A@mail.gmail.com> <YqzXKaaWRNP9C4b0@dev-arch.thelio-3990X>
In-Reply-To: <YqzXKaaWRNP9C4b0@dev-arch.thelio-3990X>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 18 Jun 2022 07:57:54 +0200
Message-ID: <CA+icZUWa9UBNBiijYCfrVorkKAH11=4KKgRkp-MxCsngWOPTeg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Nathan Chancellor <nathan@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 9:34 PM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> On Fri, Jun 17, 2022 at 07:50:58PM +0200, Sedat Dilek wrote:
> > On Fri, Jun 17, 2022 at 6:32 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Jun 17, 2022 at 3:35 AM Sedat Dilek <sedat.dilek@gmail.com> w=
rote:
> > > >
> > > > On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
> > > > >
> > > > > On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.co=
m> wrote:
> > > > > >
> > > > > > On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wr=
ote:
> > > > > > >
> > > > > > > Until the link-vmlinux.sh split (cf. the commit below), the l=
inker was
> > > > > > > run with jobserver set in MAKEFLAGS. After the split, the com=
mand in
> > > > > > > Makefile.vmlinux_o is not prefixed by "+" anymore, so this in=
formation
> > > > > > > is lost.
> > > > > > >
> > > > > > > Restore it as linkers working in parallel (esp. the LTO ones)=
 make a use
> > > > > > > of it.
> > >
> > > TBH, I agree with Masahiro. I didn't understand this comment "esp. th=
e
> > > LTO ones."  Jiri, can you clarify what you mean here?
> > >
> > > > [ CC Nathan and Sami ]
> > > >
> > > > I re-checked as my build-time takes approx. 15mins more than usual
> > > > with Linux v5.17.
> > > >
> > > > [ Perf - seconds time elapsed ]
> > > > v5.17: approx. 12500
> > > > v5.19: approx. 13500
> > > >
> > > > +1.000 secs =3D +16,67mins
>
> So roughly 7.5% increase if I did my math correctly?
>
> > > Does this patch make a difference?
> > > https://lore.kernel.org/linux-kbuild/20220616195759.3214538-1-samitol=
vanen@google.com/
> > >
> >
> > Running a new build...
>
> I did a quick benchmark with Fedora's clang 14.0.0 and I didn't see an
> increase of that proportion with your configuration (only about 1%,
> which I would expect would be within the noise for new drivers and
> such):
>
> Benchmark 1: 5.17
>   Time (abs =E2=89=A1):        287.744 s               [User: 23497.818 s=
, System: 4444.602 s]
>
> Benchmark 2: 5.19-rc2
>   Time (abs =E2=89=A1):        290.027 s               [User: 24567.290 s=
, System: 4834.458 s]
>
> Summary
>   '5.17' ran
>     1.01 times faster than '5.19-rc2'
>
> Not to say that there is not an issue but it might be more visible with
> slower hardware.
>

@Nick Desaulniers
I applied the patch.
Seen from build-time not really measurable.
Noticed some binary size reduction.

@Nathan Chancellor
Yeah, that I was thinking, too.
This is due to the number of driver (and modules) increased.

And of course the changes to kbuild-system.
It's hard to compare.

Surely, ancient CPU (10 years) plus HDD etc.

-Sedat-
