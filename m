Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE294704F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhLJPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhLJPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:53:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2BC061A32;
        Fri, 10 Dec 2021 07:50:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso6945584wmr.5;
        Fri, 10 Dec 2021 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ODdzhhl8ZdFMrrK88abDusryGLbUIj0Lh4fOWPeWSw8=;
        b=UCKM5bzxlPxFnJ3zWFXVphdgBxbCZqAN/l+8nsDHLrWoy2oNoiPnvkmo2wz+MuxLnW
         WAcjVYytWMiYwOOmSJqovuzLx6kxJz+tj+g0jmIMJd6P5o3uep45cYp81kqkWnanQbyd
         0CnK+Rbelqvs1WFLcKxLsqGI+77Ps6UXm11ghMiomm9fU+2jAgKjZsf9dp8aPA+F9PBY
         JS83V+OSbMWeoWwsEtQ/26l7w1HX6IGyByVb3F1lOcyxHBTWqW/N61Op3cdPYLA+479y
         sAojwaK3IHO9OD2dCOP9eZyNOiHbWTX8OKz9X4aDmw0h2787aG0p07CS5rPa9crKABP6
         rFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ODdzhhl8ZdFMrrK88abDusryGLbUIj0Lh4fOWPeWSw8=;
        b=HMvR51grFe/tuejWAm8IrOxSgLYak2NOwcSpmtN5lFCxeUSsJiQHQAUEG9pi487n2X
         XX2hahtmTVbxv9dyX7Li5RrGsTMobLN96R25x7MeuhNBRkiG8NIMXTlbfdJWO+p80YMr
         xYfIe8IyN4fCE3bDXh0vqGqkyPF3yB3yO3NwRnqN4UA0Wwdd93ccsSCNuGQY2cnZxLEf
         rVquZv2PAqbs9EkLyU/IftUc4Oi0R24y6mVhaoQOM/rNMSz0DcFA1/y0PEawLaGg/UWT
         cUJz2wUtr021YAVWME/caHoOO6FJrXhhhKVDrmYcjXzLqk+x3CYEvQ0bhBZTnHOdNtYI
         j0Ig==
X-Gm-Message-State: AOAM532EvDj5FFp4CMj7hi0g+/6uNyAnOMALxHbQ7ADndEAP4uIPW0lu
        0vjdvVxC3Sy0SiveM+p7G9Q=
X-Google-Smtp-Source: ABdhPJwn8W7fYBHhMNf2ILi5nDjJiMbQppURBXn8/SyhkIy2O6pZw9xqlOBrICoPquz1+mvhTka/zw==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr17707480wmq.47.1639151421878;
        Fri, 10 Dec 2021 07:50:21 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id g16sm4096240wmq.20.2021.12.10.07.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:50:20 -0800 (PST)
Date:   Fri, 10 Dec 2021 16:50:17 +0100
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
Subject: Re: [PATCH v5 06/24] ARM: tegra: Add common device-tree base for
 Tegra30 ASUS Transformers
Message-ID: <YbN3OektEKoHY3s1@orome>
References: <20211208173609.4064-1-digetx@gmail.com>
 <20211208173609.4064-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SxYMGIsuJmaT2LMM"
Content-Disposition: inline
In-Reply-To: <20211208173609.4064-7-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SxYMGIsuJmaT2LMM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 08:35:51PM +0300, Dmitry Osipenko wrote:
> From: Svyatoslav Ryhel <clamor95@gmail.com>
>=20
> Add common DTSI for Tegra30 ASUS Transformers. It will be used by multiple
> device-trees of ASUS devices. The common part initially was born out of
> the ASUS TF300T tablet's device-tree that was created by Micha=C5=82 Miro=
s=C5=82aw.
> It was heavily reworked and improved by Svyatoslav Ryhel, Maxim Schwalm,
> Ion Agorria et al.
>=20
> [digetx@gmail.com: factored out common part into separate patch and wrote=
 commit message]
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Co-developed-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> Co-developed-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../dts/tegra30-asus-transformer-common.dtsi  | 1729 +++++++++++++++++
>  1 file changed, 1729 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
>=20
> diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arc=
h/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> new file mode 100644
> index 000000000000..be77212dd8c7
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> @@ -0,0 +1,1729 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +#include "tegra30.dtsi"
> +#include "tegra30-cpu-opp.dtsi"
> +#include "tegra30-cpu-opp-microvolt.dtsi"
> +
> +/ {
> +	chassis-type =3D "convertible";
> +
> +	aliases {
> +		mmc0 =3D &sdmmc4;	/* eMMC */

Looks like a tab snuck in there... otherwise this also has some nodes
sorted in the wrong order.

[...]
> +	pad-keys {

Any specific reason why this is called pad-keys? We call it gpio-keys
everywhere else.

Thierry

--SxYMGIsuJmaT2LMM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGzdzgACgkQ3SOs138+
s6Gy4Q//bskcxKccjBg6l0+Dg1tNy7cS+Zewx8+Q2m5+tAN8oea3chH8mWGp/utb
XU3F0G8j7y75D+/v4KQVkFRI6OXN1owDxy6ClqFNKkPcXg4o6yBWzmny5HRGgLJI
Ep4rMo6V7vV5cSdOfEHer/LEQKPDZE9x2itahoABxZYUUV6HAkNTES4RCNuqWLoD
rt8JQ407o2c463lLozb/6xRj8VyJFYc/YRstsehXVSBxY5zdee4okLIOjGHbJoi0
SaWej8nb0z5z/TFZqw19xf2urgU2McaO9UZNrpGEfajYBU2yLog5G7JMFqc/7mtB
O5l1mMV5R93pRb/WfDFCc5bhbpkCkrg6MQODpvdcNkyFZsVg8OloPPbOz/BeUT44
HZxoxs7HZ/JKy5S91YIsRLIkKpWUejv9SKdzXwfnW035Kc7JpT7pdmq9HjvE6xQ5
CnO8KNGuH2H5UsAh0WswC1xBzIAhjUvRrt6iKz+DcVpZWnwyiQpdAUzlSDkhEsqd
P6upWNO3Dmb0alXdsIkDj4zkGZJVgexhh37FdXJEsVCqjKquF+ETev9Jrrc+b50F
IaHjNSy91rqymMkJYHxZ+VRRcMtoUFnI+TO+6rivjv4jqu+seQwGeQ9+xLpZKFVF
R8yxGH3jurk9AIi4Hc3la/O3hgyRFCLGHx7/Xi04g+y/mppOUrI=
=y1qL
-----END PGP SIGNATURE-----

--SxYMGIsuJmaT2LMM--
