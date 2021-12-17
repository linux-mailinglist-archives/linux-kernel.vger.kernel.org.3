Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D3478763
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhLQJdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:33:09 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:52466 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhLQJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:33:05 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 66E2420C509F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <ca168723-f113-8620-056d-ab2ee801d8fe@omp.ru>
Date:   Fri, 17 Dec 2021 12:32:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to
 populate IRQ resource
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 17.12.2021 3:12, Lad Prabhakar wrote:

> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
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
>   drivers/ata/pata_of_platform.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 35aa158fc976..557f349eb533 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
[...]
> @@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>   		return -EINVAL;
>   	}
>   
> -	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> +	irq = of_irq_to_resource(dn, 0, &irq_res);

    Why not use platform_get_irq_optional()?

> +	if (irq <= 0 && irq != -ENXIO)
> +		return irq ? irq : -ENXIO;
>   
>   	of_property_read_u32(dn, "reg-shift", &reg_shift);
>   
[...]

MBR, Sergey
