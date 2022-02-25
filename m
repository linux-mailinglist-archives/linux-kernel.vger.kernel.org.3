Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0B4C4469
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiBYMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiBYMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:15:52 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9A2275A4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:15:16 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 69F00C3EEAFF;
        Fri, 25 Feb 2022 13:15:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 69F00C3EEAFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1645791312; bh=uznWO2E4e4XX8oTlSGFj0SCiL5sa3KQXgvli76Fp7YM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oeplpv2oO2fh5hpfY9o2jQkQhruDFE66OIcT2R/QNxtZAlqgWf7YhijwO83OSQ20L
         r+iLlqiaCkJRzUKxMGX0kiJ3jmZbXJYaw50ahnnrqrDKx+xzEM/vx+AGy6TGiG+Jy5
         FUyX70Md8zLIdlz57RY2wwAojCJRec1Ph8uQt/+c=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 2/2] Driver for ON Semi AR0521 camera sensor
References: <m3czl9eylt.fsf@t19.piap.pl> <m34k6leyb1.fsf@t19.piap.pl>
        <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
Sender: khalasa@piap.pl
Date:   Fri, 25 Feb 2022 13:15:11 +0100
In-Reply-To: <20220109153439.bfnfigocaeeeghmp@uno.localdomain> (Jacopo Mondi's
        message of "Sun, 9 Jan 2022 16:34:39 +0100")
Message-ID: <m35yp387n4.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Sorry it took that long. Unfortunately I no longer have much time to
work on this, thus the delays.

Jacopo Mondi <jacopo@jmondi.org> writes:

>> +static int ar0521_s_ctrl(struct v4l2_ctrl *ctrl)
>> +{
>> +	struct v4l2_subdev *sd =3D ctrl_to_sd(ctrl);
>> +	struct ar0521_dev *sensor =3D to_ar0521_dev(sd);
>> +	int ret;
>> +
>> +	/* v4l2_ctrl_lock() locks our own mutex */
>> +
>> +	dev_dbg(&sensor->i2c_client->dev, "%s(0x%X)\n", __func__, ctrl->id);
>> +
>> +	switch (ctrl->id) {
>> +	case V4L2_CID_HBLANK:
>> +	case V4L2_CID_VBLANK:
>> +		sensor->total_width =3D sensor->fmt.width +
>> +			sensor->ctrls.hblank->val;
>> +		sensor->total_height =3D sensor->fmt.width +
>> +			sensor->ctrls.vblank->val;
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
>> +		break;
>> +	}
>> +
>> +	// access the sensor only if it's powered up
>> +	if (!pm_runtime_get_if_in_use(&sensor->i2c_client->dev))
>
> As you correctly do not access the chip's registers if it's powered
> off, you have to call __v4l2_ctrl_handler_setup() at power on time to
> make sure controls are actually set.

These registers are also written in ar0521_set_stream(), isn't it
enough?

>> +	ctrls->hblank =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HBLANK,
>> +					  AR0521_WIDTH_BLANKING_MIN, 4094, 1,
>> +					  AR0521_WIDTH_BLANKING_MIN);
>> +	ctrls->vblank =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_VBLANK,
>> +					  AR0521_HEIGHT_BLANKING_MIN, 4094, 2,
>> +					  AR0521_HEIGHT_BLANKING_MIN);
>> +	v4l2_ctrl_cluster(2, &ctrls->hblank);
>
> Is it intended to have vblank and hblank as cluster, can't they change
> independently ?

They can. It appears, though, that clusters aren't about controls which
can't change independently. Both of the two are written to the hardware
at the same time, which appears to be a valid reason to combine them
into a cluster.
This is similar to the gain/balance controls, and BTW the use of
clusters there was suggested by you.

Please correct me if I'm wrong.

>> +	/* Read-only */
>> +	ctrls->pixrate =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_PIXEL_RATE,
>> +					   AR0521_PIXEL_CLOCK_MIN,
>> +					   AR0521_PIXEL_CLOCK_MAX, 1,
>> +					   AR0521_PIXEL_CLOCK_RATE);
>
> so you have to mark it as read-only

Oh, I'd be happy for this control to be R/W. Unfortunately the core
media core enforces R/O. This is only a comment about what the core code
does, currently at least.

>> +	dev_dbg(dev, "%s()\n", __func__);
>
> Rather useless, please drop. Same for all other debug functions that
> just print the current function name in other parts of the driver.
> While maybe useful when developing, they're mostly noise for users
> imo.

Fine, will drop the rest of the debug. In fact, I already dropped the
most useful parts (I2C register access debugging).

>> +	endpoint =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
>> +						   FWNODE_GRAPH_ENDPOINT_NEXT);
>
> The drivers supports a single endpoint right ? Then
> fwnode_graph_get_next_enpoint() can be used

Well, I originally used
fwnode_graph_get_next_endpoint(of_fwnode_handle(dev->of_node), NULL).
Sakari suggested I should use the above
fwnode_graph_get_endpoint_by_id().
It could be a good idea to agree on this. Not sure about the difference.

>> +	for (cnt =3D 0; cnt < ARRAY_SIZE(ar0521_supply_names); cnt++) {
>> +		struct regulator *supply =3D devm_regulator_get(dev,
>> +						ar0521_supply_names[cnt]);
>> +
>> +		if (IS_ERR(supply)) {
>> +			dev_info(dev, "no %s regulator found: %li\n",
>> +				 ar0521_supply_names[cnt], PTR_ERR(supply));
>> +			return PTR_ERR(supply);
>> +		}
>> +		sensor->supplies[cnt] =3D supply;
>> +	}
>
> Using the regulator bulk api would simplify this.
> See drivers/media/i2c/ccs/ccs-core.c

The bulk API doesn't allow for delays between individual supplies, does it?
The delays are mandated by the manufacturer.

>> +
>> +	mutex_init(&sensor->lock);
>> +
>> +	ret =3D ar0521_init_controls(sensor);
>> +	if (ret)
>> +		goto entity_cleanup;
>> +
>> +	ar0521_adj_fmt(&sensor->fmt);
>
> Called already here above.

Right, I will remove the first one.

>> +	ret =3D v4l2_async_register_subdev(&sensor->sd);
>> +	if (ret)
>> +		goto free_ctrls;
>> +
>> +	/* Turn on the device and enable runtime PM */
>> +	ret =3D ar0521_power_on(&client->dev);
>> +	if (ret)
>> +		goto disable;
>
> Does the device stay powered all the time ?

Depends on the hw, but the power could be disabled, yes.

> Doesn't your resume callback call power_on() already ?

It does, when the PM is enabled.

Should the above code be changed?

>> +static struct i2c_driver ar0521_i2c_driver =3D {
>> +	.driver =3D {
>> +		.name  =3D "ar0521",
>> +		.pm =3D &ar0521_pm_ops,
>> +		.of_match_table	=3D ar0521_dt_ids,
>> +	},
>> +	.probe    =3D ar0521_probe,
>
> You could use probe_new and drop the "const struct i2c_device_id *id"
> argument to probe()

You are right again.

That said, I wonder if it would be better (like easier) to have this
driver added to the staging area instead.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
