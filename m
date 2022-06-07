Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B80540155
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiFGO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245411AbiFGOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD8F339F;
        Tue,  7 Jun 2022 07:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6743F615BC;
        Tue,  7 Jun 2022 14:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25812C385A5;
        Tue,  7 Jun 2022 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654611952;
        bh=eTmmhNitWRhmgZXJiNPWVRwjucfXXcjZHpQJMAyvH58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBR0PNsJs3s/xFyjfBsc4EC9G3D/5SUtETmaEp5FfEHy2Y4GkLRefOZZC16UJYwF1
         ZLnF7A38kqHH808gvWreIM8pzJ9/T2hLyN12swLRB0jh6pA93lbsFjiD56+LsV2vXm
         4kT+r3l0XMMjXazYdAxlil8FhZQ3fscdk+ObtXevsiol99sqlgyuXCEahsvWKzM+Dw
         2f3hgoRrcHZj/n+bUqhHB6hMZgYfg/DsNmLsZ9YIOJ77WN0UdIu/imQNcAG7FhF+UJ
         +90y5Yc98fFqkKvcRz/9VZnhx+8DpTr8UccPT4POnxYj+2sT3QPAA6h3/XM1RA/Hna
         zedNydLz/9Hxw==
Date:   Tue, 7 Jun 2022 07:25:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 06/10] kbuild: check static EXPORT_SYMBOL* by script
 instead of modpost
Message-ID: <Yp9f7lKjcCrRUcAD@dev-arch.thelio-3990X>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <20220513113930.10488-7-masahiroy@kernel.org>
 <e020f60d-218c-8e47-5863-23dcb55452f2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e020f60d-218c-8e47-5863-23dcb55452f2@nvidia.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:22:21PM +0100, Jon Hunter wrote:
> 
> On 13/05/2022 12:39, Masahiro Yamada wrote:
> > The 'static' specifier and EXPORT_SYMBOL() are an odd combination.
> > 
> > Commit 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL*
> > functions") tried to detect it, but this check has false negatives.
> > 
> > Here is the sample code.
> > 
> >    Makefile:
> > 
> >      obj-y += foo1.o foo2.o
> > 
> >    foo1.c:
> > 
> >      #include <linux/export.h>
> >      static void foo(void) {}
> >      EXPORT_SYMBOL(foo);
> > 
> >    foo2.c:
> > 
> >      void foo(void) {}
> > 
> > foo1.c exports the static symbol 'foo', but modpost cannot catch it
> > because it is fooled by foo2.c, which has a global symbol with the
> > same name.
> > 
> > s->is_static is cleared if a global symbol with the same name is found
> > somewhere, but EXPORT_SYMBOL() and the global symbol do not necessarily
> > belong to the same compilation unit.
> > 
> > This check should be done per compilation unit, but I do not know how
> > to do it in modpost. modpost runs against vmlinux.o or modules, which
> > merges multiple objects, then forgets their origin.
> > 
> > It is true modpost gets access to the lists of all the member objects
> > (.vmlinux.objs and *.mod), but modpost cannot parse individual objects
> > because they may not be ELF but LLVM IR when CONFIG_LTO_CLANG=y.
> > 
> > Add a simple bash script to parse the output from ${NM}. This works for
> > CONFIG_LTO_CLANG=y because llvm-nm can dump symbols of LLVM IR files.
> > 
> > Revert 15bfc2348d54.
> > 
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> 
> One some older build machines this is causing some builds (ARM/ARM64)
> to fail ...
> 
> /dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/check-local-export: line 54: wait: pid 48433 is not a child of this shell
> /dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/Makefile.build:250: recipe for target 'scripts/mod/empty.o' failed
> make[2]: *** [scripts/mod/empty.o] Error 127
> make[2]: *** Deleting file 'scripts/mod/empty.o'
> make[2]: *** Waiting for unfinished jobs....
> /dvs/git/dirty/git-master_l4t-upstream/kernel/Makefile:1285: recipe for target 'prepare0' failed
> make[1]: *** [prepare0] Error 2
> make[1]: Leaving directory '/dvs/git/dirty/git-master_l4t-upstream/artifacts/linux/arm64-defconfig-jetson'
> Makefile:228: recipe for target '__sub-make' failed
> make: *** [__sub-make] Error 2
> 
> Any ideas?

https://lore.kernel.org/20220607084317.211785-1-masahiroy@kernel.org/
should resolve it if you wanted to give it a test.

Cheers,
Nathan
