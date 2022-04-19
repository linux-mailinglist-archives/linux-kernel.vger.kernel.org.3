Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B195506C26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352196AbiDSMUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352175AbiDSMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:20:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735325E90;
        Tue, 19 Apr 2022 05:17:44 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-11-253-nat.elisa-mobile.fi [85.76.11.253])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA2F025B;
        Tue, 19 Apr 2022 14:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650370662;
        bh=P4gIXFtrwQDyN+C6uar+ovwXk6cY3/kQnY32ADsmRFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nblueKlxS7o0DUw7O83Z6nlkNHVGWJx3nEW/tkbsh8zQS7Optx6iFbxnCGdlW17/s
         FaISR5gqVn8baPQaPnAoBPQ3WcRoMx6u2U6QKG1VqtJSi97c+TGFqnBBlR1+3b7Sey
         Ym2OK+uF5V3EpFy5szf/7evp7dUwZLrCVOh8zYB4=
Date:   Tue, 19 Apr 2022 15:17:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     James_Lin <Ping-lei.Lin@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, sherlock.chang@mediatek.com,
        lecopzer.chen@mediatek.com, max.yan@mediatek.com,
        tm.wu@mediatek.com
Subject: Re: [PATCH v3] media: usb: uvc: Add UVC_GUID_FORMAT_H265
Message-ID: <Yl6oYlv+t63+5dVP@pendragon.ideasonboard.com>
References: <20220418090652.3156-1-Ping-lei.Lin@mediatek.com>
 <CANiDSCvLb785H7qyAzSfTSBRpO2eM-oJFF5SgVHXdL1O-GusLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCvLb785H7qyAzSfTSBRpO2eM-oJFF5SgVHXdL1O-GusLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 19, 2022 at 01:46:15PM +0200, Ricardo Ribalda wrote:
> On Mon, 18 Apr 2022 at 11:07, James_Lin <Ping-lei.Lin@mediatek.com> wrote:
> >
> > This patch aims to add UVC_GUID_FORMAT_H265
> > High Efficiency Video Coding (HEVC), also known as H.265 and MPEG-H Part 2.
> > They describe the same video encoding method.
> > So for handling their behavior is the same.
> > However, when external camera device describes this encoding method,
> > some use hevc, some use h265.
> > There is no uniform specification to describe this encoding method.
> > So if an external camera device use h265 to describe this encoding method,
> > driver will not recognize it.
> > Therefore, this patch is to enable driver to read HEVC/H265
> > and convert it to V4L2_PIX_FMT_HEVC.
> >
> > Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> 
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 5 +++++
> >  drivers/media/usb/uvc/uvcvideo.h   | 3 +++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index dda0f0aa78b8..e437e9f95890 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] = {
> >                 .guid           = UVC_GUID_FORMAT_H264,
> >                 .fcc            = V4L2_PIX_FMT_H264,
> >         },
> 
> Maybe I would add a comment here saying that some cameras represent
> hevc as h265.

I wish there would be a 4CC and GUID standard with a centralized
registry...

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > +       {
> > +               .name           = "H.265",
> > +               .guid           = UVC_GUID_FORMAT_H265,
> > +               .fcc            = V4L2_PIX_FMT_HEVC,
> > +       },
> >         {
> >                 .name           = "Greyscale 8 L/R (Y8I)",
> >                 .guid           = UVC_GUID_FORMAT_Y8I,
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 143230b3275b..41f4d8c33f2a 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -139,6 +139,9 @@
> >  #define UVC_GUID_FORMAT_H264 \
> >         { 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
> >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > +#define UVC_GUID_FORMAT_H265 \
> > +       { 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
> > +        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> >  #define UVC_GUID_FORMAT_Y8I \
> >         { 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
> >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}

-- 
Regards,

Laurent Pinchart
