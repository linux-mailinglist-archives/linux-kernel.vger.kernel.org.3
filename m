Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94107535B28
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbiE0IJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiE0IJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:09:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F01161;
        Fri, 27 May 2022 01:09:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8cqQ63MKzbbq5;
        Fri, 27 May 2022 16:07:46 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:09:20 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:09:19 +0800
From:   keliu <liuke94@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <open-iscsi@googlegroups.com>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: scsi: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 08:30:49 +0000
Message-ID: <20220527083049.2552526-1-liuke94@huawei.com>
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

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/scsi/hosts.c                | 4 ++--
 drivers/scsi/scsi_transport_iscsi.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index f69b77cbf538..ec16cfad034e 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -350,7 +350,7 @@ static void scsi_host_dev_release(struct device *dev)
 
 	kfree(shost->shost_data);
 
-	ida_simple_remove(&host_index_ida, shost->host_no);
+	ida_free(&host_index_ida, shost->host_no);
 
 	if (shost->shost_state != SHOST_CREATED)
 		put_device(parent);
@@ -395,7 +395,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	init_waitqueue_head(&shost->host_wait);
 	mutex_init(&shost->scan_mutex);
 
-	index = ida_simple_get(&host_index_ida, 0, 0, GFP_KERNEL);
+	index = ida_alloc(&host_index_ida, GFP_KERNEL);
 	if (index < 0) {
 		kfree(shost);
 		return NULL;
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 2c0dd64159b0..2578db4c095d 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1975,7 +1975,7 @@ static void __iscsi_unbind_session(struct work_struct *work)
 	scsi_remove_target(&session->dev);
 
 	if (session->ida_used)
-		ida_simple_remove(&iscsi_sess_ida, target_id);
+		ida_free(&iscsi_sess_ida, target_id);
 
 unbind_session_exit:
 	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
@@ -2044,7 +2044,7 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
 		return -ENOMEM;
 
 	if (target_id == ISCSI_MAX_TARGET) {
-		id = ida_simple_get(&iscsi_sess_ida, 0, 0, GFP_KERNEL);
+		id = ida_alloc(&iscsi_sess_ida, GFP_KERNEL);
 
 		if (id < 0) {
 			iscsi_cls_session_printk(KERN_ERR, session,
@@ -2083,7 +2083,7 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
 	device_del(&session->dev);
 release_ida:
 	if (session->ida_used)
-		ida_simple_remove(&iscsi_sess_ida, session->target_id);
+		ida_free(&iscsi_sess_ida, session->target_id);
 destroy_wq:
 	destroy_workqueue(session->workq);
 	return err;
-- 
2.25.1

