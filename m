Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD55359B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344633AbiE0Gzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiE0Gzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:55:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B1FB7FB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:55:48 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8bCT2T1WzjX4r;
        Fri, 27 May 2022 14:55:01 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:55:46 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:55:45 +0800
From:   keliu <liuke94@huawei.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: phy: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:17:14 +0000
Message-ID: <20220527071714.2359990-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/phy/phy-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 91e28d6ce450..7115727476dc 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -910,7 +910,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	if (!phy)
 		return ERR_PTR(-ENOMEM);
 
-	id = ida_simple_get(&phy_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&phy_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(dev, "unable to get id\n");
 		ret = id;
@@ -1180,7 +1180,7 @@ static void phy_release(struct device *dev)
 	phy = to_phy(dev);
 	dev_vdbg(dev, "releasing '%s'\n", dev_name(dev));
 	regulator_put(phy->pwr);
-	ida_simple_remove(&phy_ida, phy->id);
+	ida_free(&phy_ida, phy->id);
 	kfree(phy);
 }
 
-- 
2.25.1

