Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29D15708F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGKRgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGKRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70627B29
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36A1A6136E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24210C34115;
        Mon, 11 Jul 2022 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657560970;
        bh=/JLD7aGPAUH2PlEjhKv8uoAqs8/TyZRWMWlU6+jVWgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlYkvo3bixwtbU6hCps4/5JfqYhJ5pR2zL0s9D0OlM2Jp2Dq/8xx2NK4NAJ3JQGpB
         gZKYcK/HJ0O/zdgNbOOQgmZ5FqPOB1TYqKj2ZSzQhXEleq4K1Yke3XCISkRbSBoKoF
         JnOWU17WoB5SRUA9UhoLCKQ5RumJqm0l3Sr44Q/44UZSp3aFVRGOWlFQlxjvItLSVB
         3oSTQGA41U2Y6wP5oEEeiTT3/7HoXz48tkpb9ji8x++aED+S76Y3Xlz6ASpoyfUBDS
         dUz6dqIlSjUa5nNmaQ4hC0FAB9ViMDG+QJup58Hm5ldq8LeBjyJAkmGigAd8T8TAUC
         DDinQqc3d8l6Q==
Date:   Mon, 11 Jul 2022 10:36:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Khem Raj <raj.khem@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] riscv: Pass -mno-relax only on lld < 15.0.0
Message-ID: <YsxfiKC/ZBr7U7qI@dev-arch.thelio-3990X>
References: <20220710071117.446112-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710071117.446112-1-maskray@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 12:11:17AM -0700, Fangrui Song wrote:
> lld since
> https://github.com/llvm/llvm-project/commit/6611d58f5bbcbec77262d392e2923e1d680f6985
> (milestone: 15.0.0) has implemented some RISC-V linker relaxation.
> -mno-relax is no longer needed in KBUILD_CFLAGS/KBUILD_AFLAGS to
> suppress R_RISCV_ALIGN which older lld can not handle:
> 
> ld.lld: error: capability.c:(.fixup+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax but the .o is already compiled with -mno-relax
> 
> Signed-off-by: Fangrui Song <maskray@google.com>

ld.lld 14 and 15 both continue to link kernels and I have no issues
booting them in QEMU.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 34cf8a598617..7e4ceb2a0981 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -37,6 +37,7 @@ else
>  endif
>  
>  ifeq ($(CONFIG_LD_IS_LLD),y)
> +ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 150000; echo $$?),0)
>  	KBUILD_CFLAGS += -mno-relax
>  	KBUILD_AFLAGS += -mno-relax
>  ifndef CONFIG_AS_IS_LLVM
> @@ -44,6 +45,7 @@ ifndef CONFIG_AS_IS_LLVM
>  	KBUILD_AFLAGS += -Wa,-mno-relax
>  endif
>  endif
> +endif
>  
>  # ISA string setting
>  riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
> -- 
> 2.37.0.144.g8ac04bfd2-goog
> 
> 
