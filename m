Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5994D47D002
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbhLVKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhLVKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:30:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F48C061574;
        Wed, 22 Dec 2021 02:30:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F2E3B81054;
        Wed, 22 Dec 2021 10:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7085DC36AE5;
        Wed, 22 Dec 2021 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640169040;
        bh=8eRtn9R7D2SkOi593etkmaZGi65sMUskA/NqryVOrBc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kZ/No8CwZbWpAUp4QvtpAXKdXyXePi1yeAR2inSG57MGuPH95SUee5X2GJ+vo2RTu
         nwiQ0JRMzb+mlB/SVAiCXb+ezmrVSY86JasVOWacfBZrcNJUpO1oNInMWe42RPd/sd
         qh+ubBWlM4W6dpruCTDbGDAID/ItPSyxnljALV2TY9vpPtMaMsHl6fQgiIzgrrZq9o
         JJCcategoGGlnkhtN9zVr1Yx6uDL/vpo86dl8Fl7zl6FaE5d2pNQlVz4+1C1RlY5IA
         zss7U596MhopRvgDU+I3Lqmr3RciRVUewv6LM4YXckFu31yXy8E/DrnJGsy2LFDdRD
         4+P3xLMLQPf8A==
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Make use of the
 devm_platform_ioremap_resource()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-omap@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211221203916.18588-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221203916.18588-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <7b8882c1-a3ef-2cb4-ab2a-a367755cad85@kernel.org>
Date:   Wed, 22 Dec 2021 12:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221203916.18588-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

On 21/12/2021 22:39, Lad Prabhakar wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/memory/omap-gpmc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 56f401ba53a5..582fe102f923 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2492,7 +2492,6 @@ static int gpmc_probe(struct platform_device *pdev)
>  {
>  	int rc;
>  	u32 l;
> -	struct resource *res;
>  	struct gpmc_device *gpmc;
>  
>  	gpmc = devm_kzalloc(&pdev->dev, sizeof(*gpmc), GFP_KERNEL);
> @@ -2502,11 +2501,7 @@ static int gpmc_probe(struct platform_device *pdev)
>  	gpmc->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, gpmc);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENOENT;
> -
> -	gpmc_base = devm_ioremap_resource(&pdev->dev, res);
> +	gpmc_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(gpmc_base))
>  		return PTR_ERR(gpmc_base);
>  
> 

Thanks for the patch but this is already being taken care of by this patch
https://lore.kernel.org/lkml/20211221131757.2030-4-rogerq@kernel.org/T/#m9516df757d98049d769601ee4601005f74f3cec7

--
cheers,
-roger
