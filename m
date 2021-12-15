Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6C7475BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbhLOPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhLOPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:16:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBBAC061574;
        Wed, 15 Dec 2021 07:16:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso3299684wme.1;
        Wed, 15 Dec 2021 07:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Q9Qi8wQrEoZWm5nsu6G4IHs86FT9L423fH5Q6OLkcA=;
        b=TW0UDNbyWAL4qgqq0kFrVu7bE+lTDYxQSAwBC3cRCaJFFH1/P4MGQ0hQYHQ4BN4lRY
         jF7mY9owHeXUSwMEaLWBueGxhSi5E7Ry2FWkpAC4Yy99H1DbBzXJVWkhI9ly0FLUOAac
         HvBAxmOQClgmCA/Tpn2dW69r9OM+VqeUI8tjKehRElFOR/nzQLOfzFkApGSFw/y4VfI3
         H2jBDinKiMjTPU5dxmCtNS+HNF6fzqmzpKWdsalQp3425T+zUCxFYlJE8sMxxyDthcjg
         dWFcq/btrhjgS4axZMuHzI5WK5Z7wo4f3RuOJs8pcSpKcQqRAGDnC31JYhQO2rNE5ihR
         n2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Q9Qi8wQrEoZWm5nsu6G4IHs86FT9L423fH5Q6OLkcA=;
        b=qG1NojqR0tTWNn3GGlWZnvYoREX8GUC7ZypZUg1ESktYCOuv5j2U0yNu/r2nh31bNR
         g+X/3A/qhOyqIeoYH3+7gcK+5l8hqYGwl4Kbs9Wb6fZjSNZZ8Zi5fYMNa8sk5ZJtBqra
         WSZ2sm7LTufC7OVUqj8zcFMqoLxFvw0Bk9L2PyEQIDzuZrcM94VBps1bd4C9f9kqQm5E
         IREy060oP+H7bjvQcy2bH+If0GJRQtkFQM6tWJz85rAX4mQFgPxs1SXeDM3hXCPp4Mvd
         7GyHlugnUoqD7DnYdVFf90E3vOzA9TFasLKptJy1wS1ZlaOygSvUolGBF1R/QwtrMwyr
         pxtg==
X-Gm-Message-State: AOAM531hN7cY7uXjURIe96zcMQPVjbfX7sESALC+uGaht8ND3Ti/PXUW
        7qwm6qSU4FghmipvrocGDDE=
X-Google-Smtp-Source: ABdhPJwcQAhgd6tMvOqhOGQfwhmuxfi4/RnpfrTqDUixzz+Dbbo/ne0yrMPZtjGbR6B1DiRKXMbBAw==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr212948wmg.181.1639581386791;
        Wed, 15 Dec 2021 07:16:26 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id d1sm2211910wrz.92.2021.12.15.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:16:25 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:16:21 +0100
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
Subject: Re: [PATCH v6 15/28] ARM: tegra: Add usb-role-switch property to USB
 OTG ports
Message-ID: <YboGxZSi13OGByUQ@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-16-digetx@gmail.com>
 <YbnqP0XAcUYc4ePy@orome>
 <9cf23721-db53-830a-f634-d2215232f059@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WYAJB0Pchkifo8CI"
Content-Disposition: inline
In-Reply-To: <9cf23721-db53-830a-f634-d2215232f059@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WYAJB0Pchkifo8CI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 06:04:54PM +0300, Dmitry Osipenko wrote:
> 15.12.2021 16:14, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Dec 12, 2021 at 12:13:59AM +0300, Dmitry Osipenko wrote:
> >> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >>
> >> If an USB port is an OTG port, then we should add the usb-role-switch
> >> property. Otherwise XUSB setup fails and therefore padctl is unable to
> >> set up the ports. This leads to broken USB and PCIe ports. Add the
> >> usb-role-switch properties to Tegra124 device-trees to fix the problem.
> >>
> >> The error message shown without this patch is e.g:
> >> usb2-0: usb-role-switch not found for otg mode
> >>
> >> [digetx@gmail.com: improved commit message]
> >> Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
> >> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
> >>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
> >>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 1 +
> >>  arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
> >>  4 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > The device tree bindings for the XUSB pad controller say that when this
> > property is set, then the "connector" subnode should also exist.
> >=20
> > Any chance we can add that? I was planning on making that a dependency
> > in the json-schema conversion of the binding, in which case it would be
> > more of a "must" than a "should".
>=20
> I guess it will be harmless if you'll add the connector subnodes. Will
> you be able to create a separate patch that will add the subnodes on top
> of this patch?
>=20
> Thomas Graichen says that one USB port on Nyan Big doesn't work without
> this patch. This is why this patch is needed essentially.

Okay, I can add "dummy" connector nodes for now. I don't see how we can
properly set this up because as far as I can tell there's USB ID GPIO on
Tegra124 (seems like it's a fixed function pin) and the VBUS GPIO is
already used to enable the VBUS supply. The gpio-usb-b-connector binding
required at least one of the ID and VBUS GPIOs to be specified.

On the other hand, at least Venice2 has a USB type A connector for this,
so I'm not even sure how that would work. I vaguely recall that the
Tegra20 Seaboard also had a USB type A and that it was possible to use
it in device mode, but I don't how that would. Nor would it be correct
to use the gpio-usb-b-connector compatible for that since, well, it's
not USB type B.

I suspect that Apalis has a micro-B port, much like the Jetson TK1. My
understanding is that OTG doesn't work on Jetson TK1 (which is why it's
configured in "host" mode), so it'd be interesting to see if this can be
made to work on Apalis.

Thierry

--WYAJB0Pchkifo8CI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6BsUACgkQ3SOs138+
s6EdVA/9HoSwai41QHSPGL6ezVQADy/iGs9tHGDNypOX4IMF/UOYV3SNVHJDI5wG
sJS1OFIlEHLj0+IaKsSjg3wLQvtPduWoO2Gdi/aTScPdiABe86xIOLPu9jv0I+/E
MzhrVLnN+t0YYPkU/0uornbwd2UzgZTeyhn8Ey5E4NrtqdLXyVj+5q3UFrYpEn+Q
ReMRZJ1RTXNzFqpOGTTW5pa4+sWx3ECaUV7Hwd2qY6Ezlun41U7EjoBvhNLPUowB
A/k5CtdzwWHu5plpwquUwP8eDk9v53tYIgA2gPDtbf7xBMop2D4X/YFywIQTTos2
wU5GcnFVpK1Yg+GAMJGieI/61UxMcYyJqinhY4qRtj4PR5Eo3pn4H7FVA+sG5CKb
vPZWmv3n/UDAWlW0mQZZsgqtWwpgMLz2PN8AGZmfru/1pmCZrTStLORSDqMkv2Aq
4SzSd6BBRfpiaJySaXr1aj+c7fPRN8niqOi1TFjnv8F5LNaqFvqOhfX9gylByvJc
v8TOxMqu27+CtDdK3WlcmGEE2A5DdW4IPTXVSvR0f8KeoxDUOOW+nQc8300jA/iv
EfHZfe+JsvP1pTNPE+9AdIg1C/us5ZSM1FcnMBvUB4mWX5sZjZ8GLLxJ2fPKJ7VP
9dGQMD1y73vrMBLHLDNFNchAMKuUay+STSoLkpxvndJ3rcOtm1c=
=Ut27
-----END PGP SIGNATURE-----

--WYAJB0Pchkifo8CI--
