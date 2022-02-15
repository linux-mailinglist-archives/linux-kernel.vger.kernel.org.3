Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB104B64D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiBOH4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:56:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBOHz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:55:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15104BD2FF;
        Mon, 14 Feb 2022 23:55:50 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3C251315;
        Tue, 15 Feb 2022 08:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644911748;
        bh=GEG1DSIU4IWEDQo1Tjve/iWZVxcmw/Uh3L34YH4IHEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYKrZLZzrMFaORoM38qEaP4SvvTC6v5Isxn/jGst8UbY3h5KW6aNcqPpjJ7UtZTAY
         v+D5WcEDKJ64oidfc8yv6JuMU6m1MlqaR51W6d/OR2S9LunrBDvSuQshyti9Usv4Fg
         eJoarb61EwxWxXxjGRE+2MI+R0pVTTqRqEem5OTk=
Date:   Tue, 15 Feb 2022 09:55:41 +0200
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
Subject: Re: [PATCH v2 4/9] media: imx: Fail conversion if pixel format not
 supported
Message-ID: <YgtcfaJPpu9zx4pc@pendragon.ideasonboard.com>
References: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
 <20220211142752.779952-5-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211142752.779952-5-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander and Dorota,

Thank you for the patch.

On Fri, Feb 11, 2022 at 03:27:47PM +0100, Alexander Stein wrote:
> From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> 
> imx_media_find_mbus_format has NULL as a valid return value,
> therefore the caller should take it into account.
> 
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/staging/media/imx/imx-media-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 02a4cb124d37..e59aaa77172a 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -544,6 +544,9 @@ static int imx56_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
>  		cc = imx_media_find_mbus_format(code, PIXFMT_SEL_YUV);
>  	}
>  
> +	if (!cc)
> +		return -EINVAL;
> +
>  	/* Round up width for minimum burst size */
>  	width = round_up(mbus->width, 8);
>  

-- 
Regards,

Laurent Pinchart
