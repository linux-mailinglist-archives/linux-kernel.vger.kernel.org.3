Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33C0475B71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbhLOPJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243550AbhLOPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:09:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51297C061574;
        Wed, 15 Dec 2021 07:09:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so38738131wrd.9;
        Wed, 15 Dec 2021 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndszUawtcZsihPxhRzA/LtnVLLc7iX4oMb3QBYTTmpA=;
        b=ETfDROvgKirT7dBbBlqYQ7Tpuf+p+zrnl5rYRaBKrhjNi9Tpg6CiRqXowvqdw3nr6n
         b4w98RHtiIadoeNhtbtYbMzTKxzO46k9/1VDYGBysTXZEZqEhIupEQ1USi2vflDoYuch
         VYwDEXDnbYzaKZ5AKYcudUcbXG9W+6UcuF4BAomK1bJS4/sK7LiniD8CETKEVdg0WoUl
         lImaYoiFrX0oIa7HEjUhl7mn8Ep1pfG1pJbdVtpC7ZRuyooDiY6KoyKYTkfPU8RAvFpr
         z7yu8eNP5QIBXzq+jKDHS0TpVNLSkaS2Adu/+qyeKAmjFLTFWubhEMBOuOQqh5meSaWQ
         sZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndszUawtcZsihPxhRzA/LtnVLLc7iX4oMb3QBYTTmpA=;
        b=5zssZ2r4x3D0BYT2mIAMNDCzNTWb1ksnHyeBP2S/Irbsnej2cLLGXxsusIlsVBjeKc
         iFNUWd9EMz2W1Rn9xiLz0FlRcu/NvfAZv6syZTrbziMD5+gePDTa1fpxkNnE49ADOzxn
         d+ZdklnQkVDrl3basSHQwwPBTfvsi2xAdHQ51+hyadi9SRstohYqu9OH/g1+I8szkmRz
         aXvr0GDXC58tPcHBifwlDXY3gBeKbt1eWGsDwenV6ZKxcnXdguoU4Os0grFrIX4j4XnY
         k+lPzGpegygsM6DO6QRaPSoMsuo6yI6Q6fylmneefeQB3PZCUITP1HLT0xqA1P54hjBC
         aHpQ==
X-Gm-Message-State: AOAM532dxkIiv/rSgoyVMQcO8CIwm+OQh4M510gs3FyEXfvEFSo753LF
        2nPbjKJWka8bVc4oc+OBMkA=
X-Google-Smtp-Source: ABdhPJzBpWAYkW+xNPBUpX4TQ/KAQSl85LQaKAjS9J1srPEWlG4c04xnHAwDm8xKqEjGOXe78f8ILA==
X-Received: by 2002:adf:fd4c:: with SMTP id h12mr4535921wrs.429.1639580958794;
        Wed, 15 Dec 2021 07:09:18 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id r17sm5683419wmq.5.2021.12.15.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:09:17 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:09:13 +0100
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
Message-ID: <YboFGXzalmPeCqwI@orome>
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-9-digetx@gmail.com>
 <Ybntiedyo353hMxm@orome>
 <373613c6-2c3b-522c-ac63-371304b79bb9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5JrQbDbVSoe0zJtM"
Content-Disposition: inline
In-Reply-To: <373613c6-2c3b-522c-ac63-371304b79bb9@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5JrQbDbVSoe0zJtM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 05:19:09PM +0300, Dmitry Osipenko wrote:
> 15.12.2021 16:28, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Dec 12, 2021 at 12:13:52AM +0300, Dmitry Osipenko wrote:
> > [...]
> >> +	display-panel {
> >> +		compatible =3D "hannstar,hsd101pww2";
> >=20
> > There doesn't seem to be a DT binding for this and I can't find any
> > patches where this would be added. Is there a patch somewhere to do
> > this?
>=20
> Are you trolling me? :/ Please search the "Tegra kernel patches for
> 5.17" email in your inbox, it must be there. Please read and answer to it.

Hmm... I searched for this in my inbox and couldn't find it. Odd.

> All patches are in the Tegra patchwork. Who marked them "Not Applicable"?
>=20
> https://patchwork.ozlabs.org/project/linux-tegra/patch/20211211213653.177=
00-3-digetx@gmail.com/
>=20
> https://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D276358

I will regularly go over patchwork and mark things "Not Applicable" if
they don't go in via the Tegra tree. These would have to go in via DRM
and so are not relevant on the linux-tegra patchwork instance.

Thierry

--5JrQbDbVSoe0zJtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6BRYACgkQ3SOs138+
s6EPuxAAl3QaJ9HZpSuDGYbnFMXdFJ0jby48BCs2NQFpQuwCiuu6OWE61nwOOS8v
5bcKavrBm5ZHQ/qgfIl6GQVjpLQKn+Y322DkE1IoRlWa/czGMUn3cuIc+OzL+N4+
5gRqwjQw+Xg/BYSUsacLVI5j8Mre+NGVsicQxmAWLjBCdojTvIbimAReDlenXsSF
8/3Y7FqPLlper1ca7QB8B1yn8J/ff2/YgFWr1XJMSRN/dktTPmmPuI+5gw6XlBzD
XUk4v/9O5oZWC4SBryIFTyTovILIU+HYyvCmsjHP9XdA/zTKT26XkDulBIpyZV+L
se9poN7OqGX96GdF7Yap9ZWu+R/6dYHpPZin1OWz3aQ5JuPHM2qDKfWYWdQpe09T
dH6kybvJ4nS1zmtG1F7BkXWF5y2LMbzGDttxJAwF84/p858WdlrxNTrsmeQwU2KD
mO6UD/H9NZJMZV95GTVwvD5yQQpZzDKK+pVxqo4+FikEvbvpKF2wnAM/RyihTkl6
Y1bPED0uhiQvDbFEgQ7WLCdZgpPZCVmV3Mf8pHQXiFN3S993tC5oWwiaIu94WZ0g
Cmi/QZDkFD0kj0GJSnJlesrn/38FRdAHBAx5zPG4IIudQH5kIDzMBCwoz/7x4Am9
JNLd7EKQLd7dQxCi6rypkrr6F9N3rzsr8NUO0S6hz4IRx1nAOEQ=
=2Phy
-----END PGP SIGNATURE-----

--5JrQbDbVSoe0zJtM--
