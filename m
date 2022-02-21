Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7125F4BD3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbiBUCoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:44:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbiBUCn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:43:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58600E002;
        Sun, 20 Feb 2022 18:43:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1A65B80E3B;
        Mon, 21 Feb 2022 02:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74847C36AE2;
        Mon, 21 Feb 2022 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645411413;
        bh=fr9WRLrW4coExEzj2Kuaw9OBpeHu4mj+MkxXimcnkCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tHGeFe5kGxavBagXfuqMvZGtm9XDhRHHf+F/OYh1gQbFsj115H1fn7bAF3Gy/ZjSV
         tKvXiYAod5rP1da37lvbUbVcupqxjUDf9xRGMcPJE7PGqzqDVLfqGRbd/+GORMiP4O
         Gxe/IimKdeCkmmB86sCgXl8gg7pWab1VGJvjWP0unJ8jiqE949Ywbxs0mCtnjxBB/k
         zlWlE8hjtFtl02/DkLFkYhaG2nIaCaH/9rZIKqdhJdyRcVEkz3xlJLGRyDMHXsDD04
         Q+qfu4OFlOx6hK+6w9Stp1ZngsaT7szHesbaI/vsJaIb1ezjuwYbrropLb71RNgIzV
         eZXH4RvJ2WmPQ==
Received: by mail-ej1-f42.google.com with SMTP id qk11so29393197ejb.2;
        Sun, 20 Feb 2022 18:43:33 -0800 (PST)
X-Gm-Message-State: AOAM530TTkinVBVwygfABEootZq89pdRIduP6dcbuTx9QENDpvOpi4xq
        rgjuhB7AetW9y+KGm1a+KwEk8egj6bhFbeU+8w==
X-Google-Smtp-Source: ABdhPJwOzYdjdfRguJrzoCzdajK1FOiYj6KmzNtAScRDhOVtID8EpaZbeIyGY8zVQWhRYhYShCXwM4IhUMsXpmbxZhY=
X-Received: by 2002:a17:906:b348:b0:6cf:5b66:2f80 with SMTP id
 cd8-20020a170906b34800b006cf5b662f80mr13893213ejb.638.1645411411757; Sun, 20
 Feb 2022 18:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-10-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-10-granquet@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Feb 2022 10:43:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8zj3PxdZ-CftM8jE+0T-vmck1UMH9tNYN6YL5MuaTdQw@mail.gmail.com>
Message-ID: <CAAOTY_8zj3PxdZ-CftM8jE+0T-vmck1UMH9tNYN6YL5MuaTdQw@mail.gmail.com>
Subject: Re: [PATCH v8 09/19] drm/mediatek: dpi: move dimension_mask to board config
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, deller@gmx.de,
        CK Hu <ck.hu@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guillaume:

Guillaume Ranquet <granquet@baylibre.com> =E6=96=BC 2022=E5=B9=B42=E6=9C=88=
18=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:56=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add flexibility by moving the dimension mask to board config

Replace 'board' with 'SoC'.

>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 8ca3455ed64ee..0d3acd08ea358 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -129,6 +129,8 @@ struct mtk_dpi_conf {
>         bool swap_input_support;
>         // Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH (no =
shift)
>         u32 dimension_mask;
> +       // Mask used for HSIZE and VSIZE (no shift)

/* ... */

Regards,
Chun-Kuang.

> +       u32 hvsize_mask;
>         const struct mtk_dpi_yc_limit *limit;
>  };
>
> @@ -243,8 +245,10 @@ static void mtk_dpi_config_interface(struct mtk_dpi =
*dpi, bool inter)
>
>  static void mtk_dpi_config_fb_size(struct mtk_dpi *dpi, u32 width, u32 h=
eight)
>  {
> -       mtk_dpi_mask(dpi, DPI_SIZE, width << HSIZE, HSIZE_MASK);
> -       mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE, VSIZE_MASK);
> +       mtk_dpi_mask(dpi, DPI_SIZE, width << HSIZE,
> +                    dpi->conf->hvsize_mask << HSIZE);
> +       mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE,
> +                    dpi->conf->hvsize_mask << VSIZE);
>  }
>
>  static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
> @@ -816,6 +820,7 @@ static const struct mtk_dpi_conf mt8173_conf =3D {
>         .is_ck_de_pol =3D true,
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
> +       .hvsize_mask =3D HSIZE_MASK,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -829,6 +834,7 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
>         .is_ck_de_pol =3D true,
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
> +       .hvsize_mask =3D HSIZE_MASK,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -841,6 +847,7 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
>         .is_ck_de_pol =3D true,
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
> +       .hvsize_mask =3D HSIZE_MASK,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -853,6 +860,7 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
>         .is_ck_de_pol =3D true,
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
> +       .hvsize_mask =3D HSIZE_MASK,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> --
> 2.34.1
>
