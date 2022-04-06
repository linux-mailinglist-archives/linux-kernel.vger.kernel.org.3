Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4254F6447
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiDFQA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiDFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B52264821;
        Wed,  6 Apr 2022 06:28:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p15so4259470ejc.7;
        Wed, 06 Apr 2022 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y+tMzJEriSaWDDcS/F97k/mKlm0p04jeY+Q3bPtBnbk=;
        b=iJVjuq+iWz3a2mcUFxIo/n1DF1fY3FekGsrCqZYTm1GZ/mjgZ/KSlZprH2CpSqCKaT
         F1NDl4m8Qven6W/xgwoEMrRrEppoiQI7UF+Qmgxa0wOO4CxhN/G+DPe1RgLKxXoCrf+0
         ThxzXGl81Ab+IIMu8i8EnIBvA49M4tychCTE6VGDLdHGm5nZnay86zRR4AWymdkxR0tB
         tlAfFZ3JfUbiI2f3x1cuKk5ohFfdz7Yaf02OzdJ/nzRP+UijrouGxYIrgleJ1jdomQrU
         /RhVfsg5CtCoQ2xvUNzzJPORQvKqUFifcj6qvJ8Ypub5UCtn7BB3m8QIgIy4roENN/24
         TFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y+tMzJEriSaWDDcS/F97k/mKlm0p04jeY+Q3bPtBnbk=;
        b=KCiTvIpqJI6q5zcQkOE3h+5ZxWqNzq6OtXdNGTx3i29hYKnAxvX0NMQVhm50xjVZ9z
         sQeoL+Dgm2KPR5w1WLpo6mJBsWLpImV6+P5244WGVR91JjXJdJsiZeaa4FfaBv1NHOnS
         iKJD7UUuw6medDrW/emBrZxLmS6n4DpGeLMEL6lqSwZhwDroq6MdumGzJzk8pbPNv3IJ
         +2ndbjwHwF8TLqvtIKPkvhv/b20rhB3wcp1VaPGAAFdGt0+cgMSZLsVpSuKo0X0XKkDo
         leasBeDRGIvDcOXLo9ev0MuaUidC86pe3ZMovgJUfP/uH687VnSlHMFu1AYKGEbHXzeX
         1sJw==
X-Gm-Message-State: AOAM530zxTB4eTkxBP9+W0ndxX6BFeeFo3HKgCbF4MtcRn9+c8VnkZGh
        MqOfdq0dxW7n7AmskD1GKXS0X9rHShM=
X-Google-Smtp-Source: ABdhPJwvZypJzouKpw2/wIKDrN9EweIIWpIu2XksEb6Oidd5j1g7WZrjsw/FptflpTIzTNh8q8X91g==
X-Received: by 2002:a17:906:6a17:b0:6e1:13c3:e35c with SMTP id qw23-20020a1709066a1700b006e113c3e35cmr8577584ejc.760.1649251723343;
        Wed, 06 Apr 2022 06:28:43 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id rl16-20020a170907217000b006e4c1027beasm6485248ejb.55.2022.04.06.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:28:42 -0700 (PDT)
Date:   Wed, 6 Apr 2022 15:28:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        ashishsingha@nvidia.com, skomatineni@nvidia.com,
        ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v4] arm64: tegra: Add QSPI controllers on Tegra234
Message-ID: <Yk2VhxRrGfc1iSna@orome>
References: <20220308183026.66394-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qe6MpwpcFGIU3aX3"
Content-Disposition: inline
In-Reply-To: <20220308183026.66394-1-kyarlagadda@nvidia.com>
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


--Qe6MpwpcFGIU3aX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2022 at 12:00:26AM +0530, Krishna Yarlagadda wrote:
> From: Ashish Singhal <ashishsingha@nvidia.com>
>=20
> This adds the QSPI controllers on the Tegra234 SoC and populates the
> SPI NOR flash device for the Jetson AGX Orin platform.
>=20
> Signed-off-by: Ashish Singhal <ashishsingha@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
> v4:
> sort definitions in include and dt files
>=20
>  .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 12 ++++++++
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 28 +++++++++++++++++++
>  include/dt-bindings/clock/tegra234-clock.h    |  8 ++++++
>  include/dt-bindings/reset/tegra234-reset.h    |  2 ++
>  4 files changed, 50 insertions(+)

Applied, thanks. I may need to split this up at a later point if there
are conflicts in those include/dt-bindings files. Next time, please send
these kinds of changes as two separate patches: 1) dt-bindings include
changes and 2) DT changes.

Thierry

--Qe6MpwpcFGIU3aX3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJNlYcACgkQ3SOs138+
s6FUxQ//eIRRaT4pW8HjD9kPvjwpFobCTv4eNE/psSq5/aZyWVuTATTVuIoPWMbr
i13/VAY4S5SiQxjP8XkVFT0wqu5gm66acKjN1aAdA5NUiU9Za5J0TSTCY+cRdi9r
TqM9m7RXJt3kyzd2XKPXVEwIF7kn1BrRmpXt+31+Mi49xjXRBREWdrfhXgDGs4vg
bJly/l+JRI4FqwUf1gPUV0GtS/tJV/xDW3YlOt11vbbc+8L52yjl7ug8rLA0y2S0
c4KAT1F6EUVvjR9uAVtuI+5wiT9r7dAkF3G0anbys7aACWoPsb2VI+3eRVjZkd8p
8GNlcBoFlxUiQyIA3uqVD/SDVEZbzQkenTyajihS50ZmZ4VNR0M/JlEIubOXn57j
Jzuwr8oizILXDotRoZS0UpXCN8upMyH2cKZzlegUzsH6Xur0Tg/LJO8oCrnNgiX6
u8liE2k3zW3yFty+7uSEwIhGclmx+/5jyCkxTX219fdF9Kr/rGk5Hs5D1vyQpSFS
HvA5fCBtR091I5e1lNzj3IvwCL5ghwSKBqsBG59kajHLadbc627j855De8hOL48n
e+82ur15D7iVU6aIsOelnulkBHmlhkzmIBk37jyQwQChQnB0FrU03Mmel0Jjabb4
pztgygMS8M3RkxP2Zhg0ZIjs6dKsCpurjVneHokuYJF51uTlgMk=
=LOcs
-----END PGP SIGNATURE-----

--Qe6MpwpcFGIU3aX3--
