Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E2511654
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiD0LgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiD0LgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:36:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54743A721;
        Wed, 27 Apr 2022 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651059169; x=1682595169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/A3B6d6OPF/q0b6dnctlrtCp51yNGiV6UyDdy28MVuE=;
  b=iNFNVLwfGCZNsFZ3eoeZ2Ts5f4XJLFn5otE+t4J4916LU4ZlwJEcrmgg
   bzQmSi7kggUt16B9OVAeUzlq+niB0SZT+pj9eERGhC8mE/TUp5VsfpUHh
   hfv91GujNi5x2RF+6SeguVuE+IjxoL2tSt91Pw7kdAZuFZ7MG4ZELuO2Y
   G3nbofBS5hfNjqtqaFxgBaQWcKKUh726Z8Y4eddWAgZ97+8penETfHFoy
   En4QHOSjbyDdMOUvUq2BvbQpoLE/c9SXCyFhGtJ0dR7pyouaB1HqMVoNX
   K3nb+VKweohXkUa1pAl8FOoF11XpJkOj4ucMdq3myAYrVok0SS7oikYlj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326391272"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326391272"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 04:32:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580543933"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 04:32:42 -0700
Message-ID: <c592d7b6-b317-2f14-e4a2-62529129b0e5@intel.com>
Date:   Wed, 27 Apr 2022 14:32:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V5] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, chris@printf.net, venkatg@codeaurora.org,
        gdjakov@mm-sol.com, quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
References: <1650816153-23797-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1650816153-23797-1-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/22 19:02, Shaik Sajida Bhanu wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes since V4:
> 	- Called reset_control_put() in error path.
> 
> Changes since V3:
> 	- Used reset controller local variable as suggested by
> 	  Bjorn Andersson.
> 	- Passed NULL as a parameter to
> 	  devm_reset_control_get_optional_exclusive() as suggested by
> 	  Bjorn Andersson.
> 	- Replaced devm_reset_control_get_optional_exclusive() with
> 	  reset_control_get_optional_exclusive() and called
> 	  reset_control_put() before returning to clear the reset
> 	  controller as suggested by Bjorn Andersson.
> 
> Changes since V2:
> 	- Dropped new line after fixes tag as suggested by Bjorn
> 	  Andersson.
> 	- Passed device structure instead of passing platform_device
> 	  structure as a argument for sdhci_msm_gcc_reset() as suggested
> 	  by Bjorn Andersson.
> 	- Replaced dev_err() with dev_err_probe() as suggested by Bjorn
> 	  Andersson.
> 
> Changes since V1:
> 	- Added fixes tag as suggested by Ulf Hansson.
> 	- Replaced devm_reset_control_get() with
> 	  devm_reset_control_get_optional_exclusive() as suggested by
> 	  Ulf Hansson.
> ---
>  drivers/mmc/host/sdhci-msm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..ff9f5b6 100644
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
> @@ -2482,6 +2483,43 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>  	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>  }
>  
> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> +{
> +	struct reset_control *reset;
> +	int ret = 0;
> +
> +	reset = reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				"unable to acquire core_reset\n");
> +
> +	if (!reset)
> +		return ret;
> +
> +	ret = reset_control_assert(reset);
> +	if (ret) {
> +		reset_control_put(reset);
> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
> +	}
> +
> +	/*
> +	 * The hardware requirement for delay between assert/deassert
> +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> +	 * ~125us (4/32768). To be on the safe side add 200us delay.
> +	 */
> +	usleep_range(200, 210);
> +
> +	ret = reset_control_deassert(reset);
> +	if (ret) {
> +		reset_control_put(reset);
> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
> +	}
> +
> +	usleep_range(200, 210);
> +	reset_control_put(reset);
> +
> +	return ret;
> +}
>  
>  static int sdhci_msm_probe(struct platform_device *pdev)
>  {
> @@ -2529,6 +2567,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
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

