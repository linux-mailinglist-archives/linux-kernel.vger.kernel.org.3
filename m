Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD2574765
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiGNImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiGNImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:42:12 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD19D3D5A7;
        Thu, 14 Jul 2022 01:42:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VJIOffY_1657788120;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VJIOffY_1657788120)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 16:42:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] soc/tegra: cbb: Remove unnecessary print function dev_err()
Date:   Thu, 14 Jul 2022 16:41:58 +0800
Message-Id: <20220714084158.33521-1-yang.lee@linux.alibaba.com>
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

platform_get_irq()<--platform_get_irq_optional()
platform_get_irq_optional() return non-zero IRQ number on success,
negative error number on failure, if IRQ number is 0, return -EINVAL.
so the function platform_get_irq() never returns 0, and the print function
dev_err() is redundant because platform_get_irq() already prints an error.

Eliminate the follow coccicheck warnings:
./drivers/soc/tegra/cbb/tegra-cbb.c:142:3-10: line 142 is redundant because platform_get_irq() already prints an error
./drivers/soc/tegra/cbb/tegra-cbb.c:152:2-9: line 152 is redundant because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/soc/tegra/cbb/tegra-cbb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra-cbb.c b/drivers/soc/tegra/cbb/tegra-cbb.c
index d200937353c7..aa9fcbd5d4a7 100644
--- a/drivers/soc/tegra/cbb/tegra-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra-cbb.c
@@ -138,20 +138,16 @@ int tegra_cbb_get_irq(struct platform_device *pdev, unsigned int *nonsec_irq,
 
 	if (num_intr == 2) {
 		irq = platform_get_irq(pdev, index);
-		if (irq <= 0) {
-			dev_err(&pdev->dev, "failed to get non-secure IRQ: %d\n", irq);
+		if (irq < 0)
 			return -ENOENT;
-		}
 
 		*nonsec_irq = irq;
 		index++;
 	}
 
 	irq = platform_get_irq(pdev, index);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "failed to get secure IRQ: %d\n", irq);
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	*sec_irq = irq;
 
-- 
2.20.1.7.g153144c

