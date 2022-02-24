Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E274C2110
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiBXBa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBXBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:30:55 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971313CDE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:30:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V5LiiSH_1645665799;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V5LiiSH_1645665799)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 09:23:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     matthias.bgg@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        chunkuang.hu@kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm: mediatek: mtk_dsi: Remove unnecessary print function dev_err()
Date:   Thu, 24 Feb 2022 09:23:18 +0800
Message-Id: <20220224012318.84935-1-yang.lee@linux.alibaba.com>
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

Eliminate the follow coccicheck warning:
./drivers/gpu/drm/mediatek/mtk_dsi.c:1092:2-9: line 1092 is redundant
because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index bced4c7d668e..704252ee1198 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1089,7 +1089,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 	irq_num = platform_get_irq(pdev, 0);
 	if (irq_num < 0) {
-		dev_err(&pdev->dev, "failed to get dsi irq_num: %d\n", irq_num);
 		ret = irq_num;
 		goto err_unregister_host;
 	}
-- 
2.20.1.7.g153144c

