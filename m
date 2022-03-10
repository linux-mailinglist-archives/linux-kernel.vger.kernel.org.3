Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4F4D5591
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbiCJXjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbiCJXjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:39:46 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DA35871
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:38:43 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q189so7627293oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5YgWXh9EdVjh1W/rPJ6KNdL1nAingABW0Gom5HZqNug=;
        b=nzuplA6UJr3OCptBVYac78FF2j0OKoFCo1m3M8XHawxP9y5CAnAkpZSl5R4BanCfpj
         cVtxKKAkoyZpZ0ERLXpXG+awu/BNkt+SXsZwWqmeWVcoEh378F1IY2vJcrCoW39KbpCq
         QbSFrjGl6ZvsLAvZWwCU9c/ul/bQ87UyPojUVqDpvy8R4ZX1FjeWPhbKCLA9w/eeY5DH
         FX/MRVRygmrMyn4zzyf6IqTvQ/INPyRVDsfVTo0EaoN7wb07k09ozjFIuTTVlTNGF36J
         TetMKkuHnBAlW58AzQgMWQFGOmVFjYEX/BWyasXE9DGnA5jnpUgPkTH/wD4w6L1N3jyV
         A1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5YgWXh9EdVjh1W/rPJ6KNdL1nAingABW0Gom5HZqNug=;
        b=qaNu929D/TLs6wMC7lXXSVKGv+VmP/WrMAP09EibBwzlIiOE23SPvLwnr8eQ/OxUJf
         3MTQN8NlSrZeGo5M8wxlEq4aDFgVklejw7uDwWXi4Q8k4xuCX9kINiHBtBhArenc0Znq
         TeIA0WOgRV/lKqXcx1RMWPwB4EIoDJIwyJ3+LJIgKYxRAK/ApXY46L4jwlPu1eT5sopn
         STN8G3ibC0AzPjzuCe1n1tUl+OfHC8fh15JQU4iNfLji2FB/rIjiifrWWFffpV/ol29g
         AfYICWHvY7ehPplDpqFyPGX1dy5kHDw/0aOG3eAlK42K8+/9H5iLPsatL0h+UotFvjAz
         TKbQ==
X-Gm-Message-State: AOAM531tCrFqe1v8Vt8ZnsZ2IqWvydkvG/+EEgKuDEg43upzmkDUgS7t
        cEwXpzjENpCwOuOqfO37KR8Tyw==
X-Google-Smtp-Source: ABdhPJxFCzc3m1UVAdP/mnxcDEWfhBzlFRkLIgemb8qHz2BIn0jGQVTGa4uoiqPy2lCgMtiHWPPACA==
X-Received: by 2002:a05:6808:2227:b0:2da:5a4f:95db with SMTP id bd39-20020a056808222700b002da5a4f95dbmr3991134oib.129.1646955522821;
        Thu, 10 Mar 2022 15:38:42 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id ay44-20020a056808302c00b002d9d2b564absm3047905oib.43.2022.03.10.15.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:38:42 -0800 (PST)
Date:   Thu, 10 Mar 2022 15:40:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     adrian.hunter@intel.com, agross@kernel.org, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, chris@printf.net, gdjakov@mm-sol.com,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_asutoshd@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
Subject: Re: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Message-ID: <YiqMZouVVEtVNrlV@ripper>
References: <1646926823-5362-1-git-send-email-quic_c_sbhanu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646926823-5362-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Mar 07:40 PST 2022, Shaik Sajida Bhanu wrote:

> Reset GCC_SDCC_BCR register before every fresh initilazation. This will
> reset whole SDHC-msm controller, clears the previous power control
> states and avoids, software reset timeout issues as below.
> 

Nice, we've gotten reports about this from time to time.

> [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
> [ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP
> ===========
> [ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version:
> 0x00007202
> [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt:
> 0x00000000
> [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode:
> 0x00000000
> [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl:
> 0x00000000
> [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
> [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
> [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat:
> 0x00000000
> [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab:
> 0x00000000
> [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int:
> 0x00000000
> [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
> [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
> [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]:
> 0x00000000
> [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]:
> 0x00000000
> [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
> [ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER
> DUMP-----------
> [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
> 0x6000642c |
> DLL cfg2: 0x0020a000
> [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
> 0x00010800 | DDR cfg: 0x80040873
> [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 :
> 0xf88218a8 Vndr func3: 0x02626040

Please ignore the line length "limit" and leave these unwrapped.

> 
> Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm
> chipsets")

This as well, and please drop the empty line between Fixes: and
Signed-off-by:.

> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
> 
> Changes since V1:
> 	- Added fixes tag as suggested by Ulf Hansson.
> 	- Replaced devm_reset_control_get() with
> 	  devm_reset_control_get_optional_exclusive() as suggested by
> 	  Ulf Hansson.
> ---
>  drivers/mmc/host/sdhci-msm.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..cb33c9a 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/reset.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -284,6 +285,7 @@ struct sdhci_msm_host {
>  	bool uses_tassadar_dll;
>  	u32 dll_config;
>  	u32 ddr_config;
> +	struct reset_control *core_reset;

As you only reset the controller once, during probe, this can be a local
variable in sdhci_msm_gcc_reset().

>  	bool vqmmc_enabled;
>  };
>  
> @@ -2482,6 +2484,45 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>  	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>  }
>  
> +static int sdhci_msm_gcc_reset(struct platform_device *pdev,

You don't need pdev here, take a struct deivce * in and pass &pdev->dev.

> +	       struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret = 0;
> +
> +	msm_host->core_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "core_reset");

No need to hold onto that, so use the non-devm variant and free the
reset at the end of the function.

> +	if (IS_ERR(msm_host->core_reset)) {
> +		ret = PTR_ERR(msm_host->core_reset);
> +		dev_err(&pdev->dev, "core_reset unavailable (%d)\n", ret);
> +		msm_host->core_reset = NULL;

return dev_err_probe(&pdev->dev, PTR_ERR(msm_host->core_reset), "unable to acquire core_reset\n");

> +	}
> +	if (msm_host->core_reset) {

If you flip this around as:

	if (!msm_host->core_reset)
		return 0;

You don't need to zero-initialize ret, use goto and indent
this block.

> +		ret = reset_control_assert(msm_host->core_reset);
> +		if (ret) {
> +			dev_err(&pdev->dev, "core_reset assert failed (%d)\n",
> +						ret);
> +			goto out;

return dev_err_probe();

> +		}
> +		/*
> +		 * The hardware requirement for delay between assert/deassert
> +		 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> +		 * ~125us (4/32768). To be on the safe side add 200us delay.
> +		 */
> +		usleep_range(200, 210);
> +
> +		ret = reset_control_deassert(msm_host->core_reset);
> +		if (ret) {
> +			dev_err(&pdev->dev, "core_reset deassert failed (%d)\n",
> +						ret);
> +			goto out;

return dev_err_probe()

> +		}
> +		usleep_range(200, 210);

The comment above says that we need to hold reset for 125us, is this
delay in here in error or should the comment above mention that this
needs to be done after deasserting the reset as well?

> +	}
> +
> +out:
> +	return ret;

With above, you can return 0 here.

> +}
>  
>  static int sdhci_msm_probe(struct platform_device *pdev)
>  {
> @@ -2529,6 +2570,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  
>  	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>  
> +	ret = sdhci_msm_gcc_reset(pdev, host);
> +	if (ret) {
> +		dev_err(&pdev->dev, "core_reset assert/deassert failed (%d)\n",
> +					ret);

You just printed in sdhci_msm_gcc_reset(), no need to print again.

Regards,
Bjorn

> +		goto pltfm_free;
> +	}
> +
>  	/* Setup SDCC bus voter clock. */
>  	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>  	if (!IS_ERR(msm_host->bus_clk)) {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
