Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764EC4C46DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiBYNra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiBYNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:47:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D33E40E4A;
        Fri, 25 Feb 2022 05:46:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so1708587wml.3;
        Fri, 25 Feb 2022 05:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WOJDawq4UDbuTj1KJIDLM/jMOXSHv7p8EKE/sG/KKz4=;
        b=m8MYoDvvDvREAkO3wGE+9kmU/6N48Gb8khl9XPXk5O6MghtnOMfqjmzVlSuKTF+E/4
         t0Ea3BgebQXkcOHIENHCSRrGLk2C4N3q9DOnkxVD1cMmVP03BOIsx50aqfxw8Pqkmk/l
         gaeu6LCeCoi1WM6Gfgv+pTZjg9+JEXf/nET+KDKLdlaaPOPqQb0Sk90gGziWd4+OC2ba
         6vMvhdbExhPhrGrKczjvFnsRmEjbBT9hJY5QQbLQEhjEShWl6oibmp2pXwGIm3KdGn+W
         bTR1sJypb4YN9NjCIUVOd644rvV8qlLhsARi4cCwsUs0ch/N2/cCOxbtx3JyGQuDtG57
         vAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOJDawq4UDbuTj1KJIDLM/jMOXSHv7p8EKE/sG/KKz4=;
        b=1yEdjwD2A2O/oE34R9ibZXVKa3RIA/SBtLglkZm81F6nsqV7OWH9lWrWLBq5EJj5nq
         EddDum6YogMGDXwuPzcJTFqHnO55HzePBOGvxWCf6mnFVVZvOJ/g5U/HBXnQzq/W3P3u
         Qw1WkuHMex6Q4UaAVmjsGE8aV7bCZ+qDiNqCBPXwwfjsfCzhWB/tme8vcAEi8o4VhSAB
         qJVx5PDdwJBHtwKJL/mRiwLnLl+bq+1VOSZiDzefo9AZfTfh1vBCJufvAvrdjAEbDVbr
         FOh5g1YqofbFDEm+DZ+KJGo2hA6WvC5k2cAqkghQlIfQ4VZnS0Qc2wLuWrp3wpbvdX6U
         YKnQ==
X-Gm-Message-State: AOAM533Br5yujm98/ZcaXxcnrPmzvUZgvh2cp8IJtL/LiyyVEPR04RxN
        DUvkSo5dE4HOySAzbl9XKsI=
X-Google-Smtp-Source: ABdhPJyWomoCRJMSMC6pFRaLjTLNDleYv44mHjL3o7g8/yIrnOR8RMVvw1KQdtpLA/x53shX8Gj7ew==
X-Received: by 2002:a05:600c:1e8a:b0:37f:deb2:6aec with SMTP id be10-20020a05600c1e8a00b0037fdeb26aecmr2801976wmb.86.1645796810049;
        Fri, 25 Feb 2022 05:46:50 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c3b8f00b0037bc64fbd17sm6196397wms.11.2022.02.25.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:46:49 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:46:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     richard.leitner@linux.dev
Cc:     richard.leitner@skidata.com, Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: tegra: tamonten: Fix I2C3 pad setting
Message-ID: <Yhjdx49OcmfqipxV@orome>
References: <20211201161148.238263-1-richard.leitner@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AxXtD6Dj3Z4zzjbO"
Content-Disposition: inline
In-Reply-To: <20211201161148.238263-1-richard.leitner@linux.dev>
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


--AxXtD6Dj3Z4zzjbO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 05:11:48PM +0100, richard.leitner@linux.dev wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
>=20
> This patch fixes the tristate configuration for i2c3 function assigned
> to the dtf pins on the Tamonten Tegra20 SoM.
>=20
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  arch/arm/boot/dts/tegra20-tamonten.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This fell through the cracks for last cycle. Applied now, thanks.

Thierry

--AxXtD6Dj3Z4zzjbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY3ccACgkQ3SOs138+
s6HnTA//c25d7M3OmIF12IRyNITho0et8saGGqV9u8LhkDG6QYMxspuvEwVLJNUO
o5xJsEeM2RF23H/crRQ56+Fk5bV/xhdkYPJWau98AHPbYG626eUvyIKvKaIW5s4B
HtufuoJRKg+2riMkyNkLdrl6Eka0MZjpwawiBsk23fWQrNotxFgrHXEulD4c27so
m1aD3u2VrYPZ0mIDNHrd4NW+yhPI1SYxERJoqwQBq5c6PVO7/JcMt9bJkYHVdGDN
FHbjy3DoHukv9pj8RtAnk9gR5j60bqT+1CNdelxsZ1FW4wr5A73CP/EdP918YgK1
mOJqDlZU0yFPUZOCf4D+Ag6ttlsykhxtxWuYae+WjtWhKOodjoAvo5ioWBKu1PJ8
rqYPABbudsRO6IIHCLdPx91BvaLOcKeOAyVP/dAJHmgAqEXLNOqq9UO8tdaQApnn
AdItCp3ALGSeUy9bXd9wQgIzg2+ia3EneRrzgeU9aS5YE8BZCy8IfoGVIUN1ONOm
Ii6TNVRoz43tQE3l8KuW6fgjRVlD/KJsgXYZqu7cIkDfynf1ksIv0YYYjbF/pEsI
K77k/COeGAEeC0OslSMxKLtxwT1g6Tfg4JRCIE4XrOPC0jZEcsR1l4bxQwRgQe38
c5/bTGJX2m2/95ynLnpKGWaOyGzXeorqLnyZTR6AwP7sDEAFgIo=
=O1Ys
-----END PGP SIGNATURE-----

--AxXtD6Dj3Z4zzjbO--
