Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6C47E8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350253AbhLWUaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:30:09 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:33086 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350241AbhLWUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:30:08 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 15CB420A977E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 2/4] ata: pata_platform: Merge pata_of_platform into
 pata_platform
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221162614.25308-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <dc6c931f-493e-cb94-b62c-cb9b87e393ec@omp.ru>
Date:   Thu, 23 Dec 2021 23:30:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211221162614.25308-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/21/21 7:26 PM, Lad Prabhakar wrote:

> Merge the OF pata_of_platform driver into pata_platform. While doing so
> drop usage of platform_get_resource() and use platform_get_irq_optional().

   Sounds like you need a separate patch for doing that... 

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1-->v2
> * Dropped check for IRQ0
> * Dropped setting the irqflags as suggested by Rob
> * Set just the irq start
> * Fixed freeing up irq_res when not present in DT
> * Dropped PATA_OF_PLATFORM entry
> * Split up sorting of headers in separate patch
> * Dropped sht from struct pata_platform_priv
[...]
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index cb3134bf88eb..d1f7f4d65316 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
[...]
[...]
> @@ -108,15 +118,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>  	/*
>  	 * Check for MMIO
>  	 */
> -	mmio = (( io_res->flags == IORESOURCE_MEM) &&
> -		(ctl_res->flags == IORESOURCE_MEM));
> +	mmio = ((priv->io_res->flags == IORESOURCE_MEM) &&
> +		(priv->ctl_res->flags == IORESOURCE_MEM));
>  
>  	/*
>  	 * And the IRQ
>  	 */
> -	if (irq_res && irq_res->start > 0) {
> -		irq = irq_res->start;
> -		irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
> +	if (priv->irq_res && priv->irq_res->start > 0) {

   Can this start < 0 ever happen?

> +		irq = priv->irq_res->start;
> +		irq_flags = (priv->irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
>  	}
>  
>  	/*
[...]
> @@ -168,23 +178,81 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
[...]
> -static int pata_platform_probe(struct platform_device *pdev)
> +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
> +				      struct pata_platform_priv *priv)
>  {
> +	struct device_node *dn = ofdev->dev.of_node;
>  	struct resource *io_res;
>  	struct resource *ctl_res;
>  	struct resource *irq_res;
> +	int pio_mode = 0;
> +	int irq;
> +	int ret;
> +
> +	io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
> +	ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
> +	irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
> +	if (!io_res || !ctl_res || !irq_res)
> +		return -ENOMEM;
> +
> +	ret = of_address_to_resource(dn, 0, io_res);

   Why not switch to platform_mem_or_io() -- either before or after this patch?

> +	if (ret) {
> +		dev_err(&ofdev->dev, "can't get IO address from device tree\n");
> +		return -EINVAL;
> +	}
> +	priv->io_res = io_res;
> +
> +	ret = of_address_to_resource(dn, 1, ctl_res);

   Ditto.

> +	if (ret) {
> +		dev_err(&ofdev->dev, "can't get CTL address from device tree\n");
> +		return -EINVAL;
> +	}
> +	priv->ctl_res = ctl_res;
> +
> +	irq = platform_get_irq_optional(ofdev, 0);

   Contrariwise, either keep the old code and update it in pata_of_platform before
this patch or do it after this patch. Otherwise it seems somewhat inconsistent WRT
the of_address_to_resource() calls which you don't convert...

[...]
> @@ -198,32 +266,60 @@ static int pata_platform_probe(struct platform_device *pdev)
>  	/*
>  	 * Get the I/O base first
>  	 */
> -	io_res = platform_get_mem_or_io(pdev, 0);
> -	if (unlikely(!io_res))
> +	priv->io_res = platform_get_mem_or_io(pdev, 0);
> +	if (unlikely(!priv->io_res))

   As Damien said, you can drop unlikely() here...

>  		return -EINVAL;
>  
>  	/*
>  	 * Then the CTL base
>  	 */
> -	ctl_res = platform_get_mem_or_io(pdev, 1);
> -	if (unlikely(!ctl_res))
> +	priv->ctl_res = platform_get_mem_or_io(pdev, 1);
> +	if (unlikely(!priv->ctl_res))

   Ditto.

[...]

MBR, Sergey
