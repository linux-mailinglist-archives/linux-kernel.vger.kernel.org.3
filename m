Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3206547AA66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhLTNcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:32:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55078 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhLTNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:32:03 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKDVkKh032531;
        Mon, 20 Dec 2021 07:31:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640007106;
        bh=5Xojthp86AJPaaXIqo7bpdpUtIVJBB4beqVhAYVWPmY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=m6x5oO5rFQzL7oRKY0b2681tm5TN8vEsXyNhyFDNyWClWzsK1gtRNRVPSYdF6j3va
         fPXbbrXCY7ibk6fx2bPoALMHzh7Ri+JcmxCL84e2jdlp/tEhrQ4F4UYnyhUIdO/sYA
         DmSsvJPrvdymW+wLjfm6WErMr66tFzENq4EIA/Ls=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKDVkMB115486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 07:31:46 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 07:31:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 07:31:46 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKDVjhM041337;
        Mon, 20 Dec 2021 07:31:45 -0600
Date:   Mon, 20 Dec 2021 07:31:45 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <SantoshShilimkarssantosh@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: smartreflex: Use platform_get_irq_optional() to
 get the interrupt
Message-ID: <20211220133145.uiww2nuormjks7gc@unruly>
References: <20211218153943.28014-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211218153943.28014-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:39-20211218, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
> 
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers,
> Prabhakar
> ---
>  drivers/soc/ti/smartreflex.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> index b5b2fa538d5c..4f311e00fa46 100644
> --- a/drivers/soc/ti/smartreflex.c
> +++ b/drivers/soc/ti/smartreflex.c
> @@ -819,7 +819,7 @@ static int omap_sr_probe(struct platform_device *pdev)
>  {
>  	struct omap_sr *sr_info;
>  	struct omap_sr_data *pdata = pdev->dev.platform_data;
> -	struct resource *mem, *irq;
> +	struct resource *mem;
>  	struct dentry *nvalue_dir;
>  	int i, ret = 0;
>  
> @@ -844,7 +844,12 @@ static int omap_sr_probe(struct platform_device *pdev)
>  	if (IS_ERR(sr_info->base))
>  		return PTR_ERR(sr_info->base);
>  
> -	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	ret = platform_get_irq_optional(pdev, 0);
> +	if (ret <= 0 && ret != -ENXIO)
> +		return ret ? ret : -ENXIO;
^^ minor: This is a better check compared to what existed, might be good
to add that to commit message, also does this cause the driver to fail
probe silently?

> +	if (ret > 0)
> +		sr_info->irq = ret;
> +	ret = 0;
>  
>  	sr_info->fck = devm_clk_get(pdev->dev.parent, "fck");
>  	if (IS_ERR(sr_info->fck))
> @@ -870,9 +875,6 @@ static int omap_sr_probe(struct platform_device *pdev)
>  	sr_info->autocomp_active = false;
>  	sr_info->ip_type = pdata->ip_type;
>  
> -	if (irq)
> -		sr_info->irq = irq->start;
> -
>  	sr_set_clk_length(sr_info);
>  
>  	list_add(&sr_info->node, &sr_list);
> -- 
> 2.17.1
> 

Otherwise, looks fine to me. but it is a little late since I have sent out my
5.17 PR. We can try for rc OR 5.18.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
