Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0E529302
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349424AbiEPVkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiEPVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:40:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1C419B2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aCb2HiewM12GOnx9FEdB6E4pX5NJT/HZCa9UT6fkVvk=; b=OlCozzdRAQyf+vNMU2vVeuPHd/
        qjdeQrKKntDC2H9t8AZ1ILZHIERUIF9f75hQRCxN4ftfUviI2YgdlATVvB5CaxsW7/4sm01G2sdpq
        oTlngSGy3zMhVkJjMdH59yo+1VCti6N84pqoR+OU7ERpLIqK8rTMBay/IMTUWkZ6qXWnV+ZE/x20i
        7EEtNsu65vlPwEvJpsFiibLuITp6Aeovj9RCPmJ45ftcE5inToCKc5sxSmD6U44WqobMuk/U2BFYe
        Iiy6yxab5ivpBh39CBfuT4GgKovg5wzH+Eg2YSOqMQdXLzWhT3VhefsbImx1T6BW7Wrn9662ZHZkp
        PS33ixMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqiRj-00120Q-1i; Mon, 16 May 2022 21:40:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05E44980DCC; Mon, 16 May 2022 23:40:06 +0200 (CEST)
Date:   Mon, 16 May 2022 23:40:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 01:47:15PM -0700, Nathan Chancellor wrote:
> Hi Josh and Peter,
> 
> After a recent change in LLVM [1], I see warnings (errors?) from objtool
> when building x86_64 allmodconfig on 5.15 and 5.17:
> 
>   $ make -skj"$(nproc)" KCONFIG_ALLCONFIG=<(echo CONFIG_WERROR) LLVM=1 allmodconfig all
>   ...
>   mm/highmem.o: warning: objtool: no non-local symbols !?
>   mm/highmem.o: warning: objtool: gelf_update_symshndx: invalid section index
>   make[2]: *** [scripts/Makefile.build:288: mm/highmem.o] Error 255
>   ...
>   security/tomoyo/load_policy.o: warning: objtool: no non-local symbols !?
>   security/tomoyo/load_policy.o: warning: objtool: gelf_update_symshndx: invalid section index
>   make[3]: *** [scripts/Makefile.build:288: security/tomoyo/load_policy.o] Error 255
>   ...
> 
> I don't see the same errors on x86_64 allmodconfig on mainline so I
> bisected the 5.17 branch and came upon commit 4abff6d48dbc ("objtool:
> Fix code relocs vs weak symbols"). I wanted to see what 5.17 might be
> missing and came to commit ed53a0d97192 ("x86/alternative: Use
> .ibt_endbr_seal to seal indirect calls") in mainline, which I think just
> hides the issue for allmodconfig. I can reproduce this problem with a
> more selective set of config values on mainline:
> 
>   $ make -skj"$(nproc)" LLVM=1 defconfig
> 
>   $ scripts/config -e KASAN -e SECURITY_TOMOYO -e SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
> 
>   $ make -skj"$(nproc)" LLVM=1 olddefconfig security/tomoyo/load_policy.o
>   security/tomoyo/load_policy.o: warning: objtool: no non-local symbols !?
>   security/tomoyo/load_policy.o: warning: objtool: gelf_update_symshndx: invalid section index
>   make[3]: *** [scripts/Makefile.build:288: security/tomoyo/load_policy.o] Error 255
>   ...
> 
> Looking at the object file, the '.text.asan.module_ctor' section has
> disappeared.
> 
> Before:
> 
>   $ llvm-nm -S security/tomoyo/load_policy.o
>   0000000000000000 0000000000000001 t asan.module_ctor
> 
>   $ llvm-readelf -s security/tomoyo/load_policy.o
> 
>   Symbol table '.symtab' contains 4 entries:
>      Num:    Value          Size Type    Bind   Vis       Ndx Name
>        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
>        1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS load_policy.c
>        2: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 .text.asan.module_ctor
>        3: 0000000000000000     1 FUNC    LOCAL  DEFAULT     3 asan.module_ctor
> 
> After:
> 
>   $ llvm-nm -S security/tomoyo/load_policy.o
>   0000000000000000 0000000000000001 t asan.module_ctor
> 
>   $ llvm-readelf -s security/tomoyo/load_policy.o
> 
>   Symbol table '.symtab' contains 3 entries:
>      Num:    Value          Size Type    Bind   Vis       Ndx Name
>        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
>        1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS load_policy.c
>        2: 0000000000000000     1 FUNC    LOCAL  DEFAULT     3 asan.module_ctor
> 

The problem seems to be that we need to add a local symbols because LLVM
helpfully stripped all unused section symbols.

The way we do that, is by moving a the first non-local symbol to the
end, thereby creating a hole where we can insert a new local symbol.
Because ELF very helpfully mandates that local symbols must come before
non-local symbols and keeps the symbols index of the first non-local in
sh_info.

Thing is, the above object files don't appear to have a non-local symbol
so the swizzle thing isn't needed, and apparently the value in sh_info
isn't valid either.

Does something simple like this work? If not, I'll try and reproduce
tomorrow, it shouldn't be too hard to fix.

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 583a3ec987b5..baabf38a2a11 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -618,8 +618,7 @@ static int elf_move_global_symbol(struct elf *elf, struct section *symtab,
 
 	sym = find_symbol_by_index(elf, first_non_local);
 	if (!sym) {
-		WARN("no non-local symbols !?");
-		return first_non_local;
+		return symtab->sh.sh_size / sizeof(sym->sym);
 	}
 
 	s = elf_getscn(elf->elf, symtab->idx);

