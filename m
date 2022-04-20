Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EA508D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380475AbiDTQUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380460AbiDTQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B33C31DC4;
        Wed, 20 Apr 2022 09:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B26A619C4;
        Wed, 20 Apr 2022 16:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA40C385A1;
        Wed, 20 Apr 2022 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650471478;
        bh=EhDbwrptE+6g/UNMyxZeY6Wpjo5hANx3givZ6qDu5eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjuwlbUya/ODyQ+lJKPf48cAPLfu1TguU7l3LDcpoOZRrnDe0LBLc5NFEOhG3X6Gx
         2JmIjdUp8RecbbS1p7MaTTvG9vWmTMuUT02waChGYWVbgRHveDCZPc0nTvdMqIV8qw
         LOVRmJWoiKJ629an68VeBXQe02lYhXh9DcgZgKpbBLl+SAISA9QGmTuVkCKZ59vMrY
         UrSS82gbB4IFUm/7hVrgB9O2W50hSb+UNQ5UhOLIE3CE5nCDXEGNAqtY+sATJZINqp
         5Dv3+O3JQFnwr2qYE6vAzMGpbphWAPeUNi6s8FRwb8BK5rLRzCbViL48xbmaQVakPU
         D+hwhq9Qa8TEQ==
Date:   Wed, 20 Apr 2022 17:17:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <ryan.lee.analog@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        cy_huang@richtek.com, pierre-louis.bossart@linux.intel.com,
        drhodes@opensource.cirrus.com, pbrobinson@gmail.com,
        hdegoede@redhat.com, lukas.bulwahn@gmail.com, stephan@gerhold.net,
        arnd@arndb.de, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryans.lee@analog.com
Subject: Re: [PATCH 2/2] ASoC: max98396: add amplifier driver
Message-ID: <YmAyLuZIT1zYfNeA@sirena.org.uk>
References: <20220416004024.210418-1-ryan.lee.analog@gmail.com>
 <20220416004024.210418-2-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XSbHXvA7G1nFF4+/"
Content-Disposition: inline
In-Reply-To: <20220416004024.210418-2-ryan.lee.analog@gmail.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XSbHXvA7G1nFF4+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2022 at 05:40:24PM -0700, Ryan Lee wrote:

This looks mostly good - some issues below but nothing structural.

> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +	case SND_SOC_DAIFMT_NB_IF:
> +		break;

One of these must be wrong - the device needs to know if it's handling a
normal or inverted frame clock, otherwise the audio will be corrupted. =20

> +static int max98396_mux_put(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =3D
> +		snd_soc_dapm_kcontrol_component(kcontrol);
> +	struct snd_soc_dapm_context *dapm =3D snd_soc_dapm_kcontrol_dapm(kcontr=
ol);
> +	struct max98396_priv *max98396 =3D snd_soc_component_get_drvdata(compon=
ent);
> +	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
> +	unsigned int *item =3D ucontrol->value.enumerated.item;
> +	int reg, val;
> +
> +	if (item[0] >=3D e->items)
> +		return -EINVAL;
> +
> +	val =3D snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
> +
> +	if (max98396->device_id =3D=3D CODEC_TYPE_MAX98396)
> +		reg =3D MAX98396_R2055_PCM_RX_SRC1;
> +	else
> +		reg =3D MAX98397_R2056_PCM_RX_SRC1;
> +
> +	regmap_update_bits(max98396->regmap, reg,
> +			   MAX98396_PCM_RX_MASK, val);
> +
> +	snd_soc_dapm_mux_update_power(dapm, kcontrol, item[0], e, NULL);
> +
> +	return 0;
> +}

This should return 1 if the value changed - you should get an error
reported by mixer-test from selftests if you run them on a sound card
with the driver.

> +	/* L/R mix configuration */
> +	if (max98396->device_id =3D=3D CODEC_TYPE_MAX98396) {
> +		regmap_write(max98396->regmap,
> +			     MAX98396_R2055_PCM_RX_SRC1, 0x02);
> +		regmap_write(max98396->regmap,
> +			     MAX98396_R2056_PCM_RX_SRC2, 0x10);
> +	} else {
> +		regmap_write(max98396->regmap,
> +			     MAX98397_R2056_PCM_RX_SRC1, 0x02);
> +		regmap_write(max98396->regmap,
> +			     MAX98397_R2057_PCM_RX_SRC2, 0x10);
> +	}

Shouldn't these be user controllable?  Most of the setup being done here
looks system specific, especially the routing stuff.

--XSbHXvA7G1nFF4+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgMi4ACgkQJNaLcl1U
h9DICQf/bKSmtrhcu8wSY0tnSjL1Lf/Ayrnni4M6IW2WY3KTpURARCts6AIN1ScG
tt/uv2U+YP2eoQuGJY+Ou4qgMe7IHLOfV8Ymg5MMJLPrbpgEuzDVoMQj6ZwjoKDz
iw6Ig0TfsjJ/3OLbHbKe4Oz7qWaGZzZXWWGQeQflYc7enuSO6cyUG/Wd19Gl3476
/DZ4m/IR944lGU0nHrmX17Bdo1sT/8Psfe1ZLJG7VC6Pp73OhQRWG66yNICgx+VE
iqlVHjti/NNMRRdCjWtbSRwTL8bMzjavUSti96yWhEpsSEuZpOH9w09D3PIRf7N1
VNSreXJzFQH7U60iPsQjKtdqvNRBOQ==
=reW6
-----END PGP SIGNATURE-----

--XSbHXvA7G1nFF4+/--
