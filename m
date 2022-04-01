Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072ED4ED920
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiCaMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiCaMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:02:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB81C7E92;
        Thu, 31 Mar 2022 04:59:33 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KThdB4XwFzgYHy;
        Thu, 31 Mar 2022 19:57:50 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 19:59:30 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 31 Mar
 2022 19:59:29 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>,
        <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
Subject: [PATCH] scsi: sd: cleanup gendisk if device_add_disk() failed
Date:   Thu, 31 Mar 2022 21:10:19 -0400
Message-ID: <20220401011018.1026553-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forget to call blk_cleanup_disk() when device_add_disk() failed.
Which would cause memory leak of gendisk and sched_tags alloced in
elevator_init_mq()

Reference:https://syzkaller.appspot.com/x/log.txt?x=13b41dcb700000
Reported-and-tested-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..4620a1158272 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3475,6 +3475,7 @@ static int sd_probe(struct device *dev)
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
 		put_device(&sdkp->disk_dev);
+		blk_cleanup_disk(gd);
 		goto out;
 	}
 
-- 
2.32.0

