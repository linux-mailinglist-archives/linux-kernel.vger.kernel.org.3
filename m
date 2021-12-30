Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F1481E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbhL3Qbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhL3Qbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:31:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 08:31:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7502CB81C77
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A20DC36AF0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640881906;
        bh=DoMqZeSp31c4BdQxbZ15ZYyN+jInAOYa+pzWvuj1V+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WAxEl4NOgOsftPaDpXfRWoi1nj9/3fBgHhYhGl4tT7fwXxVvRzy6i6pyh+KoCXk0q
         8RZ7JiL0yOC2GV7fDTUlnobaRHJNyofs7qQrBSputf0GNixgO/AaaYPWBjJVLuX09g
         UY6WwzrRDOkUyfrqtsQDdbV4pMqS7s5C56us+39ouMSTW/lGGrTDskGcyRNQ3UHYB+
         GzoO+xEf1ZGOZ9l70xvInPjANXpy5a0HDHDbURl+5luZuHGzm+wJmjUq/qdadbs3jB
         fYYvy6Ti9nRD/RK0j5WLKPou7gV351lmqiFPF1RO9IMihDfLLgbQ3+jVzA28Y0Ye6J
         +aok3dSqdoFRg==
Received: by mail-ed1-f48.google.com with SMTP id j21so99927154edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 08:31:46 -0800 (PST)
X-Gm-Message-State: AOAM531zgxwmHX53nunDIeOJRnkCCA6r2uOSupoDWsIYvUGdNzd8AX5p
        vaWhH8KSTqgCKtkgUXQzhqZEluufeUWcyD+ipQ==
X-Google-Smtp-Source: ABdhPJwwoCM4BACwhBGiZnGRAg9C++hI21NbvZwOdn/dltz/26/69d6R/OprjtD1A4ewX0f1NC+U3pEDXI3uVMzy1AQ=
X-Received: by 2002:a17:907:629a:: with SMTP id nd26mr26535652ejc.680.1640881904439;
 Thu, 30 Dec 2021 08:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20211224082103.7658-1-linmq006@gmail.com>
In-Reply-To: <20211224082103.7658-1-linmq006@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 31 Dec 2021 00:31:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-7-BrnkPk_5V5y20F6fX3X8Vm0tcYAA=1DNCnxjvNF8A@mail.gmail.com>
Message-ID: <CAAOTY_-7-BrnkPk_5V5y20F6fX3X8Vm0tcYAA=1DNCnxjvNF8A@mail.gmail.com>
Subject: Re: [PATCH] phy: mediatek: Fix missing check in mtk_mipi_tx_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-phy@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miaoqian:

Miaoqian Lin <linmq006@gmail.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The of_device_get_match_data() function may return NULL.
> Add check to prevent potential null dereference.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediat=
ek/phy-mtk-mipi-dsi.c
> index 28ad9403c441..67b005d5b9e3 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> @@ -146,6 +146,8 @@ static int mtk_mipi_tx_probe(struct platform_device *=
pdev)
>                 return -ENOMEM;
>
>         mipi_tx->driver_data =3D of_device_get_match_data(dev);
> +       if (!mipi_tx->driver_data)

I'm confused. mtk_mipi_tx_probe() is called because this device node's
compatible match one in mtk_mipi_tx_match[]. So I think the return
value of of_device_get_match_data(dev) would not be NULL. If this is
true, this checking is redundant.

Regards,
Chun-Kuang.

> +               return -ENODEV;
>
>         mipi_tx->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(mipi_tx->regs))
> --
> 2.17.1
>
