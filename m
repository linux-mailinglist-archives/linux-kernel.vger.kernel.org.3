Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6F46DEB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhLHWz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhLHWz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:55:57 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9833C061746;
        Wed,  8 Dec 2021 14:52:24 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p65so4613587iof.3;
        Wed, 08 Dec 2021 14:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGrqkR/C9an0vJ81QFVP7yrSB4MKsuP1Qtuq0+7PDTs=;
        b=qtCkg3AEHt9KZvFv27AxZOPDhiyQTEalWwlECrnoY3J42vrvN+KOD9kOJoZjG9OSSl
         AQtGufR39Vsm6oVTBRMmIE7Hb5DoqAsiQN2duIaEi6ZOkafN1qLWO1TPYSkqjQKBvWRr
         MEneMfKPU1BlcD7nYcylWSG/zbzhbyrroOTPej1mMkdUIXCQGPF9l0EBNgc7slOiAbU/
         11OeLFPxnzmhxRqUlEMdV44f16mCamPogP8fN4OuMrIUpBAwg8IIRkBnrCM2jV/Vy3A1
         AtzlbDKnCgZgUzC/TNua+aiJvXNWOEl3XtOU8kj01YXMUFOBVw4vU/0FXhw0HkIWQlax
         SiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGrqkR/C9an0vJ81QFVP7yrSB4MKsuP1Qtuq0+7PDTs=;
        b=KByB4qO2inUQk7AqIzU8cnt2OdD3wZKLsE26zBr6++5GHGfGKkkPiOwZr13CI0tkA7
         rOkul6sdEnoNAun6u2VkSBrz0DI+bwRFl4hb/OJ55W+NZO3MgVIgdMaPi6wqOYxZPoeP
         uV7cw2yi03CCPZzc+Z7TWEn0nKkvFudxis6/SirjzgmvOMyJxKfDQat4E/XwQxvIrwUO
         oTTdeaQyN7j86P1syiexchCnH6r67/RJTSNybKpQ6eujUNUSSmkaP1FKuni/NznRKmjB
         DqYwKOy0ao2tGqSeDKxg9TGHlCYaucASpBf+mcfdCxQGAN9DzB4chHF2dVLU+vxvRlkR
         EM/Q==
X-Gm-Message-State: AOAM533GaUs4axqyW5EMCTb+MgZIn+tQqjAYow0LPMulNlUowP3BgHJY
        6Z23IgPtys+WiDS7l+C8j95f9SWv34zI3QYsuQg=
X-Google-Smtp-Source: ABdhPJyavX5M+GuCfLeHUrBbhwLQLTulvc+eZRg9a6Kyv4WBQ4kLn+WrBRryfp3O9RSjBPTxnNQpJm0O4YiIpmt1OcE=
X-Received: by 2002:a05:6638:19a:: with SMTP id a26mr3884482jaq.133.1639003943906;
 Wed, 08 Dec 2021 14:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-16-ojeda@kernel.org>
 <CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 8 Dec 2021 23:52:13 +0100
Message-ID: <CANiq72mYmzwADwJFbOpAPh5YF59RxP-ZoHm-DD=uVdj+yKB_Kw@mail.gmail.com>
Subject: Re: [PATCH 15/19] Kbuild: add Rust support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

Hi Nick,

On Tue, Dec 7, 2021 at 11:45 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Can we update some Kconfig checks to fix that?

Yes, I can definitely add that.

> Consider putting clippy specific flags in their own variable, and/or
> just adding them to KBUILD_RUSTFLAGS only when clippy is actually
> being used.

This was actually the original approach, but I simplified it -- there
is no need to put them on their own.

Unless, of course, what you want is shorter verbose output -- is this
what you are referring to?

> ... here. Should we sink the check for origin CLIPPY? Can we also
> match how we check for LLVM=1 rather than checking the variables
> origin?  Especially since KBUILD_CLIPPY isn't exported, it seems it's
> not used outside of this file, IIUC?

I am mimicking what we do for the checkers etc., since that is the
closest to Clippy.

> Is this used in a different patch in the series? ^

`RUSTC_BOOTSTRAP` is used to be able to use stable releases of the
compiler with unstable features (it should go away, eventually).

> If z and s are distinct opt levels, then rustc should really be using
> s rather than z.  IME, z has created larger images than s due to LLVM
> aggressively emitting libcalls, regardless of the cost of call setup.
> See also commit a75bb4eb9e56 ("Revert "kbuild: use -Oz instead of -Os
> when using clang")

Sounds good. In any case, I will check with upstream Rust if they are
used (or planned to be used) for any optimization purposes even before
LLVM is reached.

> oh boy. I wonder which configs change the above values? ;) Can rustc
> still override these via command line flags?

No, it cannot. This is actually a topic I brought up at LPC. Ideally,
we would get `rustc` to support similar command line flags as GCC and
Clang do to customize the targets.

The good news are that it seems upstream may be open to accept flags
to customize targets. They may use it as a way to stabilize parts of
the custom target spec piece by piece, instead of stabilizing the
custom target spec files.

We also raised the issue at the Rust CTCFT meeting a couple of weeks ago.

> So this is like turning on -fsanitize=signed-integer-overflow and
> -fsanitize=unsigned-integer-overflow by default?

Not exactly -- in the Rust case, it is a (Rust) panic. So it would be
closer to `-fno-sanitize-recover`.

> A rust panic or a kernel panic?

The former -- which currently means `BUG()`. However, there could
perhaps be other alternatives. There was a bit of discussion about
this around Kangrejos time but nothing conclusive.

> This should really be the only option here. I still don't see the
> point of allowing wacky combinations of configs where we differ from C
> code.  The more combinations will just frustrate randconfig builds.

I don't have a strong opinion -- but I have not heard from others either...

Regarding `randconfig`, we could restrict it, no?

> Seeing repeated filter-out rules makes me wonder if we could DRY up
> some of these rules with function definitions?

Yeah, there are also some factoring out that I could do. I grew the
file over time and while I am using target-specific variables to
generalize a bit too, it can still be taken further.

I have some other changes planned to the build process, so I will
probably take the chance to clean up a bit as well.

> Are there links to corresponding feature requests upstream so that one
> day we can drop technical debt here?  In particular, having to create
> a custom sysroot as is done here isn't particularly pretty.
>
> I'd be curious if we could remove the dependency on cargo for rust tests.

Yes, we have brought this up to upstream, for instance in the Rust
CTCFT meeting: https://rust-lang.github.io/ctcft/meetings/2021-11-22.html

In general, I track all feature requests etc. in this "live" issue
(see also the linked ones from there):
https://github.com/Rust-for-Linux/linux/issues/2

> Do we denote the conflict in KCONFIG?

No, but yeah, we could. However, I am not sure if we want to denote
them for something so experimental, though (another question is
whether we warn the user about GCC+Rust builds in general).

Or, if we are going to be serious about GCC already (i.e. before we
have actual codegen through GCC for Rust), then I would say we need a
better solution to the problem (like the "check-if-correct" approach
you suggested a while ago, or a proper GCC backend for `bindgen`).

> Why do we need to strip out all these warning flags when running
> bindgen?  Should be just be using -w to silence all warnings from
> clang when invoking bindgen?

Hmm... is there any possibility that we silence something that we care
actually about? I guess we would get the same diagnostics in normal
Clang/LLVM builds, so maybe it is fine. And even if not, perhaps we
should just simplify anyway, given it is GCC+Rust builds we are
talking about.

> I don't understand why the PowerPC specific flags are pulled out, but
> the x86 specific ones (like most of the -m flags in the initial
> defiition of bindgen_skip_c_flags) are not.

No particular reason. When the list of archs started to grow, I
decided it would be better to start splitting them out. I will clean
that out.

> This doesn't accidentally export non-GPL symbols as GPL does it?

It does, but that is fine -- it is the other way around the one that
would "open" the kernel unexpectedly.

Thanks a lot for the throughout review!

Cheers,
Miguel
