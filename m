Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2856D872
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiGKIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGKIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:40:45 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8F0921E2C;
        Mon, 11 Jul 2022 01:40:07 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oAoxa-0006eA-04; Mon, 11 Jul 2022 10:40:06 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 05592C0353; Mon, 11 Jul 2022 10:38:48 +0200 (CEST)
Date:   Mon, 11 Jul 2022 10:38:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, gerg@kernel.org,
        fancer.lancer@gmail.com, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220711083848.GE6084@alpha.franken.de>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707215237.1730283-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
> It is permissible for kernel code to call virt_to_phys() against virtual
> addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> types. Add a final condition that ensures that the virtual address is
> below KSEG2.
> 
> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/mm/physaddr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> index a1ced5e44951..a82f8f57a652 100644
> --- a/arch/mips/mm/physaddr.c
> +++ b/arch/mips/mm/physaddr.c
> @@ -5,6 +5,7 @@
>  #include <linux/mmdebug.h>
>  #include <linux/mm.h>
>  
> +#include <asm/addrspace.h>
>  #include <asm/sections.h>
>  #include <asm/io.h>
>  #include <asm/page.h>
> @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
>  	if (x == MAX_DMA_ADDRESS)
>  		return true;
>  
> -	return false;
> +	return KSEGX(x) < KSEG2;
>  }
>  
>  phys_addr_t __virt_to_phys(volatile const void *x)
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
