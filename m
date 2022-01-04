Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0794F484327
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiADOQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiADOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:16:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A57C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:16:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0835D6146C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBF0C36AED;
        Tue,  4 Jan 2022 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641305798;
        bh=UlDD+lGj5Cmhrg+RkbyzmbZ1P9SsNurPMWzCZUqMB7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeTy0Lgu/vGchW0QKXnwPlG8yFuHucitOyLI0gFFrtmW5dyMPtr8N3umyS7gwEISn
         0CnePwX/tnmvsw9qn08Dd3UQBFcsHxl+HTE8d8zE1sCFnp/lVqjqI81HPQuNj5vwET
         oHrVWyEG1ZpwCD1jOUh+Frd5oRx+HaFEEjlZcmgZIZjgjjxvdf0xfqra7N58MimxMH
         KeweQnVAeJV99bv00VwEPE3E1HOFHi83d25Nu1Fe/uUwhFs5TbHIv4ACBCjJbn1Av2
         XEgKkC+ApIB6ObeV36No19nkwtD47/OL/ELw4MV5SbskVzuPfB4g2OY3UFlWwytt9g
         msJquGhKlkiIw==
Date:   Tue, 4 Jan 2022 14:16:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] regulator: Add MAX20086-MAX20089 driver
Message-ID: <YdRWwWmoQGQuUyLz@sirena.org.uk>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pj4qz6iEykajA1dF"
Content-Disposition: inline
In-Reply-To: <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pj4qz6iEykajA1dF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 02, 2022 at 11:11:24PM +0200, Laurent Pinchart wrote:

> ---
> Changes since v0:
>=20
> - Remove unused regulator_config members
> - Drop unused header

This is a *very* long list relative to something that was never posted
:/

> @@ -1415,4 +1424,3 @@ config REGULATOR_QCOM_LABIBB
>  	  for LCD display panel.
> =20
>  endif
> -

Unrelated whitespace change.

> --- /dev/null
> +++ b/drivers/regulator/max20086-regulator.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * max20086-regulator.c - MAX20086-MAX20089 camera power protector driver
> + *

Please keep the entire comment a C++ one so things look more
intentional.

> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>

It is worrying that a regulator driver should need the interfaces for
machines...  the driver doesn't look like it actually does though.

> +static int max20086_parse_regulators_dt(struct max20086 *chip)
> +{
> +	struct of_regulator_match matches[MAX20086_MAX_REGULATORS] =3D { };
> +	struct device_node *node;
> +	unsigned int i;
> +	unsigned int n;
> +	int num;

You should be able to remove the stuff about looking for the regulators
node and just set of_match and regulators_node in the descs.

> +	num =3D of_regulator_match(chip->dev, node, matches,
> +				 chip->info->num_outputs);
> +	of_node_put(node);
> +	if (num <=3D 0) {
> +		dev_err(chip->dev, "Failed to match regulators\n");
> +		return -EINVAL;
> +	}
> +
> +	chip->num_outputs =3D num;

The number of regulators the device supports should be known from the
compatible, I'd expect a data table for this.  It should be possible to
read the state of regulators not described in the DT.

> +static const struct regmap_config max20086_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.writeable_reg =3D max20086_gen_is_writeable_reg,
> +	.max_register =3D 0x9,
> +	.cache_type =3D REGCACHE_NONE,
> +};

No readback support?

> +	/* Turn off all outputs. */
> +	ret =3D regmap_update_bits(chip->regmap, MAX20086_REG_CONFIG,
> +				 MAX20086_EN_MASK, 0);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to disable outputs: %d\n", ret);
> +		return ret;
> +	}

The driver should not do not do this - the driver should only configure
the hardware if told to by the core which in turn will only do this if
there's explicit permission to do so in the machine constraints.  We
don't know what some system integrator might have thought to do with
the device.

> +	/* Get the chip out of low-power shutdown state. */
> +	chip->gpio_en =3D devm_gpiod_get(chip->dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->gpio_en)) {
> +		ret =3D PTR_ERR(chip->gpio_en);
> +		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);
> +		return ret;
> +	}

This one is more OK - it's changing the state of the outputs that's an
issue.  I guess this might cause the outputs to come on though if the
GPIO was left off by the bootloader which is awkward.  If there's
nothing other than the outputs going on with the chip I would be tempted
to map this onto the per regulator enable GPIO that the core supports,
the core will then be able to manage the low power state at runtime.
That's *probably* the least bad option we have with current interfaces.

It's a real shame we can't easily get the GPIO state at startup for
bootstrapping :/ =20

--pj4qz6iEykajA1dF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUVsEACgkQJNaLcl1U
h9DjSwf/RRqIkaF8C5VMn4PukjPBEUEO+0Og7p5PaGNCaZ6YWFJ/AyvB0psS+6tV
q5LL2HAHYcS9fncHpXNQ3R265/X5wn+mX3f7KFjLlvlY8qWx/cwa0MH/YFAa+/q2
uzpFPHcv92Tju+Ygj5wrbWHKlUU2tG7cElwbihpXfge2QwFlTSILo/F9zD8Pf8dd
4FYm2pJjFrylZXfFmF4N89o0Kbt9yij5bM+6dWd1UP+wdSERKuZa18XqDWdoY5F6
kCs+wa2yjtfGDUuyEOufEjClzU8pkbYV7ujyGt5paXj5eavqYVhB9/iDpY3+GzSb
RiZvI/dCQBkBYvNKhu9of2r08EdCQQ==
=LXcg
-----END PGP SIGNATURE-----

--pj4qz6iEykajA1dF--
