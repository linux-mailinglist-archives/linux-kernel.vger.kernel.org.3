Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41D523732
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiEKPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbiEKPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:24:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E812297D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:24:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z2so4802676ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seaHCom44uiTs26SOVTHmO+d30N+urihbVnoa7jcBHU=;
        b=TAsFxKUwFUu/cfHGMVs7euuOOaHKgnj7ofjrXFjp8r9Snf7wiMSBmToMDbll08c4wB
         B4LGXeld//Q6hfxFtxBMvALlOyKkBrwRlXmA5HUoGvnBrbQ8Z0lf5TiNGHuyMrP5BR63
         n6ueMhr6dz49B7BTy3DGmj6ZgllDGug3NlmCJzP7cNvRG6GoVu5qS4C3KtiUZlgXFufh
         GrpfbUWWpQRQYDaaK9aKLJGsmkgEdTsj7LCUFYY8sOi2gz+5yjJCzJ/Cm21z7B6ydRD5
         Eb6frZ5RtEav3mlIuE5peSrbI9eRPdVtxJETEJRXmlpTKjxCb0r6y2Qp7SoSZumEhuWj
         rDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seaHCom44uiTs26SOVTHmO+d30N+urihbVnoa7jcBHU=;
        b=ZowSiwEDRVhxbKuYvB/J1NFPu/1rgCqTuPnzVRyPsKiHp7HmvIeLPCfmzuvJVABH59
         7F5+9x+d4zXqax7SQ1c/5Wzz2EYYWBKfx3yL53LB8M3RoSc0iYVsBes/GzmnVNIxa54o
         0ZZX8ORsHX6s0FjrP6+LdrZ7tczqlMvGOzU38bZWlNKtrkokEwLgUymhDhfI1PekJCXj
         0SDdplG7PsbxkrHliTLd21YrASF37pHIY6S/IGtuv1emSaGfLn3OuydQFfp3RXj4Azqa
         HBJCnY19xe5jrRvWunwrMyrL6gHowqIsZbm40khwiHDab2InLpJm80tWgLlg+ZVMwD/5
         nlAw==
X-Gm-Message-State: AOAM532pFS7Yv6WWxB0ZD/hKEVR0AnXq+jNbojaJ1A9clqMoA9pinaLQ
        Vz0zwRn19dbqKZ+s/1E4doV1eq1ywUlim0Wl60U1zjbLu3Pkfg==
X-Google-Smtp-Source: ABdhPJw5lbZ3f5D9UUxJJpVm5HxR51LIMMyK1ge48NZ+6rLvEM9+7xdSTx82HwOKw4EXjm+P/qHF+QOQPr1ZncyweS8=
X-Received: by 2002:a17:907:162a:b0:6f4:c53b:fca7 with SMTP id
 hb42-20020a170907162a00b006f4c53bfca7mr25795243ejc.723.1652282690650; Wed, 11
 May 2022 08:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220511064920.18455-1-yong.wu@mediatek.com> <20220511064920.18455-2-yong.wu@mediatek.com>
In-Reply-To: <20220511064920.18455-2-yong.wu@mediatek.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 11 May 2022 08:24:39 -0700
Message-ID: <CABXOdTcA1ERGTCMVDhz+cah6GwC3hsNR9W3PYyYZN6uGE5_Rsg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iommu/mediatek: Use dev_err_probe to mute probe_defer
 err log
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:49 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Mute the probe defer log:
>
> [    2.654806] mtk-iommu 14018000.iommu: mm dts parse fail(-517).
> [    2.656168] mtk-iommu 1c01f000.iommu: mm dts parse fail(-517).
>
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> The Fixes tag commit-id is from linux-next.
> ---
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 71b2ace74cd6..0f6ec4a4d9d4 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1198,7 +1198,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>         if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>                 ret = mtk_iommu_mm_dts_parse(dev, &match, data);
>                 if (ret) {
> -                       dev_err(dev, "mm dts parse fail(%d).", ret);
> +                       dev_err_probe(dev, ret, "mm dts parse fail.");
>                         goto out_runtime_disable;
>                 }
>         } else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> --
> 2.18.0
>
