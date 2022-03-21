Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4E4E2370
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbiCUJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345957AbiCUJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:38:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72C963BED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:36:38 -0700 (PDT)
X-UUID: ef0d69968e6348248e783b0787ce3457-20220321
X-UUID: ef0d69968e6348248e783b0787ce3457-20220321
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 625806720; Mon, 21 Mar 2022 17:36:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Mar 2022 17:36:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 17:36:32 +0800
Message-ID: <0e4344e084e3306cd265580883c0093c7cb40d45.camel@mediatek.com>
Subject: Re: [PATCH v3, 1/4] drm/mediatek: Adjust the timing of mipi signal
 from LP00 to LP11
From:   CK Hu <ck.hu@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <jitao.shi@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <rex-bc.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 21 Mar 2022 17:36:32 +0800
In-Reply-To: <1647503611-13144-2-git-send-email-xinlei.lee@mediatek.com>
References: <1647503611-13144-1-git-send-email-xinlei.lee@mediatek.com>
         <1647503611-13144-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xinlei:

On Thu, 2022-03-17 at 15:53 +0800, xinlei.lee@mediatek.com wrote:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
> Old sequence:
> 1. Pull the MIPI signal high
> 2. Delay & Dsi_reset
> 3. Set the dsi timing register
> 4. dsi clk & lanes leave ulp mode and enter hs mode
> 
> New sequence:
> 1. Set the dsi timing register
> 2. Pull the MIPI signal high
> 3. Delay & Dsi_reset
> 4. dsi clk & lanes leave ulp mode and enter hs mode
> 
> In the new sequence 2 & 3 & 4 will be moved to dsi_enbale in later
> patch.

I think there would be one patch in 5.9 make the wrong sequence, so add
'Fixes' tag to indicate which patch make the wrong sequence. Use the
term correct/wrong instead old/new sequence.

I still do not understand what is the sequence after apply this patch?

Does the sequence is this after apply this patch?
1. Set the dsi timing register
2. Pull the MIPI signal high
3. Delay & Dsi_reset
4. dsi clk & lanes leave ulp mode and enter hs mode

Regards,
CK

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index ccb0511b9cd5..262c027d8c2f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -649,14 +649,14 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  	mtk_dsi_reset_engine(dsi);
>  	mtk_dsi_phy_timconfig(dsi);
>  
> -	mtk_dsi_rxtx_control(dsi);
> -	usleep_range(30, 100);
> -	mtk_dsi_reset_dphy(dsi);
>  	mtk_dsi_ps_control_vact(dsi);
>  	mtk_dsi_set_vm_cmd(dsi);
>  	mtk_dsi_config_vdo_timing(dsi);
>  	mtk_dsi_set_interrupt_enable(dsi);
>  
> +	mtk_dsi_rxtx_control(dsi);
> +	usleep_range(30, 100);
> +	mtk_dsi_reset_dphy(dsi);
>  	mtk_dsi_clk_ulp_mode_leave(dsi);
>  	mtk_dsi_lane0_ulp_mode_leave(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 0);

