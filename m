Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FCC4705AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbhLJQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhLJQcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:32:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304E8C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:29:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4FE4FCE2C16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2C9C00446;
        Fri, 10 Dec 2021 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639153752;
        bh=qZMDuSu0HBrM+59b1qeAI3uolB8RNdbS1spN69HoT+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzbpGVlFIarkB8baQdEADO7/nEvVSRqT4VFYmIXtX8vsB6ZTnvFYckfOtGmJN7OtG
         XGntFrEszDq6lsG/jFi+vT9pTHqbWTaQn2b0lELSmntIlh/ddr8nNfMVRw9kJa7Yi0
         aGM7+AnpF6cSBaghA7EZFV0pWBN6YJuh+Eu6qFupL3+DcRDWJ2xQxV+U7a2yol9tgW
         eDTP8jkZZ+j3JXdutVOtQL3ZXa9bLnpQoonh55FV6H/JsS1I/+ltNMFyudUDeKH2YL
         BbB83Dsk2g9Vqw761ZtSgnUkkfkt/eElz4RrPsaMwW+cIecnKjBdkz8f1ASlGhhoJ5
         wjSDUvijale9w==
Date:   Fri, 10 Dec 2021 16:29:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Shumin Chen <chenshumin86@sina.com>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: add ES8156 codec driver
Message-ID: <YbOAUxygSKNUqRZG@sirena.org.uk>
References: <20211210151041.108751-1-chenshumin86@sina.com>
 <20211210151041.108751-2-chenshumin86@sina.com>
 <42b70959-3bfb-7370-4ea4-39833b6e42d9@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RPJ/HVnd6q16I6zA"
Content-Disposition: inline
In-Reply-To: <42b70959-3bfb-7370-4ea4-39833b6e42d9@linux.intel.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RPJ/HVnd6q16I6zA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 10, 2021 at 09:53:39AM -0600, Pierre-Louis Bossart wrote:
> On 12/10/21 9:10 AM, Shumin Chen wrote:

> > +static int es8156_resume(struct snd_soc_component *codec)
> > +{
> > +	return 0;

> es8156_set_bias_level(codec, SND_SOC_BIAS_ON);

> for symmetry with suspend?

Shouldn't be _ON since we're resuming so there should be no running
audio - _STANDBY would be more normal.

> > +static int es8156_probe(struct snd_soc_component *codec)
> > +{
> > +	struct es8156_priv *es8156 = snd_soc_component_get_drvdata(codec);
> > +	int ret = 0;
> > +
> > +	es8156_codec = codec;
> > +
> > +#if MCLK
> > +	es8156->mclk = devm_clk_get(codec->dev, "mclk");
> > +	if (PTR_ERR(es8156->mclk) == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +	ret = clk_prepare_enable(es8156->mclk);
> > +#endif

> Unclear how MCLK will be enabled in a build, did you mean

> es8156->mclk = devm_clk_get_optional(codec->dev, "mclk");

Please also move all resource acquisition to the I2C level probe, that
means we don't get the card trying to instantiate repeatedly while the
CODEC isn't ready.

--RPJ/HVnd6q16I6zA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzgFMACgkQJNaLcl1U
h9A5AAf/YiebKdbXyl+0DSE7I2SvKyOIUApc8JjqOOMjp/kvFYVusyzUC21Ob/R3
7Uh1sC1k5EHQ5Y86UeG1X1XGknXMyLI+5WUo6U8aBqtABUAqq9GMUW4kVlGKvym9
WvPiw57H1iHuJfxJ5F7k++dalqbv+R+MshF/BcYEzwyLNmGC9JeGlJ89K4e5AU1P
HLmcq0umQ9iRrZei0RgTD5G1gU+S4zlLPFfVNUlKSnSpKPDpeU34FU660uRRTp8k
dBbGVVrIeG7B1axqST2gwXNB1mvY/DEXkXe77AUMMnCP0/fyHxorLeyCMlyxpvYd
csK9dx/jgZsh5z3M1PUhdnVus4FdAg==
=Yw/w
-----END PGP SIGNATURE-----

--RPJ/HVnd6q16I6zA--
