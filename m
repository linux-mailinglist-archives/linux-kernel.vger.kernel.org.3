Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1F51DAE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442340AbiEFOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiEFOqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:46:51 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B52B6AA43;
        Fri,  6 May 2022 07:43:06 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4ECEC2000B;
        Fri,  6 May 2022 14:43:02 +0000 (UTC)
Date:   Fri, 6 May 2022 16:43:00 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: ov5675: add device-tree support
Message-ID: <20220506144300.nv3lqogpkir3i7fz@uno.localdomain>
References: <20220504135543.59522-1-foss+kernel@0leil.net>
 <20220504135543.59522-2-foss+kernel@0leil.net>
 <20220505074725.4aabembd4uh4tt23@uno.localdomain>
 <YnOKuGqQ74rGUz6q@valkosipuli.retiisi.eu>
 <1344ed86-1505-a1af-1671-67106a4b9cf7@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1344ed86-1505-a1af-1671-67106a4b9cf7@theobroma-systems.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentinm

On Fri, May 06, 2022 at 04:13:07PM +0200, Quentin Schulz wrote:
> Sakari, Jacopo,
>
> On 5/5/22 10:28, Sakari Ailus wrote:
> > Hi Jacopo, Quentin,
> >
> > On Thu, May 05, 2022 at 09:47:25AM +0200, Jacopo Mondi wrote:
> > > Hi Quentin,
> > >
> > > On Wed, May 04, 2022 at 03:55:42PM +0200, Quentin Schulz wrote:
> > > > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > >
> > > > Until now, this driver only supported ACPI. This adds support for
> > > > Device Tree too.
> > > >
> > > > This is heavily inspired by device tree support addition to OV8856
> > > > driver. The differentiation between ACPI and DT mode is done through an
> > > > is_acpi_node check.
> > > >
> > > > Cc: Quentin Schulz <foss+kernel@0leil.net>
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > > ---
> > > >
> > > > v2:
> > > >   - fixed unused-const-variable warning by removing of_match_ptr in
> > > >   of_match_table, reported by kernel test robot,
> > > >
> > > >   drivers/media/i2c/ov5675.c | 134 +++++++++++++++++++++++++++++++++----
> > > >   1 file changed, 121 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> > > > index 82ba9f56baec..ccbc8dc506ff 100644
> > > > --- a/drivers/media/i2c/ov5675.c
> > > > +++ b/drivers/media/i2c/ov5675.c
> > > > @@ -3,10 +3,13 @@
> > > >
> > > >   #include <asm/unaligned.h>
> > > >   #include <linux/acpi.h>
> > > > +#include <linux/clk.h>
> > > >   #include <linux/delay.h>
> > > > +#include <linux/gpio/consumer.h>
> > > >   #include <linux/i2c.h>
> > >
> > > #include <linux/mod_devicetable.h>
> > >
> > > for struct of_device_id
> > >
>
> Mmm.. Wondering why this is needed if it compiles fine without? What am I
> missing?
>

Probably included by another header, with the risk that if the
inclusion chain gets changed in future the symbol might be undefined.

It's easy to verify for yourself where struct of_device_id is defined

> > > >   #include <linux/module.h>
> > > >   #include <linux/pm_runtime.h>
> > > > +#include <linux/regulator/consumer.h>
> > > >   #include <media/v4l2-ctrls.h>
> > > >   #include <media/v4l2-device.h>
> > > >   #include <media/v4l2-fwnode.h>
> > > > @@ -17,7 +20,7 @@
> > > >
> > > >   #define OV5675_LINK_FREQ_450MHZ		450000000ULL
> > > >   #define OV5675_SCLK			90000000LL
> > > > -#define OV5675_MCLK			19200000
> > > > +#define OV5675_XVCLK_19_2		19200000
> > > >   #define OV5675_DATA_LANES		2
> > > >   #define OV5675_RGB_DEPTH		10
> > > >
> > > > @@ -76,6 +79,14 @@
> > > >
> > > >   #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
> > > >
> > > > +static const char * const ov5675_supply_names[] = {
> > > > +	"avdd",		/* Analog power */
> > > > +	"dovdd",	/* Digital I/O power */
> > > > +	"dvdd",		/* Digital core power */
> > > > +};
> > > > +
> > > > +#define OV5675_NUM_SUPPLIES	ARRAY_SIZE(ov5675_supply_names)
> > > > +
> > > >   enum {
> > > >   	OV5675_LINK_FREQ_900MBPS,
> > > >   };
> > > > @@ -484,6 +495,9 @@ struct ov5675 {
> > > >   	struct v4l2_subdev sd;
> > > >   	struct media_pad pad;
> > > >   	struct v4l2_ctrl_handler ctrl_handler;
> > > > +	struct clk		*xvclk;
> > > > +	struct gpio_desc	*reset_gpio;
> > > > +	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
> > > >
> > > >   	/* V4L2 Controls */
> > > >   	struct v4l2_ctrl *link_freq;
> > > > @@ -944,6 +958,52 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
> > > >   	return ret;
> > > >   }
> > > >
> > > > +static void __ov5675_power_off(struct ov5675 *ov5675)
> > > > +{
> > > > +	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
> > > > +
> > > > +	if (is_acpi_node(dev_fwnode(&client->dev)))
> > > > +		return;
> > > > +
> > > > +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
> > > > +	usleep_range(1000, 1200);
> > > > +
> > > > +	regulator_bulk_disable(OV5675_NUM_SUPPLIES, ov5675->supplies);
> > > > +	clk_disable_unprepare(ov5675->xvclk);
> > > > +}
> > > > +
> > > > +static int __ov5675_power_on(struct ov5675 *ov5675)
> > > > +{
> > > > +	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
> > > > +	int ret;
> > > > +
> > > > +	if (is_acpi_node(dev_fwnode(&client->dev)))
> > >
> > > A question for Sakari here:
> > >
> > > I have a similar series for ov5670, where I don't use is_acpi_node()
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.linuxtv.org_project_linux-2Dmedia_patch_20220329090133.338073-2D7-2Djacopo-40jmondi.org_&d=DwIBAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=d4bhfjobjD_6CMiuzFRtZy27p0ytvQuScDxLXtsaHnzywAfKYeap61kXxLuejvfT&s=pnMz66bcaCWlXZZEIqknW9Atqkxp28rKJFT4lllZhuQ&e=
> > >
> > > should this be done for all drivers supporting acpi && OF ?
> >
> > It's better if you don't.
> >
> > Regulators and GPIOs can be present in ACPI systems, too, I'm not sure
> > about clocks (maybe not yet?). If you check for ACPI and then bail out
> > here, the driver may not work on some systems.
> >
>
> Yet, the driver does not use regulators and GPIOs and is only probed via
> ACPI.
>
> The fact is that today, the ACPI version does not need any of this but the
> Device Tree version does. If the ACPI version would need to support
> regulators and GPIOs too, I'd say that's out of topic for this patch series.
> Especially since I do not have anything to test ACPI version.
>
> I expect the suggested implementation to not break (nor improve!) anything
> on ACPI.
>
> > On the other hand, you might be able to skip some of these delays in some
> > cases if the related resource isn't there. The datasheet probably tells
> > more of that.
> >
>
> I don't trust the datasheet.. I discovered that I need to wait for 2ms AFTER
> the regulators have been turned on to release the reset gpio and not just
> 2ms of holding reset gpio. Even though the datasheet states that there's
> literally no minimum delay between the rising of the power rails and the
> release of reset gpio. So the way I did in this patchset is not always
> working (actually less often than it does... will fix that in v2).
>
> > I guess the driver or the example driver name in documentation need
> > some revising.
> >
> > >
> > > > +		return 0;
> > > > +
> > > > +	ret = clk_prepare_enable(ov5675->xvclk);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&client->dev, "failed to enable xvclk: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
> > > > +
> > > > +	/* Reset pulse should be at least 2ms */
> > > > +	usleep_range(2000, 2200);
> > > > +
> > > > +	ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, ov5675->supplies);
> > > > +	if (ret) {
> > > > +		clk_disable_unprepare(ov5675->xvclk);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
> > > > +
> > > > +	usleep_range(1000, 1200);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >   static int __maybe_unused ov5675_suspend(struct device *dev)
> > > >   {
> > > >   	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > > > @@ -953,6 +1013,7 @@ static int __maybe_unused ov5675_suspend(struct device *dev)
> > > >   	if (ov5675->streaming)
> > > >   		ov5675_stop_streaming(ov5675);
> > > >
> > > > +	__ov5675_power_off(ov5675);
> > >
> > > So you plumb the device power/up down in the SYSTEM_SLEEP_PM_OPS() callbacks ?
> > >
> > > My understanding is that it would be better to create RUNTIME_PM_OPS()
> > > for this, so that the device can be runtime suspended/resumed.
>
> Can't test runtime PM for ACPI version and didn't want to risk breaking this
> support.

Why are you mentioning ACPI ?

My point here is that the driver supports only power management at
system suspend/resume time and does not implement runtime power
management and would be trivial for you to do so.

>
> The point of this was to be of minimal impact on existing users. Also see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c2c7a1e0d69221b9d489bfd8cf53262d6f82446
>
> Not saying it is good, just pointing at the inspiration for this patch.
>
> >
> > Yes, please. The driver already uses runtime PM.
> >
>
> Does it? I only see SYSTEM_SLEEP_PM_OPS in the dev_pm_ops data structure. My
> reading of it is that it's not supported unless I add RUNTIME_PM_OPS? I'm
> probably missing some PM subsystem internals understanding though :/
>
> c.f. https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov5675.c#L1244
>
> I have a doubt now we're still talking about this patch and not Jacopo's? At
> least I'm not sure to fully get what's being discussed here.
>

Maybe Sakari just meant the driver is already instrumented to use the RPM
framework instead of relying on s_power() as some older driver doe,
and you just need to define the corresponding runtime_resume/suspend
operation ?

> > >
> > > Be aware my understanding of runtime_pm is limited, better check with
> > > Sakari too (I'll ask him to have a look).
> > >
> > > >   	mutex_unlock(&ov5675->mutex);
> > > >
> > > >   	return 0;
> > > > @@ -965,6 +1026,8 @@ static int __maybe_unused ov5675_resume(struct device *dev)
> > > >   	int ret;
> > > >
> > > >   	mutex_lock(&ov5675->mutex);
> > > > +
> > > > +	__ov5675_power_on(ov5675);
> > > >   	if (ov5675->streaming) {
> > > >   		ret = ov5675_start_streaming(ov5675);
> > > >   		if (ret) {
> > > > @@ -1106,32 +1169,60 @@ static const struct v4l2_subdev_internal_ops ov5675_internal_ops = {
> > > >   	.open = ov5675_open,
> > > >   };
> > > >
> > > > -static int ov5675_check_hwcfg(struct device *dev)
> > > > +static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
> > > >   {
> > > >   	struct fwnode_handle *ep;
> > > >   	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > >   	struct v4l2_fwnode_endpoint bus_cfg = {
> > > >   		.bus_type = V4L2_MBUS_CSI2_DPHY
> > > >   	};
> > > > -	u32 mclk;
> > > > +	u32 xvclk_rate;
> > > >   	int ret;
> > > >   	unsigned int i, j;
> > > >
> > > >   	if (!fwnode)
> > > >   		return -ENXIO;
> > > >
> > > > -	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
> > > > +	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &xvclk_rate);
> > >
> > > Isn't "clock-frequency" a leftover from ACPI ? It shouldn't be in the OF
> > > bindings either (you have it in 1/3).
> > >
> > > You can use the common clock framework API as you do below for OF and
> > > parse "clock-frequency" only for ACPI, as far as I can tell.
> >
> > Older bindings had clock-frequency on DT, too, but newer ones rely on the
> > frequency being set using assigned-clock- stuff.
> >
> > <URL:https://urldefense.proofpoint.com/v2/url?u=https-3A__hverkuil.home.xs4all.nl_spec_driver-2Dapi_camera-2Dsensor.html-23handling-2Dclocks&d=DwIBAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=d4bhfjobjD_6CMiuzFRtZy27p0ytvQuScDxLXtsaHnzywAfKYeap61kXxLuejvfT&s=TYhByXuRxctr7fGq94xBetcqW2gfnfZpGK3KyCZnCNA&e= >
> >
> > But as discussed earlier, it's not possible to technically add these as
> > required properties albeit it's almost certainly a bug if they're not
> > present in dts.
> >
>
> I assume this can be "enforced" via dt-bindings checks? So, what's the
> decision here? Do I go for the clock framework version and lose the
> enforcing or do I keep using this one clock-frequency property for both ACPI
> and DT?
>

My understanding is that "clock-frequency" is
an ACPI leftover that has been brought into some DT bindings as an
historical mistake. OF can work well with the common clock framework,
there's no need to introduce a property for the same purpose.

See
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx258.c#L1262

When it comes to "enforcing" maybe Sakari refers to
https://patchwork.linuxtv.org/project/linux-media/patch/20220314162714.153970-2-jacopo@jmondi.org/#136002

where enforcing of assigned-clock-.. properties presence was
discussed.


> > See e.g.
> >
>
> Missing link maybe?
>
> > >
> > > >   	if (ret) {
> > > >   		dev_err(dev, "can't get clock frequency");
> > > >   		return ret;
> > > >   	}
> > > >
> > > > -	if (mclk != OV5675_MCLK) {
> > > > -		dev_err(dev, "external clock %d is not supported", mclk);
> > > > +	if (!is_acpi_node(fwnode)) {
> > > > +		ov5675->xvclk = devm_clk_get(dev, "xvclk");
> > > > +		if (IS_ERR(ov5675->xvclk)) {
> > > > +			ret = PTR_ERR(ov5675->xvclk);
> > > > +			dev_err(dev, "failed to get xvclk: %d\n", ret);
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		clk_set_rate(ov5675->xvclk, xvclk_rate);
> > > > +		xvclk_rate = clk_get_rate(ov5675->xvclk);
> > >
> > > > +	}
> > > > +
> > > > +	if (xvclk_rate != OV5675_XVCLK_19_2) {
> > > > +		dev_err(dev, "external clock rate %u is unsupported", xvclk_rate);
> >
> > This would be nicer wrapped.
> >
>
> I do not get your suggestion, can you rephrase please?
>
> I want the rate to be checked both for ACPI and DT.
>

Is the line over 80-cols maybe ? Is this what 'wrapped' was meant to
indicate ?

> > > >   		return -EINVAL;
> > > >   	}
> > > >
> > > > +	ov5675->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > > > +						     GPIOD_OUT_HIGH);
> > > > +	if (IS_ERR(ov5675->reset_gpio)) {
> > > > +		ret = PTR_ERR(ov5675->reset_gpio);
> > > > +		dev_err(dev, "failed to get reset-gpios: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < OV5675_NUM_SUPPLIES; i++)
> > > > +		ov5675->supplies[i].supply = ov5675_supply_names[i];
> > > > +
> > > > +	ret = devm_regulator_bulk_get(dev, OV5675_NUM_SUPPLIES,
> > > > +				      ov5675->supplies);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > >   	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
> > > >   	if (!ep)
> > > >   		return -ENXIO;
> > > > @@ -1186,6 +1277,8 @@ static int ov5675_remove(struct i2c_client *client)
> > > >   	pm_runtime_disable(&client->dev);
> > > >   	mutex_destroy(&ov5675->mutex);
> > > >
> > > > +	__ov5675_power_off(ov5675);
> > > > +
> > > >   	return 0;
> > > >   }
> > > >
> > > > @@ -1195,25 +1288,31 @@ static int ov5675_probe(struct i2c_client *client)
> > > >   	bool full_power;
> > > >   	int ret;
> > > >
> > > > -	ret = ov5675_check_hwcfg(&client->dev);
> > > > +	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
> > > > +	if (!ov5675)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ret = ov5675_get_hwcfg(ov5675, &client->dev);
> > > >   	if (ret) {
> > > > -		dev_err(&client->dev, "failed to check HW configuration: %d",
> > > > +		dev_err(&client->dev, "failed to get HW configuration: %d",
> > > >   			ret);
> > > >   		return ret;
> > > >   	}
> > > >
> > > > -	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
> > > > -	if (!ov5675)
> > > > -		return -ENOMEM;
> > > > -
> > > >   	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
> > > >
> > > > +	ret = __ov5675_power_on(ov5675);
> > > > +	if (ret) {
> > > > +		dev_err(&client->dev, "failed to power on: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > >   	full_power = acpi_dev_state_d0(&client->dev);
> > > >   	if (full_power) {
> > > >   		ret = ov5675_identify_module(ov5675);
> > > >   		if (ret) {
> > > >   			dev_err(&client->dev, "failed to find sensor: %d", ret);
> > > > -			return ret;
> > > > +			goto probe_power_off;
> > > >   		}
> > > >   	}
> > >
> > > Maybe you can also update the comment at the end of the probe function
> > > to remove references to ACPI. As you wish.
> > >
> > > 	/*
> > > 	 * Device is already turned on by i2c-core with ACPI domain PM.
> > > 	 * Enable runtime PM and turn off the device.
> > > 	 */
> >
> > No need for such a comment --- nothing specific to this driver there.
> >
>
> The comment is already there in the driver.
>
> The issue being that if it's probed from ACPI, there's nothing to be done
> power wise (currently at least, in the current state of the driver). If it's
> probed via DT, I need to power the device manually.
>

Exactly, that's why the comment is either incomplete (and I suggested
to change it). Or, as Sakari pointed out, it's rather useless as this
is what happes in all drivers, so no need to point it out here.

Thanks
  j

> Cheers,
> Quentin
