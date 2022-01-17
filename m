Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552A84900E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiAQEpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiAQEpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:45:38 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C8C061574;
        Sun, 16 Jan 2022 20:45:38 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d3so13787322ilr.10;
        Sun, 16 Jan 2022 20:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXJNU8A/vrNI4Y+ivgE9K8Fmf8JFY+TijAbHrzk15XA=;
        b=PzG00sgeoimoo1zcwhcGVtlDlW3/+n1GDlK7V+RyNpRuHCMClBHy0YdteLUK1u/Qd+
         uR+lG457kbxkO4LTBEt5Rq1APHSKpT1xSp19GmSjJLUoMgT3D2W6v2jumaYJ0UzEXJ3T
         vFd3zTLgbvSFjcZ4pgjzM6dNI9V/05BQyBlzCapxqKrFtRvM7n1YQfXgsOZAhwJRDHWF
         nP9DK/6G6XuhF4if4s7BccDxwgNNE5zF4I1MYlNfoG6eNLlmEPpichojwoYsCQNUgImM
         YSRM+511RAMm3djS5h4cOb0gN3TBDJz3LvPHI0s1W2n0iWRO/1TRD1/pe7kpP7CCKs72
         JUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXJNU8A/vrNI4Y+ivgE9K8Fmf8JFY+TijAbHrzk15XA=;
        b=HiaZXqH2QUEUFSJxbd/95TgJ4LKK7caktx5swsbBZKaZ7uxrnj27Q3DcbuR9vumJV2
         r7IzZrLaoGgu380HfWEMMfxQd5sQD3OUzuEq3uAMuhqR1xsczvywpE5QGN/IwlsqOtAz
         z3Pm71NlifALfRJDVs8naGXEHRP91fNp8y48NLpyI0vzOQ7/Z2uDBUPD+VJyR5pl19cl
         dpkqpwWRUIf+au0wCX6+r2an2krGRqKd3CPllPTSRrJPKaSlBK98I/AIZqVUxgLaIoMi
         RtvQ4QFTYCOFrh3EZtapsjV6QYJPxR9gUZ1q1Fxgx3VFPVzzoJmQ/R0KD05jckEXcPPT
         p2Eg==
X-Gm-Message-State: AOAM532ilXJZuyWuv4UsLb2s1nt8GYU+bm10sjDaUpvFjwl2mDCCPOo4
        TUyc3O1JoHQ7pl9IaGrkS69J0R9RzzDPRRXcTvXwcuwg
X-Google-Smtp-Source: ABdhPJxRhKFpEsFdyKcte+Zsj7MrW5IXWNB4xcrRU37urSdE65MYsL2fH1bp9UCr9Pbs6bP+ay49DBuxJszsX8sSj9k=
X-Received: by 2002:a05:6e02:1a41:: with SMTP id u1mr1776348ilv.151.1642394737646;
 Sun, 16 Jan 2022 20:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-16-ojeda@kernel.org>
 <CAK7LNAS+eiL-kcdnNyyCUNWjV5qGxrw4PM-oJFfw=o1fbhc2qw@mail.gmail.com>
In-Reply-To: <CAK7LNAS+eiL-kcdnNyyCUNWjV5qGxrw4PM-oJFfw=o1fbhc2qw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 17 Jan 2022 05:45:26 +0100
Message-ID: <CANiq72n4aM6RG+mcGyG-U_fahRw4H9XLUyp4_Jayf1-uq=qY_g@mail.gmail.com>
Subject: Re: [PATCH 15/19] Kbuild: add Rust support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, Dec 11, 2021 at 4:54 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Do you really want to support CLIPPY=1
> in addition to KBUILD_CLIPPY=1 ?
>
> (Refer to C=  V=  M=  O=, which checks $(origin ) )

I implemented both because I saw the pattern used for `V=`, `W=` etc.,
and I thought I should follow it too. If I understand correctly, the
split between `KBUILD_*` and the shorthands is there to avoid
conflicts if the caller had set very short environment variables for
some reason -- is this correct?

If you prefer only one, I think writing `KBUILD_CLIPPY=1` would be too
long for command line usage; so I would prefer `CLIPPY=1` in that
case.

> Is there any reason why
> you did not write like
>
>   core-$(CONFIG_RUST)  += rust/
>
> ?

I have moved it inside the `rust/Makefile` -- please take a look at
the next round I am sending in a bit.

> extra-y does nothing for 'make modules'.
> Is this your expected behavior?
>
> (commit d0e628cd817f3)

Thanks for the reference! Changed to `always-y`. Indeed, this is
needed in `make modules` because we need to trigger the compilation of
`core.o` etc. for the `.rmeta` files.

> Why is .SECONDEXPANSION: needed ?

It was needed at some point for the prototype more than a year ago;
however, it isn't the case anymore, so I have removed it. I have also
made those variables simply expanded ones.

Cheers,
Miguel
