Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F0E477559
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhLPPHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:07:55 -0500
Received: from elvis.franken.de ([193.175.24.41]:50675 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235074AbhLPPHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:07:54 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mxsMK-0001iD-00; Thu, 16 Dec 2021 16:07:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E2724C0995; Thu, 16 Dec 2021 16:03:13 +0100 (CET)
Date:   Thu, 16 Dec 2021 16:03:13 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Bert Vermeulen <bert@biot.com>
Subject: Re: [PATCH] MIPS: drop selected EARLY_PRINTK configs for
 MACH_REALTEK_RTL
Message-ID: <20211216150313.GA15172@alpha.franken.de>
References: <20211215200602.6546-1-sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215200602.6546-1-sander@svanheule.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 09:06:02PM +0100, Sander Vanheule wrote:
> MACH_REALTEK_RTL declares that the system supports early printk , but
> this is not actually implemented as intended. The system is left with a
> non-functional early0 console because the setup_8250_early_printk_port()
> call provided for MIPS_GENERIC is never used to set this up. Generic
> ns16550a earlycon works, so devices should use that for early output.
> This means that SYS_HAS_EARLY_PRINTK and USE_GENERIC_EARLY_PRINTK_8250
> do not need to be selected.
> 
> Additionally, as reported by Lukas Bulwahn, the selected symbol
> SYS_HAS_EARLY_PRINTK_8250 does not actually exist, so should also be
> dropped.
> 
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Bert Vermeulen <bert@biot.com>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  arch/mips/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 63eb66a22691..9a3a2330fc69 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -642,9 +642,6 @@ config MACH_REALTEK_RTL
>  	select SYS_SUPPORTS_MIPS16
>  	select SYS_SUPPORTS_MULTITHREADING
>  	select SYS_SUPPORTS_VPE_LOADER
> -	select SYS_HAS_EARLY_PRINTK
> -	select SYS_HAS_EARLY_PRINTK_8250
> -	select USE_GENERIC_EARLY_PRINTK_8250
>  	select BOOT_RAW
>  	select PINCTRL
>  	select USE_OF
> -- 
> 2.33.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
