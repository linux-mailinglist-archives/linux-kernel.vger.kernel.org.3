Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38B4B148B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiBJRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:48:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245319AbiBJRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:48:29 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC35210EA;
        Thu, 10 Feb 2022 09:48:26 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 9736EE000A;
        Thu, 10 Feb 2022 17:48:20 +0000 (UTC)
Date:   Thu, 10 Feb 2022 18:49:27 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jacopo+renesas@jmondi.org,
        hverkuil-cisco@xs4all.nl, Nicolas.Ferre@microchip.com,
        sakari.ailus@iki.fi, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v4 03/11] media: atmel: atmel-isc: implement media
 controller
Message-ID: <20220210174927.bk736t2ww4fkil6t@uno.localdomain>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
 <20220121131416.603972-4-eugen.hristev@microchip.com>
 <20220207124444.giyamcg2dgn6t3hv@uno.localdomain>
 <b456d5d5-e1ed-c896-482c-00598f92605f@microchip.com>
 <20220208085931.5rf5dueyb57zxlyk@uno.localdomain>
 <8ed88286-3959-03e9-e6e3-6b1675d7de4f@microchip.com>
 <20220208193059.qxitj5xb5cwiggkg@uno.localdomain>
 <0e768525-1a5a-e96f-eadf-79e82f3dc0bc@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e768525-1a5a-e96f-eadf-79e82f3dc0bc@microchip.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Wed, Feb 09, 2022 at 06:59:37AM +0000, Eugen.Hristev@microchip.com wrote:
> On 2/8/22 9:30 PM, Jacopo Mondi wrote:
> > Hi Eugen
> >
> > On Tue, Feb 08, 2022 at 10:33:31AM +0000, Eugen.Hristev@microchip.com wrote:
> >> On 2/8/22 10:59 AM, Jacopo Mondi wrote:
> >>> Hi Eugen
> >>>
> >>> On Mon, Feb 07, 2022 at 01:40:31PM +0000, Eugen.Hristev@microchip.com wrote:
> >>>> On 2/7/22 2:44 PM, Jacopo Mondi wrote:
> >>>>> Hi Eugen
> >>>>>
> >>>>> On Fri, Jan 21, 2022 at 03:14:08PM +0200, Eugen Hristev wrote:
> >>>>>> Implement the support for media-controller.
> >>>>>> This means that the capabilities of the driver have changed and now
> >>>>>> it also advertises the IO_MC .
> >>>>>> The driver will register it's media device, and add the video entity to this
> >>>>>> media device. The subdevices are registered to the same media device.
> >>>>>> The ISC will have a base entity which is auto-detected as atmel_isc_base.
> >>>>>> It will also register a subdevice that allows cropping of the incoming frame
> >>>>>> to the maximum frame size supported by the ISC.
> >>>>>> The ISC will create a link between the subdevice that is asynchronously
> >>>>>> registered and the atmel_isc_scaler entity.
> >>>>>> Then, the atmel_isc_scaler and atmel_isc_base are connected through another
> >>>>>> link.
> >>>>>>
> >>>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >>>>>> ---
> >>>>>> Changes in v4:
> >>>>>> As suggested by Jacopo:
> >>>>>> - renamed atmel_isc_mc to atmel_isc_scaler.c
> >>>>>> - moved init_mc/clean_mc to isc_base file
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>> - implement try formats
> >>>>>>
> >>>>>>     drivers/media/platform/atmel/Makefile         |   2 +-
> >>>>>>     drivers/media/platform/atmel/atmel-isc-base.c |  73 +++++-
> >>>>>>     .../media/platform/atmel/atmel-isc-scaler.c   | 245 ++++++++++++++++++
> >>>>>>     drivers/media/platform/atmel/atmel-isc.h      |  37 +++
> >>>>>>     .../media/platform/atmel/atmel-sama5d2-isc.c  |  14 +-
> >>>>>>     .../media/platform/atmel/atmel-sama7g5-isc.c  |  12 +-
> >>>>>>     6 files changed, 375 insertions(+), 8 deletions(-)
> >>>>>>     create mode 100644 drivers/media/platform/atmel/atmel-isc-scaler.c
> >>>>>>
> >>>>>> diff --git a/drivers/media/platform/atmel/Makefile b/drivers/media/platform/atmel/Makefile
> >>>>>> index 794e8f739287..f02d03df89d6 100644
> >>>>>> --- a/drivers/media/platform/atmel/Makefile
> >>>>>> +++ b/drivers/media/platform/atmel/Makefile
> >>>>>> @@ -1,7 +1,7 @@
> >>>>>>     # SPDX-License-Identifier: GPL-2.0-only
> >>>>>>     atmel-isc-objs = atmel-sama5d2-isc.o
> >>>>>>     atmel-xisc-objs = atmel-sama7g5-isc.o
> >>>>>> -atmel-isc-common-objs = atmel-isc-base.o atmel-isc-clk.o
> >>>>>> +atmel-isc-common-objs = atmel-isc-base.o atmel-isc-clk.o atmel-isc-scaler.o
> >>>>>>
> >>>>>>     obj-$(CONFIG_VIDEO_ATMEL_ISI) += atmel-isi.o
> >>>>>>     obj-$(CONFIG_VIDEO_ATMEL_ISC_BASE) += atmel-isc-common.o
> >>>>>> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> >>>>>> index 6b0005987a17..6b482270eb93 100644
> >>>>>> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> >>>>>> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> >>>>>> @@ -1710,6 +1710,7 @@ static int isc_async_bound(struct v4l2_async_notifier *notifier,
> >>>>>>                                                struct isc_device, v4l2_dev);
> >>>>>>          struct isc_subdev_entity *subdev_entity =
> >>>>>>                  container_of(notifier, struct isc_subdev_entity, notifier);
> >>>>>> +     int pad;
> >>>>>>
> >>>>>>          if (video_is_registered(&isc->video_dev)) {
> >>>>>>                  v4l2_err(&isc->v4l2_dev, "only supports one sub-device.\n");
> >>>>>> @@ -1718,6 +1719,16 @@ static int isc_async_bound(struct v4l2_async_notifier *notifier,
> >>>>>>
> >>>>>>          subdev_entity->sd = subdev;
> >>>>>>
> >>>>>> +     pad = media_entity_get_fwnode_pad(&subdev->entity, asd->match.fwnode,
> >>>>>> +                                       MEDIA_PAD_FL_SOURCE);
> >>>>>> +     if (pad < 0) {
> >>>>>> +             v4l2_err(&isc->v4l2_dev, "failed to find pad for %s\n",
> >>>>>> +                      subdev->name);
> >>>>>> +             return pad;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     isc->remote_pad = pad;
> >>>>>> +
> >>>>>>          return 0;
> >>>>>>     }
> >>>>>>
> >>>>>> @@ -1732,8 +1743,8 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
> >>>>>>          v4l2_ctrl_handler_free(&isc->ctrls.handler);
> >>>>>>     }
> >>>>>>
> >>>>>> -static struct isc_format *find_format_by_code(struct isc_device *isc,
> >>>>>> -                                           unsigned int code, int *index)
> >>>>>> +struct isc_format *isc_find_format_by_code(struct isc_device *isc,
> >>>>>> +                                        unsigned int code, int *index)
> >>>>>>     {
> >>>>>>          struct isc_format *fmt = &isc->formats_list[0];
> >>>>>>          unsigned int i;
> >>>>>> @@ -1749,6 +1760,7 @@ static struct isc_format *find_format_by_code(struct isc_device *isc,
> >>>>>>
> >>>>>>          return NULL;
> >>>>>>     }
> >>>>>> +EXPORT_SYMBOL_GPL(isc_find_format_by_code);
> >>>>>>
> >>>>>>     static int isc_formats_init(struct isc_device *isc)
> >>>>>>     {
> >>>>>> @@ -1765,7 +1777,7 @@ static int isc_formats_init(struct isc_device *isc)
> >>>>>>                 NULL, &mbus_code)) {
> >>>>>>                  mbus_code.index++;
> >>>>>>
> >>>>>> -             fmt = find_format_by_code(isc, mbus_code.code, &i);
> >>>>>> +             fmt = isc_find_format_by_code(isc, mbus_code.code, &i);
> >>>>>>                  if (!fmt) {
> >>>>>>                          v4l2_warn(&isc->v4l2_dev, "Mbus code %x not supported\n",
> >>>>>>                                    mbus_code.code);
> >>>>>> @@ -1891,7 +1903,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
> >>>>>>          vdev->queue             = q;
> >>>>>>          vdev->lock              = &isc->lock;
> >>>>>>          vdev->ctrl_handler      = &isc->ctrls.handler;
> >>>>>> -     vdev->device_caps       = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE;
> >>>>>> +     vdev->device_caps       = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE |
> >>>>>> +                               V4L2_CAP_IO_MC;
> >>>>>>          video_set_drvdata(vdev, isc);
> >>>>>>
> >>>>>>          ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> >>>>>> @@ -1901,8 +1914,18 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
> >>>>>>                  goto isc_async_complete_err;
> >>>>>>          }
> >>>>>>
> >>>>>> +     ret = isc_scaler_link(isc);
> >>>>>> +     if (ret < 0)
> >>>>>> +             goto isc_async_complete_unregister_device;
> >>>>>> +
> >>>>>> +     ret = media_device_register(&isc->mdev);
> >>>>>> +     if (ret < 0)
> >>>>>> +             goto isc_async_complete_unregister_device;
> >>>>>>          return 0;
> >>>>>>
> >>>>>> +isc_async_complete_unregister_device:
> >>>>>> +     video_unregister_device(vdev);
> >>>>>> +
> >>>>>>     isc_async_complete_err:
> >>>>>>          mutex_destroy(&isc->lock);
> >>>>>>          return ret;
> >>>>>> @@ -1969,6 +1992,48 @@ int isc_pipeline_init(struct isc_device *isc)
> >>>>>>     }
> >>>>>>     EXPORT_SYMBOL_GPL(isc_pipeline_init);
> >>>>>>
> >>>>>> +int isc_mc_init(struct isc_device *isc, u32 ver)
> >>>>>> +{
> >>>>>> +     const struct of_device_id *match;
> >>>>>> +     int ret;
> >>>>>> +
> >>>>>> +     isc->video_dev.entity.function = MEDIA_ENT_F_IO_V4L;
> >>>>>> +     isc->video_dev.entity.flags = MEDIA_ENT_FL_DEFAULT;
> >>>>>
> >>>>> Should you set entity.ops.link_validate = v4l2_subdev_link_validate
> >>>>> to be able to have the media pipeline validated at
> >>>>> media_pipeline_start() time ?
> >>>>
> >>>> Hi,
> >>>>
> >>>> I am doing that in a subsequent patch. Things are not completely ready
> >>>> at this moment, because ISC still relies on the old mechanism to call
> >>>> v4l2_subdev_call with set_fmt on the subdevice (which subsequent patch
> >>>> removes and adds checks to the link validate ).
> >>>>
> >>>
> >>> I see.. the subsequent patches are not part of this series, right ?
> >>
> >> No. Patch 7 does this. In that patch, the link validation is created and
> >> all the logic of format propagation is removed and reworked, and creates
> >> the need for the link_validate call
> >> Could you have also a look at that patch ?
> >
> > Ah ups, 7 was not in my inbox with the rest of the series. Just
> > noticed. I had even reviewed the previous version, I should have
> > remembered link_validate was added later
> >
> >>>
> >>> I think patches 1, 2, 4, 5 and 6 from this series do not depend on
> >>> the introduction of media controller or the scaler, right ? (I'm not
> >>> sure if the DTS patches do).
> >
> > Do DTS patches depend on media-controller plumbing ?
>
> I think not, but, I have not tested them without the media controller.
>
> >
> >>>
> >>> If that's the case, would it make sense to to fast-track them (as some
> >>> of them are fixes) and then on top plumb the media controller
> >>> infrastructure with this patch and the ones you have been mentioning ?
> >>
> >> It would make sense.
> >>
> >
> > Once the other discussion with Hans about the stop state it might make
> > sense to fastrack the first part of the series ?
>
> The other three patches (4,5,6) are quite independent and can go faster.
> >
> >>>
> >>>>>
> >>>>>> +     isc->pads[ISC_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
> >>>>>> +
> >>>>>> +     ret = media_entity_pads_init(&isc->video_dev.entity, ISC_PADS_NUM,
> >>>>>> +                                  isc->pads);
> >>>>>> +     if (ret < 0) {
> >>>>>> +             dev_err(isc->dev, "media entity init failed\n");
> >>>>>> +             return ret;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     isc->mdev.dev = isc->dev;
> >>>>>> +
> >>>>>> +     match = of_match_node(isc->dev->driver->of_match_table,
> >>>>>> +                           isc->dev->of_node);
> >>>>>> +
> >>>>>> +     strscpy(isc->mdev.driver_name, KBUILD_MODNAME,
> >>>>>> +             sizeof(isc->mdev.driver_name));
> >>>>>> +     strscpy(isc->mdev.model, match->compatible, sizeof(isc->mdev.model));
> >>>>>> +     snprintf(isc->mdev.bus_info, sizeof(isc->mdev.bus_info), "platform:%s",
> >>>>>> +              isc->v4l2_dev.name);
> >>>>>> +     isc->mdev.hw_revision = ver;
> >>>>>> +
> >>>>>> +     media_device_init(&isc->mdev);
> >>>>>> +
> >>>>>> +     isc->v4l2_dev.mdev = &isc->mdev;
> >>>>>> +
> >>>>>> +     return isc_scaler_init(isc);
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(isc_mc_init);
> >>>>>> +
> >>>>>> +void isc_mc_cleanup(struct isc_device *isc)
> >>>>>> +{
> >>>>>> +     media_entity_cleanup(&isc->video_dev.entity);
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(isc_mc_cleanup);
> >>>>>> +
> >>>>>>     /* regmap configuration */
> >>>>>>     #define ATMEL_ISC_REG_MAX    0xd5c
> >>>>>>     const struct regmap_config isc_regmap_config = {
> >>>>>> diff --git a/drivers/media/platform/atmel/atmel-isc-scaler.c b/drivers/media/platform/atmel/atmel-isc-scaler.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..ec95c9665883
> >>>>>> --- /dev/null
> >>>>>> +++ b/drivers/media/platform/atmel/atmel-isc-scaler.c
> >>>>>> @@ -0,0 +1,245 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>>> +/*
> >>>>>> + * Microchip Image Sensor Controller (ISC) Scaler entity support
> >>>>>> + *
> >>>>>> + * Copyright (C) 2021 Microchip Technology, Inc.
> >>>>>
> >>>>> Time flies! It's 2022 already :)
> >>>>>
> >>>>>> + *
> >>>>>> + * Author: Eugen Hristev <eugen.hristev@microchip.com>
> >>>>>> + *
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include <media/media-device.h>
> >>>>>> +#include <media/media-entity.h>
> >>>>>> +#include <media/v4l2-device.h>
> >>>>>> +#include <media/v4l2-subdev.h>
> >>>>>> +
> >>>>>> +#include "atmel-isc-regs.h"
> >>>>>> +#include "atmel-isc.h"
> >>>>>> +
> >>>>>> +static int isc_scaler_get_fmt(struct v4l2_subdev *sd,
> >>>>>> +                           struct v4l2_subdev_state *sd_state,
> >>>>>> +                           struct v4l2_subdev_format *format)
> >>>>>> +{
> >>>>>> +     struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
> >>>>>> +     struct v4l2_mbus_framefmt *v4l2_try_fmt;
> >>>>>> +
> >>>>>> +     if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
> >>>>>> +             v4l2_try_fmt = v4l2_subdev_get_try_format(sd, sd_state,
> >>>>>> +                                                       format->pad);
> >>>>>> +             format->format = *v4l2_try_fmt;
> >>>>>> +
> >>>>>> +             return 0;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     format->format = isc->scaler_format;
> >>>>>
> >>>>> isc->scaler_format is only used inside this file if I'm not mistaken.
> >>>>> I wonder why it lives in the isc_device struct.
> >>>>
> >>>> isc_device is a placeholder for all isc things.
> >>>>
> >>>> I would not create a separate struct in this file that would have to be
> >>>> allocated etc... just for one two things. So I preferred to have it in
> >>>> the same place as all the other things.
> >>>>
> >>>>>
> >>>>>> +
> >>>>>> +     return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int isc_scaler_set_fmt(struct v4l2_subdev *sd,
> >>>>>> +                           struct v4l2_subdev_state *sd_state,
> >>>>>> +                           struct v4l2_subdev_format *req_fmt)
> >>>>>> +{
> >>>>>> +     struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
> >>>>>> +     struct v4l2_mbus_framefmt *v4l2_try_fmt;
> >>>>>> +     struct isc_format *fmt;
> >>>>>> +     unsigned int i;
> >>>>>> +
> >>>>>> +     if (req_fmt->pad == ISC_SCALER_PAD_SOURCE)
> >>>>>> +             v4l_bound_align_image
> >>>>>> +                     (&req_fmt->format.width, 16, isc->max_width, 0,
> >>>>>> +                      &req_fmt->format.height, 16, isc->max_height, 0, 0);
> >>>>>> +     else
> >>>>>> +             v4l_bound_align_image
> >>>>>> +                     (&req_fmt->format.width, 16, 10000, 0,
> >>>>>> +                      &req_fmt->format.height, 16, 10000, 0, 0);
> >>>>>
> >>>>> Where does 10000 come from ?
> >>>>
> >>>> It's a random number. Do you have any suggestion for a better one ?
> >>>
> >>> An actual HW limit ? :)
> >>
> >> There is no hardware limit. The ISC just stops sampling pixels once the
> >> crop limit is reached. The element that generates pixels could go on
> >> forever , or until the next HBLANK/VBLANK. So what limit could I place
> >> here ?
> >> The cropping is mandatory, otherwise there could be an overflow w.r.t.
> >> the buffer size if the ISC would sample more pixels than the software
> >> expects it to.
> >>
> >>>
> >>>> Maybe this would be much more clear with my comments below (where I will
> >>>> explain what the isc scaler does )
> >>>> In short, it allows the other entity in the link to 'sink' a huge format
> >>>> into this 'scaler' . Because the scaler can crop anything basically down
> >>>> to the biggest format size the ISC could handle.
> >>>>
> >>>
> >>> doesn't it have any documented input size limit ?
> >>
> >> As stated above, ISC handles a pixel stream and stores it in an internal
> >> SRAM. ISC stops sampling when this SRAM is full or when the cropping
> >> limit is reached.
> >> After storing the pixels in the SRAM (which is limited to the ISC
> >> maximum frame size), the ISC will work on the pixels and then DMA the
> >> frame to another RAM.
> >>
> >
> > I understand...
> >
> > So whatever the input size is, only the first n-th bytes are actually
> > dumped to memory, the following ones are discarded.
>
> Yes ! That's the behavior.
> >
> > So the crop is always applied on the top-leftmost corner as a
> > consequence, right ?
>
> Right. Pixels come in order. The ISC does not really know how many
> pixels are coming until its memory is full (or counting until the crop
> limit is reached). After that it stops sampling pixels, and waits for
> vblank to finish the frame.
>
>
> >
> > I understand why you had difficulties picking a default :)
> >
> > This is not easy to handle, as the scaler doesn't actually applies a
> > crop but rather stops capturing after the destination buffer has been
> > saturated. So the limiting factor is the full image size, not one of
> > its dimensions, like in example the line length. This makes it hard
> > to adjust cropping to something meaningful for most use cases.
>
> I didn't know how to name this except crop. It 'crops out' what does not
> fit in the internal memory of the ISC
>
> >
> > In your below example you suggest that an image size of (800000 x 10)
> > would theoretically be captured correctly.  What if the input is of
> > size (800000 x 10 + 1). What size would you set the crop rectangle to ?
> >
> > I wouldn't however be too much concerned for the moment, but I would
> > record this in a comment ?
>
> I discussed a bit more with designer and looked in datasheet.
> It looks like the horizontal line length is not a hard limit, but it
> makes the ISC internal ISP stop working, so I would keep the horizontal
> limit as well for now, unless an important use case (I am coming back to
> that). The vertical limit looks to be a hard requirement.
> So in short, we have to impose a vertical limit of 2464 , we cannot have
> more lines than these. So if the horizontal is 100 pixels e.g., we can
> capture only 100x2464 .
> In practice we could capture [16,3264] on the horizontal, and [16,2464]
> on the vertical, and in theory horizontal could go more like [16, 4000],
> but we have to limit the vertical, and without the internal ISP.
> So I would not haphazardly go in this direction. Let's stick to the
> datasheet maximum frame 3264x2464 .
> According to this , I changed the frame size of the ISC to be a
> continuous size from [16,16] to [3264,2464]
> About that use case that I talked about earlier, we have one sensor ,
> imx274, which is more wide, and outputs something like 3800x2100 .
> With the cropping and limitations we have in place now, this will be
> limited to 3264x2100 , which is in line with datasheet and what the ISC
> supports now.
> As in theory we could capture 3800x2100 as long as the SRAM doesn't get
> full, for now I would like to avoid capturing this size (and disable the
> internal ISP), until we have someone really asking for such kind of
> capture and with some good reasons.
> In short I would like to have the crop rectangle to 3264x2464 and the
> bounds would be limited to the incoming frame but no H>3264 and no
> V>2464. Does that make sense ?

Just to make sure I got it: is the ISC actually able to crop on the
line length ? If you apply a 3264 limit, will the last 536 pixels of
each line will be dropped if the input frame is 3800x2100 as your
above example ?

Or rather, is the SRAM size limit the issue and the lines gets
captured in full lenght no matter what, until the buffer gets filled up
and all the successive pixels dropped.

In other words, do your cropped image look like:

                                        3264
        +--------------------------------X-----------+ 3800
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|           |
        +--------------------------------------------+ 2100

Or rather


                                        3264
        +--------------------------------X-----------+ 3800
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
        |xxxxxxxxxxxxxxxxx|                          |
        |                                            |
        +--------------------------------------------+ 2100

I assume the first, as otherwise you wouldn't be able to interpret the
image as 3264x2100.

I'm asking because you had the un-cropped 3280x2464 size as the ISC
source pad size in the paste of the media graph you provided below,
which might mean the output image is actually full size in lines
lenght and it's maybe missing pixels at the end, in case the ISC
operates as in the above second case.

>
> >
> >>>
> >>>>>
> >>>>>> +
> >>>>>> +     req_fmt->format.colorspace = V4L2_COLORSPACE_SRGB;
> >>>>>> +     req_fmt->format.field = V4L2_FIELD_NONE;
> >>>>>> +     req_fmt->format.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> >>>>>> +     req_fmt->format.quantization = V4L2_QUANTIZATION_DEFAULT;
> >>>>>> +     req_fmt->format.xfer_func = V4L2_XFER_FUNC_DEFAULT;
> >>>>>> +
> >>>>>> +     fmt = isc_find_format_by_code(isc, req_fmt->format.code, &i);
> >>>>>
> >>>>> So you rely on the isc format list for the scaler as well ?
> >>>>> I think it's fine as long as they are identical
> >>>>
> >>>> Yes, the scaler is kind of a dummy entity , but it's required by the
> >>>> media controller validation of the pipeline.
> >>>>
> >>>
> >>> More on this later
> >>>
> >>>>>
> >>>>>> +
> >>>>>> +     if (!fmt)
> >>>>>> +             fmt = &isc->formats_list[0];
> >>>>>> +
> >>>>>> +     req_fmt->format.code = fmt->mbus_code;
> >>>>>> +
> >>>>>> +     if (req_fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
> >>>>>> +             v4l2_try_fmt = v4l2_subdev_get_try_format(sd, sd_state,
> >>>>>> +                                                       req_fmt->pad);
> >>>>>> +             *v4l2_try_fmt = req_fmt->format;
> >>>>>> +             /* Trying on the pad sink makes the source sink change too */
> >>>>>> +             if (req_fmt->pad == ISC_SCALER_PAD_SINK) {
> >>>>>> +                     v4l2_try_fmt =
> >>>>>> +                             v4l2_subdev_get_try_format(sd, sd_state,
> >>>>>> +                                                        ISC_SCALER_PAD_SOURCE);
> >>>>>> +                     *v4l2_try_fmt = req_fmt->format;
> >>>>>> +
> >>>>>> +                     v4l_bound_align_image(&v4l2_try_fmt->width,
> >>>>>> +                                           16, isc->max_width, 0,
> >>>>>> +                                           &v4l2_try_fmt->height,
> >>>>>> +                                           16, isc->max_height, 0, 0);
> >>>>>> +             }
> >>>>>> +             /* if we are just trying, we are done */
> >>>>>> +             return 0;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     isc->scaler_format = req_fmt->format;
> >>>>>
> >>>>> No per-pad format but a global scaler_format ? How do you configure scaling ?
> >>>>>
> >>>>> Actually, I would like to know more about the scaler device
> >>>>> capabilities. What functions can this IP perform ? Does it do
> >>>>> cropping, can it also do (down)scaling or even composition ?
> >>>>>
> >>>>> I think it is worth to read
> >>>>> https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-subdev.html#v4l2-subdev-selections
> >>>>> where it is reported how cropping and scaling are implemented by using
> >>>>> the selection API.
> >>>>>
> >>>>> Figure 4.5 is particularly helpful to explain the simple crop case,
> >>>>> for which you need to implement support to by adding s_selection on
> >>>>> the sink pad TGT_CROP target.
> >>>>
> >>>> The scaler is kind of a dummy entity.
> >>>> The problem is that different subdevices cannot be connected directly to
> >>>> a v4l entity, because the ISC does cropping on the incoming frame.
> >>>> The ISC has a limit on the total number of pixels per frame, thus it
> >>>> will do a crop.
> >>>
> >>> What is this limit related to ? I don't know the ISC internals, but is
> >>> the limitation due to the overall image size, or maybe it's due to
> >>> some line buffers being limited in the size they can transfer to
> >>> memory ? Is it a limitation on the size of the image in pixels, or is
> >>> it due to a limitation of the processing bandwidth on the input
> >>> interface and thus depends on the actual size of the image in bytes ?
> >>
> >> Limitation is both on line size and full image size. From my
> >> understanding, is that the internal SRAM is limited (8 Mpixels with a
> >> small safe buffer on top in the case of sama7g5 )
> >> This SRAM could be used as 800000x10 for example, or 3200x2464 for
> >> another example. However, I am not sure if a real line of 800,000 pixels
> >> make sense, or if there is another internal mechanism in the ISC that
> >> stops it.
> >> In any case, the ISC is cropping the incoming frame from aaaXbbb up to
> >> the maximum frame that it can handle
> >>
> >>>
> >>>> So, if I allow e.g. an entity that sends 3280x2464 , when the ISC can
> >>>> only handle 3264x2464 , then we have two choices:
> >>>> 1/ crop it and output the 3264x2464 -> cannot, because userspace expects
> >>>> 3280x2464, and the whole pipeline fails to configure, there is a
> >>>> mismatch between /dev/video output and what the whole pipeline produces
> >>>
> >>> I'm confused in first place. If the ISC cannot output anything larger
> >>> than 3264x2464, then if userspace sets a 3280x2464 size on the ISC,
> >>> this should be adjusted to 3264x2464.
> >>
> >> yes, that is true. However, without an entity that says 'I am doing
> >> cropping', the media pipeline will fail, because previous entity will
> >> output 3280x2464 .
> >> The conclusion to create a scaler entitity was done during my last year
> >> discussions on the IRC. I could not find a way to perform this cropping
> >> at the v4l entity side, and one reason is that the v4l entity does not
> >> support what I needed , or at least that was my understanding.
> >> You claim that the v4l entity could perform the cropping in the same
> >> entity ?
> >
> > I thought so, but I haven't tried to be honest
> >
> >>
> >> Let's assume for a minute that it could do this. Even so, I would prefer
> >> to have a separate scaler entity to do this , for several reasons:
> >> -> I would like to be able to crop the frame arbitrarily if I want to,
> >> and the scaler would allow me to do this easier
> >> -> it would be more obvious that the frame is cropped by having this
> >> entity there
> >> -> in fact some of the ISC versions really have a down scaler, that I
> >> have not implemented yet. So it would be useful to already have this in
> >> place to be able to scale down with it at a later time.
> >
> > I think this last reason is enough to have an entity plumbed in
> > already
> >
> >>
> >>>
> >>> Or is the ISC limitation on the -input- side ?
> >>>
> >>>> 2/ deny the link, and ask the subdevice to produce the 3264x2464 which
> >>>> the ISC can handle at most -> cannot , because the sensor let's say can
> >>>> *only* produce 3280x2464 and *any* other frame size returns an error.
> >>>
> >>> buggy sensor I would say :)
> >>
> >> I cannot tell this to the customers, and I cannot fail the whole
> >> pipeline because the sensor does not crop 16 pixels, when in fact I can
> >> do this very easily on the ISC side.
> >>
> >
> > Fair enough :)
> >
> >>>
> >>>>
> >>>> The only solution to make both worlds happy, is to have a dummy entity
> >>>> called 'scaler' which in fact now it only performs a simple crop.
> >>>> It accepts any frame size at input (hence the 10000x10000 which you saw
> >>>> earlier), and outputs at most 3264x2464 the isc_max_height and
> >>>> isc_max_width.
> >>>
> >>> I have a maybe dumb question: can the cropping operation be modeled
> >>> by applying a TGT_CROP rectangle (whose _BOUND size is 3280x2464) to
> >>> the atmel_isc_common entity sink pad and avoid the scaler completely ?
> >>
> >> I am not sure. This is what I wanted initially. But then I thought about
> >> the three reasons stated above for the use of the scaler entity, and
> >> discussed with folks on the IRC, and come up with the solution for the
> >> scaler entity
> >>
> >>>
> >>>>
> >>>> So to answer your question, the isc scaler is a software model for a
> >>>> simple cropping, that would make media controller happy, and capture
> >>>> software happy.
> >>>>
> >>>> Here it how it looks :
> >>>>
> >>>> Device topology
> >>>> - entity 1: atmel_isc_scaler (2 pads, 2 links)
> >>>>                type V4L2 subdev subtype Unknown flags 0
> >>>>                device node name /dev/v4l-subdev0
> >>>>            pad0: Sink
> >>>>                    [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb
> >>>>                     crop.bounds:(0,0)/3264x2464
> >>>>                     crop:(0,0)/3264x2464]
> >>>>                    <- "csi2dc":1 [ENABLED,IMMUTABLE]
> >>>>            pad1: Source
> >>>>                    [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb]
> >>>>                    -> "atmel_isc_common":0 [ENABLED,IMMUTABLE]
> >>>>
> >>>> - entity 4: csi2dc (2 pads, 2 links)
> >>>>                type V4L2 subdev subtype Unknown flags 0
> >>>>                device node name /dev/v4l-subdev1
> >>>>            pad0: Sink
> >>>>                    [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb]
> >>>>                    <- "dw-csi.0":1 [ENABLED]
> >>>>            pad1: Source
> >>>>                    [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb]
> >>>>                    -> "atmel_isc_scaler":0 [ENABLED,IMMUTABLE]
> >>>>
> >>>> - entity 7: dw-csi.0 (2 pads, 2 links)
> >>>>                type V4L2 subdev subtype Unknown flags 0
> >>>>                device node name /dev/v4l-subdev2
> >>>>            pad0: Sink
> >>>>                    [fmt:SRGGB10_1X10/3280x2464]
> >>>>                    <- "imx219 1-0010":0 [ENABLED]
> >>>>            pad1: Source
> >>>>                    [fmt:SRGGB10_1X10/3280x2464]
> >>>>                    -> "csi2dc":0 [ENABLED]
> >>>>
> >>>> - entity 12: imx219 1-0010 (1 pad, 1 link)
> >>>>                 type V4L2 subdev subtype Sensor flags 0
> >>>>                 device node name /dev/v4l-subdev3
> >>>>            pad0: Source
> >>>>                    [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb
> >>>> xfer:srgb ycbcr:601 quantization:full-range
> >>>>                     crop.bounds:(8,8)/3280x2464
> >>>>                     crop:(8,8)/3280x2464]
> >>>>                    -> "dw-csi.0":0 [ENABLED]
> >>>>
> >>>> - entity 24: atmel_isc_common (1 pad, 1 link)
> >>>>                 type Node subtype V4L flags 1
> >>>>                 device node name /dev/video0
> >>>>            pad0: Sink
> >>>>                    <- "atmel_isc_scaler":1 [ENABLED,IMMUTABLE]
> >>>>
> >>>>
> >>>> Scaler does this one cute little thing :
> >>>>
> >>>>         pad0: Sink
> >>>>                    [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb
> >>>>                     crop.bounds:(0,0)/3264x2464
> >>>>                     crop:(0,0)/3264x2464]
> >>>>                    <- "csi2dc":1 [ENABLED,IMMUTABLE]
> >>>>            pad1: Source
> >>>>                    [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb]
> >>>
> >>> Shouldn't this be 3264x2464 as that's what the entity outputs after
> >>> the cropping ? And shouldn't then be 3264x2464 the size output from
> >>> the video device too ?
> >>
> >> That's right.
> >> I don't know why the source format for the scaler is still 3280x2464.
> >> Maybe there is a bug on g_fmt for it.. have to check it.
> >
> > Thanks, I think this should be fixed ten
> >
> >
> >>
> >> Anyway, the video format is like this :
> >>
> >> # v4l2-ctl --get-fmt-video
> >> Format Video Capture:
> >>           Width/Height      : 3264/2464
> >>           Pixel Format      : 'RGBP' (16-bit RGB 5-6-5)
> >>           Field             : None
> >>           Bytes per Line    : 6528
> >>           Size Image        : 16084992
> >>           Colorspace        : sRGB
> >>           Transfer Function : Default (maps to sRGB)
> >>           YCbCr/HSV Encoding: Default (maps to ITU-R 601)
> >>           Quantization      : Default (maps to Full Range)
> >>           Flags             :
> >> #
> >>
> >> and initializing the pipeline looks fine from user perspective.
> >> The scaler is in fact the solution to make this pipeline work with
> >> libcamera.
> >> I found this cropping to be an issue in media controller when trying it
> >> with libcamera. Otherwise, the other user space apps which I was using
> >> never complained that anything was wrong
> >> Libcamera simply refuses to acknowledge the pipeline if the video output
> >> is 3264x2464 but there is no entity that changes the format from
> >> 3280x2464 down
> >
> > Not sure why libcamera should play a role there. Isn't it the media
> > pipeline validation that complains and returns an -EPIPE ?
>
> I tried this before the media_pipeline_start .
> Perhaps libcamera was doing some similar checks, anyway, it was
> complaining and not adding the stream, and reported no usable streams/camera
>
> Once I will rework some of the things according to your review I will
> run libcamera again to see what it complains about
>
> >
> >>
> >>>
> >>>
> >>>>                    -> "atmel_isc_common":0 [ENABLED,IMMUTABLE]
> >>>>
> >>>>
> >>>> Which is what we needed.
> >>>>
> >>>>>
> >>>>>> +
> >>>>>> +     return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int isc_scaler_enum_mbus_code(struct v4l2_subdev *sd,
> >>>>>> +                                  struct v4l2_subdev_state *sd_state,
> >>>>>> +                                  struct v4l2_subdev_mbus_code_enum *code)
> >>>>>> +{
> >>>>>> +     struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
> >>>>>> +     int supported_index = 0;
> >>>>>> +     int i;
> >>>>>> +
> >>>>>> +     for (i = 0; i < isc->formats_list_size; i++) {
> >>>>>> +             if (!isc->formats_list[i].sd_support)
> >>>>>> +                     continue;
> >>>>>
> >>>>> The sd_support flag still doesn't click in my head.
> >>>>>
> >>>>> Shouldn't the enumeration of available formats on the scaler do not
> >>>>> depend on the sensor supproted formats ?
> >>>>
> >>>> You're right. I will have to check it again.
> >>>>
> >>>>>
> >>>>>> +             if (supported_index == code->index) {
> >>>>>> +                     code->code = isc->formats_list[i].mbus_code;
> >>>>>> +                     return 0;
> >>>>>> +             }
> >>>>>> +             supported_index++;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     return -EINVAL;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int isc_scaler_g_sel(struct v4l2_subdev *sd,
> >>>>>> +                         struct v4l2_subdev_state *sd_state,
> >>>>>> +                         struct v4l2_subdev_selection *sel)
> >>>>>> +{
> >>>>>> +     struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
> >>>>>> +
> >>>>>> +     if (sel->pad == ISC_SCALER_PAD_SOURCE)
> >>>>>> +             return -EINVAL;
> >>>>>> +
> >>>>>> +     if (sel->target != V4L2_SEL_TGT_CROP_BOUNDS &&
> >>>>>> +         sel->target != V4L2_SEL_TGT_CROP)
> >>>>>> +             return -EINVAL;
> >>>>>> +
> >>>>>> +     sel->r.height = isc->max_height;
> >>>>>> +     sel->r.width = isc->max_width;
> >>>>>
> >>>>> The CROP_BOUNDS should be set to the same size as the sink pad image format,
> >>>>> as it represents the maximum valid crop rectangle.
> >>>>>
> >>>>> TGT_CROP should report the configured crop rectangle which can be
> >>>>> intiialized to the same size as CROP_BOUNDS, if my understanding of
> >>>>> the spec is correct
> >>>>
> >>>> So you would like to have this differentiated, and report the
> >>>> CROP_BOUNDS to whatever is on the sink pad, and the TGT_CROP to what is
> >>>> reported now, the maximum size of the ISC frame .
> >>>> My understanding is correct ?
> >>>>
> >>>
> >>> I didn't know you have an HW limitation, so your _BOUNDS is not the
> >>> input image size but rather 3264x2464 ( == max_width x max_height).
> >>>
> >>> What I meant is that _BOUNDS should report the maximum rectangle size
> >>> that can be applied to the _CROP target. In you case you have an HW
> >>> limitation 3264x2464 and that's the largest rectangle you can apply.
> >> So the CROP should be at 3264x2464
> >>> TGT_CROP can be initialized to the same as _BOUND, but if you
> >>> implement s_selection it should report what has been there applied.
> >> and BOUND to actual frame size ?
> >>> But as you don't implement s_selection yet, I think this is fine for
> >>> now. Maybe a little comment ?
> >>
> >> It could also be the case where e.g. the sensor is outputting 1920x1080,
> >> in this case the scaler would do nothing.
> >> CROP is still 3264x2464 and BOUND in this case is 1920x1080 ?
> >> If the sensor is outputting 1920x1080, this format comes directly from
> >> the sensor (the sensor is cropping it from 3280x2464 or not... it's the
> >> sensor's problem)
> >>>
> >>> Also, is set->r zeroed by the framework before getting here ?
> >>> Otherwise you should set r.left and r.top to 0
> >>
> >> If these are redundant, no problem to remove them
> >
> > I was actually confused. I was suggesting you to add...
> >
> >>>
> >>>>>
> >>>>>> +
> >>>>>> +     sel->r.left = 0;
> >>>>>> +     sel->r.top = 0;
> >
> >          These ^
> >
> > So nothing to change. Sorry I've missed them
> >
> > Thanks
> >    j
> >
> >
> >>>>>> +
> >>>>>> +     return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int isc_scaler_init_cfg(struct v4l2_subdev *sd,
> >>>>>> +                            struct v4l2_subdev_state *sd_state)
> >>>>>> +{
> >>>>>> +     struct v4l2_mbus_framefmt *v4l2_try_fmt =
> >>>>>> +             v4l2_subdev_get_try_format(sd, sd_state, 0);
> >>>>>> +     struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
> >>>>>> +
> >>>>>> +     *v4l2_try_fmt = isc->scaler_format;
> >>>>>> +
> >>>>>> +     return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static const struct v4l2_subdev_pad_ops isc_scaler_pad_ops = {
> >>>>>> +     .enum_mbus_code = isc_scaler_enum_mbus_code,
> >>>>>> +     .set_fmt = isc_scaler_set_fmt,
> >>>>>> +     .get_fmt = isc_scaler_get_fmt,
> >>>>>> +     .get_selection = isc_scaler_g_sel,
> >>>>>> +     .init_cfg = isc_scaler_init_cfg,
> >>>>>
> >>>>> .link_validate = v4l2_subdev_link_validate_default,
> >>>>>
> >>>>> To have the formats at the end of links that point to this entity
> >>>>> validated (I think the framework already calls it if not set though,
> >>>>> please check v4l2-subdev.c:v4l2_subdev_link_validate())
> >>>>>
> >>>>>> +};
> >>>>>> +
> >>>>>> +static const struct v4l2_subdev_ops xisc_scaler_subdev_ops = {
> >>>>>> +     .pad = &isc_scaler_pad_ops,
> >>>>>> +};
> >>>>>> +
> >>>>>> +int isc_scaler_init(struct isc_device *isc)
> >>>>>> +{
> >>>>>> +     int ret;
> >>>>>> +
> >>>>>> +     v4l2_subdev_init(&isc->scaler_sd, &xisc_scaler_subdev_ops);
> >>>>>> +
> >>>>>> +     isc->scaler_sd.owner = THIS_MODULE;
> >>>>>> +     isc->scaler_sd.dev = isc->dev;
> >>>>>> +     snprintf(isc->scaler_sd.name, sizeof(isc->scaler_sd.name),
> >>>>>> +              "atmel_isc_scaler");
> >>>>>
> >>>>> I would drop 'atmel' for brevity, unless other entities have this
> >>>>> prefix set already
> >>>>
> >>>> The v4l entity takes it's name from the module name, which is
> >>>> atmel_isc_common, so I thought to keep the prefix
> >>>>
> >>>
> >>> Ack!
> >>>
> >>>>>
> >>>>>> +
> >>>>>> +     isc->scaler_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> >>>>>> +     isc->scaler_sd.entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
> >>>>>> +     isc->scaler_pads[ISC_SCALER_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
> >>>>>> +     isc->scaler_pads[ISC_SCALER_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
> >>>>>> +
> >>>>>> +     isc->scaler_format.height = isc->max_height;
> >>>>>> +     isc->scaler_format.width = isc->max_width;
> >>>>>> +     isc->scaler_format.code = isc->formats_list[0].mbus_code;
> >>>>>> +     isc->scaler_format.colorspace = V4L2_COLORSPACE_SRGB;
> >>>>>> +     isc->scaler_format.field = V4L2_FIELD_NONE;
> >>>>>> +     isc->scaler_format.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> >>>>>> +     isc->scaler_format.quantization = V4L2_QUANTIZATION_DEFAULT;
> >>>>>> +     isc->scaler_format.xfer_func = V4L2_XFER_FUNC_DEFAULT;
> >>>>>> +
> >>>>>> +     ret = media_entity_pads_init(&isc->scaler_sd.entity,
> >>>>>> +                                  ISC_SCALER_PADS_NUM,
> >>>>>> +                                  isc->scaler_pads);
> >>>>>> +     if (ret < 0) {
> >>>>>> +             dev_err(isc->dev, "scaler sd media entity init failed\n");
> >>>>>> +             return ret;
> >>>>>> +     }
> >>>>>> +     ret = v4l2_device_register_subdev(&isc->v4l2_dev, &isc->scaler_sd);
> >>>>>> +     if (ret < 0) {
> >>>>>> +             dev_err(isc->dev, "scaler sd failed to register subdev\n");
> >>>>>> +             return ret;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     return ret;
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(isc_scaler_init);
> >>>>>> +
> >>>>>> +int isc_scaler_link(struct isc_device *isc)
> >>>>>> +{
> >>>>>> +     int ret;
> >>>>>> +
> >>>>>> +     ret = media_create_pad_link(&isc->current_subdev->sd->entity,
> >>>>>> +                                 isc->remote_pad, &isc->scaler_sd.entity,
> >>>>>> +                                 ISC_SCALER_PAD_SINK,
> >>>>>> +                                 MEDIA_LNK_FL_ENABLED |
> >>>>>> +                                 MEDIA_LNK_FL_IMMUTABLE);
> >>>>>> +
> >>>>>> +     if (ret < 0) {
> >>>>>> +             v4l2_err(&isc->v4l2_dev,
> >>>>>> +                      "Failed to create pad link: %s to %s\n",
> >>>>>> +                      isc->current_subdev->sd->entity.name,
> >>>>>> +                      isc->scaler_sd.entity.name);
> >>>>>> +             return ret;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     dev_dbg(isc->dev, "link with %s pad: %d\n",
> >>>>>> +             isc->current_subdev->sd->name, isc->remote_pad);
> >>>>>> +
> >>>>>> +     ret = media_create_pad_link(&isc->scaler_sd.entity,
> >>>>>> +                                 ISC_SCALER_PAD_SOURCE,
> >>>>>> +                                 &isc->video_dev.entity, ISC_PAD_SINK,
> >>>>>> +                                 MEDIA_LNK_FL_ENABLED |
> >>>>>> +                                 MEDIA_LNK_FL_IMMUTABLE);
> >>>>>> +
> >>>>>> +     if (ret < 0) {
> >>>>>> +             v4l2_err(&isc->v4l2_dev,
> >>>>>> +                      "Failed to create pad link: %s to %s\n",
> >>>>>> +                      isc->scaler_sd.entity.name,
> >>>>>> +                      isc->video_dev.entity.name);
> >>>>>> +             return ret;
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     dev_dbg(isc->dev, "link with %s pad: %d\n", isc->scaler_sd.name,
> >>>>>> +             ISC_SCALER_PAD_SOURCE);
> >>>>>> +
> >>>>>> +     return ret;
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(isc_scaler_link);
> >>>>>
> >>>>>    From the DT graph point of view, the ISC appears as a single block
> >>>>> with an CSI-2 input port. It is then in charge of parsing the .dts and
> >>>>> add to its notifier the image sensor remote subdevice.
> >>>>
> >>>> Actually it's only a parallel port.
> >>>> And it can be connected either to a sensor directly or to the csi2dc
> >>>> bridge. (the csi2dc bridge can be connected to a CSI-2 receiver)
> >>>>
> >>>>>
> >>>>> When the sensor subdev registers and the ISC notifier completes, the scaler
> >>>>> entity which was initialized at isc_probe() time is linked in between
> >>>>> the ISC and the image sensor immutably.
> >>>>
> >>>> yes, because this cannot change at runtime, and usually, it can't change
> >>>> without altering the board hardware. (at least this is what my
> >>>> understanding of immutability is )
> >>>>
> >>>>>
> >>>>> I think it is fine for now, but I wonder if you plan to plumb more
> >>>>> components between the ISC video node and the sensor, if it's not
> >>>>> worth changing the DT bindings and their parsing logic to separate the
> >>>>> CSI-2 receiver from the ISC, whcih can create its media graph at probe
> >>>>> time and have the CSI-2 receiver entity as downstream remote. I think
> >>>>> I need to get to know the ISC better to really have an idea. For now,
> >>>>> this seems ok to me, but please check with maintainers if this is fine
> >>>>> with them.
> >>>>
> >>>> In the XISC case (sama7g5-isc), the csi2dc receiver is the subdev (so,
> >>>> the remote subdev).
> >>>> The ISC will register a scaler, and connect the subdev to this scaler
> >>>> first, and then, the scaler to the isc itself (the v4l entity).
> >>>>
> >>>>>
> >>>>>> +
> >>>>>> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> >>>>>> index 5fbf52a9080b..c9234c90ae58 100644
> >>>>>> --- a/drivers/media/platform/atmel/atmel-isc.h
> >>>>>> +++ b/drivers/media/platform/atmel/atmel-isc.h
> >>>>>> @@ -183,6 +183,17 @@ struct isc_reg_offsets {
> >>>>>>          u32 his_entry;
> >>>>>>     };
> >>>>>>
> >>>>>> +enum isc_mc_pads {
> >>>>>> +     ISC_PAD_SINK    = 0,
> >>>>>> +     ISC_PADS_NUM    = 1,
> >>>>>> +};
> >>>>>> +
> >>>>>> +enum isc_scaler_pads {
> >>>>>> +     ISC_SCALER_PAD_SINK     = 0,
> >>>>>> +     ISC_SCALER_PAD_SOURCE   = 1,
> >>>>>> +     ISC_SCALER_PADS_NUM     = 2,
> >>>>>> +};
> >>>>>> +
> >>>>>>     /*
> >>>>>>      * struct isc_device - ISC device driver data/config struct
> >>>>>>      * @regmap:          Register map
> >>>>>> @@ -257,6 +268,12 @@ struct isc_reg_offsets {
> >>>>>>      *                   be used as an input to the controller
> >>>>>>      * @controller_formats_size: size of controller_formats array
> >>>>>>      * @formats_list_size:       size of formats_list array
> >>>>>> + * @pads:            media controller pads for isc video entity
> >>>>>> + * @mdev:            media device that is registered by the isc
> >>>>>> + * @remote_pad:              remote pad on the connected subdevice
> >>>>>> + * @scaler_sd:               subdevice for the scaler that isc registers
> >>>>>> + * @scaler_pads:     media controller pads for the scaler subdevice
> >>>>>> + * @scaler_format:   current format for the scaler subdevice
> >>>>>>      */
> >>>>>>     struct isc_device {
> >>>>>>          struct regmap           *regmap;
> >>>>>> @@ -344,6 +361,19 @@ struct isc_device {
> >>>>>>          struct isc_format               *formats_list;
> >>>>>>          u32                             controller_formats_size;
> >>>>>>          u32                             formats_list_size;
> >>>>>> +
> >>>>>> +     struct {
> >>>>>> +             struct media_pad                pads[ISC_PADS_NUM];
> >>>>>> +             struct media_device             mdev;
> >>>>>> +
> >>>>>> +             u32                             remote_pad;
> >>>>>> +     };
> >>>>>> +
> >>>>>> +     struct {
> >>>>>> +             struct v4l2_subdev              scaler_sd;
> >>>>>> +             struct media_pad                scaler_pads[ISC_SCALER_PADS_NUM];
> >>>>>> +             struct v4l2_mbus_framefmt       scaler_format;
> >>>>
> >>>> Here are the scaler stuff which I added, in the same bulk struct for the
> >>>> whole isc device
> >>>>
> >>>>
> >>>>>> +     };
> >>>>>>     };
> >>>>>>
> >>>>>>     extern const struct regmap_config isc_regmap_config;
> >>>>>> @@ -355,4 +385,11 @@ int isc_clk_init(struct isc_device *isc);
> >>>>>>     void isc_subdev_cleanup(struct isc_device *isc);
> >>>>>>     void isc_clk_cleanup(struct isc_device *isc);
> >>>>>>
> >>>>>> +int isc_scaler_link(struct isc_device *isc);
> >>>>>> +int isc_scaler_init(struct isc_device *isc);
> >>>>>> +int isc_mc_init(struct isc_device *isc, u32 ver);
> >>>>>> +void isc_mc_cleanup(struct isc_device *isc);
> >>>>>> +
> >>>>>> +struct isc_format *isc_find_format_by_code(struct isc_device *isc,
> >>>>>> +                                        unsigned int code, int *index);
> >>>>>>     #endif
> >>>>>> diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> >>>>>> index c5b9563e36cb..c244682ea22f 100644
> >>>>>> --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> >>>>>> +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> >>>>>> @@ -553,6 +553,12 @@ static int atmel_isc_probe(struct platform_device *pdev)
> >>>>>>                          break;
> >>>>>>          }
> >>>>>>
> >>>>>> +     regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
> >>>>>
> >>>>> I am surprised you can read a register before runtime_pm is
> >>>>> intialized!
> >>>>>
> >>>>
> >>>> Actually I can read any register after the moment of starting the clock
> >>>> on the hardware block.
> >>>
> >>> Ah right then
> >>>
> >>>> Maybe the starting and stopping of the clock needs to be moved to the
> >>>> runtime_pm calls, but this is another story, not related to the media
> >>>> controller.
> >>>
> >>> It's fine, but maybe worth recording with a todo ?
> >>>
> >>> Thanks
> >>>     j
> >>>
> >>>> I moved this line because I had to pass the version to the isc_mc_init call
> >>>>
> >>>>> Thanks
> >>>>>       j
> >>>>
> >>>> Thanks for reviewing !
> >>>> Eugen
> >>>>>
> >>>>>
> >>>>>> +
> >>>>>> +     ret = isc_mc_init(isc, ver);
> >>>>>> +     if (ret < 0)
> >>>>>> +             goto isc_probe_mc_init_err;
> >>>>>> +
> >>>>>>          pm_runtime_set_active(dev);
> >>>>>>          pm_runtime_enable(dev);
> >>>>>>          pm_request_idle(dev);
> >>>>>> @@ -562,7 +568,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
> >>>>>>          ret = clk_prepare_enable(isc->ispck);
> >>>>>>          if (ret) {
> >>>>>>                  dev_err(dev, "failed to enable ispck: %d\n", ret);
> >>>>>> -             goto cleanup_subdev;
> >>>>>> +             goto isc_probe_mc_init_err;
> >>>>>>          }
> >>>>>>
> >>>>>>          /* ispck should be greater or equal to hclock */
> >>>>>> @@ -572,7 +578,6 @@ static int atmel_isc_probe(struct platform_device *pdev)
> >>>>>>                  goto unprepare_clk;
> >>>>>>          }
> >>>>>>
> >>>>>> -     regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
> >>>>>>          dev_info(dev, "Microchip ISC version %x\n", ver);
> >>>>>>
> >>>>>>          return 0;
> >>>>>> @@ -580,6 +585,9 @@ static int atmel_isc_probe(struct platform_device *pdev)
> >>>>>>     unprepare_clk:
> >>>>>>          clk_disable_unprepare(isc->ispck);
> >>>>>>
> >>>>>> +isc_probe_mc_init_err:
> >>>>>> +     isc_mc_cleanup(isc);
> >>>>>> +
> >>>>>>     cleanup_subdev:
> >>>>>>          isc_subdev_cleanup(isc);
> >>>>>>
> >>>>>> @@ -600,6 +608,8 @@ static int atmel_isc_remove(struct platform_device *pdev)
> >>>>>>
> >>>>>>          pm_runtime_disable(&pdev->dev);
> >>>>>>
> >>>>>> +     isc_mc_cleanup(isc);
> >>>>>> +
> >>>>>>          isc_subdev_cleanup(isc);
> >>>>>>
> >>>>>>          v4l2_device_unregister(&isc->v4l2_dev);
> >>>>>> diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> >>>>>> index 07a80b08bc54..9dc75eed0098 100644
> >>>>>> --- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> >>>>>> +++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
> >>>>>> @@ -547,15 +547,23 @@ static int microchip_xisc_probe(struct platform_device *pdev)
> >>>>>>                          break;
> >>>>>>          }
> >>>>>>
> >>>>>> +     regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
> >>>>>> +
> >>>>>> +     ret = isc_mc_init(isc, ver);
> >>>>>> +     if (ret < 0)
> >>>>>> +             goto isc_probe_mc_init_err;
> >>>>>> +
> >>>>>>          pm_runtime_set_active(dev);
> >>>>>>          pm_runtime_enable(dev);
> >>>>>>          pm_request_idle(dev);
> >>>>>>
> >>>>>> -     regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
> >>>>>>          dev_info(dev, "Microchip XISC version %x\n", ver);
> >>>>>>
> >>>>>>          return 0;
> >>>>>>
> >>>>>> +isc_probe_mc_init_err:
> >>>>>> +     isc_mc_cleanup(isc);
> >>>>>> +
> >>>>>>     cleanup_subdev:
> >>>>>>          isc_subdev_cleanup(isc);
> >>>>>>
> >>>>>> @@ -576,6 +584,8 @@ static int microchip_xisc_remove(struct platform_device *pdev)
> >>>>>>
> >>>>>>          pm_runtime_disable(&pdev->dev);
> >>>>>>
> >>>>>> +     isc_mc_cleanup(isc);
> >>>>>> +
> >>>>>>          isc_subdev_cleanup(isc);
> >>>>>>
> >>>>>>          v4l2_device_unregister(&isc->v4l2_dev);
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>>
> >>>>
> >>
>
