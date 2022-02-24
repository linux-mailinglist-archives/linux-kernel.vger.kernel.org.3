Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668BF4C2BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiBXMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiBXMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:42:23 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4A7EDAA;
        Thu, 24 Feb 2022 04:41:52 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so2656131lju.4;
        Thu, 24 Feb 2022 04:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E5f8dBX9uhibFNXc6Mel3BGvbrzQlLZqBC/+F9B6bsQ=;
        b=CBBYk42iKlTLvyHt5Xq2ne+Y0e3NUaMKxkDJol/Ow7dWi+5ZYXMcvM9MdQK73/NORp
         T+BOY3vS9a2hi11zs635mbkkRppxjdt/dg+Bdg9ArhX4+rU77Jw9pFIV2ibqQ8USy9xS
         qtiT3jgd3eiMwgJX6quH+RmSRvAsKwkwZhs4PIMdZD+YyF1QrR9Ky5rv0NUwHvdIiPue
         ZCKE5eJ2gef7FuFM2Aw9+xympbHTikCZezopD/yoeQXNC/8o+KtjhRY3tHYrMZ9AxR8e
         EdfiaPKqmc2vVfOm0GsHJyw54yC8x1uBleNJRyfRsWIbsQ0UO1+VXpZaul59L01GAWfP
         +45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E5f8dBX9uhibFNXc6Mel3BGvbrzQlLZqBC/+F9B6bsQ=;
        b=m7PHEYmJSnYkIgIirsIij5zi9kiDH41b3t47j9/2LzmNmmIbr6Q5+Y8xGKOxlJN1+j
         O20WtY/E8f07qEs2Sag/XEnmOoneFdUzfkvoTAfo6UHyznkwVU1cLNVDEacd+e+UeVje
         2d25LYvCYC/3ZIz87tkKYhjM7H40ucz882IorIAbikQDp0N38PFlhlRf+G81kDIOgU+z
         9r1grSJSX/njwyqdkbrAk0KGmFX+MkAEnmrBC1eSLpKHGVPv9pRrZgf2fsMueF+4Z0Zx
         Y5s/YQloURUSrpRJ51Dwrfkp3Yk9lz2QjH0cr4u+Y452IvY8kw2cdZGOqiuA52DpdEbe
         hLvg==
X-Gm-Message-State: AOAM532uW930Qt0LEGgXM1gwgXQ5L72PLlpPhaEP4fbrvPm9uuJMriVf
        vfY9/O51DjNh7ojPSdkBHmw=
X-Google-Smtp-Source: ABdhPJyCMH/RlCAdlrNo3h6tSANXMSZcYbwRf4yH6eMeEeqgfqSEBkyLJXNTX8aJ9hmjt8Se3GKG3A==
X-Received: by 2002:a2e:8795:0:b0:246:485b:9a2f with SMTP id n21-20020a2e8795000000b00246485b9a2fmr1882695lji.283.1645706510643;
        Thu, 24 Feb 2022 04:41:50 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id p3sm199599lfr.179.2022.02.24.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 04:41:49 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:41:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic
 pwm schema
Message-ID: <Yhd9CjAbI7MJu56L@orome>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QoKhDQpat5OJfaIh"
Content-Disposition: inline
In-Reply-To: <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
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


--QoKhDQpat5OJfaIh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 09:19:13AM +0100, Krzysztof Kozlowski wrote:
> Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
> the old name in bindings as deprecated.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml          | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--QoKhDQpat5OJfaIh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXfQoACgkQ3SOs138+
s6Hy0hAAjDWtz6200YMgIRd4aeQNFbETpimnMUmcjdEmd6wj3sRaVpeNuUPuL+Fw
gSyLLpv9GSqgrr6JxAAMgULmUciu+l1+mC1DePxqw/xUOvY8pR5fCugKBDFT42ie
7A1D7I+5hGVgNihA/IV9Ia29GcjEA3Hwb1v9JOtuzYZw8ds/G9SDXUyAUCaIlOJk
9Rfk2JKCcq8/eKE/SM5NWUPWncIekGnmovibZ8JlcwyrOkkyRZp5nZ+NgK7u17SJ
Ybo2hJX5g/ZxWxGNu707jCsIoSrfwexKVWBDYVwTFGHKzsT05N75Z28pTbpmsPoj
ZYsck1jN1rYmBVLoW9kYy0+kb7Hx3982BTQv8f0Yt72fy1ijwCLfYaXcekCw3sge
IvBrZIaIzyy+bjKNFJwmdXY03rang2bbeBUmCNtWu+EP+Z3TkIyk3ZoTD6RQs/Pr
9KP7XPRAhqk7Ch0xpLxmFfNarAy14ydyz9vDKxAd4f2Dt9qhTYV0k1OV2CMEARbh
g9hCdAAF0OaOkUEa1G58nkKeS4mcQfLN3mR1OsGijYdkgqXw9WMn1KCmblrHfQAj
12siFOxkWcjU3sQRpnBpiHm7qnxShKST6Rgb6t2IrsMizUaP6es8my0rrFAMy81Y
748NAi0Oyz39/Vft51iRggSYY5G4d1c/NiPzuAro4LSKVgY/q6s=
=jFME
-----END PGP SIGNATURE-----

--QoKhDQpat5OJfaIh--
