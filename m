Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618C55FDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiF2K6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiF2K6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F5A457
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1659461598
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17563C341C8;
        Wed, 29 Jun 2022 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656500290;
        bh=eXMXjPQfilPFIwhMFsvO2FusOcPMUkuU5iKTUzRj1Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pC5lR2Xq8G7+eSWtXv114v1+OI+V22onDAF6LMXnLy5l3VLJfxohL89vQrGR6d18r
         c9iZrVl1vHPW0WB/M/xkn4LIL9bv64Ehpkr2Sp+YhYuWLG54ZOH0CFrAiG9aGHHDqf
         j1OLs7lrRng03znvWjGA7YnrtRC00+SXDALKHiUmphI04hh6ZC3QLIbtK0K4N31euq
         qqmHmjVUnlduGgZ9I/ZRCyd8f1quQOnYHHM0Uw6rv9QF98c59XLY84rKur0zypAvSK
         CZtu6rB1VH6KVSYINoS0xKW1HKNK0o5JvKB2vWV8w6C+KM2Q2B9lOZTYBTiG5P3rGd
         Bozvd8HlW49gA==
Date:   Wed, 29 Jun 2022 11:58:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: add control, dapm widgets and
 map
Message-ID: <YrwwPbm0sL1RGwjO@sirena.org.uk>
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
 <20220629090644.67982-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcLfZaC9ZTnbhhTf"
Content-Disposition: inline
In-Reply-To: <20220629090644.67982-4-srinivas.kandagatla@linaro.org>
X-Cookie: Booths for two or more.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gcLfZaC9ZTnbhhTf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2022 at 10:06:43AM +0100, Srinivas Kandagatla wrote:

> +static int wsa_dev_mode_put(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
> +
> +	if (wsa883x->dev_mode == ucontrol->value.enumerated.item[0])
> +		return 0;
> +
> +	wsa883x->dev_mode = ucontrol->value.enumerated.item[0];
> +
> +	return 0;
> +}

This isn't returning 1 when the value changes so will miss generating
events, please test the driver with mixer-test.

> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		if (wsa883x->dev_mode == RECEIVER) {
> +			snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
> +						      WSA883X_RXD_MODE_MASK,
> +						      WSA883X_RXD_MODE_HIFI);
> +			snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
> +						      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
> +						      WSA883X_SPKR_PWM_FREQ_F600KHZ);
> +			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
> +						       WSA883X_DRE_PROG_DELAY_MASK, 0x0);
> +		} else if (wsa883x->dev_mode == SPEAKER) {

This looks like it'd be better written as a switch statement.

> +static const struct snd_kcontrol_new wsa883x_snd_controls[] = {
> +	SOC_SINGLE_RANGE_TLV("PA Gain", WSA883X_DRE_CTL_1, 1,
> +			     0x0, 0x1f, 1, pa_gain),

Volume controls should end in Volume, mixer-test should also have caught
this.

--gcLfZaC9ZTnbhhTf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8MD0ACgkQJNaLcl1U
h9BXjwf+MBbQuEiO10aKYLzGCSekPsbbLZ5nbdrQRJrPPHQBz7GZeCm94ocxTqW6
urpKw5bfp4TZu28szf0jv2G/i6/pBDk+1gCbquKS//eps+rQyse3GmQ5Y/lV5lUT
8EumngMnlYMHMrBNK2iHDoYNAtrT7dYnoy3EWuhK8nR8End9AaJtTeBBztRWYU8T
SLvvPyzwBJd0gSSUzxnQG1IIHqfwLuDO/10fu2Y2Cv9DXhBAlNMivycxdy7UvmP0
aiofhOWakZx8fBM7LwQlxZVw0YB5UQHUrMMOWn4injxV6Ko0Xgoafios15wPpAr9
6JJlYCnoKRcGsjs4OAUYgwDMqRXuRg==
=91P7
-----END PGP SIGNATURE-----

--gcLfZaC9ZTnbhhTf--
