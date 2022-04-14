Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2C501D33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiDNVNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiDNVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:13:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DBD4C9C;
        Thu, 14 Apr 2022 14:11:25 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 709731F47CE5;
        Thu, 14 Apr 2022 22:11:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649970684;
        bh=5xMkEzAZOGJAMLJhGhAudl6cnOUM32tr6wt4093X+gQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ET0VcdH+/kERMVBvFDuX5GP2+bIBO/hnjxu5R2aRJ1L714Ma6JcvgT8N6CbbE6vjx
         3WGgpoXR23wdqcgmXX0hLTQ95DDegk+u/kFiMQdeYAR1VuOIDxiPLdWkhe6aQhdTmv
         wLklu7f9Q2PpGD8U25SBbHv4rzzvAOTHHsd88ONQVx82hi+av3CHPHo/EFCGhT9tEj
         3voKPmvokc0TD4ftQTkj16ltXfWrZpiBroOkGVrz9YAvdJ1rjm7Wbqj/L+gBj2D/AC
         hRflNckxeF6lNOyB9WLI4XIwZP12jovSJHy0JY3qGXXhrwyF6Q1r5lNHSZxtl+5dVu
         P0A4hnOSfjudA==
Message-ID: <a4059c30-b660-cad4-4c5d-3b100ac164bf@collabora.com>
Date:   Fri, 15 Apr 2022 00:11:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v7 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, digetx@gmail.com,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-2-amhetre@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220413094012.13589-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 12:40, Ashish Mhetre wrote:
>  
> +static int tegra186_mc_map_regs(struct tegra_mc *mc)
> +{
> +	struct platform_device *pdev = to_platform_device(mc->dev);
> +	int i;
> +
> +	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
> +	if (IS_ERR(mc->bcast_ch_regs)) {
> +		if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
> +			dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
> +			return 0;
> +		}
> +		return PTR_ERR(mc->bcast_ch_regs);
> +	}
> +
> +	mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels,
> +				   sizeof(void __iomem *), GFP_KERNEL);
> +	if (!mc->ch_regs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mc->soc->num_channels; i++) {
> +		char name[4];
> +
> +		sprintf(name, "ch%u", i);

name[5], otherwise you corrupting stack. Use snprintf(name, sizeof(name)).
