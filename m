Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518FF4CBD29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiCCLyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiCCLyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:54:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA013E5F3;
        Thu,  3 Mar 2022 03:53:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70C01424;
        Thu,  3 Mar 2022 03:53:54 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9E733F70D;
        Thu,  3 Mar 2022 03:53:52 -0800 (PST)
Message-ID: <07977a52-a492-4568-7259-7f213af0b0b0@arm.com>
Date:   Thu, 3 Mar 2022 11:53:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock
 rates
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220303015151.1711860-1-pgwipeout@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220303015151.1711860-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-03 01:51, Peter Geis wrote:
> The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> supports.

Isn't that specific to RK3568, per the downstream fix? Certainly my 
RK3399 has no problem if I simulate polling by plugging in an empty adapter:

[499969.392530] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 
400000Hz, actual 400000HZ div = 0)
[499969.467709] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 
300000Hz, actual 300000HZ div = 0)
[499969.545975] mmc_host mmc1: Bus speed (slot 0) = 200000Hz (slot req 
200000Hz, actual 200000HZ div = 0)
[499969.629824] mmc_host mmc1: Bus speed (slot 0) = 100000Hz (slot req 
100000Hz, actual 100000HZ div = 0)

Even though every card within arm's reach of my desk does seem happy to 
identify at 400KHz, there are apparently some that only work towards the 
lower end of the range, so it's less than ideal to impose this 
limitation where it isn't necessary.

Robin.

> This leads to a situation during card initialization where the
> ciu clock is set lower than the clock driver can support. The
> dw-mmc-rockchip driver spews errors when this happens.
> For normal operation this only happens a few times during boot, but when
> cd-broken is enabled (in cases such as the SoQuartz module) this fires
> multiple times each poll cycle.
> 
> Fix this by testing the minimum frequency the clock driver can support
> that is within the mmc specification, then divide that by the internal
> clock divider. Set the f_min frequency to this value, or if it fails,
> set f_min to the downstream driver's default.
> 
> Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 95d0ec0f5f3a..c198590cd74a 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -15,7 +15,9 @@
>   #include "dw_mmc.h"
>   #include "dw_mmc-pltfm.h"
>   
> -#define RK3288_CLKGEN_DIV       2
> +#define RK3288_CLKGEN_DIV	2
> +#define RK3288_MIN_INIT_FREQ	375000
> +#define MMC_MAX_INIT_FREQ	400000
>   
>   struct dw_mci_rockchip_priv_data {
>   	struct clk		*drv_clk;
> @@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
>   static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   {
>   	struct dw_mci_rockchip_priv_data *priv = host->priv;
> +	struct mmc_host *mmc = mmc_from_priv(host);
>   	int ret;
>   	unsigned int cclkin;
>   	u32 bus_hz;
> @@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   	if (ios->clock == 0)
>   		return;
>   
> +	/* the clock will fail if below the f_min rate */
> +	if (ios->clock < mmc->f_min)
> +		ios->clock = mmc->f_min;
> +
>   	/*
>   	 * cclkin: source clock of mmc controller
>   	 * bus_hz: card interface clock generated by CLKGEN
> @@ -51,7 +58,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   
>   	ret = clk_set_rate(host->ciu_clk, cclkin);
>   	if (ret)
> -		dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> +		dev_warn(host->dev, "failed to set rate %uHz err: %d\n", cclkin, ret);
>   
>   	bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>   	if (bus_hz != host->bus_hz) {
> @@ -290,13 +297,29 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>   
>   static int dw_mci_rockchip_init(struct dw_mci *host)
>   {
> +	struct mmc_host *mmc = mmc_from_priv(host);
> +	int ret;
> +
>   	/* It is slot 8 on Rockchip SoCs */
>   	host->sdio_id0 = 8;
>   
> -	if (of_device_is_compatible(host->dev->of_node,
> -				    "rockchip,rk3288-dw-mshc"))
> +	if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
>   		host->bus_hz /= RK3288_CLKGEN_DIV;
>   
> +		/* clock driver will fail if the clock is less than the lowest source clock
> +		 * divided by the internal clock divider. Test for the lowest available
> +		 * clock and set the f_min freq to clock / clock divider. If we fail, set
> +		 * it to the downstream hardcoded value.
> +		 */
> +		ret = clk_round_rate(host->ciu_clk, MMC_MAX_INIT_FREQ * RK3288_CLKGEN_DIV);
> +		if (ret < 0) {
> +			dev_warn(host->dev, "mmc safe rate failed: %d\n", ret);
> +			mmc->f_min = RK3288_MIN_INIT_FREQ;
> +		} else {
> +			mmc->f_min = ret / RK3288_CLKGEN_DIV;
> +		}
> +	}
> +
>   	return 0;
>   }
>   
