Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3332521511
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiEJMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbiEJMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:21:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47FE10635B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:17:40 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KyH932tctzhZ0x;
        Tue, 10 May 2022 20:17:11 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 20:17:38 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 20:17:37 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>, <gregkh@linuxfoundation.org>,
        <arne.edholm@axis.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3 3/3] ubi: ubi_create_volume: Fix use-after-free when volume creation failed
Date:   Tue, 10 May 2022 20:31:26 +0800
Message-ID: <20220510123126.1820335-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220510123126.1820335-1-chengzhihao1@huawei.com>
References: <20220510123126.1820335-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an use-after-free problem for 'eba_tbl' in ubi_create_volume()'s
error handling path:

  ubi_eba_replace_table(vol, eba_tbl)
    vol->eba_tbl = tbl
out_mapping:
  ubi_eba_destroy_table(eba_tbl)   // Free 'eba_tbl'
out_unlock:
  put_device(&vol->dev)
    vol_release
      kfree(tbl->entries)	  // UAF

Fix it by removing redundant 'eba_tbl' releasing.
Fetch a reproducer in [Link].

Fixes: 493cfaeaa0c9b ("mtd: utilize new cdev_device_add helper function")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215965
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/vmt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 1bc7b3a05604..6ea95ade4ca6 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -309,7 +309,6 @@ int ubi_create_volume(struct ubi_device *ubi, struct ubi_mkvol_req *req)
 	ubi->volumes[vol_id] = NULL;
 	ubi->vol_count -= 1;
 	spin_unlock(&ubi->volumes_lock);
-	ubi_eba_destroy_table(eba_tbl);
 out_acc:
 	spin_lock(&ubi->volumes_lock);
 	ubi->rsvd_pebs -= vol->reserved_pebs;
-- 
2.31.1

