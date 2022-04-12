Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704584FDFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353344AbiDLMI4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Apr 2022 08:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352860AbiDLMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03148232D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:00:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1neEGE-000510-FH; Tue, 12 Apr 2022 13:00:38 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1neEGA-002Z8P-Ul; Tue, 12 Apr 2022 13:00:33 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1neEG8-0006zj-QC; Tue, 12 Apr 2022 13:00:32 +0200
Message-ID: <1ee3b0619ee976eaf88e7207318770d441418c94.camel@pengutronix.de>
Subject: Re: [PATCH V4] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        adrian.hunter@intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        chris@printf.net, venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
Date:   Tue, 12 Apr 2022 13:00:32 +0200
In-Reply-To: <1649759983-22035-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1649759983-22035-1-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2022-04-12 at 16:09 +0530, Shaik Sajida Bhanu wrote:
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
>  drivers/mmc/host/sdhci-msm.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..0e5fb62 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/reset.h>
>  
> 
> 
> 
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -2482,6 +2483,39 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>  	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>  }
>  
> 
> 
> 
> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> +{
> +	struct reset_control *reset;
> +	int ret = 0;

No need to initialize ret.

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
> +	if (ret)
> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");

Missing reset_control_put(reset) in the error path.

> +
> +	/*
> +	 * The hardware requirement for delay between assert/deassert
> +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> +	 * ~125us (4/32768). To be on the safe side add 200us delay.
> +	 */
> +	usleep_range(200, 210);
> +
> +	ret = reset_control_deassert(reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");

Same as above. Maybe make both ret = dev_err_probe() and goto ...

> +
> +	usleep_range(200, 210);

... here.

> +	reset_control_put(reset);
> +
> +	return ret;
> +}

regards
Philipp
