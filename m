Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABB535EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbiE0LH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiE0LHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:07:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3640CE039
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:07:52 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8hnN6ln2zgYBn;
        Fri, 27 May 2022 19:06:16 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 19:07:50 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 19:07:49 +0800
From:   keliu <liuke94@huawei.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <alistair@popple.id.au>,
        <eajames@linux.ibm.com>, <linux-fsi@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: fsi: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 11:29:19 +0000
Message-ID: <20220527112919.3444659-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/fsi/fsi-core.c | 12 ++++++------
 drivers/fsi/fsi-occ.c  | 19 ++++++++++---------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3a7b78e36701..a85f97a9ddf0 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -951,7 +951,7 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 	if (cid >= 0 && cid < 16 && type < 4) {
 		/* Try reserving the legacy number */
 		id = (cid << 4) | type;
-		id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
+		id = ida_alloc_range(&fsi_minor_ida, id, id, GFP_KERNEL);
 		if (id >= 0) {
 			*out_index = fsi_adjust_index(cid);
 			*out_dev = fsi_base_dev + id;
@@ -962,7 +962,7 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 			return id;
 		/* Fallback to non-legacy allocation */
 	}
-	id = ida_simple_get(&fsi_minor_ida, FSI_CHAR_LEGACY_TOP,
+	id = ida_alloc_range(&fsi_minor_ida, FSI_CHAR_LEGACY_TOP,
 			    FSI_CHAR_MAX_DEVICES, GFP_KERNEL);
 	if (id < 0)
 		return id;
@@ -980,7 +980,7 @@ EXPORT_SYMBOL_GPL(fsi_get_new_minor);
 
 void fsi_free_minor(dev_t dev)
 {
-	ida_simple_remove(&fsi_minor_ida, MINOR(dev));
+	ida_free(&fsi_minor_ida, MINOR(dev));
 }
 EXPORT_SYMBOL_GPL(fsi_free_minor);
 
@@ -1313,13 +1313,13 @@ int fsi_master_register(struct fsi_master *master)
 	struct device_node *np;
 
 	mutex_init(&master->scan_lock);
-	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
+	master->idx = ida_alloc_max(&master_ida, INT_MAX - 1, GFP_KERNEL);
 	dev_set_name(&master->dev, "fsi%d", master->idx);
 	master->dev.class = &fsi_master_class;
 
 	rc = device_register(&master->dev);
 	if (rc) {
-		ida_simple_remove(&master_ida, master->idx);
+		ida_free(&master_ida, master->idx);
 		return rc;
 	}
 
@@ -1337,7 +1337,7 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
 void fsi_master_unregister(struct fsi_master *master)
 {
 	if (master->idx >= 0) {
-		ida_simple_remove(&master_ida, master->idx);
+		ida_free(&master_ida, master->idx);
 		master->idx = -1;
 	}
 
diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index c9cc75fbdfb9..9240eb0379d7 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -630,17 +630,18 @@ static int occ_probe(struct platform_device *pdev)
 		rc = of_property_read_u32(dev->of_node, "reg", &reg);
 		if (!rc) {
 			/* make sure we don't have a duplicate from dts */
-			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
-						  GFP_KERNEL);
+			occ->idx = ida_alloc_range(&occ_ida, reg, reg,
+					GFP_KERNEL);
 			if (occ->idx < 0)
-				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-							  GFP_KERNEL);
+				occ->idx = ida_alloc_range(&occ_ida, 1,
+						INT_MAX - 1, GFP_KERNEL);
 		} else {
-			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-						  GFP_KERNEL);
+			occ->idx = ida_alloc_range(&occ_ida, 1,
+					INT_MAX - 1, GFP_KERNEL);
 		}
 	} else {
-		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
+		occ->idx = ida_alloc_range(&occ_ida, 1, INT_MAX - 1,
+							GFP_KERNEL);
 	}
 
 	platform_set_drvdata(pdev, occ);
@@ -654,7 +655,7 @@ static int occ_probe(struct platform_device *pdev)
 	rc = misc_register(&occ->mdev);
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
-		ida_simple_remove(&occ_ida, occ->idx);
+		ida_free(&occ_ida, occ->idx);
 		kvfree(occ->buffer);
 		return rc;
 	}
@@ -677,7 +678,7 @@ static int occ_remove(struct platform_device *pdev)
 
 	device_for_each_child(&pdev->dev, NULL, occ_unregister_child);
 
-	ida_simple_remove(&occ_ida, occ->idx);
+	ida_free(&occ_ida, occ->idx);
 
 	return 0;
 }
-- 
2.25.1

