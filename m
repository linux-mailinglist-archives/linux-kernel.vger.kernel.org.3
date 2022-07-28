Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E9583EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbiG1MeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiG1MeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576416AA33
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E984D61CBF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5120EC433C1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659011646;
        bh=YS/n9ogwkr/pRzYuKfIBVzxt/zaMhoZ7QPsR7CiArGI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nsx5R754RNWL4YVTijfhrwVEM9Iy7Djo317RdIF2y5iQfSz70y3ouhglc5t7GCs8h
         K21MYHjbp7TmlsO9KbELn/y1WR0L3LFT5EwTPyQyyPlVg6XYAAQCB4IM8fCJLsGgwS
         Pxaxx3pVV8dATdjnmg/EZTS0Caz/Mnu0TeopmGz8Zs8ZAkdp7IITJGK2qyTamlxSD7
         xSgE18WGeaW6lnBYr5cQby36utpMqM2mYFMp4wuwer1hQUI23klOzqJGC1YSGmLG08
         r25FMlc8EPdk6zLyhSjEvtcvR6u2lrQW1ugjCLmSg7nggMU9G5WWs1EAUYEDsS14Bb
         YK62iP7wBt65g==
Received: by mail-vs1-f41.google.com with SMTP id o4so1451673vsc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:34:06 -0700 (PDT)
X-Gm-Message-State: AJIora+40BRNQZ6bamoZgq/cYz5UMiEL6s8J7Xv2REsmMojG8T/lrZGr
        RS/E4ylIWANMHW0766Pr/g0hQdrpIBspiGH6NIQ=
X-Google-Smtp-Source: AGRyM1t9JciZ9hkpPv8Vv819pdS0eDNfU1nlXZzDbDfz/WZbvVMO2CWjzXYuF8EAeleBxkBfJU2VJvFj+f3ZSLZh4+o=
X-Received: by 2002:a67:d495:0:b0:357:688d:f65c with SMTP id
 g21-20020a67d495000000b00357688df65cmr8324265vsj.59.1659011645148; Thu, 28
 Jul 2022 05:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
In-Reply-To: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 20:33:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5C3LW-xFV-4KsJZHow3av0qeV-sHUSJTUp=hwHGfO1wg@mail.gmail.com>
Message-ID: <CAAhV-H5C3LW-xFV-4KsJZHow3av0qeV-sHUSJTUp=hwHGfO1wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] LoongArch: Support new relocation types
To:     Xi Ruoyao <xry111@xry111.site>, Arnd Bergmann <arnd@arndb.de>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd,


On Thu, Jul 28, 2022 at 7:49 PM Xi Ruoyao <xry111@xry111.site> wrote:
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
> Tested by building the kernel with Binutils & GCC master branch,
> running the kernel with 35 in-tree modules loaded, and loading one
> module with 20 GOT loads (both old SOP_PUSH_GPREL and new
> GOT_PC_HI20/GOT_PC_LO12 relocations tested, and loaded addresses
> verified by comparing with /proc/kallsyms).
>
> Link: https://github.com/loongson/LoongArch-Documentation/pull/57
> Link: https://gcc.gnu.org/r13-1834
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f09482a
Could you update the cross-compilers here [1] to make this series be
possible upstream in the 5.20 cycle? Or we can only do that until new
binutils/gcc be released?

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

Huacai
>
> Changes from v1 to v2:
>
> - Fix a stupid programming error (confusion between the number of PLT
>   entries and the number of GOT entries).  (Bug spotted by Youling).
> - Synthesize the _GLOBAL_OFFSET_TABLE_ symbol with module.lds, instead
>   of faking it at runtime.  The 3rd patch from V1 is now merged into
>   the 1st patch because it would be a one-line change.  (Suggested by
>   Jinyang).
> - Keep reloc_rela_handlers[] ordered by the relocation type ID.
>   (Suggested by Youling).
> - Remove -fplt along with -Wa,-mla-* options because it's the default.
>   (Suggested by Youling).
>
> Xi Ruoyao (4):
>   LoongArch: Add section of GOT for kernel module
>   LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation type in kernel
>     module
>   LoongArch: Stop using undocumented assembler options
>   LoongArch: Support modules with new relocation types
>
>  arch/loongarch/Makefile                 |  4 --
>  arch/loongarch/include/asm/elf.h        | 37 ++++++++++
>  arch/loongarch/include/asm/module.h     | 23 ++++++
>  arch/loongarch/include/asm/module.lds.h |  1 +
>  arch/loongarch/kernel/head.S            | 10 +--
>  arch/loongarch/kernel/module-sections.c | 51 ++++++++++++--
>  arch/loongarch/kernel/module.c          | 94 +++++++++++++++++++++++++
>  7 files changed, 207 insertions(+), 13 deletions(-)
>
> --
> 2.37.0
>
