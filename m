Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D226E475C43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhLOPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbhLOPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:52:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346EEC061574;
        Wed, 15 Dec 2021 07:52:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso3374858wme.1;
        Wed, 15 Dec 2021 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fRezAm0KgTU4qbdbTP9jVXgHNoJOhN9tuImbbcO8MrI=;
        b=mvz9/fN9kFsTA+y3iYV6sIluxzt9hC3jUa2dxhCAirBLkmmGANU1Nn8J/EgSRWF9DC
         FaIkgvtb4f/2JTz+aPZfsUAHym03C2nIffl0UYjTXYSHIm+jYJ1JTRW4palKeFbLpfke
         72XdAw2ex1M4e4jayddOme9NJQhWl5JCOsermSFDaAphPsKCEPwojz5sUWQlddEqgoS5
         SeGCRc0mAYgtbi1/cmD+LwrOEpR2Mr21No05ubc0R4i99DhOhA8oL4boNUVpP+QHlU+6
         zzAvrm9No3pL3UvWnJaD2FA4QJU5fyVnXYUi+2j+6xByDR+J5a/jzGwl2PN4BPI2KZm4
         rRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fRezAm0KgTU4qbdbTP9jVXgHNoJOhN9tuImbbcO8MrI=;
        b=43ziiiR/eVjOs8xAQUQz7pnUrWKqwWmK+YXdwlgOZ/U3YN9ULOX1hgHKaMp1bFk76c
         d4pOFF3yGidP4kS9+mTnWyS1X/LIAMT1Tpzlt8EmeDREWFmqnzRzwvCV+8QXagB3au76
         wRHPvqlk1hylfIclJyWq8vD7LI5omb2t6MhRReIYkD0h8JO5y89tDchV3vvq8khHbVd4
         2WFKfbq5g/aykYb5ksOgih8BacH9SWAzqZuSbzYl++djDQKXv++W/Zhe7Dvxv8ZDOKIJ
         mZtnCZHRsnQ1jXI4XCIMWMwU8i8RqcPUGPB3+E9h74RMin/BXKNgtWSWh/nkKQ1QrHA+
         hQDA==
X-Gm-Message-State: AOAM533jzkLU88ylU8qyX9gSoT4NjuhaYFVBm0FeaBStIA/F3dBUkHcv
        gGFa80iDoggItVBQLqCuMiGmFRkfD6vNlg==
X-Google-Smtp-Source: ABdhPJxICAEDBphdI95vOuIO170N6+cqbuafjEPlOrP5W5d83pqgR+nEFBOdiuJLwuv47WICeHvmWQ==
X-Received: by 2002:a05:600c:5101:: with SMTP id o1mr409180wms.81.1639583561692;
        Wed, 15 Dec 2021 07:52:41 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id a198sm2192950wmd.42.2021.12.15.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:52:40 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:52:36 +0100
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
Message-ID: <YboPROE47E3QBzfl@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-16-digetx@gmail.com>
 <YbnqP0XAcUYc4ePy@orome>
 <9cf23721-db53-830a-f634-d2215232f059@gmail.com>
 <YboGxZSi13OGByUQ@orome>
 <8c0defff-3348-6f97-6bd4-ddfc6117e707@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bL/7g93/IKUyyp+l"
Content-Disposition: inline
In-Reply-To: <8c0defff-3348-6f97-6bd4-ddfc6117e707@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bL/7g93/IKUyyp+l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 06:45:32PM +0300, Dmitry Osipenko wrote:
> 15.12.2021 18:16, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Dec 15, 2021 at 06:04:54PM +0300, Dmitry Osipenko wrote:
> >> 15.12.2021 16:14, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Sun, Dec 12, 2021 at 12:13:59AM +0300, Dmitry Osipenko wrote:
> >>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >>>>
> >>>> If an USB port is an OTG port, then we should add the usb-role-switch
> >>>> property. Otherwise XUSB setup fails and therefore padctl is unable =
to
> >>>> set up the ports. This leads to broken USB and PCIe ports. Add the
> >>>> usb-role-switch properties to Tegra124 device-trees to fix the probl=
em.
> >>>>
> >>>> The error message shown without this patch is e.g:
> >>>> usb2-0: usb-role-switch not found for otg mode
> >>>>
> >>>> [digetx@gmail.com: improved commit message]
> >>>> Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan B=
ig
> >>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
> >>>>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
> >>>>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 1 +
> >>>>  arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
> >>>>  4 files changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> The device tree bindings for the XUSB pad controller say that when th=
is
> >>> property is set, then the "connector" subnode should also exist.
> >>>
> >>> Any chance we can add that? I was planning on making that a dependency
> >>> in the json-schema conversion of the binding, in which case it would =
be
> >>> more of a "must" than a "should".
> >>
> >> I guess it will be harmless if you'll add the connector subnodes. Will
> >> you be able to create a separate patch that will add the subnodes on t=
op
> >> of this patch?
> >>
> >> Thomas Graichen says that one USB port on Nyan Big doesn't work without
> >> this patch. This is why this patch is needed essentially.
> >=20
> > Okay, I can add "dummy" connector nodes for now. I don't see how we can
> > properly set this up because as far as I can tell there's USB ID GPIO on
> > Tegra124 (seems like it's a fixed function pin) and the VBUS GPIO is
> > already used to enable the VBUS supply. The gpio-usb-b-connector binding
> > required at least one of the ID and VBUS GPIOs to be specified.
>=20
> The ID and VBUS hardware configurations are very board-specific. There
> are multiple ways of how it could implemented on Tegra.
>=20
> > On the other hand, at least Venice2 has a USB type A connector for this,
> > so I'm not even sure how that would work. I vaguely recall that the
> > Tegra20 Seaboard also had a USB type A and that it was possible to use
> > it in device mode, but I don't how that would. Nor would it be correct
> > to use the gpio-usb-b-connector compatible for that since, well, it's
> > not USB type B.
>=20
> I'm not sure whether it makes much sense to use OTG for USB type A
> connectors, normally they should be fixed to host mode.

My recollection is that those can be used in device mode as well. For
example that USB type A port on Venice2 (same as for Seaboard) can be
used for RCM, IIRC. It's possible that there's no way to detect what is
connected, though, so this may not be proper OTG.

>=20
> > I suspect that Apalis has a micro-B port, much like the Jetson TK1. My
> > understanding is that OTG doesn't work on Jetson TK1 (which is why it's
> > configured in "host" mode), so it'd be interesting to see if this can be
> > made to work on Apalis.
>=20
> Looks like the default Apalis carrier board has three type A connectors.
>=20
> https://www.toradex.com/products/carrier-board/ixora-carrier-board

I'm wondering if the best thing would be to mark all of these as "host"
for now and avoid making this look like something that it isn't. I don't
think we've ever made OTG work on these boards, so perhaps we shouldn't
assume that it works.

Thierry

--bL/7g93/IKUyyp+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6D0QACgkQ3SOs138+
s6E6Qw/+NI/apEThH0dvFCCilxaBp5v6FIRnx3T33dnqulelfDZQg4cJzpPwv7Rm
cDJ2gPpuP3oQZkQ5pisk2KMsb8KbBHCAxopLXjggIX/Nol5uAwKb8fFHq7PkHlzy
Vw0Foe2sl7wIpCgMxdKhOZltbELOWBma7zB1NYF/Hdu1YQlmPraexCUETqZLMM9v
QDb7oDBWS3bHJNn3KiaRTv3J/2ahOahtxzSNI4KdiXYd/4QAclKSBIo4MnQa32IV
4vwTvXb+wBTDyr+rAcyM9p2JxeH17vbYBbJlwygc4Vc7uxvCEuyQr6zfTCUgNbFB
3dOCOp1LjiDKREJ8N2R4V3DpQoE2x5Aiw0JNKNc2rFwlLBA5I8/HXnyIegYlywHz
fdXCgiNxHE60tHH9V9F1yUcnnuLN+KcGHwCYNg76aCQOagNPHsFMFrCCHFCEU41i
JLNrb7NiyjD5O+6KmcMMFPZv8XgoD15EHG3xLRzKivZhbhbCLzw5ywIaPi0FeeX4
/gGfuPU08pyohF0eZUVQ8FMG2l8RQVBIpiK2gxrRNn/bRY+UYDM86HsH/C6rZfZX
FLsyRSId1MHst37Q34gp7Nye8ZdDwb0mOhATfRUTwujNEFgLLX6bkVBwT75VzXSY
GcJS1L3y0Rtw3Gv5Qs4DquGDIuA9oXNUO0Gbf+uVgNM8ORojoN8=
=1LNN
-----END PGP SIGNATURE-----

--bL/7g93/IKUyyp+l--
