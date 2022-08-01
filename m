Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB87586BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiHANOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHANOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:14:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC9255A5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11C98B8116B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89772C433C1;
        Mon,  1 Aug 2022 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659359681;
        bh=Ys23SCaqwQo0xJ/5DGB6j0jxIe7a4XFk2MqQP4qYS00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baIFx+BYLzwvIxTsk4i8ToRmLEoWEk38ssM0zmXdIqkX41EIzrEPFwBMX2wf95LLR
         2wrIH8KYLcUICP7WFQ8GoZe/NHONm3uQo7fQOgysSAvkfmWgJ1d6I7a1CxLvssE2SR
         wp6+jBWYWhs7Y19+0ZNga6eZVp66AgaBGTnLbylFY/0lXHJasfTxuWVo6lSIyucf3H
         QACKpjJjJfYdx72qIvN7u+5S42H2mfZBnQj7woFipz+5dNQsRxn99r8mVyzQCo7SvZ
         XzGZ/NsTXGM7Dkvyuq6Brj6XQITdc0gtCcMJJq1fg9hlMY845zfzYNqT7rRp0KFUkl
         JKN9ro0gLjfSA==
Date:   Mon, 1 Aug 2022 14:14:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com, kevin-lu@ti.com
Subject: Re: [PATCH v1 1/1] Add a new kcontrol for phase calib, remove
 unnecessary header file, make code more comply with linux coding style
Message-ID: <YufRu6/Wed2J/eoX@sirena.org.uk>
References: <20220801025939.2343-1-luminlong@139.com>
 <20220801025939.2343-2-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3VOt0VJwLJ0XInkT"
Content-Disposition: inline
In-Reply-To: <20220801025939.2343-2-luminlong@139.com>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3VOt0VJwLJ0XInkT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 10:59:39AM +0800, Kevin Lu wrote:

This looks mostly good however there are a few things that need looking
at:

> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  tlv320adcx140.c | 1218 +++++++++++++++++++++++++++++++++++++++++++++++
>  tlv320adcx140.h |  157 ++++++
>  2 files changed, 1375 insertions(+)
>  create mode 100644 tlv320adcx140.c
>  create mode 100644 tlv320adcx140.h

This is a new driver which isn't what the changelog says at all, and it
lacks any Kconfig or Makefile updates so the new driver won't be built.

Please format your changelog as covered in submitting-patches.rst, both
accurately describing what's in the patch and following the subject line
style for the subsystem.

> +static const char * const resistor_text[] = {
> +	"2.5 kOhm", "10 kOhm", "20 kOhm"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(in1_resistor_enum, ADCX140_CH1_CFG0, 2,
> +			    resistor_text);
> +static SOC_ENUM_SINGLE_DECL(in2_resistor_enum, ADCX140_CH2_CFG0, 2,
> +			    resistor_text);
> +static SOC_ENUM_SINGLE_DECL(in3_resistor_enum, ADCX140_CH3_CFG0, 2,
> +			    resistor_text);
> +static SOC_ENUM_SINGLE_DECL(in4_resistor_enum, ADCX140_CH4_CFG0, 2,
> +			    resistor_text);

Is this something that can usefully be varied at runtime or does it
depend on the board design?

> +	SND_SOC_DAPM_MIXER("Output Mixer", SND_SOC_NOPM, 0, 0,
> +		&adcx140_output_mixer_controls[0],
> +		ARRAY_SIZE(adcx140_output_mixer_controls)),

Don't put all the mixer controls into an array and then index into it by
magic numbers, just declare variables for all the individual controls.
This is much more readable and less error prone.

> +static const char * const phase_calib_text[] = {
> +	"Disable",
> +	"Enable"
> +};
> +
> +static const struct soc_enum phase_calib_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(phase_calib_text), phase_calib_text),
> +};

This is a simple on/off switch, it should be a normal control with a
name ending in Switch not an enum.

> +static int adcx140_phase_calib_get(struct snd_kcontrol *pKcontrol,
> +	struct snd_ctl_elem_value *pValue)
> +{
> +	struct snd_soc_component *codec =
> +		snd_soc_kcontrol_component(pKcontrol);
> +	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(codec);
> +
> +	pValue->value.integer.value[0] = adcx140->phase_calib_on;

Please follow the normal kernel coding style for variable and parameter
names, don't use hungarian notation.

> +static int adcx140_phase_calib_put(struct snd_kcontrol *pKcontrol,
> +	struct snd_ctl_elem_value *pValue)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(pKcontrol);
> +	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(codec);
> +
> +	adcx140->phase_calib_on = pValue->value.integer.value[0];
> +
> +	return 0;
> +}

This should return 1 if the value changes, the mixer-test selftest will
check for this and a number of other issues - you should ensure your
driver passes that cleanly.

> +	/* signal polarity */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_IB_NF:
> +	case SND_SOC_DAIFMT_IB_IF:
> +		inverted_bclk = !inverted_bclk;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		iface_reg1 |= ADCX140_FSYNCINV_BIT;
> +		break;
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;

This is treating _IB_IF and _IB_NF identically which is clearly wrong.
It looks like the ADCX140_FSYNCINV_BIT setting needs to be handled.

> +	adcx140->supply_areg = devm_regulator_get_optional(adcx140->dev,
> +							   "areg");
> +	if (IS_ERR(adcx140->supply_areg)) {
> +		if (PTR_ERR(adcx140->supply_areg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		adcx140->supply_areg = NULL;
> +	} else {
> +		ret = regulator_enable(adcx140->supply_areg);
> +		if (ret) {
> +			dev_err(adcx140->dev, "Failed to enable areg\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&i2c->dev,
> +			adcx140_disable_regulator, adcx140);
> +		if (ret)
> +			return ret;
> +	}

Unless the hardware can work without power this is buggy.  The driver
should request and unconditionally use all supplies the device
physically has, it should only use _get_optional() for supplies which
may be physically absent in the system for some reason.  For example
with the TLV320ADC6140 it looks like the driver shuld be requesting
AVDD and IOVDD and that AREG is an output from the device.

--3VOt0VJwLJ0XInkT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLn0boACgkQJNaLcl1U
h9Cr9Qf/ULUoVl5YDm4HlnyFKdSJrFSop/q5H0KXaJHmquPMXs0cOgHHvxDoB1eb
4rNNqHk94qy2/e3RKv1gDLaeEj/1E/WSPGFbQJXOX8dBs3kKgVXQpVxb1xQUwGDg
WWzfeCVimsEPHX1zHjAYVH2Rwu7fpgEj/9qoejZPiBwAeZkHFKh0oIwi309BeICp
Bbqi5L+0+OSc+ZdSt2E34oxXrVH6xtkmrDuHmmdhXJ5f2EyjZHPrgqkmS9H1owVO
UhzoXIX2VoavCZI/gu7FCV0/JoKRz8Dy9gOtAIHJlJuwGVA/NK7Z/sGZ04AnM+nc
2ZXkgZpnLe0Y1E6aWklITqvQgan13w==
=ylpb
-----END PGP SIGNATURE-----

--3VOt0VJwLJ0XInkT--
