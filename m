Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D42B4E69C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiCXU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353387AbiCXU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:26:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC4B8212;
        Thu, 24 Mar 2022 13:25:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1BC51852;
        Thu, 24 Mar 2022 21:25:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648153504;
        bh=ZZ2CK86gTTo7D1QQXMRiTg4e02nEdAmkkQoefa7UwzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8yrJ5DGX3+H0lQOXdNH7F4JLRswpatyhWBnZPfBLxvfMGhXCP3ewa/sC9dnwbPP9
         ypXAfeZXfpy2R24eIU8vfp9yabT8qj2omFQbj+O5bZqT4DrmBzz11tRIYclSqxUN4h
         doq1h4BrQuKtIIFdcYnPcF/61HXOKg8xu9HY/LG8=
Date:   Thu, 24 Mar 2022 22:25:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v2] media: uvcvideo: Fix handling on Bitmask controls
Message-ID: <YjzTnlf92rY/X6Lv@pendragon.ideasonboard.com>
References: <20220215184228.2531386-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215184228.2531386-1-ribalda@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Feb 15, 2022 at 06:42:28PM +0000, Ricardo Ribalda wrote:
> Minimum and step values for V4L2_CTRL_TYPE_BITMASK controls should be 0.
> There is no need to query the camera firmware about this and maybe get
> invalid results.
> 
> Also value should be clamped to the min/max value advertised by the
> hardware.
> 
> Fixes v4l2-compliane:
> Control ioctls (Input 0):
>                 fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL

What bitmask control do you have ? The driver has no standard control
that use the V4L2_CTRL_TYPE_BITMASK type.

UVC doesn't formally define bitmask control type
(UVC_CTRL_DATA_TYPE_BITMASK). In UVC 1.1 only the UVC_CT_AE_MODE_CONTROL
control has a bitmap type, and only one bit can be set at a type. It
thus maps to a V4L2 menu control.

In UVC 1.5 there are other controls documented as bitmap controls,
which could map to the V4L2 bitmask control type. Those don't support
GET_MIN and GET_MAX, but use GET_RES to report the list of bits that can
be set. This should be mapped to the V4L2 control maximum value, which
isn't handled by this patch. The last hunk is also incorrect, as it
clamps the value to what is reported by GET_MIN and GET_MAX, instead of
[0, GET_RES], but more than that, it should not just clamp the value,
but check that all bits are valid.

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index b4f6edf968bc0..d8b9ab5b7fb85 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1156,7 +1156,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  		break;
>  	}
>  
> -	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
> +	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN &&
> +	    mapping->v4l2_type != V4L2_CTRL_TYPE_BITMASK)
>  		v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
>  				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>  
> @@ -1164,7 +1165,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
>  				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>  
> -	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
> +	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES &&
> +	    mapping->v4l2_type != V4L2_CTRL_TYPE_BITMASK)
>  		v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
>  				  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>  
> @@ -1721,6 +1723,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  	/* Clamp out of range values. */
>  	switch (mapping->v4l2_type) {
>  	case V4L2_CTRL_TYPE_INTEGER:
> +	case V4L2_CTRL_TYPE_BITMASK:
>  		if (!ctrl->cached) {
>  			ret = uvc_ctrl_populate_cache(chain, ctrl);
>  			if (ret < 0)

-- 
Regards,

Laurent Pinchart
