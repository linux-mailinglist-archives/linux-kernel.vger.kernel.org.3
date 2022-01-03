Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06848346F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiACP40 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 10:56:26 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55041 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiACP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:56:25 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B4AF9240004;
        Mon,  3 Jan 2022 15:56:21 +0000 (UTC)
Date:   Mon, 3 Jan 2022 16:56:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     kyungmin.park@samsung.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: onenand: Check for error irq
Message-ID: <20220103165620.2eadfc4c@xps13>
In-Reply-To: <20211224022321.1470969-1-jiasheng@iscas.ac.cn>
References: <20211224022321.1470969-1-jiasheng@iscas.ac.cn>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

jiasheng@iscas.ac.cn wrote on Fri, 24 Dec 2021 10:23:21 +0800:

> For the possible failure of the platform_get_irq(), the returned irq
> could be error number and will finally cause the failure of the
> request_irq().
> Consider that platform_get_irq() can now in certain cases return
> -EPROBE_DEFER, and the consequences of letting request_irq() effectively
> convert that into -EINVAL, even at probe time rather than later on.
> So it might be better to check just now.
> 
> Fixes: 26777d37216c ("mtd: Move onenand code base to drivers/mtd/nand/onenand")

This is not the root cause.

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
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

Otherwise looks fine.

Thanks,
Miquèl
