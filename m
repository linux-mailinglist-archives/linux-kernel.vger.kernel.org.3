Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60014AA64B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379257AbiBEDko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiBEDkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:40:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081DC061346;
        Fri,  4 Feb 2022 19:40:41 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 872A7472;
        Sat,  5 Feb 2022 04:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644032438;
        bh=M4oWpZz0r0BqnToSL7RS29+fEekesWQcKrZDN5GeO2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ST7w0dKSwAF4/6257W+6jRHQ4crVFxaz+PmkUYcmu8qPP3eu05D0jrj+q3c4uT/oR
         LcUJblncmC1jbtnRay7QWpQF0YEXekt7piqiMrwf271c7tQK9j7ZBZ+kygFmLtSZbu
         twUd50ArBli6uMZWn51/6Qk7qBBC+M8tSGhN0ozc=
Date:   Sat, 5 Feb 2022 05:40:14 +0200
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
Subject: Re: [PATCH 6/8] media: imx: imx7_media-csi: Add support for
 additional Bayer patterns
Message-ID: <Yf3xni8i4AAOZ7HF@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <20220204121514.2762676-7-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204121514.2762676-7-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thank you for the patch.

On Fri, Feb 04, 2022 at 01:15:12PM +0100, Alexander Stein wrote:
> imx7_csi_configure() allows configuring these Bayer patterns when
> starting a stream. So allow these in link_validate() as well.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> I'm wondering if V4L2_PIX_FMT_SBGGR16 (and their variants) is correct in this
> function. imx7_csi_configure() does not list MEDIA_BUS_FMT_Sxxxx16_1X16.
> Also I can't find a proper a proper setting in CSI_CR18 of CSI Bridge in
> IMX8M Mini RM for RAW16. The feature list names a  "16-bit data port for
> Bayer data input", but is it actually supported? I do not know anything about
> the MIPI CSI data formats though. Maybe someone else can clarify this.

The CSI bridge has a 16-bit input. The MIPI_DATA_FORMAT field in CR18
maps to the CSI-2 DT value, and it's not clear if it's only used to
filter on the CSI-2 DT, or if it does more than that. If we're lucky,
it's the former and we can just use 0x2e.

>  drivers/staging/media/imx/imx7-media-csi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index 158d2a736c6d..7e737221f187 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1004,6 +1004,18 @@ static int imx7_csi_pad_link_validate(struct v4l2_subdev *sd,
>  	case V4L2_PIX_FMT_SGBRG8:
>  	case V4L2_PIX_FMT_SGRBG8:
>  	case V4L2_PIX_FMT_SRGGB8:
> +	case V4L2_PIX_FMT_SBGGR10:
> +	case V4L2_PIX_FMT_SGBRG10:
> +	case V4L2_PIX_FMT_SGRBG10:
> +	case V4L2_PIX_FMT_SRGGB10:
> +	case V4L2_PIX_FMT_SBGGR12:
> +	case V4L2_PIX_FMT_SGBRG12:
> +	case V4L2_PIX_FMT_SGRBG12:
> +	case V4L2_PIX_FMT_SRGGB12:
> +	case V4L2_PIX_FMT_SBGGR14:
> +	case V4L2_PIX_FMT_SGBRG14:
> +	case V4L2_PIX_FMT_SGRBG14:
> +	case V4L2_PIX_FMT_SRGGB14:
>  	case V4L2_PIX_FMT_SBGGR16:
>  	case V4L2_PIX_FMT_SGBRG16:
>  	case V4L2_PIX_FMT_SGRBG16:

-- 
Regards,

Laurent Pinchart
