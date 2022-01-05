Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA825485005
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiAEJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:29:22 -0500
Received: from elvis.franken.de ([193.175.24.41]:58347 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232432AbiAEJ3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:29:21 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n52be-0006hW-00; Wed, 05 Jan 2022 10:29:18 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 21937C0D5D; Wed,  5 Jan 2022 09:54:52 +0100 (CET)
Date:   Wed, 5 Jan 2022 09:54:52 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     cgel.zte@gmail.com
Cc:     maz@kernel.org, ilya.lipnitskiy@gmail.com, chi.minghao@zte.com.cn,
        ryazanov.s.a@gmail.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mips/pci: remove redundant ret variable
Message-ID: <20220105085452.GA5406@alpha.franken.de>
References: <20220104112024.601765-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104112024.601765-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:20:24AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from rt3883_pci_r32() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  arch/mips/pci/pci-rt3883.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
> index d3c947fa2969..e07ae098bdd8 100644
> --- a/arch/mips/pci/pci-rt3883.c
> +++ b/arch/mips/pci/pci-rt3883.c
> @@ -102,14 +102,12 @@ static u32 rt3883_pci_read_cfg32(struct rt3883_pci_controller *rpc,
>  			       unsigned func, unsigned reg)
>  {
>  	u32 address;
> -	u32 ret;
>  
>  	address = rt3883_pci_get_cfgaddr(bus, slot, func, reg);
>  
>  	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
> -	ret = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
>  
> -	return ret;
> +	return rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
>  }
>  
>  static void rt3883_pci_write_cfg32(struct rt3883_pci_controller *rpc,
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
