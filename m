Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2929249FB56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbiA1OHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:07:51 -0500
Received: from vps5.brixit.nl ([192.81.221.234]:47618 "EHLO vps5.brixit.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240958AbiA1OHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:07:49 -0500
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps5.brixit.nl (Postfix) with ESMTPSA id 0861061BA7;
        Fri, 28 Jan 2022 14:07:46 +0000 (UTC)
Message-ID: <22c14d50-7585-ced5-24e2-8c0b417fa0db@postmarketos.org>
Date:   Fri, 28 Jan 2022 17:07:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Add ufs power-domain entries
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220120082803.15535-1-bhupesh.sharma@linaro.org>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20220120082803.15535-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At 20.01.2022 11:28, Bhupesh Sharma wrote:
> Add power-domain entries for UFS controller & phy nodes
> in sm8150 dts.
> 
> ...
> +			power-domains = <&gcc UFS_PHY_GDSC>;
>   			resets = <&gcc GCC_UFS_PHY_BCR>;
>   			reset-names = "rst";
> ...
> +			power-domains = <&gcc UFS_CARD_GDSC>,
> +					<&gcc UFS_PHY_GDSC>;
> +			power-domain-names = "ufs_card_gdsc", "ufs_phy_gdsc";

Strange, but I don't see neither UFS_PHY_GDSC nor UFS_CARD_GDSC in 
gcc-sm8150.c [1] (and accordingly not in 
include/dt-bindings/clock/qcom,gcc-sm8150.h), but they are present in 
corresponding files for sm8250 [2].

By quick look at downstream sm8150-gdsc.dtsi addresses seem to be 
similar to one used on sm8250, so I'm guessing gcc-sm8150 has to be 
fixed first for this patch to work?

[1] 
https://elixir.bootlin.com/linux/v5.17-rc1/source/drivers/clk/qcom/gcc-sm8150.c#L3716
[2] 
https://elixir.bootlin.com/linux/v5.17-rc1/source/drivers/clk/qcom/gcc-sm8250.c#L3522

-- 
Regards
Alexey Minnekhanov
postmarketOS developer
https://www.postmarketos.org
