Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E410571BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiGLNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiGLNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:45:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7709D2B271;
        Tue, 12 Jul 2022 06:45:41 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lj26F3fklzlVqb;
        Tue, 12 Jul 2022 21:44:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 21:45:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Jul
 2022 21:45:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>
Subject: [PATCH] Revert "spi: simplify devm_spi_register_controller"
Date:   Tue, 12 Jul 2022 21:55:04 +0800
Message-ID: <20220712135504.1055688-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 59ebbe40fb51e307032ae7f63b2749fad2d4635a.

If devm_add_action() fails in devm_add_action_or_reset(),
devm_spi_unregister() will be called, it decreases the
refcount of 'ctlr->dev' to 0, then it will cause uaf in
the drivers that calling spi_put_controller() in error path.

Fixes: 59ebbe40fb51 ("spi: simplify devm_spi_register_controller")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index dc1a324e3271..ef751ccd65be 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3130,9 +3130,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
 
-static void devm_spi_unregister(void *ctlr)
+static void devm_spi_unregister(struct device *dev, void *res)
 {
-	spi_unregister_controller(ctlr);
+	spi_unregister_controller(*(struct spi_controller **)res);
 }
 
 /**
@@ -3151,13 +3151,22 @@ static void devm_spi_unregister(void *ctlr)
 int devm_spi_register_controller(struct device *dev,
 				 struct spi_controller *ctlr)
 {
+	struct spi_controller **ptr;
 	int ret;
 
+	ptr = devres_alloc(devm_spi_unregister, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
 	ret = spi_register_controller(ctlr);
-	if (ret)
-		return ret;
+	if (!ret) {
+		*ptr = ctlr;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
 
-	return devm_add_action_or_reset(dev, devm_spi_unregister, ctlr);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_spi_register_controller);
 
-- 
2.25.1

