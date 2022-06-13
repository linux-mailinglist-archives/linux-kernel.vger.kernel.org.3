Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECBE549A25
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbiFMRf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbiFMRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B5663D6;
        Mon, 13 Jun 2022 05:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6379B80FCD;
        Mon, 13 Jun 2022 12:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2BDC3411C;
        Mon, 13 Jun 2022 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655125051;
        bh=KDhPN0EJSPqVJzBkGZYZ/spitiiOUeilcgOvShhrFB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMJ5e6gBSI7FEY6Te1788d11iJlulxXuHGGuL9TFl9R5J/Fi1mTnAbFFEwc9sVdqG
         /gfYi9COCxRzBF4bqk4wOlkpnMT5E1gkLYpSZBE3RIQHpZjkXxkdhtRBvdTPICAKEp
         j+onTRZedv5xDqdbcECM32Wc5IWYXJeN4XSW9cHtTj9wm7SaZsazli+NlPcyjRsFzE
         /rsjvMHBqJuoUyXL/GMHOj9800A6o4X66xFIorh/uzTDrf3UxlJlDdXeHyEfErYSVs
         heThHqdyy3FhrH/ZHx+EWxGDhEFgoXgPXComQNGT9GReuajxWkZ41ikVfXD2hEXEBM
         b3dsu2DO2eNoA==
Date:   Mon, 13 Jun 2022 13:57:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome NEANNE <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, will@kernel.org, lee.jones@linaro.org,
        khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 2/5] mfd: drivers: Add TI TPS65219 PMIC support
Message-ID: <Yqc0NQSLO2j2IHI3@sirena.org.uk>
References: <20220613090604.9975-1-jneanne@baylibre.com>
 <20220613090604.9975-3-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U2vy66mGJShhsnPN"
Content-Disposition: inline
In-Reply-To: <20220613090604.9975-3-jneanne@baylibre.com>
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


--U2vy66mGJShhsnPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 13, 2022 at 11:06:01AM +0200, Jerome NEANNE wrote:

> +/**
> + * tps65219_reg_read: Read a single tps65219 register.
> + *
> + * @tps: Device to read from.
> + * @reg: Register to read.
> + * @val: Contians the value
> + */
> +int tps65219_reg_read(struct tps65219 *tps, unsigned int reg,
> +			unsigned int *val)
> +{
> +	return regmap_read(tps->regmap, reg, val);
> +}
> +EXPORT_SYMBOL_GPL(tps65219_reg_read);

It is better practice to just expose the regmap and let the function
drivers use it, that means the function drivers can just use standard
helper functions.

> +static int tps65219_update_bits(struct tps65219 *tps, unsigned int reg,
> +		unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +	unsigned int data;
> +
> +	ret = regmap_read(tps->regmap, reg, &data);
> +	if (ret) {
> +		dev_err(tps->dev, "Read from reg 0x%x failed\n", reg);
> +		return ret;
> +	}
> +
> +	data &= ~mask;
> +	data |= val & mask;
> +
> +	mutex_lock(&tps->tps_lock);
> +	ret = tps65219_reg_write(tps, reg, data);
> +	if (ret)
> +		dev_err(tps->dev, "Write for reg 0x%x failed\n", reg);
> +	mutex_unlock(&tps->tps_lock);

It's not clear what this locking is intended to protect.  It looks like
this should just be using regmap_update_bits().

> +static const struct regmap_range tps65219_yes_ranges[] = {
> +	regmap_reg_range(TPS65219_REG_INT_SOURCE, TPS65219_REG_POWER_UP_STATUS),
> +};
> +
> +static const struct regmap_access_table tps65219_volatile_table = {
> +	.yes_ranges = tps65219_yes_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(tps65219_yes_ranges),
> +};

tps65219_yes_ranges probably needs a clearer name.

--U2vy66mGJShhsnPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKnNDQACgkQJNaLcl1U
h9Bqegf/anATfCIwadSoj3K2+Sm8a/mvOi3cqdrwn+9BBtO5fPW8QB0iEMMVyX9W
5+AhfxMMfQ9icgu5/ciWCWFuhQ5s0jI5xCbkCdKI9z9wXrIahFJLd0p7UN8Qszen
pGvT/TIF3PTfcQoLt7YNDxLvwNchi9A26stCHUpvZXDInzbeqSvA6JZraL8BE2bw
1uoRmHRfb28iPl8J6v9Jbhb1GOrjpzZKosWB1Awlet0COCWYSGdnRWepEGt0RCfi
JB9PmDmt9Hzx+JaDTu1+2pMiLkzCShs3Sd/oOWAiSB9PKHI73tVll1G1tJ26lWFv
aPxmboun/NkcNpq7jgX0z3UN/AKG7w==
=Q4Fu
-----END PGP SIGNATURE-----

--U2vy66mGJShhsnPN--
