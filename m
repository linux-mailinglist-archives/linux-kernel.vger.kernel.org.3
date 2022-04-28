Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B029512AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbiD1FiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1FiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:38:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BEC13FBC;
        Wed, 27 Apr 2022 22:35:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e23so4217640eda.11;
        Wed, 27 Apr 2022 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+eUJv9+G15IKxU6f/ds8z9ndhSiLJLYEEsP0KxbxHA=;
        b=ED+2Y6JfSdVUXkpMQIz27N8z4Q5f+APo0eGC7FPjO7L/C6/GDpmhoE4COt0l5gA7ge
         rH7ORahf3k4ZeKalAOKZmYX3t33EqRRDeOYe8Td09u4y7mGAtK+/BYl3i8Hyp6Qwx5HZ
         y7UN625BX4v8/r5BE/7EgXFTPS7T+FGcqiMARQHZcLrMtrIg3tG4UAbvbIJFWmgYFEAA
         AnR/gKZ78siMitch/BVJwDdJMd8e+ftMv/ojheDlyfufWsvfgPYZI49MIOdFVEZsg6FQ
         14VQSJ67DmT2bUWmAG95Yhl2tRx6nTeHMMA7n+3gT0Kk76W6QNFG2psxZZVM760BLUjs
         II2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+eUJv9+G15IKxU6f/ds8z9ndhSiLJLYEEsP0KxbxHA=;
        b=ay4o89VeWfq0CkK3HOhJwCqVBUAfwlShRtwB7ydKGPQiptiPxeLhkBn17Si2ZQSJVt
         o9h0kswAl7O+GWAgLe2RZP6Qb7E5ZWSZ7BObGiCsmp2BdVXj8gcFLTSaYJmxBOlHnKUF
         u0syhVRsJd2gVyhZChtwNwEFRSedQJxdhZCB650karBgrDsHjGHLI4pJUAQmA1DWYw4g
         WN19P2oJYBRnZMxjr54gCASpgGqwoLKqfRJOAy9ie34QeqKDvajLTkANLr87ISnCIAy+
         EabAaGbAs3Q8s2DSIRXSgjn7v+U+8+cuAGPUM2wCgHc3ySIrsuPT/c9W/9t+3N8veKQa
         I89w==
X-Gm-Message-State: AOAM531rRbajIxJBgJ59u6Nv2k59/4vNWJ3UsMvlOjMopyqVC3sWimEN
        WiLCldv0s9lJx4Jw244/5Ow=
X-Google-Smtp-Source: ABdhPJwRmhqGmKmdzX4KIXgkDoCMGASyY4aGra++WokhDjLD8F+KBZu9SF1mTqE2Q+aZ9CJOKTHcUQ==
X-Received: by 2002:a05:6402:5106:b0:425:f733:8d9b with SMTP id m6-20020a056402510600b00425f7338d9bmr15264075edd.326.1651124101019;
        Wed, 27 Apr 2022 22:35:01 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709066c8200b006e4e1b1f875sm7884833ejr.199.2022.04.27.22.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:35:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/5] iommu/sun50i: Add support for the D1 variant
Date:   Thu, 28 Apr 2022 07:34:59 +0200
Message-ID: <2752686.88bMQJbFj6@jernej-laptop>
In-Reply-To: <20220428010401.11323-5-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org> <20220428010401.11323-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 28. april 2022 ob 03:03:59 CEST je Samuel Holland napisal=
(a):
> D1 contains an IOMMU similar to the one in the H6 SoC, but the D1
> variant has no external reset signal. It also has some register
> definition changes, but none that affect the current driver.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
>  drivers/iommu/sun50i-iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index b9e644b93637..1fb707e37fb3 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -999,11 +999,15 @@ static int sun50i_iommu_probe(struct platform_device
> *pdev) return ret;
>  }
>=20
> +static const struct sun50i_iommu_variant sun20i_d1_iommu =3D {
> +};
> +
>  static const struct sun50i_iommu_variant sun50i_h6_iommu =3D {
>  	.has_reset =3D true,
>  };
>=20
>  static const struct of_device_id sun50i_iommu_dt[] =3D {
> +	{ .compatible =3D "allwinner,sun20i-d1-iommu", .data =3D=20
&sun20i_d1_iommu },
>  	{ .compatible =3D "allwinner,sun50i-h6-iommu", .data =3D=20
&sun50i_h6_iommu },
>  	{ /* sentinel */ },
>  };




