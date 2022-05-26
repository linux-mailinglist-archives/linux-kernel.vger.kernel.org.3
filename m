Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85D5347EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbiEZBO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbiEZBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:14:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723690CFD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:14:56 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L7qgl0g17z1JC4q;
        Thu, 26 May 2022 09:13:23 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 09:14:53 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lee.jones@linaro.org>
Subject: [PATCH] mfd: ipaq-micro: Fix IRQ check in micro_probe
Date:   Thu, 26 May 2022 01:09:54 +0000
Message-ID: <20220526010954.32288-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns non-zero IRQ number on success,
negative error number on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: dcc21cc09e3c2 ("mfd: Add driver for Atmel Microcontroller on iPaq h3xxx")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mfd/ipaq-micro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index e92eeeb67a98..ac042bfd38a8 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -403,8 +403,8 @@ static int __init micro_probe(struct platform_device *pdev)
 	micro_reset_comm(micro);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
-		return -EINVAL;
+	if (irq < 0)
+		return irq;
 	ret = devm_request_irq(&pdev->dev, irq, micro_serial_isr,
 			       IRQF_SHARED, "ipaq-micro",
 			       micro);
-- 
2.17.1

