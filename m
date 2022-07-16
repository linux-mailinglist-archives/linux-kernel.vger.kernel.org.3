Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE057720D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiGPWr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiGPWr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:47:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B176B1D337;
        Sat, 16 Jul 2022 15:47:56 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 785B96601656;
        Sat, 16 Jul 2022 23:47:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658011675;
        bh=2Pu3AZ1yFuNoD7g1t6OJHWoQeW3uaFFW4sDkRlgdN1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSAcvowOMdLTmowzz9lyHwJzD7ZpqZShkOFL/gKfK0NCySX6SHoh1Tm1f9az/Mt3D
         qlaMFzzzu0Wd9BnHQ1HywVIdofeAKtbQ9iNMpwiH7v9W/eD9mRzXWXO6UvnJKglL7K
         +Qm8kQ2bXSmzIDkbSLPKLmgjjFLOsFcn5sAbW8ccQ+ciSkv5XrJrVWfbzfkI5sbBZy
         Z32IznVTAKnjPYZKno4LzHeIzmnlV0YWGF7x1gDL9C0u6iWaA0xBI+1T0W0djm/6KF
         /XgSZ4VXxKp20/gNYZhcxgecxTzu92aOoaKXlbik3FkJRubdzee4gEHuFYhLX+aeKa
         PZulq22CmjOEQ==
Received: by mercury (Postfix, from userid 1000)
        id CAB971060428; Sun, 17 Jul 2022 00:47:52 +0200 (CEST)
Date:   Sun, 17 Jul 2022 00:47:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     myungjoo.ham@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix typo in power_supply_check_supplies
Message-ID: <20220716224752.zvee6zml42ezomjj@mercury.elektranox.org>
References: <20220705033244.5791-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2gzyvp2kaanvj5ev"
Content-Disposition: inline
In-Reply-To: <20220705033244.5791-1-schspa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2gzyvp2kaanvj5ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 05, 2022 at 11:32:44AM +0800, Schspa Shi wrote:
> It seems to be a typo, there is no actual BUG, but it's better to
> fix it to avoid any possible BUG after we change the type of
> supplied_from.
>=20
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index fad5890c899e..02228d68c599 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -263,13 +263,13 @@ static int power_supply_check_supplies(struct power=
_supply *psy)
>  		return 0;
> =20
>  	/* All supplies found, allocate char ** array for filling */
> -	psy->supplied_from =3D devm_kzalloc(&psy->dev, sizeof(psy->supplied_fro=
m),
> +	psy->supplied_from =3D devm_kzalloc(&psy->dev, sizeof(*psy->supplied_fr=
om),
>  					  GFP_KERNEL);
>  	if (!psy->supplied_from)
>  		return -ENOMEM;
> =20
>  	*psy->supplied_from =3D devm_kcalloc(&psy->dev,
> -					   cnt - 1, sizeof(char *),
> +					   cnt - 1, sizeof(**psy->supplied_from),
>  					   GFP_KERNEL);
>  	if (!*psy->supplied_from)
>  		return -ENOMEM;
> --=20
> 2.29.0
>=20

--2gzyvp2kaanvj5ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTQBgACgkQ2O7X88g7
+pqkOhAAk8PjxHluM5z8cE5okLdna7x94NWtXT7DVCe0ryxWOSKQv9+1XFa4Motx
Mjdtb6z0OCXV2FgC1Ryyi0SvldhU/ywI+p5DkrMGubbFTQ7Q39s6/itFSNULOR9o
0WC6BIsbIexF3OnruM+EzGhNw6XOAE76rebJvd0C/LASB+G8QpsOiKcnFlemwjVk
WOoYT87wg5cItJsaJW0ORFKloL4O8kv3MNPJGi0poXB7pVpkGCPPUfWzGfcmRO+u
oGCDr6If/9Eg2PlfJMAdB5VJ1GO35xClHbt3OujQ8XRYyke48etTZAhX/ay6bi2f
nHc/jJsiCh2xa1v20ul3Ew5JsGL30N5zYXHrzIG+HkMTZDo9GMdIqPang4bThoS4
3hOPuUO6QzH5lD1NMPVR7FQXYv2WfLejKS/2zwn6tePR+xDDe6UmItZFAF4cJwGa
VWtwlYC9LTjajTTPReavCwHNDtzY9oUwvwMJzxuPTFkMtmSBAyuTi/Q24X5Ry2YO
o5v5M5xNo+ZWtL+1qQJ6oe/QqGcjpC6+Ixq+rh2yQLPPBooVgxV59eOPey/J/5B1
3tOTIpdifeVSSc6WNwn9xSqdSY3oTlcL0qiJnyRiKFKR8KEzZWL7f35G5vZtb89o
vYgRZWIsrh66XKjMKTLQIBLgojDKhb3bsXnINfwbex4i/H6wXA8=
=c38s
-----END PGP SIGNATURE-----

--2gzyvp2kaanvj5ev--
