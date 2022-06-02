Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D29D53BC6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiFBQYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiFBQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:24:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B99183B8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ULsaBdzIjNY9UlBzRBFJHpbCyKR8X0rIBrR1eB+c08A=; b=G6WU1GUIS0iwi/bybRPUvGMkH8
        g5GmOalwZYTCL+uEuOPOL9Ux89HvrMgvXjEABpyhgivSYhw2lmEqEd5fgmT4jIzeJy1y9OTySFgqH
        JqkRLzW4neHF3cgs7JU6gqJ3qbJnJ0lNq6AT1HRkfZdt/+hVFyOWz7M1NlhyVNVpwJt6U+NEW29p4
        9CMUlbrXpWW7ZUlbyDy2I4FeRH9xhs0Z9CxbuvD+ZsDbKRJY0J36SeQ5xYfaVSHOtjf1juPwo1qm7
        n+jgwxOlHf9PE/dBVocOILMAQ8dE3mmmr5QG+6XEhh0kua1y2A1OU0lBI3G/zvbTaE2ukgLP8ASgf
        yTvVv60g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwncQ-0049hG-9P; Thu, 02 Jun 2022 16:24:18 +0000
Message-ID: <cc1a2594-3596-a8e6-077d-183e69e3f4e7@infradead.org>
Date:   Thu, 2 Jun 2022 09:24:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] riscv: Add Zawrs support for spinlocks
Content-Language: en-US
To:     Christoph Muellner <christoph.muellner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Muellner <christoph.muellner@vrull.io>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220602141032.169907-1-christoph.muellner@vrull.io>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220602141032.169907-1-christoph.muellner@vrull.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/2/22 07:10, Christoph Muellner wrote:
> The current RISC-V code uses the generic ticket lock implementation,
> that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
> Currently, RISC-V uses the generic implementation of these macros.
> This patch introduces a RISC-V specific implementation, of these
> macros, that peels off the first loop iteration and modifies the waiting
> loop such, that it is possible to use the WRS instruction of the Zawrs
> ISA extension to stall the CPU.
> 
> The resulting implementation of smp_cond_load_*() will only work for
> 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
> This is caused by the restrictions of the LR instruction (RISC-V only
> has LR.W and LR.D). Compiler assertions guard this new restriction.
> 
> This patch uses the existing RISC-V ISA extension framework
> to detect the presents of Zawrs at run-time.
> If available a NOP instruction will be replaced by WRS.
> A similar patch could add support for the PAUSE instruction of
> the Zihintpause ISA extension.
> 
> The whole mechanism is gated by Kconfig setting, which defaults to Y.
> 
> The Zawrs specification can be found here:
> https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> 
> Note, that the Zawrs extension is not frozen or ratified yet.
> Therefore this patch is an RFC and not intended to get merged.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@vrull.io>
> ---
>  arch/riscv/Kconfig                   | 10 +++
>  arch/riscv/include/asm/barrier.h     | 97 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h | 12 +++-
>  arch/riscv/include/asm/hwcap.h       |  3 +-
>  arch/riscv/kernel/cpu.c              |  1 +
>  arch/riscv/kernel/cpufeature.c       | 13 ++++
>  6 files changed, 133 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 905e550e0fd3..054872317d4a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -358,6 +358,16 @@ config RISCV_ISA_C
>  
>  	   If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_ZAWRS
> +	bool "Zawrs extension support"
> +	select RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the Zawrs extension
> +	   (wait for reservation set) and enable its usage.
> +
> +	   If you don't know what to do here, say Y.
> +

With this patch, it is possible to enable XIP_KERNEL and
RISCV_ISA_ZAWRS at the same time.  That causes a kconfig warning:

WARNING: unmet direct dependencies detected for RISCV_ALTERNATIVE
  Depends on [n]: !XIP_KERNEL [=y]
  Selected by [y]:
  - RISCV_ISA_ZAWRS [=y]
  - RISCV_ISA_SVPBMT [=y] && 64BIT [=y] && MMU [=y]

because RISCV_ALTERNATIVE depends on !XIP_KERNEL:

config RISCV_ALTERNATIVE
	bool
	depends on !XIP_KERNEL


>  config RISCV_ISA_SVPBMT
>  	bool "SVPBMT extension support"
>  	depends on 64BIT && MMU


-- 
~Randy
