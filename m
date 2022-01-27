Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BE49E3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiA0NpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiA0NpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:45:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2BC061714;
        Thu, 27 Jan 2022 05:45:06 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74EAFBBE;
        Thu, 27 Jan 2022 14:45:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643291104;
        bh=mEl1zghtkHJtzO30DV6wfrtRC/5c6yz7+42K6o1o49Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDszjm6q1RZITKDTTbqKu9PTB5QXSazymbGLeUMppqwQk1nNHeo3S+j3wEh2uLVj6
         5AAbMJ2uOPoJo2pMsvEYUpWpwd7dEY6fvvd1dDbxal6jbnlglcxXjd0HUp++6i+cF5
         m9BRzid5ni2/l7LwrcmZbsSwpIQqnxAA7yhO5sKY=
Date:   Thu, 27 Jan 2022 15:44:43 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, lars@metafoo.de, mchehab@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: adv7180: Fix media bus format
Message-ID: <YfKhy62JGDx98JFg@pendragon.ideasonboard.com>
References: <20220127100947.150555-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127100947.150555-1-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Thu, Jan 27, 2022 at 11:09:47AM +0100, Jean-Michel Hautbois wrote:
> MEDIA_BUS_FMT_UYVY8_2X8 isn't correct for CSI-2. Use
> MEDIA_BUS_FMT_UYVY8_1X16 instead.

While that's right, I expect it will cause regressions. The driver
probably needs to support for media bus codes.

> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  drivers/media/i2c/adv7180.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> index d9a99fcfacb1..cbededfb6b3f 100644
> --- a/drivers/media/i2c/adv7180.c
> +++ b/drivers/media/i2c/adv7180.c
> @@ -655,7 +655,7 @@ static int adv7180_enum_mbus_code(struct v4l2_subdev *sd,
>  	if (code->index != 0)
>  		return -EINVAL;
>  
> -	code->code = MEDIA_BUS_FMT_UYVY8_2X8;
> +	code->code = MEDIA_BUS_FMT_UYVY8_1X16;
>  
>  	return 0;
>  }
> @@ -665,7 +665,7 @@ static int adv7180_mbus_fmt(struct v4l2_subdev *sd,
>  {
>  	struct adv7180_state *state = to_state(sd);
>  
> -	fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
> +	fmt->code = MEDIA_BUS_FMT_UYVY8_1X16;
>  	fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
>  	fmt->width = 720;
>  	fmt->height = state->curr_norm & V4L2_STD_525_60 ? 480 : 576;

-- 
Regards,

Laurent Pinchart
