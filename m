Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F59B57A0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiGSOMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbiGSOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03044820FF;
        Tue, 19 Jul 2022 06:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C101EB81B84;
        Tue, 19 Jul 2022 13:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2780C341C6;
        Tue, 19 Jul 2022 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658237585;
        bh=KmR8tfAQ9eE542jYNhTNtY7nfxX4kwpdPzlaxf3sLt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=seW9K4at5nVQ/Q8nukFkt9W9kRQtMR/DXkKUUQYWp2yWcjv2awfL8XaVkAUhVnQUK
         bLb1vtVymoYpiAZPS56w+bnW3F8F5suJ+SpSk+Xc64YUFldgCcgsTLB9XPx3KkMZj1
         WnO75Q16lSW3h2KxomnAiEznijzPykQ8dBt+kMuBeGHjwigJKoOA1Zx8d3EbgDFmfU
         CQ/66+TBMTNxDurp+nT0roRa8aa7PRg2UCTJN9ZSL4mtNc2AaZv2zc9tqsbivTnCls
         tzkE+1jw84sTk/nR5A6fFbq0iazB7yUtYnebQTNqOhXp7O0DMttpYv0c5Ej3d8bkT7
         6/M76a8ifxdwQ==
Date:   Tue, 19 Jul 2022 14:32:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/14] regulator: drivers: Add TI TPS65219 PMIC
 regulators support
Message-ID: <YtayikFdidxXXubS@sirena.org.uk>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-9-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zBpfrOEWtgLbiYl8"
Content-Disposition: inline
In-Reply-To: <20220719091742.3221-9-jneanne@baylibre.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zBpfrOEWtgLbiYl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 11:17:36AM +0200, Jerome Neanne wrote:

> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tps65219-regulator.c
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +static int tps65219_pmic_set_voltage_sel(struct regulator_dev *dev,
> +					 unsigned int selector)
> +{
> +	int ret;
> +	struct tps65219 *tps =3D rdev_get_drvdata(dev);
> +
> +	/* Set the voltage based on vsel value */
> +	ret =3D regmap_update_bits(tps->regmap, dev->desc->vsel_reg,
> +				 dev->desc->vsel_mask, selector);
> +	if (ret) {
> +		dev_dbg(tps->dev, "%s failed for regulator %s: %d ",
> +			__func__, dev->desc->name, ret);
> +	}
> +	return ret;
> +}

This should just be able to use the standard regmap helper, as should
the enable and disable operations?

> +static int tps65219_set_mode(struct regulator_dev *dev, unsigned int mod=
e)
> +{
> +	struct tps65219 *tps =3D rdev_get_drvdata(dev);
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_NORMAL:
> +		return regmap_set_bits(tps->regmap, TPS65219_REG_STBY_1_CONFIG,
> +				       dev->desc->enable_mask);
> +
> +	case REGULATOR_MODE_STANDBY:
> +		return regmap_clear_bits(tps->regmap,
> +					 TPS65219_REG_STBY_1_CONFIG,
> +					 dev->desc->enable_mask);
> +	}
> +
> +	return -EINVAL;

It'd be a little clearer to have that -EINVAL in a default statement.

> +static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
> +{
> +	struct tps65219_regulator_irq_data *irq_data =3D data;
> +
> +	if (irq_data->type->event_name[0] =3D=3D '\0') {
> +		/* This is the timeout interrupt */
> +		dev_err(irq_data->dev, "System was put in shutdown during an active or=
 standby transition.\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_err(irq_data->dev, "Registered %s for %s\n",
> +		irq_data->type->event_name, irq_data->type->regulator_name);

This should be reporting the events through the notification API, see
regulator_notifier_call_chain().  That will require a bit of refactoring
of the way the driver is registering interrupts unfortunately, at the
minute it doesn't have data joining them up with the=20

I'd also reword that log message to be something more like "Error %s
reported for %s" - at the minute it looks more like a probe message.

Otherwise this looks good.

--zBpfrOEWtgLbiYl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWsokACgkQJNaLcl1U
h9AF+gf/QEBDuiPJXAhqxJOMjcTKQGe2EGbChi3FnnmfjZcl0uqL9RsiSnchsJcQ
pleLjPyp1GlnRDwl/O0Vg2weZJRTNRlcKnfh9HhER9C0VKW91zIvbyNX78uCpPPw
zXBAylmh26YknpAjtUz9gh7uO0x1TNnZX2TvI4+M5rd2ioDqrvyIhTWWKy5QCFt3
3oyzHQfCdlwWqS6lvIz+hl0dfY5R0/qJA408EIQ+VQrGWb0TIcWK5VrdshH4p1oy
V8y91syEOGvOIXP1UnJBKe3EaAimcNmGtKLXPf1MVhDvC7dcTW/20sBpPeBzB0w4
/RnTiTspHVXIM1D3u4KcaD//S/WZ1A==
=LDKf
-----END PGP SIGNATURE-----

--zBpfrOEWtgLbiYl8--
