Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C360656D871
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiGKIlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiGKIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:40:45 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8E3B21E26;
        Mon, 11 Jul 2022 01:40:07 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oAoxb-0006eA-00; Mon, 11 Jul 2022 10:40:07 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 59B68C0353; Mon, 11 Jul 2022 10:39:38 +0200 (CEST)
Date:   Mon, 11 Jul 2022 10:39:38 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, fancer.lancer@gmail.com,
        gerg@kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] MIPS: Enable ARCH_HAS_DEBUG_VIRTUAL for 64-bit
Message-ID: <20220711083938.GF6084@alpha.franken.de>
References: <20220707220428.1731083-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707220428.1731083-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:04:27PM -0700, Florian Fainelli wrote:
> Update __debug_virt_addr_valid() to check for a virtual address'
> validity below CKSSEG and remove the !64BIT dependency on
> ARCH_HAS_DEBUG_VIRTUAL to make DEBUG_VIRTUAL selectable.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> This requires the previous patch to be applied for this to work cleanly.
> 
>  arch/mips/Kconfig       | 2 +-
>  arch/mips/mm/physaddr.c | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index db09d45d59ec..ddb6bde8fa1f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -5,7 +5,7 @@ config MIPS
>  	select ARCH_32BIT_OFF_T if !64BIT
>  	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
>  	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 140000
> -	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
> +	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
> diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> index a82f8f57a652..3076238943d3 100644
> --- a/arch/mips/mm/physaddr.c
> +++ b/arch/mips/mm/physaddr.c
> @@ -31,7 +31,11 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
>  	if (x == MAX_DMA_ADDRESS)
>  		return true;
>  
> +#ifdef CONFIG_64BIT
> +	return KSEGX(x) < CKSSEG;

as KSEGX does 32bit casts, I have some doubts that this is correct.
What do I miss ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
