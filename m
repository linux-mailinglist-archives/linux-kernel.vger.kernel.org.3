Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785554F88E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382501AbiFQNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382472AbiFQNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:50:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32696433B8;
        Fri, 17 Jun 2022 06:50:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 597E2741;
        Fri, 17 Jun 2022 15:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655473799;
        bh=6HFQwJyFFUCTIY6mEX4k39R6zc6S/ycXDDjbNPTIYnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ0rR9GtDF27bT0g2FgKq9eR4R/zQnX9P2Xc05t4PZrfhfDGIsJaw1ejLMBYBtFtr
         vU2ccDUuePOGWOyGY96kEzR3vzB43eBBdeKZQpvnT2E4x08/rXQCwbEOG1n96cvLCZ
         O/erPvCxk00tRatUnZtrxjBupyJecf0gGpw8i08s=
Date:   Fri, 17 Jun 2022 16:49:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Subject: Re: [PATCH v7 3/8] media: uvcvideo: Support minimum for
 V4L2_CTRL_TYPE_MENU
Message-ID: <YqyGfFK3UXhrBLwK@pendragon.ideasonboard.com>
References: <20220617103645.71560-1-ribalda@chromium.org>
 <20220617103645.71560-4-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220617103645.71560-4-ribalda@chromium.org>
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

On Fri, Jun 17, 2022 at 12:36:40PM +0200, Ricardo Ribalda wrote:
> Currently all mappings of type V4L2_CTRL_TYPE_MENU, have a minimum of 0,
> but there are some controls (limited powerline), that start with a value
> different than 0.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 5 +++--
>  drivers/media/usb/uvc/uvcvideo.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 092decfdaa62..3b20b23abd1e 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1144,7 +1144,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  
>  	switch (mapping->v4l2_type) {
>  	case V4L2_CTRL_TYPE_MENU:
> -		v4l2_ctrl->minimum = 0;
> +		v4l2_ctrl->minimum = mapping->menu_min;
>  		v4l2_ctrl->maximum = mapping->menu_count - 1;
>  		v4l2_ctrl->step = 1;
>  
> @@ -1264,7 +1264,8 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  		goto done;
>  	}
>  
> -	if (query_menu->index >= mapping->menu_count) {
> +	if (query_menu->index < mapping->menu_min ||
> +	    query_menu->index >= mapping->menu_count) {
>  		ret = -EINVAL;
>  		goto done;
>  	}
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index fff5c5c99a3d..6ceb7f7b964d 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -254,6 +254,7 @@ struct uvc_control_mapping {
>  	u32 data_type;
>  
>  	const struct uvc_menu_info *menu_info;
> +	u32 menu_min;
>  	u32 menu_count;

That's a bit of a stop-gap measure, could we turn it into a bitmask
instead ?

>  
>  	u32 master_id;

-- 
Regards,

Laurent Pinchart
