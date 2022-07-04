Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB63564BF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiGDC64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDC6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:58:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE752AE0;
        Sun,  3 Jul 2022 19:58:53 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lbr790KjpzkWlS;
        Mon,  4 Jul 2022 10:56:53 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 10:58:23 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 10:58:23 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <stanley.chu@mediatek.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Ren Zhijie" <renzhijie2@huawei.com>
Subject: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
Date:   Mon, 4 Jul 2022 10:56:32 +0800
Message-ID: <20220704025632.235968-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set,
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_suspend’:
drivers/ufs/host/ufs-mediatek.c:1435:8: error: implicit declaration of function ‘ufshcd_runtime_suspend’; did you mean ‘ufs_mtk_runtime_suspend’? [-Werror=implicit-function-declaration]
  ret = ufshcd_runtime_suspend(dev);
        ^~~~~~~~~~~~~~~~~~~~~~
        ufs_mtk_runtime_suspend
drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_resume’:
drivers/ufs/host/ufs-mediatek.c:1450:9: error: implicit declaration of function ‘ufshcd_runtime_resume’; did you mean ‘ufs_mtk_runtime_resume’? [-Werror=implicit-function-declaration]
  return ufshcd_runtime_resume(dev);
         ^~~~~~~~~~~~~~~~~~~~~
         ufs_mtk_runtime_resume
At top level:
drivers/ufs/host/ufs-mediatek.c:1444:12: error: ‘ufs_mtk_runtime_resume’ defined but not used [-Werror=unused-function]
 static int ufs_mtk_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~
drivers/ufs/host/ufs-mediatek.c:1430:12: error: ‘ufs_mtk_runtime_suspend’ defined but not used [-Werror=unused-function]
 static int ufs_mtk_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The declarations of func "ufshcd_runtime_suspend()" and "ufshcd_runtime_resume()" depended on CONFIG_PM, so the function wrappers "ufs_mtk_runtime_suspend()" and "ufs_mtk_runtime_resume()"  both should warpped by CONFIG_PM too.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e7bf1d50063c ("scsi: ufs: ufs-mediatek: Fix build warnings")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/ufs/host/ufs-mediatek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index c958279bdd8f..e006c2528a3a 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1427,6 +1427,7 @@ static int ufs_mtk_system_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM
 static int ufs_mtk_runtime_suspend(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -1449,6 +1450,7 @@ static int ufs_mtk_runtime_resume(struct device *dev)
 
 	return ufshcd_runtime_resume(dev);
 }
+#endif
 
 static const struct dev_pm_ops ufs_mtk_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,
-- 
2.17.1

