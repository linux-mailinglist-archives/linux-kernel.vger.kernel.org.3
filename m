Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA913480470
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 20:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhL0TsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 14:48:25 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:49628 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhL0TsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 14:48:23 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 0F2AC209BFA3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 03/10] ata: pata_of_platform: Use
 platform_get_irq_optional() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <320dfb50-e086-7d72-2a11-465e8e7444dd@omp.ru>
Date:   Mon, 27 Dec 2021 22:48:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211224131300.18198-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 12/24/21 4:12 PM, Lad Prabhakar wrote:

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
> v2-->v3
> * New patch
> ---
>  drivers/ata/pata_of_platform.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 35aa158fc976..2e2ec7d77726 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -25,11 +25,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
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
> @@ -45,7 +46,14 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  		return -EINVAL;
>  	}
>  
> -	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> +	irq = platform_get_irq_optional(ofdev, 0);
> +	if (irq < 0 && irq != -ENXIO)
> +		return irq;
> +
> +	if (irq > 0) {
> +		memset(&irq_res, 0x0, sizeof(struct resource));
> +		irq_res.start = irq;

   Is that really enough? Doesn't __pata_platform_probe() use irq_res->flags?

[...]

MBR, Sergey
