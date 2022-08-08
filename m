Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CE858C5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiHHJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbiHHJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:49:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D44DA13D5E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:49:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349CCD6E;
        Mon,  8 Aug 2022 02:49:35 -0700 (PDT)
Received: from [10.57.14.160] (unknown [10.57.14.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D0A33F70D;
        Mon,  8 Aug 2022 02:49:32 -0700 (PDT)
Message-ID: <baf39eb0-3115-eb25-9378-f4f99a0a00b3@arm.com>
Date:   Mon, 8 Aug 2022 10:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: disable FDPIC ABI
Content-Language: en-US
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220801191721.1253291-1-Ben.Wolsieffer@hefring.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20220801191721.1253291-1-Ben.Wolsieffer@hefring.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 20:17, Ben Wolsieffer wrote:
> When building with an arm-*-uclinuxfdpiceabi toolchain, the FDPIC ABI is
> enabled by default but should not be used to build the kernel.
> Therefore, pass -mno-fdpic if supported by the compiler.
> 
> Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
> ---
>  arch/arm/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c8e3633f5434..88be49b71d40 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -22,6 +22,9 @@ GZFLAGS		:=-9
>  # Never generate .eh_frame
>  KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
>  
> +# Disable FDPIC ABI
> +KBUILD_CFLAGS	+= $(call cc-option,-mno-fdpic)
> +
>  # This should work on most of the modern platforms
>  KBUILD_DEFCONFIG := multi_v7_defconfig
>  

Without patch I'm getting

scripts/link-vmlinux.sh: line 52: 312779 Segmentation fault      (core dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive ${objs} ${wl}--no-whole-archive ${wl}--start-group ${libs} ${wl}--end-group $@ ${ldlibs}

So, FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Unless you get any other comments, please, drop it into RMK's patch system [1].
 
[1] https://www.armlinux.org.uk/developer/patches/

P.S. 
Extra thanks for Buildroot patches, they were handy to build FDPIC toolchain and
test the patch!

Cheers
Vladimir
