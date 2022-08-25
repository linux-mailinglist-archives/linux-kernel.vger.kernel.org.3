Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AA5A099D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiHYHJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiHYHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:09:53 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 00:09:50 PDT
Received: from out30-42.freemail.mail.aliyun.com (unknown [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689FA11455;
        Thu, 25 Aug 2022 00:09:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNCEMA-_1661411080;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VNCEMA-_1661411080)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 15:04:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tony@atomide.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] regulator: drivers: Remove unnecessary print function dev_err()
Date:   Thu, 25 Aug 2022 15:04:38 +0800
Message-Id: <20220825070438.128093-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1986
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/regulator/tps65219-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index 7ba2594e437c..ab16e6665625 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -363,11 +363,9 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 		irq_type = &tps65219_regulator_irq_types[i];
 
 		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
-		if (irq < 0) {
-			dev_err(tps->dev, "Failed to get IRQ %s: %d\n",
-				irq_type->irq_name, irq);
+		if (irq < 0)
 			return -EINVAL;
-		}
+
 		irq_data[i].dev = tps->dev;
 		irq_data[i].type = irq_type;
 
-- 
2.20.1.7.g153144c

