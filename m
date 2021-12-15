Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5F475980
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbhLONOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhLONOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:14:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09D8C061574;
        Wed, 15 Dec 2021 05:14:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so38118882wrd.9;
        Wed, 15 Dec 2021 05:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DtC00k5MoJtHy7c+VzfuwnEjrtBRQAfi/4tLwKgqaW0=;
        b=VZ4y91FcJaDU4ZleLAHlSLyXrFp6sNyvA95gVonN0nEw+nJVgibfwDrEQu5OZh17eR
         q3zZaaMlewkKM3NfWbtdeUTJBuCnmOAD+gcAyk2+7BBy0VH+NhgMCAVe+Qv1CYI0cJZu
         AaJPJ8FUxRRMT2BYrUeJLFb8TMgk7MEvRj+pEfiUvsMgyA7hNsLBDnTY+oIvLC0sU+xJ
         B6mAUP3QeI+FjNKgtTMeeVbRZWBArTdf/hAZBbepS/BxFIWub4BurjkmJyWbNiGkckAq
         cbM2SaoJSdcK7O7sWg+SazJpGyhcPJMe01g4GvaSPpLEssVjDQL49cMgtnE5F4CYxQG1
         9fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DtC00k5MoJtHy7c+VzfuwnEjrtBRQAfi/4tLwKgqaW0=;
        b=E2uSJI4QeRJIY8vPE+ATGuWwfmN50z7eXdPGyGOJ+TJ7euxmlMnNrzMh1reWX/V3E0
         LKL3fHIlc0fQwUZZ4TBs85Q5BGYAB/amueTPlRD3MKpg5IOgeskK9e1ETb1eIaeTDGTa
         fe/lm5i5utOvhxlqb5kEnDltZ6TuM2ph7DADvIiY6GC7DsYopI9uDNF5XOG0+mpeKJYV
         kFcb5ZwZZ+QQHytakumdiMERitlS/GNLhn2cUeYuF6eKmepG6uCGRQg1I1so13vWEr0s
         z6z9s4Ltgz6E5fGDODuHtCSVJCu7Br8NDEyVIkGInkrtz9GDSOv+KkRV22UKIo5QljxO
         Hqhw==
X-Gm-Message-State: AOAM531b3PK96GTnE7oZ/Q9ItZqt8wa3cJ1jt2py+AX1/TIRCqc9txwH
        i9sWCX8d1sBtgUYn5pr+Sy4=
X-Google-Smtp-Source: ABdhPJymhOm8azyKTgsfcLqcFUGnGZDkvsCXnEHC8aGHsl3rQH8JIkSAX7BLLq0HVQDmqT/Sz9fKuw==
X-Received: by 2002:adf:f049:: with SMTP id t9mr2987749wro.40.1639574084359;
        Wed, 15 Dec 2021 05:14:44 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id c187sm3424177wme.33.2021.12.15.05.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:14:43 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:14:39 +0100
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
Message-ID: <YbnqP0XAcUYc4ePy@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-16-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jZPZDpo3CQ/tiVnX"
Content-Disposition: inline
In-Reply-To: <20211211211412.10791-16-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jZPZDpo3CQ/tiVnX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 12, 2021 at 12:13:59AM +0300, Dmitry Osipenko wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> If an USB port is an OTG port, then we should add the usb-role-switch
> property. Otherwise XUSB setup fails and therefore padctl is unable to
> set up the ports. This leads to broken USB and PCIe ports. Add the
> usb-role-switch properties to Tegra124 device-trees to fix the problem.
>=20
> The error message shown without this patch is e.g:
> usb2-0: usb-role-switch not found for otg mode
>=20
> [digetx@gmail.com: improved commit message]
> Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 1 +
>  arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
>  4 files changed, 4 insertions(+), 1 deletion(-)

The device tree bindings for the XUSB pad controller say that when this
property is set, then the "connector" subnode should also exist.

Any chance we can add that? I was planning on making that a dependency
in the json-schema conversion of the binding, in which case it would be
more of a "must" than a "should".

Thierry

--jZPZDpo3CQ/tiVnX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG56j0ACgkQ3SOs138+
s6ED/BAAjJzAFGEDZMa0RP9mEQ8ZKPoBhLPoU6TYw8zUJbImsBK004ZjQf/8+RgQ
cuy7PrKJVdVf3GbpKKyj6B+1POinwPCTOChix1LpM8hVr/Cbyo3u20CEDHHuTnDT
7ubav66bl3W5XlLLrUMShqv4mvZU75XJweJSWfnJntM01K0ozYVFJP2m9w/m4kwt
Mo4Gz/tA5Gha9GuupY3M1Nxue3uqRWBgnRoCrns6Ph6m6m/64qxIB0yP4+mnF3bl
egP7VYEXSwOeEGYX3CBgu9C6bwMh4ikY/4TAIJ5qD79rUg8Gx5zhtP0mZU85kn/S
opaDvw9cNzc80PsFLRuA3C9JzYOEi4GVca/b94iSPf7vI/2qqWZ6W6t9pmkCu0ub
Pf0JsTvs7l6+PZil1lbPmFcbQ7B+dOXFLmn2+2htt+VCN0YjRHOeduBVAwVgNTVF
GdbLQ/kLjD/zSKQ8mTXvoDiqgyEs4qa/zTEnLdiE6Mk7+vRKx3oKJb9ebjTgjDro
c1xR+/EBKuzpdTdMMfkNu1JMIbKkp4HXt1Zq/jf1q1+MdJ7ijV128T+as0+wUb6k
FUisvaWf0Winw30eBmbsbzWYstEDf9ofjTDGBuBXrlyuRtZunKe2+MszNa5aoJpg
G5m0UbGwMrhoPaXuV+F7fY0A2BH+M3+yGLAKY/REavAemMn1JtM=
=Q6N6
-----END PGP SIGNATURE-----

--jZPZDpo3CQ/tiVnX--
