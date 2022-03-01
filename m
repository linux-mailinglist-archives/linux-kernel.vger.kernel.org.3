Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC024C8719
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiCAIv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiCAIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:51:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35558931F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:50:46 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AA7871F43F9D;
        Tue,  1 Mar 2022 08:50:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646124644;
        bh=0ZrsARjiH24wsElmcwQCEqvABOocHSYJJ1IUet5VHj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VkssrVfGYwFWa86K5JP4dvVJi6C+6lIuwJgIlWE43OPqM0Jkp6M9+FhyeHzetVEl+
         GHv/S5dgJcAckf4Rz8kTvMI3l2e5f8DT3pWg6E9FH0/dMdwYbVh3DloQHKlmplgNrl
         /OS4LXT69IGzmAt7ExHejLoZJgKgThPU/lkUtaI3B1X8gsNlxdIrX/2m3NQApgnQ9s
         O7VmwhqHFJ0gpWAB6+nSGvaOOTp/YOQwllykSHbIkN/HgNEHhmUQyObYJGUj+vP1Ua
         w61pUvqu9bVvZlIXtQ7a3Nw/3CJkFwNzfWJj0KB7IwvU14dF5AExlse8rU/ajiY6Zm
         YPGpFHL9UWlOQ==
Date:   Tue, 1 Mar 2022 09:50:37 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: atmel: fix refcount issue in
 atmel_nand_controller_init
Message-ID: <20220301095037.1763e051@collabora.com>
In-Reply-To: <20220301044556.36162-1-xiongx18@fudan.edu.cn>
References: <20220301044556.36162-1-xiongx18@fudan.edu.cn>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Mar 2022 12:45:56 +0800
Xin Xiong <xiongx18@fudan.edu.cn> wrote:

> The reference counting issue happens in several error handling paths
> on a refcounted object "nc->dmac". In these paths, the function simply
> returns the error code, forgetting to balance the reference count of
> "nc->dmac", increased earlier by dma_request_channel(), which may
> cause refcount leaks.
> 
> Fix it by decrementing the refcount of specific object in those error
> paths.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Co-developed-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Co-developed-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> ---
> V1 -> V2: Rewrited the error handling block
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index f3276ee9e4fe..0efeb5d77be0 100644
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
> +		goto out_release_dma;
>  	}
>  
>  	nc->smc = syscon_node_to_regmap(np);
> @@ -2074,10 +2076,20 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>  	if (IS_ERR(nc->smc)) {
>  		ret = PTR_ERR(nc->smc);
>  		dev_err(dev, "Could not get SMC regmap (err = %d)\n", ret);
> -		return ret;
> +		goto out_release_dma;
>  	}
>  
>  	return 0;
> +
> +out_release_dma:
> +	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
> +		if (nc->dmac) {
> +			dma_release_channel(nc->dmac);
> +			nc->dmac = NULL;
> +		}
> +	}

Nit:

	if (nc->dmac)
		dma_release_channel(nc->dmac);

should work just fine.

> +
> +	return ret;
>  }
>  
>  static int

