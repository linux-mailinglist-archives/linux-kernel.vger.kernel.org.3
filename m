Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570FE484471
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiADPVu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jan 2022 10:21:50 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:49421 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiADPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:21:49 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0D16C200005;
        Tue,  4 Jan 2022 15:21:47 +0000 (UTC)
Date:   Tue, 4 Jan 2022 16:21:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     kyungmin.park@samsung.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: onenand: Check for error irq
Message-ID: <20220104162146.38c41e06@xps13>
In-Reply-To: <20220104145854.1987853-1-jiasheng@iscas.ac.cn>
References: <20220104145854.1987853-1-jiasheng@iscas.ac.cn>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

jiasheng@iscas.ac.cn wrote on Tue,  4 Jan 2022 22:58:54 +0800:

> As it is possible that there is no suitable irq, platform_get_irq()
> will return error number.

             an

> Therefore, it might be better to check it and return error if fails

                                                      an        failed

> to guarantee the success of the probe.

in order to

Actually in case of error it will not guarantee the success of the
probe so I'm not sure what you are trying to solve here?

Either the irq is mandatory and you may want to check its presence
earlier, or it is not mandatory and you could use get_irq_optional()
maybe.

> Fixes: 26777d37216c ("mtd: Move onenand code base to drivers/mtd/nand/onenand")

This Fixes tag is still wrong.

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2
> 
> * Change 1. Change the commit message.
> ---
>  drivers/mtd/nand/onenand/generic.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/onenand/generic.c b/drivers/mtd/nand/onenand/generic.c
> index 8b6f4da5d720..a4b8b65fe15f 100644
> --- a/drivers/mtd/nand/onenand/generic.c
> +++ b/drivers/mtd/nand/onenand/generic.c
> @@ -53,7 +53,12 @@ static int generic_onenand_probe(struct platform_device *pdev)
>  	}
>  
>  	info->onenand.mmcontrol = pdata ? pdata->mmcontrol : NULL;
> -	info->onenand.irq = platform_get_irq(pdev, 0);
> +
> +	err = platform_get_irq(pdev, 0);
> +	if (err < 0)
> +		goto out_iounmap;
> +
> +	info->onenand.irq = err;
>  
>  	info->mtd.dev.parent = &pdev->dev;
>  	info->mtd.priv = &info->onenand;


Thanks,
Miquèl
