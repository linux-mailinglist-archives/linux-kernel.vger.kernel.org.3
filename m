Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9954F4B8AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiBPNss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:48:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiBPNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:48:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3449C7F6D2;
        Wed, 16 Feb 2022 05:48:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g7so4020802edb.5;
        Wed, 16 Feb 2022 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FlRChV2ED66U1fV2UHlPevpzTBOWajWUQYxF7iIvvyk=;
        b=qv/vc03s2YbobtXaOohRYrtMGKaiPeoul7yaXpDYp9Y8BCPMXPgdTH8hkDVyyxKKzc
         ieV6spSKvomI4/UXpEouoWG/oY9V63xQPHlTU7P8iAwoRd29MbwfCS8x/HPZ5daqjKpo
         7FdSTmIpY9smQlACRWFTIsUn6Yas6dm9VrbtgNW1T/+ZOmd2WVPBUWzcCbXeXRwIa3o4
         fABK7daW4Y09JE81WsWyCmDM2Bv/HN7mg7tAmU2psxcdCsBBqOLelrT9DmZkY4ZIyPdO
         QwG4SrNtCZ5km0oe8JP1kO67fwzSI4/gG2rx79OPI5NhQQTn+zqAfRivbZNvEsonmdYa
         NbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FlRChV2ED66U1fV2UHlPevpzTBOWajWUQYxF7iIvvyk=;
        b=C+3Pt4+OawqGHF4kDeyy4NfGCYOeUNDp3AVlH9SgLL/oy5dbj1LLd480l+W1fTAwrX
         z9mCbSXWjyH0yRH1jooT9oiCJGbOeqkJVTLUfK+TwJX2JdWuQeX1JBY9VHsO56YKCV66
         EEQq0gEG5yoOSNWAsa3v3HKD8lSG1GMd9pl6DYjQLaOXRY/efbHJ4IGk6ClMZVJRUhIe
         owQceMo6/L5blzF8JWry/bnLLbKRzMZfhxf92rSjMLTXlJu5LD062YQ6B/fTtjJ/R9Wx
         snE0ficbiHOz9UUDoUxmQ8xl1Juw6mcEiEp5LP2wpbzfnSzy5QiLooYuZdXu2OXrg9QY
         3JNQ==
X-Gm-Message-State: AOAM532hI/RvkTIw74bcuNaX2efjth1Z71baujD0uH6s3yseUuAjoso4
        82vFk6ft2seuXolYUmVbWwI=
X-Google-Smtp-Source: ABdhPJywvjh3cUfTL6Z618E7/SfBQBXo7KQhw71ZpUbdF4ZEaTN3AkTWga5vyZBBC2CiwwhHXNUqdQ==
X-Received: by 2002:a05:6402:2694:b0:411:f0b1:7f90 with SMTP id w20-20020a056402269400b00411f0b17f90mr2995670edd.398.1645019310575;
        Wed, 16 Feb 2022 05:48:30 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id p25sm5245206ejn.33.2022.02.16.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:48:29 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:48:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra-smmu: Fix missing put_device() call in
 tegra_smmu_find
Message-ID: <Yg0AqkLA7eXQOuh2@orome>
References: <20220107080915.12686-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="enq9AsaXPXANugPJ"
Content-Disposition: inline
In-Reply-To: <20220107080915.12686-1-linmq006@gmail.com>
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--enq9AsaXPXANugPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 08:09:11AM +0000, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
>=20
> Fixes: 765a9d1d02b2 ("iommu/tegra-smmu: Fix mc errors on tegra124-nyan")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e900e3c46903..2561ce8a2ce8 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -808,8 +808,10 @@ static struct tegra_smmu *tegra_smmu_find(struct dev=
ice_node *np)
>  		return NULL;
> =20
>  	mc =3D platform_get_drvdata(pdev);
> -	if (!mc)
> +	if (!mc) {
> +		put_device(&pdev->dev);
>  		return NULL;
> +	}
> =20
>  	return mc->smmu;
>  }

Sorry for the late reply, looks correct. We probably also need a similar
call in ->release_device(). I also wonder if we should be returning an
-EPROBE_DEFER here, which is technically the correct thing to do, though
in practice that will likely never happen because these pointers are set
during an arch_initcall, so should always be available by the time a
driver tries to attach to an IOMMU.

Acked-by: Thierry Reding <treding@nvidia.com>

--enq9AsaXPXANugPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmINAKcACgkQ3SOs138+
s6E1Dw/+JdYuxQb5lyl9zrWDXni3KEEqylRty/S9yBZqB5op/xogYj6rZ/tCOc66
CAA/cFSERk918QsbfuuajpAwiDBoivU8XAjn2pRhwfS30pE1wttCbvnYx/Pa6fhj
rFCI7P86LtlW8ppsKt2j2YE6Ro6iBe78vMu2NHsRyF/dTqdF77LBBbHc/1D7jvKJ
E516Wgps8uBmnElGaBXaWqBJm9gF+1DUcRB2iCqqKoKcZGd4cU1Z97caIfwzmxF8
+Pfy3xsZQUM/q0NEUQkYS24RhFaPIMSlVNJuBq4X8RUkobx/bSaQQybtY+CYeOfE
CdZhCt1Uvwt3REBb4crS1obr39XHDrmg9DPhwBPOxXJdoT+gHntny13RVB9PysER
SXDv62b8R/ZR4ORh9vNSlY355IauVLEJGgRqyloH0W6ylj5QVM1/PEnHUJu+E6Bp
tXAyNRwUfysUryxZgjhVjYTJnCzxhszhR8hPhwk5uxyyyzBI7oB8T9FwIuVukkqW
bw5UvHWlrKj1dQVu1Eup9qn039PjZs4cHldFi9gkjMFAupaS07mAY1FHPe2U1lD0
bq+aIHuenFUa3F+sfC4PTptGWxEcfPWEPk0QHts7FTRLEBwy4b97RLRKHwa942v6
wPzUzR62Raw96lTAPiq8UYPqB82nxDiRTIqalgVPL9DJTyk4lOA=
=FvXw
-----END PGP SIGNATURE-----

--enq9AsaXPXANugPJ--
