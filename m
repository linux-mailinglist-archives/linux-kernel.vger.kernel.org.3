Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A77048281C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiAAS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 13:26:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54392 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiAAS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 13:26:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD3FB8085E;
        Sat,  1 Jan 2022 18:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64770C36AEC;
        Sat,  1 Jan 2022 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641061571;
        bh=iqhFODTGlNWUxu0EeVN1B0a2Td/9mvJSxYqNduuXVlE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uXa86v619nFuog2NBKL8o/O2TCN3cRhajvLGXT00ONK8T3FwS6kekCul9NXkoFiJR
         ToEG7wYy9NosAs6Xvi2YNL721gJKmtVGtnYk2XyYHm7S0Khnye6XGDWF/Z+zagf4L/
         VNLOJr+s4/4qeJHEy3LQuKV8TarjXJnKaIxG/kuebKTccinC0dO0Kgl9QAtaXJaMDB
         SbMTnAvdgyw61R0FQZA9ylKcPmYCrduoyoE9fI1p3nTrHAchvKse2hRdlgM5vP/zYt
         L59HKluTOhQ6Hjm29WYZbpnll48EfJfx1eCxXZn3BiA+YPDAcIbK0RHu1L9Jq5DgTe
         mRKYKFaA05EGw==
Message-ID: <048650ad-e015-3733-bdf2-72b7a0ed61e4@kernel.org>
Date:   Sat, 1 Jan 2022 20:26:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] interconnect: imx: Add imx_icc_get_bw and
 imx_icc_aggregate functions
Content-Language: en-US
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220101163956.3344467-1-abel.vesa@nxp.com>
 <20220101163956.3344467-2-abel.vesa@nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220101163956.3344467-2-abel.vesa@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On 1.01.22 18:39, Abel Vesa wrote:
> The aggregate function will return whatever is the highest
> rate for that specific node. The imx_icc_get_bw sets the

Adding some more details about why we switch from
icc_std_aggregate to imx_icc_aggregate would be nice.

> initial avg and peak to 0 in order to avoid setting them to
> INT_MAX by the interconnect core.

Do we need a Fixes tag for this?

I would recommend to split imx_icc_get_bw and imx_icc_aggregate
changes into separate patches. These also seem to be unrelated to
the imx_icc_node_adj_desc patchset.

Thanks,
Georgi

> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
> 
> No changes since v1.
> 
>   drivers/interconnect/imx/imx.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> index 34bfc7936387..4d8a2a2d2608 100644
> --- a/drivers/interconnect/imx/imx.c
> +++ b/drivers/interconnect/imx/imx.c
> @@ -25,6 +25,23 @@ struct imx_icc_node {
>   	struct dev_pm_qos_request qos_req;
>   };
>   
> +static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}
> +
> +static int imx_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	*agg_avg = max(*agg_avg, avg_bw);
> +	*agg_peak = max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
>   static int imx_icc_node_set(struct icc_node *node)
>   {
>   	struct device *dev = node->provider->dev;
> @@ -233,7 +250,8 @@ int imx_icc_register(struct platform_device *pdev,
>   	if (!provider)
>   		return -ENOMEM;
>   	provider->set = imx_icc_set;
> -	provider->aggregate = icc_std_aggregate;
> +	provider->get_bw = imx_icc_get_bw;
> +	provider->aggregate = imx_icc_aggregate;
>   	provider->xlate = of_icc_xlate_onecell;
>   	provider->data = data;
>   	provider->dev = dev;

