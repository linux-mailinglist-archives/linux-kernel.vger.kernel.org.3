Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64774CFD4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiCGLrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiCGLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:47:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A4866208;
        Mon,  7 Mar 2022 03:46:15 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KBxTJ4V58zdfxC;
        Mon,  7 Mar 2022 19:44:52 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 19:46:13 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 19:46:13 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH 1/2] scsi: iscsi: Add helper functions to alloc and add iscsi_cls_conn
Date:   Mon, 7 Mar 2022 19:56:53 -0500
Message-ID: <20220308005654.2281343-2-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308005654.2281343-1-haowenchao@huawei.com>
References: <20220308005654.2281343-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

iscsi_alloc_conn() would alloc and initialize iscsi_cls_conn but do
not expose it to userspace.
iscsi_add_conn() would expose it to userspace.

LLDs should split the alloc and register to 2 steps.

And simplify iscsi_create_conn() with these helper functions.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 85 +++++++++++++++++++++++------
 include/scsi/scsi_transport_iscsi.h |  3 +
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 554b6f784223..092d4429bb1d 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2341,7 +2341,7 @@ void iscsi_free_session(struct iscsi_cls_session *session)
 EXPORT_SYMBOL_GPL(iscsi_free_session);
 
 /**
- * iscsi_create_conn - create iscsi class connection
+ * iscsi_alloc_conn - alloc iscsi class connection
  * @session: iscsi cls session
  * @dd_size: private driver data size
  * @cid: connection id
@@ -2356,12 +2356,10 @@ EXPORT_SYMBOL_GPL(iscsi_free_session);
  * non-zero.
  */
 struct iscsi_cls_conn *
-iscsi_create_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
+iscsi_alloc_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
 {
 	struct iscsi_transport *transport = session->transport;
 	struct iscsi_cls_conn *conn;
-	unsigned long flags;
-	int err;
 
 	conn = kzalloc(sizeof(*conn) + dd_size, GFP_KERNEL);
 	if (!conn)
@@ -2383,35 +2381,90 @@ iscsi_create_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
 	dev_set_name(&conn->dev, "connection%d:%u", session->sid, cid);
 	conn->dev.parent = &session->dev;
 	conn->dev.release = iscsi_conn_release;
+
+	return conn;
+
+free_conn:
+	kfree(conn);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(iscsi_alloc_conn);
+
+/**
+ * iscsi_add_conn - add iscsi class connection
+ * @conn: iscsi cls connection
+ *
+ * this would expose iscsi_cls_conn to sysfs, so make sure the related
+ * resources when access sysfs attributes are initialized before calling this.
+ */
+int iscsi_add_conn(struct iscsi_cls_conn *conn)
+{
+	int err;
+	unsigned long flags;
+	struct iscsi_cls_session *session = iscsi_dev_to_session(conn->dev.parent);
+
 	err = device_register(&conn->dev);
 	if (err) {
 		iscsi_cls_session_printk(KERN_ERR, session, "could not "
 					 "register connection's dev\n");
-		goto release_parent_ref;
+		put_device(&session->dev);
+		return err;
 	}
 	err = transport_register_device(&conn->dev);
 	if (err) {
 		iscsi_cls_session_printk(KERN_ERR, session, "could not "
 					 "register transport's dev\n");
-		goto release_conn_ref;
+		device_unregister(&conn->dev);
+		put_device(&session->dev);
+		return err;
 	}
 
 	spin_lock_irqsave(&connlock, flags);
 	list_add(&conn->conn_list, &connlist);
 	spin_unlock_irqrestore(&connlock, flags);
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iscsi_add_conn);
+
+/**
+ * iscsi_create_conn - create iscsi class connection
+ * @session: iscsi cls session
+ * @dd_size: private driver data size
+ * @cid: connection id
+ *
+ * This can be called from a LLD or iscsi_transport. The connection
+ * is child of the session so cid must be unique for all connections
+ * on the session.
+ *
+ * Since we do not support MCS, cid will normally be zero. In some cases
+ * for software iscsi we could be trying to preallocate a connection struct
+ * in which case there could be two connection structs and cid would be
+ * non-zero.
+ *
+ * Note: iscsi_cls_conn would be exposed to sysfs after this function, it
+ * means attributes of iscsi_cls_conn are accessible to userspace. So the
+ * caller must make sure everything related these sysfs attributes are
+ * already initialized.
+ */
+struct iscsi_cls_conn *
+iscsi_create_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
+{
+	struct iscsi_cls_conn *conn;
+	int err;
+
+	conn = iscsi_alloc_conn(session, dd_size, cid);
+	if (!conn)
+		return NULL;
+
+	err = iscsi_add_conn(conn);
+	if (err) {
+		kfree(conn);
+		return NULL;
+	}
+
 	ISCSI_DBG_TRANS_CONN(conn, "Completed conn creation\n");
 	return conn;
-
-release_conn_ref:
-	device_unregister(&conn->dev);
-	put_device(&session->dev);
-	return NULL;
-release_parent_ref:
-	put_device(&session->dev);
-free_conn:
-	kfree(conn);
-	return NULL;
 }
 
 EXPORT_SYMBOL_GPL(iscsi_create_conn);
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index c5d7810fd792..fd9ce99c2186 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -441,6 +441,9 @@ extern struct iscsi_cls_session *iscsi_create_session(struct Scsi_Host *shost,
 						unsigned int target_id);
 extern void iscsi_remove_session(struct iscsi_cls_session *session);
 extern void iscsi_free_session(struct iscsi_cls_session *session);
+extern int iscsi_add_conn(struct iscsi_cls_conn *conn);
+extern struct iscsi_cls_conn *iscsi_alloc_conn(struct iscsi_cls_session *sess,
+						int dd_size, uint32_t cid);
 extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
 						int dd_size, uint32_t cid);
 extern void iscsi_put_conn(struct iscsi_cls_conn *conn);
-- 
2.32.0

