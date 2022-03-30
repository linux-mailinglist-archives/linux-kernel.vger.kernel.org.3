Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD04EBEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbiC3KjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245481AbiC3KjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:39:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD412C673;
        Wed, 30 Mar 2022 03:37:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z92so23848803ede.13;
        Wed, 30 Mar 2022 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zk0PakqhMYo2nFjmrTKxunyt2MpesAgQERWC2WnfNEk=;
        b=qtB20WeQ8TqlA5Az/Y82F+D7x/DnDTFKbEzzFPSMBk0QRxFPiiRUGmWElNr2kbE9vD
         Gfcy3Q9HTiwvBsb7+8eSkCqzWmPE42L6sDxbqqgDapgUufsDVmdujlzTukO+yeqnpMxS
         hs+XySx0uq4x20C9bpF/3udDDwX7Hw1+hV2eQlBYHNd99uNHRN+BlLksKbOnjnXykiG/
         UU3JwQ+f6jKnjIp37pISID9iryLk7UfNteJgXzLMNvnjAyyPC+fH+oADq0eC0J0Ebhr1
         ZR5ZC4PM1hMfCWp96oIF4tDmHrETVbhAeZJim8Z1X4WJ/CinwApkMzeozj7SKZQlhUtC
         /faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zk0PakqhMYo2nFjmrTKxunyt2MpesAgQERWC2WnfNEk=;
        b=wYTVN2SWLfBGYocUOMF4MuWqUkTuBD+OgWP5NAbmpzqVefA+kZL55vyBqf2h+qllcL
         YMjvdmf1vbcLhTxZG2wxIMcRw9Xv2sV1lMfDGvCcFytzvgtXKiS+3zvTZZkUDmmQiHdZ
         J9jDw382ube3XP2RIv155dWuWhcgUPyhUrwr36J05J482vJdwQzcwIIYh4OUQvwlpWnr
         qA3cZJyqNhmK4LxTMtLcklRW7pFBRwS+tDdCzslkTIcBAeZAZHA5xBKFbjPpSZqZXYWQ
         UUd0fQtOEl53mdsj08tVU75W6HSS3hX4JRnwh10/mwTSUzJczW+b5gMg98l7EIgcGw+b
         oz8g==
X-Gm-Message-State: AOAM530LfW/p4OUBYKHoG2S70iXjTpF+YRSvH56EwxJUNvPE6zB/MMHr
        52XZPvqD9kN/y8TATGiawwffg9Nioeg=
X-Google-Smtp-Source: ABdhPJw9D+m3ZJO4IlSutzipSpKEnO5i52pnHm9z5H4lL7rXz7bfI7kYfdoWNGgI3f6lSq8FklVM3A==
X-Received: by 2002:a50:8707:0:b0:41a:68df:1a6e with SMTP id i7-20020a508707000000b0041a68df1a6emr9756964edb.31.1648636644169;
        Wed, 30 Mar 2022 03:37:24 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402280e00b0041957289726sm10438767ede.79.2022.03.30.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:37:23 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:37:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Ashish Mhetre <amhetre@nvidia.com>, jonathanh@nvidia.com,
        vdumpa@nvidia.com, will@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Snikam@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [Patch v1] iommu: arm-smmu: Use arm-smmu-nvidia impl for Tegra234
Message-ID: <YkQy4W07fe+PlcT/@orome>
References: <20220329044436.27732-1-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/KyzvAGB3/jpeRiy"
Content-Disposition: inline
In-Reply-To: <20220329044436.27732-1-amhetre@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/KyzvAGB3/jpeRiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2022 at 10:14:36AM +0530, Ashish Mhetre wrote:
> Tegra234 has 2 pairs of ARM MMU-500 instances. Each pair is used
> together and should be programmed identically.
> Add compatible string of Tegra234 iommu nodes in arm_smmu_impl_init()
> so that arm-smmu-nvidia implementation will be used for programming
> these SMMU instances.
>=20
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I already sent out this patch a couple of months ago, though I realize
that it still hasn't been applied:

	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D276030

Joerg, any chance we can still get that series into v5.18? I've already
applied patch 4 given that Rob had acked the DT bindings changes. I know
it's a bit late, but this has been on the list for a couple of months
and has Rob's Reviewed-by on the bindings and Will's Acked-by on the ARM
SMMU driver patches.

If it's too late for v5.18, is there anything else you're waiting for so
that this can go into v5.19?

Thanks,
Thierry

--/KyzvAGB3/jpeRiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJEMuEACgkQ3SOs138+
s6HlOg//TjNJ4z0WyKy0AxRsqlIcw2z3MucsPxsaWi4GkY7aRO7MwWwkFgO47mZZ
eQ+C5Jqy6la7Z9jWrpjDqKUDS7LqNIHq0u5sC+i2eEmmk+97aejtm5LwguwOp1qv
3zq88Yy8OjA+sfH8wwQ3stqmnNNHMS56eqAgNlItBbiDkreYsR75TtAOhu7zrJZa
UABYC3Uhl4fYAJUiWI9Acf/ggrvCk8q6h/XNL0eRzxXY4s7nvOBWkTJHDqiGlTUG
TsqGx9w3T5IVbB+gkYMy/vW24HbeE19eYCgSxXXcR2sbBCB/eFXdG9SsfIQiUT37
KR6nriHdNNmR4mrGQPWfhj1Myo5DW59aRNliWvJWE7lpNpUo1OvIrX7s1WPYIvLn
ooc7da5IFZgFsD6QQX6DaM58pZeYvMmgzwB2dtbq5D/6UEDlsiSFb4nunHkfVuZO
yQT+7Xh2ck0kxnugqvEij9UzGXBjLZkeBlUGhs7+0KIUFUekRuh/ppbL1ZtijQNA
Um4IeRw425O7qRDbBwl/T9sxeKIJif//QbUKrNHCeXaiyRApf54DnQOTbY3YbTdE
9bTHNbC1Q+fUS92lRe+DpFVUPVvjZeti5lUcFqyfMDrqEumIa7zK9vorP4w6/QQK
LTCzBjImHuiI7mrEuRkRGFfM6a6emMdmPrVHyyHY4BrM0c8D1tc=
=8a7i
-----END PGP SIGNATURE-----

--/KyzvAGB3/jpeRiy--
