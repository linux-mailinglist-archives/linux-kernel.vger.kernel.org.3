Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1713247965F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhLQVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:38:30 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:34336 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhLQVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:38:28 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7612920D755E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 2/2] ata: pata_platform: Merge pata_of_platform into
 pata_platform
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b94e0a92-1995-926c-95df-17365f03eed0@omp.ru>
Date:   Sat, 18 Dec 2021 00:38:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 12/17/21 5:17 PM, Lad Prabhakar wrote:

> Merge the OF pata_of_platform driver into pata_platform.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index a7da8ea7b3ed..0fab5cae45d5 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1122,7 +1122,8 @@ config PATA_PLATFORM
>  
>  config PATA_OF_PLATFORM
>  	tristate "OpenFirmware platform device PATA support"
> -	depends on PATA_PLATFORM && OF
> +	depends on OF
> +	select PATA_PLATFORM
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems with OpenFirmware

   Hm, why in the world you're keeping this Konfig entry? You doint even use it
anywhere... :-/

[...]
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index cb3134bf88eb..b8d8d51bc562 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
> @@ -11,21 +11,42 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/blkdev.h>
> -#include <scsi/scsi_host.h>
>  #include <linux/ata.h>
> +#include <linux/ata_platform.h>
> +#include <linux/blkdev.h>
> +#include <linux/kernel.h>
>  #include <linux/libata.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
> -#include <linux/ata_platform.h>
> +#include <scsi/scsi_host.h>

   I'd make the sorting of the #include's a separate patch...

[...]
> +/**
> + * struct pata_platform_priv - Private info
> + * @io_res: Resource representing I/O base
> + * @ctl_res: Resource representing CTL base
> + * @irq_res: Resource representing IRQ and its flags
> + * @ioport_shift: I/O port shift
> + * @mask: PIO mask
> + * @sht: scsi_host_template to use when registering
> + * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> + */
> +struct pata_platform_priv {
> +	struct resource *io_res;
> +	struct resource *ctl_res;
> +	struct resource *irq_res;
> +	unsigned int ioport_shift;
> +	int mask;

   Why not pio_mask?

> +	struct scsi_host_template *sht;
> +	bool use16bit;
> +};
>  
>  /*
>   * Provide our own set_mode() as we don't want to change anything that has
[...]
> @@ -168,23 +180,83 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
[...]
>  
> -static int pata_platform_probe(struct platform_device *pdev)
> +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
> +				      struct pata_platform_priv *priv)
>  {
> -	struct resource *io_res;
> +	struct device_node *dn = ofdev->dev.of_node;
>  	struct resource *ctl_res;
>  	struct resource *irq_res;
> +	struct resource *io_res;

   Should be declared before ctl_res...


> +	int pio_mode = 0;
> +	int irq;
> +	int ret;
> +
> +	ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
> +	io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
> +	irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
> +	if (!ctl_res || !io_res || !irq_res)
> +		return -ENOMEM;

   Can't we get away from these allocated resources? Or at least irq_res?

[...]
> +	priv->use16bit = of_property_read_bool(dn, "ata-generic,use16bit");
> +
> +	priv->mask = 1 << pio_mode;
> +	priv->mask |= (1 << pio_mode) - 1;

   You can make use of GENMASK(pio_mode, 0), in a separate pre-patch (or post-patch?).

[...]
> @@ -198,32 +270,63 @@ static int pata_platform_probe(struct platform_device *pdev)
[...]
> +static int pata_platform_probe(struct platform_device *pdev)
> +{
> +	struct pata_platform_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (!dev_of_node(&pdev->dev))
> +		ret = pata_platform_get_pdata(pdev, priv);
> +	else
> +		ret = pata_of_platform_get_pdata(pdev, priv);
> +

   No need for empty line here...

> +	if (ret)
> +		return ret;
> +
> +	priv->sht = &pata_platform_sht;

   Aren't those structures identical between the formerly separate drivers?

[...]

MBR, Sergey
