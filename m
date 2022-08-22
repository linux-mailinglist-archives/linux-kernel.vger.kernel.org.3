Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4185159C02D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiHVNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiHVNHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:07:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64573356F3;
        Mon, 22 Aug 2022 06:07:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A9F662B3;
        Mon, 22 Aug 2022 15:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661173648;
        bh=EgK/lj3WOzFoJY3t5OghKCjX9nJhMCtuKrfeio3gCCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYLRqJKpqNWSi7RoHVeSnd6+lUMgxA3Y5yXyXQ8XcX0c8wl8vUdp1lgFj5i6Poaru
         jNl6GqmffjTFvqC03B8TewA/SOnPcxnoChOCEdwuAalv4KDCUw1Xi9UzKwjtDbWqvX
         RCko36GpWZG2S3m5TEsCdhLLIDws/2mRU7QSntsM=
Date:   Mon, 22 Aug 2022 16:07:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix InterfaceProtocol for Quanta camera
Message-ID: <YwN/jeElxyXpyyfU@pendragon.ideasonboard.com>
References: <20220808134106.70100-1-ribalda@chromium.org>
 <YwN+fU5ez0L5pi1j@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwN+fU5ez0L5pi1j@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 04:02:55PM +0300, Laurent Pinchart wrote:
> Hi Ricardo,
> 
> Thank you for the patch.
> 
> On Mon, Aug 08, 2022 at 03:41:06PM +0200, Ricardo Ribalda wrote:
> > The device is using a different InterfaceProtocol than the one set in
> > the original quirk.

Also, I would mention that the device implements UVC 1.5:

The Quanta 0408:4034 camera implements UVC 1.5, and thus sets
bInterfaceProtocol to UVC_PC_PROTOCOL_15. Commit 95f03d973478 ("media:
uvcvideo: Limit power line control for Quanta cameras") added a quirk
for the device that incorrectly specified the UVC 1.0 protocol,
rendering the quirk inoperative. Fix it.

As this is a v6.0 fix, would you mind submitting a v2 with these changes
? Mauro could then pick it up directly.

> > Fixes: 95f03d973478 ("media: uvcvideo: Limit power line control for Quanta cameras")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > 
> > This was fixed on the last version of the patchset. Unfortunately I did
> > checked that it was the version merged :(.
> 
> Oops :-(
> 
> > It is too late to land it in this version?
> 
> I think it can be considered as a v6.0 fix, yes.
> 
> >  drivers/media/usb/uvc/uvc_driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 9c05776f11d1..6556158a8888 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2740,7 +2740,7 @@ static const struct usb_device_id uvc_ids[] = {
> >  	  .idProduct		= 0x4034,
> >  	  .bInterfaceClass	= USB_CLASS_VIDEO,
> >  	  .bInterfaceSubClass	= 1,
> > -	  .bInterfaceProtocol	= 0,
> > +	  .bInterfaceProtocol	= 1,
> 
> Should we use UVC_PC_PROTOCOL_15 here ?
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> >  	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> >  	/* LogiLink Wireless Webcam */
> >  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE

-- 
Regards,

Laurent Pinchart
