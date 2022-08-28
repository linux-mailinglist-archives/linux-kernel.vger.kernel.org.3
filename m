Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491025A3DF6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiH1OPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1OPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449112ABB
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A0260F9F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F5BC433D7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661696138;
        bh=99ZcCIurvZTW9PcpZnQL4kXGr8fFd022xLQ96/T+S0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZANWoDpM44tfTY87bjDQiWJEtSRR2yTxj2xIlPdkzTw6IvTU/fRUgwC5hfiZmqsAj
         SJ9KBkfV85esc8R5J71arTE/arip6NwyCVUr0P5g1ZIxBNRLqc6WEkVt3R80gXX1Z1
         UVVAwrf8npE54J33z6LHVwGBsu2z/zB7bxKr/ZGd8pBCZhR6lq1zYiw5Lyc5S6FxeR
         NU99BcRk6JaNa47NuoqnT+lL76OuGYN/g0fmYZkbYsc4ppWqaD4w0w/S0M7IwwxJkX
         9Hmr+MOSGLd1l83FcmcJlMG+x6aiXp9Y/hHwh07X6Fny7fgVTqOg+1LPQx8HaxR7dV
         HBNFq6wYnh6GQ==
Received: by mail-vk1-f182.google.com with SMTP id s66so797591vkb.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:15:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo0IGR5POJqRZLdQmckWtwu+mTJPqgwa5T/YN+KZGPKJ5bu3eOyO
        7z1Tq5XY112vamOtkibSeLJzkHJ7FojOku/9ivw=
X-Google-Smtp-Source: AA6agR5kos12SinkdJRmGfRcKjpnuqh5Dizap/pwmR9zBct2kTeSPZNilj8KD5ibGl1tyTkZirY3QcMa4Bd8yZ1c+/w=
X-Received: by 2002:a1f:b248:0:b0:377:aa0c:941 with SMTP id
 b69-20020a1fb248000000b00377aa0c0941mr2104203vkf.37.1661696137497; Sun, 28
 Aug 2022 07:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220827175436.156464-1-xry111@xry111.site>
In-Reply-To: <20220827175436.156464-1-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 28 Aug 2022 22:15:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4+=CqeRUUt+XPZ2Nf=1GRgHtTFyMuVu-y6QdgQgD4mog@mail.gmail.com>
Message-ID: <CAAhV-H4+=CqeRUUt+XPZ2Nf=1GRgHtTFyMuVu-y6QdgQgD4mog@mail.gmail.com>
Subject: Re: [PATCH 0/8] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Sun, Aug 28, 2022 at 1:55 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> The version 2.00 of LoongArch ELF ABI specification introduced new
> relocation types, and the development tree of Binutils and GCC has
> started to use them.  If the kernel is built with the latest snapshot of
> Binutils or GCC, it will fail to load the modules because of unrecognized
> relocation types in modules.
>
> Add support for GOT and new relocation types for the module loader, so
> the kernel (with modules) can be built with the "normal" code model and
> function properly.
>
> This series does not break the compatibility with old toolchain using
> stack-based relocation types, so with the patches applied the kernel can
> be be built with both old and new toolchains.
>
> Tested by building the kernel with the following combinations:
>
> - GCC 12 and Binutils 2.39
> - GCC 12 and Binutils trunk
> - GCC trunk and Binutils trunk
>
> and running the builds with 35 in-tree modules loaded, and loading one
> module with 20 GOT loads and a per-CPU variable (loaded addresses
> verified by comparing with /proc/kallsyms).
>
> This superseds "LoongArch: Support new relocation types" series.  I
> don't make it a "v5" because too much things have changed so it's better
> to treat this as a new series.
1, You can still call it v5, even if it has changed a lot;
2, In my opinion, patch 4,5,7,8 can be combined, but I don't insist if
you have a good reason to separate.
3, If possible, I still prefer to remove old relocation types support,
in order to make life easier, especially for objtool that is queued
for upstream.



Huacai

>
> Xi Ruoyao (8):
>   LoongArch: Add CONFIG_CC_HAS_EXPLICIT_RELOCS
>   LoongArch: Only use -Wa,-mla-* options for
>     !CONFIG_CC_HAS_EXPLICIT_RELOCS
>   LoongArch: Define ELF relocation types added in v2.00 ABI
>   LoongArch: Support R_LARCH_B26 in modules
>   LoongArch: Support R_LARCH_ABS* in modules
>   LoongArch: Use model("extreme") attribute for per-CPU variables in
>     module if CONFIG_CC_HAS_EXPLICIT_RELOCS
>   LoongArch: Support R_LARCH_PCALA* in modules
>   LoongArch: Support R_LARCH_GOT_PC* in modules
>
>  arch/loongarch/Kconfig                  |   3 +
>  arch/loongarch/Makefile                 |  15 ++-
>  arch/loongarch/include/asm/elf.h        |  37 +++++++
>  arch/loongarch/include/asm/module.h     |  23 ++++
>  arch/loongarch/include/asm/module.lds.h |   1 +
>  arch/loongarch/include/asm/percpu.h     |  13 +++
>  arch/loongarch/kernel/head.S            |  10 +-
>  arch/loongarch/kernel/module-sections.c |  56 +++++++++-
>  arch/loongarch/kernel/module.c          | 138 +++++++++++++++++++++++-
>  9 files changed, 285 insertions(+), 11 deletions(-)
>
> --
> 2.37.0
>
