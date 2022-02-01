Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DE4A644C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiBAS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:56:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39170 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiBAS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:56:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECD2AB82F5E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 18:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA79C340EB;
        Tue,  1 Feb 2022 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643741791;
        bh=c/IJGNmj/Ex6/82Ta/ipeCiMP2mjbmkO9Yx3XqM+Ro8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqWc/UnElgcA1V/zabH0Upd2dRIuZ7XfcXx1LltnpaEQjmwXG1244xqct7HfsPGfz
         EAzqU/AuH8RaTAZKaeGXrPsnZslxkl0Ly1rAyiNIu9Lhe5VyS6iE9GhDWgdWocVqnz
         SZ1mHEG90cIQbPEzGGQo0kowIy8rr/uCZKaS8eAt43OPv3QA0mmwlJUbrDngbhFIVu
         nF+aGAlE9lhtGeZBBwhDKigfv5PaECp2wT3ehSwNeGmBTcYXU1GzTZaxHXj4BUwH+Q
         aOrxAdh61l+tn8SGCG1rpmrRmfmfajV+Xjydx95MHC/B8QnpG19Y9HLkDJNy9HQ0jg
         6fbMtSjLMiC6Q==
Date:   Tue, 1 Feb 2022 18:56:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     V sujith kumar Reddy <vsujithkumar.reddy@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        ajitkumar.pandey@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH] ASoC: amd: acp: Set gpio_spkr_en to None for max speaker
 amplifer in machine driver
Message-ID: <YfmCWuD88sT8YxfG@sirena.org.uk>
References: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lIess6m8PaiZ+06b"
Content-Disposition: inline
In-Reply-To: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com>
X-Cookie: All's well that ends.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lIess6m8PaiZ+06b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2022 at 02:02:15AM +0530, V sujith kumar Reddy wrote:

> Maxim codec driver already enabling/disabling spk_en_gpio in form of sd_m=
ode gpio
> hence remove such gpio access control from machine driver to avoid confli=
ct


> -	.gpio_spkr_en =3D EN_SPKR_GPIO_NK,
> +	.gpio_spkr_en =3D EN_SPKR_GPIO_NONE,
>  };
> =20
>  static struct acp_card_drvdata sof_rt5682s_rt1019_data =3D {
> @@ -56,7 +56,7 @@ static struct acp_card_drvdata sof_rt5682s_max_data =3D=
 {
>  	.hs_codec_id =3D RT5682S,
>  	.amp_codec_id =3D MAX98360A,
>  	.dmic_codec_id =3D DMIC,
> -	.gpio_spkr_en =3D EN_SPKR_GPIO_NK,
> +	.gpio_spkr_en =3D EN_SPKR_GPIO_NONE,
>  };

This looks like a good fix for the immediate issue which fixes the
MAX9360A systems without breaking the RT1019 ones, however as I said in
the thread about Curtis' revert it's not clear what the ideal thing is
here.  There's no documentation about the RT1019 that I can find so it's
not clear to me what exactly the GPIO is controlling, if it's part of
the RT1019 or something else.  That influences where the most tasteful
place to control this GPIO is.  Curtis noted that the RT1019 driver
includes gpiolib headers but that could just as easily be cut'n'paste as
intentional.  What's the story here?

I do also note that the current code just turns the GPIO on and leaves
it on which presumably isn't great from a power management point of
view.

--lIess6m8PaiZ+06b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH5glkACgkQJNaLcl1U
h9AWMwf9H+pMGHYSfKLyGrqqxX98un/or66MjUsxkpLtvaChtZ4NO/N29ZVH1IyH
Yq7+PCSINajjV8pmxYKpPHgrjDjWCdSRk9cLHivHG7SmazMwjBGrKPYg7TLxr0r4
WkupsCucq91p+BPGZ8oUsFoEMILPHI+w0tka+AflnUfXlhYtG/qqZBa+QbJ1wEd3
ZvOwac6lbfzu2sf9vQgTJig1h9lUyRT1l+y4aFkFfQRZKQZc6YGGLzoHRawWQqxY
8m5IabZxP/3KcpMcZ6GZDMNa47nDWKu7PLQZo0OUEAUlgfffY7mO/4HBRaeJlIMc
KuFmmP9uNYoYHd+VSDPeMoD4UVBwMA==
=DVHf
-----END PGP SIGNATURE-----

--lIess6m8PaiZ+06b--
