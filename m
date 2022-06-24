Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287C75596F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiFXJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXJo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:44:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C12A3EAB7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:44:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o4frX-00052V-LX; Fri, 24 Jun 2022 11:44:27 +0200
Message-ID: <2d475e77dca2395ee5b6fcff0e1d3ade2b0a36ef.camel@pengutronix.de>
Subject: Re: [PATCH v2 4/4] drm/etnaviv: export loadavg via perfmon
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Date:   Fri, 24 Jun 2022 11:44:26 +0200
In-Reply-To: <20220621072050.76229-5-christian.gmeiner@gmail.com>
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
         <20220621072050.76229-5-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 21.06.2022 um 09:20 +0200 schrieb Christian Gmeiner:
> Make it possible to access the sub-GPU component load value from
> user space with the perfmon infrastructure.
> 
You need to explain a bit more how you intend to use those.

Contrary to all other perfmon values, where we go to great lengths to
only count the load put onto the GPU by the specific process requesting
the perfmon, the loadavg values also include the load caused by other
submits. Due to this difference in behavior I fear that those new
counters might be confusing to use. But maybe you have a use-case in
mind that I don't see right now.

Regards,
Lucas

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 79 +++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> index bafdfe49c1d8..d65d9af3a74a 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> @@ -120,6 +120,19 @@ static u32 hi_total_idle_cycle_read(struct etnaviv_gpu *gpu,
>  	return gpu_read(gpu, reg);
>  }
>  
> +static u32 load_read(struct etnaviv_gpu *gpu,
> +	const struct etnaviv_pm_domain *domain,
> +	const struct etnaviv_pm_signal *signal)
> +{
> +	u32 load;
> +
> +	spin_lock_bh(&gpu->loadavg_spinlock);
> +	load = gpu->loadavg_percentage[signal->data];
> +	spin_unlock_bh(&gpu->loadavg_spinlock);
> +
> +	return load;
> +}
> +
>  static const struct etnaviv_pm_domain doms_3d[] = {
>  	{
>  		.name = "HI",
> @@ -419,6 +432,72 @@ static const struct etnaviv_pm_domain doms_3d[] = {
>  				&perf_reg_read
>  			}
>  		}
> +	},
> +	{
> +		.name = "LOAD",
> +		.nr_signals = 12,
> +		.signal = (const struct etnaviv_pm_signal[]) {
> +			{
> +				"FE",
> +				0,
> +				&load_read
> +			},
> +			{
> +				"DE",
> +				1,
> +				&load_read
> +			},
> +			{
> +				"PE",
> +				2,
> +				&load_read
> +			},
> +			{
> +				"SH",
> +				3,
> +				&load_read
> +			},
> +			{
> +				"PA",
> +				4,
> +				&load_read
> +			},
> +			{
> +				"SE",
> +				5,
> +				&load_read
> +			},
> +			{
> +				"RA",
> +				6,
> +				&load_read
> +			},
> +			{
> +				"TX",
> +				7,
> +				&load_read
> +			},
> +			{
> +				"VG",
> +				8,
> +				&load_read
> +			},
> +			{
> +				"IM",
> +				9,
> +				&load_read
> +			},
> +			{
> +				"FP",
> +				10,
> +				&load_read
> +			},
> +			{
> +				"TS",
> +				11,
> +				&load_read
> +			}
> +		}
>  	}
>  };
>  


