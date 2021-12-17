Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1592478135
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhLQAXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:23:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24073 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhLQAXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639700625; x=1671236625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQ6Kpy2HPH6xl4gMSUs5ik1YmyfyPdpEY2+hjik4JjA=;
  b=S6KyDFa7k6iw+AsBkGWjITixc6VT9xMzkGn07qJ3flUhJpVelw7Xyj1S
   0xudHESbrZ4eE1rL2q1wds98LmVwJrWe9nhZXfpadTeW9F1mYzWm3Tgqy
   rj1j3aUBFUZo1oLjlDaGVT0DyUvion1sabaCZHq7CGPkyUCZ5oqL+GPzt
   odHjkxisnOvM2wGgrXGZK33s16FYgMR4hSrIC04pRtKBaIW1JQNCvjTbM
   vrKOR68bjULevjgmYgpEVICqD45tlmHWlPsAAaGY6AVddk4fb/b9PzaJm
   LftC7D/k+K/FubungiEc47rIxPfThAdD+PbwZmlLsocJEsv2FR7FbADn6
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,212,1635177600"; 
   d="scan'208";a="300307901"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 08:23:45 +0800
IronPort-SDR: C2hT7AZqChbSjeDIlmLcYMzdZwj/FRCvpatFLxPAvDmiz87V8TsHARtfpHn8WuPDemeSbupUGz
 0FQc5tLIKQLXUXkhb2Bon/70ZcXj5UzdkMDfmxi0AHkGkSfXye0TTTjyus64KndfOL7ObG3wbd
 GLwdgOg2lSa1NAGHKjZoE/YxtEedXfRMqg650jjsjxzBcwdP+3iaawNiQszerU/d+M0c0ExmY3
 vCLJMQutKaKl0s4/6aCif//bFmeIqTSq5cktOPzCPgkfY0XFuo1pPPVkEdduQ7Cf9z45e6u5kK
 qKj3aDrZXwi6ZhNonT/3K32w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 15:56:39 -0800
IronPort-SDR: XcJ8rmmtrdpjbrOu76lhmb+gBsJtacsAf6JlZwJ5gzUFwlwVV6NQwcqZ9fLKBgg0/SMaESdPGu
 ty091GAFD9mSS3GBp0Zdl3sC8kh7sVEBOcj7ga08fKIcvT0LNJjD64hRovBsGzfNYP6al+v9ZU
 VWrNgsKOCUY945Bd0SV9mKXydPRzZkWn7h6Q/7kulofEeqC1Ww7UoP1Ui5NCJZm9daVr3dRkqP
 tRK3ee3BNl4+QgjWTYC4x6qCcD9hqTUhRViqnKm860X2AoTMuc+qfPBncR2pdtqpwrWi1N2bnO
 3yQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:23:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JFV8K1fSlz1RvTh
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:23:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639700624; x=1642292625; bh=tQ6Kpy2HPH6xl4gMSUs5ik1YmyfyPdpEY2+
        hjik4JjA=; b=C4vl5x4MjowydunGkdrnkXMTmP+DxqtzbwjMu5pDrZSTcMxSJNE
        OOzGwTXnA7tdnk5W87CxnGbbjRS5suq5E2YSmisLrPx6yJcNQAF2Ih8L6AVoV2zy
        Xl5uWt9GMEyId9U5jeBg+PrXAK7lCgSxepxIbO5MCGHnVeslNG4qlJLboOAm2M5o
        mR/TZGOw1DchIV+08bqjDWKlutVtum5UMBJDHyoTZT67JUlTs6vWVibFt79CWfxh
        lr6zI0kjdS3bFkW3q+bEIubA/zVHuJ05VE8pyiGNdDFl94IQvRmD3UW6o/IcGIXJ
        QgqSEumm8DzinVHpZXm11rxDQKO6qtUaVpw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EVlQvBw5RBWm for <linux-kernel@vger.kernel.org>;
        Thu, 16 Dec 2021 16:23:44 -0800 (PST)
Received: from [10.225.163.18] (unknown [10.225.163.18])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JFV8H5nvxz1RtVG;
        Thu, 16 Dec 2021 16:23:43 -0800 (PST)
Message-ID: <d25d6c6f-098a-1dbc-0c85-00f97f491e99@opensource.wdc.com>
Date:   Fri, 17 Dec 2021 09:23:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to
 populate IRQ resource
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 09:12, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the

s/bypassed/bypasses
s/messed/messes

> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use of_irq_to_resource().
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
>  drivers/ata/pata_of_platform.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 35aa158fc976..557f349eb533 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/libata.h>
> @@ -25,11 +26,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  	struct device_node *dn = ofdev->dev.of_node;
>  	struct resource io_res;
>  	struct resource ctl_res;
> -	struct resource *irq_res;
> +	struct resource irq_res;
>  	unsigned int reg_shift = 0;
>  	int pio_mode = 0;
>  	int pio_mask;
>  	bool use16bit;
> +	int irq;
>  
>  	ret = of_address_to_resource(dn, 0, &io_res);
>  	if (ret) {
> @@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  		return -EINVAL;
>  	}
>  
> -	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> +	irq = of_irq_to_resource(dn, 0, &irq_res);
> +	if (irq <= 0 && irq != -ENXIO)
> +		return irq ? irq : -ENXIO;

Why are you making an exception for ENXIO ? I suspect this is to cover
the case "there is no IRQ for this node", but then how does this
differentiate from a real error case ?

>  
>  	of_property_read_u32(dn, "reg-shift", &reg_shift);
>  
> @@ -63,7 +67,8 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  	pio_mask = 1 << pio_mode;
>  	pio_mask |= (1 << pio_mode) - 1;
>  
> -	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
> +	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res,
> +				     irq > 0 ? &irq_res : NULL,
>  				     reg_shift, pio_mask, &pata_platform_sht,
>  				     use16bit);
>  }
> 


-- 
Damien Le Moal
Western Digital Research
