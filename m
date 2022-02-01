Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B324A53C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiBAAHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBAAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:07:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F7C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:07:09 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id y23so29976570oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=etN/F/33nyG7XjKahm9y0BQjMlDg0tr31SIo/26P8fo=;
        b=YhTr5miT/Oj2D1T11IjOg1Ck8aQM7Lpldcb+wAsy24c8e6GhVURiho/gjVEeM1MPR4
         WdFR/o6SOmUR+vn+xMYSfUfOmACpDF0JQCXn+aL72bMYRxBkUMkiXUkCBB6zlbpO5h5o
         rBeIyjbo/mEcKVQd/onmO1Emuv+9oSshAD70gNT37e5nD7rtHTXKy0zFdxTm1cMK0AEB
         tp89L4s7zeVY2s8/hu3VdH/twhbsWX9Yl7y013dg15tEKa0TASRLxCfpI4lT2xouRaxw
         HMSDOVisOE9uEfpECxWTeVWacgp9+75OSUs9yC6vUXaqEt4HJmOv6Oa3Xl4Zw6TwV+3B
         9LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=etN/F/33nyG7XjKahm9y0BQjMlDg0tr31SIo/26P8fo=;
        b=4P/nEulDEj8XymaR0+s48LYuJCt8pCl4vCbdf+1C5Q3+RJGRJScnsrmKXk/WvZVvDT
         Wt2HZupgFw30N53Gl1NGyqBwUU0ifnZDB1dXvq4O+SxbIoDCW/IBRVgGRq9k0Coc4dpz
         8dbesdnmu3FxeyxIMiQ5SOob7Yq/zhiRd+RGJn87/Hd8ncDvwBusuXdKUnrrf+9ZGjZf
         gtmXKNP2YrTL7TnJBKuODFfSWmuG5GRPx9esp+izgSgjMaDYFFhOmYlrtpPEgGeJPFny
         3oLGABHGjq+kBRohETfGb+gKFuAgEClfpC1SZ78MD64wQOp8GSR3509B5OtKG8PSBFNq
         GpXw==
X-Gm-Message-State: AOAM533wg29nofdBaYFDxYcxKiCWacuTxlOp1cdP6owR35dlWk2F+GJ/
        IhTz2hEnnJSdQ8TDt+JvRFo5Aw==
X-Google-Smtp-Source: ABdhPJw+RXbE69BLQesPDpbW6Gf9TBeWq/C1I/hrqxma9k+U23KJoH5J2P3RSmgEQOUjO1xaK8gZmg==
X-Received: by 2002:a05:6808:1481:: with SMTP id e1mr19871361oiw.217.1643674029182;
        Mon, 31 Jan 2022 16:07:09 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id v78sm7103115oie.18.2022.01.31.16.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:07:08 -0800 (PST)
Date:   Mon, 31 Jan 2022 18:07:06 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, sboyd@kernel.org,
        tdas@codeaurora.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/8] net: stmmac: Add support for SM8150
Message-ID: <Yfh5qrT2dAMpFk2s@builder.lan>
References: <20220126221725.710167-1-bhupesh.sharma@linaro.org>
 <20220126221725.710167-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126221725.710167-3-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 Jan 16:17 CST 2022, Bhupesh Sharma wrote:

> From: Vinod Koul <vkoul@kernel.org>
> 
> This adds compatible, POR config & driver data for ethernet controller
> found in SM8150 SoC.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> [bhsharma: Massage the commit log and other cosmetic changes]
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

The series can be picked up by 3 different maintainers and e.g. the
network patches seems ready to be merged.

Please facilitate this by sending it in 3 different series (you may
combine clock and dts in one series, as I merge both).

Regards,
Bjorn

> ---
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 2ffa0a11eea5..8cdba9d521ec 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -183,6 +183,20 @@ static const struct ethqos_emac_driver_data emac_v2_3_0_data = {
>  	.num_por = ARRAY_SIZE(emac_v2_3_0_por),
>  };
>  
> +static const struct ethqos_emac_por emac_v2_1_0_por[] = {
> +	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40C01343 },
> +	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642C },
> +	{ .offset = SDCC_HC_REG_DDR_CONFIG,	.value = 0x00000000 },
> +	{ .offset = SDCC_HC_REG_DLL_CONFIG2,	.value = 0x00200000 },
> +	{ .offset = SDCC_USR_CTL,		.value = 0x00010800 },
> +	{ .offset = RGMII_IO_MACRO_CONFIG2,	.value = 0x00002060 },
> +};
> +
> +static const struct ethqos_emac_driver_data emac_v2_1_0_data = {
> +	.por = emac_v2_1_0_por,
> +	.num_por = ARRAY_SIZE(emac_v2_1_0_por),
> +};
> +
>  static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
>  {
>  	unsigned int val;
> @@ -558,6 +572,7 @@ static int qcom_ethqos_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id qcom_ethqos_match[] = {
>  	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
> +	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
> -- 
> 2.34.1
> 
