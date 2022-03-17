Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4949B4DC5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiCQMVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCQMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:21:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092A1AA4B1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:20:23 -0700 (PDT)
X-UUID: ca9f5fc0992e48a1b96ea7664a771e60-20220317
X-UUID: ca9f5fc0992e48a1b96ea7664a771e60-20220317
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1558619466; Thu, 17 Mar 2022 20:20:18 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Mar 2022 20:20:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 20:20:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 20:20:16 +0800
Message-ID: <ebcf547ab6e4481e6c8e60db88eccf58fe7059ed.camel@mediatek.com>
Subject: Re: [PATCH v3,4/4] drm/mediatek: Add pull-down MIPI operation in
 mtk_dsi_poweroff function
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>
Date:   Thu, 17 Mar 2022 20:20:16 +0800
In-Reply-To: <1647503611-13144-5-git-send-email-xinlei.lee@mediatek.com>
References: <1647503611-13144-1-git-send-email-xinlei.lee@mediatek.com>
         <1647503611-13144-5-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xinlei,

On Thu, 2022-03-17 at 15:53 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> In the dsi_enable function, mtk_dsi_rxtx_control is to
> pull up the MIPI signal operation. Before dsi_disable,
> MIPI should also be pulled down by writing a register instead of
> disabling dsi.
> 

What will happen if you do not pulled down the mipi before disable dsi?
What's differnet for this two setting?

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index b509d59235e2..1c6a75a46b67 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -676,6 +676,8 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  	mtk_dsi_reset_engine(dsi);
>  	mtk_dsi_lane0_ulp_mode_enter(dsi);
>  	mtk_dsi_clk_ulp_mode_enter(dsi);
> +	/* set the lane number as 0 */
> +	writel(0, dsi->regs + DSI_TXRX_CTRL);

So set lane num to 0 means pull down mipi?

BRs,
Rex

>  
>  	mtk_dsi_disable(dsi);
>  

