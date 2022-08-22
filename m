Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B159BAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiHVHvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiHVHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:51:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA12AE0D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:51:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQ2D8-0001Hr-1H; Mon, 22 Aug 2022 09:51:02 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQ2D7-000666-1O; Mon, 22 Aug 2022 09:51:01 +0200
Date:   Mon, 22 Aug 2022 09:51:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] media: mt9m111: fix subdev API usage
Message-ID: <20220822075101.75dv3cv2evb2qeqq@pengutronix.de>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-2-m.felsch@pengutronix.de>
 <YwMiJYympE18tkmm@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwMiJYympE18tkmm@paasikivi.fi.intel.com>
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

Hi Sakari,

On 22-08-22, Sakari Ailus wrote:
> Hi Marco,
> 
> On Thu, Aug 18, 2022 at 04:47:10PM +0200, Marco Felsch wrote:
> > In case of I2C transfer failures the driver return failure codes which
> > are not allowed according the API documentation. Fix that by ignore the
> > register access failure codes.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/media/i2c/mt9m111.c | 116 ++++++++++++++++++++----------------
> >  1 file changed, 66 insertions(+), 50 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > index cdaf283e1309..53c4dac4e4bd 100644
> > --- a/drivers/media/i2c/mt9m111.c
> > +++ b/drivers/media/i2c/mt9m111.c
> > @@ -455,7 +455,7 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
> >  	struct mt9m111 *mt9m111 = to_mt9m111(client);
> >  	struct v4l2_rect rect = sel->r;
> >  	int width, height;
> > -	int ret, align = 0;
> > +	int align = 0;
> >  
> >  	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE ||
> >  	    sel->target != V4L2_SEL_TGT_CROP)
> > @@ -481,14 +481,13 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
> >  	width = min(mt9m111->width, rect.width);
> >  	height = min(mt9m111->height, rect.height);
> >  
> > -	ret = mt9m111_setup_geometry(mt9m111, &rect, width, height, mt9m111->fmt->code);
> > -	if (!ret) {
> > -		mt9m111->rect = rect;
> > -		mt9m111->width = width;
> > -		mt9m111->height = height;
> > -	}
> >  
> > -	return ret;
> > +	mt9m111_setup_geometry(mt9m111, &rect, width, height, mt9m111->fmt->code);
> 
> If the function can fail, it'd be much better to move it to s_stream
> callback than ignore the error.
> 
> Same for the rest of such changes.

I did that in the following patch, but I can merge them if you want.

Regards,
  Marco
