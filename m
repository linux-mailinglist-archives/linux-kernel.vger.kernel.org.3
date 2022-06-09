Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3757054472D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbiFIJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiFIJSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:18:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACC1AF0E;
        Thu,  9 Jun 2022 02:18:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D622E6CF;
        Thu,  9 Jun 2022 11:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654766316;
        bh=XqbV2uJBHM4471KRakRKgntn/CTn4mUBsoshtAeVQLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYrYCVWJWjrDLZ6ycZDOMJq3GQi//h/AXg7U7ktS0/Dg3pYV8K3vjsdNjnkfbhXxC
         X8YWj4Yv9jR8ur4jIdcwV0QO2ak4QbKCIgPKtYj/glFLtEuQVETJZ8v0l3ttCrTZJc
         dL8DyLcPQa0jVJHwrPvACi3kAdwFgb3qUEUa3X7Q=
Date:   Thu, 9 Jun 2022 12:18:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix spurious DMA max segment size
 warnings
Message-ID: <YqG65hU4SLUrxMI7@pendragon.ideasonboard.com>
References: <20220609082246.13182-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220609082246.13182-1-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

(CC'ing Greg and the linux-usb mailing list)

Thank you for the patch.

On Thu, Jun 09, 2022 at 10:22:46AM +0200, Takashi Iwai wrote:
> As default, the DMA max segment size is set to 64k, and uvcvideo may
> overflow that size easily, resulting in a warning like:
> 
>   DMA-API: xhci_hcd 0000:00:14.0: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> 
> Explicitly set up the DMA max segment size for avoiding spurious kernel
> warnings.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 1b4cc934109e..25aa6e6a6906 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -2160,6 +2160,8 @@ int uvc_video_init(struct uvc_streaming *stream)
>  	for_each_uvc_urb(uvc_urb, stream)
>  		INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
>  
> +	dma_set_max_seg_size(uvc_stream_to_dmadev(stream), UINT_MAX);
> +

uvc_stream_to_dmadev() returns the pointer to the HCD's struct device,
which is shared between all drivers on the bus. Is it really fine for a
USB device driver to change the maximum segment size of the HCD device
directly ?

>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
