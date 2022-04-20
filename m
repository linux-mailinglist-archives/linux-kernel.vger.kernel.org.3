Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB166508C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354915AbiDTP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354866AbiDTP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:28:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D914349B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:25:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u18so2770897eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jc0J+GRuK0RHzVpyT/qJhxhKSe6IYaD0IozWZB6ybTA=;
        b=EiL4ORlCE+wRptxMWfVp6CJW/RObzSYdXH/9cwu+iIW11/YMojO5GWcCiZTYA13V9u
         MQWrblyLf4+HUUDZQTudrtIci5C64D8x4n4JTb04+RJHI0L0SfHV6t0kELGPig0RwnFe
         VExoOdyNGzrvk7B9dILNH1p8jAp3i2dOwCuWxNnaefSuXNRso5xlj4WWRelGh3jMDB38
         zzovm742GjmfdOhzs1ovVppRfaYEkBQ+MbHfV/UgxCNDPygkzFOsYko7FOKtpdd+u6lw
         LMR7mzmjTvxaR304rAm2BZ+OD+eppKye+3boYuyEGt67H72dok/P30Ds1tulGlvJlLjt
         HZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jc0J+GRuK0RHzVpyT/qJhxhKSe6IYaD0IozWZB6ybTA=;
        b=YDYOpUCevwImVlRzH9wzk9UHdm3KcBu8tEgCMkbod2H2iBtKlQki/IcuqCvR4b9ee+
         dkcGHs6NALlOhiyVq6m4lnj5aUWzbMNcAUIyFnP5IedGF8TxZBX5Wd4h7oA7px6uE5iN
         3Dmy4C8dmgy8KNmInkanp9N+W7i/LMZ+axktL+Q1K7LixGyeNVG7+nYcgOGznsFd4+iW
         EWNmlelmbqMbKRuj5U5pcECV/iT/OgISIv36f9E6o0HtDrvtWDgsp/oXxpjr3b9nDXW8
         JRAXBV6Jwu04BenJ1xEsOY5s5e8AEP/zji62vIu45vG1izFTVxis5jFgrWmAzQEIg2Kj
         E3zw==
X-Gm-Message-State: AOAM532Gm6DnwmIwOtfr/wmajPI/ifJvyUfGAOXp9OIfa03UfIegXsWe
        +DWUNvCFNmxEyfKoqpgiehM=
X-Google-Smtp-Source: ABdhPJwu1OX4s+SauTj29pYv5bx0er4e/4J7RCmOTFAd+sQMtXZzg1GnPqoKjBMF1HA/mnfGJ3xhrg==
X-Received: by 2002:a05:6402:2789:b0:423:fe09:c252 with SMTP id b9-20020a056402278900b00423fe09c252mr10286417ede.11.1650468339361;
        Wed, 20 Apr 2022 08:25:39 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm10415758edb.47.2022.04.20.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:25:38 -0700 (PDT)
Date:   Wed, 20 Apr 2022 17:25:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drm: of: Improve error handling in bridge/panel detection
Message-ID: <YmAl78qAMAe4bTfk@orome>
References: <20220407093408.1478769-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l/mPNCZ3ZxnPNUQC"
Content-Disposition: inline
In-Reply-To: <20220407093408.1478769-1-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l/mPNCZ3ZxnPNUQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 11:34:08AM +0200, Paul Kocialkowski wrote:
> With the previous rework of drm_of_find_panel_or_bridge only
> -EPROBE_DEFER is returned while previous behavior allowed -ENODEV
> to be returned when the port/endpoint is either missing or unavailable.
>=20
> Make the default return code of the function -ENODEV to handle this and
> only return -EPROBE_DEFER in find_panel_or_bridge when the of device is
> available but not yet registered. Also return the error code whenever
> the remote node exists to avoid checking for child nodes.
>=20
> Checking child nodes could result in -EPROBE_DEFER returned by
> find_panel_or_bridge with an unrelated child node that would overwrite
> a legitimate -ENODEV from find_panel_or_bridge if the remote node from
> the of graph is unavailable. This happens because find_panel_or_bridge
> has no way to distinguish between a legitimate panel/bridge node that
> isn't yet registered and an unrelated node.
>=20
> Add comments around to clarify this behavior.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Fixes: 67bae5f28c89 ("drm: of: Properly try all possible cases for bridge=
/panel detection")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
>=20
> ---
>  drivers/gpu/drm/drm_of.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

This also fixes the regression that I was seeing on Tegra.

Tested-by: Thierry Reding <treding@nvidia.com>

--l/mPNCZ3ZxnPNUQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJgJe8ACgkQ3SOs138+
s6FQoRAAk2q7FwnQXxVcdMauYYi2tWDLXHS7GMdfe9U6+8oTCErYTcpYkV+XY/Pk
mrWUTaKMmKTHeymTLuU3W3bh4bELRDV1I1rv+4KgX6qvqWqmM2pq0ZYQA+QQgI65
vkwSFeoM//C7Oe5Os1KbGFR9QxpRGV4KCdCiALrscal2rsYBkwojZN77ejJI6oeH
rCP/Qr9j2w9lqSJKAkqMtbfA10S9e61MBmSV2M9PVja9REvcpL08LluYmjUlf6Ea
mQxFwcRTWlxzyNQio1gF1mKyXrb/be/+pbdutE2Lr/uBOp/M+Hv5Mq5GinogGOZp
AQax66fsbbT8mpFTQvIvOCI6EfvYzKTlmGWeoD5R+m6UpPpGS56VPLPyFOC7ibvU
kMQqHBCy2grG2U3lC7LUmem+xjsR6m/9UzSBEToFDD5zdk9EL45p40UutgGE7nlH
hjYsHnPmnQ4hF6bLPeY1KtJiRzHrafCyDcBuEe7j0MOHBNc+WuAZtNt/jL5p1FTr
77+RTv27qFk4ESpW7JRYTr0nZZlnlOQ4pcSVeh0Htkqh/Yuj2JYJcw8+6aBeNC+H
AUAI6drVbaaLViOOxxyCPZWZXA711Up1dZerRieBCPPYRJ6eKRvjc/De/+H+yPuk
R7RbUQuoQuDGn+4mTAi3WPek2qQalZ+ovmvV88iFH/Cs+eZZbGQ=
=pKal
-----END PGP SIGNATURE-----

--l/mPNCZ3ZxnPNUQC--
