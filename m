Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D7585A35
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiG3LQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 07:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiG3LQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 07:16:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174871EC40
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:16:40 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lw1yN4yqkz9svc;
        Sat, 30 Jul 2022 19:15:24 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 19:16:38 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 30 Jul
 2022 19:16:37 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <zach.brown@ni.com>, <ben.shelton@ni.com>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ubi: Fix UAF wear-leveling entry in eraseblk_count_seq_show()
Date:   Sat, 30 Jul 2022 19:28:37 +0800
Message-ID: <20220730112837.51184-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wear-leveling entry could be freed in error path, which may be accessed
again in eraseblk_count_seq_show(), for example:

__erase_worker                eraseblk_count_seq_show
                                wl = ubi->lookuptbl[*block_number]
				if (wl)
  wl_entry_destroy
    ubi->lookuptbl[e->pnum] = NULL
    kmem_cache_free(ubi_wl_entry_slab, e)
		                   erase_count = wl->ec  // UAF!

Wear-leveling entry updating/accessing in ubi->lookuptbl should be
protected by ubi->wl_lock, fix it by adding ubi->wl_lock to serialize
wl entry accessing between wl_entry_destroy() and
eraseblk_count_seq_show().

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216305
Fixes: 7bccd12d27b7e3 ("ubi: Add debugfs file for tracking PEB state")
Fixes: 801c135ce73d5d ("UBI: Unsorted Block Images")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/wl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index ee0100740869..5218e6edde58 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -890,8 +890,11 @@ static int wear_leveling_worker(struct ubi_device *ubi, struct ubi_work *wrk,
 
 	err = do_sync_erase(ubi, e1, vol_id, lnum, 0);
 	if (err) {
-		if (e2)
+		if (e2) {
+			spin_lock(&ubi->wl_lock);
 			wl_entry_destroy(ubi, e2);
+			spin_unlock(&ubi->wl_lock);
+		}
 		goto out_ro;
 	}
 
@@ -1130,14 +1133,18 @@ static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
 		/* Re-schedule the LEB for erasure */
 		err1 = schedule_erase(ubi, e, vol_id, lnum, 0, false);
 		if (err1) {
+			spin_lock(&ubi->wl_lock);
 			wl_entry_destroy(ubi, e);
+			spin_unlock(&ubi->wl_lock);
 			err = err1;
 			goto out_ro;
 		}
 		return err;
 	}
 
+	spin_lock(&ubi->wl_lock);
 	wl_entry_destroy(ubi, e);
+	spin_unlock(&ubi->wl_lock);
 	if (err != -EIO)
 		/*
 		 * If this is not %-EIO, we have no idea what to do. Scheduling
-- 
2.31.1

