Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6965A512B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiD1Fsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiD1Fsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:48:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E20C29C96;
        Wed, 27 Apr 2022 22:45:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e23so4237045eda.11;
        Wed, 27 Apr 2022 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bu1Am+mfc3RBLLJSWrxdM96hFXnw6XnAcu5xdCKTnQI=;
        b=U8hjzI4Jj09EF12s/5KD7XD/HAE5Z7zNZb7gWS9RHKNUrA2CWF+gTT/vZIv/5/mhc8
         4CJxJzlpSuKkDLHXEFMJRhg5iJCgsDrfAdB73ODHYREydYyubRYogza60y9tDwkqlHBy
         SAktsXiJBe+UBiaDkVc07s13Q/ReWDb0YAepyD0q6JPZc/mM+DuZhxVMk6wAXXFpXeIU
         GHGAyDXMSXzV/NlvvE/4Lk43zpBEXxm/LGkQVW16movp2IxXsMjwLSHD5rRbgP640tbP
         f0jsF/V5y+V4YOhKhPSv2HTyEacDMCqakP2v9tx9Obee8bSz44ZVXJf/94aed8paCPST
         5pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bu1Am+mfc3RBLLJSWrxdM96hFXnw6XnAcu5xdCKTnQI=;
        b=WLCmsmf51+sMUYi4TuzcJH4M5Rea3w6vV3LMB2fnjT5LOFkLBJ9DDtWR9Meuis8Ja4
         RcKFSjcHlu8uCDrx8wY0+CGHHJ6OeWojE5rU9KPNAhHM6Sk/3q2zpblUExEfU9DQlPsw
         b/0hBkwHY2a3s1JZcKc7J/+U1LD4+jxe86C+beePGmnDSsD+rIZ4kKSpYYrLt4JK4AVf
         0boLxAVBo4Tgl8qUfsIOdrCpmGrt3dShlJ4ppY/ZzJ+ONAl6L+trIdRvFIY/94oVsWW/
         TvbQ9oCUf/g+xH9CEefcMtmlltDc1XgV333ssKds2wOmCgiDC3XYgP6m9NxwZlO1CTq9
         rRsA==
X-Gm-Message-State: AOAM530fz962SNdzvjT5mHVsRXu/8x3+jNnoXJ1HOx8FzBt6FjkmhrhC
        M/8uLoWZh1iAn4JMqwCCHcU=
X-Google-Smtp-Source: ABdhPJxIesueP7mEJQ7cfZ1GF83jwnUH9gcTViGICL1YvhcSy1woJt6erlqveaurraCCU9ukUVTVCw==
X-Received: by 2002:a50:d79a:0:b0:425:e577:c71a with SMTP id w26-20020a50d79a000000b00425e577c71amr20815339edi.188.1651124734847;
        Wed, 27 Apr 2022 22:45:34 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id z14-20020a170906944e00b006f38c33b6e3sm5970246ejx.68.2022.04.27.22.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:45:34 -0700 (PDT)
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
Subject: Re: [PATCH 0/5] iommu/sun50i: Allwinner D1 support
Date:   Thu, 28 Apr 2022 07:45:33 +0200
Message-ID: <1849776.IobQ9Gjlxr@jernej-laptop>
In-Reply-To: <20220428010401.11323-1-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
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

Hi Samuel!

Dne =C4=8Detrtek, 28. april 2022 ob 03:03:55 CEST je Samuel Holland napisal=
(a):
> D1 is a RISC-V SoC from Allwinner's sunxi family. This series adds IOMMU
> binding and driver support.
>=20
> One piece is still missing to use the IOMMU for DMA allocations: a call
> to iommu_setup_dma_ops(). On ARM64 this is handled by the architecture's
> code. RISC-V does not currently select ARCH_HAS_SETUP_DMA_OPS, but it
> will once Zicbom support[1] is merged.
>=20
> [1]: https://lore.kernel.org/lkml/20220307224620.1933061-2-heiko@sntech.d=
e/
>=20
> So I cannot follow virtio-iommu.c and call iommu_setup_dma_ops() when
> ARCH_HAS_SETUP_DMA_OPS=3Dn. However, if I apply the following patch on top
> of Heiko's non-coherent DMA series, the display engine successfully uses
> the IOMMU to allocate its framebuffer:

Did you test this on any other device than display pipeline? It should be=20
supported by Cedrus too, right? I think there are still some corner cases t=
o=20
fix on Cedrus before IOMMU fully works.

Best regards,
Jernej

>=20
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -6,6 +6,7 @@
>   */
>=20
>  #include <linux/dma-direct.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/mm.h>
>=20
> @@ -53,4 +54,7 @@
>  {
>  	/* If a specific device is dma-coherent, set it here */
>  	dev->dma_coherent =3D coherent;
> +
> +	if (iommu)
> +		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
>  }
>=20
>=20
> Samuel Holland (5):
>   dt-bindings: iommu: sun50i: Add compatible for Allwinner D1
>   iommu/sun50i: Support variants without an external reset
>   iommu/sun50i: Ensure bypass is disabled
>   iommu/sun50i: Add support for the D1 variant
>   iommu/sun50i: Ensure the IOMMU can be used for DMA
>=20
>  .../iommu/allwinner,sun50i-h6-iommu.yaml      | 16 +++++++++++--
>  drivers/iommu/Kconfig                         |  1 +
>  drivers/iommu/sun50i-iommu.c                  | 24 +++++++++++++++++--
>  3 files changed, 37 insertions(+), 4 deletions(-)




