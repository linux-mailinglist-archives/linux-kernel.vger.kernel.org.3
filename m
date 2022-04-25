Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A250E974
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbiDYT24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDYT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:28:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32CA3A734;
        Mon, 25 Apr 2022 12:25:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 7FA761F433C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650914745;
        bh=4H8Tfxb/3HJv6jwhxuDK6+J5KJ7dxxiuti0TYw1hEQU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ooUjr6rItVPGVXDDyvwTK/dgopIHGw+ney8faEy327qHUHQOjUtf/k+cRyuRjv+1D
         skhxbu4RRsQbOFTBKHELhnBnMCJDIs1tGifySGd1UsT9eusiUJTNlSkw2RSt+JaRXP
         UUA6hxeYFqy4d/N5tKF9O3erEPcdJlgD0VUazz1PDdlgxX7tNcowj6IdXqKsjSbVdv
         JwBFP2rNCNnGmZ2vztvcyH73H3siH3HQj34R34QaSOXXuVWCZuLRoYT55rDit0nB8X
         JtU53YwJbqauSVR2/9LC+8isohL2n5hw/vlsrGw0PlPKCgsJWBIBNW9VvoqN5OpBNF
         YsY830QxEVvCg==
Message-ID: <5ddaf113-c8f6-7c9c-5bf6-27f2f7855d24@collabora.com>
Date:   Mon, 25 Apr 2022 22:25:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v8 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220425075036.30098-1-amhetre@nvidia.com>
 <20220425075036.30098-2-amhetre@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220425075036.30098-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 10:50, Ashish Mhetre wrote:
> +static int tegra186_mc_map_regs(struct tegra_mc *mc)
> +{
> +	struct platform_device *pdev = to_platform_device(mc->dev);
> +	int i;
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
> +				   sizeof(void __iomem *), GFP_KERNEL);

You should use sizeof(*mc->ch_regs) in general to prevent mistakes.

> +	if (!mc->ch_regs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mc->soc->num_channels; i++) {
> +		char name[5];
> +
> +		snprintf(name, sizeof(name), "ch%u", i);

The type of "i" variable is int, change it to unsigned int.

With that:

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
