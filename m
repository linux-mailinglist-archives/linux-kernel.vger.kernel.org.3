Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5044DA6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352746AbiCPAPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbiCPAPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:15:30 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3B91CFF7;
        Tue, 15 Mar 2022 17:14:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V7JcKdl_1647389652;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7JcKdl_1647389652)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 08:14:13 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     matthias.bgg@gmail.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: platform: Remove unnecessary print function dev_err()
Date:   Wed, 16 Mar 2022 08:14:11 +0800
Message-Id: <20220316001411.80167-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warnings:
./drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c:119:2-9:
line 119 is redundant because platform_get_irq() already prints an error
./drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c:103:2-9:
line 103 is redundant because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 4 +---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 48dad9bb13d2..df7b25e9cbc8 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -115,10 +115,8 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
 		return 0;
 
 	dev->dec_irq = platform_get_irq(pdev, 0);
-	if (dev->dec_irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq number");
+	if (dev->dec_irq < 0)
 		return dev->dec_irq;
-	}
 
 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index 8d2a641d92f1..5f07313676bb 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -99,10 +99,8 @@ static int mtk_vdec_hw_init_irq(struct mtk_vdec_hw_dev *dev)
 	int ret;
 
 	dev->dec_irq = platform_get_irq(pdev, 0);
-	if (dev->dec_irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq resource");
+	if (dev->dec_irq < 0)
 		return dev->dec_irq;
-	}
 
 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
-- 
2.20.1.7.g153144c

