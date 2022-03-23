Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C2B4E5234
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiCWMcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:32:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784084839F;
        Wed, 23 Mar 2022 05:31:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bi12so2540603ejb.3;
        Wed, 23 Mar 2022 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pr1tceJ5axwZ9yC4WRhMr6ZLanYIf+/neXLund54R+A=;
        b=otx8RnRZQ2F3yrwx7ahJIs540TP6ZitRvGTwj9XKpxERUTTfAk4k1nkjWZGS5eJuNz
         gysy8cnFBpLYFxGTJyQG0++7AqsNHxoR7BLjuLCFLTos6FuikYA1Z53amJ0UilSb7bmW
         ScnKAVQ7LtunK5DWP1alJPH1+oQRqNN5rSjfN6Rre43yFD5n5ZwLdv8NzKXgadkWC5ai
         MRPJB/AHfECXJkioAXM7UpD4Rs3REtIO07ItoQDQm5oRJCScYK6AYE8dRyb5XrxNsu1p
         OVA1wMR1I1GY5FeHNybFEFh04GAEnKsx4swyRVMXdt/+z6W7JQzkSuARPIyDp2xKLhSy
         luEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pr1tceJ5axwZ9yC4WRhMr6ZLanYIf+/neXLund54R+A=;
        b=qaOoeT+cdOqCDvq7MEK5sIJR/o9XfyVLFAkE0bwC+IQYa2/4GvgMXldM0Q6HHBfRHq
         jvlOzIlFbxnKbG8C+xbq7sxOe1d9IhtJzCGQnCOM8PfS7NgJHGsNMvF1N4j9PwjSWG+u
         0RZjCxbowdobHO+TNKxxEWseBcJ9qRLISeGMLf+0vnyeg/vOlVpPJwD1CtBrWPwV4UHK
         +tQjwDYlzNL0o5W2Yjj9j4V+/qpj0UVoLzcfSKphYFGEzDnhMHx3lSS2cGCs3dLTi+bM
         DoqWjbhtkD+bCFCJ0SXCYu+vb/1hy9ZaTiuFWdwS/kmaKNLo/3eVajao6lIWg8ZWckMS
         mOfg==
X-Gm-Message-State: AOAM530ZKTEOdqYMAAPDNCfRmheeZaoW+0bAErtgnDSXaYjy+y5VER/k
        XpspqWU8Df8bEwtcViWGLd3gW0FjZ1w=
X-Google-Smtp-Source: ABdhPJyWb9xSYuH3pMaouoh955z1Yi5I2iWyIvxN7OHQy+kr8UClS1Jr2hxoZbb70XoECdC0mjNvng==
X-Received: by 2002:a17:907:968f:b0:6db:a3c5:ae3e with SMTP id hd15-20020a170907968f00b006dba3c5ae3emr32282332ejc.770.1648038668818;
        Wed, 23 Mar 2022 05:31:08 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm9562677ejl.122.2022.03.23.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:31:07 -0700 (PDT)
Date:   Wed, 23 Mar 2022 13:31:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, smangipudi@nvidia.com,
        EJ Hsu <ejh@nvidia.com>
Subject: Re: [PATCH] pinctrl: tegra: Set SFIO mode to Mux Register
Message-ID: <YjsTCRdc3yCLZkVY@orome>
References: <20220311043015.4027-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aDwnUUzQs80VnPan"
Content-Disposition: inline
In-Reply-To: <20220311043015.4027-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aDwnUUzQs80VnPan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2022 at 10:00:15AM +0530, Prathamesh Shete wrote:
> If the device has the 'sfsel' bit field, pin should be
> muxed to set to SFIO mode to be used for pinmux operation.
>=20
> Signed-off-by: EJ Hsu <ejh@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegr=
a/pinctrl-tegra.c
> index 50bd26a30ac0..30341c43da59 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -270,6 +270,9 @@ static int tegra_pinctrl_set_mux(struct pinctrl_dev *=
pctldev,
>  	val =3D pmx_readl(pmx, g->mux_bank, g->mux_reg);
>  	val &=3D ~(0x3 << g->mux_bit);
>  	val |=3D i << g->mux_bit;
> +	/* Set the SFIO/GPIO selection to SFIO when under pinmux control*/
> +	if (pmx->soc->sfsel_in_mux)
> +		val |=3D (1 << g->sfsel_bit);
>  	pmx_writel(pmx, val, g->mux_bank, g->mux_reg);
> =20
>  	return 0;

So this is basically what tegra_pinctrl_gpio_disable_free() does. I'm
wondering if we need to do both, though. Are ->gpio_disable_free() and
->set_mux() always called in tandem? I suspect they are not because
otherwise this wouldn't be needed.

On the other hand, if ->set_mux() can be called in a code path without
->gpio_disable_free() then this may be necessary to get the pin out of
SF mode. But that doesn't necessarily mean that the reverse is true.
If it isn't possible for ->gpio_disable_free() to be called in a code
path that doesn't have ->set_mux() then this patch would make the former
implementation redundant.

That said, upon inspecting the pinmux core, I don't see a 1:1
correlation between the two, so this seems fine.

It might be worth stating in the commit message what the practical
implications are of this. That is, you're explaining what you do in the
commit message and assert that this is what should be done. But it'd be
more useful to say *why* this is necessary. Specifically if this fixes a
bug, then say what kind of bug this would fix.

Thierry

--aDwnUUzQs80VnPan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmI7EwcACgkQ3SOs138+
s6EAVQ//UN048EY2ruCY7siM7mFkIa7bi2ZZNMtJUrAOCifmmEVcbiGLdznlNicU
OZZswzDUXCD5bq0Ouug4AaFX9GkadYwm5UvI/FpjEzG29LSvcdb3rqECX3DzDwvn
WjIGSI1QVH450nCg+FP2GtypTr8FvW2tsHZMKwia+xj2HMZQf63EjbMzDABAzvaC
FDL/iVzTisNyxDqhZrEVegydjTwNxJug1dsEfCH7obu47QcVnuAknQOigHn2KFsx
9IqCrva8VLTAm8i9kgRu7b1YJOhbMQRcQ+JzrYpdYi68pHkU+LtajTsqsIbjEEp3
wnGdUP3gqinwd2km0ORV4DqG3BOQK4oXQDi5kOJjiGKuMA1wCmu3A2daTd11VRAN
5IXTc3FkY8va1Fr4PRGJ3NjufGbovFoImOy5sT1AZ+jxTaNNN88xgJB7BrNGvNTE
lNxcCQm1j7UCVo7oyiVj689hWRJJqSTxUst93pY9zAU8QyCUIjVrOecypzF9nNIV
aawPUoWOy/eKP/4p/055sAFtfYafXCXcSQJVDw+L3bWMEYE3n3oKEDcrG8hHizz9
FUH7YcBKazmBF+qgcDFNbbyYznC0AvP8bdkwJNvu73p89iu9OxX+MeibU+yPoXxd
niR1JfvkDzWeDPXLk2A16c1iwn8VeiRGNwd5zIw2qgN8Qhgx614=
=5/zk
-----END PGP SIGNATURE-----

--aDwnUUzQs80VnPan--
