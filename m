Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060064703BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhLJPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbhLJPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:25:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B04C061746;
        Fri, 10 Dec 2021 07:22:19 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j3so15551485wrp.1;
        Fri, 10 Dec 2021 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jnwba4bZjLq5RdhOQVSpoiV3VIIFnQHgzq6yln7hbIM=;
        b=ipFuXk59Dbzxv+IW1pqe3zwl2tPFuRdtGzbi2GkerIVVR5YEUtK6VhO11qqcECuezO
         BxCc1PLVya1tw6yxoJWafKOag64FcjhVA8Do8a/AfI80Napz3R6tH67rgZT5cCR+gTIo
         LPkdIYHBhkw59s7633lktVm1mNSr4SEW1jLHHTOe81bBJMD2bl45ixAC2UVUYWYnt0Nt
         aC9R7Tl3p6aSeAWQ3i3N0cIvjqJi8JanNGecB2W49UtVj9aF5efFHVxHcxXI21bgdyQ7
         YYgJILE1tsXuFtEq7e9EH5hPyGfytKaa3dvUPYFCpzXpovzAA6bvp/yR/zQ1YACjZ/Xz
         J5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jnwba4bZjLq5RdhOQVSpoiV3VIIFnQHgzq6yln7hbIM=;
        b=hpfDBdhI9qZAk9C/M1wCBM3F+Kasfmkb/wZDbsnpWQlpqbHXRLc2MC6dFDoebptASD
         Q9M3ncXzCBMLE1DrP705xYGYxHeKeRLUw6iI7eWTrhYQbGlQbRFAlz+Mm/qaUS4SDebB
         XqzOmYHVrymEWHPG/0kDuGhN7OR/uu2VQgxhcWHdxwgg2OPSXaFl+uyxV4tk47bfcLO/
         PDQ3JiVzFgyOW1dOWoKq7K+Rjg3lWGOAfhWWVD9I+NGJuwsa4U5OLIsQ5m62NP6gssCo
         j716HRpZXBZKWX4axNisf77nmMn2LmNXVlAwlcGXZ1xu60NJu7aPUNOxMRff3Wh366GG
         6ddg==
X-Gm-Message-State: AOAM532NatNfILUB7nhKwk6McRFfPDRjg9QyIYbd0+VDnhmy/773PMBm
        URPlIJhRO6fIf8ri/HQXPgU=
X-Google-Smtp-Source: ABdhPJxzXqCHZ5Qv9ATTXNRDO6EVE3SyE7fZi3Qxy3ZhjwIYvc/zez/pO+TuwILJQi6/dxfae5AkxA==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr15078105wrm.431.1639149737976;
        Fri, 10 Dec 2021 07:22:17 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id t127sm12355478wma.9.2021.12.10.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:22:16 -0800 (PST)
Date:   Fri, 10 Dec 2021 16:22:13 +0100
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
Subject: Re: [PATCH v5 03/24] ARM: tegra: Add labels to tegra30.dtsi
Message-ID: <YbNwpWpEW4EKHd2R@orome>
References: <20211208173609.4064-1-digetx@gmail.com>
 <20211208173609.4064-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RFgBf0dxqJCnzj+c"
Content-Disposition: inline
In-Reply-To: <20211208173609.4064-4-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RFgBf0dxqJCnzj+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 08:35:48PM +0300, Dmitry Osipenko wrote:
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> Add phandle names for memory/I2C/SPI/USB/SDMMC controller nodes to allow
> for cleaner device descriptions.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 36 +++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

We typically only add those when they are really needed. These are
technically harmless because without a reference, DTC won't actually
create a phandle property, but dangling labels are the kind of thing
that some janitor may at some point want to remove with some scripts,
so I'm hesitant to apply this because it'll likely cause churn in the
future.

Thierry

--RFgBf0dxqJCnzj+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGzcKUACgkQ3SOs138+
s6GftA/+KbVHvJu3VYIbmIUpoJYVbJBgJIylYA73m5ii010cLhvZb8ojspNZLof6
VaHjhKCUqfYy3BabVIbMqLleHzCIBZPSw9SWGkP/yp8SajHZxKrT3ZGqzTnl+QAF
OZVDjO65wWx81upZHinaysN3tEPJaRjrJhaq0QoiNVnyO8AYvvgq7E8SyfBYBd6B
mp+gomXAjzn2I/TxP2xpIJesaYnUURATdbu/Sb4S/r1x4eoIH7tELC8LSgAqNfZy
GPUPFJ6Fd4TS4YCFuC2/5oJt5Cfsw4wz/uA2AlGhWiI9zoHcKj2B4D0sOVwnn0AZ
Wso4V9kfiZ1+eeALg5q14CU3YFfb/CmsyFrwEdQKV4V+Kvg5VMHIYHOhMgBtO+AR
jS6cGt4NrgfRNq2PELeT3ns9/nUR7vyW+faJ9r6vXcH/HyB5JcF0ZSDQusVlO+3V
GTmiIQ0NWwHCckD0l3Ha5tZhfG6X124fV4nX4R7JcP4sMxX8+GtX985Ab/Xusmnt
VKgUytPXJ3Mj2eOHEca9WgvtNxESOc1Ki7qDbq2bAI7RxxZcND4JwSqE7dLfy1RA
3+9KTAi4+MrK26QUv1FDSLIDNtwu1cOJx7Rjzg1UswoZuVZY8MxzYiz5qzLSvsIr
ddK9gDNE1V+4S2H8gc6yF5+NwdrQADORfe4/N6P1+4ww+1nrVhc=
=WGJZ
-----END PGP SIGNATURE-----

--RFgBf0dxqJCnzj+c--
