Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3258749C09E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiAZBT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:19:29 -0500
Received: from mx.socionext.com ([202.248.49.38]:47317 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235763AbiAZBTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:19:16 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Jan 2022 10:19:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 67D592021818;
        Wed, 26 Jan 2022 10:19:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 26 Jan 2022 10:19:14 +0900
Received: from [10.212.180.162] (unknown [10.212.180.162])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 8A12CC1E22;
        Wed, 26 Jan 2022 10:19:13 +0900 (JST)
Subject: Re: [PATCH] spi: uniphier: fix reference count leak in
 uniphier_spi_probe()
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220125101214.35677-1-xiongx18@fudan.edu.cn>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <e3283f14-adf1-ac3c-3454-80ff68b7d71f@socionext.com>
Date:   Wed, 26 Jan 2022 10:19:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220125101214.35677-1-xiongx18@fudan.edu.cn>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/25 19:12, Xin Xiong wrote:
> The issue happens in several error paths in uniphier_spi_probe().
> When either dma_get_slave_caps() or devm_spi_register_master() returns
> an error code, the function forgets to decrease the refcount of both
> `dma_rx` and `dma_tx` objects, which may lead to refcount leaks.
> 
> Fix it by decrementing the reference count of specific objects in
> those error paths.

Looks good to me.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

And it is necessary to add the following line to this according to
Documentation/process/submitting-patches.rst.

Fixes: 28d1dddc59f6 ("spi: uniphier: Add DMA transfer mode support")

Thank you,

> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>   drivers/spi/spi-uniphier.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
> index 342ee8d2c..cc0da4822 100644
> --- a/drivers/spi/spi-uniphier.c
> +++ b/drivers/spi/spi-uniphier.c
> @@ -726,7 +726,7 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   		if (ret) {
>   			dev_err(&pdev->dev, "failed to get TX DMA
> capacities: %d\n",
>   				ret);
> -			goto out_disable_clk;
> +			goto out_release_dma;
>   		}
>   		dma_tx_burst = caps.max_burst;
>   	}
> @@ -735,7 +735,7 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   	if (IS_ERR_OR_NULL(master->dma_rx)) {
>   		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
>   			ret = -EPROBE_DEFER;
> -			goto out_disable_clk;
> +			goto out_release_dma;
>   		}
>   		master->dma_rx = NULL;
>   		dma_rx_burst = INT_MAX;
> @@ -744,7 +744,7 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   		if (ret) {
>   			dev_err(&pdev->dev, "failed to get RX DMA
> capacities: %d\n",
>   				ret);
> -			goto out_disable_clk;
> +			goto out_release_dma;
>   		}
>   		dma_rx_burst = caps.max_burst;
>   	}
> @@ -753,10 +753,20 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   
>   	ret = devm_spi_register_master(&pdev->dev, master);
>   	if (ret)
> -		goto out_disable_clk;
> +		goto out_release_dma;
>   
>   	return 0;
>   
> +out_release_dma:
> +	if (!IS_ERR_OR_NULL(master->dma_rx)) {
> +		dma_release_channel(master->dma_rx);
> +		master->dma_rx = NULL;
> +	}
> +	if (!IS_ERR_OR_NULL(master->dma_tx)) {
> +		dma_release_channel(master->dma_tx);
> +		master->dma_tx = NULL;
> +	}
> +
>   out_disable_clk:
>   	clk_disable_unprepare(priv->clk);
>   
> 

-- 
---
Best Regards
Kunihiko Hayashi
