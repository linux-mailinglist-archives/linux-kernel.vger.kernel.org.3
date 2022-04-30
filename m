Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B751598C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381980AbiD3BVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381976AbiD3BVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:21:42 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA18021D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:18:20 -0700 (PDT)
Received: from [192.168.1.101] (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A164C3F84D;
        Sat, 30 Apr 2022 03:18:15 +0200 (CEST)
Message-ID: <dc1ac42a-a97f-979e-e65b-03251a261daa@somainline.org>
Date:   Sat, 30 Apr 2022 03:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V5] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, p.zabel@pengutronix.de, chris@printf.net,
        venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
References: <1650816153-23797-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <1650816153-23797-1-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.04.2022 18:02, Shaik Sajida Bhanu wrote:
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
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> 
Looks like this fixes SDHCI init problems on MSM8996 SONY Tone!

Tested-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
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
> 
