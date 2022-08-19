Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BBE599644
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbiHSHfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346683AbiHSHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:35:21 -0400
X-Greylist: delayed 1133 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 00:35:19 PDT
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806F982FB8;
        Fri, 19 Aug 2022 00:35:19 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 9667A20002;
        Fri, 19 Aug 2022 07:35:14 +0000 (UTC)
Date:   Fri, 19 Aug 2022 09:35:12 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] media: mt9m111: remove .s_power callback
Message-ID: <20220819073512.ulud7ppnrudxewdn@uno.localdomain>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-4-m.felsch@pengutronix.de>
 <20220818161408.76ofg2rjvp5whtof@uno.localdomain>
 <20220819071832.3mr7u7jhp2ud4fv6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220819071832.3mr7u7jhp2ud4fv6@pengutronix.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco

On Fri, Aug 19, 2022 at 09:18:32AM +0200, Marco Felsch wrote:
> Hi Jacopo,
>
> thanks for your fast feedback :)
>
> On 22-08-18, Jacopo Mondi wrote:
> > Hi Marco
> >
> > On Thu, Aug 18, 2022 at 04:47:12PM +0200, Marco Felsch wrote:
> > > This is in preparation of switching to the generic dev PM mechanism.
> > > Since the .s_power callback will be removed in the near future move the
> > > powering into the .s_stream callback. So this driver no longer depends
> > > on the .s_power mechanism.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> >
> > If you want to move to runtime_pm, I would implement it first and have
> > s_power call the _resume and _suspend routines, as some platform
> > drivers still use s_power() and some of them might depend on it.
>
> Do we really have platforms which depend on this? IMHO if that is the

$ git grep "v4l2_subdev_call(.*, s_power" drivers/media/platform/  | cut -d : -f1 | uniq  | wc -l
8

> case than we should fix those platfoms. Since new drivers shouldn't use
> this callback anymore.

Patches are clearly welcome I guess..

>
> In my case, I worked on [1] and wondered why the sensor was enabled
> before I told him to do so. Since I didn't implement the s_power()
> callback, I had no chance to get enabled before.
>

I'm not sure I got this part

> Can we please decide:
>  - Do we wanna get rid of the s_power() callback?

I think that would be everyone's desire, but drivers have to be moved
away from it

>  - If not, how do we handle those devices then with drivers not
>    implementing this callback?

By maintaining compatibility. I suggested to move to runtime_pm() and
wrap _resume/_suspend in s_power(). My understanding is that the two
(runtime_pm/s_power) are mutually exclusive, but even if that was not
the case, runtime_pm is reference counted, hence as long as calls are
balanced this should work, right ?

>
> [1] https://lore.kernel.org/all/20220818143307.967150-1-m.felsch@pengutronix.de/
>
> > It's a slippery slope.. I would love to get rid of s_power() but if
> > any platform uses it with this sensor, it would stop working after
> > this change.
> >
> > > ---
> > >  drivers/media/i2c/mt9m111.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > > index cd74c408e110..8e8ba5a8e6ea 100644
> > > --- a/drivers/media/i2c/mt9m111.c
> > > +++ b/drivers/media/i2c/mt9m111.c
> > > @@ -1065,7 +1065,6 @@ static const struct v4l2_ctrl_ops mt9m111_ctrl_ops = {
> > >  };
> > >
> > >  static const struct v4l2_subdev_core_ops mt9m111_subdev_core_ops = {
> > > -	.s_power	= mt9m111_s_power,
> > >  	.log_status = v4l2_ctrl_subdev_log_status,
> > >  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> > >  	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
> > > @@ -1136,8 +1135,14 @@ static int mt9m111_enum_mbus_code(struct v4l2_subdev *sd,
> > >  static int mt9m111_s_stream(struct v4l2_subdev *sd, int enable)
> > >  {
> > >  	struct mt9m111 *mt9m111 = container_of(sd, struct mt9m111, subdev);
> > > +	int ret;
> > >
> > >  	mt9m111->is_streaming = !!enable;
> > > +
> > > +	ret = mt9m111_s_power(sd, enable);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	return 0;
> > >  }
> > >
> > > --
> > > 2.30.2
> > >
> >
