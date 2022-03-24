Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56F84E6470
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350651AbiCXNx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiCXNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:53:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9C3A0BD0;
        Thu, 24 Mar 2022 06:52:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95BFA1844;
        Thu, 24 Mar 2022 14:52:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648129942;
        bh=Te4JoDgpbXFsVGceZJvYn38hZ74flQXo5Sw37WpMpKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqwSUXrxZf6f/CZbctAv3jiH2aj0s8MNbIBCUa15+8DM8laiikUAH4rCuJ3Oho75k
         8a/Z0AgdZ0ONPGficbWLe0XgAJW1xvzCOOoUp2hIB4pzcr5ABNC2fUcKpI3U4OB9gV
         N/JFgWE2z5Av42vYk2hkHEmMc+6/wR58zaI6Bk0o=
Date:   Thu, 24 Mar 2022 15:52:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvc_video: fix bit overflow in uvc_probe_video
Message-ID: <Yjx3laKM9Ah+1PRC@pendragon.ideasonboard.com>
References: <20220324091308.44799-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324091308.44799-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

Thank you for the patch.

On Thu, Mar 24, 2022 at 05:13:08PM +0800, Hangyu Hua wrote:
> probe->dwMaxPayloadTransferSize is a 32bit value, but bandwidth is 16bit. This
> may lead to a bit overflow.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 1b4cc934109e..cc4878373aa7 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -383,7 +383,7 @@ int uvc_probe_video(struct uvc_streaming *stream,
>  	struct uvc_streaming_control *probe)
>  {
>  	struct uvc_streaming_control probe_min, probe_max;
> -	u16 bandwidth;
> +	u32 bandwidth;
>  	unsigned int i;
>  	int ret;
>  
> @@ -422,7 +422,7 @@ int uvc_probe_video(struct uvc_streaming *stream,
>  			break;
>  
>  		bandwidth = probe->dwMaxPayloadTransferSize;
> -		if (bandwidth <= stream->maxpsize)
> +		if (bandwidth <= (u32)stream->maxpsize)

The cast to u32 isn't needed, it's implicit.

This could actually be written

	if (probe->dwMaxPayloadTransferSize <= stream->maxpsize)

The bandwidth local variable can be dropped. Could you submit a v2 with
this change ?

>  			break;
>  
>  		if (stream->dev->quirks & UVC_QUIRK_PROBE_MINMAX) {

-- 
Regards,

Laurent Pinchart
