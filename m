Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB30C538125
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiE3OIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 10:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiE3ODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 10:03:15 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDE38AE42;
        Mon, 30 May 2022 06:40:03 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a10so11336654ioe.9;
        Mon, 30 May 2022 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIwe3AKRbCHeJRE3dPTatS7K/6ILlXUNL6T/HNDhAhU=;
        b=cSzwr5INM0XMJMTjfBIFqC6i5S58eV8gcJa/64rR0gDugFmRTU5nQgL16eOHpgeMFI
         7AfIC/ykpu26A1o3tWj6uRAXJg8F8QVvcvAIxqOgTwk//2oTGuNDuWVqcGupsqpPcM6T
         ZRAJqMTcOk2f0Pg5Sqy8051E3rZJH3I33bcAioIyj1QEd+htYi69FlxTGKOOn4GcVjjE
         pEirF1LZJZUjhxfS+0GnGmUhc97QLgfasJMGHXk9cu2E+2pU6QcPUuPNv5BRpstZpwXX
         9NoZsAOpE0EVU3IryTlU5mkC2xM3qI4IbFyk9WdwRkwSVZe45lL2Nx+m0vwWNHCFkswg
         kaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIwe3AKRbCHeJRE3dPTatS7K/6ILlXUNL6T/HNDhAhU=;
        b=WYIg8OMmIYkzVHmC+9kzLY0xjObj+mPLMJOyPZo7f6F2D+rSiF26LroGFrj0aHIDRM
         3xqEUoAn2mZwwVIb+OsePeFu6juFTmIqZ5cGYYYDThvISPG9kMq/8kt/XOTdu/drFDEt
         WUc7jE3K7vZnz5318hodlrm/21zXVNsVSI2Xgihpa2KfyG7fpPIqpzTI6e0lH/uZwgzn
         N2zeYyq23YkmpiUCYbKBrNhTo3s8i2EsaqZMQUPQCpTWvUIYy5p0I54k8zJQ/KksqUdJ
         Q/FhXlPzfXtHXrOBbFilWeQGmlhrgd7bJj4bGOZoUvXiCyUnBpzzNxqAu+MDJpTAEv+2
         vbbg==
X-Gm-Message-State: AOAM532ZeyYkIg9otTEM8kG6LCrIzWL0+5bqv8lEB9/9DIYcCOkgnPWB
        /cArgZe4U9pLQ4YqomFuml3pC+F88nM6PCB+No0=
X-Google-Smtp-Source: ABdhPJynB3luYlUIXTTDca8c2gxMygZVtlz0csg40D16eodRT8Q+xqzjGbylbRXxbzD+mvxPI5WGRexbTj0PrTzr1DM=
X-Received: by 2002:a05:6638:f89:b0:32e:89f4:e150 with SMTP id
 h9-20020a0566380f8900b0032e89f4e150mr27799661jal.308.1653918002647; Mon, 30
 May 2022 06:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-22-ojeda@kernel.org>
 <CAKwvOdn+9qORm8UpDGnPXxiK7B7P_TW5CtXv1+8qkv7UvQr3hQ@mail.gmail.com>
In-Reply-To: <CAKwvOdn+9qORm8UpDGnPXxiK7B7P_TW5CtXv1+8qkv7UvQr3hQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 30 May 2022 15:39:51 +0200
Message-ID: <CANiq72n2bU3LSGu-4v66nif_95EVq--z2X_F2V7JBPU8v=h8EA@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>,
        David Gow <davidgow@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:25 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Is there a reason to not just turn clippy on always? Might be nicer to
> start off with good practices by default. :^)

The idea crossed my mind too [1], but sadly Clippy disables some
optimizations and in general is not intended to be used for normal
compilation [2].

[1] https://github.com/rust-lang/rust-clippy/issues/8035
[2] https://github.com/rust-lang/rust-clippy/pull/8037

> Are there *.rmeta directories that we _don't_ want to remove via `make
> mrproper`? I'm curious why *.rmeta isn't just part of MRPROPER_FILES?

Putting them in `MRPROPER_FILES` would mean only those in a given
directory are removed (e.g. the root one), but the idea here is to
find them anywhere in the tree, since in the future we may have
library crates in different parts of the tree.

However, I am not sure I understand your first question in relation
with the second one -- if we put them in `MRPROPER_FILES`, that would
remove less, not more.

> I don't think we need to repeat dir/* here again for rust. The
> existing targets listed above (outside this hunk) make sense in both
> contexts.

The idea here is to document the differences (e.g. `RUSTFMT`) and that
we may have other targets in the future that do not apply to C (e.g.
MIR dump, if that happens to be useful).

But maybe I can fit that in the normal place and make it still look
good... I will give it a try.

> Does rustc really use .i as a conventional suffix for macro expanded
> sources? (The C compiler might use the -x flag to override the guess

It is not a conventional suffix at all as far as I am aware.

Maybe we should use a different one to aid editors and users anyway,
e.g. `.rsi`, similar to `.mi` for Objective-C `.m` files.

> it would make based on the file extension; I'm curious if rustc can
> ingest .i files or will it warn?)

The macro expanded output is not intended to be used as a compilable
input, but as a debugging aid only. I can note this there.

Having said that, `rustc` accepts the "preprocessed" output in the
sense that it will just treat them as normal source files (no flag
needed, and e.g. both `.i` and `.rsi` work); however, it may give new
diagnostics or may require extra flags to enable some compiler
features.

From a quick test, I managed to compile a "preprocessed" Rust kernel
module with only command-line changes. But if we really wanted to
support this, we would need to ask upstream Rust to actually support
it.

> Are these two kconfigs used anywhere?

Not for the moment, but it could still be useful when getting
`.config` reports (and we could add it to `LINUX_COMPILER` etc. in the
future).

> How does enabling or disabling debug info work for rustc? I may have
> missed it, but I was surprised to see no additional flags getting
> passed to rustc based on CONFIG_DEBUG info.

`-Cdebuginfo=` is the one; by default there is no debug info and that
option enables it (i.e. it is not just the level but the enablement
too).

(Note that in userspace, when compiling a common program, you will get
some debug info coming from the standard library and other
dependencies).

> Ah, that explains the host rust build infra.  Bravo! Hard coding the
> target files was my major concern last I looked at the series. I'm
> very happy to see it be generated properly from .config!
>
> I haven't actually reviewed this yet, but it makes me significantly
> more confident in the series to see this approach added. Good job
> whoever wrote this.

Thanks! I thought Rust would be a nice option for writing hostprogs,
though of course for the moment only programs that can assume Rust is
there may use it.

Note that non-x86 specific options need to be handled properly still
(e.g. move things between the arch Makefiles and the hostprog as
needed).

I would still want to see compilers come to some kind of common format
for this as we discussed other times, but... :)

> Does `$(READELF) -p .comment foo.o` print anything about which
> compiler was used? That seems less brittle IMO.

Currently, `rustc` does not add a `.comment` section; but we could
ask, I sent [3].

If debug info is enabled, another way is using the `DW_AT_language`
attribute, like `pahole` will be doing for a new option we need [4].
However, we would still need a way for the other case.

In any case, I am not sure something like `.comment` is less or more
brittle -- compilers could in theory change it (e.g. not emitting it),
while adding a symbol is something we control. So different kinds of
brittleness.

[3] https://github.com/rust-lang/rust/pull/97550
[4] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4

Cheers,
Miguel
