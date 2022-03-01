Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614D24C8745
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiCAJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCAJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:02:19 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8C08A309;
        Tue,  1 Mar 2022 01:01:38 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id C225D1C0010;
        Tue,  1 Mar 2022 09:01:34 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:01:32 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 2/2] Driver for ON Semi AR0521 camera sensor
Message-ID: <20220301090132.g5xsodoeotcm6h2q@uno.localdomain>
References: <m3czl9eylt.fsf@t19.piap.pl>
 <m34k6leyb1.fsf@t19.piap.pl>
 <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
 <m35yp387n4.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m35yp387n4.fsf@t19.piap.pl>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Fri, Feb 25, 2022 at 01:15:11PM +0100, Krzysztof Hałasa wrote:
> Hi Jacopo,
>
> Sorry it took that long. Unfortunately I no longer have much time to
> work on this, thus the delays.
>

No worries! sorry it took me a few days to reply

> Jacopo Mondi <jacopo@jmondi.org> writes:
>
> >> +static int ar0521_s_ctrl(struct v4l2_ctrl *ctrl)
> >> +{
> >> +	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
> >> +	struct ar0521_dev *sensor = to_ar0521_dev(sd);
> >> +	int ret;
> >> +
> >> +	/* v4l2_ctrl_lock() locks our own mutex */
> >> +
> >> +	dev_dbg(&sensor->i2c_client->dev, "%s(0x%X)\n", __func__, ctrl->id);
> >> +
> >> +	switch (ctrl->id) {
> >> +	case V4L2_CID_HBLANK:
> >> +	case V4L2_CID_VBLANK:
> >> +		sensor->total_width = sensor->fmt.width +
> >> +			sensor->ctrls.hblank->val;
> >> +		sensor->total_height = sensor->fmt.width +
> >> +			sensor->ctrls.vblank->val;
> >> +		break;
> >> +	default:
> >> +		ret = -EINVAL;
> >> +		break;
> >> +	}
> >> +
> >> +	// access the sensor only if it's powered up
> >> +	if (!pm_runtime_get_if_in_use(&sensor->i2c_client->dev))
> >
> > As you correctly do not access the chip's registers if it's powered
> > off, you have to call __v4l2_ctrl_handler_setup() at power on time to
> > make sure controls are actually set.
>
> These registers are also written in ar0521_set_stream(), isn't it
> enough?

Oh I see, set_stream() sets gains and then calls write_mode() which
handles blankings, exposure and test pattern so yes, all controls seem
to be covered. It's usually safer to go through the control handler
to make sure that any control that is added later is not left behind.
But for now it's all right!

>
> >> +	ctrls->hblank = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HBLANK,
> >> +					  AR0521_WIDTH_BLANKING_MIN, 4094, 1,
> >> +					  AR0521_WIDTH_BLANKING_MIN);
> >> +	ctrls->vblank = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_VBLANK,
> >> +					  AR0521_HEIGHT_BLANKING_MIN, 4094, 2,
> >> +					  AR0521_HEIGHT_BLANKING_MIN);
> >> +	v4l2_ctrl_cluster(2, &ctrls->hblank);
> >
> > Is it intended to have vblank and hblank as cluster, can't they change
> > independently ?
>
> They can. It appears, though, that clusters aren't about controls which
> can't change independently. Both of the two are written to the hardware
> at the same time, which appears to be a valid reason to combine them
> into a cluster.

Is there a reason to write them to hw at the same time ? :)

> This is similar to the gain/balance controls, and BTW the use of
> clusters there was suggested by you.


>
> Please correct me if I'm wrong.

I don't think it's strictly necessary to clusterize them, but
defintely not a big deal

>
> >> +	/* Read-only */
> >> +	ctrls->pixrate = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_PIXEL_RATE,
> >> +					   AR0521_PIXEL_CLOCK_MIN,
> >> +					   AR0521_PIXEL_CLOCK_MAX, 1,
> >> +					   AR0521_PIXEL_CLOCK_RATE);
> >
> > so you have to mark it as read-only
>
> Oh, I'd be happy for this control to be R/W. Unfortunately the core
> media core enforces R/O. This is only a comment about what the core code
> does, currently at least.

You right, the core does that for you

>
> >> +	dev_dbg(dev, "%s()\n", __func__);
> >
> > Rather useless, please drop. Same for all other debug functions that
> > just print the current function name in other parts of the driver.
> > While maybe useful when developing, they're mostly noise for users
> > imo.
>
> Fine, will drop the rest of the debug. In fact, I already dropped the
> most useful parts (I2C register access debugging).
>
> >> +	endpoint = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> >> +						   FWNODE_GRAPH_ENDPOINT_NEXT);
> >
> > The drivers supports a single endpoint right ? Then
> > fwnode_graph_get_next_enpoint() can be used
>
> Well, I originally used
> fwnode_graph_get_next_endpoint(of_fwnode_handle(dev->of_node), NULL).
> Sakari suggested I should use the above
> fwnode_graph_get_endpoint_by_id().
> It could be a good idea to agree on this. Not sure about the difference.
>

Let's stick with what Sakari suggested.

> >> +	for (cnt = 0; cnt < ARRAY_SIZE(ar0521_supply_names); cnt++) {
> >> +		struct regulator *supply = devm_regulator_get(dev,
> >> +						ar0521_supply_names[cnt]);
> >> +
> >> +		if (IS_ERR(supply)) {
> >> +			dev_info(dev, "no %s regulator found: %li\n",
> >> +				 ar0521_supply_names[cnt], PTR_ERR(supply));
> >> +			return PTR_ERR(supply);
> >> +		}
> >> +		sensor->supplies[cnt] = supply;
> >> +	}
> >
> > Using the regulator bulk api would simplify this.
> > See drivers/media/i2c/ccs/ccs-core.c
>
> The bulk API doesn't allow for delays between individual supplies, does it?
> The delays are mandated by the manufacturer.
>

Ack then, no bulk API

> >> +
> >> +	mutex_init(&sensor->lock);
> >> +
> >> +	ret = ar0521_init_controls(sensor);
> >> +	if (ret)
> >> +		goto entity_cleanup;
> >> +
> >> +	ar0521_adj_fmt(&sensor->fmt);
> >
> > Called already here above.
>
> Right, I will remove the first one.
>
> >> +	ret = v4l2_async_register_subdev(&sensor->sd);
> >> +	if (ret)
> >> +		goto free_ctrls;
> >> +
> >> +	/* Turn on the device and enable runtime PM */
> >> +	ret = ar0521_power_on(&client->dev);
> >> +	if (ret)
> >> +		goto disable;
> >
> > Does the device stay powered all the time ?
>
> Depends on the hw, but the power could be disabled, yes.
>
> > Doesn't your resume callback call power_on() already ?
>
> It does, when the PM is enabled.
>
> Should the above code be changed?
>

As it doesn't seem to me you access registers during probe (to
identify the sensor in example) there's no need to power up the device
during probe, but should be enough to let runtime_pm do so when
requested.

> >> +static struct i2c_driver ar0521_i2c_driver = {
> >> +	.driver = {
> >> +		.name  = "ar0521",
> >> +		.pm = &ar0521_pm_ops,
> >> +		.of_match_table	= ar0521_dt_ids,
> >> +	},
> >> +	.probe    = ar0521_probe,
> >
> > You could use probe_new and drop the "const struct i2c_device_id *id"
> > argument to probe()
>
> You are right again.
>
> That said, I wonder if it would be better (like easier) to have this
> driver added to the staging area instead.

Personally I don't think this driver qualifies for staging, it can
be accepted in this form and be eventually changed on top in
drivers/media. Let's see what maintainers think.

I'll review the last version and hope to see this merged soon.

Thanks
  j


> --
> Krzysztof "Chris" Hałasa
>
> Sieć Badawcza Łukasiewicz
> Przemysłowy Instytut Automatyki i Pomiarów PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa
