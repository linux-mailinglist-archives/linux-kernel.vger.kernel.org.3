Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA714703B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhLJPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242765AbhLJPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:22:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D5C0617A1;
        Fri, 10 Dec 2021 07:19:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a18so15489901wrn.6;
        Fri, 10 Dec 2021 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8+y55MuKw2WtmHih8yLdWggAVXQsu4nFITssGPO+OeQ=;
        b=QohqBXUphLxcw/Tyiz63NuiKIHQEcshmTTGrE/JsqTZiz8aWMMJyZwSfHw+yVyu3b0
         x9DlZPTYlN5DNeu4XhrXQklO9P6PyNsCbbMPa5ZtUsrZB/Ru1tezDlj+qblLXi32RA0K
         apVZR1dWaQwxm8UgRKAfMSIeeF7GHWUlScScPO1yNxpdMn5tHOScmOv9zBsB5Tx5GVzg
         Ed1W5WJsReoppMy8e/qwH5qDdkseLtKz+c+1rVZfyUk1uvDA1AaDCUPQlGtwnu3pLpQw
         SPpcGzuySusF9rS9FMq+KXkrjG/JgxCifexuD6NRw/z79bubHk4Auw5eoURMfbGn8fzT
         Z+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8+y55MuKw2WtmHih8yLdWggAVXQsu4nFITssGPO+OeQ=;
        b=HIL8skLpT3iNfQlF58EUXk+o3Cc2IXzqXq8QROQkQMi6pRT4ga9cEZEFlGSamGzcdZ
         XawpZOxAkC5STOX20yK64pHOQIdk4to9SP3n6CxeL2jvEgXmbpHK88avLB6y29nVntTi
         0pUJwxQhbQelCX3ZOOifgI14YUvFw2saiyHqyPBBmZQ8vPj+YmlXksBBV2iL46b1+08W
         SOqwX/BV2QcZBBv1PWMk99B4ukiZxyYvcMTje2NcZyHSWkKvNaUSS9b8JnCGOjr45zef
         67SX1pR9UqSSRjJn3JWShA/cknZtsRoii/K02W1kt4umDTIGhWByoeHTKyEy69Brc2a0
         fKFA==
X-Gm-Message-State: AOAM533HtgI7iyacCEkBKaCcO/mq/XJS2PceLHc7jcWe88/Vs3FFQvgn
        DdSZp8UYbaJsZ2bkOhYyKZY=
X-Google-Smtp-Source: ABdhPJwdDolBzpySgD389vxXio7XqOEk27T3r6Dwzqugv4e7W4M9SxAcdX7T4K/i+gt6/ZFCUAmz+Q==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr15175787wrc.193.1639149559577;
        Fri, 10 Dec 2021 07:19:19 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id e18sm2826833wrs.48.2021.12.10.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:19:17 -0800 (PST)
Date:   Fri, 10 Dec 2021 16:19:13 +0100
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
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/24] dt-bindings: ARM: tegra: Document Pegatron
 Chagall
Message-ID: <YbNv8fBpMRTIGZQh@orome>
References: <20211208173609.4064-1-digetx@gmail.com>
 <20211208173609.4064-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MnySrT6ZM7gmN80D"
Content-Disposition: inline
In-Reply-To: <20211208173609.4064-3-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnySrT6ZM7gmN80D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 08:35:47PM +0300, Dmitry Osipenko wrote:
> From: David Heidelberg <david@ixit.cz>
>=20
> Document Pegatron Chagall, which is Tegra30-based tablet device.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
>  1 file changed, 3 insertions(+)

This and many others in the set are missing your Signed-off-by. See
"Developer's Certificate of Origin 1.1" in
Documentation/process/submitting-patches.rst for a rationale why that's
important.

Thierry

--MnySrT6ZM7gmN80D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGzb+8ACgkQ3SOs138+
s6EdhQ/+M5idtwWnfm/tB5H+ArBlzNLkbOLg9/BIcjdA0uS/B6HLuCrkCjj5uI3k
ohj68ROuGQjCl7b2BKNe1amC+EDzecHFsnZMB2rYUzYYNb6vdr7msZqDlaad0PPV
iOKy4eZYUnSh+iVIDintpmk+nIpr1W2vjnTWYX2V8/fq62W6zj2QSn1vpFSdzvDu
hUdnvh4xqc0in37hWa1VikThJx5nj122udTxUlaOYTUEOfSQwpdSmpSl9jjw7viG
DabGmqamMLwS+89JSRnWlSVbaNcldLXMgYJOZFWPuJApifP/4LEDqu+2r7KCUS+6
zfmBUEdFd6CKecBY74YAmC2RBqPWynIK8PlpWzEDFvvgzXmrYZsrR/bSN8J37CY8
0LaSGigNT5UiXc2iGuwrYg59Pz2qoXnWMk6d7+j9dOKK5RkmY73TsutsS4bar275
3GG2evyEg2S98wNLZFAAqnh3O/qhxHlhdliGTTocaEOFMfbg9ew+dEWK25rJEHo0
bhSrgmCd10ztUpuOtRK05EoVoB/uwnLgDRHgCn+q5oE4e+Y/Exgn4fPeg2v/cJXA
ZatdFYop4RMLS2n2Vv2hpzh+5qXltDSjvcEpIinRi4p5p58gYJPVEac9D7Plz2+K
bIZ9j+Hj2+gfJrvNsidkAgtK6nZ8XgXFFzv3T9KpFz1CIlwDD20=
=qJpv
-----END PGP SIGNATURE-----

--MnySrT6ZM7gmN80D--
