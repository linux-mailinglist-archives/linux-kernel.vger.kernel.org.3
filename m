Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A23584E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiG2Jre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiG2Jrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:47:32 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2D1F609
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1659088044; bh=UeD/jfW+A1CZ4GGUNDiEY/6KnggkPxlj/RfG5x+Rv0I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NuUwrClVrzg2dJWV5RaVGqUmWLW3Zt7Bn8ld/apkyKhtTebLosFw4r/PvzeuzEwWh
         /BArHVzVKs0tVhWK4KcU13DwrI0Cj3gIHmoazr+I1ilDz4cYLOMEYTUQn0i5XkReBd
         oC8rR74WpVMRDbyLFEAepFK21sLFrZKhjF6oVM1M=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id A7DA060610;
        Fri, 29 Jul 2022 17:47:24 +0800 (CST)
Message-ID: <4a61d1a5-539f-25f9-4acd-92e107bc99a0@xen0n.name>
Date:   Fri, 29 Jul 2022 17:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:105.0)
 Gecko/20100101 Thunderbird/105.0a1
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/29 16:38, Xi Ruoyao wrote:
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
> Tested by building the kernel with both Binutils & GCC master branch and
> my system Binutils & GCC (without new relocation type support), running
> both the builds with 35 in-tree modules loaded, and loading one module
> with 20 GOT loads (loaded addresses verified by comparing with
> /proc/kallsyms).
> 
> Changes from v3 to v4:
> 
> - No code change.  Reword the commit message of the 3rd patch again
>    based on suggestion from Huacai.
> 
> Changes from v2 to v3:
> 
> - Use `union loongarch_instruction` instead of explicit bit shifts
>    applying the relocation.  Suggested by Youling.
> - For R_LARCH_B26, move the alignment check before the range check to be
>    consistent with stack pop relocations.  Suggested by Youling.
> - Reword the commit message of the 3rd patch.  Suggested by Huacai.
> 
> Changes from v1 to v2:
> 
> - Fix a stupid programming error (confusion between the number of PLT
>    entries and the number of GOT entries).  (Bug spotted by Youling).
> - Synthesize the _GLOBAL_OFFSET_TABLE_ symbol with module.lds, instead
>    of faking it at runtime.  The 3rd patch from V1 is now merged into
>    the 1st patch because it would be a one-line change.  (Suggested by
>    Jinyang).
> - Keep reloc_rela_handlers[] ordered by the relocation type ID.
>    (Suggested by Youling).
> - Remove -fplt along with -Wa,-mla-* options because it's the default.
>    (Suggested by Youling).
> 
> Xi Ruoyao (4):
>    LoongArch: Add section of GOT for kernel module
>    LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation type in kernel
>      module
>    LoongArch: Remove -fplt and -Wa,-mla-* from CFLAGS
>    LoongArch: Support modules with new relocation types
> 
>   arch/loongarch/Makefile                 |  4 --
>   arch/loongarch/include/asm/elf.h        | 37 ++++++++++
>   arch/loongarch/include/asm/module.h     | 23 ++++++
>   arch/loongarch/include/asm/module.lds.h |  1 +
>   arch/loongarch/kernel/head.S            | 10 +--
>   arch/loongarch/kernel/module-sections.c | 51 +++++++++++--
>   arch/loongarch/kernel/module.c          | 96 +++++++++++++++++++++++++
>   7 files changed, 209 insertions(+), 13 deletions(-)
> 

Thanks very much for the timely adaptation. I'm rebuilding my Gentoo 
toolchain from upstream HEAD, will test this weekend.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

