Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5B64DAC57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354483AbiCPIT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiCPIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:19:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131E23D4AB;
        Wed, 16 Mar 2022 01:18:42 -0700 (PDT)
X-UUID: a72b291d1f464eb1952bece34dd9c0b7-20220316
X-UUID: a72b291d1f464eb1952bece34dd9c0b7-20220316
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1692572578; Wed, 16 Mar 2022 16:18:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Mar 2022 16:18:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 16:18:38 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <yang.lee@linux.alibaba.com>
CC:     <abaci@linux.alibaba.com>, <andrew-ct.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mchehab@kernel.org>, <tiffany.lin@mediatek.com>
Subject: Re: [PATCH -next] media: platform: Remove unnecessary print function dev_err()
Date:   Wed, 16 Mar 2022 16:18:39 +0800
Message-ID: <20220316081839.22093-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220316001411.80167-1-yang.lee@linux.alibaba.com>
References: <20220316001411.80167-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

>The print function dev_err() is redundant because platform_get_irq()
>already prints an error.
>
>Eliminate the follow coccicheck warnings:
>./drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c:119:2-9:
>line 119 is redundant because platform_get_irq() already prints an error
>./drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c:103:2-9:
>line 103 is redundant because platform_get_irq() already prints an error
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>---
> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 4 +---
> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c  | 4 +---
> 2 files changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>index 48dad9bb13d2..df7b25e9cbc8 100644
>--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>@@ -115,10 +115,8 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
> 		return 0;
> 
> 	dev->dec_irq = platform_get_irq(pdev, 0);
>-	if (dev->dec_irq < 0) {
>-		dev_err(&pdev->dev, "failed to get irq number");
>+	if (dev->dec_irq < 0)
> 		return dev->dec_irq;
>-	}
> 

Thanks for the patch, 
Yihao has submitted a patch to fix mtk_vcodec_init_dec_resources() [1]
[1] https://lore.kernel.org/lkml/20220310023645.10082-1-hanyihao@vivo.com/

> 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
> 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
>diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
>index 8d2a641d92f1..5f07313676bb 100644
>--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
>+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
>@@ -99,10 +99,8 @@ static int mtk_vdec_hw_init_irq(struct mtk_vdec_hw_dev *dev)
> 	int ret;
> 
> 	dev->dec_irq = platform_get_irq(pdev, 0);
>-	if (dev->dec_irq < 0) {
>-		dev_err(&pdev->dev, "Failed to get irq resource");
>+	if (dev->dec_irq < 0)
> 		return dev->dec_irq;
>-	}
> 
> 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
> 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,

Would you mind submitting mtk_vdec_hw_init_irq() part by another patch?

Thanks,
Miles
