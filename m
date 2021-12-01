Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179FB464557
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbhLADTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbhLADTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:19:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5BDC061746;
        Tue, 30 Nov 2021 19:15:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C79B2A5;
        Wed,  1 Dec 2021 04:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638328537;
        bh=wlCzj5WtPkkZo7MA6RstYeimR8KZkvsnApKEauN7Jts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CggsWlsUWwr4WFMc0gxawRn64x3UAF3iro1ksm3ZeJ7o0xy1zt2As+4zOT5qq1y9D
         yGNakPp20TNogsvRpDyYtGRjelCuVRswjOeLECqI5uNprFgrrl/7HzAkSp0TgapI9P
         Kg/hiGChafJvCqVrrvM1kI0U41oLBqBxbKqdTLqo=
Date:   Wed, 1 Dec 2021 05:15:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v2] media: uvcvideo: use dynamic allocation for
 uvc_copy_op
Message-ID: <YabowLdtOJwkXgpY@pendragon.ideasonboard.com>
References: <20210903045456.83301-1-kyeongdon.kim@lge.com>
 <CAPybu_10kUFE02QewKd7Lf3CVrJa5y4ogPfptViUfWzTh0W_qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPybu_10kUFE02QewKd7Lf3CVrJa5y4ogPfptViUfWzTh0W_qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:37:32PM +0100, Ricardo Ribalda Delgado wrote:
> Hi Kyeongdon
> 
> I fail to understand why your approach is faster than the original one.
> 
> Is it because of the alignment of struct uvc_copy_op copy_operations ?

I also wonder.

> On Fri, Sep 3, 2021 at 6:56 AM Kyeongdon Kim <kyeongdon.kim@lge.com> wrote:
> >
> > There are some issues to handle frame throughput with camera devices
> >
> > Using devices:
> > - Logitech Webcam
> > - Intel(R) RealSense(TM) Depth Camera
> >
> > To improve efficiency, and maximise throughput,
> > use dynamic allocation for uvc_copy_op.
> >
> > Change from struct uvc_copy_op copy_operations[UVC_MAX_PACKETS];
> > to struct uvc_copy_op *copy_operations;
> >
> > Now, only tested bulk video options.
> >
> > On test device & own debug log to check frame duration(us),
> > refer to test result the below:
> >
> > Use copy_operations[UVC_MAX_PACKETS]
> > [UVC] Check time duration(us) : 54732 / 66000
> > [UVC] Check time duration(us) : 57452 / 66000
> > [UVC] Check time duration(us) : 57413 / 66000
> > [UVC] Check time duration(us) : 56713 / 66000
> > [UVC] Check time duration(us) : 57967 / 66000
> >
> > Use *copy_operations
> > [UVC] Check time duration(us) : 30804 / 66000
> > [UVC] Check time duration(us) : 38642 / 66000
> > [UVC] Check time duration(us) : 26011 / 66000
> > [UVC] Check time duration(us) : 30116 / 66000
> > [UVC] Check time duration(us) : 29265 / 66000
> >
> > Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 55 ++++++++++++++++++++++++++++++++++++---
> >  drivers/media/usb/uvc/uvcvideo.h  |  3 ++-
> >  2 files changed, 54 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index e164646..3a7c131 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1614,6 +1614,36 @@ static void uvc_video_complete(struct urb *urb)
> >         queue_work(stream->async_wq, &uvc_urb->work);
> >  }
> >
> > +static void uvc_free_urb_cop(struct uvc_streaming *stream)
> > +{
> > +       struct uvc_urb *uvc_urb;
> > +
> > +       for_each_uvc_urb(uvc_urb, stream) {
> > +               if (uvc_urb->copy_operations) {

You can drop this check, kfree() is a no-op when called with a NULL
pointer.

> > +                       kfree(uvc_urb->copy_operations);
> > +                       uvc_urb->copy_operations = NULL;

Wouldn't it be better to move this to uvc_free_urb_buffers() ?

> > +               }
> > +       }
> > +}
> > +
> > +static int uvc_alloc_urb_cop(struct uvc_streaming *stream, gfp_t gfp_flags)
> > +{
> > +       int max_packet = stream->urb_max_packets;

unsigned int. But you can drop the line, see below.

> > +       struct uvc_urb *uvc_urb;
> > +
> > +       for_each_uvc_urb(uvc_urb, stream) {
> > +               uvc_urb->copy_operations
> > +                               = kcalloc(max_packet, sizeof(struct uvc_copy_op), gfp_flags);

sizeof(variable) is preferred over sizeof(type).

		uvc_urb->copy_operations = kcalloc(stream->urb_max_packets,
						   sizeof(*uvc_urb->copy_operations),
						   gfp_flags);

> > +               if (uvc_urb->copy_operations == NULL)
> > +                       goto error;
> > +       }
> > +       return 0;

Blank line.

> > +error:
> > +       uvc_free_urb_cop(stream);
> > +
> > +       return -ENOMEM;
> > +}
> > +
> >  /*
> >   * Free transfer buffers.
> >   */
> > @@ -1687,8 +1717,8 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
> >          * payloads across multiple URBs.
> >          */
> >         npackets = DIV_ROUND_UP(size, psize);
> > -       if (npackets > UVC_MAX_PACKETS)
> > -               npackets = UVC_MAX_PACKETS;
> > +       if (npackets > stream->urb_max_packets)
> > +               npackets = stream->urb_max_packets;
> >
> >         /* Retry allocations until one succeed. */
> >         for (; npackets > 1; npackets /= 2) {
> > @@ -1744,8 +1774,10 @@ static void uvc_video_stop_transfer(struct uvc_streaming *stream,
> >                 uvc_urb->urb = NULL;
> >         }
> >
> > -       if (free_buffers)
> > +       if (free_buffers) {
> >                 uvc_free_urb_buffers(stream);
> > +               uvc_free_urb_cop(stream);
> > +       }
> >  }
> >
> >  /*
> > @@ -1790,10 +1822,18 @@ static int uvc_init_video_isoc(struct uvc_streaming *stream,
> >         psize = uvc_endpoint_max_bpi(stream->dev->udev, ep);
> >         size = stream->ctrl.dwMaxVideoFrameSize;
> >
> > +       stream->urb_max_packets = UVC_MAX_PACKETS;
> > +
> >         npackets = uvc_alloc_urb_buffers(stream, size, psize, gfp_flags);
> >         if (npackets == 0)
> >                 return -ENOMEM;
> >
> > +       if (uvc_alloc_urb_cop(stream, gfp_flags) != 0) {
> > +               uvc_dbg(stream->dev, VIDEO,
> > +                               "Failed to init URBs copy operations.\n");

This message should move to uvc_alloc_urb_cop(). I would also propagate
the error:

	ret = uvc_alloc_urb_cop(stream, gfp_flags);
	if (ret < 0)
		return ret;

But it would be better to call this from uvc_alloc_urb_buffers().

> > +               return -ENOMEM;
> > +       }
> > +
> >         size = npackets * psize;
> >
> >         for_each_uvc_urb(uvc_urb, stream) {
> > @@ -1842,11 +1882,18 @@ static int uvc_init_video_bulk(struct uvc_streaming *stream,
> >         psize = usb_endpoint_maxp(&ep->desc);
> >         size = stream->ctrl.dwMaxPayloadTransferSize;
> >         stream->bulk.max_payload_size = size;
> > +       stream->urb_max_packets = DIV_ROUND_UP(size, psize);

This is an important change that should be explained in the commit
message. It may even deserve a patch of its own.

> >
> >         npackets = uvc_alloc_urb_buffers(stream, size, psize, gfp_flags);
> >         if (npackets == 0)
> >                 return -ENOMEM;
> >
> > +       if (uvc_alloc_urb_cop(stream, gfp_flags) != 0) {
> > +               uvc_dbg(stream->dev, VIDEO,
> > +                               "Failed to init URBs copy operations.\n");
> > +               return -ENOMEM;
> > +       }
> > +
> >         size = npackets * psize;
> >
> >         if (usb_endpoint_dir_in(&ep->desc))
> > @@ -2147,6 +2194,8 @@ int uvc_video_init(struct uvc_streaming *stream)
> >                 }
> >         }
> >
> > +       stream->urb_max_packets = UVC_MAX_PACKETS;
> > +
> >         /* Prepare asynchronous work items. */
> >         for_each_uvc_urb(uvc_urb, stream)
> >                 INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index cce5e38..00cf6c9 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -561,7 +561,7 @@ struct uvc_urb {
> >         struct sg_table *sgt;
> >
> >         unsigned int async_operations;
> > -       struct uvc_copy_op copy_operations[UVC_MAX_PACKETS];
> > +       struct uvc_copy_op *copy_operations;
> >         struct work_struct work;
> >  };
> >
> > @@ -616,6 +616,7 @@ struct uvc_streaming {
> >
> >         struct uvc_urb uvc_urb[UVC_URBS];
> >         unsigned int urb_size;
> > +       unsigned int urb_max_packets;
> >
> >         u32 sequence;
> >         u8 last_fid;

-- 
Regards,

Laurent Pinchart
