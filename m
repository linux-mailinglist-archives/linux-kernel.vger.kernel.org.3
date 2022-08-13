Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087BD5919DB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiHMKgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:36:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F042317D;
        Sat, 13 Aug 2022 03:36:18 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M4cMK5q7qzlVjr;
        Sat, 13 Aug 2022 18:33:17 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 18:36:15 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 18:36:15 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/hpre - change return type of hpre_cluster_inqry_write()
Date:   Sat, 13 Aug 2022 18:34:21 +0800
Message-ID: <20220813103421.25673-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weili Qian <qianweili@huawei.com>

hpre_cluster_inqry_write() always returns 0. So change the type
of hpre_cluster_inqry_write() to void.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 9d529df0eab9..8e0e87cede6b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -708,7 +708,7 @@ static u32 hpre_cluster_inqry_read(struct hpre_debugfs_file *file)
 	return readl(qm->io_base + offset + HPRE_CLSTR_ADDR_INQRY_RSLT);
 }

-static int hpre_cluster_inqry_write(struct hpre_debugfs_file *file, u32 val)
+static void hpre_cluster_inqry_write(struct hpre_debugfs_file *file, u32 val)
 {
 	struct hisi_qm *qm = hpre_file_to_qm(file);
 	int cluster_index = file->index - HPRE_CLUSTER_CTRL;
@@ -716,8 +716,6 @@ static int hpre_cluster_inqry_write(struct hpre_debugfs_file *file, u32 val)
 			       HPRE_CLSTR_ADDR_INTRVL;

 	writel(val, qm->io_base + offset + HPRE_CLUSTER_INQURY);
-
-	return 0;
 }

 static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
@@ -792,9 +790,7 @@ static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
 			goto err_input;
 		break;
 	case HPRE_CLUSTER_CTRL:
-		ret = hpre_cluster_inqry_write(file, val);
-		if (ret)
-			goto err_input;
+		hpre_cluster_inqry_write(file, val);
 		break;
 	default:
 		ret = -EINVAL;
--
2.30.0
