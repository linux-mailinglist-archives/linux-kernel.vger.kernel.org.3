Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACD4A4BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380250AbiAaQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:16:36 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50581 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380193AbiAaQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:16:14 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 77408C0002;
        Mon, 31 Jan 2022 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643645773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQZNpFwpLCJ2QyIMMCx53V4RScNFk6vSypQeECK4z4c=;
        b=NTnrvH4RJ0iYZUySnPLyEFtsw7hdyFpmXXaxYfRvf4A3oB2RQmWvP82HDlpnVT6zZDejcc
        yTFsBLtBz5DqIPbN+H06NMTb6Y7+uHUENEsCZvHZp492AHbg2rjLCFPLZpSRsZ8MvZjRRQ
        UZWGhs0QiHgHUn/8X4Y5ZwOoutcg4cRAlmQSrt3fWAyenVzewJ/5SlKAzeQAMRdrArCt4D
        D10feyLYD0zSL7OQriWl1VeVrZbKxPfQ0UEZpkr4RuJm8YyJHG0UHj6wER3s0Gz/kvab9L
        6RkRBbWqf07yn9B8QKjxLSYAR4KdniVXfMWbZsVj8pKFbayiVy1cebVNGquauw==
Date:   Mon, 31 Jan 2022 17:16:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: atmel: fix refcount issue in
 atmel_nand_controller_init
Message-ID: <20220131171606.2733d1a3@xps13>
In-Reply-To: <20220127084104.3683-1-xiongx18@fudan.edu.cn>
References: <20220127084104.3683-1-xiongx18@fudan.edu.cn>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

xiongx18@fudan.edu.cn wrote on Thu, 27 Jan 2022 16:41:05 +0800:

> The reference counting issue happens in several error handling paths
> on a refcounted object "nc->dmac". In these paths, the function simply
> returns the error code, forgetting to balance the reference count of
> "nc->dmac", increased earlier by dma_request_channel(), which may
> cause refcount leaks.
>=20
> Fix it by decrementing the refcount of specific object in those error
> paths.
>=20
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Co-developed-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Co-developed-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/n=
and/raw/atmel/nand-controller.c
> index f3276ee9e4fe..7003877632fb 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2060,13 +2060,15 @@ static int atmel_nand_controller_init(struct atme=
l_nand_controller *nc,
>  	nc->mck =3D of_clk_get(dev->parent->of_node, 0);
>  	if (IS_ERR(nc->mck)) {
>  		dev_err(dev, "Failed to retrieve MCK clk\n");
> -		return PTR_ERR(nc->mck);
> +		ret =3D PTR_ERR(nc->mck);
> +		goto out_release_dma;
>  	}
> =20
>  	np =3D of_parse_phandle(dev->parent->of_node, "atmel,smc", 0);
>  	if (!np) {
>  		dev_err(dev, "Missing or invalid atmel,smc property\n");
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto out_release_dma;
>  	}
> =20
>  	nc->smc =3D syscon_node_to_regmap(np);
> @@ -2074,10 +2076,20 @@ static int atmel_nand_controller_init(struct atme=
l_nand_controller *nc,
>  	if (IS_ERR(nc->smc)) {
>  		ret =3D PTR_ERR(nc->smc);
>  		dev_err(dev, "Could not get SMC regmap (err =3D %d)\n", ret);
> -		return ret;
> +		goto out_release_dma;
>  	}
> =20
>  	return 0;
> +
> +out_release_dma:
> +	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
> +		if (!IS_ERR_OR_NULL(nc->dmac)) {

if (!nc->dmac) {

> +			dma_release_channel(nc->dmac);
> +			nc->dmac =3D NULL;

This is then unnecessary and the whole block and the two first checks
can then be ignored as dmac will not be set otherwise (and will stay
NULL).

> +		}
> +	}
> +
> +	return ret;
>  }
> =20
>  static int


Thanks,
Miqu=C3=A8l
