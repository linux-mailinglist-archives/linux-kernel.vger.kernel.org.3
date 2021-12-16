Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1E4772E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhLPNPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhLPNPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:15:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A19C061574;
        Thu, 16 Dec 2021 05:14:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t26so7817512wrb.4;
        Thu, 16 Dec 2021 05:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=plntCnoEf4l+2O6n5K2//4k94Xfcj+XZd/AAN0qmlKg=;
        b=FIO7dAYdQsogQTPmvKNLvcHJmvCg6gKD4gaQUApx/L1OHKB+gdGjuTQwMR7iPm8Au8
         4eDzFvrkcAOZXcQn5eov/jIed7iuyilK/FrmhhV9f8ipnM83966znpVIWxQ0y8rENrx/
         DR0dxbZOtzzl9ogZGBI4oY+EmvHQRGx2Ld8d2c1XyIEbnaK/FbMQjYo43feaOZmMoGu8
         UWjWd+D5bnSeZfuFe/mxr8MKKfHSA6tbWcxKs/BtvaTwP4U2sCSA86AZ5Wi7VNnPQfPJ
         tqn7Slclo/4qiAkuAew92t2U+kRMWgGGC7e1ZxGxqC6qyRRNj5UDm262Don06h799XPa
         /fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=plntCnoEf4l+2O6n5K2//4k94Xfcj+XZd/AAN0qmlKg=;
        b=3Li3cl2rRvPNc3ncVDBH1Ay/8qv1DKriRx3R3liMNvHC8Z19XJo3vZf1Sfm5fpwVYV
         DLvtByryhb1lD0iiVkBwHjuCDbzbAIv62V2eMv5EhRQPnOe+xZkxuEeTHQQk0WtfRlbM
         yU6Iq2IIkS/L5Ywy4ipbd+hFid5zN/SArSMEIMJp2CAltJVi/3uUcm9hzgiYChcTNQ4h
         RaKXhngX/qniMyvZFvipu0QbMOtBjPtukpfNk03WOgzMBVgR279tK5sSeKz0kbSLU4Dr
         P1MWZdt2s4jkyrNPA82ZCbt18CmWG5bnMGjuyGk2z5gsNdZujCeCiiOTbs24fjqTlZIA
         kefg==
X-Gm-Message-State: AOAM530Ewg9koOTZG95pzYXs+ND+8jFQ7Ij1fxB1rjFJx+82LSHeblHN
        FHWPvsTiklG0Rz9TGYMHuQY=
X-Google-Smtp-Source: ABdhPJxZUIxe16AL1U6OVyWzVyNBqRDFNcocl3pvTG2D4/71hffD8CvlNr25wmCQpMbdSJzLa6QbkQ==
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr8860261wrg.433.1639660498311;
        Thu, 16 Dec 2021 05:14:58 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id x1sm4651630wru.40.2021.12.16.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:14:57 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:14:52 +0100
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
Subject: Re: [PATCH v16 00/40] NVIDIA Tegra power management patches for 5.17
Message-ID: <Ybs7zKQY1uJCJ2f3@orome>
References: <20211130232347.950-1-digetx@gmail.com>
 <YboP9IFMUrUnEzrU@orome>
 <6baf6013-fbb2-b42f-5b26-2d10a2ca9374@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GBkk6fJUCkERZf+c"
Content-Disposition: inline
In-Reply-To: <6baf6013-fbb2-b42f-5b26-2d10a2ca9374@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GBkk6fJUCkERZf+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 07:11:53PM +0300, Dmitry Osipenko wrote:
> 15.12.2021 18:55, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Dec 01, 2021 at 02:23:07AM +0300, Dmitry Osipenko wrote:
> >> This series adds runtime PM support to Tegra drivers and enables core
> >> voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.
> >>
> >> All patches in this series are interdependent and should go via Tegra =
tree
> >> for simplicity.
> >=20
> > So these can be applied in any order without breaking anything?
>=20
> Please notice that the word is *inter* dependent, not *in* dependent.
>=20
> There is a build dependency for the patches. The first two "soc/tegra"
> must be applied first.

Okay, so I've separated the first two patches out into a separate stable
branch that I can share between the Tegra and drm/tegra trees to pull in
the build dependency and then I've applied the driver patches to those
two trees and I've verified that the two branches build correctly. I've
not done any runtime testing, but I'll trust you on that.

> The "soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30"
> *must* be the last applied patch if we want to preserve bisectability.
> The core voltage scaling can be enabled only once all the drivers got
> the power management support.
>=20
> The rest could be applied out-of-order.

One last remaining question: I don't think I can apply that one patch if
it requires that all the others are enabled first because it would
basically create a circular dependency.

Can I pick up the final 7 patches (the DT ones) independently of that
one patch without things breaking? If so, one option we could try is to
wait for both Tegra and drm/tegra trees to get merged into v5.17-rc1 and
then send that one patch (which is only a 4-line diff) right after
v5.17-rc1 so that it makes it into v5.17-rc2. That avoids the circular
dependency and should get everything enabled for v5.17.

Do you see any problems with that?

Thierry

--GBkk6fJUCkERZf+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7O8oACgkQ3SOs138+
s6FaPxAAurtl9RVWzTQoPumQ6idPyH/LVTqdXH8uhMksiRkr4Y5/jwAgyN0Xds9g
0elHBQwMR1RuXgChY1mCtzK5Bd7KYuXtbRrDNDuzdNeErVVWhAmkLfpaWx4gtsn+
LnNMnNjGqhpJl+x4JET4cExLmzvsZPonV3KOJb11zqf0MHPPErBIUNVtN3fHEtEz
mH2WbH3Kt7f1ih6syH6w+LcwdZ9Z6nRxSfzXTX1Y8IFrncwmwU7UIVAJ0/iPNXso
7CVfEKEkR+3q2FNlHFpoZj+yeeSsk7pMC1EIHXIgjUqZmgVgZPbT4s02saWqsI0s
SUOo2uLBW8xIsSvUltCBsi8fQ36zj8gWz0brqiAQu47t7XB7oX8Z1m7Y+9GjuFoz
AlATrPX+VxyLryAxx4WgkYVarCHr67qjqRjZJ9LXqCES8IfwXxgNBRP7igTLkLzD
dkMkGxw+n7T1Ic6hH4/UPK44ZfpHDhE8Fl1zD2P/h0hBm9kcd7P+8GO3SnKETaKS
MsdJTA+1RUCdT/24s/obuMDA/3va8SoU6UEzaOqmsb+KujnSHb8kcR/NWHjAdDXP
325SFxssz92BU7jiOnooUw1BhqGio6Ufv+EEHJCataCIczKt9XogPtLJrcO94qo1
Qlb6JGF1/uUXQj3IaICdmPigTcyAdSuFM4pKXoyOL8HOToBjKcc=
=AIks
-----END PGP SIGNATURE-----

--GBkk6fJUCkERZf+c--
