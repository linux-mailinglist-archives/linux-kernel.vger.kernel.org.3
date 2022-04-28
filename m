Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC4512B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbiD1Fqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiD1Fql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:46:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911F5EDF2;
        Wed, 27 Apr 2022 22:43:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kq17so7354868ejb.4;
        Wed, 27 Apr 2022 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s07a0DsY9s52QkJmiJ36LrahFkWV2t9AjkvfZr/kSYU=;
        b=AoSWjN4/5ia3sJysWSlpJKDFdG/NXjaAcfPIzWtpSV7VXYWAH+TaL+n47Sj1nuCQPi
         J56q+vUiECCLwu3kys9q/Jv1pOUc4MpmGNGfLPbRGLnRnQlsR6GqQZzTdDvhd/Qawh92
         /7oYX4g5gnXixje6OV1O6PG2hG6BTfY8TDrf+zL6dHFRjBtRiDNo5fmZgSzurmzXkvWU
         6bV3KbvuIPI5CN1bqS2frjrHr0uwIWKYxkXFhDlOkezxthjM5PGtwoolbM86cIje0lKr
         vTVdQTiCDjE8/E/f1AI0sSkqNPpeBQsbiI2JxkXRLOf+TlWZzylSoDuwScGjfY10IK+2
         M4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s07a0DsY9s52QkJmiJ36LrahFkWV2t9AjkvfZr/kSYU=;
        b=p4eu2y35cmm0j0r18yJsDYn0AQVnIxp0YWLElNIbkCsthbhrnzjtYzJ525A8IeQbnP
         VHZnfUicsrLHcoZPgi5YwJQFxt3Y5NcXtQPmVtXA7f95WuXIWtDN9i73O3jlLvsg/FA3
         u73f+1aN/mB+vfNgxmXDx2KMI96i6a2K/2vBtYJiOGDRAtQwbWIAbrbCWZPT8nB0dLmO
         jA1KU4nxC/65tRv+MEf4m7vRvjG0k4zA0n9PI2AwH3uhKGfKlRfS26ArImJZgRje1tTz
         XvIgeRrZ5buv8htgA/lXB7O3ci7MTKKsxCfb+0DgicB/MD9ZLeOFpHVYREmwHyDZO8R7
         CASg==
X-Gm-Message-State: AOAM533rw9ye1Tb70SxEgLyGinfWHcB3tWhvwvQcCmxQIWqdbzVzPFwR
        EaFR/H9K5KZOxYabstHcQr0=
X-Google-Smtp-Source: ABdhPJzWJjNdXgo+WbHDrSQuq/2nYg4TWpvGFaOwbQshU+cXykP4HIK3zWEPoWCTdp5k14/cBAAWdw==
X-Received: by 2002:a17:906:1841:b0:6e8:872d:8999 with SMTP id w1-20020a170906184100b006e8872d8999mr29426739eje.492.1651124607032;
        Wed, 27 Apr 2022 22:43:27 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906285900b006f3c813f51fsm2227173ejc.128.2022.04.27.22.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:43:26 -0700 (PDT)
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
Subject: Re: [PATCH 3/5] iommu/sun50i: Ensure bypass is disabled
Date:   Thu, 28 Apr 2022 07:43:25 +0200
Message-ID: <1922960.8hb0ThOEGa@jernej-laptop>
In-Reply-To: <20220428010401.11323-4-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org> <20220428010401.11323-4-samuel@sholland.org>
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

Dne =C4=8Detrtek, 28. april 2022 ob 03:03:58 CEST je Samuel Holland napisal=
(a):
> The H6 variant of the hardware disables bypass by default. The D1
> variant of the hardware enables bypass for all masters by default.
>=20
> Since the driver expects bypass to be disabled, ensure that is the case.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Actually, it would be better to set bypass to 0xff and in=20
sun50i_iommu_attach_device() clear bypass bit for that particular device. A=
s=20
you might notice, index in phandle is currently not used. This would also h=
elp=20
expose bugs, like missing second iommu channel for Cedrus on H6, but that's=
=20
easy to fix.

Best regards,
Jernej

> ---
>=20
>  drivers/iommu/sun50i-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index ec07b60016d3..b9e644b93637 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -374,6 +374,8 @@ static int sun50i_iommu_enable(struct sun50i_iommu
> *iommu)
>=20
>  	spin_lock_irqsave(&iommu->iommu_lock, flags);
>=20
> +	iommu_write(iommu, IOMMU_BYPASS_REG, 0);
> +
>  	iommu_write(iommu, IOMMU_TTB_REG, sun50i_domain->dt_dma);
>  	iommu_write(iommu, IOMMU_TLB_PREFETCH_REG,
>  		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(0) |




