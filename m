Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF14A6408
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiBASgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbiBASgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:36:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B7C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:36:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i17so16608405pfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=au2QIv+E5efC5CXFBVtN3Dhp88XfEH66mYp3WFA4dy4=;
        b=OzqPatId9hYU/kdkYqwdo5N/t94vb8Ym5n0MeDAweVjIrNJGKqFDYpfOoGn4KTTXF8
         noDYko8zN7lX1ZB7fGgPTZkr0TSwJu/mew/BoFxZBhqE2IbOvlHEtl3wmg1k37OT3Fqj
         AhAVEXOhTkOr8jQOqokKKuob/1cSiiPXF8Zzc5WMDwW2veUtNn9NSPNhTqmkRlgXjV+w
         nm1z4SHN8UBQ/Knm+oWMOq6z+3ch9FiDl02rAKZIz3Jp+1VaexPZh7k8uJbeMfGVbA7B
         57nJhQELFRgndRbftgkPLN9gCUqzFhUHQmQ4UBNpu7+GNBCVo1vmiPsg8UJGU6RObBVa
         n0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=au2QIv+E5efC5CXFBVtN3Dhp88XfEH66mYp3WFA4dy4=;
        b=bm7SvNH8PGURI4EPE1efMemSG/T5LgRhe3y7q49ODrVdV/H7HLRXxIwqKwEDJ1O8i2
         RSCNs2g0O7Pku633HqjMtjmhg30qgEQg+tPF/KsOjoQDVHcK69sW/7l4RmQ1UIUYV/wh
         viqqLAnUC1Ts1Q+q9y/WcY34kl18o4ZZQ8/boaoRCCMkRZmwYDkgMWLyTTMlUGYPMR3c
         mqs/4SlmTobxV2Bs8bzKQzlytT54amcRC/k2Y2pK4co3GuTXwStTr3qrG67TGfoEnEWH
         aTayfwiZZHXanNyI7Xz9OVWAITJVYo9+wjv2VWMeecqV+G7pImWB1AHoFDkOlvXhtsw1
         MR7A==
X-Gm-Message-State: AOAM531X4AGrTwY50HBHOF9MlSd6ikdxvdT1Xt81Mpdcr/YM0xdaJLMP
        nGoDbLvPKVelmDr7PSLb5eRY5w==
X-Google-Smtp-Source: ABdhPJyXfaqwD+jsdqC62UNTBL+nVsylPRncm6pguROBuW/H6mEZXGhxRAt2QA3tJqSx++YfbZqvtg==
X-Received: by 2002:a63:6885:: with SMTP id d127mr12149556pgc.470.1643740575558;
        Tue, 01 Feb 2022 10:36:15 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k21sm22861321pff.33.2022.02.01.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:36:14 -0800 (PST)
Date:   Tue, 1 Feb 2022 11:36:12 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 3/3] remoteproc: mtk_scp: Use dev_err_probe() where
 possible
Message-ID: <20220201183612.GC2490199@p14s>
References: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
 <20220124120915.41292-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124120915.41292-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Mon, Jan 24, 2022 at 01:09:15PM +0100, AngeloGioacchino Del Regno wrote:
> Simplify the probe function, where possible, by using dev_err_probe().
> While at it, as to increase human readability, also remove some
> unnecessary forced void pointer casts that were previously used in
> error checking.

I am in favour of all 3 patches (please add a cover letter next time) but weary
about testing - do you have access to a Mediatek platform to try this on or
is it purely theoretical?

I would definitely feel better to see a "Tested-by" tag by someone out there
with access to the HW.

Thanks,
Mathieu

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index e40706b0e015..dcddb33e9997 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -757,10 +757,8 @@ static int scp_probe(struct platform_device *pdev)
>  	int ret, i;
>  
>  	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
> -	if (!rproc) {
> -		dev_err(dev, "unable to allocate remoteproc\n");
> -		return -ENOMEM;
> -	}
> +	if (!rproc)
> +		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
>  
>  	scp = (struct mtk_scp *)rproc->priv;
>  	scp->rproc = rproc;
> @@ -770,21 +768,20 @@ static int scp_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
>  	scp->sram_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR((__force void *)scp->sram_base)) {
> -		dev_err(dev, "Failed to parse and map sram memory\n");
> -		return PTR_ERR((__force void *)scp->sram_base);
> -	}
> +	if (IS_ERR(scp->sram_base))
> +		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
> +				     "Failed to parse and map sram memory\n");
> +
>  	scp->sram_size = resource_size(res);
>  	scp->sram_phys = res->start;
>  
>  	/* l1tcm is an optional memory region */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
>  	scp->l1tcm_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR((__force void *)scp->l1tcm_base)) {
> -		ret = PTR_ERR((__force void *)scp->l1tcm_base);
> +	if (IS_ERR(scp->l1tcm_base)) {
> +		ret = PTR_ERR(scp->l1tcm_base);
>  		if (ret != -EINVAL) {
> -			dev_err(dev, "Failed to map l1tcm memory\n");
> -			return ret;
> +			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
>  		}
>  	} else {
>  		scp->l1tcm_size = resource_size(res);
> @@ -792,10 +789,9 @@ static int scp_probe(struct platform_device *pdev)
>  	}
>  
>  	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> -	if (IS_ERR((__force void *)scp->reg_base)) {
> -		dev_err(dev, "Failed to parse and map cfg memory\n");
> -		return PTR_ERR((__force void *)scp->reg_base);
> -	}
> +	if (IS_ERR(scp->reg_base))
> +		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
> +				     "Failed to parse and map cfg memory\n");
>  
>  	ret = scp->data->scp_clk_get(scp);
>  	if (ret)
> -- 
> 2.33.1
> 
