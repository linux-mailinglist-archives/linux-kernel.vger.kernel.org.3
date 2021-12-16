Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885704775FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhLPPb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhLPPb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:31:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8C8C061574;
        Thu, 16 Dec 2021 07:31:26 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o13so44805530wrs.12;
        Thu, 16 Dec 2021 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sts3JGyfN1WuKgg88vZXBQQlHHEJeYISoHb+lIrYjpI=;
        b=OI/lA3kVbaJDD/afsQSi+J36E2JqDxVXvOowE3TBOFNTrX1O3LczxrTihQ1jr6Ux6f
         ovaLEraU36ANee/qN+2S8S2u/FdMucEzq/hFYUrnE5bdNBZUd2/3iL9s9yR8moc3CZMU
         Ag5+NZCv2EM7gw8WWiN98BkkFWIS5jCXHKWRcq8FrmRoZ5HDS0i5wSh3wcN+ZOwrtWWO
         O7YH0NPO0KSE+LDkUNWT/cRYfL/tKOdqbASlL9LB5xUnPbcqkw5Qjxu+maa3lETPxwPK
         Nnz1cAva20b7kryGV92hhutdsvoEydLKblUacrE1FntjJzhyX0BXb0uozsSWZ4q3IKDQ
         psfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sts3JGyfN1WuKgg88vZXBQQlHHEJeYISoHb+lIrYjpI=;
        b=Ls0V9VgAfNRiLa6PJ8jhr9Ld1/53eCK/f2N85+OPxgjARNB739FfBRo6sH+w1HeBz+
         gJcIBXQR7acylTKbc/AvJs4WivccBSB74N0JaN79+muvOV+D7Z00In9bF5nNLfpFllLk
         5wp9CgHbsl0Mu5HWCNlpChG6zG3Cum4NsiJ/6sTWKwFJ2kRsHT7yk4Co+tr+PhI5j3oW
         azm91/JZPL5JsEclz6HO6jxdsjpu1jcaw7cJnGV0zdfCflVYiQ6pnZ9wJe1R411m8kNL
         +G/5rQVtZi5f1JJpGL3f4UrJk769wZhaN/PHOUeZ7dt12Iyfy0Hyx0mAU2U8NTLodexc
         oIjw==
X-Gm-Message-State: AOAM533JZ+0chla0ZZFBMetxRtRL17Jpa3jx9lSNoYJnA27Itj+mbc19
        ofY5nmPKiUe6ra7zjFI2BvI=
X-Google-Smtp-Source: ABdhPJx1GRSUJgkEQM02MsqnuDNU/r4aWmqUaySJJcyuR/EPQN8tAfIjZJbeWsV+oiDXQvB/S//viQ==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr7296693wrq.460.1639668684641;
        Thu, 16 Dec 2021 07:31:24 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id d2sm1204462wrw.26.2021.12.16.07.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:31:23 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:31:19 +0100
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
Subject: Re: [PATCH v4 13/22] ASoC: tegra20: i2s: Filter out unsupported rates
Message-ID: <Ybtbx8gQJaSsOjGM@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S1udWQXOrWShk0yg"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-14-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S1udWQXOrWShk0yg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:16PM +0300, Dmitry Osipenko wrote:
> Support new nvidia,fixed-parent-rate device-tree property which instructs
> I2S that board wants parent clock rate to stay at a fixed rate. This allo=
ws
> to play audio over S/PDIF and I2S simultaneously. The root of the problem
> is that audio components on Tegra share the same audio PLL, and thus, only
> a subset of rates can be supported if we want to play audio simultaneousl=
y.
> Filter out audio rates that don't match parent clock rate if device-tree
> has the nvidia,fixed-parent-rate property.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/soc/tegra/tegra20_i2s.c | 49 +++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--S1udWQXOrWShk0yg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7W8cACgkQ3SOs138+
s6HSMxAAwX26l+Dg3mv4WaTtS1H3RdqOzt4vyKt0XKp31P44er319zd2Zg254d+i
TawtYdaIqqfVp0nnU21mXGkCdKeI3PYuKMAIkwxr/oqKEz0DXJ3x75+MqGDkX1Xb
CI8kio5xGDi/8WDUmEaItKjlQtysVAS+cqxVpJ6sQ2dCuG03laCvX/P7y/41nYDE
8cVJwGIUu4e7yQ2E9yi2kJqvOfFn/NyA4tyPjAYpFLRI0LiaHioczQNKGkhr3Ecm
FA71vbV3hF/pJ2ygRzKbHKu/9PE08xKkOl6pWgFJSkJ8LGXZjGs5Kx4f0V97r/hK
BrKqrPgG06GCrbI8q4UjGh18GKe4tt1Cu7cX6ak+t6s4tqvIVF45dHFPlHnltpFD
E4x83Tp0qJdcsAOEI8HdnvcIeCKXH9Pz5f+ekHaAVrify7kb+He2L+7b8GzEYwPz
zx5pG+3XisWQog3Ir9UJn4S9SxzLG66SQRVV0tChf6HRbBHp2GqnlmzlJk4nh69+
pCdGvwBd+JGXiuW0EEkh4eGdhYvN7rC9B9gTIJXBGtvEW7qRApHzMtSs8+LQJtat
apPcE2u1SQIL3QWH8SMNZjdkYOIM4CTkrLK2WotRkJajW5mmt7NZJMEfkSjGiOzL
eNMAkyoaWEU/Ne3yVSXk5P1nIvrecBIJnQMYh/fpb8tyFzgPDVo=
=8pKh
-----END PGP SIGNATURE-----

--S1udWQXOrWShk0yg--
