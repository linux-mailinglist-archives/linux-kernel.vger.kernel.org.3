Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC295144DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356151AbiD2Izn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356260AbiD2IyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:54:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753BE6D952;
        Fri, 29 Apr 2022 01:50:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 3042C1F460A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651222254;
        bh=JMryjmbHSpjNRgHd+CiOPwDHIkfH7sdFnahi2359ly4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HAlTgR7ERsXtlbeQUXl5BK+85HTiCmaGgR+VREeXHjtIWuSRvoxOSAJkUKVZTSSnh
         6iZOln4rfgrlkFUSFJHpSoKrli2vEH1c8Ck3nqic3TD+QGEEbkzHZHGaq5JQnGKjpf
         mgUzCRok5jXEKQ0MRxSVGq3F7RG4H2JAoo+l5r+6d9pieC+9x83Pm+EakjHkVdylBj
         FH08H9u+nP4PT1wzg+ky+98IH96Ko7WwP/sluEzfrDDS4PN4GXStc68ldk7WCZuBuR
         alGund/kuPdcHa23GSHlvOKR/MPuBtYCCgdURvRBsQTl21XzQTJV5cLwx5MiCvtj1/
         +QAmm0/JFPRlQ==
Message-ID: <8fc06781-72a0-9f86-e9cc-6af2425f2077@collabora.com>
Date:   Fri, 29 Apr 2022 11:50:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v9 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220426073827.25506-1-amhetre@nvidia.com>
 <20220426073827.25506-2-amhetre@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220426073827.25506-2-amhetre@nvidia.com>
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

On 4/26/22 10:38, Ashish Mhetre wrote:
> +static int tegra186_mc_map_regs(struct tegra_mc *mc)
> +{
> +	struct platform_device *pdev = to_platform_device(mc->dev);
> +	unsigned int i;
> +
> +	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
> +	if (IS_ERR(mc->bcast_ch_regs)) {
> +		if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
> +			dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
> +			mc->bcast_ch_regs = NULL;
> +			return 0;
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
> +	return 0;
> +}
> +
>  const struct tegra_mc_ops tegra186_mc_ops = {
>  	.probe = tegra186_mc_probe,
>  	.remove = tegra186_mc_remove,
>  	.resume = tegra186_mc_resume,
>  	.probe_device = tegra186_mc_probe_device,
> +	.map_regs = tegra186_mc_map_regs,
>  };

Do we really need the map_regs() callback? Could you please move it to
the tegra186_mc_probe()? .. Sorry, I haven't noticed this previously.
