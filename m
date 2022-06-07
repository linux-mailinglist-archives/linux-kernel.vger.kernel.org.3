Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D28541ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384264AbiFGWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378460AbiFGVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:23:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940B226CFB;
        Tue,  7 Jun 2022 12:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0E9BCE247C;
        Tue,  7 Jun 2022 19:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C34FC385A5;
        Tue,  7 Jun 2022 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654628433;
        bh=PETGTpshoDoTRoH9w/heaUnGsqX8NQyeufAgBDPT+dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuBUuLTlpKLrFOJkqHh9kPQ0JfJeWqd0WcizgQYJomwFKG9B/mo340eff68SsGWf4
         u5rhlB6BKhXhVBjN+rccBwo2qO7SHi+KTsBx3QaTokTup472ptXiBsZ5TOOWgyqnXP
         DaIVzhsTvmjipXXk7l4x/9ezYPItrCzvrh0mT4PsSa7pLcSRAuCUUZ9/JVbsZpqQEo
         USNVw2sU7sHjD53sXPDaUC2koJIWm9cA2cdI0bcBwo1O72rEspr0ANGPvUsPjK5Zrq
         Nnhj4Ww7jT9vCOXVegNe5YkO+lNfWH/hYB6P0yggJTeDAEQL069ZI1yQiGHZEE2fJA
         zArkaLa/809aw==
Date:   Tue, 7 Jun 2022 20:00:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: rt5120: Add PMIC regulator support
Message-ID: <Yp+gS6r5Kpi33Ags@sirena.org.uk>
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksAClhgkgYP1BOgI"
Content-Disposition: inline
In-Reply-To: <1654581161-12349-4-git-send-email-u0084500@gmail.com>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ksAClhgkgYP1BOgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2022 at 01:52:40PM +0800, cy_huang wrote:

This looks mostly good, a few things though:

> +static void rt5120_fillin_regulator_desc(struct regulator_desc *desc, int rid)
> +{
> +	static const char * const name[] = { "buck1", "buck2", "buck3", "buck4",
> +					     "ldo", "exten" };
> +	static const char * const sname[] = { "vin1", "vin2", "vin3", "vin4",
> +					      "vinldo", NULL };

It would be easier and clearer to just make this a static table like
other drivers do, there's no need to generate anything dynamically as
far as I can see.

> +static int rt5120_of_parse_cb(struct rt5120_priv *priv, int rid,
> +			      struct of_regulator_match *match)
> +{
> +	struct regulator_desc *desc = priv->rdesc + rid;
> +	struct regulator_init_data *init_data = match->init_data;
> +
> +	if (!init_data || rid == RT5120_REGULATOR_BUCK1)
> +		return 0;
> +
> +	if (init_data->constraints.min_uV != init_data->constraints.max_uV) {
> +		dev_err(priv->dev, "Variable voltage for fixed regulator\n");
> +		return -EINVAL;
> +	}
> +
> +	desc->fixed_uV = init_data->constraints.min_uV;
> +	init_data->constraints.apply_uV = 0;

Drivers should never override constraints passed in by machine drivers,
if there's validation needed let the core do it.  The same probably
applies to providing a voltage range for a fixed regulator though that's
not modifying everything so not such a problem.

> +static int rt5120_parse_regulator_dt_data(struct rt5120_priv *priv)
> +{
> +	struct device *dev = priv->dev->parent;
> +	struct device_node *reg_node;
> +	int i, ret;
> +
> +	for (i = 0; i < RT5120_MAX_REGULATOR; i++) {
> +		rt5120_fillin_regulator_desc(priv->rdesc + i, i);
> +
> +		rt5120_regu_match[i].desc = priv->rdesc + i;
> +	}

Like I said above just make the list of regulators static data and loop
through registering them.

> +
> +	reg_node = of_get_child_by_name(dev->of_node, "regulators");
> +	if (!reg_node) {
> +		dev_err(priv->dev, "Couldn't find 'regulators' node\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_regulator_match(priv->dev, reg_node, rt5120_regu_match,
> +				 ARRAY_SIZE(rt5120_regu_match));
> +
> +	of_node_put(reg_node);
> +
> +	if (ret < 0) {
> +		dev_err(priv->dev,
> +			"Error parsing regulator init data (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < RT5120_MAX_REGULATOR; i++) {
> +		ret = rt5120_of_parse_cb(priv, i, rt5120_regu_match + i);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed in [%d] of_passe_cb\n", i);
> +			return ret;
> +		}
> +	}

This is all open coding stuff that's in the core - just provde an
of_parse_cb() operation and let the core take care of calling it.

> +static int rt5120_device_property_init(struct rt5120_priv *priv)
> +{
> +	struct device *dev = priv->dev->parent;
> +	bool prot_enable;
> +	unsigned int prot_enable_val = 0;
> +
> +	/* Assign UV/OV HW protection behavior */
> +	prot_enable = device_property_read_bool(dev,
> +					"richtek,enable-undervolt-hiccup");
> +	if (prot_enable)
> +		prot_enable_val |= RT5120_UVHICCUP_MASK;

Use the DT APIs to parse DT - since ACPI has a very strong idea of how
power management works which is fundamentally incompatible with with the
DT model we should be writing code in a way that minimises the risk that
we'll end up trying to parse DT properties out of ACPI systems and
creating confusion as DT and ACPI software tries to run on the same
system.

--ksAClhgkgYP1BOgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfoEsACgkQJNaLcl1U
h9CbXgf/UP1xlHdcxsSMcl+dOuHtQVClDCrw8ssMEZoh5P0ptx96m8VaEPkVF/pU
64Y/IH4gv/ROwEXDSIT9ExPMBg4J0kTvOl08x+bnUl3oQUopPOC65uA03hOkI9V1
ygSjgh6WlNl6sT8mKOPRluz85uEGgzlGQviAdXhe/WvMSpYRkeQwScD61qJYE0Ur
yO+goydPHRmt/kNT/fqTypQ0wKu5n0j4LzIxcKN+4ovTJiNj4jdnoPLwtr+iVDVR
5n2ze8TBEUuL2Elh0d2qWqc6DXDm/2OelFLCx03gVdkr6ahg62/QOTRnJzz2Vhgp
SINDFI1pJt2+4f+R/poMsQxOUOvdPA==
=d5Wn
-----END PGP SIGNATURE-----

--ksAClhgkgYP1BOgI--
