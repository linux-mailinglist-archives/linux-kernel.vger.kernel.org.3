Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B521747727B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhLPNAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhLPNAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:00:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A1C061574;
        Thu, 16 Dec 2021 05:00:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso1376553wmi.0;
        Thu, 16 Dec 2021 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sRvIW7doKXqI6rhYNOhv8QjoOjQJfFJ2pt+OcCCzfU8=;
        b=HHNt5BWbbSN7iQgL1IxSY2dyTbpfuuOTJd+nwlMaynKzL9Pr49qsLKX50WKeoinb7v
         CODZlzv03cuts3cAnP6MLlI6JCDYL1EGCjjZKuYIoVOKOCG2oCpbEChvD+E10TAYDfkF
         6rh+QtWkJxzHPoOET7ZmiNJhLnxKQjK8IRQTy+8BFse/zqY9nd4K6TzhXvuRErY1yHsq
         plzukotDNSjepgnrBvPYy02vpDAwIh+TOSzIw44AOHr8nKpYWEsploOdS25nCOZbF40x
         GclC6lPII5wBloBKlOu6nqfjow5kJ5xvYp3kds2uOS+a22LSRwY5/aYtsPRjzTbwk6si
         SIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sRvIW7doKXqI6rhYNOhv8QjoOjQJfFJ2pt+OcCCzfU8=;
        b=k4mCHhSrdnYeVLvJBYWjRMsSuFcDUO77yXA+FmQ9c7cLgUPOT10irXfDA4Ri1cdJld
         LAjfScU2HCvD6BQd8i/4pMr/rnJEC7hOsohwtP4UgyXbk3Fl5wwr91isjmgIbgCo49Bc
         rIHNlrTAWSey3Q91fpNHvWKfp/lOgpDc4oXLsRrQp0r919axtQrEuubbMxv/w8hjjAVE
         UyyePi/KH6GFLxCTGpyMnv+M/sKvhA0tgTvtaYr6SQzpafKnBNgmet1Ir5nIx5Tg9dg4
         mCYCKRi3wULasQSW20s/hjbdS79UeJMYY88/qbh20tSe8IHPh9SJtPr0OITlD3Wry2Q2
         zl4w==
X-Gm-Message-State: AOAM531jn3Q3ZpwE8sWloIx1Jkk1VYhZCkreuL2jxqOx9KZmJLaVDDm3
        EFY6SfwOlmKu7Iz62t3Bqo5FHN3jsvLgEA==
X-Google-Smtp-Source: ABdhPJzpa64m0gg+VUlHvNfE9WO8NP83sV16MMQYAolf5J2J2/tcI3cFqqyfnxLtT0rbWP5PckRJxg==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr4887604wml.146.1639659600749;
        Thu, 16 Dec 2021 05:00:00 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id k6sm4299844wmj.16.2021.12.16.04.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 04:59:59 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:59:55 +0100
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
Subject: Re: [PATCH v16 29/40] soc/tegra: fuse: Use resource-managed helpers
Message-ID: <Ybs4S4WMJBhAEWWp@orome>
References: <20211130232347.950-1-digetx@gmail.com>
 <20211130232347.950-30-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZQq/1UzGq+uUb+/w"
Content-Disposition: inline
In-Reply-To: <20211130232347.950-30-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZQq/1UzGq+uUb+/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 02:23:36AM +0300, Dmitry Osipenko wrote:
> Use resource-managed helpers to make code cleaner and more correct,
> properly releasing all resources in case of driver probe error.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c   | 32 ++++++++++++++------------
>  drivers/soc/tegra/fuse/fuse-tegra20.c | 33 ++++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 17 deletions(-)

Ehm... this is very borderline. Adding 31 lines of code isn't exactly
making the code cleaner.

On the other hand I don't care enough to get into an argument, so I've
applied this anyway.

Thierry

--ZQq/1UzGq+uUb+/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7OEkACgkQ3SOs138+
s6EVgw//Q1bJ7UIWESNDxmwd9IN5+l1yqA6koyP2/T9lZI6CZwZSmWcUUSpFP/5W
FrIkEWkLWqBfpCCHSSi3DqBQRffF5XV/+VY/CgF7jkB5e8aQplyBe4NXabp8q2lu
+emE4bjR0Kx4MKewjHp6H+RPRDtatG1YmytnsHChDb/lB2lCTWawoYxjI9FuJLQI
R+x0XMaa6zKM9Df3r3cbUf5vnk+aXUqQJ+CnIRxxHJR2Y+/toDoG1xw3igwQoBSF
+PBJ9p5YrHUhgk3IeS3D7LskY995tCgIjNhT3BlZEDax/m+KlSAVvW1SxrVmDorz
/P4+MIrZc3n21VI8MbB3GYEswiOH28v56uR6fYLidA+SKOhf6GpZ5YfHJCEImdf9
FXsn159vQIuwDAbrxZAW2rXGMJ0Ob9js0+e6F6Ef4gDcvHQVAqjyCzL477yzZzAM
QWG9iGVewC5a8t+XyyUHiUegvFPM3FyM+BCybdFmADW4CBvI9Hm3wAG82YNOuY2b
9gNymg0VeNUxQGu6LmKlgjXJ6H9L/9ecVxdQ4HHEcImotUXXaRheMyig16CF7HQP
C0bqGjndmSWu2BkHYl7LHPF9gYtwYzjhTCHF0kTfLXLwCPrbCwxATChiTvITfPmz
PDsmbJI2R6IygKQgpD39dqYrW8Y4QkyU7AjivlraXC9X31tp/yw=
=b3Ro
-----END PGP SIGNATURE-----

--ZQq/1UzGq+uUb+/w--
