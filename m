Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD8512B02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbiD1Fis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243122AbiD1Fil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:38:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59FE26ADE;
        Wed, 27 Apr 2022 22:35:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m20so7287079ejj.10;
        Wed, 27 Apr 2022 22:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6GB1/WywBgvh+64+Tjj1z6mIuDmSgmvtpDpu9gTFhI=;
        b=Sk9QjBASR1ZDnIiWemIfYQHAyckj3WwUQ0Dk1x8vUbtZKw+Ps2RXC6ddu1yuaUfDpB
         gMi/A8uQw0hEu+F47+bjMp3t0QSCs67/abhdlEHByg/jPyQayH7pn4Niiz8YRh5dR/se
         xln6tUHCH2ERr0czmm5bEvYM2ukGDy9YomaBo1EqTSTx4xoNVJ08d1wBBXiam8xKQTnx
         m2eyYfCopyih6EYsIGG1jf7cGgoW/UdVQ6fuA03CTOCzsi1Xz/KgZtBjOu5G13Jw3OOq
         KE1LJORJpVZYpyh+W5+KQw59PhV/1nUPGPeM7fCd356wan6bL63d95Hnn1EfATYDBxWT
         v/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6GB1/WywBgvh+64+Tjj1z6mIuDmSgmvtpDpu9gTFhI=;
        b=DoRgDEIYEPEj1euj7h2BugO3TAIVV2hpoe+27Fe1mb1xZtGtBvAZXASpwf7Ybj6UDB
         FiFoyndOGVH8u0H46dxk7w4WsoXx6O8JkJFgKnn0xpP4lPi5tUDU6g7B8G+AIRj+eU6n
         fg5lGhgOg6Mrx75uasW8fSecElUqwoREC6MLaYgFkBvF1eLh0r3m3TuYlnIrDGqZ3j0O
         BGz1Z8bMOjyCIlBFC8NU2ZS2R1TOao8XPhhz32CAwqCKHc3E41JdVP0hfJZAcYhNJvQJ
         tmfzii0+IroO9dK72zxIX48EfLC06wi8a8a8P5ytElock0zWF0U6Eskupg8E6xwpUe7y
         gf4A==
X-Gm-Message-State: AOAM5325O/8TyMPoboltbHdNAomx7/+113bJq5b77dQW4kp8izE300ZA
        44Mbemxmfi2feKyF+iHOKwM=
X-Google-Smtp-Source: ABdhPJxOTXVpvT//Cj+0qyGctmcgG8tu4Sgrf5+zvtxXeIcbwKP79h4Ibc/zhuPFP2T8AkYgQw4Smw==
X-Received: by 2002:a17:907:72cd:b0:6f3:a068:a2ce with SMTP id du13-20020a17090772cd00b006f3a068a2cemr16041538ejc.563.1651124126336;
        Wed, 27 Apr 2022 22:35:26 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7cd06000000b0042617ba63a9sm886885edw.51.2022.04.27.22.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:35:25 -0700 (PDT)
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
Subject: Re: [PATCH 5/5] iommu/sun50i: Ensure the IOMMU can be used for DMA
Date:   Thu, 28 Apr 2022 07:35:24 +0200
Message-ID: <1762951.8hzESeGDPO@jernej-laptop>
In-Reply-To: <20220428010401.11323-6-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org> <20220428010401.11323-6-samuel@sholland.org>
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

Dne =C4=8Detrtek, 28. april 2022 ob 03:04:00 CEST je Samuel Holland napisal=
(a):
> So far, the driver has relied on arch/arm64/Kconfig to select IOMMU_DMA.
> Unsurprisingly, this does not work on RISC-V, so the driver must select
> IOMMU_DMA itself.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
>  drivers/iommu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c79a0df090c0..70a0bfa6d907 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -223,6 +223,7 @@ config SUN50I_IOMMU
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	select ARM_DMA_USE_IOMMU
>  	select IOMMU_API
> +	select IOMMU_DMA
>  	help
>  	  Support for the IOMMU introduced in the Allwinner H6 SoCs.




