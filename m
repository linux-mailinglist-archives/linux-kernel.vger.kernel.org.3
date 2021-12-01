Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41C34644F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbhLAClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:41:00 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50626 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346180AbhLACkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:40:37 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A2D08AE;
        Wed,  1 Dec 2021 03:37:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638326234;
        bh=G8ibmo7g8I2RzAw+GgWkSmZiLSIlyII0HeGLTSnYgYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TU8TWiolzRVmBNer0YyWniwoCCvBm/57RG90yku/U13j0YwzDe8g8bgT3swpf83rf
         xug9vJydct1P8R/Oaw4FP/Rk34GaHD/jHDNbHBogbyeT6MSy4FrjU/Q+E13FxZXO7/
         80HFpd7pSFu/aKQPbw1I/mNXYrHvFSIlXo4/900A=
Date:   Wed, 1 Dec 2021 04:36:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: uvcvideo: Avoid invalid memory access
Message-ID: <YabfwZQvlQfadAhl@pendragon.ideasonboard.com>
References: <20211130155026.1082594-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130155026.1082594-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Nov 30, 2021 at 03:50:25PM +0000, Ricardo Ribalda wrote:
> If mappings points to an invalid memory, we will be invalid accessing
> it.
> Solve it by initializing the value of the variable mapping and by
> changing the order in the conditional statement (to avoid accessing
> mapping->id if not needed).
> 
> Fix:
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN NOPTI
> 
> Fixes: 6350d6a4ed487 ("media: uvcvideo: Set error_idx during ctrl_commit errors")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 30bfe9069a1fb..f7b7add3cfa59 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -852,8 +852,8 @@ static void __uvc_find_control(struct uvc_entity *entity, u32 v4l2_id,
>  				return;
>  			}
>  
> -			if ((*mapping == NULL || (*mapping)->id > map->id) &&
> -			    (map->id > v4l2_id) && next) {
> +			if (next && (map->id > v4l2_id) &&
> +			    (*mapping == NULL || (*mapping)->id > map->id)) {
>  				*control = ctrl;
>  				*mapping = map;
>  			}
> @@ -1638,7 +1638,7 @@ static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
>  				  struct v4l2_ext_controls *ctrls,
>  				  struct uvc_control *uvc_control)
>  {
> -	struct uvc_control_mapping *mapping;
> +	struct uvc_control_mapping *mapping = NULL;

It seems to me that either change will fix the bug, we don't need both,
is that right ? If so I'd drop the change to __uvc_find_control(), as it
seems quite fragile to allow mapping to be uninitialized.

>  	struct uvc_control *ctrl_found;
>  	unsigned int i;
>  

-- 
Regards,

Laurent Pinchart
