Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842C4775F2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbhLPPah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbhLPPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:30:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A8C06173F;
        Thu, 16 Dec 2021 07:30:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u17so44914865wrt.3;
        Thu, 16 Dec 2021 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ljz1sia0YjUcnh8cX/bSKFrHoMO2tH/2wPxmNzX1O4=;
        b=hfDSQRBrhQVm2NOzdpqwxylBGQgeOUmm8l8Ro2WD06r79RRhoMX8Jwm6RhUmtUCLDn
         CN1ivuFuclTpTB2h5j7URTwgL5x4u5r8I4DEg9qimVY3Zuhf9gqgcoTSKQSXjQcd2qAZ
         Mw3fznXHYx/UYtdjAjx/kVSIWlOSXooFnYvm+eGcZg9H9DCOE0yKCt+QXygZ9elAPIQA
         cklYHS4uSDCY5yC7WtEiT9qq8MXoLcl0st+4lWR3gTEl33sJrBGyuY9WpG2l84VvrIPq
         6nLGOopCQ4ewFXcVvMcwsEjdAu/cV/oudhLr7y14aI+SiWrGNnAQA+xaEDV3BdzI649f
         o6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ljz1sia0YjUcnh8cX/bSKFrHoMO2tH/2wPxmNzX1O4=;
        b=WH+14+bWlXPM0GE0zIqsOybNWk8C0TWwQ9/c/eUN5SumA2s0xX3BftMZvvxvRwM5js
         /6y0aUV+xtuJjHC0eLAAdT0WPibm4uNjFRcGyW3LQg3qqZtBkScf14DXT1ewaW7QHLoQ
         gyARKYtwZzW9Pdqwkp41WZJJ7fq18GA3CS1ijoBB7kC9GhMlvW2uf72sLs75YNWvpSNA
         8x/Wh7FtbxLNHSvCrFe1rKFubMXxekqTbw3e3VNkS/ApkwFYDFJuWUhOs49tq7zulzo+
         0EADSSt60aYnqtNWR/KCHH1/A4wQYj2VnpFqnpIEyvmk60ewv10Cmz2P5QQkK601bcRf
         B/tw==
X-Gm-Message-State: AOAM531y3EySqD2e5aH14gOpL0I/0/k7K2k4DNEYVRKHOIRnQOXsEt8f
        kxRzCi70A280fKvuKbtz3Wo=
X-Google-Smtp-Source: ABdhPJyGqb1sK9/KehghXxEJLcEssMut1QZQEgMFWqLe0DyI32xXK6U2NEiO83P+2tWeOyGZch1AlQ==
X-Received: by 2002:adf:aa9a:: with SMTP id h26mr9312334wrc.437.1639668634242;
        Thu, 16 Dec 2021 07:30:34 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id l22sm4869371wmq.2.2021.12.16.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:30:33 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:30:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 12/22] ASoC: tegra20: spdif: Filter out unsupported
 rates
Message-ID: <YbtbleAye0kQ3Ghq@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hlDusqvBIjGc6g1d"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-13-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hlDusqvBIjGc6g1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:15PM +0300, Dmitry Osipenko wrote:
> SPDIF and other SoC components share audio PLL on Tegra, thus only one
> component may set the desired base clock rate. This creates problem for
> HDMI audio because it uses SPDIF and audio may not work if SPDIF's clock
> doesn't exactly match standard audio rate since some receivers may reject
> audio in that case. Filter out audio rates which SPDIF output can't
> support, assuming that other components won't change rate at runtime.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/soc/tegra/tegra20_spdif.c | 61 +++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_sp=
dif.c
> index a4aa5614aef4..d09cd7ee6879 100644
> --- a/sound/soc/tegra/tegra20_spdif.c
> +++ b/sound/soc/tegra/tegra20_spdif.c
> @@ -79,6 +79,7 @@ static int tegra20_spdif_hw_params(struct snd_pcm_subst=
ream *substream,
>  	struct tegra20_spdif *spdif =3D dev_get_drvdata(dai->dev);
>  	unsigned int mask =3D 0, val =3D 0;
>  	int ret, spdifclock;
> +	long rate;

Perhaps we should change spdifclock to be "long" as well, even though
they're the same on Tegra20. SND_SOC_TEGRA depends on || COMPILE_TEST,
so technically somebody could build this on 64-bit and then these are
no longer the same types.

Still shouldn't be problematic given the numbers that are passed in,
but it'd still be nice to keep consistent types for these.

> =20
>  	mask |=3D TEGRA20_SPDIF_CTRL_PACK |
>  		TEGRA20_SPDIF_CTRL_BIT_MODE_MASK;
> @@ -133,6 +134,12 @@ static int tegra20_spdif_hw_params(struct snd_pcm_su=
bstream *substream,
>  		return ret;
>  	}
> =20
> +	rate =3D clk_get_rate(spdif->clk_spdif_out);
> +	if (rate !=3D spdifclock)
> +		dev_warn_once(dai->dev,
> +			      "SPDIF clock rate %d doesn't match requested rate %lu\n",

That should be %ld since it's not unsigned.

Otherwise, looks good. Probably not worth respinning for just these
minor comments, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--hlDusqvBIjGc6g1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7W5UACgkQ3SOs138+
s6EoZA//RbQ55S5Uiwy8g6JPCcgotaa5lun+zkW1rlcFkNxQdjV2L34+7vI2qe0p
cq0JRwSP9gcN70Ev3gZvdfsX8gF3PpUa8CI/n4LekRF/w7UpBODl2DnjBMx5ooMT
oCttnlJ9n6Oguj4HumyNE4IHEaEvPh4ZM2zwTYjWZKRFZprajsSOLnLld9Hb5DIz
ouN5/TX14FNRl1SlW69oBs370/y+ai9VKIgYnHjgkDCyG0iIHVUDG6qlowt8XbfR
RTUeB6yxy9Pb2ip2zRFC/q2bK4SjsrVk3nM1UgQ1MRtJXUhXI7KmIsHMsZgOKYqL
P+HSo1xynxA9KlqowzmB7z8rmkAb8C0ItGNDeC56B+D62mJNaRGMlPd8eP9g4S+P
UKev7F4U6L9kER3L+0LbpTvfNRngqgaGwiCvluPdP/u2DR000QGH9/9GOeQvGHqQ
0BcqIunA/H+DTdWqcvlyoqUIZxH1EWWsa7W6jJ+YRsW0W7jTrHjm1oV+EWg+mNt3
uWHb7dvl106okJNL9NPnxYN3mrAUAxgCUaCwRNrLp2Ls8qK524kXIbkGvm6AkwPn
7W5fLG0y0+nocEBXD51rz6uFzl1t5xCqw1Y77p5QDamNyErjxZx9DyXe4/fdWrTt
ouaaeKp7Og++Bpn0D0XcwBIFDu40tBkQLzD0xF0Ieu2tv3gWMlE=
=gmxg
-----END PGP SIGNATURE-----

--hlDusqvBIjGc6g1d--
