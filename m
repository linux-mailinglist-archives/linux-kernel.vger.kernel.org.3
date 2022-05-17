Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB352995A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbiEQGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiEQGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:12:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303E43ED8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:12:40 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L2QdX5ZqczCskr;
        Tue, 17 May 2022 14:07:44 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 14:12:37 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <christophe.jaillet@wanadoo.fr>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <wupeng58@huawei.com>
Subject: [PATCH] mtd: rawnand: fix drivers probe/remove methods
Date:   Tue, 17 May 2022 06:07:53 +0000
Message-ID: <20220517060753.26710-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver should call pci_disable_device() if it returns from
cafe_nand_probe() with error.

Meanwhile, the driver calls pci_enable_device() in
cafe_nand_probe(), but never calls pci_disable_device()
during removal.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/mtd/nand/raw/cafe_nand.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 9dbf031716a6..af119e376352 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -679,8 +679,10 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	cafe = kzalloc(sizeof(*cafe), GFP_KERNEL);
-	if (!cafe)
-		return  -ENOMEM;
+	if (!cafe) {
+		err = -ENOMEM;
+		goto out_disable_device;
+	}
 
 	mtd = nand_to_mtd(&cafe->nand);
 	mtd->dev.parent = &pdev->dev;
@@ -801,6 +803,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	pci_iounmap(pdev, cafe->mmio);
  out_free_mtd:
 	kfree(cafe);
+ out_disable_device:
+	pci_disable_device(pdev);
  out:
 	return err;
 }
@@ -822,6 +826,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
 	pci_iounmap(pdev, cafe->mmio);
 	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
 	kfree(cafe);
+	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id cafe_nand_tbl[] = {
-- 
2.17.1

