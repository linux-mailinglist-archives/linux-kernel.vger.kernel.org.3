Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C74CD408
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiCDMKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiCDMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:10:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C11A6F83;
        Fri,  4 Mar 2022 04:09:50 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA4DF51C;
        Fri,  4 Mar 2022 13:09:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646395789;
        bh=V3tPVMEO+Jq2klZv9qatnhwYwoLpYgaa6zzWUUOn5XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPF+PX5xMyBl+3ZOhN5TT74AfjoyDD68PReLFygt7fsddbZoCvL3QVsR2BtLo3wYV
         Lr3GQhO0VCxU0UPqqJrQiRB3GlAr3MF5FiJv1FJPTNq5DjN/piozKnoV0gt4gsZk4L
         NE+J29i+BvoKsXE3AN8Rsf66oCCo7uubKf7C8E2o=
Date:   Fri, 4 Mar 2022 14:09:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     xkernel.wang@foxmail.com
Cc:     sakari.ailus@iki.fi, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: omap3isp: check the return of __ccp2_get_format()
Message-ID: <YiIBgDA7PQHYS59h@pendragon.ideasonboard.com>
References: <tencent_E6A97F6B1009E6F65C230E070A9770612507@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_E6A97F6B1009E6F65C230E070A9770612507@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiaoke,

Thank you for the patch.

On Fri, Mar 04, 2022 at 07:48:18PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> __ccp2_get_format() returns format structure or NULL on error.
> So it is better to check the return value of it to prevent potential
> wrong memory access.

The function can actually never return NULL if it's called with a valid
pad number, which should always be the case as far as I can tell (since
commit a8fa55078a778). This patch is thus not needed.

> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/media/platform/omap3isp/ispccp2.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/omap3isp/ispccp2.c b/drivers/media/platform/omap3isp/ispccp2.c
> index acb58b6..81881b1 100644
> --- a/drivers/media/platform/omap3isp/ispccp2.c
> +++ b/drivers/media/platform/omap3isp/ispccp2.c
> @@ -675,8 +675,10 @@ static void ccp2_try_format(struct isp_ccp2_device *ccp2,
>  		 */
>  		format = __ccp2_get_format(ccp2, sd_state, CCP2_PAD_SINK,
>  					   which);
> -		memcpy(fmt, format, sizeof(*fmt));
> -		fmt->code = MEDIA_BUS_FMT_SGRBG10_1X10;
> +		if (format != NULL) {
> +			memcpy(fmt, format, sizeof(*fmt));
> +			fmt->code = MEDIA_BUS_FMT_SGRBG10_1X10;
> +		}
>  		break;
>  	}
>  
> @@ -709,6 +711,9 @@ static int ccp2_enum_mbus_code(struct v4l2_subdev *sd,
>  
>  		format = __ccp2_get_format(ccp2, sd_state, CCP2_PAD_SINK,
>  					   code->which);
> +		if (format == NULL)
> +			return -EINVAL;
> +
>  		code->code = format->code;
>  	}
>  
> @@ -792,6 +797,9 @@ static int ccp2_set_format(struct v4l2_subdev *sd,
>  	if (fmt->pad == CCP2_PAD_SINK) {
>  		format = __ccp2_get_format(ccp2, sd_state, CCP2_PAD_SOURCE,
>  					   fmt->which);
> +		if (format == NULL)
> +			return -EINVAL;
> +
>  		*format = fmt->format;
>  		ccp2_try_format(ccp2, sd_state, CCP2_PAD_SOURCE, format,
>  				fmt->which);

-- 
Regards,

Laurent Pinchart
