Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89C4775AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhLPPSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbhLPPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:18:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0500C061574;
        Thu, 16 Dec 2021 07:18:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o13so44737995wrs.12;
        Thu, 16 Dec 2021 07:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0NW4fFRtdMsPlhmkKhcfTmNZmyEs9QhErqbczxjv6B0=;
        b=kRAuUi3pHfp0vlymF4VGBZuEwSgT02dIRWqOT35hkagh6ntcNm8yIFOd8aC3cbEjeV
         oLvppbAZRB8W2b4GctTPRBCxTvug8AbYTh4eU9SKY464yhzZoIZbkU7NStoyhZo028uP
         30G79hCtFKOTQZ41pob7oCKdpmnUyzF/WOr8HOUrKPj7pgtBjorDAt1r+B0SffNGb2nx
         PWYlXg3FMnVSoyx70RZYYypH0u6HTgYkYxQ9HgAu5RfJiVfJbT+9OBeFuOIHwD+kdpCQ
         wyyVlh6+vxWWobNr7aCMpPy2K3Psu4wUGD2t3a6B0oxiAEEZJtpoBjFYAB3fPwOhvgRJ
         rXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0NW4fFRtdMsPlhmkKhcfTmNZmyEs9QhErqbczxjv6B0=;
        b=QsGi2mLQwHzN2XQAtq7zPlAzfM22zTwamuo0ink2i8duKK0goel3HEgFWpR2C5AwLs
         vreXmuUGKmMKqTHCkXM/ND1tgV7r+qR6nntTSC5ZSTypj+VLzPMhaIzNCsKvyC93IrPl
         bkOWKrPZju/Vg1GbKMRzxSYe1W51hBTv5o3OKff4QIxhZVsmsXgZMlNxq+xj1zDtcyYw
         JoyfGiUbW9e3iPERQaMo91xoDidUEt+iBSA1v+Ia0uEqDyFSJ68s48qpZJzpKHs4bnbb
         q4At++ShZiy9TK6hYGPOFEDvHFDD5Is+HTTd6DlVJ2csVn2/yiCi6pOpNduXBWT0oHZ3
         uIYg==
X-Gm-Message-State: AOAM532aSwHBWf8BELlV7AlwKX3JOGH5UOl+ocU5mL0Uwn9swrrZuaR9
        9oI0lqM3z2/efn3u1eo4gElJQpblyWMOyg==
X-Google-Smtp-Source: ABdhPJyy3q6RwT0+pTgk+dWoIRgzvgCOOBY61BwzAcTietGzu7v354AVmOOir3fo/hsmJoWX4Pt/IQ==
X-Received: by 2002:adf:ea50:: with SMTP id j16mr8909726wrn.719.1639667930246;
        Thu, 16 Dec 2021 07:18:50 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id q13sm1597560wrr.64.2021.12.16.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:18:48 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:18:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 08/22] ASoC: tegra20: spdif: Improve driver's code
Message-ID: <YbtY1TfX3rdVbkzG@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TtAaL1I0tfYEZFLw"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-9-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TtAaL1I0tfYEZFLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:11PM +0300, Dmitry Osipenko wrote:
> - Clean up whitespaces, defines and variables.
>=20
> - Remove obsolete code.
>=20
> - Adhere to upstream coding style.
>=20
> - Don't override returned error code.
>=20
> - Replace pr_err with dev_err.
>=20
> No functional changes are made by this patch. This is a minor code's
> refactoring that will ease further maintenance of the driver.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/soc/tegra/tegra20_spdif.c | 49 ++++++++++++---------------------
>  1 file changed, 18 insertions(+), 31 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--TtAaL1I0tfYEZFLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7WNUACgkQ3SOs138+
s6GwvxAAvJ61geFKAbm8cP5N+pEbKgtEihkMw5PcFuU3W2atATXHSqSBZfJLV4ze
A8EQ0s+6vh51dP9aXYxgKU3eiuilqw97kCSNPEwmq9kOiDe/ls7Z/hoEW/Djsir5
wHOa7uBq4+10I4UNMlJQNs5XX9+bp1ajTmH5ia/KiTcburoqT1P/UllLwjboBgRm
k9P3LKjBckI8u9wRx9meYGxA712IxAyOmbdlfHa7SlGKwXZw7aO3K2wuls7QAdZw
NTSkpLHUbgQW9VIAyRIIA2iczZHlwm60Y43Bo6RRTlx8vH1pPlTikqFB+VMZHH4E
awm7aD0p+VpvM+gBN2+cjmwlWsUXvVp34rQYZ4dR+bY078R4EOTA+nyMS4Z+693G
kNwjF+02na0InBnxDg3VFKCCd+O72A+r5ydXcWDw88FhNy5D4kUIZl+EFBKBmMb4
AWl/HxMmM13IVSfu4NpgpCpjqNaOAQokybxCH4YHs9JIUcHAP9XZR2IKTVxZaerC
NxQqpp9BfrOiIevdNifxpp7XL7DA6yjpck7iYMFzrcZDkc2gmIb9jiS2Cn8Szwjq
emDETf5gob2Pn4atJkeP5koMR57wmi70y7ulhTqtJtNjGCUlW2ahYykNoTjaueiw
b/nN6nrnayfCg8YIh81xMas2Q81sANyy8a3JLwTj+0HqHBovOWI=
=wYWM
-----END PGP SIGNATURE-----

--TtAaL1I0tfYEZFLw--
