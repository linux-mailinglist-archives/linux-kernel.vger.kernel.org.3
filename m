Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9A5657D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiGDNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiGDNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:51:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C464EC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 506646158E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 13:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F75C341CE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656942699;
        bh=hAfuMRpk9TdhPZKHaCc+WuV8OqufS7bLGsHXotM88Ho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jxq9RUGXnffQs7/NqBRif/E6Maxq+B+XEABUVLFoONhdTRJeiTn9q99B4qRUQbW/6
         S6su4yTThCr+kM3+DjkYD/7RbOyE2vWp6tGTi0lHWF4dTvYyUTe/O8hA3qsFDfCcYl
         H+4iC778OmdLvCYid6PETCJ9D9ia2f5CLaW+Xrq/KAZu11MiOGcwOJtr8pBhXu1xls
         jZ0eWPyIqFgDfzIBf57zbOGqicaKXAkVTvo0OuH8yHIJnK4pXoPLjiu0Wt9IzQhoZI
         cAz+FrN6WVLMgoZj76qfUB17Ld5rYZP1fR4Hq8hzPi2KZnDGl2eJJj9LfBfVYWOF5i
         wPAIgNdUo0VvA==
Received: by mail-wr1-f54.google.com with SMTP id s1so13588069wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:51:39 -0700 (PDT)
X-Gm-Message-State: AJIora/FRiAmhJYGIOzETwS41O2D9f/3+GaR2+Yu6VDR2gcfpc6wpfFY
        Uiy8wmapOWNjmYuWEfGOrz7kD7R48w5W4eSCCw==
X-Google-Smtp-Source: AGRyM1uKp2lrpW6u+5cY6RUsSDjtF0VW1MATP4aMMyHLV7iUskweguBh2vAeN6OdOJ6Qu9KV7S3kduEtUTEV6H8/NnE=
X-Received: by 2002:a5d:6c62:0:b0:21d:2235:d800 with SMTP id
 r2-20020a5d6c62000000b0021d2235d800mr27450391wrz.381.1656942697923; Mon, 04
 Jul 2022 06:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220629190545.478113-1-hsinyi@chromium.org>
In-Reply-To: <20220629190545.478113-1-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 4 Jul 2022 21:51:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY__F2Ms6tfYgU=5wXS==0qVivo6OT=8txq9yA3XQLfqh-A@mail.gmail.com>
Message-ID: <CAAOTY__F2Ms6tfYgU=5wXS==0qVivo6OT=8txq9yA3XQLfqh-A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: ensure bridge disable happends before suspend
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8830=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E5=87=8C=E6=99=A83:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Make sure bridge_disable will be called before suspend by calling
> drm_mode_config_helper_suspend() in .prepare callback.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> The issue is found if suspend is called via VT2 in several MTK SoC (eg.
> MT8173, MT8183, MT8186) chromebook boards with eDP bridge:
> bridge disable is called through mtk-drm's suspend, and it needs to be
> called before bridge pm runtime suspend.
> So we move the hook to .prepare() and .complete().
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 13a1bbe7ead7f..a42812e490007 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -828,8 +828,7 @@ static int mtk_drm_remove(struct platform_device *pde=
v)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -static int mtk_drm_sys_suspend(struct device *dev)
> +static int mtk_drm_sys_prepare(struct device *dev)
>  {
>         struct mtk_drm_private *private =3D dev_get_drvdata(dev);
>         struct drm_device *drm =3D private->drm;
> @@ -840,20 +839,21 @@ static int mtk_drm_sys_suspend(struct device *dev)
>         return ret;
>  }
>
> -static int mtk_drm_sys_resume(struct device *dev)
> +static void mtk_drm_sys_complete(struct device *dev)
>  {
>         struct mtk_drm_private *private =3D dev_get_drvdata(dev);
>         struct drm_device *drm =3D private->drm;
>         int ret;
>
>         ret =3D drm_mode_config_helper_resume(drm);
> -
> -       return ret;
> +       if (ret)
> +               dev_err(dev, "Failed to resume\n");
>  }
> -#endif
>
> -static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
> -                        mtk_drm_sys_resume);
> +static const struct dev_pm_ops mtk_drm_pm_ops =3D {
> +       .prepare =3D mtk_drm_sys_prepare,
> +       .complete =3D mtk_drm_sys_complete,
> +};
>
>  static struct platform_driver mtk_drm_platform_driver =3D {
>         .probe  =3D mtk_drm_probe,
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
