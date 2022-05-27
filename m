Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA9535A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbiE0HdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiE0HdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:33:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339CF688C;
        Fri, 27 May 2022 00:33:01 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8c1V6yPNz1JCRn;
        Fri, 27 May 2022 15:31:26 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:32:59 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:32:59 +0800
From:   keliu <liuke94@huawei.com>
To:     <ulf.hansson@linaro.org>, <axboe@kernel.dk>, <Avri.Altman@wdc.com>,
        <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>,
        <CLoehle@hyperstone.com>, <swboyd@chromium.org>,
        <digetx@gmail.com>, <bigeasy@linutronix.de>,
        <wsa+renesas@sang-engineering.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <dev@lynxeye.de>,
        <liuke94@huawei.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: core: Directly use ida_free()
Date:   Fri, 27 May 2022 07:54:28 +0000
Message-ID: <20220527075428.2475782-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Use ida_free() instead of deprecated
ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/mmc/core/block.c | 8 ++++----
 drivers/mmc/core/host.c  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 506dc900f5c7..c8d702db483d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -204,7 +204,7 @@ static void mmc_blk_kref_release(struct kref *ref)
 	int devidx;
 
 	devidx = mmc_get_devidx(md->disk);
-	ida_simple_remove(&mmc_blk_ida, devidx);
+	ida_free(&mmc_blk_ida, devidx);
 
 	mutex_lock(&open_lock);
 	md->disk->private_data = NULL;
@@ -2495,7 +2495,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
  err_kfree:
 	kfree(md);
  out:
-	ida_simple_remove(&mmc_blk_ida, devidx);
+	ida_free(&mmc_blk_ida, devidx);
 	return ERR_PTR(ret);
 }
 
@@ -2621,7 +2621,7 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
 {
 	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
 
-	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
+	ida_free(&mmc_rpmb_ida, rpmb->id);
 	kfree(rpmb);
 }
 
@@ -2643,7 +2643,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 
 	rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
 	if (!rpmb) {
-		ida_simple_remove(&mmc_rpmb_ida, devidx);
+		ida_free(&mmc_rpmb_ida, devidx);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 2ed2b4d5e5a5..9332e82e175a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -76,7 +76,7 @@ static void mmc_host_classdev_release(struct device *dev)
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	wakeup_source_unregister(host->ws);
 	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
-		ida_simple_remove(&mmc_host_ida, host->index);
+		ida_free(&mmc_host_ida, host->index);
 	kfree(host);
 }
 
-- 
2.25.1

