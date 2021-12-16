Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24AC476C46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhLPIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLPIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:55:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61945C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:55:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c4so42799749wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SOuxRFXySPzshUyGC5iL0C2CvH+JBhvny1eTkHaCuAk=;
        b=C3+lWk3b0y78VVa5eWSCceWoMVKh8OoLiXVo7+b6aykRMYMZS84tnO1iY3ilDuL+9S
         kNFtEfRVtO639culhM0FpOo4Y5s9vMHKmSsjGZuezi40pU5i8mpnOQ3RS+oeaRMH3hl9
         pPN24fNaNFy0a9PsTywZjzg/vJ29iwzznOpSkfNmKYcxwRecN9Ii8967W2bG+MsJYOzd
         zipVfIzveylYNsmoBr6s3JwYXRZnmQ2MZdQL4HlJjlJcy9Yugxhwqe9D+SjsSbm+OJ0B
         hqYQy30NATx1d4buHLlzpvm/LnePURXPW/Ml0FrbTWnDlmXYjVLLhwVt0JIVC5anZtg1
         swTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOuxRFXySPzshUyGC5iL0C2CvH+JBhvny1eTkHaCuAk=;
        b=uLsUfQ/yZf6Pi8BW9pdhe+8sj3gxQHwIUHQWDLGJ/9KXhnuJvN1MmSPPyoIBuZIMvy
         aAza8Gx/ClzUy0ta3VIULOxaQgrg9lbm/QRDQA+13tvmIDkEVIsUmLEQpnB6b0F/SiHc
         L7+K2TqilDRexUGSbIxr77l68goaWz4JrCG+KyIblNY058reUExuvmhQ8wFClrYkCK5I
         76r7KCdDOnOeY+io8LEQ0k7dUDRwh+9QbX/DhxL9H97N7AlXzvSWq7BaRi1DIk4ULMl5
         Gvvw2xoahjM6GRy0rhFRynzIV4i9lmLw47GbD0ELhXOMsYOQjxR9I1FysgfBqCZ/dQeL
         QR9Q==
X-Gm-Message-State: AOAM533ypz/UnsrUbNsX7i48BD9cWPW2DUf3J7E7Dlcw7O+skstNORpr
        t2SYRyuHVdF71+J62q1vre8=
X-Google-Smtp-Source: ABdhPJwbtAMNBx3u2dBIsPqwFJsMFEOrlFqylkByzKob5f0kf3vZdqodg/kqdagKi6U3S/JWjAH3Vg==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr7678332wru.397.1639644943821;
        Thu, 16 Dec 2021 00:55:43 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id w15sm4090586wrk.77.2021.12.16.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:55:42 -0800 (PST)
Date:   Thu, 16 Dec 2021 09:55:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, linux-mm@kvack.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 03/11] drm/tegra: vic: Fix DMA API misuse
Message-ID: <Ybr/C+GNFPDPgLnF@orome>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xaI96K7vWbm32g6g"
Content-Disposition: inline
In-Reply-To: <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xaI96K7vWbm32g6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 05:54:44PM +0000, Robin Murphy wrote:
> Upon failure, dma_alloc_coherent() returns NULL. If that does happen,
> passing some uninitialised stack contents to dma_mapping_error() - which
> belongs to a different API in the first place - has precious little
> chance of detecting it.
>=20
> Also include the correct header, because the fragile transitive
> inclusion currently providing it is going to break soon.
>=20
> Fixes: 20e7dce255e9 ("drm/tegra: Remove memory allocation from Falcon lib=
rary")
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Mikko Perttunen <mperttunen@nvidia.com>
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>=20
> ---
>=20
> It also doesn't appear to handle failure of the tegra_drm_alloc() path
> either, but that's a loose thread I have no desire to pull on... ;)
>=20
> v2: Resend as part of the series, originally posted separately here:
>=20
> https://lore.kernel.org/dri-devel/2703882439344010e33bf21ecd63cf9e5e6dc00=
d.1637781007.git.robin.murphy@arm.com/
>=20
>  drivers/gpu/drm/tegra/vic.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks. I've also fixed up the missing failure handling for
tegra_drm_alloc(), which was actually quite trivial to do.

Thierry

--xaI96K7vWbm32g6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6/wsACgkQ3SOs138+
s6G5Ng//YzfjTiVGwWVICqHpvgQHCcZ8oVaca2ULy6V9X+H0OOwBsrnOOsQRNQPN
bhUymR2MvtF7CGkWXSLcLBInR683ccLJefYom3K7kd/Lf1bptAbYsIIR6mEU/iHF
dgk52WgEANXqXpjIkny9hIQdmgjL4ilBS9vwZnBniFIfNTAER2fEy3CsfvoQnkC6
0ZoB9zaj+a+PBUy2oGB0K51wzoYWglCG5sbD94eeztUwdZtnWcFz8FpYWLVZQgvb
OH7mgLECdjDiu6ZJ+/h57xcO2gR0NhEPOlq5fhyWd6M2OMcqmwE4xEmH14zyq1RS
maeLK89xm8X7BCEneOai8B70OH2nzW7dHYMFT33WWJOVzvfX9jBzTn5aMxif8T1x
NYoJew1GJDCvc0hE1SQyWLqfomvVE9Ctod8pgR18us9XMn0jhQZ9+9frVE661g7C
0ATJ+ekU7msdPeQGG+gIgOoBI1nxVlhMyaeiEA5ZUI7jaa118EAS5o7RFHGW55yu
YTmw+ZiJ1Oqtm+sJIco6G4z30Su+rsAo99K0lALgJ0op2uBibF49yGyoDvfM/k62
7fgmTjnj2tA/V4isGVdH8/JjF8gvferm8YCBh2PZlArczHEUTOh1hIoNwxGOGIG7
y02bpMz2KLrRaOdf+ut96A/t1b+aUMiwgnH1cOyt1cy7SuBVvjU=
=+ED4
-----END PGP SIGNATURE-----

--xaI96K7vWbm32g6g--
