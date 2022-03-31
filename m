Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94C4EE0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiCaSlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiCaSlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:41:35 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0219A1E3C8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:39:46 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-de3eda6b5dso263482fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9jkAgjwsi1IJSGTXHmKAcaACDiJsAOI5quMymW0VDc=;
        b=mMD97fQDv0+2FvvZYf5+fdkYUQipERsAb3C2YcKnLOOEQ/PsJUTDDX5i376ABpBGWC
         8TpaoyFX9P3UccJmlhrrqlSG+ka+WkQfRZFsFNnxBtpTwOpjT/x3Lzt9HADfuPpu7OS7
         QU+9iTOz1sDnXxGrb0mS9cmpSLomtfZalfKPVbntBxVwZkTTnhqBYisXjdlU7goWLDkM
         laUKXVA0VLRefOHvgcNMqbM2Shr1AH7O2d7elvTBpQ9ZmSUzDNCbzRS3cbBLKLE+kBsK
         I6c/dZZlvp6SopotuACCLG3keVMeHJOquxTiNQjJRKkGlYfxw8wYJcbmi+rjvkUxeo7i
         AXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9jkAgjwsi1IJSGTXHmKAcaACDiJsAOI5quMymW0VDc=;
        b=SDvkuNO8b6HR39svibpRUIflXd97mPeykZT5b2Z8v+LEKI4AYVpPl8pSXeh8+l2IX7
         hcC/zSDNVZyPcFKAzm962QwH5/tIb9ZLNP7fuVYyMwe2TZP6DsdZwl+wGUW51fv6v65x
         xCyTkmJXY2gY3/OeBfItQrXeeBalTeWm+dXtofaDxRWGY7ay3Dh9A+KSMHwcIg4DNvPa
         TmEvNdLIW8NTqb+ZD6uBEIOdXJvnGTTOD2YXio3Bclp2+L3NhiX0F9Vqsv2qw3TmXQSm
         c1470EC7J744inBc5j9iHKaaDIq466l0eZCFHJ9RS1tv/36I3inKxLQXykgYbMGwKNqo
         mLzQ==
X-Gm-Message-State: AOAM5318PchmdOLOXD7YFYHAYGPt34vQyBeIiP24bhFK03rUku8UFUo2
        6Io9fuBrwWPAvaom0ArMy+leng==
X-Google-Smtp-Source: ABdhPJw/a/7CrFLyGEY0Z/DS0/Ws4lqIc4WJ3cyuGTmJnxDrq9I4ThBrzgRb24j8nj+NdhQfCvPQBw==
X-Received: by 2002:a05:6870:d0ce:b0:de:79e2:7ec7 with SMTP id k14-20020a056870d0ce00b000de79e27ec7mr3185850oaa.245.1648751985239;
        Thu, 31 Mar 2022 11:39:45 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id e7-20020a9d2a87000000b005af548abe73sm175078otb.4.2022.03.31.11.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:39:44 -0700 (PDT)
Date:   Thu, 31 Mar 2022 11:42:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, quic_asutoshd@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com, agross@kernel.org,
        krzysztof.kozlowski@canonical.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Message-ID: <YkX2BrTjgexrIHtR@ripper>
References: <1648710182-31899-1-git-send-email-quic_c_sbhanu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648710182-31899-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31 Mar 00:03 PDT 2022, Shaik Sajida Bhanu wrote:

> Reset GCC_SDCC_BCR register before every fresh initilazation. This will
> reset whole SDHC-msm controller, clears the previous power control
> states and avoids, software reset timeout issues as below.
> 
> [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
> [ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version: 0x00007202
> [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt: 0x00000000
> [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl: 0x00000000
> [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
> [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
> [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
> [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
> [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
> [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
> [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]: 0x00000000
> [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]: 0x00000000
> [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
> [ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP-----------
> [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg: 0x6000642c | DLL cfg2: 0x0020a000
> [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl: 0x00010800 | DDR cfg: 0x80040873
> [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88218a8 Vndr func3: 0x02626040
> 
> Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm chipsets")
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
> 
> Changes since V2:
> 	- Dropped new line after fixes tag as suggested by Bjorn
> 	  Andersson.
> 	- Passed device structure instead of passing platform_device
> 	  structure as a argument for sdhci_msm_gcc_reset() as suggested
> 	  by Bjorn Andersson.
> 	- Replaced dev_err() with dev_err_probe() as suggested by Bjorn
> 	  Andersson.

Thanks, looks much better. Still some things I would like to see
improved below.

> Changes since V1:
> 	- Added fixes tag as suggested by Ulf Hansson.
> 	- Replaced devm_reset_control_get() with
> 	  devm_reset_control_get_optional_exclusive() as suggested by
> 	  Ulf Hansson.
> ---
>  drivers/mmc/host/sdhci-msm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..e15e789 100644
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
>  	bool vqmmc_enabled;
>  };
>  
> @@ -2482,6 +2484,39 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>  	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>  }
>  
> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret = 0;

First use of this variable is an assignment, so no need to initialize it
here.

> +
> +	msm_host->core_reset = devm_reset_control_get_optional_exclusive(dev, "core_reset");

reset-names will only be used to identify resets and hence there's no
reason to include "_reset" in the identifier.

If this is the only reset for the controller, there's actually no reason
for identifying it, you can omit reset-names from the binding and just
pass NULL here (to get the first resets = <>).

> +	if (IS_ERR(msm_host->core_reset))
> +		return dev_err_probe(dev, PTR_ERR(msm_host->core_reset),
> +				"unable to acquire core_reset\n");
> +
> +	if (!msm_host->core_reset)
> +		return 0;
> +
> +	ret = reset_control_assert(msm_host->core_reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
> +
> +	/*
> +	 * The hardware requirement for delay between assert/deassert
> +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> +	 * ~125us (4/32768). To be on the safe side add 200us delay.
> +	 */
> +	usleep_range(200, 210);
> +
> +	ret = reset_control_deassert(msm_host->core_reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
> +
> +	usleep_range(200, 210);
> +

sdhci_msm_gcc_reset() is only called once during probe(), so there's no
reason to carry the reset_control pointer in struct sdhci_msm_host. Make
it a local variable and use reset_control_get_optional_exclusive() and
reset_control_put() the reset here before returning.

Regards,
Bjorn

> +	return 0;
> +}
>  
>  static int sdhci_msm_probe(struct platform_device *pdev)
>  {
> @@ -2529,6 +2564,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  
>  	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>  
> +	ret = sdhci_msm_gcc_reset(&pdev->dev, host);
> +	if (ret)
> +		goto pltfm_free;
> +
>  	/* Setup SDCC bus voter clock. */
>  	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>  	if (!IS_ERR(msm_host->bus_clk)) {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
