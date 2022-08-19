Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49DD59963C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbiHSHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbiHSHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:33:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F3E3C33
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:33:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOwUx-0005VQ-U4; Fri, 19 Aug 2022 09:32:55 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOwUx-0006rP-E7; Fri, 19 Aug 2022 09:32:55 +0200
Date:   Fri, 19 Aug 2022 09:32:55 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: mt9m111: fix device power usage
Message-ID: <20220819073255.lgdcjlczfv6fx7xg@pengutronix.de>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-3-m.felsch@pengutronix.de>
 <20220819072605.sbp6ycsf3oj74j6c@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819072605.sbp6ycsf3oj74j6c@uno.localdomain>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 22-08-19, Jacopo Mondi wrote:
> Hi Marco
> 
> On Thu, Aug 18, 2022 at 04:47:11PM +0200, Marco Felsch wrote:
> > Currently the driver turn off the power after probe and toggle it during
> > .stream by using the .s_power callback. This is problematic since other
> > callbacks like .set_fmt accessing the hardware as well which will fail.
> 
> Ouch!
> 
> > So in the end the default format is the only supported format.
> >
> > Remove the hardware register access from the callbacks and instead sync
> > the state once right before the stream gets enabled to fix this.
> 
> Where does it happen in this patch ?

during mt9m111_s_power which gets called by s_power() or after this
small series during s_stream().

> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/media/i2c/mt9m111.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > index 53c4dac4e4bd..cd74c408e110 100644
> > --- a/drivers/media/i2c/mt9m111.c
> > +++ b/drivers/media/i2c/mt9m111.c
> > @@ -481,8 +481,6 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
> >  	width = min(mt9m111->width, rect.width);
> >  	height = min(mt9m111->height, rect.height);
> >
> > -
> 
> Why in mainline I don't see these empty lines ?

Hm.. because I introduced this during my "media: mt9m111: fix subdev API
usage" patch.. Sorry.

> > -	mt9m111_setup_geometry(mt9m111, &rect, width, height, mt9m111->fmt->code);
> >  	mt9m111->rect = rect;
> >  	mt9m111->width = width;
> >  	mt9m111->height = height;
> > @@ -611,7 +609,6 @@ static int mt9m111_set_pixfmt(struct mt9m111 *mt9m111,
> >  	if (mt9m111->pclk_sample == 0)
> >  		mask_outfmt2 |= MT9M111_OUTFMT_INV_PIX_CLOCK;
> >
> > -
> >  	mt9m111_reg_mask(client, context_a.output_fmt_ctrl2,
> >  			 data_outfmt2, mask_outfmt2);
> >  	mt9m111_reg_mask(client, context_b.output_fmt_ctrl2,
> > @@ -678,9 +675,6 @@ static int mt9m111_set_fmt(struct v4l2_subdev *sd,
> >  		return 0;
> >  	}
> >
> > -
> > -	mt9m111_setup_geometry(mt9m111, rect, mf->width, mf->height, mf->code);
> > -	mt9m111_set_pixfmt(mt9m111, mf->code);
> 
> Are we looking at two different versions of the driver ??
> https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/mt9m111.c#L684

Same here.

> >  	mt9m111->width	= mf->width;
> >  	mt9m111->height	= mf->height;
> >  	mt9m111->fmt	= fmt;
> > @@ -743,6 +737,8 @@ mt9m111_find_mode(struct mt9m111 *mt9m111, unsigned int req_fps,
> >  	return mode;
> >  }
> >
> > +static int mt9m111_s_power(struct v4l2_subdev *sd, int on);
> > +
> >  #ifdef CONFIG_VIDEO_ADV_DEBUG
> >  static int mt9m111_g_register(struct v4l2_subdev *sd,
> >  			      struct v4l2_dbg_register *reg)
> > @@ -753,10 +749,14 @@ static int mt9m111_g_register(struct v4l2_subdev *sd,
> >  	if (reg->reg > 0x2ff)
> >  		return -EINVAL;
> >
> > +	mt9m111_s_power(sd, 1);
> > +
> >  	val = mt9m111_reg_read(client, reg->reg);
> >  	reg->size = 2;
> >  	reg->val = (u64)val;
> >
> > +	mt9m111_s_power(sd, 0);
> > +
> >  	if (reg->val > 0xffff)
> >  		return -EIO;
> >
> > @@ -771,9 +771,13 @@ static int mt9m111_s_register(struct v4l2_subdev *sd,
> >  	if (reg->reg > 0x2ff)
> >  		return -EINVAL;
> >
> > +	mt9m111_s_power(sd, 1);
> > +
> >  	if (mt9m111_reg_write(client, reg->reg, reg->val) < 0)
> >  		return -EIO;
> >
> > +	mt9m111_s_power(sd, 0);
> > +
> >  	return 0;
> >  }
> >  #endif
> > @@ -896,6 +900,9 @@ static int mt9m111_s_ctrl(struct v4l2_ctrl *ctrl)
> >  					       struct mt9m111, hdl);
> >  	int ret;
> >
> > +	if (!mt9m111->is_streaming)
> > +		return 0;
> > +
> >  	switch (ctrl->id) {
> >  	case V4L2_CID_VFLIP:
> >  		ret = mt9m111_set_flip(mt9m111, ctrl->val,
> > @@ -927,7 +934,6 @@ static int mt9m111_s_ctrl(struct v4l2_ctrl *ctrl)
> >  		ret = -EINVAL;
> >  	}
> >
> > -
> >  	return ret;
> >  }
> >
> > --
> > 2.30.2
> >
> 
