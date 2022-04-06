Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEF4F6489
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiDFP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiDFP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:56:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F136E2D;
        Wed,  6 Apr 2022 06:21:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so4254365ejd.3;
        Wed, 06 Apr 2022 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yESXEe0+6GUCQQAygJIy9zdNmWQoteoBqsLlYT+U3Pw=;
        b=m4zu2aWGPii7y+HdtTFFDusKRn2vRLX86QvtKNwqf/ThhEGKyRuzHj2bLxziNYlJz7
         LXOouEGWEHMBixmGR2izzkw8ifx/0WpBgQXwWgg+QYGZX/xpdNM3akrfO1KvVzkBn79g
         hn3j8aIvqON4ybc6BCvU3FV6ziqo2ZvqjyYcgOhqBwk7vnVscLY6CdFEWd6ZpkwxpJU6
         wxw55Ez89y7FsCfmDBxJjKXAortyZPOdA7I1/tkZ+ReKnQyNj0Fcw4o35m3jlPECi765
         QLkDphzZiHVeXUtEmMT/INAICP80pYKLUEdEq6cyvUOK8SQRHRQkfq4pYQl/bsxCG4YV
         z61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yESXEe0+6GUCQQAygJIy9zdNmWQoteoBqsLlYT+U3Pw=;
        b=l7rA8AolElADzU7D98vaLK9D94Me6rnCwstmKkfNzSC/2JwmzzxIpcrHpnS8sVGbrj
         vaFpVZZ+31xvAosal8iiYiDKXrj3sbogMqIq2mnNlSjPYebTCQDqy2env34p3vsiAA7l
         g0vN0w7y8Nv16w0nWBt9bmi5uP5uEuiEN7dZxN/U+aOqQ3pnwApL1Cy1HJF4ptqQsaYi
         44IyhRgBgxdNVi1o1DHN1aPwcjt5K8FRaA/D/1Dm2lfgSEGIwT1L8OdLoVnXQNDDiA0a
         mJjmjJs4YW9mnpdHYE3NAznNf2o0bY1gxs0TVX+bNLWKdQEBYLjhfaOsb31XoytYgs0q
         83lA==
X-Gm-Message-State: AOAM532I7Q5toCYpSVWnLaFY4jAb5Fn/EY2kUw9b5mKYWLsoo6O7oEwO
        KbfijPdym9UU/GNIeZLCpfQ=
X-Google-Smtp-Source: ABdhPJyEt5Heruqfz5ekAxEIum+qU1DdZN/P4WNLsqph1vg/dCXgqNAQ/v26Wow97WmVAOa/yKEaHg==
X-Received: by 2002:a17:906:4793:b0:6e8:289d:c13e with SMTP id cw19-20020a170906479300b006e8289dc13emr1351726ejc.489.1649251270789;
        Wed, 06 Apr 2022 06:21:10 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c0c8000000b0041934547989sm8012684edp.55.2022.04.06.06.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:21:09 -0700 (PDT)
Date:   Wed, 6 Apr 2022 15:21:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: vic: fix unused-function warnings
Message-ID: <Yk2TwyteFgeqkZE1@orome>
References: <20220316183708.1505846-1-arnd@kernel.org>
 <20220316183708.1505846-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HP/3wNqKzbcc9NYj"
Content-Disposition: inline
In-Reply-To: <20220316183708.1505846-2-arnd@kernel.org>
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


--HP/3wNqKzbcc9NYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 07:36:47PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The use of the old-style SET_RUNTIME_PM_OPS() and
> SET_SYSTEM_SLEEP_PM_OPS() macros requires function definitions
> to be hidden to avoid
>=20
> drivers/gpu/drm/tegra/vic.c:326:12: error: 'vic_runtime_suspend' defined =
but not used [-Werror=3Dunused-function]
>   326 | static int vic_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/tegra/vic.c:292:12: error: 'vic_runtime_resume' defined b=
ut not used [-Werror=3Dunused-function]
>   292 | static int vic_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~
>=20
> Use the new-style SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS() instead.
>=20
> Fixes: 1e15f5b911d6 ("drm/tegra: vic: Stop channel on suspend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/tegra/vic.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> I see this warning on 5.17-rc8, but did not test it on linux-next,
> which may already have a fix.
>=20
> diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
> index 1e342fa3d27b..f56f5921a8c2 100644
> --- a/drivers/gpu/drm/tegra/vic.c
> +++ b/drivers/gpu/drm/tegra/vic.c
> @@ -513,9 +513,8 @@ static int vic_remove(struct platform_device *pdev)
>  }
> =20
>  static const struct dev_pm_ops vic_pm_ops =3D {
> -	SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> +	RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>  };
> =20
>  struct platform_driver tegra_vic_driver =3D {

Hi Arnd,

is this a replacement for __maybe_unused annotations that we would
typically use to address these? Is the ternary operator in PTR_IF enough
to eliminate the warning? Does that work the same way for structure
definitions as it does for conditionals where we use IS_ENABLED() to use
the compiler's DCE for improved coverage?

It looks like it, but just making sure because there's another patch
that fixes this warning by adding __maybe_unused.

Thierry

--HP/3wNqKzbcc9NYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJNk8MACgkQ3SOs138+
s6EfghAAwTnmOPtrfC5Qjzo6Gd2YHQVRPrJ3nq4VQNddX2aPY7mHpsaQgU8pmrSH
bt8kUlPsGkh8lEJ2B4b1/MlIxUrhoYj+XOjzHBl3McdHJMKTzhnyV45HU/nWUXtB
rptRs0Bz5eekensRZTtklgjxmS/cdxeje8reyKe4aE809Mx8AhseYV9aHuB/jFkM
QiqEcacQIJR+W5y+3AUrGjr6wBqaSt/69d5h9u0C25CD5mHygMMKu38+AMGFlvsL
mhJktcKigjKSoUj3L5RKQKX6ZWqsEIHDjJbboiFcuFkGliwmaR6GZGIp1APCOnzW
TOvxkgatv2gQsp4T1ymDr323n07eNYXzBq14uXu6tBkfaqaIQ23AwSHGjJIcKrER
qAe67DgH8OKHUksMuLzHelPM52WeBsO/FkzPIkdD5srB6jZBaexwIsj15nT3Y9rc
4vDM9/M3g7rISfa2WBfRrdSfx5Uf4bMpRedrpBowbC2I+DUgyQ1SlZIgktzr3r4k
pj+2xeBTKfb0UjsgRYv6XA/nQ0zOiwgMio65gcOBwJIm4qxlcpbBW+KbtNiZz1qE
0yYYfIx0IEiPyn5GJqVeS0vhvq0nfqAsbadY/hiB08xoPPqPPqjPSWKdgUxvxEzl
Nyf6UNmidSSQzfiyR9xjdBMasYFYlFNuMiDKmNCGQqP/uslwIrA=
=itVd
-----END PGP SIGNATURE-----

--HP/3wNqKzbcc9NYj--
