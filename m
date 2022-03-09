Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7484D19E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347310AbiCHN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347276AbiCHN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:59:39 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2947B1A81A;
        Tue,  8 Mar 2022 05:58:42 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KCcJz4l9mz9sS1;
        Tue,  8 Mar 2022 21:54:59 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 21:58:40 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:58:39 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v2 3/3] scsi:libiscsi: teardown iscsi_cls_conn gracefully
Date:   Tue, 8 Mar 2022 22:09:16 -0500
Message-ID: <20220309030916.2932316-4-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220309030916.2932316-1-haowenchao@huawei.com>
References: <20220309030916.2932316-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

commit 1b8d0300a3e9 ("scsi: libiscsi: Fix UAF in
iscsi_conn_get_param()/iscsi_conn_teardown()") fixed an UAF in
iscsi_conn_get_param() and introduced 2 tmp_xxx varibles, the
implement looks ugly.

We can fix this UAF with the help of device_del() gracefully.
Call iscsi_remove_conn() at the beginning of iscsi_conn_teardown would
make userspace unable to see iscsi_cls_conn any more, then we can free
memory safely.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/libiscsi.c             | 8 ++++----
 drivers/scsi/scsi_transport_iscsi.c | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 43f903bce0b8..0d57521751dd 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3109,8 +3109,8 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iscsi_session *session = conn->session;
-	char *tmp_persistent_address = conn->persistent_address;
-	char *tmp_local_ipaddr = conn->local_ipaddr;
+
+	iscsi_remove_conn(cls_conn);
 
 	del_timer_sync(&conn->transport_timer);
 
@@ -3132,6 +3132,8 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 	spin_lock_bh(&session->frwd_lock);
 	free_pages((unsigned long) conn->data,
 		   get_order(ISCSI_DEF_MAX_RECV_SEG_LEN));
+	kfree(conn->persistent_address);
+	kfree(conn->local_ipaddr);
 	/* regular RX path uses back_lock */
 	spin_lock_bh(&session->back_lock);
 	kfifo_in(&session->cmdpool.queue, (void*)&conn->login_task,
@@ -3143,8 +3145,6 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 	mutex_unlock(&session->eh_mutex);
 
 	iscsi_destroy_conn(cls_conn);
-	kfree(tmp_persistent_address);
-	kfree(tmp_local_ipaddr);
 }
 EXPORT_SYMBOL_GPL(iscsi_conn_teardown);
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index ca724eed4f4d..7b4d998708e7 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2165,6 +2165,7 @@ static int iscsi_iter_destroy_conn_fn(struct device *dev, void *data)
 {
 	if (!iscsi_is_conn_dev(dev))
 		return 0;
+	iscsi_remove_conn(iscsi_dev_to_conn(dev));
 	return iscsi_destroy_conn(iscsi_dev_to_conn(dev));
 }
 
@@ -2463,7 +2464,7 @@ int iscsi_destroy_conn(struct iscsi_cls_conn *conn)
 
 	transport_unregister_device(&conn->dev);
 	ISCSI_DBG_TRANS_CONN(conn, "Completing conn destruction\n");
-	device_unregister(&conn->dev);
+	iscsi_free_conn(conn);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iscsi_destroy_conn);
-- 
2.32.0

