Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC418585A25
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 12:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiG3KjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiG3KjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 06:39:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF20A2CDEF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 03:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 825BB60C40
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 10:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DBCC433B5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659177548;
        bh=ccWN+UJr8e9XwHdVFz0LM15EpLwV+jaB+5qiit7JIVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QF+6eONP/pe/8pH/OTVVlCLH6AFY6nKQwfu9MRB7JaGDVpS6+V7PUdInaBhosdxXP
         GJRI+e4laH6ZdCS0YZwPnKcGMT1/l19HytWf6q21GczIFfWYSyAZExGhU/F4CIQmiI
         3ls2vWzGhYIIE7CXHOoLnv+Ka58QPB7ozCl+dWMSuFDwWfgJ4KiPq8fsTWgmYk4B0z
         ONirkePV/JHrcJKvl5cQ3n6Y6jVZVKPS48jwiNo+LlsoExoEwEsLKkrcopmyF6UBhV
         RXMCaO2+094qAy3TbWq1C+xX6ap81tntamHgC86FaCX/g7XW2zXFlkj+rocIRqaSII
         1hmEE84DVog5g==
Received: by mail-vs1-f41.google.com with SMTP id 66so6831028vse.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 03:39:08 -0700 (PDT)
X-Gm-Message-State: AJIora8R5hx707e4LpClPKCcqWbZJoE928F8XxxPYG24VLtXGTvcuI4M
        5ja/d2yL9iq3W1e80bfoUfY0tcpHxUo16xqx3ZU=
X-Google-Smtp-Source: AGRyM1u0YIgB0zQEKY8PZ0OA2sgsXwQ+k1R5VVCl4BfAkImIZSDYwymFrpd19aGQiVZmz931afQsAi+c3w7RCTHO3Hk=
X-Received: by 2002:a67:d495:0:b0:357:688d:f65c with SMTP id
 g21-20020a67d495000000b00357688df65cmr2936127vsj.59.1659177547759; Sat, 30
 Jul 2022 03:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
 <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn> <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
 <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
 <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
 <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn> <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
 <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
 <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
 <CAAhV-H7WxRp4u1iBs47LN1Sj3rDBdbLv1u7EpSt0Bt4QuhFSXQ@mail.gmail.com>
 <674cb3e9-d820-016b-a210-afd37ed6e25e@loongson.cn> <5233653cceab9c2baf6510bd712cd53ef63e3aac.camel@xry111.site>
In-Reply-To: <5233653cceab9c2baf6510bd712cd53ef63e3aac.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 30 Jul 2022 18:38:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6jAxOx1xfa6N8F5L0Oc-sp9KimQN-Sen6YPDjnRVEMuQ@mail.gmail.com>
Message-ID: <CAAhV-H6jAxOx1xfa6N8F5L0Oc-sp9KimQN-Sen6YPDjnRVEMuQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Lulu Cheng <chenglulu@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 5:51 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Sat, 2022-07-30 at 14:44 +0800, Lulu Cheng wrote:
> > > > If addr_global is rejected or not implemented (for example, building the
> > > > kernel with GCC 12), *I expect* the following hack to work (I've not
> > > > tested it because I'm AFK now).  Using visibility in kernel seems
> > > > strange, but I think it may make some sense because the modules are some
> > > > sort of similar to an ELF shared object being dlopen()'ed, and our way
> > > > to inject per-CPU symbols is analog to ELF interposition.
> > > >
> > > Sadly, I don't know what visibility is, does it have something to do
> > > with __visible in include/linux/compiler_attributes.h?
>
> They are different definitions of visibility and mostly unrelated.
> Unfortunately humans do not have enough words in the language to
> disambiguate those different concepts :).
>
> -fvisibility and __attribute__((visibility)) are for ELF shared objects.
> Kernel developers usually do not need to take care of them (unless
> working on VDSO).
>
> -fvisibility=default (yes, it's the default) makes the symbol "possible
> to be interposed" while -fPIC.  Say
>
> $ cat main.c
> extern int f(void);
> extern int printf(const char *, ...);
> int x = 1;
> int main() { printf("%d\n", f()); }
> $ cat shared.c
> int x = 42;
> int f(void) { return x; }
> $ cc shared.c -fPIC -shared -o libshared.so
> $ cc main.c -L. -Wl,-rpath,. -lshared
> $ ./a.out
> 1
>
> You may think it strange but it's so-called "symbol interposition"
> mandated by ELF spec.  To make it work, the compiler has to use GOT
> access for "x" instead of PC-relative access.
>
> OTOH, a "hidden" visibility disallows interposition:
>
> $ cat shared-1.c
> __attribute__((visbility("hidden"))) int x = 42;
> int f(void) { return x; }
> $ cc shared-1.c -fPIC -shared -o libshared.so
> $ ./a.out
> 42
>
> Now the compiler will use PC-relative access for "x" in "f".
>
> In my hack the combination of "-fPIC" and
> "__attribute__((visibility("default")))" for per-CPU symbols makes per-
> CPU symbols accessed via GOT, and "-fvisibility=hidden" keeps normal
> symbols accessed via PC-relative within a TU.
>
> Note that the visibility of a symbol is also recorded in the symtab, and
> ld.so will refuse to access a hidden symbol in one shared object from
> another.  But the kernel module loader just doesn't care the visibility
> field in symtab so it won't affect us.
>
> Basically the hack just uses visibility options & attributes *in a way
> they are not designed for* to trick the compiler to emit GOT accesses
> for per-CPU symbols.  A new attribute ("get_through_got"/"movable" or
> whatever) is definitely wanted to avoid such a tricky approach, but the
> hack can be used if we want modular kernel able to be built with GCC 12.
So it has nothing to do with __visible in include/linux/compiler_attributes.h?
Or __visible is a similar thing that used by Linux kernel?

Huacai
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
