Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEE4A8AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353460AbiBCRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344584AbiBCRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:51:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4DC061753;
        Thu,  3 Feb 2022 09:51:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k13so7571908lfg.9;
        Thu, 03 Feb 2022 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c40bPrHQjIbgf0eWeT2zwsJ4RQU/yT+6ZwMVByjiTgI=;
        b=VlXK0AMpTH0qhx6en1xgTax8rQm7INYcf+/H+QO1D3+gRrPsazrMxrDydLT42k13jh
         nUCmQqMtGq8RLgBi06k6w/dUnZR19gpmfZXQSlch7P780eb9z/F+o96bsjDR+6NiJivn
         FckpEcHjELx1VWq8lM3kw3MKLKlPhZ5IaqC5tNxySysLzAFvekO26FbtyWF8lWov9kYM
         G/+yq3y98JuD/oxPlc3GQ8QE2XbzxD9k4shlm75Fobkqk1JgCiP+WAlKyVNv6edgsacp
         BUknqEdlETyXIkqSGsDSU+9/iectZv7PRWhPqNfd/rfvkEimlfDB9WyFAj8MWAcRb1/Q
         lFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c40bPrHQjIbgf0eWeT2zwsJ4RQU/yT+6ZwMVByjiTgI=;
        b=bJ/57GxL0zxsgEj9H66RG5WgN0fNaxOFgjVj7lHxQtqT5JwChj//Kdl0FN0sGjnJee
         7tPCIjUvw/CZNtPFY+XdW0UB8iFkIRxlccNaYCr+wWu+xdxNIFZB1dCw6SXihABvtSHu
         3wliWMMHfqkM4Lr4O54mJauk+MFsAV3NLeKEm5zh6ZGBLZrinXyjB0DzWlbXEGgT3rYX
         4VIFSn0RIWQrlv2wKIz9TYMFlRJ4DIwcP8MIge4t53p2BwWlB0b2tle49G+DFrVG56K+
         5aV8WV4tiSEUg7QopIjVrJnCNVg260m84IKAlenTUiEByC0djPaGSgXkXmv8iuwLNATH
         m4Lg==
X-Gm-Message-State: AOAM531s1LhmLgM0ZD+pDQ/SICCes3zBS+/H8MnMoUSC8P4ltC4csUfv
        9NlP57hKf0lyNQffxNTUEaI=
X-Google-Smtp-Source: ABdhPJyi9FtMW5FIeWes6Fh5+v4jj6jJF+9c4Bne95ATRab6MsvPKb383kpap7zsh4dEvWwcd9dsBg==
X-Received: by 2002:a05:6512:68e:: with SMTP id t14mr28263542lfe.366.1643910668248;
        Thu, 03 Feb 2022 09:51:08 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id 8sm3857623lfq.200.2022.02.03.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:51:07 -0800 (PST)
Date:   Thu, 3 Feb 2022 18:51:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v16 33/40] soc/tegra: pmc: Enable core domain support for
 Tegra20 and Tegra30
Message-ID: <YfwWCBzuN5q0JGm8@orome>
References: <20211130232347.950-1-digetx@gmail.com>
 <20211130232347.950-34-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8ffx5k3tX5AIfR+/"
Content-Disposition: inline
In-Reply-To: <20211130232347.950-34-digetx@gmail.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8ffx5k3tX5AIfR+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 02:23:40AM +0300, Dmitry Osipenko wrote:
> All device drivers got runtime PM and OPP support. Flip the core domain
> support status for Tegra20 and Tegra30 SoCs.
>=20
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/pmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied now. I'll give it a few days in linux-next and will then send a
PR with this for ARM SoC.

Thierry

--8ffx5k3tX5AIfR+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmH8FggACgkQ3SOs138+
s6FO5w//cPW87rvUKeQQiBIG3MKYHivxZPlxXlkfRG5W+Y9oMFE5HyfE03v28G1S
qcGQX+fjbKaISc+4hOem3NaDKKlpItUVQUD8akNUSHoZLX3SYrNQ/v4ZNqRKjrGg
bkZTolF7BsabsFq84dlnpUJN6JPIdHaaaPiq2btwqSf1ubAW9JgA613VYHlG/+me
mVkYI84z2K2kvOevWtk44pubJmfPPea53g4MP2TFtXYtK7NvdX+VWpG89ZazJmUq
cGJpNrtIDmjL/aYbmxWi0nQvv3JKp4aO2MvjMvV4ZEcl25VccIP4a9NuJXj3kCe3
P62k+Yv1DJWkTOpSXx7NfzAl3iTkx7hTx6WlNBZDD9uanine+ZGmRZNR17q84zN/
CJstSdhkyfhWtddP8JV/SEODRUXk936eAk8cQTNPUDtvCGu1Xr43QoYXCFGxpeD6
MUUeRYyVQDuCo2UmeVqNNXS/5kvyTlE/Qr4xKmw+hLe0fZOVSAUt9o8kqRV6NkMq
wqremWTw1FmAYzJnsgfDRnY5SlPeCJFBPxH+LkXDzEOsAmIMYeYi0qykqGGkwPQA
BYOWaXKMggviplovauBvfRKTVCsKnnxgeRDbcwNX8Dn/uwwH4tHHQjzB7A7domEB
RJkbnuYFInpC7nNrtcT1QedT+G7nVsDLwqW3f682nUcDnq9DYxs=
=IVU8
-----END PGP SIGNATURE-----

--8ffx5k3tX5AIfR+/--
