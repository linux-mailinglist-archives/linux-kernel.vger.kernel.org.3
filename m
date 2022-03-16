Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E544DADBE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354976AbiCPJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbiCPJve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:51:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE701606D5;
        Wed, 16 Mar 2022 02:50:19 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KJQT84XtZz67MtS;
        Wed, 16 Mar 2022 17:48:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 16 Mar 2022 10:50:17 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 09:50:14 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <damien.lemoal@opensource.wdc.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <bvanassche@acm.org>,
        <martin.wilck@suse.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <hare@suse.de>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2] scsi: core: Fix sbitmap depth in scsi_realloc_sdev_budget_map()
Date:   Wed, 16 Mar 2022 17:44:30 +0800
Message-ID: <1647423870-143867-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit edb854a3680b ("scsi: core: Reallocate device's budget map on
queue depth change"), the sbitmap for the device budget map may be
reallocated after the slave device depth is configured.

When the sbitmap is reallocated we use the result from
scsi_device_max_queue_depth() for the sbitmap size, but don't resize to
match the actual device queue depth.

Fix by resizing the sbitmap after reallocating the budget sbitmap. We do
this instead of init'ing the sbitmap to the device queue depth as the user
may want to change the queue depth later via sysfs or other.

Fixes: edb854a3680b ("scsi: core: Reallocate device's budget map on queue depth change")
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
Changes since v1 (apart from sending as a separate patch):
- Add fixes and RB tag (thanks)
- mention in commit message why we don't init sbitmap at queue depth

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f4e6c68ac99e..2ef78083f1ef 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -223,6 +223,8 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 	int ret;
 	struct sbitmap sb_backup;
 
+	depth = min_t(unsigned int, depth, scsi_device_max_queue_depth(sdev));
+
 	/*
 	 * realloc if new shift is calculated, which is caused by setting
 	 * up one new default queue depth after calling ->slave_configure
@@ -245,6 +247,9 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 				scsi_device_max_queue_depth(sdev),
 				new_shift, GFP_KERNEL,
 				sdev->request_queue->node, false, true);
+	if (!ret)
+		sbitmap_resize(&sdev->budget_map, depth);
+
 	if (need_free) {
 		if (ret)
 			sdev->budget_map = sb_backup;
-- 
2.26.2

