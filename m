Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0DB48C0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351883AbiALJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:03:09 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57557 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiALJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:03:07 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A05B7C000A;
        Wed, 12 Jan 2022 09:03:04 +0000 (UTC)
Date:   Wed, 12 Jan 2022 10:04:05 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 19/23] media: atmel: atmel-isc-base: clamp wb gain
 coefficients
Message-ID: <20220112090405.tjgz47dhdbyjrwxr@uno.localdomain>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-20-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-20-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Mon, Dec 13, 2021 at 03:49:36PM +0200, Eugen Hristev wrote:
> White balance computed gains can overflow above the 13 bits hardware
> coefficient that can be used, in some specific scenarios like a subexposure
> from the sensor when the image is mostly black.
> In this case the computed gain has to be clamped to the maximum value
> allowed by the hardware.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index f1f1019f9d82..31c8e3029eee 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -1415,6 +1415,10 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
>  		/* multiply both gains and adjust for decimals */
>  		ctrls->gain[c] = s_gain[c] * gw_gain[c];
>  		ctrls->gain[c] >>= 9;
> +
> +		/* make sure we are not out of range */
> +		ctrls->gain[c] = clamp_val(ctrls->gain[c], 0, GENMASK(12, 0));

#include <linux/minmax.h>

What is the type of gain[c} ? If it's unsigned clamping with [0 is not
required. I would in that case gain[c] = min(gain[c], ...)

It's fine anyway
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
   j


> +
>  		v4l2_dbg(1, debug, &isc->v4l2_dev,
>  			 "isc wb: component %d, final gain %u\n",
>  			 c, ctrls->gain[c]);
> --
> 2.25.1
>
