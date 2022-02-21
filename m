Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C14BD427
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbiBUDZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:25:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiBUDZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:25:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0F31DF7;
        Sun, 20 Feb 2022 19:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3186114D;
        Mon, 21 Feb 2022 03:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EE5C340F6;
        Mon, 21 Feb 2022 03:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645413886;
        bh=qO8573CRQiu/z0EEizzes65D3OQ8wZzEKmTCKW4MMZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P7AwV41JAjM1ZOsTsvNlGJ6sJNmBEtTtLPKmNNZMC/XyySs3Tq3cBWL90hcL3jA/q
         uH9Vqr9YNCNgQQWZm0Ns9WoEljd+2walrv9TSiEkLrxEomBUJI0mMKWfIf5f0zDywj
         bossYpFjoH2fCEfV6X9jmPT+WwQZ5Am4PnnlP2Ibd54CyLY6tCVX3A+umM5Xi2ZPL6
         cqWvxZ7FiL48OjFb9T4kJAymjYyJaOzV6Txkn/N61dyxtab3v43prPY57tl1DEYf9B
         ZTyXJ7xlvbxzJPgswUVpXtVt4DPiaXRJdhBf+6O5c9xua6U289BEtAphzhZl4nKu6d
         +5Y+ufev1oAaQ==
Received: by mail-ej1-f51.google.com with SMTP id qx21so29469787ejb.13;
        Sun, 20 Feb 2022 19:24:46 -0800 (PST)
X-Gm-Message-State: AOAM531oUIxgtcLiMXRTId+EpdeBNsyN357vPQ25hf+oOjhKO2oCOrzi
        Ju3pYkbaG0B2cEbYWd1ib8z7lp6HcVbO5rDn9Q==
X-Google-Smtp-Source: ABdhPJwjAPsaHxaTO2fPl36BRiMDL+aqL50uBkML8OltdMe4CzpwYsfSM7uRTzFcal0fd0xrQupABtvgOQ9eblRYB5w=
X-Received: by 2002:a17:906:8143:b0:6cf:73c1:8a0 with SMTP id
 z3-20020a170906814300b006cf73c108a0mr14451460ejw.406.1645413884967; Sun, 20
 Feb 2022 19:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-11-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-11-granquet@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Feb 2022 11:24:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9cOLJnTK0tSqfzyK4tUn_LUAywRPa+z7tTCOSien2j1Q@mail.gmail.com>
Message-ID: <CAAOTY_9cOLJnTK0tSqfzyK4tUn_LUAywRPa+z7tTCOSien2j1Q@mail.gmail.com>
Subject: Re: [PATCH v8 10/19] drm/mediatek: dpi: move swap_shift to board config
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
> Add flexibility by moving the swap shift value to board config
>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 0d3acd08ea358..ec221e24e0fee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -131,6 +131,7 @@ struct mtk_dpi_conf {
>         u32 dimension_mask;
>         // Mask used for HSIZE and VSIZE (no shift)
>         u32 hvsize_mask;
> +       u32 channel_swap_shift;
>         const struct mtk_dpi_yc_limit *limit;
>  };
>
> @@ -349,7 +350,8 @@ static void mtk_dpi_config_channel_swap(struct mtk_dp=
i *dpi,
>                 break;
>         }
>
> -       mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP, CH_SWAP_MAS=
K);
> +       mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP,
> +                    CH_SWAP_MASK << dpi->conf->channel_swap_shift);

This may be wrong because of these definition:

#define DPINTF_CH_SWAP BIT(1)
#define DPINTF_CH_SWAP_MASK (0x7 << 1)

Regards,
Chun-Kuang.

>  }
>
>  static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enabl=
e)
> @@ -821,6 +823,7 @@ static const struct mtk_dpi_conf mt8173_conf =3D {
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
> +       .channel_swap_shift =3D CH_SWAP,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -835,6 +838,7 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
> +       .channel_swap_shift =3D CH_SWAP,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -848,6 +852,7 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
> +       .channel_swap_shift =3D CH_SWAP,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -861,6 +866,7 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
>         .swap_input_support =3D true,
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
> +       .channel_swap_shift =3D CH_SWAP,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> --
> 2.34.1
>
