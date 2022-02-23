Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39BD4C18A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiBWQfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiBWQfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:35:04 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED204EF53;
        Wed, 23 Feb 2022 08:34:36 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C5C6E000D;
        Wed, 23 Feb 2022 16:34:32 +0000 (UTC)
Date:   Wed, 23 Feb 2022 17:34:31 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen.Hristev@microchip.com
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        Nicolas.Ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v5 04/13] media: atmel: atmel-isc: implement media
 controller
Message-ID: <20220223163431.wask6vh2tfhllzf4@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-5-eugen.hristev@microchip.com>
 <e4109e0f-af1f-7594-a154-92e65fd7ac59@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4109e0f-af1f-7594-a154-92e65fd7ac59@microchip.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On Thu, Feb 17, 2022 at 02:59:19PM +0000, Eugen.Hristev@microchip.com wrote:
> On 2/17/22 3:56 PM, Eugen Hristev wrote:
> > Implement the support for media-controller.
> > This means that the capabilities of the driver have changed and now
> > it also advertises the IO_MC .
> > The driver will register it's media device, and add the video entity to this
> > media device. The subdevices are registered to the same media device.
> > The ISC will have a base entity which is auto-detected as atmel_isc_base.
> > It will also register a subdevice that allows cropping of the incoming frame
> > to the maximum frame size supported by the ISC.
> > The ISC will create a link between the subdevice that is asynchronously
> > registered and the atmel_isc_scaler entity.
> > Then, the atmel_isc_scaler and atmel_isc_base are connected through another
> > link.
> >
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > ---
>
>
> Hello Jacopo,
>
> I will add to this patch a little update about how the scaler is seen
> now by the media-ctl :
>
> for imx219 sensor, which generates 3280x2464:
>
>
> - entity 1: atmel_isc_scaler (2 pads, 2 links)
>              type V4L2 subdev subtype Unknown flags 0
>              device node name /dev/v4l-subdev0
>          pad0: Sink
>                  [fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb
>                   crop.bounds:(0,0)/3280x2464
>                   crop:(0,0)/3264x2464]
>                  <- "csi2dc":1 [ENABLED,IMMUTABLE]
>          pad1: Source
>                  [fmt:SRGGB10_1X10/3264x2464 field:none colorspace:srgb]
>                  -> "atmel_isc_common":0 [ENABLED,IMMUTABLE]
>
>
> The source pad of the scaler looks good now.
>
> For the imx274 which I am using (and it generates 3840x2160 ):
>
> - entity 1: atmel_isc_scaler (2 pads, 2 links)
>              type V4L2 subdev subtype Unknown flags 0
>              device node name /dev/v4l-subdev0
>          pad0: Sink
>                  [fmt:SRGGB10_1X10/3840x2160 field:none colorspace:srgb
>                   crop.bounds:(0,0)/3840x2160
>                   crop:(0,0)/3264x2160]
>                  <- "csi2dc":1 [ENABLED,IMMUTABLE]
>          pad1: Source
>                  [fmt:SRGGB10_1X10/3264x2160 field:none colorspace:srgb]
>                  -> "atmel_isc_common":0 [ENABLED,IMMUTABLE]
>
> So in both cases, each line is cropped down to 3264 as the maximum width.
>
> If we select a lower frame size, the scaler will automatically update
> the source pad to reflect this, e.g.:
>
>
> - entity 1: atmel_isc_scaler (2 pads, 2 links)
>              type V4L2 subdev subtype Unknown flags 0
>              device node name /dev/v4l-subdev0
>          pad0: Sink
>                  [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb
>                   crop.bounds:(0,0)/1920x1080
>                   crop:(0,0)/1920x1080]
>                  <- "csi2dc":1 [ENABLED,IMMUTABLE]
>          pad1: Source
>                  [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb]
>                  -> "atmel_isc_common":0 [ENABLED,IMMUTABLE]
>
>
> does it look good now ?

great! I think it now works as intended, thanks!

I only have one question. BOUND target is the larger rectangle that
contains all crop rectangles. As your max crop is limited to 3264x2160
I wonder if BOUND should be limited by the same size. Does
v4l2-compliance check for this.

Otherwise it looks good!

Thanks
  j

>
> Thanks for checking this out !
> Eugen
