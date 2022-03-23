Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F214E4EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbiCWIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiCWIzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:55:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1DBF2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:53:43 -0700 (PDT)
X-UUID: 36902fb81b254e84924810e4cc4ea1cd-20220323
X-UUID: 36902fb81b254e84924810e4cc4ea1cd-20220323
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1310939299; Wed, 23 Mar 2022 16:53:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 23 Mar 2022 16:53:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 16:53:36 +0800
Message-ID: <7992e5fcd0ed9fdee60ee9259b3238e33c86e28e.camel@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: mmsys: Add sw0_rst_offset for MT8192
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Date:   Wed, 23 Mar 2022 16:53:36 +0800
In-Reply-To: <20220322092040.12010-1-angelogioacchino.delregno@collabora.com>
References: <20220322092040.12010-1-angelogioacchino.delregno@collabora.com>
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

On Tue, 2022-03-22 at 10:20 +0100, AngeloGioacchino Del Regno wrote:
> MT8192 has the same sw0 reset offset as MT8183: add the parameter
> to be able to use mmsys as a reset controller for managing at
> least the DSI reset line.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/soc/mediatek/mtk-mmsys.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c
> b/drivers/soc/mediatek/mtk-mmsys.c
> index 4fc4c2c9ea20..f69521fabcce 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -70,6 +70,7 @@ static const struct mtk_mmsys_driver_data
> mt8192_mmsys_driver_data = {
>  	.clk_driver = "clk-mt8192-mm",
>  	.routes = mmsys_mt8192_routing_table,
>  	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
> +	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
>  };
>  
>  static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data =
> {

Hello Angelo,

Thanks for your patch.
But from register map for mmsys, the offset is 0x160 and DSI reset bit
is 15.

datasheet: MT8192 Tablet Application Processor Software Register
Table/4.1 Display Controller.pdf

BRs,
Rex

