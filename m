Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9450D57F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiDXWHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiDXWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:07:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915B54697;
        Sun, 24 Apr 2022 15:04:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 92131822;
        Mon, 25 Apr 2022 00:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650837857;
        bh=r46ShRAcDqpoKdBbLpASO9i+HH59TI1+EaMgiwY8r8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aotRcrCKGhT/CB0CNuD2sRNaiGkTn1q1gCoBfQiJYTEkMxJy/suxTeBrMifBhzKxP
         HW8o7kt74XYaIYdwqJTT1GgxgIGJc9xpEhn8L/fkl7/4iO8fc8MVYX/mJxxL7tbiQU
         Y9dXF/RrzFrcGMq9mZeN9LKXiOY/pFSfwIsh2VxA=
Date:   Mon, 25 Apr 2022 01:04:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     James_Lin <Ping-lei.Lin@mediatek.com>
Cc:     nicolas@ndufresne.ca, acourbot@chromium.org, arnd@arndb.de,
        ezequiel@vanguardiasur.com.ar, hverkuil-cisco@xs4all.nl,
        lecopzer.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        max.yan@mediatek.com, mchehab@kernel.org, ribalda@chromium.org,
        sakari.ailus@linux.intel.com, senozhatsky@chromium.org,
        sherlock.chang@mediatek.com, tm.wu@mediatek.com
Subject: Re: [PATCH v3] media: usb: uvc: Add UVC_GUID_FORMAT_H265
Message-ID: <YmXJYUvJMGCXb9kt@pendragon.ideasonboard.com>
References: <4b6b65e72b3f3cd74af5a3f0069838c86a6725e9.camel@ndufresne.ca>
 <20220421092354.16774-1-Ping-lei.Lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421092354.16774-1-Ping-lei.Lin@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Apr 21, 2022 at 05:23:54PM +0800, James_Lin wrote:
> Hi All,
> 
> Do I need to add the comment 
> "some cameras represent hevc as h265"
> at /drivers/media/usb/uvc/uvc_driver.c ?
> Also, is there anything else that needs to be modified?
> 
> Or can it move to queue on next merged window?
> thanks for your reply

I've queued the patch in my tree and will send a pull request. I don't
think we need an additional comment, H.265 and HEVC being used
interchangeably isn't specific to UVC, and if someone gets puzzled by
this in the uvcvideo driver, there's always the git history.

> On WED, 20 Apr 2022 at 01:37, Nicolas Dufresne wrote:
> > Le mardi 19 avril 2022 à 14:18 +0200, Ricardo Ribalda a écrit :
> > > On Tue, 19 Apr 2022 at 14:17, Laurent Pinchart wrote:
> > > > On Tue, Apr 19, 2022 at 01:46:15PM +0200, Ricardo Ribalda wrote:
> > > > > On Mon, 18 Apr 2022 at 11:07, James_Lin <Ping-lei.Lin@mediatek.com> wrote:
> > > > > > 
> > > > > > This patch aims to add UVC_GUID_FORMAT_H265 High Efficiency 
> > > > > > Video Coding (HEVC), also known as H.265 and MPEG-H Part 2.
> > > > > > They describe the same video encoding method.
> > > > > > So for handling their behavior is the same.
> > > > > > However, when external camera device describes this encoding 
> > > > > > method, some use hevc, some use h265.
> > > > > > There is no uniform specification to describe this encoding method.
> > > > > > So if an external camera device use h265 to describe this 
> > > > > > encoding method, driver will not recognize it.
> > > > > > Therefore, this patch is to enable driver to read HEVC/H265 and 
> > > > > > convert it to V4L2_PIX_FMT_HEVC.
> > > > > > 
> > > > > > Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> > > > > 
> > > > > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_driver.c | 5 +++++
> > > > > >  drivers/media/usb/uvc/uvcvideo.h   | 3 +++
> > > > > >  2 files changed, 8 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c 
> > > > > > b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > index dda0f0aa78b8..e437e9f95890 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > @@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] = {
> > > > > >                 .guid           = UVC_GUID_FORMAT_H264,
> > > > > >                 .fcc            = V4L2_PIX_FMT_H264,
> > > > > >         },
> > > > > 
> > > > > Maybe I would add a comment here saying that some cameras 
> > > > > represent hevc as h265.
> > > > 
> > > > I wish there would be a 4CC and GUID standard with a centralized 
> > > > registry...
> > > 
> > > Thought that was the kernel codebase :)
> > 
> > You'll find multiple fourcc for the same thing in the linux kernel ;-P
> > 
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > 
> > > > > > +       {
> > > > > > +               .name           = "H.265",
> > > > > > +               .guid           = UVC_GUID_FORMAT_H265,
> > > > > > +               .fcc            = V4L2_PIX_FMT_HEVC,
> > > > > > +       },
> > > > > >         {
> > > > > >                 .name           = "Greyscale 8 L/R (Y8I)",
> > > > > >                 .guid           = UVC_GUID_FORMAT_Y8I,
> > > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h 
> > > > > > b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > index 143230b3275b..41f4d8c33f2a 100644
> > > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > @@ -139,6 +139,9 @@
> > > > > >  #define UVC_GUID_FORMAT_H264 \
> > > > > >         { 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
> > > > > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > > > > +#define UVC_GUID_FORMAT_H265 \
> > > > > > +       { 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
> > > > > > +        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > > > >  #define UVC_GUID_FORMAT_Y8I \
> > > > > >         { 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
> > > > > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}

-- 
Regards,

Laurent Pinchart
