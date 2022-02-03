Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955834A7E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349117AbiBCDSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiBCDSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:18:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8CEC061714;
        Wed,  2 Feb 2022 19:18:49 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 937DA49C;
        Thu,  3 Feb 2022 04:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643858326;
        bh=Us7yjbixGu6dCaNBJ+ZZazneoSNXAmdN3op7smSm4tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jk6onqyHbJrL19lqRtijgJLskTuvKAx6L82rr2jxE/2zP7U1oIpn/80ZohHjB1n+a
         1PL14VZsCSotncKq2RqOMdo64xBK1v/es9avU1LBhZaFx6YdRbcob4a1wbLUTLR6xR
         iDgDY+uz753AAI4n6rC0R33r6IZNeMKGSQo9zdUY=
Date:   Thu, 3 Feb 2022 05:18:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Only create input devs if hw
 supports it
Message-ID: <YftJff6gxQ96TnI1@pendragon.ideasonboard.com>
References: <20220124190013.221601-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124190013.221601-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Mon, Jan 24, 2022 at 08:00:12PM +0100, Ricardo Ribalda wrote:
> Examine the stream headers to figure out if the device has a GPIO and
> can be used as an input.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_status.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index 753c8226db70..3ef0b281ffc5 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -18,11 +18,34 @@
>   * Input device
>   */
>  #ifdef CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV
> +
> +static bool uvc_input_has_button(struct uvc_device *dev)
> +{
> +	struct uvc_streaming *stream;
> +
> +	/*
> +	 * The device has GPIO button event if both bTriggerSupport and

The UVC specification doesn't talk about GPIOs but about buttons. With
s/GPIO button event/button events/ here and s/GPIO/button/ in the commit
message,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	 * bTriggerUsage are one. Otherwise the camera button does not
> +	 * exist or is handled automatically by the camera without host
> +	 * driver or client application intervention.
> +	 */
> +	list_for_each_entry(stream, &dev->streams, list) {
> +		if (stream->header.bTriggerSupport == 1 &&
> +		    stream->header.bTriggerUsage == 1)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int uvc_input_init(struct uvc_device *dev)
>  {
>  	struct input_dev *input;
>  	int ret;
>  
> +	if (!uvc_input_has_button(dev))
> +		return 0;
> +
>  	input = input_allocate_device();
>  	if (input == NULL)
>  		return -ENOMEM;

-- 
Regards,

Laurent Pinchart
