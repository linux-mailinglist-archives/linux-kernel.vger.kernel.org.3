Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F44B3B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiBMMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:49:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiBMMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:49:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A35B3D0;
        Sun, 13 Feb 2022 04:49:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 08F3855A;
        Sun, 13 Feb 2022 13:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644756579;
        bh=FHpUB2jjNceHeQbJGiThGx4WBZhIDUQRPUsnubhTu4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDNh9eBEeodzMRO110o89bBlKq7zGLxmUoeMJPbpyWpd9ZkYip7N9Kt1CZHAEASJg
         V3/fdpC2HyBCR29ArXdDStAbX3rF/IcJgCfvnPZtvBbtgMuTWCL9hRB66sIB7pUq/7
         GnI3QEKS5ekKxpjD1hhBAQR2saZsjVIqJcFkuY0w=
Date:   Sun, 13 Feb 2022 14:49:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v5 04/11] media: bcm2835-unicam: Add support for
 CCP2/CSI2 camera interface
Message-ID: <Ygj+XYUy4zYQZMWt@pendragon.ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
 <7dbce123-19e6-c1b5-bebe-c49bb5d2da02@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dbce123-19e6-c1b5-bebe-c49bb5d2da02@i2se.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Sun, Feb 13, 2022 at 12:17:25PM +0100, Stefan Wahren wrote:
> Am 08.02.22 um 16:50 schrieb Jean-Michel Hautbois:
> > Add driver for the Unicam camera receiver block on BCM283x processors.
> > It is represented as two video device nodes: unicam-image and
> > unicam-embedded which are connected to an internal subdev (named
> > unicam-subdev) in order to manage streams routing.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> >
> > ---
> > v4:
> >   - Add the vendor prefox for DT name
> >   - Use the reg-names in DT parsing
> >   - Remove MAINTAINERS entry
> >
> > v3 main changes:
> >   - Change code organization
> >   - Remove unused variables
> >   - Correct the fmt_meta functions
> >   - Rewrite the start/stop streaming
> >     - You can now start the image node alone, but not the metadata one
> >     - The buffers are allocated per-node
> >     - only the required stream is started, if the route exists and is
> >       enabled
> >   - Prefix the macros with UNICAM_ to not have too generic names
> >   - Drop colorspace support
> >     -> This is causing issues in the try-fmt v4l2-compliance test
> >   test VIDIOC_G_FMT: OK
> > 	fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
> > 	fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc, pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
> >   test VIDIOC_TRY_FMT: FAIL
> > 	fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
> > 	fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc, pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
> >   test VIDIOC_S_FMT: FAIL
> >
> > v2: Remove the unicam_{info,debug,error} macros and use
> > dev_dbg/dev_err instead.
> > ---
> >  drivers/media/platform/Kconfig                |    1 +
> >  drivers/media/platform/Makefile               |    2 +
> >  drivers/media/platform/bcm2835/Kconfig        |   21 +
> >  drivers/media/platform/bcm2835/Makefile       |    3 +
> >  .../platform/bcm2835/bcm2835-unicam-regs.h    |  253 ++
> >  .../media/platform/bcm2835/bcm2835-unicam.c   | 2570 +++++++++++++++++
> >  6 files changed, 2850 insertions(+)
> >  create mode 100644 drivers/media/platform/bcm2835/Kconfig
> >  create mode 100644 drivers/media/platform/bcm2835/Makefile
> >  create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam-regs.h
> >  create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam.c
> >
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index 9fbdba0fd1e7..033b0358fbb8 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -170,6 +170,7 @@ source "drivers/media/platform/am437x/Kconfig"
> >  source "drivers/media/platform/xilinx/Kconfig"
> >  source "drivers/media/platform/rcar-vin/Kconfig"
> >  source "drivers/media/platform/atmel/Kconfig"
> > +source "drivers/media/platform/bcm2835/Kconfig"
> >  source "drivers/media/platform/sunxi/Kconfig"
> >  
> >  config VIDEO_TI_CAL
> > diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> > index 28eb4aadbf45..18894fc586aa 100644
> > --- a/drivers/media/platform/Makefile
> > +++ b/drivers/media/platform/Makefile
> > @@ -86,6 +86,8 @@ obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss/
> >  
> >  obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
> >  
> > +obj-$(CONFIG_VIDEO_BCM2835_UNICAM)	+= bcm2835/
> > +
> >  obj-y					+= sunxi/
> >  
> >  obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
> > diff --git a/drivers/media/platform/bcm2835/Kconfig b/drivers/media/platform/bcm2835/Kconfig
> > new file mode 100644
> > index 000000000000..1691541da905
> > --- /dev/null
> > +++ b/drivers/media/platform/bcm2835/Kconfig
> > @@ -0,0 +1,21 @@
> > +# Broadcom VideoCore4 V4L2 camera support
> > +
> > +config VIDEO_BCM2835_UNICAM
> > +	tristate "Broadcom BCM283x/BCM271x Unicam video capture driver"
> > +	depends on ARCH_BCM2835 || COMPILE_TEST
> > +	depends on VIDEO_V4L2
> > +	select MEDIA_CONTROLLER
> > +	select VIDEO_V4L2_SUBDEV_API
> > +	select V4L2_FWNODE
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	help
> > +	  Say Y here to enable support for the BCM283x/BCM271x CSI-2 receiver.
> > +	  This is a V4L2 driver that controls the CSI-2 receiver directly,
> > +	  independently from the VC4 firmware.
> > +	  This driver is mutually exclusive with the use of bcm2835-camera. The
> > +	  firmware will disable all access to the peripheral from within the
> > +	  firmware if it finds a DT node using it, and bcm2835-camera will
> > +	  therefore fail to probe.
>
> would be nice to know, what is the exact condition for the firmware. The
> compatible and must its status be enabled?
>
> > +
> > +	  To compile this driver as a module, choose M here. The module will be
> > +	  called bcm2835-unicam.

[snip]

> > diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam.c b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> > new file mode 100644
> > index 000000000000..470e691637c7
> > --- /dev/null
> > +++ b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> > @@ -0,0 +1,2570 @@

[snip]

> > +static inline bool unicam_sd_pad_is_sink(u32 pad)
> > +{
> > +	/* Camera RX has 1 sink pad, and N source pads */
> > +	return pad == 0;
> > +}
>
> s/0/UNICAM_SD_PAD_SINK ?

Good idea.

> > +
> > +static inline bool unicam_sd_pad_is_source(u32 pad)
> > +{
> > +	/* Camera RX has 1 sink pad, and N source pads */
> > +	return pad != UNICAM_SD_PAD_SINK;
> > +}
> > +
> > +enum unicam_node_type {
> > +	UNICAM_IMAGE_NODE,
> > +	UNICAM_METADATA_NODE,
> > +	UNICAM_MAX_NODES
> > +};
> > +
> > +/* -----------------------------------------------------------------------------
> > + * Structure definitions
> > + */
>
> please drop

I really favour splitting code in sections, it makes it more readable.
At the end of the day I think this is a personal decision for the
author, if no specific policy is enforced at the subsystem level.

[snip]

> > +/*
> > + * unicam_isr : ISR handler for unicam capture
> > + * @irq: irq number
> > + * @dev_id: dev_id ptr
>
> these kernel-doc doesn't match with the definition. dev seems to be the
> unicam instance?

I'd drop the comment as it doesn't really contain much useful information.

> > + *
> > + * It changes status of the captured buffer, takes next buffer from the queue
> > + * and sets its address in unicam registers
> > + */
> > +static irqreturn_t unicam_isr(int irq, void *dev)

[snip]

-- 
Regards,

Laurent Pinchart
