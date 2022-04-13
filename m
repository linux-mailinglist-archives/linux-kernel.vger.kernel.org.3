Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9914FF42C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiDMJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiDMJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:54:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C54ECD8;
        Wed, 13 Apr 2022 02:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49A6BB82161;
        Wed, 13 Apr 2022 09:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85992C385A4;
        Wed, 13 Apr 2022 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649843503;
        bh=8ts+Kz9ndNJjRtSXvOEj5iAcy0dAiFBVQaR1hMCq0jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPeZ7wdVTWbFywyfLoz0s2gLEIzH1+pavbNZXUPU4nCfLSGvudPAQDuZMWb1Dzsgp
         qDBQDMZFI36H1EJYqOAfwf/hyQ0MZo+Y6Lq3P+Vv+6icNP7IqDEt1TyLzotHPNT0jU
         0b5+B8XDzkjgI9MbU4SVpz3YarihjneIehRoBCPJhKNriaIDfP7T3+qrvEsR9LmNE0
         BdruynS0hC5bnAPYHogYdbRZ33FH40N6ct65EPRqz/oTkUVfY2JMjriJ0R5JkKjhF9
         kkbXFMp9NQ6cqAaK8Q4++ZqB8JeMlcFVbuAH2ge8yf0iCR7jeRRD5ko1UZCybT1Ai4
         eiFTkqiBTxqJw==
Date:   Wed, 13 Apr 2022 15:21:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: samsung: exynos5250-sata: fix missing device put in
 probe error paths
Message-ID: <YladK4z//z1hmTRX@matsya>
References: <20220309170028.51913-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309170028.51913-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-03-22, 18:00, Krzysztof Kozlowski wrote:
> The actions of of_find_i2c_device_by_node() in probe function should be
> reversed in error paths by putting the reference to obtained device.

This fails to apply on phy-fixes, pls rebase

> 
> Fixes: bcff4cba41bc ("PHY: Exynos: Add Exynos5250 SATA PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Rebased on top of (although it is independent, no conflicts):
> https://lore.kernel.org/linux-samsung-soc/20220309124856.32632-1-linmq006@gmail.com/T/#u
> ---
>  drivers/phy/samsung/phy-exynos5250-sata.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos5250-sata.c b/drivers/phy/samsung/phy-exynos5250-sata.c
> index 6c305a3fe187..595adba5fb8f 100644
> --- a/drivers/phy/samsung/phy-exynos5250-sata.c
> +++ b/drivers/phy/samsung/phy-exynos5250-sata.c
> @@ -196,20 +196,21 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
>  	sata_phy->phyclk = devm_clk_get(dev, "sata_phyctrl");
>  	if (IS_ERR(sata_phy->phyclk)) {
>  		dev_err(dev, "failed to get clk for PHY\n");
> -		return PTR_ERR(sata_phy->phyclk);
> +		ret = PTR_ERR(sata_phy->phyclk);
> +		goto put_dev;
>  	}
>  
>  	ret = clk_prepare_enable(sata_phy->phyclk);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to enable source clk\n");
> -		return ret;
> +		goto put_dev;
>  	}
>  
>  	sata_phy->phy = devm_phy_create(dev, NULL, &exynos_sata_phy_ops);
>  	if (IS_ERR(sata_phy->phy)) {
> -		clk_disable_unprepare(sata_phy->phyclk);
>  		dev_err(dev, "failed to create PHY\n");
> -		return PTR_ERR(sata_phy->phy);
> +		ret = PTR_ERR(sata_phy->phy);
> +		goto clk_disable;
>  	}
>  
>  	phy_set_drvdata(sata_phy->phy, sata_phy);
> @@ -217,11 +218,18 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
>  	phy_provider = devm_of_phy_provider_register(dev,
>  					of_phy_simple_xlate);
>  	if (IS_ERR(phy_provider)) {
> -		clk_disable_unprepare(sata_phy->phyclk);
> -		return PTR_ERR(phy_provider);
> +		ret = PTR_ERR(phy_provider);
> +		goto clk_disable;
>  	}
>  
>  	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(sata_phy->phyclk);
> +put_dev:
> +	put_device(&sata_phy->client->dev);
> +
> +	return ret;
>  }
>  
>  static const struct of_device_id exynos_sata_phy_of_match[] = {
> -- 
> 2.32.0

-- 
~Vinod
