Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317775003C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiDNBrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbiDNBrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:47:07 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8A55FE3;
        Wed, 13 Apr 2022 18:44:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VA05hUu_1649900680;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VA05hUu_1649900680)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Apr 2022 09:44:41 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] slimbus: qcom: Remove unnecessary print function dev_err()
Date:   Thu, 14 Apr 2022 09:44:30 +0800
Message-Id: <20220414014430.19051-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

Eliminate the follow coccicheck warning:
./drivers/slimbus/qcom-ctrl.c:514:2-9: line 514 is redundant because
platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ec58091fc948..c0c4f895d76e 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -510,10 +510,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	}
 
 	ctrl->irq = platform_get_irq(pdev, 0);
-	if (ctrl->irq < 0) {
-		dev_err(&pdev->dev, "no slimbus IRQ\n");
+	if (ctrl->irq < 0)
 		return ctrl->irq;
-	}
 
 	sctrl = &ctrl->ctrl;
 	sctrl->dev = &pdev->dev;
-- 
2.20.1.7.g153144c

