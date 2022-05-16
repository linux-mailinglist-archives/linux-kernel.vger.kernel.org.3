Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245225293CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbiEPWtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349767AbiEPWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:49:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E264161F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D22AB8169D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8A5C385B8;
        Mon, 16 May 2022 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652741337;
        bh=0a/C5Zh/EyYXf/vzC/E/LwVLfqbJzBzn8Mkz0TSW/yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWnzV72+IpwctV6Br6FbM1QcIOfi5j/S+mo0+UkMggtP03es0EHoIIM8FXr80ydlN
         pU/iMMX7IiiFYYkMPykUzjkQ/rBELVMBM3ZgczPG+Df+Xf4JvmqeWRpnaplIQXADV3
         ljdR/DzH36ziJ14mg/fQgOQZwpA3aKGJuMytrgVFUjcupuZ8L8ly4T0fUGHclcClJC
         uPWzkwAkQXg19m1TXk/9yigHK8Xi9f+zd5bIi2u4bEOR6QyRG/pF3pV/l72MQ1UwKC
         eHOfs3Jli4RLCkx7MhuwaX9PwWg82TqD6ZK3Q3XRji8jma+x6Jbeey+zHX9LgHn+r2
         xIr0STsCpLCAA==
Date:   Mon, 16 May 2022 15:48:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <YoLU10rW+EZCDEfI@dev-arch.thelio-3990X>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:40:05PM +0200, Peter Zijlstra wrote:
> On Mon, May 16, 2022 at 01:47:15PM -0700, Nathan Chancellor wrote:
> > Hi Josh and Peter,
> > 
> > After a recent change in LLVM [1], I see warnings (errors?) from objtool
> > when building x86_64 allmodconfig on 5.15 and 5.17:
> > 
> >   $ make -skj"$(nproc)" KCONFIG_ALLCONFIG=<(echo CONFIG_WERROR) LLVM=1 allmodconfig all
> >   ...
> >   mm/highmem.o: warning: objtool: no non-local symbols !?
> >   mm/highmem.o: warning: objtool: gelf_update_symshndx: invalid section index
> >   make[2]: *** [scripts/Makefile.build:288: mm/highmem.o] Error 255
> >   ...
> >   security/tomoyo/load_policy.o: warning: objtool: no non-local symbols !?
> >   security/tomoyo/load_policy.o: warning: objtool: gelf_update_symshndx: invalid section index
> >   make[3]: *** [scripts/Makefile.build:288: security/tomoyo/load_policy.o] Error 255
> >   ...
> > 
> > I don't see the same errors on x86_64 allmodconfig on mainline so I
> > bisected the 5.17 branch and came upon commit 4abff6d48dbc ("objtool:
> > Fix code relocs vs weak symbols"). I wanted to see what 5.17 might be
> > missing and came to commit ed53a0d97192 ("x86/alternative: Use
> > .ibt_endbr_seal to seal indirect calls") in mainline, which I think just
> > hides the issue for allmodconfig. I can reproduce this problem with a
> > more selective set of config values on mainline:
> > 
> >   $ make -skj"$(nproc)" LLVM=1 defconfig
> > 
> >   $ scripts/config -e KASAN -e SECURITY_TOMOYO -e SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
> > 
> >   $ make -skj"$(nproc)" LLVM=1 olddefconfig security/tomoyo/load_policy.o
> >   security/tomoyo/load_policy.o: warning: objtool: no non-local symbols !?
> >   security/tomoyo/load_policy.o: warning: objtool: gelf_update_symshndx: invalid section index
> >   make[3]: *** [scripts/Makefile.build:288: security/tomoyo/load_policy.o] Error 255
> >   ...
> > 
> > Looking at the object file, the '.text.asan.module_ctor' section has
> > disappeared.
> > 
> > Before:
> > 
> >   $ llvm-nm -S security/tomoyo/load_policy.o
> >   0000000000000000 0000000000000001 t asan.module_ctor
> > 
> >   $ llvm-readelf -s security/tomoyo/load_policy.o
> > 
> >   Symbol table '.symtab' contains 4 entries:
> >      Num:    Value          Size Type    Bind   Vis       Ndx Name
> >        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
> >        1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS load_policy.c
> >        2: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 .text.asan.module_ctor
> >        3: 0000000000000000     1 FUNC    LOCAL  DEFAULT     3 asan.module_ctor
> > 
> > After:
> > 
> >   $ llvm-nm -S security/tomoyo/load_policy.o
> >   0000000000000000 0000000000000001 t asan.module_ctor
> > 
> >   $ llvm-readelf -s security/tomoyo/load_policy.o
> > 
> >   Symbol table '.symtab' contains 3 entries:
> >      Num:    Value          Size Type    Bind   Vis       Ndx Name
> >        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
> >        1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS load_policy.c
> >        2: 0000000000000000     1 FUNC    LOCAL  DEFAULT     3 asan.module_ctor
> > 
> 
> The problem seems to be that we need to add a local symbols because LLVM
> helpfully stripped all unused section symbols.
> 
> The way we do that, is by moving a the first non-local symbol to the
> end, thereby creating a hole where we can insert a new local symbol.
> Because ELF very helpfully mandates that local symbols must come before
> non-local symbols and keeps the symbols index of the first non-local in
> sh_info.
> 
> Thing is, the above object files don't appear to have a non-local symbol
> so the swizzle thing isn't needed, and apparently the value in sh_info
> isn't valid either.
> 
> Does something simple like this work? If not, I'll try and reproduce
> tomorrow, it shouldn't be too hard to fix.

That diff obviously gets rid of the "no non-local symbols" message but I
still see the "invalid section index" message. I'll be offline tomorrow
but if you have issues reproducing it, I'll be happy to help on
Wednesday. At the time I am writing this, apt.llvm.org packages have not
been updated to include that LLVM change I mentioned; hopefully they
will be soon.

Thanks for the quick response!
Nathan

> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 583a3ec987b5..baabf38a2a11 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -618,8 +618,7 @@ static int elf_move_global_symbol(struct elf *elf, struct section *symtab,
>  
>  	sym = find_symbol_by_index(elf, first_non_local);
>  	if (!sym) {
> -		WARN("no non-local symbols !?");
> -		return first_non_local;
> +		return symtab->sh.sh_size / sizeof(sym->sym);
>  	}
>  
>  	s = elf_getscn(elf->elf, symtab->idx);
> 
