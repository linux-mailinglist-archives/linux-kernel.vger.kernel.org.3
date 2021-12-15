Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83E14759A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbhLON2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbhLON2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:28:46 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC5C061574;
        Wed, 15 Dec 2021 05:28:46 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 207so33286225ljf.10;
        Wed, 15 Dec 2021 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dz0GA19ryeg+oeJV9N8K8wsEZZL8M53J/JQlMxcDflo=;
        b=ltwlAtWfj+cSg72jYSvGVLJxrzjiq7RGKiUufJa01KvLLc9morCymEJLqAuuilI5FI
         uXHoLXafxt10iwduMOTRiljVzW6UsR/Mg6dizt3qBeCAOZpPWs3Q9yI7ZN0Z3EE4h1XG
         ed9T8+8CZBGg3OA/kYi7dz8d0yvQYcc/dN5o/6yZrl5Wg8rpD2U39D1zHZDH8bxe1Qb9
         zeYbeCd4VySPYplr1Xn5CdWSK2pkIb9C64pLiCONu8DCu2+oqig11H87gzACn42N8wFz
         eTLCiVLgmRrBqpfcPfi3itp4zB4/4PsRGdlOzeUTURstGLrtslUhR5zxeGodfUju8YDt
         OC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dz0GA19ryeg+oeJV9N8K8wsEZZL8M53J/JQlMxcDflo=;
        b=MAlCAD4FaIJ7c5Q7b8Iko0KNr89xifier+2EIz3F2P9uB/tim7yH8BwUmsIcnK5sg4
         9HQUZAgkx/W7wl0oWt7tM37ygLnlJXhUisEWxaVuO6OQmo0qyjwbZKjdcb08y9j1iqRl
         IQakDZEGd80uG1X6npD2RIJ2C73MjMFQAnSOIKtRyWSKrlhUFuy6staplFyiaeNj+rpu
         EkLC3f+wGFW/gNTopEzDuxReAqKgPtUGZfX0vBMGCLwP4D6zexE1M+BH8mESU9VtcQ2j
         9hxPu8NC2OJQ+ZLKUSL/kKNfuGmUinggblgHNeVJdJgQZTyNnVKZQilIezSp1T6nONyx
         K/hg==
X-Gm-Message-State: AOAM532/c02aIK+CKwXGfZA7NUUJjF8i+tM1DNhu9O6jsvt31p9Ewwvq
        i5wK6L198Bd+899CWDCw7iA=
X-Google-Smtp-Source: ABdhPJzM1f61gCZlatJ/6FWjfJNJuhOQFug6vE35pjrfRjHRz/L3IKNkWuVR6KnAUEsjnmKNhcCYmw==
X-Received: by 2002:a2e:8e38:: with SMTP id r24mr9915935ljk.450.1639574924630;
        Wed, 15 Dec 2021 05:28:44 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id p11sm322554lfc.101.2021.12.15.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:28:43 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:28:41 +0100
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
Subject: Re: [PATCH v6 08/28] ARM: tegra: Add device-tree for ASUS
 Transformer Prime TF201
Message-ID: <Ybntiedyo353hMxm@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8CCpjWlobjOg053Y"
Content-Disposition: inline
In-Reply-To: <20211211211412.10791-9-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8CCpjWlobjOg053Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 12, 2021 at 12:13:52AM +0300, Dmitry Osipenko wrote:
[...]
> +	display-panel {
> +		compatible = "hannstar,hsd101pww2";

There doesn't seem to be a DT binding for this and I can't find any
patches where this would be added. Is there a patch somewhere to do
this?

Thierry

--8CCpjWlobjOg053Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG57YYACgkQ3SOs138+
s6HgQg/+MJCWmuNMm4flx4FCM3sClwDAw0f2I+xGELeWHxyPG2TKg8TS8h0L8cM1
ZaVzJ994Pypxlecr9nnWNchJuYSx+FOjMgs/OtyE74Tno9hnRDPib9L++dRGI6SH
KfAlLcSIXRZn4TQOBQ8CSVh4IttrAc//BGOgmMY0wWGzaZFKg3ALnaDwbQ1DplSL
asiXg05FqbVci8SCO11FPMZ0UNrFaDYQjg5mln81WAgIDc0kwH+7jvMD5cNWalu2
d6X3zMwy4aBITWH4qBGPPNG/ulKgdnAjrqoSF2VleblH0RXF0nuY5OyUSrDvmIlp
0Qc0BN5TO/Eb5rKNBEifQVfrWOmdRShulD6St//+f8Cc+JLwNxtUKOzjZPQL6fnX
4MIvY+Pnlp9zJSipzec/dN0A0o23W6u0Md6VU9bl2T/BBmMyplXDOnS3IMkUjreW
D4KQoIUnGgOEee5Hq0vD0rRqgugB/z5tXka1dhxaLdIFbGQTWF9Nrg/U5dtYiFG0
3WB50nGo8nZUfSk+Vs9imd7xWEE8bDtw/gBMiydm+gGraPW9UQ2He3xRB0ONtoez
30mUviHYauvIEFEerKxtJ4tZb+Qq6nk9dTxOhqf/xn68uKH3K6x5MvlKFpY6KUWB
lDFgceUherzSNLfpfxMtFMSoZaGry3geQMlmCza+zuIP9O/S45U=
=6jhd
-----END PGP SIGNATURE-----

--8CCpjWlobjOg053Y--
