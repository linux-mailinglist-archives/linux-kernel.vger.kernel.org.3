Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26802510D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356491AbiD0Aw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbiD0AwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:52:20 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FA5F8CE;
        Tue, 26 Apr 2022 17:49:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VBPajTW_1651020547;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VBPajTW_1651020547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 08:49:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] Input: Remove unnecessary print function dev_err()
Date:   Wed, 27 Apr 2022 08:49:06 +0800
Message-Id: <20220427004906.129893-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Eliminate the follow coccicheck warning:
./drivers/input/joystick/sensehat-joystick.c:102:2-9: line 102 is
redundant because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/input/joystick/sensehat-joystick.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/sensehat-joystick.c b/drivers/input/joystick/sensehat-joystick.c
index 5ad1fe4ff496..a84df39d3b2f 100644
--- a/drivers/input/joystick/sensehat-joystick.c
+++ b/drivers/input/joystick/sensehat-joystick.c
@@ -98,10 +98,8 @@ static int sensehat_joystick_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Could not retrieve interrupt request");
+	if (irq < 0)
 		return irq;
-	}
 
 	error = devm_request_threaded_irq(&pdev->dev, irq,
 					  NULL, sensehat_joystick_report,
-- 
2.20.1.7.g153144c

