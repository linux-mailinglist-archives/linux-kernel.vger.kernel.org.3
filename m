Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0708450829E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376346AbiDTHvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344870AbiDTHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:51:43 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D70340E0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:48:58 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4B86C1C0B87; Wed, 20 Apr 2022 09:48:56 +0200 (CEST)
Date:   Wed, 20 Apr 2022 09:48:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     cgel.zte@gmail.com
Cc:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] ASoC: fsl: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Message-ID: <20220420074855.GA25823@amd>
References: <20220412083000.2532711-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20220412083000.2532711-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  sound/soc/fsl/fsl_esai.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index ed444e8f1d6b..1a2bdf8e76f0 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -1050,11 +1050,9 @@ static int fsl_esai_probe(struct platform_device *=
pdev)
>  			goto err_pm_disable;
>  	}
> =20
> -	ret =3D pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(&pdev->dev);
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0)
>  		goto err_pm_get_sync;
> -	}
> =20
>  	ret =3D fsl_esai_hw_init(esai_priv);
>  	if (ret)

Please take a closer look at that function.

a) error labels are now misnamed

b) there's leak if
   ret =3D fsl_esai_hw_init(esai_priv);
   if (ret)
     goto err_pm_get_sync;

happens.

Best regards,
							Pavel			  =20

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJfuucACgkQMOfwapXb+vIiGACffOMVcK21uP4rckwMmbnzLCim
9/QAnjyoa8+Std4g2m6imouSbgDhSKdo
=cpOV
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
