Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28DD477592
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbhLPPQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhLPPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:16:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35861C061574;
        Thu, 16 Dec 2021 07:16:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so44769194wrw.10;
        Thu, 16 Dec 2021 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YY9FZgJmPcsrvv1dDjxqyVtz1nIgdkKk67xLM0ZtgAc=;
        b=GZcyGrESDUijhcGlmAgDyEACRWE72v4x7GWiBc6yS2aH74dRCA1Y3+gZd+icRAsgk/
         jbEcpMe5d5KSkMbBICkq/rqdm7In9kQza4dIWoDlt2lPrFbK3yY4LA8oGN5UKwJqj1Dt
         YaxYzweyskLjTCLMPGTDmov4lCKWtXsCmBnQys9ei1xj2X9jFCDK3SYckJ5caCREGz2L
         z7W9HEj7osEIDxJl8Qr9dzT/KRzzkF56K6qj+GTSCbZsWklb/NK/uE5WFRQj5QHUK0CB
         hrYBrYek82ZOp7Zf8HpnFsJWo3rPyNWJDYBbyQ0wWfUJnyWKH5PEwcujoLmeJqg5pNPt
         P1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YY9FZgJmPcsrvv1dDjxqyVtz1nIgdkKk67xLM0ZtgAc=;
        b=c5wY8CbMD9wUVw/682owvz07gkv3nf1wLcmVfbO7Nmv7Y8cNAvp5vP0Rv2cO8SDOnO
         O43xyZqR3qDTlTmLWDZ2bEKTApQJ/kwj6gw3vC6lFMAg24zsE6MzplVRrDInZ9pVUyn9
         Ifply1YD+CAZVkp9TTL388spwEXbQeP+Rm2yKMQdQrfpq5xLs+bwf0ZXdbC2cWJDwxdP
         6VwKgl9P5ROiKhqciFiS7TFUg+BiHxh3st2g+Od0f4hTtnWTLWnWB1JgGiNYp8vpUQf1
         LgSx0Sc+Mxg/k9vGyjuVBuH9UHXq/7r7SQsryFeDwsPrViSMCOIQPKNzZmZcxCiYZbe2
         fXrQ==
X-Gm-Message-State: AOAM533PcWxZUMqEz9UzpyqbBzLncYwBSKoXK4rn/jY8naigbJbfPXqy
        4EN1JsgpjlvHTtR63FSoflTdDYbHwljfnw==
X-Google-Smtp-Source: ABdhPJxBH32FXzbEF9kfDCQM7O3XzmCGCPyYvwo7dy80ekk+7njHTBz0zzBJAx5/tRWBcopUFGXr/g==
X-Received: by 2002:adf:f189:: with SMTP id h9mr9495198wro.463.1639667802831;
        Thu, 16 Dec 2021 07:16:42 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id b132sm4989939wmd.38.2021.12.16.07.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:16:41 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:16:38 +0100
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
Subject: Re: [PATCH v4 06/22] ASoC: tegra20-spdif: stop setting slave_id
Message-ID: <YbtYVss3y8lgK1Z3@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5K+xSKWjsvh7cW7"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-7-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5K+xSKWjsvh7cW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:09PM +0300, Dmitry Osipenko wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The DMA resource is never set up anywhere, and passing this as slave_id
> has not been the proper procedure in a long time.
>=20
> As a preparation for removing all slave_id references from the ALSA code,
> remove this one.
>=20
> According to Dmitry Osipenko, this driver has never been used and
> the mechanism for configuring DMA would not work as it is implemented,
> so this part will get rewritten when the driver gets put into use
> again in the future.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/tegra/tegra20_spdif.c | 1 -
>  1 file changed, 1 deletion(-)

In case you want to pick this up into the ASoC tree and Vinod removes it
=66rom the DMA tree:

Acked-by: Thierry Reding <treding@nvidia.com>

--f5K+xSKWjsvh7cW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7WFYACgkQ3SOs138+
s6Hi7A//WvSC6HaD4dz2sE4APvQvLcrg7UUf4Q12zWYMoso91uXcLGSE4K7y12yD
bkRiCDYCsAmW2VCzapWMjLeTvpoUvVQPVDnZyXT/iY53m8GThFqnhNUZV+SUu4hx
oYuH2I7i+2frmjS9b7HglTBshVz6ALvn+vCmS7sXzYbGVsv4BYc338j2P5s6R0NT
AcoYb6/pav05eUTHLq086ipVUz9FxstCDhqq4A0x/7SJcY7TvVTzel9aqD6nfEiF
LGzc7df6QzFkTkhu91FPKi0RiumCbQw4d4Gdm7c3wk3f6s6dLJoZ90HCCmxT9I+Y
jUPPIjpmZl70RNDoWByu884ySe3b02sSGY1a5oLcOuBYx/M34rMo0mj71zHEKdQi
IrD1Ayniv0NRnwNwkR7CwGJtMjB2mO15h8uEL5ujqWFHAqkwd3pNOx8m3DPo8pP0
hpgHdTy0ogufgEy+Zs/V+w17WQVH/++zlxRJHvjfjWaAmJgBIP5jDJKpOtsZFxjd
YLY35vN7331mQkzZZPfYyCna7q1qHEOm3UwRNzyVp0fuozZHl0GQBRQDB8q7emQB
RROAE/QWJd7we/mF85Wfs8nKfYinG/iLM22oMZ6ZHIa81CoIiAXV7Ao89pDxCHcX
A8b8dTnu42raqD/1R1Pb549QpdaPaIRHl6d43FzCPuETRCMIbpk=
=o3sP
-----END PGP SIGNATURE-----

--f5K+xSKWjsvh7cW7--
