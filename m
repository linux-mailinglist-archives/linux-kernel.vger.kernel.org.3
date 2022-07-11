Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E356D874
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiGKIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGKIkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D409B21E30;
        Mon, 11 Jul 2022 01:40:07 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oAoxa-0006eA-02; Mon, 11 Jul 2022 10:40:06 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CB69DC0353; Mon, 11 Jul 2022 10:38:13 +0200 (CEST)
Date:   Mon, 11 Jul 2022 10:38:13 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: vdso: Utilize __pa() for gic_pfn
Message-ID: <20220711083813.GC6084@alpha.franken.de>
References: <20220707202759.1224809-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707202759.1224809-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 01:27:58PM -0700, Florian Fainelli wrote:
> The GIC user offset is mapped into every process' virtual address and is
> therefore part of the hot-path of arch_setup_additional_pages(). Utilize
> __pa() such that we are more optimal even when CONFIG_DEBUG_VIRTUAL is
> enabled, and while at it utilize PFN_DOWN() instead of open-coding the
> right shift by PAGE_SHIFT.
> 
> Reported-by: Greg Ungerer <gerg@kernel.org>
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/kernel/vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 3d0cf471f2fe..b2cc2c2dd4bf 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -159,7 +159,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	/* Map GIC user page. */
>  	if (gic_size) {
>  		gic_base = (unsigned long)mips_gic_base + MIPS_GIC_USER_OFS;
> -		gic_pfn = virt_to_phys((void *)gic_base) >> PAGE_SHIFT;
> +		gic_pfn = PFN_DOWN(__pa(gic_base));
>  
>  		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
>  					 pgprot_noncached(vma->vm_page_prot));
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
