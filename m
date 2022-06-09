Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96063544903
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbiFIKgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbiFIKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D29320FC7E;
        Thu,  9 Jun 2022 03:36:04 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgT147GPz6885p;
        Thu,  9 Jun 2022 18:34:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:03 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:35:59 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 02/18] scsi: core: Resurrect scsi_{get,free}_host_dev()
Date:   Thu, 9 Jun 2022 18:29:03 +0800
Message-ID: <1654770559-101375-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6bd49b1a8d43ec118c55f3aaa7577729b52bde15.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/scsi_scan.c | 57 ++++++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_host.h | 10 +++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 91ac901a6682..925fe63fa370 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1978,3 +1978,60 @@ void scsi_forget_host(struct Scsi_Host *shost)
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
+/**
+ * scsi_get_host_dev - Create a scsi_device that points to the host adapter itself
+ * @shost: Host that needs a scsi_device
+ *
+ * Lock status: None assumed.
+ *
+ * Returns:     The scsi_device or NULL
+ *
+ * Notes:
+ *	Attach a single scsi_device to the Scsi_Host - this should
+ *	be made to look like a "pseudo-device" that points to the
+ *	HA itself.
+ *
+ *	Note - this device is not accessible from any high-level
+ *	drivers (including generics), which is probably not
+ *	optimal.  We can add hooks later to attach.
+ */
+struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
+{
+	struct scsi_device *sdev = NULL;
+	struct scsi_target *starget;
+
+	mutex_lock(&shost->scan_mutex);
+	if (!scsi_host_scan_allowed(shost))
+		goto out;
+	starget = scsi_alloc_target(&shost->shost_gendev, 0, shost->this_id);
+	if (!starget)
+		goto out;
+
+	sdev = scsi_alloc_sdev(starget, 0, NULL);
+	if (sdev)
+		sdev->borken = 0;
+	else
+		scsi_target_reap(starget);
+	put_device(&starget->dev);
+ out:
+	mutex_unlock(&shost->scan_mutex);
+	return sdev;
+}
+EXPORT_SYMBOL(scsi_get_host_dev);
+
+/**
+ * scsi_free_host_dev - Free a scsi_device that points to the host adapter itself
+ * @sdev: Host device to be freed
+ *
+ * Lock status: None assumed.
+ *
+ * Returns:     Nothing
+ */
+void scsi_free_host_dev(struct scsi_device *sdev)
+{
+	BUG_ON(sdev->id != sdev->host->this_id);
+
+	__scsi_remove_device(sdev);
+}
+EXPORT_SYMBOL(scsi_free_host_dev);
+
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 667d889b92b5..59aef1f178f5 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -790,6 +790,16 @@ void scsi_host_busy_iter(struct Scsi_Host *,
 
 struct class_container;
 
+/*
+ * These two functions are used to allocate and free a pseudo device
+ * which will connect to the host adapter itself rather than any
+ * physical device.  You must deallocate when you are done with the
+ * thing.  This physical pseudo-device isn't real and won't be available
+ * from any high-level drivers.
+ */
+extern void scsi_free_host_dev(struct scsi_device *);
+extern struct scsi_device *scsi_get_host_dev(struct Scsi_Host *);
+
 /*
  * DIF defines the exchange of protection information between
  * initiator and SBC block device.
-- 
2.26.2

