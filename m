Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6318F514E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378058AbiD2PAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359135AbiD2PAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:00:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0486AD11A;
        Fri, 29 Apr 2022 07:56:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C2C671F466DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651244214;
        bh=z9AR4wgc26TG7iya9Kky9QmyE15COjI5k6NO1aUr9nM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B/o+15Qp5XwlYcfwYE4cvYJnt0OqXlhOnnLsVBpctIVKIBBQF1Y0ge8+TDDW8u9w+
         CdvsBd7//mvviofvJIPFRwZksdC8WRcGvTlKZgIA1Fn+oNtTrEEuiaaODTX1TbOWlw
         FlxkIIsE3NJI1NqThewT/+h9/AVB+laxO0pajoj1cSppFTa9uDnq0OVG9SNCtLQfPC
         NtThfNp+cESYTKrQ3f/tpP8TrwIPOUp2tuiHL6v8WljdI1W10uXJg/QT2jRGESUP8P
         taidYj5OEO3fTFm+48cNGGAV41RvEdnHly/JOnSn6XGedl5HwzaGiPecUPwQRwGPj7
         Y+LzyxI6kfxyQ==
Message-ID: <2e0df511-f9fa-2905-f381-fc1158774ab4@collabora.com>
Date:   Fri, 29 Apr 2022 17:56:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v10 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220429113438.13988-1-amhetre@nvidia.com>
 <20220429113438.13988-2-amhetre@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220429113438.13988-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/22 14:34, Ashish Mhetre wrote:
>  static int tegra186_mc_probe(struct tegra_mc *mc)
>  {
> +	struct platform_device *pdev = to_platform_device(mc->dev);
> +	unsigned int i;
>  	int err;
>  
> +	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
> +	if (IS_ERR(mc->bcast_ch_regs)) {
> +		if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
> +			dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
> +			mc->bcast_ch_regs = NULL;
> +			goto skip_map_regs;
> +		}
> +		return PTR_ERR(mc->bcast_ch_regs);
> +	}
> +
> +	mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels,
> +				   sizeof(*mc->ch_regs), GFP_KERNEL);
> +	if (!mc->ch_regs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mc->soc->num_channels; i++) {
> +		char name[5];
> +
> +		snprintf(name, sizeof(name), "ch%u", i);
> +		mc->ch_regs[i] = devm_platform_ioremap_resource_byname(pdev, name);
> +		if (IS_ERR(mc->ch_regs[i]))
> +			return PTR_ERR(mc->ch_regs[i]);
> +	}
> +
> +skip_map_regs:
>  	err = of_platform_populate(mc->dev->of_node, NULL, NULL, mc->dev);

More common to name labels by the action pointed by label, like
"populate:" in this case. No need to make v11 because of that.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
