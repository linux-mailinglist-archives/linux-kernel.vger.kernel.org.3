Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9034559C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiFXOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiFXOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:35:51 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B7563AC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:35:27 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B1ECC2000A;
        Fri, 24 Jun 2022 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656081326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=19T0/4IPPW1GQWI31VpPxCmK00qIsCKpQrmNNviZXf8=;
        b=epq+BuYnxlAKsTU/Ce94aJ1lSbVtGjNy0FuSDoSsFQooJpdVjQuH2hQnsiEernff1IrM8V
        5zjEs8L9RGNMp1webmA82qcYjxm4/yGVdXOZt0tvo0hWd1GobIO62N5hxUK2mHOyJK6C+q
        +pmEPCGD1S+sZkktRQbgNKxRlhlMGy3toKVH05+94v7Lwwdgt48SF5COtbhnDi2ytDRT1O
        GgfLTRaa3E7w44hHeQ4cYkGHT2Yv8s4okbzzGI9yXtuD5zJaaj6K6BlW/aDboL7njDZXjq
        pQ/u/gJIQu0HdXQ/0E0Q9Q93R4n5FipkM2Rq2LZML1Xv49Mr257OBj4V8pzQTA==
Date:   Fri, 24 Jun 2022 16:35:25 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: logicvc: Fix uninitialized variable in probe
Message-ID: <YrXLrVUIavGWC4sx@aptenodytes>
References: <Yqh6OfSiPFuVrGo4@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DwiraIsIEPc2Ikp+"
Content-Disposition: inline
In-Reply-To: <Yqh6OfSiPFuVrGo4@kili>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DwiraIsIEPc2Ikp+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue 14 Jun 22, 15:08, Dan Carpenter wrote:
> The "regmap" is supposed to be initialized to NULL but it's used
> without being initialized.
>=20
> Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Nice catch, thanks a lot!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/gpu/drm/logicvc/logicvc_drm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logi=
cvc/logicvc_drm.c
> index df1805cf0f95..0b983a33f9ff 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
> @@ -298,7 +298,7 @@ static int logicvc_drm_probe(struct platform_device *=
pdev)
>  	struct logicvc_drm *logicvc;
>  	struct device *dev =3D &pdev->dev;
>  	struct drm_device *drm_dev;
> -	struct regmap *regmap;
> +	struct regmap *regmap =3D NULL;
>  	struct resource res;
>  	void __iomem *base;
>  	int irq;
> --=20
> 2.35.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--DwiraIsIEPc2Ikp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmK1y60ACgkQ3cLmz3+f
v9F7Kwf/QJpFMndulFNyA2x3mb7KHVGg3dQKG+3a7CvlFT2m+N0OUW6HcXSkmz+x
Z7Ccffbm4Lb2E+gQucPwwPDReZieX4IrVhiHQfoc5IRTq5916CRouPxGGmzzq5KS
pUYjhWq9PNNNU+oDiZ6k04H2ozX8T8fABH7/U2ZBeRZ0oocBXMZL2hXnvNbLou4C
1dPE5D/rMZ7qGKkFi7Oks5c1IWz3Sx9ieku6ZH+AGbq7yr5ILxt5zfIuEH02NPZ9
DpaVENSmpOccaOZcM00rIbUFwVpLptmV56Woar15J9NZBcgewR2j655GQk/M1jG9
hMSQofNJAMMQRLPA3S7vgd8+lnQTrA==
=Ojhr
-----END PGP SIGNATURE-----

--DwiraIsIEPc2Ikp+--
