Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE45973CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbiHQQMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiHQQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:11:26 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D655A8;
        Wed, 17 Aug 2022 09:11:17 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1660752671; x=1661011871;
        bh=D7wmN5qV4emk+fg1faj1v+A7IXjv09X2AsHUIrsCn0k=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=IsDoc4npeWk0r72wVIlqVnw1Z7A9wz2QzGggjZ0LMDtOAWxh+wgWqOxMimKAoNGPA
         yQN4hx+K4ji7Zo2YxqmLF+UAutLDoxVMcJ5EiOksPgBWJNSTfvRP01jcLdgn+U/IHR
         lXnXYbDak+b9zfyGitx64bR07jPvJyYjob9QCO1BPGcMIKqF9J+JjWjsL3zFXa06e8
         N9wayJKKpjGwuTW5ohs6cw9SrMhUNZU/zi/Ag4HZHPPprbH7yJA/VSPu9aTVjB/7Os
         cou5MU5UT4+ZoTjhexXmeuzWC0G1mjkOuHMhvDsrU4XPDLebMxpzFTvKSYtr/3IUaN
         pv0TUeeu7un9Q==
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Miguel Cano <macanroj@gmail.com>,
        Paul Mackerras <paulus@samba.org>, Gary Guo <gary@garyguo.net>,
        Douglas Su <d0u9.su@outlook.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-um@lists.infradead.org,
        Michal Marek <michal.lkml@markovi.net>,
        Daniel Xu <dxu@dxuuu.xyz>, David Gow <davidgow@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        linux-arm-kernel@lists.infradead.org,
        Tiago Lam <tiagolam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Richard Weinberger <richard@nod.at>,
        Finn Behrens <me@kloenk.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linuxppc-dev@lists.ozlabs.org,
        Philip Herron <philip.herron@embecosm.com>,
        Arthur Cohen <arthur.cohen@embecosm.com>
Reply-To: =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v8 27/31] Kbuild: add Rust support
Message-ID: <rYTolA_zKqIX3oCL_i-vlIqKS99s0bYQmRKAdcScDq0mcyxti3imzP7AvJzBpiI6RAuH5RU5BpU4xuEY1Vzq57CuY5v47tO3SuUNAMd7seM=@protonmail.com>
In-Reply-To: <CANiq72nNucEhXAXkXSujnGkpQrkv3-Pcn7ua8N=2XB-suAjs9w@mail.gmail.com>
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-28-ojeda@kernel.org> <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com> <CANiq72nNucEhXAXkXSujnGkpQrkv3-Pcn7ua8N=2XB-suAjs9w@mail.gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 17th, 2022 at 17:13, Miguel Ojeda <miguel.ojeda.sandon=
is@gmail.com> wrote:

> Hi Arnd,
>=20
> On Wed, Aug 17, 2022 at 4:40 PM Arnd Bergmann arnd@arndb.de wrote:
>=20
> > Hi Miguel,
> >=20
> > I tried enabling rust support in the gcc builds I provide at
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/12.=
1.0/
>=20
>=20
> Thanks for giving it a go!
>=20
> > to make this more accessible, but it appears that the command line
> > options here are not portable:
> >=20
> > /home/arnd/cross/x86_64/gcc-12.1.0+rust-nolibc/x86_64-linux/bin/x86_64-=
linux-gccrs
>=20
>=20
> So you mean with GCC Rust, right? (i.e. we have "GCC builds" working,
> via compiling the Rust side with LLVM and linking with the GCC C side,
> but it is not intended for production or to be supported, even if we
> cover it in our CI, test it boots and loads modules etc.).
>=20
> Indeed, `gccrs` does not support `rustc` flags yet. I am not sure if
> the GCC Rust team will eventually provide a driver for those like
> clang does for e.g. `cl` -- I would hope they do, since many projects
> would benefit from it, but maybe they plan to start simply by
> modifying Cargo to call them as they need instead.

There is already a prototype of such a driver. It can be found at https://g=
ithub.com/Rust-GCC/cargo-gccrs. Unlike what the name suggests it is not car=
go specific. It consists of two binaries. The first calls cargo, but tells =
it to use the second binary instead of a real rustc. This second part then =
translates all arguments to what gccrs expects. It is possible to directly =
invoke this second binary. For now it probably won't work for rust-for-linu=
x though as it doesn't have all arguments that are used by rust-for-linux i=
mplemented.

>=20
> If they don't support it, we will have to map the flags on our side --
> it should not be a big problem. However, see below...
>=20
> > I guess nobody has tried this so far. Would you think that fixing this =
is only
> > a matter for fixing the build system to pass the correct flags dependin=
g on the
> > compiler, or is this broken in a more fundamental way?
>=20
>=20
> If you meant GCC Rust, then it is a bit too early for the compiler. As
> far as I now, they are working on compiling the `core` crate and
> supporting more stable language features. They are also researching
> the integration of the borrow checker, though we wouldn't need that
> for "only" compiling the kernel.
>=20
> Now, if they decided to focus on supporting Rust for Linux early on
> (which would be great), they would still need to work on the delta
> between what what they target now and what we use (which includes both
> stable and some unstable features), plus I assume infrastructure bits
> like the platform (target spec) support, the flags / `rustc` driver
> (though I would be happy to do as much as possible on our side to
> help), etc.
>=20
> (We privately talked about possible timelines for all that if they
> were to focus on Rust for Linux etc., but I let them comment or not on
> that... Cc'ing them! :)
>=20
> Cheers,
> Miguel

As alternative to GCC Rust there is also github.com/rust-lang/rustc_codegen=
_gcc/ which uses libgccjit as backend for the official rust compiler rather=
 than writing a full Rust frontend for GCC from scratch. With a bit of patc=
hing to force it to be used, I was able to compile all Rust samples with GC=
C using rustc_codegen_gcc. However it gives warnings of the following kind:

    ld.lld: warning: rust/built-in.a(core.o):(.data.rel.local) is being pla=
ced in '.data.rel.local'

And hangs very early in the boot process. If I enable early logging, it pri=
nts up to "Booting the kernel." and then does nothing. This is probably bec=
ause support for setting a different relocation model is not yet implemente=
d. I opened https://github.com/rust-lang/rustc_codegen_gcc/issues/205 for t=
his.

There may be other issues, but rustc_codegen_gcc is probably going to be th=
e easiest route towards a LLVM free rust-for-linux build. By the way note t=
hat rust-bindgen which we use for generating rust bindings from C headers d=
epends on LLVM. See https://github.com/rust-lang/rust-bindgen/issues/1949.

Cheers,
Bjorn
