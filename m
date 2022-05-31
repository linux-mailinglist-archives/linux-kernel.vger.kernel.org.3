Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049C539152
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiEaNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4085EE9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 604C3611C5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60646C385A9;
        Tue, 31 May 2022 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654002243;
        bh=0Ux74kZP49E3YbCl20ju4zIzBeNZ/Ros6AInPhoDENQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZW7s/PF4yAgeLtWttmOgQCIS1YYb9dBzCiXL5APIa9J/GgRgR4AeLk9GAyZZWvnj
         9kkYR1Ke43JwJf/XQ/PhyWemn9c/+Mkc6IMM1EZXnbigTQNTZleVX4+3sOv2J2nNJd
         0+Vp0BYAS7x0ZbqXLnKfOpSNVNjvGuqzgE72mztTyO+d1YXP5BchrTAdfN86kjz8ix
         I1rIR7U5bGBPclNfHRdi4yX6Mhs109UilJGAJpn9VVhfcFbJk2BbzeNkwfNXENmOEn
         fV1WMeAVtsbyxxLHruosw9cvhTxbUFutvzbpspEE1PQU6Uz8sU+gj4Ai7K52Y0fli8
         Qv1GxAodBiWKw==
Date:   Tue, 31 May 2022 15:04:01 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/7] regulator: add mt6357 regulator
Message-ID: <YpYSQXWU1NlM4JU6@sirena.org.uk>
References: <20220531124959.202787-1-fparent@baylibre.com>
 <20220531124959.202787-7-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kIfQMFAkV/8CDKUj"
Content-Disposition: inline
In-Reply-To: <20220531124959.202787-7-fparent@baylibre.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kIfQMFAkV/8CDKUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2022 at 02:49:58PM +0200, Fabien Parent wrote:

> @@ -0,0 +1,485 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Copyright (c) 2022 BayLibre, SAS.
> + * Author: Chen Zhong <chen.zhong@mediatek.com>
> + * Author: Fabien Parent <fparent@baylibre.com>
> + *
> + * Based on mt6397-regulator.c
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static int mt6357_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	int idx, ret;
> +	const u32 *pvol;
> +	struct mt6357_regulator_info *info =3D rdev_get_drvdata(rdev);
> +
> +	pvol =3D info->index_table;
> +
> +	idx =3D pvol[selector];
> +	ret =3D regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
> +				 info->desc.vsel_mask,
> +				 idx << 8);
> +
> +	return ret;
> +}

I don't really understand what's going on with selectors here -
the general idea with selectors is that we just pass the value
that's written to the bitfield around and have mapping functions
which convert to/from voltages.  Here we're mapping the selectors
using this index_table thing which seems like an extra layer of
mapping.  What's the story there? =20

I don't see why this can't just use the functions in helpers.c.
It looks like you can use _list_voltage_table() -EINVALs in there
for invalid selectors and _map_voltage_iterate().  Note that
n_voltages is effectively a maximum selector.

> +static int mt6357_get_buck_voltage_sel(struct regulator_dev *rdev)
> +{
> +	int ret, regval;
> +	struct mt6357_regulator_info *info =3D rdev_get_drvdata(rdev);
> +
> +	ret =3D regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
> +	if (ret !=3D 0) {
> +		dev_err(&rdev->dev,
> +			"Failed to get mt6357 Buck %s vsel reg: %d\n",
> +			info->desc.name, ret);
> +		return ret;
> +	}
> +
> +	ret =3D (regval & info->da_vsel_mask) >> info->da_vsel_shift;
> +
> +	return ret;
> +}

This looks like it should just be able to use
regulator_get_voltage_sel_regmap()?

Otherwise this looks good.

--kIfQMFAkV/8CDKUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKWEkAACgkQJNaLcl1U
h9BZdwf/cfDz6z011Xt84Qvyn1gUqxQbUzfzZ9sYn1UGCW8nNjSG+gPxhFW4G96z
Rsf3+4t6lLUho+QjpQRkEOZE9oIFJ9Q6XTW5pGVLTyF0y9PZfPnZPlx8wN+A0az6
FTAlTeMOTRavOWXqELiHJOlgsUWRQhhF/goE3yV1fPD0wYyAwLVzsEr6VplUQTjc
C+liXmRbQ60diYmWpVat2WMXIpAG4b2ydY4Y3p16X9HkuXAKHCtBpBO4auF+JZ1h
OEs8vssSyyOL/Wiv2xLd8MDFxZ56PJtFK2DO0T4/wi51fyr5EsqSq3Ef8AvQUjqf
SWmRg28+1AkZVrxj+z+pXqKo0jH8Cg==
=zuw/
-----END PGP SIGNATURE-----

--kIfQMFAkV/8CDKUj--
