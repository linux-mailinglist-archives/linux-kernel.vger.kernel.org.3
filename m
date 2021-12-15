Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF23475BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbhLOPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbhLOPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:19:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3BC061574;
        Wed, 15 Dec 2021 07:19:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso18752664wml.1;
        Wed, 15 Dec 2021 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZHOedxMgCeGLCUDZm6mjDrIj4D4tIu8hqn1Os+H7C8=;
        b=Genqt2/LMR7roaPGgIO7ChGlNRU5FTpnbd0fXp8jUhkrqMTDdt1CDmjf4fMuG+5Kek
         uAzF3tPpR4eBkRP7FBlkKwV0pBfvnKiukJxAeuGWLQe9aI6BURBPLMXE/X3vsv5qiI0C
         BHqllhcylD07Dka32pkA+9u76zLXrJOUb6+ruLqR1P3gTZmPHfC7UuI7BfndsgsKNEr/
         195uAIlupKhL+j1y8fIRUzFs+3KSjiJ6ri6veoHZnJTSRxRQoBVn4QuCs15PxLP8EUih
         QxFVyQyCqGvUWTZuPEJjoWD8fwIx+FbBSne/PL3gj3M5vNNizu5zp94RnWoyWNrDwncN
         CUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZHOedxMgCeGLCUDZm6mjDrIj4D4tIu8hqn1Os+H7C8=;
        b=drW1Zl1BIo1ngfg+ZLW+TSniUkp+QOOCKE/xxIMoVHiAVOWERzpD8R8kMlxKNSz7TJ
         b5tPl1tWLGSbJEDP9aRc7pJGnr7m1jeehOlFnPZ8fsb8Qc4wyfwyc6mKw7u6HOsphBvU
         tLMiYC/qPtxSVTYYe53E3AGDwjNVzoBvEu+d2FkLF6jILIdCT0AdQhJtVHK43wnR291M
         mTuUPf5nmyRpPQeX7vu84pmt29kSDsmZhanu6Vh+TGcXzXd/uvHdS8v5EBy3KhpUqKAe
         vMfrVWot/b/8WOzcHiydcyRrV4NSMYqhvIKFQn/YSL4k/lYhVYq7Qqumff58IUm98nz8
         0LWA==
X-Gm-Message-State: AOAM530etAsP0qP1TrNGr1/Q4u0a/cwj3eduqpkUPUPEf7fB8BVlM1GP
        2oBgDN60aWqpGcsGXJr9dtY=
X-Google-Smtp-Source: ABdhPJx9Ix/Ow7uC2/FizTS758EXx0yBXdMjt+miiZcyAqAaDE287YFOGiCJFYVRg1BOMimDuz8Tkg==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr230316wmj.179.1639581564226;
        Wed, 15 Dec 2021 07:19:24 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id m34sm5514766wms.25.2021.12.15.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:19:23 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:19:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/28] ARM: tegra: Add device-tree for ASUS
 Transformer Infinity TF700T
Message-ID: <YboHd6tIUrl+LJQb@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-12-digetx@gmail.com>
 <Ybn1Ne2aGfsablwQ@orome>
 <02d7e9a9-6999-cccd-aea2-d069c759cd56@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="icIo6y0Y+9SyroLX"
Content-Disposition: inline
In-Reply-To: <02d7e9a9-6999-cccd-aea2-d069c759cd56@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--icIo6y0Y+9SyroLX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 05:52:24PM +0300, Dmitry Osipenko wrote:
> 15.12.2021 17:01, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Dec 12, 2021 at 12:13:55AM +0300, Dmitry Osipenko wrote:
> > [...]
> >> +		i2c@1 {
> >> +			reg =3D <1>;
> >> +			#address-cells =3D <1>;
> >> +			#size-cells =3D <0>;
> >> +
> >> +			dsi-bridge@7 {
> >> +				compatible =3D "toshiba,tc358768";
> >> +				reg =3D <0x7>;
> >> +
> >> +				#address-cells =3D <1>;
> >> +				#size-cells =3D <0>;
> >> +
> >> +				clocks =3D <&tc358768_osc>;
> >> +				clock-names =3D "refclk";
> >> +
> >> +				reset-gpios =3D <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
> >> +
> >> +				vddc-supply =3D <&vdd_1v2_mipi>;
> >> +				vddio-supply =3D <&vdd_1v8_vio>;
> >> +				vddmipi-supply =3D <&vdd_1v2_mipi>;
> >> +
> >> +				ports {
> >> +					#address-cells =3D <1>;
> >> +					#size-cells =3D <0>;
> >> +
> >> +					port@0 {
> >> +						reg =3D <0>;
> >> +
> >> +						bridge_input: endpoint {
> >> +							remote-endpoint =3D <&dpi_output>;
> >> +							data-lines =3D <24>;
> >> +						};
> >> +					};
> >> +
> >> +					port@1 {
> >> +						reg =3D <1>;
> >> +
> >> +						bridge_output: endpoint {
> >> +							remote-endpoint =3D <&panel_input>;
> >> +						};
> >> +					};
> >> +				};
> >> +
> >> +				/*
> >> +				 * Panasonic VVX10F004B00 or HYDIS HV101WU1-1E1
> >> +				 * LCD SuperIPS+ Full HD panel.
> >> +				 */
> >> +				panel@1 {
> >> +					compatible =3D "panasonic,vvx10f004b00";
> >> +					reg =3D <1>;
> >> +
> >> +					power-supply =3D <&vdd_pnl>;
> >> +					backlight =3D <&backlight>;
> >> +
> >> +					port {
> >> +						panel_input: endpoint {
> >> +							remote-endpoint =3D <&bridge_output>;
> >> +						};
> >> +					};
> >> +				};
> >=20
> > make dtbs_check complains about this and says that panel@1 (as well as
> > #address-cells and #size-cells) are not allowed here. And indeed the
> > binding for the Toshiba bridge doesn't mention them here.
> >=20
> > Do we need this here or should this be moved to the top level to fix
> > those warnings? I guess what you're doing above is describe a DSI bus
> > created by the DSI bridge, which also makes sense, so another
> > alternative would be to fix up the binding and let it accept those
> > properties.
>=20
> Toshiba bridge binding is incomplete. David has patch for that [1], I
> don't think that it was sent out yet.
>=20
> [1]
> https://github.com/okias/linux/commit/0875230062294b6db17f395ced0a8384a4c=
1cfc7

Okay, please make sure this finds its way upstream eventually. That
patch looks quite similar to what I tried to do to fix this up locally.

Thierry

--icIo6y0Y+9SyroLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6B3YACgkQ3SOs138+
s6Gxtw//aCvOf0bKYvoVKs4ZCTS+T/XQeMyl3xrlo066OnC/8FgVPWQBxCWdpg6F
w0cDvawYI5tNIb+X4BGzTiD7HMySlaLhxm+UHhBg6CF/LbMIi4b5iY1QI/6djQhW
98bosskqCFmL00X5NlYZClfloYh2N8XuVXWujQtFzH0H4uuTfAxCidHwEibkynbO
TAuqMWZR9W4IqX5lzaCdsyr2Eb6VZ94TiYskuBouICCUjNLrgAwxxU/ngCZQzweD
sGTxjWjIkvsO5xoXUFJi3G0+GjHEk20AGFi1CDl1+2/EIAUWheoYfS5sphPWIMWN
wFbWZl9F5HVbAspGTI6rf0Z6mmU2vNAaUs+9KKmvhYGVL2XTws6hmtujh0dpb8mc
9e15sImNz2StsDUwufeg44+XJaqTNy4ir1qzLrMk1KMsMh3K5gqYh5J+pjmvzzJs
ec4OQeJ2F6Aj+7BDN/PLvbwn8sYfl/Ll8/dxk/00/PqhhROx6tGKNY0Xh63gHHJY
d2MbsGe0JOAHtl9Yeu/wSzVw7xP+J1nTN/us8FzPLv5ZElAlySzdW0I6Eg6825WR
qG8oD73IV0DNwCa2xcmutblU6T4JyhDRq641qXWscChlXnTvF+s8d2el9ww5KEm+
vDWlbOfwupfkuDlg1GtF9Dco7NtebMLTOgakzSWR8DRhNrBCgoo=
=xXhW
-----END PGP SIGNATURE-----

--icIo6y0Y+9SyroLX--
