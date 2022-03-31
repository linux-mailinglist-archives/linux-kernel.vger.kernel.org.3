Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818ED4ED92D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiCaMDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiCaMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C11CC6EED;
        Thu, 31 Mar 2022 04:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF00616BF;
        Thu, 31 Mar 2022 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C23C340EE;
        Thu, 31 Mar 2022 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648727994;
        bh=adnfpVD7oqXHj4mfPH8O1DTjb8aRLseC4Dvlx5i6vF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swJP9pqiZw1PBslMi6kbCZdmGGEiPUICuHiBfiDTo4t2rDC46yANqiK8ahb1iwCkX
         DUKLDUtfxGiKLaeh1DnLq0GkGDygdI+QfwlZG51KvYHQzsyJ6ZQr1rB+RRYqmz62aH
         xxAoeYM0TzoLffX/gwbxmZUy80qqN92o7WT69od3BeuS7D6GHl9mDzFz4hto9EWKsN
         rk3i8v7+tcoCKMWomAkTTUtSqgCzrxXiXFtQwE32YwMtNtwcWuJAeDSogo2RTVCSKX
         1/DffffixgiTFrqYd0HJ3aGu4c6IHkp47snP0VeE1Iahf9juWMpgZK5qkX/ZMSNpZN
         cBvqxDx9+y6qQ==
Date:   Thu, 31 Mar 2022 12:59:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 5/5] ASoC: Add macaudio machine driver
Message-ID: <YkWXs/f7edZwg1+W@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-6-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+MLBZhiivx60M6iZ"
Content-Disposition: inline
In-Reply-To: <20220331000449.41062-6-povik+lin@cutebit.org>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+MLBZhiivx60M6iZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 02:04:49AM +0200, Martin Povi=C5=A1er wrote:

> --- /dev/null
> +++ b/sound/soc/apple/macaudio.c
> @@ -0,0 +1,597 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ASoC machine driver for Apple Silicon Macs
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +		/* CPU side is bit and frame clock master, I2S with both clocks invert=
ed */

Please refer to clock providers here.

> +		ret =3D of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev, "Missing link name\n");
> +			goto err_put_np;
> +		}

This doesn't look like it's mandatory in the binding.

> +static int macaudio_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_card *card =3D rtd->card;
> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
> +	struct snd_soc_component *component;
> +	int ret, i;
> +
> +	if (rtd->num_codecs > 1) {
> +		ret =3D macaudio_assign_tdm(rtd);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	for_each_rtd_components(rtd, i, component)
> +		snd_soc_component_set_jack(component, &ma->jack, NULL);

What is the jack configuration this is attempting to describe?  It looks
like you have some dedicated speaker driver devices which are going to
get attached to jacks here for example.

> +} macaudio_kctlfixes[] =3D {
> +	{"* ASI1 Sel", "Left"},
> +	{"* ISENSE Switch", "Off"},
> +	{"* VSENSE Switch", "Off"},
> +	{ }
> +};
> +
> +static bool macaudio_kctlfix_matches(const char *pattern, const char *na=
me)
> +{
> +	if (pattern[0] =3D=3D '*') {
> +		int namelen, patternlen;
> +
> +		pattern++;
> +		if (pattern[0] =3D=3D ' ')
> +			pattern++;
> +
> +		namelen =3D strlen(name);
> +		patternlen =3D strlen(pattern);
> +
> +		if (namelen > patternlen)
> +			name +=3D (namelen - patternlen);
> +	}
> +
> +	return !strcmp(name, pattern);
> +}

This looks worryingly like use case configuration.

> +/*
> + * Maybe this could be a general ASoC function?
> + */
> +static void snd_soc_kcontrol_set_strval(struct snd_soc_card *card,
> +				struct snd_kcontrol *kcontrol, const char *strvalue)

No, we should not be setting user visible control values from the
kernel.  This shouldn't be a machine driver function either.  What are
you trying to accomplish here?

--+MLBZhiivx60M6iZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJFl7MACgkQJNaLcl1U
h9AvpQf+NQTe35sa2gGAL6J5r3unBmmRuUI+0Lmize/e9oyklq/3LgUI3zy2In6m
gWr5laQlG/Eq41KJZecdtZ5BrY+BENGZ4PzCtR06uc8hM7KJV17O6hdRXrK3VSWZ
9Tl8uSSh2xNqw6bwflA6XyfULttxC6NLsKP1RxCOaHJGG4cU1G5GkvT9sTpcQH9/
bi7Y9TzxUi6Q7zgK6vVHXygqusZ4UTHdt5fyxX4ou1tV2V1fYAO64eMJ4pA+8jUA
0ZafQA1BVTbkHK7JZjbc2ILGcu5NBR1eJK/hbv9X0OknpKrRsafaQQTRywE1hWb5
NM2xv163DU7RQTC8vqYC+rKBiQ/ypQ==
=dyOa
-----END PGP SIGNATURE-----

--+MLBZhiivx60M6iZ--
