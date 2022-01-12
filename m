Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB148C090
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351851AbiALI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:59:09 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40563 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiALI7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:59:07 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D0EBA1BF204;
        Wed, 12 Jan 2022 08:59:03 +0000 (UTC)
Date:   Wed, 12 Jan 2022 10:00:03 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 18/23] media: atmel: atmel-isc-base: add wb debug
 messages
Message-ID: <20220112090003.nktnhm3oho4mdx6g@uno.localdomain>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-19-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-19-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eugen,

On Mon, Dec 13, 2021 at 03:49:35PM +0200, Eugen Hristev wrote:
> Add debug messages that make it easier to debug white balance algorithm.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

The dev_dbg() infrastructure is preferred, as far as I know v4l2_dbg()
is legacy and should be removed.

However the driver uses v4l2_dbg() already, so
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index 53cac1aac0fd..f1f1019f9d82 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -1329,10 +1329,15 @@ static void isc_hist_count(struct isc_device *isc, u32 *min, u32 *max)
>
>  	if (!*min)
>  		*min = 1;
> +
> +	v4l2_dbg(1, debug, &isc->v4l2_dev,
> +		 "isc wb: hist_id %u, hist_count %u",
> +		 ctrls->hist_id, *hist_count);
>  }
>
>  static void isc_wb_update(struct isc_ctrls *ctrls)
>  {
> +	struct isc_device *isc = container_of(ctrls, struct isc_device, ctrls);
>  	u32 *hist_count = &ctrls->hist_count[0];
>  	u32 c, offset[4];
>  	u64 avg = 0;
> @@ -1349,6 +1354,9 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
>  		(u64)hist_count[ISC_HIS_CFG_MODE_GB];
>  	avg >>= 1;
>
> +	v4l2_dbg(1, debug, &isc->v4l2_dev,
> +		 "isc wb: green components average %llu\n", avg);
> +
>  	/* Green histogram is null, nothing to do */
>  	if (!avg)
>  		return;
> @@ -1401,9 +1409,15 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
>  		else
>  			gw_gain[c] = 1 << 9;
>
> +		v4l2_dbg(1, debug, &isc->v4l2_dev,
> +			 "isc wb: component %d, s_gain %u, gw_gain %u\n",
> +			 c, s_gain[c], gw_gain[c]);
>  		/* multiply both gains and adjust for decimals */
>  		ctrls->gain[c] = s_gain[c] * gw_gain[c];
>  		ctrls->gain[c] >>= 9;
> +		v4l2_dbg(1, debug, &isc->v4l2_dev,
> +			 "isc wb: component %d, final gain %u\n",
> +			 c, ctrls->gain[c]);
>  	}
>  }
>
> @@ -1423,6 +1437,10 @@ static void isc_awb_work(struct work_struct *w)
>  		return;
>
>  	isc_hist_count(isc, &min, &max);
> +
> +	v4l2_dbg(1, debug, &isc->v4l2_dev,
> +		 "isc wb mode %d: hist min %u , max %u\n", hist_id, min, max);
> +
>  	ctrls->hist_minmax[hist_id][HIST_MIN_INDEX] = min;
>  	ctrls->hist_minmax[hist_id][HIST_MAX_INDEX] = max;
>
> --
> 2.25.1
>
