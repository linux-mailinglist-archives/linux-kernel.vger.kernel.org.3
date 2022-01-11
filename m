Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8EC48B2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiAKRNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiAKRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:13:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E0C06173F;
        Tue, 11 Jan 2022 09:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74FE1B81C04;
        Tue, 11 Jan 2022 17:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A42C36AE3;
        Tue, 11 Jan 2022 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641921197;
        bh=Exdbp6vReZQu6x5GDKBL6zHl5yW1aC7Yy4NLbjZgQIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meHOZukTp2g9QpMR+nbJwfjqn4tLy99rPRf2Z10M6W61ClDc8DuuSSMOanMCIFO7H
         kpnLqzeVJ991K97Bnlyt+SlKXF/0zZKDmAhJhLeDxnpNsgyP4O0xRvyR2zm+m48xqO
         HeRLUQEjc+hSD4yMQI+9QwdI9qrWjebL/0d1rzuLTE8drglactXPak4axPKmPDOAaX
         Nwqf/tkUZZhDL1y338TE22ECJQl5ERFUMRHfArt2nIWt78g/aBFFBZr2sp5IjTaUaJ
         0EM2wrs774FG9WhkgoTzx//MtOGYIUv05y3bxYyOdMlJxEHBi7pCeB3aj3MSn94RQP
         tIHlrnlJZ1imA==
Date:   Tue, 11 Jan 2022 17:13:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: add support for TAS5805M digital amplifier
Message-ID: <Yd26p8rF3arufd2R@sirena.org.uk>
References: <61dccc59.1c69fb81.e1d98.02e3@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ol8CU9/+v5SCO8rz"
Content-Disposition: inline
In-Reply-To: <61dccc59.1c69fb81.e1d98.02e3@mx.google.com>
X-Cookie: Many a family tree needs trimming.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ol8CU9/+v5SCO8rz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 12:53:11PM +1300, Daniel Beer wrote:

> +++ b/sound/soc/codecs/tas5805m.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the TAS5805M Audio Amplifier
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +static void tas5805m_refresh_unlocked(struct snd_soc_component *component)
> +{
> +	struct tas5805m_priv *tas5805m =
> +		snd_soc_component_get_drvdata(component);
> +	uint8_t v[4];
> +	unsigned int i;
> +	uint32_t x;

> +	snd_soc_component_write(component, REG_PAGE, 0x00);
> +	snd_soc_component_write(component, REG_BOOK, 0x8c);
> +	snd_soc_component_write(component, REG_PAGE, 0x2a);

This isn't using the regmap paging support and I'm not seeing anything
that resets the page here.

> +	for (i = 0; i < 4; i++)
> +		snd_soc_component_write(component, 0x24 + i, v[i]);
> +	for (i = 0; i < 4; i++)
> +		snd_soc_component_write(component, 0x28 + i, v[i]);

This looks like it's potentially a stereo control but we're not allowing
the two channels to be configured separately?

> +	/* Volume controls */
> +	snd_soc_component_write(component, REG_DEVICE_CTRL_2,
> +		tas5805m->is_muted ?  0x0b : 0x03);

This comment doesn't seem terribly descriptive and this is very much a
magic number.

> +static int tas5805m_vol_get(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_kcontrol_component(kcontrol);
> +	struct tas5805m_priv *tas5805m =
> +		snd_soc_component_get_drvdata(component);
> +
> +	mutex_lock(&tas5805m->lock);
> +	ucontrol->value.integer.value[0] = tas5805m->vol;
> +	mutex_unlock(&tas5805m->lock);

What is this lock intended to protect?  We take the lock, do a read of a
single value and then unlock which doesn't seem like it's adding a huge
amount.

> +
> +	mutex_lock(&tas5805m->lock);
> +	tas5805m->vol = clamp((int)ucontrol->value.integer.value[0],
> +			      TAS5805M_VOLUME_MIN, TAS5805M_VOLUME_MAX);

It would be better to reject out of bounds values with an error.

> +static void send_cfg(struct snd_soc_component *component,
> +		     const uint8_t *s, unsigned int len)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i + 1 < len; i += 2)
> +		snd_soc_component_write(component, s[i], s[i + 1]);

This looks like the driver might be happier using regmap directly, this
looks like an open coded _multi_reg_write().

> +/* The TAS5805M can't be configured or brought out of power-down without
> + * an I2S clock. In power-down, registers are reset.
> + *
> + * We rely on DAPM not powering up the DAC widget until the source for
> + * it is ready, which we think implies that the I2S clock is present and
> + * stable.
> + */

That's not true, we run DAPM in prepare() prior to calling trigger() and
controllers might not start clocking the bus until trigger() has been
called.  There was some other device with similar issues which was
scheduling things from the trigger() callback IIRC, if you search around
in the CODEC directory you should be able to find something.

> +	dev_set_drvdata(dev, tas5805m);
> +	tas5805m->regmap = regmap;
> +	tas5805m->gpio_pdn_n = of_get_named_gpio(dev->of_node, "pdn-gpio", 0);
> +	if (!gpio_is_valid(tas5805m->gpio_pdn_n)) {
> +		dev_err(dev, "power-down GPIO not specified\n");
> +		return -EINVAL;
> +	}

Use the gpiod APIs, you shouldn't need to do anything specific to OF
here.  Also GPIO properties need to have names ending -gpios even if
they're for a single GPIO.

> +	ret = devm_snd_soc_register_component(dev, &soc_codec_dev_tas5805m,
> +					      &tas5805m_dai, 1);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to register codec: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(tas5805m->pvdd);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable pvdd: %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(100000, 150000);
> +	gpio_set_value(tas5805m->gpio_pdn_n, 1);
> +	usleep_range(10000, 15000);

This seems broken - the card might be instantiated and userspace start
using it as soon as the component is registered but we don't power on
the device until after registering it and there's no runtime power up or
down.  For power management like this you need to complete the initial
power on prior to registering the component.

> +static int tas5805m_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct tas5805m_priv *tas5805m = dev_get_drvdata(&i2c->dev);
> +
> +	gpio_set_value(tas5805m->gpio_pdn_n, 0);
> +	usleep_range(10000, 15000);
> +	regulator_disable(tas5805m->pvdd);

This will power down the device prior to unregistering the component so
userspace could still be running.  You need to not use devm_ for
component registration and manually unregister here to avoid that issue
(or register a custom devm action).

--Ol8CU9/+v5SCO8rz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHduqcACgkQJNaLcl1U
h9D7agf7Beb8sWb71Pk9t1L/CgtE5AESQ5GhIqEnt6rwtpD4E8dS5g/Plm/1Iq3d
IsaIFL74BEPRZcVfyku0GUDsX4Vq4Z81Z8R7cO4EkJMX2AlrZIKeOeS8pmMfc8d2
EnFLcQsvin7DXi6Rs8e+vXOBoKIqXmPYQgc81GiQcYa2GpAWpjwVV1Kph0/ewel7
bh8R/ZNaJoD6t/eSIMYoOpNaar6aQ2m6WGtXoihYvVOJBfTi314GhWgbCetRqEwp
ILLgfAi39a4AuTDLj0G3Bi5ziC/RtJUGjw0BjQjZ4Kv8xRhbZYNI5xaxADofSkN+
2Jee3xhBNV2lfwVEM996fFxdHlP7DA==
=C3Gh
-----END PGP SIGNATURE-----

--Ol8CU9/+v5SCO8rz--
