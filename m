Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21F480491
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhL0UgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:36:08 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:42196 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhL0UgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:36:07 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 1DB5C20B3A29
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 07/10] ata: pata_platform: Merge pata_of_platform into
 pata_platform
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <53445984-2fc4-ea3c-b499-5575c7de2f6f@omp.ru>
Date:   Mon, 27 Dec 2021 23:36:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/21 4:12 PM, Lad Prabhakar wrote:

> Merge the OF pata_of_platform driver into pata_platform.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[...]
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index f500f631f72b..4273f1a9abd2 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
[...]
>  	/*
>  	 * And the IRQ
>  	 */
> -	if (irq_res) {
> -		irq = irq_res->start;
> -		irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
> +	if (priv->irq_res && priv->irq_res->start > 0) {

    I thought you've just dropped the > 0 check?

[...]
> @@ -168,46 +177,34 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>  
>  	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
>  
> -	pata_platform_setup_port(&ap->ioaddr, ioport_shift);
> +	pata_platform_setup_port(&ap->ioaddr, priv->ioport_shift);
>  
>  	ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
> -		      (unsigned long long)io_res->start,
> -		      (unsigned long long)ctl_res->start);
> +		      (unsigned long long)priv->io_res->start,
> +		      (unsigned long long)priv->ctl_res->start);

   As Andy has noted, these could be converted to %pR (but only after this patch)...

[...]
> @@ -216,21 +213,108 @@ static int pata_platform_probe(struct platform_device *pdev)
>  	irq = platform_get_irq_optional(pdev, 0);
>  	if (irq < 0 && irq != -ENXIO)
>  		return irq;
> +
>  	if (irq > 0) {
> -		memset(&irq_res, 0x0, sizeof(struct resource));
> -		irq_res.start = irq;
> +		struct resource *irq_res;
> +
> +		irq_res = devm_kzalloc(&pdev->dev, sizeof(*irq_res), GFP_KERNEL);
> +		if (!irq_res)
> +			return -ENOMEM;
> +
> +		irq_res->start = irq;
> +		priv->irq_res = irq_res;

   Is that enough? Flags not needed?

[...]
> +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
> +				      struct pata_platform_priv *priv)

   Can I suggest another name, like pata_platform_parse_dt()?

[...]
> +static int pata_platform_get_pdata(struct platform_device *pdev,
> +				   struct pata_platform_priv *priv)

   Can I suggest another name, like pata_platform_init_pdata()?

> +{
> +	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
> +	int ret;
> +
> +	/*
> +	 * Simple resource validation ..
> +	 */
> +	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
> +		dev_err(&pdev->dev, "invalid number of resources\n");
> +		return -EINVAL;
> +	}

   Hm, do we really need this check? If we drop it beforehand, we could call
pata_platform_get_resources() only once (and expand it inline?).

> +
> +	ret = pata_platform_get_resources(pdev, priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->ioport_shift = pp_info ? pp_info->ioport_shift : 0;
> +	priv->pio_mask = pio_mask;
> +	priv->use16bit = false;
> +
> +	return 0;
> +}
> +
[...]

MBR, Sergey
