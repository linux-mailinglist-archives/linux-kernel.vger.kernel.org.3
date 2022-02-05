Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA66D4AA632
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379174AbiBED06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:26:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53368 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiBED05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:26:57 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15DE7472;
        Sat,  5 Feb 2022 04:26:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644031616;
        bh=M+Z2tUMN6VKAi5ODQ4SChm7l3WTsONh75s17OSEBxAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShcgrnsG329P7DXt11eyuTz/9Ab3J050Cau5KA/N8B/U6OwxUZxMLqxcM23fYGM1B
         4LzXVSMoWzzbhYY8U3A2dHLK2HVA7Y1oVNBd73EU+SnyLe1tN7bC0Jxs2MJcAuAMwc
         e0ZoOTYoSyqRqU3EAA2rMUQ/U7f6s1f6BieYamBc=
Date:   Sat, 5 Feb 2022 05:26:31 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] media: imx: imx7_mipi_csis: store colorspace in
 set_fmt as well
Message-ID: <Yf3uZ9fzQ4UM76gs@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <20220204121514.2762676-6-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204121514.2762676-6-alexander.stein@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thank you for the patch.

On Fri, Feb 04, 2022 at 01:15:11PM +0100, Alexander Stein wrote:
> Without this the default (SMPTE 170M) from init_cfg stays unchanged.
> Even after configuring 'srgb' colorspace (or 'raw')
> $ media-ctl -V "'csis-32e30000.mipi-csi':0 [colorspace:srgb]"
> the colorspace does not change at all:
> $ media-ctl --get-v4l2 "'csis-32e30000.mipi-csi':0"
>   [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:smpte170m xfer:709
>    ycbcr:601 quantization:lim-range]
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/staging/media/imx/imx7-mipi-csis.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
> index a22d0e6b3d44..7b0e57efcf82 100644
> --- a/drivers/staging/media/imx/imx7-mipi-csis.c
> +++ b/drivers/staging/media/imx/imx7-mipi-csis.c
> @@ -1062,6 +1062,7 @@ static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
>  	fmt->code = csis_fmt->code;
>  	fmt->width = sdformat->format.width;
>  	fmt->height = sdformat->format.height;
> +	fmt->colorspace = sdformat->format.colorspace;

Looks good, but shouldn't you also store the other colorspace-related
fields (ycbcr_enc, quantization and xfer_func) ?

>  	sdformat->format = *fmt;

-- 
Regards,

Laurent Pinchart
