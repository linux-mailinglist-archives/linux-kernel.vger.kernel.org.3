Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A583561F70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiF3Pf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiF3Pfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F04F5B7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91473B82BEB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D92C34115;
        Thu, 30 Jun 2022 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656603349;
        bh=xeXcHBHJp18s20H0r59IvRA/+hEOgADzH+b65yvr46c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjTOs5sbsSdtav/pxqHza2CWHFFSzUSvDOE9ETGhBq7kgCdhjtYj50WSIvi6VCK18
         xRlG38FDsPK1oeEplAFaqdsxFFo68VlYe2Y/IocLBP0Zy7ztOh3Gu0J/3c2Iuv1/cN
         nM1Q/VULCJpbCgaK4+wJKfA7w6fY/xm8dKzwT6hofjn5AfHvbalYllpeXbwfnsj3JH
         jdbKzF4X+4rm3wauNwkAEH58Zu3UaOml99To6kB8GaxUjpGHxYV5JG4iWJWfjEiIaO
         pVcA+MilbrvWX7kxa8qwpuCgqmR0B/j0SpG8kJ4PUJlC2zn1ymG6jpqCmj750o50/B
         nbJdAhxmuLz7Q==
Date:   Thu, 30 Jun 2022 08:35:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] arm64: vdso32: Shuffle .ARM.exidx section above
 ELF_DETAILS
Message-ID: <Yr3C04jufBhzGJe2@dev-arch.thelio-3990X>
References: <20220630153121.1317045-1-nathan@kernel.org>
 <20220630153121.1317045-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630153121.1317045-2-nathan@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:31:20AM -0700, Nathan Chancellor wrote:
> When building the 32-bit vDSO after commit 5c4fb60816ea ("arm64: vdso32:
> add ARM.exidx* sections"), ld.lld 11 fails to link:
> 
>   ld.lld: error: could not allocate headers
>   ld.lld: error: unable to place section .text at file offset [0x2A0, 0xBB1]; check your linker script for overflows
>   ld.lld: error: unable to place section .comment at file offset [0xBB2, 0xC8A]; check your linker script for overflows
>   ld.lld: error: unable to place section .symtab at file offset [0xC8C, 0xE0B]; check your linker script for overflows
>   ld.lld: error: unable to place section .strtab at file offset [0xE0C, 0xF1C]; check your linker script for overflows
>   ld.lld: error: unable to place section .shstrtab at file offset [0xF1D, 0xFAA]; check your linker script for overflows
>   ld.lld: error: section .ARM.exidx file range overlaps with .hash
>   >>> .ARM.exidx range is [0x90, 0xCF]
>   >>> .hash range is [0xB4, 0xE3]
> 
>   ld.lld: error: section .hash file range overlaps with .ARM.attributes
>   >>> .hash range is [0xB4, 0xE3]
>   >>> .ARM.attributes range is [0xD0, 0x10B]
> 
>   ld.lld: error: section .ARM.attributes file range overlaps with .dynsym
>   >>> .ARM.attributes range is [0xD0, 0x10B]
>   >>> .dynsym range is [0xE4, 0x133]
> 
>   ld.lld: error: section .ARM.exidx virtual address range overlaps with .hash
>   >>> .ARM.exidx range is [0x90, 0xCF]
>   >>> .hash range is [0xB4, 0xE3]
> 
>   ld.lld: error: section .ARM.exidx load address range overlaps with .hash
>   >>> .ARM.exidx range is [0x90, 0xCF]
>   >>> .hash range is [0xB4, 0xE3]
> 
> This was fixed in ld.lld 12 with a change to match GNU ld's semantics of
> placing non-SHF_ALLOC sections after SHF_ALLOC sections.
> 
> To workaround this issue, move the .ARM.exidx section before the
> .comment, .symtab, .strtab, and .shstrtab sections (ELF_DETAILS) so that
> those sections remain contiguous with the .ARM.attributes section.
> 
> Fixes: 5c4fb60816ea ("arm64: vdso32: add ARM.exidx* sections")

This should have been included to point out the exact commit that fixed
this in ld.lld, I can resend if necessary (since I also screwed up the
patches@lists.linux.dev domain...)

Link: https://github.com/llvm/llvm-project/commit/ec29538af2e0886a65f479d6a533956a1c478132

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/arm64/kernel/vdso32/vdso.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
> index 6e67a6524d58..c25bed8e6df1 100644
> --- a/arch/arm64/kernel/vdso32/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso32/vdso.lds.S
> @@ -56,8 +56,8 @@ SECTIONS
>  
>  	.rel.dyn	: { *(.rel*) }
>  
> -	ELF_DETAILS
>  	.ARM.exidx : { *(.ARM.exidx*) }
> +	ELF_DETAILS
>  	.ARM.attributes 0 : { *(.ARM.attributes) }
>  
>  	/DISCARD/	: {
> -- 
> 2.37.0
> 
