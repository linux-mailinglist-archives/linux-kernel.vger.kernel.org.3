Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C095981E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbiHRLFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiHRLFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:05:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC6E9D67D;
        Thu, 18 Aug 2022 04:05:17 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7hmK5cKnzlWKM;
        Thu, 18 Aug 2022 19:02:09 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 19:05:14 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <megaraidlinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>
Subject: [PATCH -next] scsi: megaraid: Make local symbol 'megasas_debugfs_root' static
Date:   Thu, 18 Aug 2022 19:13:16 +0800
Message-ID: <20220818111316.2566815-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/scsi/megaraid/megaraid_sas_debugfs.c:45:15: warning: symbol 'megasas_debugfs_root' was not declared. Should it be static?

The `megasas_debugfs_root` symbol is not dereferenced
in drivers/scsi/megaraid/megaraid_sas_base.c any more,
remove the declaration here.

After that, the megasas_debugfs_root symbol is no used
any more except this file
(drivers/scsi/megaraid/megaraid_sas_debugfs.c), so
decorate it with `static`.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c    | 1 -
 drivers/scsi/megaraid/megaraid_sas_debugfs.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index f6c37a97544e..09292749ed97 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -217,7 +217,6 @@ static bool support_pci_lane_margining;
 /* define lock for aen poll */
 static DEFINE_SPINLOCK(poll_aen_lock);
 
-extern struct dentry *megasas_debugfs_root;
 extern int megasas_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num);
 
 void
diff --git a/drivers/scsi/megaraid/megaraid_sas_debugfs.c b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
index c69760775efa..4c70aab258e3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_debugfs.c
+++ b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
@@ -42,7 +42,7 @@
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-struct dentry *megasas_debugfs_root;
+static struct dentry *megasas_debugfs_root;
 
 static ssize_t
 megasas_debugfs_read(struct file *filp, char __user *ubuf, size_t cnt,
-- 
2.25.1

