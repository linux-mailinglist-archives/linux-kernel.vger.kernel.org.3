Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B54F63C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiDFPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiDFPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:43:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74281C3164;
        Wed,  6 Apr 2022 05:59:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so3046045wrc.13;
        Wed, 06 Apr 2022 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKbluJ9oRbV4IzOTY69trizh7tqvmPKxd4J/L2rG+nI=;
        b=P0x6pqt8WbboX3Y1Pi4vFYM/6OKvCijMRDM3Vwkq89j9xj8QTT3R/NjqayAG1zJbo2
         HfzSfxnjsLtQS9RpsQEGJ3ovGq8rXMsYhbRIMx/kQNcToNnQ5PLh5kQLKWH30Wj3/iZO
         O1X13b5X/RyHM6JCoEWpTDimQzZQPtLbUC0H7wKKJwq/sXnZIlV+uFASPf6bbupKe0S+
         /dDursx8MZUdNBBmh9+6WynHA1HwE3ixFFXwU3K0MZFL8yK4xZ86NcS3GZb8Sw+Rgtwd
         gCgFiWae41xfCOcRJ1VJQANeZoraD2/sStgFY2zOsG8XBmGv3GeO01wvdMi8KBL8WsLn
         ZXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKbluJ9oRbV4IzOTY69trizh7tqvmPKxd4J/L2rG+nI=;
        b=lDFn7xjdODTFgRdQsJWufR+L9Kd7UND58R24Gu8V7xnsgOC9SzenBXYPGgo9fPGoev
         g6HNTIXE/KQLwW8me8oCXsC98Tk4W0Oc2h3YgpJfnEOL9SgB1aLQWBHC+afyKJA75igh
         C18AmPvi3UCA6z9QYWTSzXgGFJPmwXJMKSpZUP8G2LimUtQSBvpVX6TfOoAp/Q1AMKZn
         2jz9yp71Ec77zujPLWeANt2qGbNm0qy40jFUVtQCpBspy6v4jfSawiZrnj2Pbldv29I3
         KoIeT+mrmEU4U09v+rl/KhvJ7egr++zV1lFtRz4ZJkZE0ClplFerbpyyd4SG3X7aR5Jn
         +10Q==
X-Gm-Message-State: AOAM533YmXNDPZqUH4WAOiGl19hQPFttcfsqwQDX1b3Y9I1Btf6YONib
        0jTDUpnXLWpy0RqDJZeeKLU=
X-Google-Smtp-Source: ABdhPJyoXsbMi9rvSVSNemi3NQF4PH7yNOVWoEhFZN9luwp5ynOblzVSGl2nh+NtaZRzWvWsr84eFQ==
X-Received: by 2002:a5d:628c:0:b0:206:e8b:d4ea with SMTP id k12-20020a5d628c000000b002060e8bd4eamr6533204wru.675.1649249998233;
        Wed, 06 Apr 2022 05:59:58 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm15175843wri.4.2022.04.06.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:59:56 -0700 (PDT)
Date:   Wed, 6 Apr 2022 14:59:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sagar Kamble <skamble@nvidia.com>
Cc:     jonathanh@nvidia.com, digetx@gmail.com, yangyingliang@huawei.com,
        ndesaulniers@google.com, pshete@nvidia.com, nathan@kernel.org,
        kkartik@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] soc/tegra: fuse: Add nvmem cell lookup entries for
 tegra194
Message-ID: <Yk2Oyt/8nyIiXAUp@orome>
References: <1648123728-16737-1-git-send-email-skamble@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fb8UKwPtxs0r3Jfw"
Content-Disposition: inline
In-Reply-To: <1648123728-16737-1-git-send-email-skamble@nvidia.com>
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


--fb8UKwPtxs0r3Jfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2022 at 05:38:48PM +0530, Sagar Kamble wrote:
> Add nvmem cell lookup entries for below fuse cells:
>  - gcplex-config-fuse
>  - pdi0
>  - pdi1
>=20
> Also include the device name prefix "gpu-" in the names of the gpu fuse
> cells in nvmem_cell_info.
>=20
> Signed-off-by: Sagar Kamble <skamble@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c   |  8 ++++----
>  drivers/soc/tegra/fuse/fuse-tegra30.c | 17 ++++++++++++++++-
>  2 files changed, 20 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--fb8UKwPtxs0r3Jfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJNjsoACgkQ3SOs138+
s6F1sxAAhIJvgEn1IJfP6Zem11DQRMrS9o6IzvY0fCXHQlnL9j3laM0YQGUbPkvv
rnahGW7J/Sh7qBNy7+g2VpxowWz9qTuW+73zD+dRu6aQLZe6gWgqSLXKhw9hLfcj
kAbc2qirNTqEki/JjMBwyh9XgrH+5pS7eholS03+aW8qZx4S3wPFl1V2YBLELp46
iPiiboF/7C8SqUgfdHUO5kC5Ac+BWpqcopBk2Xuh7+scO1VgGck5Hdja1tWoidoZ
QZ/9oG++hQP8yqFCGzneIiHaGHyofwT9i4SWlyiOfO+iiIPm5mm4Gd/34/4+6Lnp
5PiRH+qUMi+WBTU6enS99KIpPwu6DTStbSvGyEppapqJu3JiIoUMxGsN3o4SedEu
R2bcrOqXzP4Oa1kegaWsFE13NKDFLODMDdDKYg7PUuGj4s8NSDL6mCTsC/XqvVXe
TenKO5d1y3VEIYWKWYRfMYBJGGZT4qLofF695TqOE6NJ7L5eEVU8yg2Qdx25x58W
/5P5Kpbnsqa1h1SN1yL77XTgJroehXzD+vOkRqp5XZ0/FbRzmU2z758I0WZuDkyd
Vr8K2QRVZF1bROaVWAgoNC358Pe7N7eqjN6kz1Mz99WP7ENm6Yo8dRjvQpsMiBA8
pgdvfj8Uu9UhX+PgsoDeNe77q4UK5wlPqbzT4yI2KP4IYPggPy0=
=b689
-----END PGP SIGNATURE-----

--fb8UKwPtxs0r3Jfw--
