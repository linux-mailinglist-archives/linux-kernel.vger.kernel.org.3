Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FEB512AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiD1Fhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1Fhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:37:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5457656753;
        Wed, 27 Apr 2022 22:34:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k27so4234555edk.4;
        Wed, 27 Apr 2022 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBSM19WHQrA/ZYWGbJg75BNh3CcfAodaxAUNqq255NU=;
        b=plM7dwWhPQ3jZth62O5SXqLdvRYEn6LJLnS3SMhG1knXt6I4K6PCNUPn/2U4RXzJEK
         /SaMHSqP+YKIfABjIGivVyyZqTVUJ0c+qgHonmvt6ey8B8Hvj+bvxKjmMtfLkykMPVI4
         QJabxuuaZskVSwthx9T7QEIarzSu46DwLY+0vv1lX1vjswWCp1yXwdkOx4uolexbFo1e
         9O5L4mZsrRsUgiqouHlw41R0nlcJAzcMcnW6G2vz52BWuKlLhZziycMXmWIWYFpH27QB
         59cU6+Oaz2XenKYd3FdRR4kzqchxMpCk/8r7eqvEGZx6OYWPnQxXX7oxHXmI6K8uWSFs
         o3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBSM19WHQrA/ZYWGbJg75BNh3CcfAodaxAUNqq255NU=;
        b=rH2vVckBsdCDxJ4sXni9/E2OQtt47laUHiZPtzKE+SUMq7S0UN0cHv6GAqqcbMoJ8D
         1E/xAzjju4oX36taMjYfULteuSNGzy1gQMwCWksE8zF7f1HVxoQ9lZBmVl/sFiz95Zth
         6fQnGJp2iGK5X/i7w5jA0xO35BbYU+xqhCaSLr3iV5oIvJVIsavQCO3g2M01xaHmt3FS
         uqWQ1HbrSkeou4O9iNH4UdhwPUCJ05PJeH3cGs2Q863lsooBR2Zn9iA0iXiyLYQxtY14
         lzMLqFRJP48jIQnI31fgOaLcH92ua0xHGdMHbs+9azuxDe9STEAV9zqXVj4C1h+lJUYb
         U7SQ==
X-Gm-Message-State: AOAM532aBEg6PZBGRxiabV0Jb2Y0imA/wijSc4zCAWm050sFu95PJa8j
        GDQkprmYZ48fcF03CatG5DU=
X-Google-Smtp-Source: ABdhPJxuFhdJ38I6OmBPpApX2mQq7HJRP4HXdI9BJ7CWtg4F08MfhnU+6wRqgvj5ZOzfkTlg3smYQw==
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id z22-20020a50e696000000b00419998d5febmr34607475edm.122.1651124064815;
        Wed, 27 Apr 2022 22:34:24 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id j27-20020a170906255b00b006f379c4323bsm6303285ejb.60.2022.04.27.22.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:34:24 -0700 (PDT)
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
Subject: Re: [PATCH 2/5] iommu/sun50i: Support variants without an external reset
Date:   Thu, 28 Apr 2022 07:34:22 +0200
Message-ID: <2857429.VdNmn5OnKV@jernej-laptop>
In-Reply-To: <20220428010401.11323-3-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org> <20220428010401.11323-3-samuel@sholland.org>
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

Dne =C4=8Detrtek, 28. april 2022 ob 03:03:57 CEST je Samuel Holland napisal=
(a):
> The IOMMU in the Allwinner D1 SoC does not have an external reset line.
>=20
> Only attempt to get the reset on hardware variants which should have one
> according to the binding. And switch from the deprecated function to the
> explicit "exclusive" variant.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
>  drivers/iommu/sun50i-iommu.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index c54ab477b8fd..ec07b60016d3 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -92,6 +92,10 @@
>  #define NUM_PT_ENTRIES			256
>  #define PT_SIZE				(NUM_PT_ENTRIES *=20
PT_ENTRY_SIZE)
>=20
> +struct sun50i_iommu_variant {
> +	bool has_reset;
> +};
> +
>  struct sun50i_iommu {
>  	struct iommu_device iommu;
>=20
> @@ -905,9 +909,14 @@ static irqreturn_t sun50i_iommu_irq(int irq, void
> *dev_id)
>=20
>  static int sun50i_iommu_probe(struct platform_device *pdev)
>  {
> +	const struct sun50i_iommu_variant *variant;
>  	struct sun50i_iommu *iommu;
>  	int ret, irq;
>=20
> +	variant =3D of_device_get_match_data(&pdev->dev);
> +	if (!variant)
> +		return -EINVAL;
> +
>  	iommu =3D devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
>  	if (!iommu)
>  		return -ENOMEM;
> @@ -947,7 +956,8 @@ static int sun50i_iommu_probe(struct platform_device
> *pdev) goto err_free_group;
>  	}
>=20
> -	iommu->reset =3D devm_reset_control_get(&pdev->dev, NULL);
> +	if (variant->has_reset)
> +		iommu->reset =3D devm_reset_control_get_exclusive(&pdev-
>dev, NULL);
>  	if (IS_ERR(iommu->reset)) {
>  		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
>  		ret =3D PTR_ERR(iommu->reset);
> @@ -987,8 +997,12 @@ static int sun50i_iommu_probe(struct platform_device
> *pdev) return ret;
>  }
>=20
> +static const struct sun50i_iommu_variant sun50i_h6_iommu =3D {
> +	.has_reset =3D true,
> +};
> +
>  static const struct of_device_id sun50i_iommu_dt[] =3D {
> -	{ .compatible =3D "allwinner,sun50i-h6-iommu", },
> +	{ .compatible =3D "allwinner,sun50i-h6-iommu", .data =3D=20
&sun50i_h6_iommu },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, sun50i_iommu_dt);




