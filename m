Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351BC4D2F67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiCIMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiCIMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:48:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF827B1F;
        Wed,  9 Mar 2022 04:47:45 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KDBgH5NJVz1GCK2;
        Wed,  9 Mar 2022 20:42:51 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 20:47:40 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 20:47:40 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v3 3/3] scsi:libiscsi: teradown iscsi_cls_conn gracefully
Date:   Wed, 9 Mar 2022 20:57:59 -0500
Message-ID: <20220310015759.3296841-4-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220310015759.3296841-1-haowenchao@huawei.com>
References: <20220310015759.3296841-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
And remove iscsi_destroy_conn() by hand since it is not used now.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/libiscsi.c             | 10 +++++-----
 drivers/scsi/scsi_transport_iscsi.c | 27 +++++----------------------
 include/scsi/scsi_transport_iscsi.h |  1 -
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 38e68b449c08..da583a39b307 100644
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
@@ -3142,9 +3144,7 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 	spin_unlock_bh(&session->frwd_lock);
 	mutex_unlock(&session->eh_mutex);
 
-	iscsi_destroy_conn(cls_conn);
-	kfree(tmp_persistent_address);
-	kfree(tmp_local_ipaddr);
+	iscsi_put_conn(cls_conn);
 }
 EXPORT_SYMBOL_GPL(iscsi_conn_teardown);
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index fc33000a6af9..d0f996d14782 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2165,7 +2165,11 @@ static int iscsi_iter_destroy_conn_fn(struct device *dev, void *data)
 {
 	if (!iscsi_is_conn_dev(dev))
 		return 0;
-	return iscsi_destroy_conn(iscsi_dev_to_conn(dev));
+
+	iscsi_remove_conn(iscsi_dev_to_conn(dev));
+	iscsi_put_conn(iscsi_dev_to_conn(dev));
+
+	return 0;
 }
 
 void iscsi_remove_session(struct iscsi_cls_session *session)
@@ -2437,27 +2441,6 @@ void iscsi_remove_conn(struct iscsi_cls_conn *conn)
 }
 EXPORT_SYMBOL_GPL(iscsi_remove_conn);
 
-/**
- * iscsi_destroy_conn - destroy iscsi class connection
- * @conn: iscsi cls session
- *
- * This can be called from a LLD or iscsi_transport.
- */
-int iscsi_destroy_conn(struct iscsi_cls_conn *conn)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&connlock, flags);
-	list_del(&conn->conn_list);
-	spin_unlock_irqrestore(&connlock, flags);
-
-	transport_unregister_device(&conn->dev);
-	ISCSI_DBG_TRANS_CONN(conn, "Completing conn destruction\n");
-	device_unregister(&conn->dev);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iscsi_destroy_conn);
-
 void iscsi_put_conn(struct iscsi_cls_conn *conn)
 {
 	put_device(&conn->dev);
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index 4af6768e8195..aedbc4488149 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -447,7 +447,6 @@ extern int iscsi_add_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_remove_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_put_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_get_conn(struct iscsi_cls_conn *conn);
-extern int iscsi_destroy_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_unblock_session(struct iscsi_cls_session *session);
 extern void iscsi_block_session(struct iscsi_cls_session *session);
 extern int iscsi_scan_finished(struct Scsi_Host *shost, unsigned long time);
-- 
2.32.0

