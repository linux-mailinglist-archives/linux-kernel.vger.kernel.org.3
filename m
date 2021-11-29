Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E49461536
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbhK2MiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:38:12 -0500
Received: from elvis.franken.de ([193.175.24.41]:48748 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346202AbhK2MgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:36:11 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mrfq1-0005Wg-01; Mon, 29 Nov 2021 13:32:53 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 808DEC2FEA; Mon, 29 Nov 2021 13:32:18 +0100 (CET)
Date:   Mon, 29 Nov 2021 13:32:18 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: CPC: Use bitfield helpers
Message-ID: <20211129123218.GB8232@alpha.franken.de>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
 <35f0f17e3d987afaa9cd09cdcb8131d42a53c3e1.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f0f17e3d987afaa9cd09cdcb8131d42a53c3e1.1637593297.git.geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:53:46PM +0100, Geert Uytterhoeven wrote:
> Use the FIELD_PREP() helper, instead of open-coding the same operation.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> 
> See "[PATCH 00/17] Non-const bitfield helper conversions"
> (https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
> for background and more conversions.
> ---
>  arch/mips/kernel/mips-cpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> index 8d2535123f11c8f3..17aff13cd7ce6ea7 100644
> --- a/arch/mips/kernel/mips-cpc.c
> +++ b/arch/mips/kernel/mips-cpc.c
> @@ -4,6 +4,7 @@
>   * Author: Paul Burton <paul.burton@mips.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/errno.h>
>  #include <linux/percpu.h>
>  #include <linux/of.h>
> @@ -97,7 +98,7 @@ void mips_cpc_lock_other(unsigned int core)
>  	curr_core = cpu_core(&current_cpu_data);
>  	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
>  			  per_cpu(cpc_core_lock_flags, curr_core));
> -	write_cpc_cl_other(core << __ffs(CPC_Cx_OTHER_CORENUM));
> +	write_cpc_cl_other(FIELD_PREP(CPC_Cx_OTHER_CORENUM, core));
>  
>  	/*
>  	 * Ensure the core-other region reflects the appropriate core &
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
