Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38064B2EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353405AbiBKUud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:50:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbiBKUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:50:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61777CEC;
        Fri, 11 Feb 2022 12:50:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2C5961F42CA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644612629;
        bh=titzUSRpLuAl1t9xsbS7kL0F6WrOUiNfN4rZ24f9VYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ya5jCVBNZbokUY4sj312TkrMPYG1GAKIBpnwiWpY1atBf6gQOesipFr6lHSkDeJaB
         GCTUraYYy7fFuvzfbKLfgbm1wbShMeeAM0Cvr/nGauxdVCR6pz81OvSQT/nzhJApHv
         mSaIGogGeZ6RS9J9BfslLcIxQn0LaVJsaacMyTENFQ2fu2jnWOqrL85c9MphHLdNlc
         Kn4K+KkiDWzdEBJlObOfFC1hpyrQAwa4fit2SoVi1zP/59oh/dzB9lSFP9s2kgT5hf
         3tCNl4ZA3hrVGkllUQdQlZlL3ToH5toWo/fUt5c/VDjjBm+gOoDWAZZYY3Y8wYjpkH
         eEL0SBYWS5ixw==
Received: by mercury (Postfix, from userid 1000)
        id AC3231060908; Fri, 11 Feb 2022 21:50:26 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:50:26 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: da9150: use div64_u64() instead of
 do_div()
Message-ID: <20220211205026.6jhtt66wco5ht6i6@mercury.elektranox.org>
References: <1644395986-4349-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tmbpapgwd5xul2x6"
Content-Disposition: inline
In-Reply-To: <1644395986-4349-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tmbpapgwd5xul2x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 09, 2022 at 12:39:46AM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
>=20
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
>=20
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instea=
d.
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/da9150-fg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da91=
50-fg.c
> index 6e36782..896491a
> --- a/drivers/power/supply/da9150-fg.c
> +++ b/drivers/power/supply/da9150-fg.c
> @@ -250,7 +250,7 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
>  	div =3D (u64) (sd_gain * shunt_val * 65536ULL);
>  	do_div(div, 1000000);
>  	res =3D (u64) (iavg * 1000000ULL);
> -	do_div(res, div);
> +	div64_u64(res, div);
> =20
>  	val->intval =3D (int) res;
> =20
> --=20
> 2.7.4
>=20

--tmbpapgwd5xul2x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGzBIACgkQ2O7X88g7
+pq1RA//amgy7aCdOmD2Kpx2XtE/2DM+vMVocYnQW+uTkFJf1Nlske4UwmTbDphI
cxNkYnlE+ftdkBpgvoXaGoCADXYbJqfHn4SCZmns7c7ElZM9UZfJIeRn1f/c/lev
ChCZS8bardkVf7DEwr3apsHEpz0RD4fWpjUqkbV7dRIDif4a8bZUxWakSS7R8LkV
L2pbun/PmbJUztbGSTb5ulsSlTvoTBU9bO3DOazLrQ8jbIs4jn1wNOtpr3txFfnf
McSumI/SBeHp2q9iIXhf/YCvGqlfyfZZNIb9HXdtYM5uxuTh+Hf1Gey1ih+YKGzu
PWVyydYzbm7aBqFD+rUeRzELSqH/EYdiyONkCojr3ONdfqL1SG92OVhZGDdJorRt
cK/0AFLb3F3AEKRL+TgT93qvywvZJTWFNcS3oThI75n0HI2SmxbEaWPcUsOlgAwc
a9FwGL1uv88LqHvk7FeUIGhJvujiS3Lbg6SwdtSCQ19WRvu863M+gXOge6pPJV84
+VKfI9RXQcOm2xRndUkqZIuodUf/Y2KTU89DK2zkRpNCjVNDV2CD8xYb0MV7rp+E
fmCS3Y+xK0btYXXyDlh5ecI5tpV0vyEwCJhyLyicFi93QDC8lLBxXg9Gq/UM2UBs
iA5MSl0FbToLrXvFShbVt4uUGsnw/vLwn+MuJgmnyIHauQYR7L8=
=nub8
-----END PGP SIGNATURE-----

--tmbpapgwd5xul2x6--
