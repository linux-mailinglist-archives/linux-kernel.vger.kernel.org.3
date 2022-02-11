Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D45B4B2E53
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351148AbiBKUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:18:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBKUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:18:50 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E30CF9;
        Fri, 11 Feb 2022 12:18:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E87241F47311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644610727;
        bh=FKmREKxPGsm31y789/Pvn0AY/iQ2MYWOKaGsio2oCkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2g98pujQDr3YZ3+koI2YRmAI++sXs51QQyWDAKQ7mKyY1HlLUnJGHDWp4XTy2dGn
         xIJqfBM7DwK+8cDaFYYgu7b0S03SY+aWR9YFcSaSo/Bs4CPTL9+tFqWmHtQVjpg2ss
         VKbQncPXA6VXC+rOD8zgvwfUsui6UnkCfn8es4T2ac1RJeotXmAVWeiEp82gly+VlI
         XYuzHjdEmzIKBdNNBIJAIY0HRB2ERF75yG6p8iyKQND9DssKceimLw7QceS2IW9Xfo
         oLHi3EL9tHyzAbV3XOBsemdSUkoLXsljaPkH3NM++EHwXGTB8onN0LE92zY7RSKWNC
         K8sTMIWoz7kJg==
Received: by mercury (Postfix, from userid 1000)
        id 074831060908; Fri, 11 Feb 2022 21:18:44 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:18:44 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: ltc2941: simplify Qlsb calculation
Message-ID: <20220211201844.5g4x7tjpuw64hhwt@mercury.elektranox.org>
References: <680a4c737950f59e787f64887402e3ae247e89dd.1641868274.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gxaxhjzleppuumbm"
Content-Disposition: inline
In-Reply-To: <680a4c737950f59e787f64887402e3ae247e89dd.1641868274.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gxaxhjzleppuumbm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 11, 2022 at 03:32:40AM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> Replace two divisions with a subtraction+shift for a small code size
> improvement and less brackets.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ltc2941-battery-gauge.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 09f3e78af4e0..c0cbf4cd59ee 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -490,13 +490,13 @@ static int ltc294x_i2c_probe(struct i2c_client *cli=
ent,
>  	if (info->id =3D=3D LTC2943_ID) {
>  		if (prescaler_exp > LTC2943_MAX_PRESCALER_EXP)
>  			prescaler_exp =3D LTC2943_MAX_PRESCALER_EXP;
> -		info->Qlsb =3D ((340 * 50000) / r_sense) /
> -				(4096 / (1 << (2*prescaler_exp)));
> +		info->Qlsb =3D ((340 * 50000) / r_sense) >>
> +			     (12 - 2*prescaler_exp);
>  	} else {
>  		if (prescaler_exp > LTC2941_MAX_PRESCALER_EXP)
>  			prescaler_exp =3D LTC2941_MAX_PRESCALER_EXP;
> -		info->Qlsb =3D ((85 * 50000) / r_sense) /
> -				(128 / (1 << prescaler_exp));
> +		info->Qlsb =3D ((85 * 50000) / r_sense) >>
> +			     (7 - prescaler_exp);
>  	}
> =20
>  	/* Read status register to check for LTC2942 */
> --=20
> 2.30.2
>=20

--gxaxhjzleppuumbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGxKMACgkQ2O7X88g7
+prTpA/7BPe0XzdCpPVaICPJKvHTuN/F3MiSwIIgrvpQIB0pgl3vA+5apE+GJ/eg
ctSIRtfYr4NUK4O/nizuUIoge/dkmPPxRiXnarqOiCJLWgBXwax+t8p9daTYIkGo
iPfgTjJpb2LO/DzvZbyuaaQ/ue9bbAp4HDx3ZSRK52BvwjgTSebdFkcJXaIPaKtS
ug/4Rh/B/+RL+gyOkTqCGFKlQLI+CEs6jowB804LF+y4ZLCXS0FtYZpCLv/Nwh9q
pwrXUwoHH2BLvPSVmp5cKwg0y239VUJL0+7kXu/Fnt+ckiYW0hjb05V+IUevAMBe
dDLapu2fM4EG9Wo0mShOflTth0EHK8hY4IbgrA/suaWzmEVeSbXCv28fre++reGJ
EXM1sdWcAqZ5P7cQkRJnhG9LqZwG5Y1R+oBHUBG5ELIA3YBSr15Ag70vDXM6L81U
JaSxtxAGO0AMzyOvX7GjJijeFgc9SzinNiDwHKa6Kloq1om9aP3VGwILQ+LzsYwX
Arj0prxZWe+fRSZq809pNSRpYxaJyMWfr37r/m//LA4i4ndhF7Q8Ta7Wi1AiKZju
Za62QYPnwy3U967ZjDos0xcWUR5kTe+qZPv1H0ZZRdHW+mZ/x6cBSimmk2/fGObt
gvY69nd9XzbyQQqNJRRcl/AxmqTbetdFjKqFwBEkmjXFokoGfic=
=i0fz
-----END PGP SIGNATURE-----

--gxaxhjzleppuumbm--
