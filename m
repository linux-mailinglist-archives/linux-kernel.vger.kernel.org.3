Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172EF4B3B61
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiBMMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:52:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiBMMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:52:13 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDCF5B3E3;
        Sun, 13 Feb 2022 04:52:07 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80B0455A;
        Sun, 13 Feb 2022 13:52:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644756725;
        bh=2Lb3ypDKzFK5NF5PwGxz5r1s5an8XhBxr0UQzJN7mXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaBycSLvcUWVZZLAplz+x0BucW85k2OavpFcYAOhV+EJ1j8lFcF2fuXiP25BZT23i
         ylRCFsb5hQ0TxqdI26lbHdhRDLQxFmHOefQlIOXOsOR+y/zrEd3qYTzXYWTK8hygBh
         3Oc0p+5IdeEuWgjcjLepW5bo897ur2ITTieUkWgQ=
Date:   Sun, 13 Feb 2022 14:52:00 +0200
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
Message-ID: <Ygj+8Ovplpo7xR91@pendragon.ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
 <fc5700c5-0b64-056a-2775-d0ab0f6521e8@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc5700c5-0b64-056a-2775-d0ab0f6521e8@i2se.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:00:23PM +0100, Stefan Wahren wrote:
> Hi Jean-Michel,
> 
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

[snip]

> > diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam.c b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> > new file mode 100644
> > index 000000000000..470e691637c7
> > --- /dev/null
> > +++ b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> > @@ -0,0 +1,2570 @@

[snip]

> > +static int unicam_start_streaming(struct vb2_queue *vq, unsigned int count)
> > +{
> > +	struct unicam_node *node = vb2_get_drv_priv(vq);
> > +	struct unicam_device *unicam = node->dev;
> > +	dma_addr_t buffer_addr[UNICAM_MAX_NODES] = { 0 };
> > +	struct unicam_buffer *buf;
> > +	struct v4l2_subdev_state *state;
> > +	unsigned long flags;
> > +	unsigned int i;
> > +	int ret;
> > +	u32 pad, stream;
> > +	u32 remote_pad_index = is_image_node(node) ? UNICAM_SD_PAD_SOURCE_IMAGE
> > +						   : UNICAM_SD_PAD_SOURCE_METADATA;
> > +
> > +	/* Look for the route for the given pad and stream. */
> > +	state = v4l2_subdev_lock_active_state(&unicam->subdev.sd);
> > +
> > +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing,
> > +						    remote_pad_index, 0,
> > +						    &pad, &stream);
> > +	if (ret)
> > +		goto err_streaming;
> > +
> > +	v4l2_subdev_unlock_state(state);
> > +
> > +	dev_dbg(unicam->dev, "Starting stream 0 on pad %d on subdev %s\n",
> > +		remote_pad_index, unicam->subdev.sd.name);
> > +
> > +	/* The metadata node can't be started alone. */
> > +	if (is_metadata_node(node)) {
> > +		if (!unicam->node[UNICAM_IMAGE_NODE].streaming) {
> > +			dev_err(unicam->dev,
> > +				"Can't start metadata without image\n");
> > +			return -EINVAL;
> > +		}
> > +		dev_dbg(unicam->dev, "starting metadata node\n");
> > +
> > +		spin_lock_irqsave(&node->dma_queue_lock, flags);
> > +		buf = list_first_entry(&node->dma_queue,
> > +				       struct unicam_buffer, list);
> > +		dev_dbg(unicam->dev, "buffer %d: %p\n", i, buf);
> > +		node->cur_frm = buf;
> > +		node->next_frm = buf;
> > +		list_del(&buf->list);
> > +		spin_unlock_irqrestore(&node->dma_queue_lock, flags);
> > +
> > +		buffer_addr[UNICAM_METADATA_NODE] =
> > +			vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> > +		dev_dbg(unicam->dev, "buffer %d addr: %lld\n", i, buffer_addr[i]);
> 
> i tried to compile the driver and get the following warning. I think the
> easiest solution would be to drop this debug message.

For the record, the right format specifier would be

		dev_dbg(unicam->dev, "buffer %d addr: %pad\n", i, &buffer_addr[i]);

(note the & before buffer_addr)

> In file included from ./include/linux/printk.h:555:0,
> 
>                  from ./include/linux/kernel.h:29,
>                  from ./include/linux/clk.h:13,
>                  from drivers/media/platform/bcm2835/bcm2835-unicam.c:47:
> drivers/media/platform/bcm2835/bcm2835-unicam.c: In function
> ‘unicam_start_streaming’:
> drivers/media/platform/bcm2835/bcm2835-unicam.c:1676:24: warning: format
> ‘%lld’ expects argument of type ‘long long int’, but argument 5 has type
> ‘dma_addr_t {aka unsigned int}’ [-Wformat=]
>    dev_dbg(unicam->dev, "buffer %d addr: %lld\n", i, buffer_addr[i]);
>                         ^
> ./include/linux/dynamic_debug.h:134:15: note: in definition of macro
> ‘__dynamic_func_call’
>    func(&id, ##__VA_ARGS__);  \
>                ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> ‘_dynamic_func_call’
>   _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>   ^~~~~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:155:2: note: in expansion of macro
> ‘dynamic_dev_dbg’
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:155:23: note: in expansion of macro ‘dev_fmt’
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                        ^~~~~~~
> drivers/media/platform/bcm2835/bcm2835-unicam.c:1676:3: note: in
> expansion of macro ‘dev_dbg’
>    dev_dbg(unicam->dev, "buffer %d addr: %lld\n", i, buffer_addr[i]);
>    ^~~~~~~

-- 
Regards,

Laurent Pinchart
