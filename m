Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8FC4BD33E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 02:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245478AbiBUBq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 20:46:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbiBUBqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 20:46:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC23A1AB;
        Sun, 20 Feb 2022 17:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9B06101A;
        Mon, 21 Feb 2022 01:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3600C36AE2;
        Mon, 21 Feb 2022 01:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645407989;
        bh=4qgWKGsTwLoKg719UeLRaB5xjFNi6yHpYigKnDRlLFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cIpg7hWw619i1bNWsfqhIAudwb9q8gBVD/5k1jA+qknLVsNIYcWosvE4S7bItkcmV
         afuTap6aE+Y2DBCxndC3DH37OGkjjBOyrZPFi6vU1FrijikCsW6KX8Oy5ZedFJyKVQ
         cBY8KP262S1QiZQLcENg7FczMuwbFpw65fXkZSTsSu3LVf8BscH+rlQX3i4+M7DkIx
         6r9gdbIbFMCvsq8MmB8KvbZeHkGLya/iDwlfHEtqu7si38hatWU+27W9d2XzCTCT6b
         1mhxbvs84QNpZpFZ1Z/2v660ZSCTBkLy1BCUUcXOBcxbVH4dgQbWN2U9526vSsrwqs
         hq3I5C3GBQq1g==
Received: by mail-ej1-f46.google.com with SMTP id r13so6046665ejd.5;
        Sun, 20 Feb 2022 17:46:29 -0800 (PST)
X-Gm-Message-State: AOAM530jRCZapuln8+oK+o9sCuUnr8yBnLy9e2Zwr2i4LXzS2r1uXQQL
        7jdc3EuCZfzETrf42X6k2lNb3uRyOa5xShgf+Q==
X-Google-Smtp-Source: ABdhPJwuTQy36EkhUNRD6M2+IcyGr33kZ+4z7L5xdpFKroaHetdf6U/UnYEQCCEMkMZsPcTHm7dMj6912ba9+VrWsIg=
X-Received: by 2002:a17:906:b348:b0:6cf:5b66:2f80 with SMTP id
 cd8-20020a170906b34800b006cf5b662f80mr13799127ejb.638.1645407988130; Sun, 20
 Feb 2022 17:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-6-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-6-granquet@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Feb 2022 09:46:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY__u8R-WkTmnKkey5p7_fVuy2mgoRY4Fx_kqb5kb4hnqmQ@mail.gmail.com>
Message-ID: <CAAOTY__u8R-WkTmnKkey5p7_fVuy2mgoRY4Fx_kqb5kb4hnqmQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/19] drm/mediatek: dpi: move dpi limits to board config
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
> Add flexibility by moving the dpi limits to the board config

This patch looks good to me. But I would like to know what's this
limit and why it vary in different SoC. If possible, would you please
provide more description for this?

Regards,
Chun-Kuang.

>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 4554e2de14309..4746eb3425674 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -125,6 +125,7 @@ struct mtk_dpi_conf {
>         bool edge_sel_en;
>         const u32 *output_fmts;
>         u32 num_output_fmts;
> +       const struct mtk_dpi_yc_limit *limit;
>  };
>
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 m=
ask)
> @@ -235,9 +236,10 @@ static void mtk_dpi_config_fb_size(struct mtk_dpi *d=
pi, u32 width, u32 height)
>         mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE, VSIZE_MASK);
>  }
>
> -static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi,
> -                                        struct mtk_dpi_yc_limit *limit)
> +static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
>  {
> +       const struct mtk_dpi_yc_limit *limit =3D dpi->conf->limit;
> +
>         mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
>                      Y_LIMINT_BOT_MASK);
>         mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
> @@ -449,7 +451,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>                                     struct drm_display_mode *mode)
>  {
> -       struct mtk_dpi_yc_limit limit;
>         struct mtk_dpi_polarities dpi_pol;
>         struct mtk_dpi_sync_param hsync;
>         struct mtk_dpi_sync_param vsync_lodd =3D { 0 };
> @@ -484,11 +485,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *=
dpi,
>         dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
>                 pll_rate, vm.pixelclock);
>
> -       limit.c_bottom =3D 0x0010;
> -       limit.c_top =3D 0x0FE0;
> -       limit.y_bottom =3D 0x0010;
> -       limit.y_top =3D 0x0FE0;
> -
>         dpi_pol.ck_pol =3D MTK_DPI_POLARITY_FALLING;
>         dpi_pol.de_pol =3D MTK_DPI_POLARITY_RISING;
>         dpi_pol.hsync_pol =3D vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
> @@ -536,7 +532,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *d=
pi,
>         else
>                 mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
>
> -       mtk_dpi_config_channel_limit(dpi, &limit);
> +       mtk_dpi_config_channel_limit(dpi);
>         mtk_dpi_config_bit_num(dpi, dpi->bit_num);
>         mtk_dpi_config_channel_swap(dpi, dpi->channel_swap);
>         mtk_dpi_config_yc_map(dpi, dpi->yc_map);
> @@ -790,12 +786,20 @@ static const u32 mt8183_output_fmts[] =3D {
>         MEDIA_BUS_FMT_RGB888_2X12_BE,
>  };
>
> +static const struct mtk_dpi_yc_limit mtk_dpi_limit =3D {
> +       .c_bottom =3D 0x0010,
> +       .c_top =3D 0x0FE0,
> +       .y_bottom =3D 0x0010,
> +       .y_top =3D 0x0FE0,
> +};
> +
>  static const struct mtk_dpi_conf mt8173_conf =3D {
>         .cal_factor =3D mt8173_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 300000,
>         .output_fmts =3D mt8173_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> +       .limit =3D &mtk_dpi_limit,
>  };
>
>  static const struct mtk_dpi_conf mt2701_conf =3D {
> @@ -805,6 +809,7 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
>         .max_clock_khz =3D 150000,
>         .output_fmts =3D mt8173_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> +       .limit =3D &mtk_dpi_limit,
>  };
>
>  static const struct mtk_dpi_conf mt8183_conf =3D {
> @@ -813,6 +818,7 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
>         .max_clock_khz =3D 100000,
>         .output_fmts =3D mt8183_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8183_output_fmts),
> +       .limit =3D &mtk_dpi_limit,
>  };
>
>  static const struct mtk_dpi_conf mt8192_conf =3D {
> @@ -821,6 +827,7 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
>         .max_clock_khz =3D 150000,
>         .output_fmts =3D mt8173_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> +       .limit =3D &mtk_dpi_limit,
>  };
>
>  static int mtk_dpi_probe(struct platform_device *pdev)
> --
> 2.34.1
>
