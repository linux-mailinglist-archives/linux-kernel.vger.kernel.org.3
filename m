Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6103249BACC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387290AbiAYR6Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 12:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351511AbiAYR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:56:03 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC5C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:56:02 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F0870FF803;
        Tue, 25 Jan 2022 17:55:57 +0000 (UTC)
Date:   Tue, 25 Jan 2022 18:55:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: atmel: fix refcount leaks in
 atmel_nand_controller_init
Message-ID: <20220125185556.6afb7eba@xps13>
In-Reply-To: <20220125123155.36891-1-xiongx18@fudan.edu.cn>
References: <20220125123155.36891-1-xiongx18@fudan.edu.cn>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

xiongx18@fudan.edu.cn wrote on Tue, 25 Jan 2022 20:31:56 +0800:

> The reference counting issue happens in several error handling paths
> on a refcounted object "nc->dmac". In these paths, the function simply
> returns the error code, forgetting to balance the reference count
> increased earlier by dma_request_channel(), which may cause refcount
> leaks. What's more, the "nc->mck" object also needs to be handled
> correctly.

You might want to split this into two commits.

> 
> Fix it by adding specific error handling code in those error paths.

You need a Fixes tag here.

> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

You can't do that. The patch is rather straightforward, so 3
authorship seem a little bit too much.

If someone suggested you a change, or sent you a proposal, you should
use a Suggested-by. If it was reported by a colleague, use Reported-by.
If it was co-developped, use the right tag and the right Signed-off-by
as documented in the submitted-process.rst file. If you picked the
patch from someone else, you must preserve the authorship and just add
your SoB.

> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 22 +++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index f3276ee9e..b3801ebd2 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2060,13 +2060,15 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>  	nc->mck = of_clk_get(dev->parent->of_node, 0);
>  	if (IS_ERR(nc->mck)) {
>  		dev_err(dev, "Failed to retrieve MCK clk\n");
> -		return PTR_ERR(nc->mck);
> +		ret = PTR_ERR(nc->mck);
> +		goto out_release_dma;
>  	}
>  
>  	np = of_parse_phandle(dev->parent->of_node, "atmel,smc", 0);
>  	if (!np) {
>  		dev_err(dev, "Missing or invalid atmel,smc property\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_put_clk;
>  	}
>  
>  	nc->smc = syscon_node_to_regmap(np);
> @@ -2074,10 +2076,24 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>  	if (IS_ERR(nc->smc)) {
>  		ret = PTR_ERR(nc->smc);
>  		dev_err(dev, "Could not get SMC regmap (err = %d)\n", ret);
> -		return ret;
> +		goto out_put_clk;
>  	}
>  
>  	return 0;
> +
> +out_put_clk:
> +	clk_put(nc->mck);
> +	nc->mck = NULL;
> +
> +out_release_dma:
> +	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
> +		if (!IS_ERR_OR_NULL(nc->dmac)) {

	   && !IS_ERR...

> +			dma_release_channel(nc->dmac);
> +			nc->dmac = NULL;
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  static int


Thanks,
Miquèl
