Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3A5995EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbiHSHSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345958AbiHSHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:18:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD54BA63
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:18:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOwH3-00036h-Ss; Fri, 19 Aug 2022 09:18:33 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOwH2-0006Jc-S7; Fri, 19 Aug 2022 09:18:32 +0200
Date:   Fri, 19 Aug 2022 09:18:32 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] media: mt9m111: remove .s_power callback
Message-ID: <20220819071832.3mr7u7jhp2ud4fv6@pengutronix.de>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-4-m.felsch@pengutronix.de>
 <20220818161408.76ofg2rjvp5whtof@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818161408.76ofg2rjvp5whtof@uno.localdomain>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

thanks for your fast feedback :)

On 22-08-18, Jacopo Mondi wrote:
> Hi Marco
> 
> On Thu, Aug 18, 2022 at 04:47:12PM +0200, Marco Felsch wrote:
> > This is in preparation of switching to the generic dev PM mechanism.
> > Since the .s_power callback will be removed in the near future move the
> > powering into the .s_stream callback. So this driver no longer depends
> > on the .s_power mechanism.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> If you want to move to runtime_pm, I would implement it first and have
> s_power call the _resume and _suspend routines, as some platform
> drivers still use s_power() and some of them might depend on it.

Do we really have platforms which depend on this? IMHO if that is the
case than we should fix those platfoms. Since new drivers shouldn't use
this callback anymore.

In my case, I worked on [1] and wondered why the sensor was enabled
before I told him to do so. Since I didn't implement the s_power()
callback, I had no chance to get enabled before.

Can we please decide:
 - Do we wanna get rid of the s_power() callback?
 - If not, how do we handle those devices then with drivers not
   implementing this callback?

[1] https://lore.kernel.org/all/20220818143307.967150-1-m.felsch@pengutronix.de/

> It's a slippery slope.. I would love to get rid of s_power() but if
> any platform uses it with this sensor, it would stop working after
> this change.
> 
> > ---
> >  drivers/media/i2c/mt9m111.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > index cd74c408e110..8e8ba5a8e6ea 100644
> > --- a/drivers/media/i2c/mt9m111.c
> > +++ b/drivers/media/i2c/mt9m111.c
> > @@ -1065,7 +1065,6 @@ static const struct v4l2_ctrl_ops mt9m111_ctrl_ops = {
> >  };
> >
> >  static const struct v4l2_subdev_core_ops mt9m111_subdev_core_ops = {
> > -	.s_power	= mt9m111_s_power,
> >  	.log_status = v4l2_ctrl_subdev_log_status,
> >  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> >  	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
> > @@ -1136,8 +1135,14 @@ static int mt9m111_enum_mbus_code(struct v4l2_subdev *sd,
> >  static int mt9m111_s_stream(struct v4l2_subdev *sd, int enable)
> >  {
> >  	struct mt9m111 *mt9m111 = container_of(sd, struct mt9m111, subdev);
> > +	int ret;
> >
> >  	mt9m111->is_streaming = !!enable;
> > +
> > +	ret = mt9m111_s_power(sd, enable);
> > +	if (ret)
> > +		return ret;
> > +
> >  	return 0;
> >  }
> >
> > --
> > 2.30.2
> >
> 
