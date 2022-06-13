Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F200549A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiFMRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242422AbiFMRiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:38:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6A147806;
        Mon, 13 Jun 2022 06:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D025CE12AA;
        Mon, 13 Jun 2022 13:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A976FC3411B;
        Mon, 13 Jun 2022 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655125463;
        bh=tmW0UzmHilil9D6WRtZVvd2rIwKzTWLw3Xx3woeOXfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lst8DXIdPr227QBx0vTZihAbIrVqyBL3NazUG+oAGYXZwApYXtW/A2YMtMh2hs4pw
         7KFctvuzd2Up7KRd7/WMHg5QU1m0D96g+Q9VOcD8vskYiRvSjCoNI7Bt4xFmUGesXf
         XWUUO9Jdl9NrQ3n5yU8yfAMrpgr1OtUNKSu6HdTohZR63XZRC+8+WtLtiXq3zc4WB4
         DWwB5crbHOeEJjMuaoB2S7A0nM+KbcYVNFi3TG0Sb5ebh7Z5Ib3QN2xhqfeQQp22FX
         ObB4rxnrMH0R2VsmSPU34+yMkYHFMbu38x5enMDNe3pnmaEWMxs+oc6OJzvzkZsT05
         QHU98r2GypYDA==
Date:   Mon, 13 Jun 2022 14:04:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome NEANNE <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, will@kernel.org, lee.jones@linaro.org,
        khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/5] regulator: drivers: Add TI TPS65219 PMIC
 regulators support
Message-ID: <Yqc10QuvjQ1e/ivw@sirena.org.uk>
References: <20220613090604.9975-1-jneanne@baylibre.com>
 <20220613090604.9975-4-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IopxgiwGnKTD/lJ2"
Content-Disposition: inline
In-Reply-To: <20220613090604.9975-4-jneanne@baylibre.com>
X-Cookie: innovate, v.:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IopxgiwGnKTD/lJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 11:06:02AM +0200, Jerome NEANNE wrote:

> +static int tps65219_pmic_enable(struct regulator_dev *dev)
> +{
> +	struct tps65219 *tps = rdev_get_drvdata(dev);
> +	int rid = rdev_get_id(dev);
> +	int ret;
> +
> +
> +

Lots of random blank space here.

> +	if (rid < TPS65219_BUCK_1 || rid > TPS65219_LDO_4)
> +		return -EINVAL;
> +

If a regulator doesn't support an operation it shouldn't be providing
it, no need to check here.

> +	ret = tps65219_set_bits(tps, dev->desc->enable_reg,
> +				 dev->desc->enable_mask, dev->desc->enable_mask);

If you provide the regmap to the child devices then this can use the
standard regmap helpers for most of the operations, meaning most of
the operations in the driver can be removed.

> +/* generic regulator_set_bypass_regmap does not match requirements use custom instead */

In what way?  Please also try to keep within 80 columns normally.

> +	if (dev->desc->ops->is_enabled) {
> +		dev_err(tps->dev, "%s LDO%d is enabled, should be shut down to set bypass ",
> +					 __func__, rid);
> +		return -EBUSY;
> +	}

This is testing if there is an enable operation, not if the regulator is
enabled.

> +	if (enable) {
> +		dev_dbg(tps->dev, "%s, LDO%d already in bypass mode", __func__, rid);
> +		return ret;
> +	}

This is not a problem, just silently succeed.

> +	/* Allocate memory for strobes */
> +	tps->strobes = devm_kcalloc(&pdev->dev,
> +				    TPS65219_NUM_REGULATOR, sizeof(u8),
> +				    GFP_KERNEL);
> +	if (!tps->strobes)
> +		return -ENOMEM;

These are never referenced anywhere else in the driver, no need to
allocate them.

> +		ret = regmap_read(tps->regmap, regulators[i].bypass_reg, &val);
> +		if (ret) {
> +			dev_err(tps->dev, "dev_err failed to map register for %s regulator\n",
> +				pdev->name);
> +			return ret;
> +		}

I'm not clear what this check is intended to do, it at least needs to be
better documented.

--IopxgiwGnKTD/lJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKnNdAACgkQJNaLcl1U
h9A3Rgf/XIyREPO3yKKsbHdyoXb7PZDaVPf9DpPKX/8m3fwGRc3Ba/JNM7lPLYzN
vJOIYiyr/rFe/LAZckSMBhJo1d316Bmy0HlAMOHyzMWEjvD7iTLuQ/0G+BjNoK6J
v1yEvj+bTtQ26oN3/4liVPkJNA4QBJsRR63eb9RUyOw6QESZyn2rUT23VUY2COTY
SR4555QxcCsz9RnQiREp+reE6ImqQSkkbsaIzC5+9ch7olWmopmYOdJE1C/lpk4G
z4Cz/BPfEZmxwi5RPS3gAlAjETKuBo4EyR4MlKTKsLLB8/1nvvwZNr1Pb4idKi5v
tyQHzosfLSFm/jUGZjaTH0XjlNPUFA==
=GrWr
-----END PGP SIGNATURE-----

--IopxgiwGnKTD/lJ2--
