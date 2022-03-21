Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39E4E2254
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbiCUIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245345AbiCUIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:40:55 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18332B1B8;
        Mon, 21 Mar 2022 01:39:28 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 111C61BF213;
        Mon, 21 Mar 2022 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647851967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JMfmUQxoYTTnscW8TYupXGpFLuQ3KiBZX5n0t2r2KvU=;
        b=ZINXow/fqTOdibFY3IroekzbrCGELeJ/wgb/Ne81TBoliGoj7rBGdmNOYc5qo0AdbEqC4I
        iX5cgqZFhQWcYCs+6LKx1lTSgqM8R+M6SEHtfaBSQyJIa3fV3gYGNyrx+J6C5JZtqqLXIv
        iXTZg316pooXXJSgoM1p5GXkyFQQvtD8AhEOvJAnrcwPLHK8i0BUxwkH/jH26x+TBgstkK
        WRaqdGkidqV4jzZXnTAoSFDron0tnORHJqv5rwco8P7M5PHpyuOO5PJAgFLKbnpqte1P74
        GWa9H5pzLPYSYaD5hBdHHi0UxSTRAYBmCyJEPKLxcs0TmLrSXBgM/jvGYYccUg==
Date:   Mon, 21 Mar 2022 09:39:26 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [PATCH resend] media: i2c: ov5648: fix wrong pointer passed to
 IS_ERR() and PTR_ERR()
Message-ID: <Yjg5vl1prcd6y0rT@aptenodytes>
References: <20220319035806.3299264-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="59QPluZI0vorPPeN"
Content-Disposition: inline
In-Reply-To: <20220319035806.3299264-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--59QPluZI0vorPPeN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Sat 19 Mar 22, 11:58, Yang Yingliang wrote:
> IS_ERR() and PTR_ERR() use wrong pointer, it should be
> sensor->dovdd, fix it.

Nice catch, thank-you!

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor=
")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/media/i2c/ov5648.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
> index 930ff6897044..dfcd33e9ee13 100644
> --- a/drivers/media/i2c/ov5648.c
> +++ b/drivers/media/i2c/ov5648.c
> @@ -2498,9 +2498,9 @@ static int ov5648_probe(struct i2c_client *client)
> =20
>  	/* DOVDD: digital I/O */
>  	sensor->dovdd =3D devm_regulator_get(dev, "dovdd");
> -	if (IS_ERR(sensor->dvdd)) {
> +	if (IS_ERR(sensor->dovdd)) {
>  		dev_err(dev, "cannot get DOVDD (digital I/O) regulator\n");
> -		ret =3D PTR_ERR(sensor->dvdd);
> +		ret =3D PTR_ERR(sensor->dovdd);
>  		goto error_endpoint;
>  	}
> =20
> --=20
> 2.25.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--59QPluZI0vorPPeN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmI4Ob4ACgkQ3cLmz3+f
v9HjNAgAmGq67LBBbTp9bg7Wg5UyQukKyemAP2kIIcBJyW4CZ0PlPTeK1E7G5OAN
bOfhFNB9R4TyRiXlmy5/CxtJSEK7Bdfvim0H4PFGxcjFdZoo36/HkstIEX///l53
4iOCFVTI52VDx3k9Rrc88229eGkvC0amYtUq9mhC3hdMytXdyDB2WTpW3RIjAZ9B
OWQxvxmLwLjbOcC6ojLpPHopge1L/WnzcaRqS0VBok2kh3HZKK2zFKLCSZGl/orR
RUn8fWkxld/gOqg93JuivfOvQYUuCFRnNrV5JEzQxDJx5YYmYYCaIGphl8vGi/qA
aX1iG98ItVbmgMWxsQhc/VlbiUTcMg==
=CWJH
-----END PGP SIGNATURE-----

--59QPluZI0vorPPeN--
