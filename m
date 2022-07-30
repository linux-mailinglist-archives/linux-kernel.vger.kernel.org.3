Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3B5859F3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiG3Jvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiG3Jv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:51:29 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523B24087
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659174683;
        bh=X1Bynk6uEuJ3L6QjykJAmTYr2JvUJ2YfeDQUsR/f9A8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E7EuQVarfw0a3H3VjlTPDLvijQYLEBQjQIRrej5ZH5fZbKkHUxMT5vCyOxfqV/sRE
         NezmDbA5ix73r58c/J1Kw0idmfInJc7agQnn1sMMkla5F9ShLEr9X29gkmO58gJ7ww
         sS3CeHSQVzj2it8E+4H3G8fK2f03seScHE/vbQY8=
Received: from [IPv6:2408:8427:b680:637:4856:75e9:a9b9:2f28] (unknown [IPv6:2408:8427:b680:637:4856:75e9:a9b9:2f28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 4235E667AC;
        Sat, 30 Jul 2022 05:51:17 -0400 (EDT)
Message-ID: <5233653cceab9c2baf6510bd712cd53ef63e3aac.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Lulu Cheng <chenglulu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Sat, 30 Jul 2022 17:51:12 +0800
In-Reply-To: <674cb3e9-d820-016b-a210-afd37ed6e25e@loongson.cn>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
         <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
         <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
         <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
         <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
         <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
         <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
         <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
         <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
         <CAAhV-H7WxRp4u1iBs47LN1Sj3rDBdbLv1u7EpSt0Bt4QuhFSXQ@mail.gmail.com>
         <674cb3e9-d820-016b-a210-afd37ed6e25e@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-30 at 14:44 +0800, Lulu Cheng wrote:
> > > If addr_global is rejected or not implemented (for example, building =
the
> > > kernel with GCC 12), *I expect* the following hack to work (I've not
> > > tested it because I'm AFK now).  Using visibility in kernel seems
> > > strange, but I think it may make some sense because the modules are s=
ome
> > > sort of similar to an ELF shared object being dlopen()'ed, and our wa=
y
> > > to inject per-CPU symbols is analog to ELF interposition.
> > >=20
> > Sadly, I don't know what visibility is, does it have something to do
> > with __visible in include/linux/compiler_attributes.h?

They are different definitions of visibility and mostly unrelated.=20
Unfortunately humans do not have enough words in the language to
disambiguate those different concepts :).

-fvisibility and __attribute__((visibility)) are for ELF shared objects.
Kernel developers usually do not need to take care of them (unless
working on VDSO).

-fvisibility=3Ddefault (yes, it's the default) makes the symbol "possible
to be interposed" while -fPIC.  Say

$ cat main.c
extern int f(void);
extern int printf(const char *, ...);
int x =3D 1;
int main() { printf("%d\n", f()); }
$ cat shared.c
int x =3D 42;
int f(void) { return x; }
$ cc shared.c -fPIC -shared -o libshared.so
$ cc main.c -L. -Wl,-rpath,. -lshared
$ ./a.out
1

You may think it strange but it's so-called "symbol interposition"
mandated by ELF spec.  To make it work, the compiler has to use GOT
access for "x" instead of PC-relative access.

OTOH, a "hidden" visibility disallows interposition:

$ cat shared-1.c
__attribute__((visbility("hidden"))) int x =3D 42;
int f(void) { return x; }
$ cc shared-1.c -fPIC -shared -o libshared.so
$ ./a.out
42

Now the compiler will use PC-relative access for "x" in "f".

In my hack the combination of "-fPIC" and
"__attribute__((visibility("default")))" for per-CPU symbols makes per-
CPU symbols accessed via GOT, and "-fvisibility=3Dhidden" keeps normal
symbols accessed via PC-relative within a TU.

Note that the visibility of a symbol is also recorded in the symtab, and
ld.so will refuse to access a hidden symbol in one shared object from
another.  But the kernel module loader just doesn't care the visibility
field in symtab so it won't affect us.

Basically the hack just uses visibility options & attributes *in a way
they are not designed for* to trick the compiler to emit GOT accesses
for per-CPU symbols.  A new attribute ("get_through_got"/"movable" or
whatever) is definitely wanted to avoid such a tricky approach, but the
hack can be used if we want modular kernel able to be built with GCC 12.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
