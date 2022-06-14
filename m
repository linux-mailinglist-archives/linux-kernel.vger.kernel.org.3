Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0654B56D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356489AbiFNQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357071AbiFNQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:08:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1483835AA5;
        Tue, 14 Jun 2022 09:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6FD10CE1B25;
        Tue, 14 Jun 2022 16:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA653C3411B;
        Tue, 14 Jun 2022 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655222909;
        bh=f6KuiueIv/s3cr+8vOYyA2WSMzAJ801h4xLsZ5d4vCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFsM3wa7t0y5/icGPA1hoiUopkaKXnX+CpJLFWVGwSkPa0Qa+k+fznmt3Y/IRdgAv
         q8oKIyt45anZyqQnBVyf7ijXJq6aD/afzSsX8o5+rU9gr6xZ5V+HuklQOJGmJ02O0Y
         cSjmb2RSEqIt4H8hR8+gpp846vKuDcYtjRxkzYo2vSYgygE61zxqjfvae9miPVaIcw
         R1d5VXeNEg5F5q8bdxp5OCJheNQCGau0jUaC4Rz1bEpFy7OouEAR2F5n96+H9iEttu
         DA/EbzPQhgJJzRGE5DdsGuQ6ZIq9VB64XOlNMizMza2KLLQQnU/d9z78AFcie0XVMp
         J5oIbSkIiJoPQ==
Date:   Tue, 14 Jun 2022 17:08:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Owens <dowens@precisionplanting.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: omap-mcbsp: duplicate sysfs failure after
 PROBE_DEFER
Message-ID: <YqiyeM2JkDxLIKDe@sirena.org.uk>
References: <20220614155931.2706437-1-dowens@precisionplanting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GYvOB+ScB/4Az0wW"
Content-Disposition: inline
In-Reply-To: <20220614155931.2706437-1-dowens@precisionplanting.com>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GYvOB+ScB/4Az0wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2022 at 10:59:31AM -0500, David Owens wrote:

> The call to sdma_pcm_platform_register() can return PROBE_DEFER, leading
> to omap_mcbsp_init() being called multiple times.  sysfs node creation
> fails in subsequent calls to omap_mcbsp_init(), which prevents
> the driver from ever successfully probing.  The resulting errors can be
> seen during boot:
>=20
> [    1.749328] sysfs: cannot create duplicate filename '/devices/platform=
/68000000.ocp/49022000.mcbsp/max_tx_thres'
> [    1.759643] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 5.18.0-yocto-=
standard #1
> [    1.767181] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [    1.773498] Workqueue: events_unbound deferred_probe_work_func
> [    1.779449]  unwind_backtrace from show_stack+0x10/0x14
> [    1.784729]  show_stack from sysfs_warn_dup+0x4c/0x60

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -1403,6 +1403,10 @@ static int asoc_mcbsp_probe(struct platform_device=
 *pdev)
>         mcbsp->dev =3D &pdev->dev;
>         platform_set_drvdata(pdev, mcbsp);
>=20
> +       ret =3D sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
> +       if (ret)
> +               return ret;
> +
>         ret =3D omap_mcbsp_init(pdev);
>         if (ret)
>                 return ret;
> @@ -1412,13 +1416,9 @@ static int asoc_mcbsp_probe(struct platform_device=
 *pdev)
>                 omap_mcbsp_dai.capture.formats =3D SNDRV_PCM_FMTBIT_S16_L=
E;
>         }
>=20
> -       ret =3D devm_snd_soc_register_component(&pdev->dev,
> +       return devm_snd_soc_register_component(&pdev->dev,
>                                               &omap_mcbsp_component,
>                                               &omap_mcbsp_dai, 1);
> -       if (ret)
> -               return ret;
> -
> -       return sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
>  }

It's not clear to me how this fixes the problem, your commit message
doesn't mention how?  I was expecting to see more error handling paths
being added to unwind the sysfs allocation, or a conversion to devm.  As
things stand it's not clear to me that the error won't persist in the
case where we defer registering the component.

--GYvOB+ScB/4Az0wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKosngACgkQJNaLcl1U
h9DjFwf/WQifCpq8XeOlBLOAvgI3uxiABxHsqoRqe0WDdqyfOiIgCszt2Z77mioC
FkYGfeIhUiG4PeQENR+LDpKgxL501Is0fRu6G9aRbrYvwRTgkrcA4zNp9nCGRvV/
9KPONBkkWijwTbh63YuEWZphXpj6D0TcLbZumcIDe9eKwTV2+z95rGUckojuiWUD
o47x/z9S/n93HwTPzCqFdeVwA8gAmzXYijiMfTRVwAE58ou1CHTd8oNiNQ6Rf/9X
/dRziXIw6B51hzJH+Q1+18lgkaIrXqpldQ4n45xq5vjI5JEes12ZKK3f+Pyol/u9
wXQfaVFQBQ9WO9pGNO4AEf3gUsAsSA==
=DruB
-----END PGP SIGNATURE-----

--GYvOB+ScB/4Az0wW--
