Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF4565090
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiGDJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiGDJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:16:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398BBE3E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:16:32 -0700 (PDT)
X-UUID: e9b2141855f94f6dbd5189379df3b4be-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:5cab4f8f-2ec6-4f62-9f19-39fded9d65c4,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:65087d86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e9b2141855f94f6dbd5189379df3b4be-20220704
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1370740734; Mon, 04 Jul 2022 17:16:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 4 Jul 2022 17:16:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 4 Jul 2022 17:16:27 +0800
Message-ID: <870cac7815d0f2ec9cfe4a18b19c141723fcd178.camel@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: ensure bridge disable happends before
 suspend
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     David Airlie <airlied@linux.ie>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 4 Jul 2022 17:16:27 +0800
In-Reply-To: <20220629190545.478113-1-hsinyi@chromium.org>
References: <20220629190545.478113-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-yi:

On Thu, 2022-06-30 at 03:05 +0800, Hsin-Yi Wang wrote:
> Make sure bridge_disable will be called before suspend by calling
> drm_mode_config_helper_suspend() in .prepare callback.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> The issue is found if suspend is called via VT2 in several MTK SoC
> (eg.
> MT8173, MT8183, MT8186) chromebook boards with eDP bridge:
> bridge disable is called through mtk-drm's suspend, and it needs to
> be
> called before bridge pm runtime suspend.
> So we move the hook to .prepare() and .complete().
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 13a1bbe7ead7f..a42812e490007 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -828,8 +828,7 @@ static int mtk_drm_remove(struct platform_device
> *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int mtk_drm_sys_suspend(struct device *dev)
> +static int mtk_drm_sys_prepare(struct device *dev)
>  {
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  	struct drm_device *drm = private->drm;
> @@ -840,20 +839,21 @@ static int mtk_drm_sys_suspend(struct device
> *dev)
>  	return ret;
>  }
>  
> -static int mtk_drm_sys_resume(struct device *dev)
> +static void mtk_drm_sys_complete(struct device *dev)
>  {
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  	struct drm_device *drm = private->drm;
>  	int ret;
>  
>  	ret = drm_mode_config_helper_resume(drm);
> -
> -	return ret;
> +	if (ret)
> +		dev_err(dev, "Failed to resume\n");
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
> -			 mtk_drm_sys_resume);
> +static const struct dev_pm_ops mtk_drm_pm_ops = {
> +	.prepare = mtk_drm_sys_prepare,
> +	.complete = mtk_drm_sys_complete,
> +};
>  
>  static struct platform_driver mtk_drm_platform_driver = {
>  	.probe	= mtk_drm_probe,

