Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A95996E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347628AbiHSIQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbiHSIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:15:57 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D5B8A64;
        Fri, 19 Aug 2022 01:15:55 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 8F6011BF208;
        Fri, 19 Aug 2022 08:15:50 +0000 (UTC)
Date:   Fri, 19 Aug 2022 10:15:48 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] media: mt9m111: add V4L2_CID_PIXEL_RATE support
Message-ID: <20220819081548.q6c5pwio2z2ambqq@uno.localdomain>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818161108.dlmi77o6j7wcyayc@uno.localdomain>
 <20220819075615.a3nuakrac54kn7t3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220819075615.a3nuakrac54kn7t3@pengutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco

On Fri, Aug 19, 2022 at 09:56:15AM +0200, Marco Felsch wrote:
> Hi Jacopo,
>
> On 22-08-18, Jacopo Mondi wrote:
> > Hi Marco
> >
> > On Thu, Aug 18, 2022 at 04:47:09PM +0200, Marco Felsch wrote:
> > > Add support to report the PIXEL_RATE so a host or bridge device can ask
> > > the sensor.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/media/i2c/mt9m111.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > > index afc86efa9e3e..cdaf283e1309 100644
> > > --- a/drivers/media/i2c/mt9m111.c
> > > +++ b/drivers/media/i2c/mt9m111.c
> > > @@ -908,6 +908,8 @@ static int mt9m111_s_ctrl(struct v4l2_ctrl *ctrl)
> > >  		return mt9m111_set_test_pattern(mt9m111, ctrl->val);
> > >  	case V4L2_CID_COLORFX:
> > >  		return mt9m111_set_colorfx(mt9m111, ctrl->val);
> > > +	case V4L2_CID_PIXEL_RATE:
> > > +		return 0;
> >
> > By default PIXEL_RATE is read-only.
> > Do you get a call to s_ctrl for it ?
>
> You're absolutly right, we don't need to do this.
>
> > >  	}
> > >
> > >  	return -EINVAL;
> > > @@ -1249,6 +1251,7 @@ static int mt9m111_probe(struct i2c_client *client)
> > >  {
> > >  	struct mt9m111 *mt9m111;
> > >  	struct i2c_adapter *adapter = client->adapter;
> > > +	unsigned long mclk_rate;
> > >  	int ret;
> > >
> > >  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> > > @@ -1271,6 +1274,13 @@ static int mt9m111_probe(struct i2c_client *client)
> > >  	if (IS_ERR(mt9m111->clk))
> > >  		return PTR_ERR(mt9m111->clk);
> > >
> > > +	ret = clk_prepare_enable(mt9m111->clk);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> >
> > Do you need to enable clock to read its rate ?
>
> Yes, accroding the API [1].
>
> [1] https://elixir.bootlin.com/linux/v6.0-rc1/source/include/linux/clk.h#L682

So weird! none of the drivers I checked do that. The most common
pattern is

        clk = devm_clk_get();
        rate = clk_get_rate(clk)
        if (rate != RATE)
                ...

>
> > > +	mclk_rate = clk_get_rate(mt9m111->clk);
> > > +	clk_disable_unprepare(mt9m111->clk);
> > > +
> > >  	mt9m111->regulator = devm_regulator_get(&client->dev, "vdd");
> > >  	if (IS_ERR(mt9m111->regulator)) {
> > >  		dev_err(&client->dev, "regulator not found: %ld\n",
> > > @@ -1285,7 +1295,7 @@ static int mt9m111_probe(struct i2c_client *client)
> > >  	mt9m111->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> > >  				 V4L2_SUBDEV_FL_HAS_EVENTS;
> > >
> > > -	v4l2_ctrl_handler_init(&mt9m111->hdl, 7);
> > > +	v4l2_ctrl_handler_init(&mt9m111->hdl, 8);
> > >  	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
> > >  			V4L2_CID_VFLIP, 0, 1, 1, 0);
> > >  	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
> > > @@ -1309,6 +1319,9 @@ static int mt9m111_probe(struct i2c_client *client)
> > >  				BIT(V4L2_COLORFX_NEGATIVE) |
> > >  				BIT(V4L2_COLORFX_SOLARIZATION)),
> > >  			V4L2_COLORFX_NONE);
> > > +	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops, V4L2_CID_PIXEL_RATE,
> > > +			  mclk_rate, mclk_rate, 1, mclk_rate);
> > > +
> >
> > I don't have a datasheet but it seems a little weird that the mclk
> > frequency is the same as the pixel clock rate ?
>
> I see your confusion here. I can only speak for the MT9M131 device which
> is covered by this driver as well. This device is composed of a
> internal-sensor and a internal-isp. The internal-sensor is clocked by
> mclk/2 but the final image device/sensor output-fifo is clocked by mclk.

No PLL, no rate multiplier/divider ? Does this sensor only work with
one pixel rate that is defined by the input clock rate ?

> There are options to devide the output clock as well, but these options
> are not enabled yet. So yes, the pixel clock rate == mclk rate. To avoid

Ah ok

Could you share your setup mclk, resolution and frame rate to show how
the pixel rate and the mclk rate are related ?

> confusion I could rename the mclk_rate to extclk_rate but then clock
> request is not 100% correct since we are requesting a "mclk", this
> should be "extclk".

Doesn't really make a difference!

A comment in the code to explain what happens would help though!

>
> Regards,
>   Marco
>
> > >  	mt9m111->subdev.ctrl_handler = &mt9m111->hdl;
> > >  	if (mt9m111->hdl.error) {
> > >  		ret = mt9m111->hdl.error;
> > > --
> > > 2.30.2
> > >
> >
