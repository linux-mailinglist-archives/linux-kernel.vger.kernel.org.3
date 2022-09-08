Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91E5B244B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiIHRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIHRS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9BCCD6F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9B6D61DBB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96103C433C1;
        Thu,  8 Sep 2022 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657508;
        bh=BKMcAQ3vYiv+Ylfeo5rUhNpJPYy2W6lJL3dQjdOBQtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p15oEeIpato/8FuclAgFIU8NnBmaj9g7/2fL318qIGl7W9JRzRLW5hgKL8KXmNW61
         myVk1IvIDYKaht3RqxAh2hGpmOUG7E3dOG7GPrIi524J/1YEoaUbpYjjBD4H9cIBXf
         7gohqijJ10318MqLYAV/986QoSw/GIxnT8aYLM+9MGLga7Ll5Ajd/uQWnA8mKnLXnh
         FSn+Ea5GOQzWra/K3AZfYaGo4bSlRWnWknwMsQ99Dx7caJssLjsSWg+b2PicmB8IVl
         eRD6C+xohQRj1KWvecXz0OYIqSjNc6O2vCLPE/LduOyfOuE06//gT/FHovnjRb8cbb
         /l3Wq6GJO57cg==
Date:   Thu, 8 Sep 2022 10:18:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Khem Raj <raj.khem@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] riscv: Pass -mno-relax only on lld < 15.0.0
Message-ID: <Yxoj4VUJFvQTFl9r@dev-arch.thelio-3990X>
References: <20220710071117.446112-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710071117.446112-1-maskray@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not look like this ever got picked up? Would it be possible to
pick it up for 6.1?

The original patch is at:

https://lore.kernel.org/20220710071117.446112-1-maskray@google.com/

Cheers,
Nathan

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
