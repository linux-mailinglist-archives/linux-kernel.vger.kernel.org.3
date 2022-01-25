Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0849B1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354889AbiAYK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbiAYKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:23:02 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BCDC06175B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:23:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d10so29566882eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXvXXH5NkD3VAbxPYQLS+yBdXysPjN86vINvSbtOAUo=;
        b=pDneXHtftHaFd0QpxVSQgYZJ/r85V/t7o7isVF9jWMXmK6UBInq4U2qhRaHN9SwHWb
         +0+uu2yDz4gyvRd8ExR0Y5Gr6hHRYuo4GHXw+g4H8G7bB6zqppHg6WqlXl5CPg59NNdl
         6/qXOtTbqvTSRLzAgl1zCdDRoM9RZCFoQDlE/H8a4ZGMQWkqHsuSAFhM72EqI+RmXBxs
         9nIPmmd06u2ezVi3XwxyrvGbsohdc1lF/NPzkPidacBVKieVvp6qL2elTUErmY1JIANy
         e1NfXcC10p09JorqT1p5lV33SQaKg3ODW8x+wi8GN4EQbYUNiklzMJjHAiVmlss+XzGr
         OygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXvXXH5NkD3VAbxPYQLS+yBdXysPjN86vINvSbtOAUo=;
        b=08Cpx9Yb1A6OUUAhrPqwCgup8lTzcvwy9afLIHLhToZJM52FUqzL2ZmLmsu7igGS8j
         baJN/DzlV6YTVsX3owRhW3zunSpsBkFp9Amj7Z93gQg68Ur977DmVbFn4qzGnX9qo8pT
         jXE3/8+x8krHiNWH1EYPPU2vBGYwa20LcWulMT2gO6f5zSnIZithJfGI7djBaqvY7Zfk
         dJ3c/raSPl1ctFlD67cWggE7q5Jl7WDCDVTxwuDcQI3w3RX02eLgJ7/2OV8cG036nQs2
         6Z5GesIZQ2CEm2AuQovC7pO4r/0mMgaOIl4/2RMz70fSQqp6myF2JGOkVNdRqBYyl70+
         0MGQ==
X-Gm-Message-State: AOAM533nErTjqeYZBqGpNqitoBhjPeX4EOEKp6eqA5GXmVaWAsaI1Aky
        D5SiP+j3iRanRvI1ymydnEiebv5rUmcU5McEgxfPUZiVLmo=
X-Google-Smtp-Source: ABdhPJzZTQ34Sj6DntR4KEnfsahwcr2GjkI+X89p/KhV55EV9Ip8387kcoPafKP0Tf9qoGGj36xxE50nWLaCOxj2LZ8=
X-Received: by 2002:a17:907:3f93:: with SMTP id hr19mr16043123ejc.697.1643106178771;
 Tue, 25 Jan 2022 02:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20220120070226.1492-1-biao.huang@mediatek.com> <20220120070226.1492-3-biao.huang@mediatek.com>
In-Reply-To: <20220120070226.1492-3-biao.huang@mediatek.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Jan 2022 11:22:48 +0100
Message-ID: <CAMRc=McZTped08HwbM+pr-xtsDyddTLjpsCc_f7ucoDM2DNXaw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/9] net: ethernet: mtk-star-emac: modify IRQ
 trigger flags
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     David Miller <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Yinghua Pan <ot_yinghua.pan@mediatek.com>,
        srv_heupstream@mediatek.com, Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:02 AM Biao Huang <biao.huang@mediatek.com> wrote:
>
> If the flags in request_irq() is IRQF_TRIGGER_NONE, the trigger method
> is determined by "interrupt" property in dts.
> So, modify the flag from IRQF_TRIGGER_FALLING to IRQF_TRIGGER_NONE.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> Signed-off-by: Yinghua Pan <ot_yinghua.pan@mediatek.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_star_emac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> index 26f5020f2e9c..7c2af775d601 100644
> --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> @@ -959,7 +959,7 @@ static int mtk_star_enable(struct net_device *ndev)
>
>         /* Request the interrupt */
>         ret = request_irq(ndev->irq, mtk_star_handle_irq,
> -                         IRQF_TRIGGER_FALLING, ndev->name, ndev);
> +                         IRQF_TRIGGER_NONE, ndev->name, ndev);
>         if (ret)
>                 goto err_free_skbs;
>
> --
> 2.25.1
>

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
