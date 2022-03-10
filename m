Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596FA4D2F5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiCIMsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiCIMsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:48:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5D1D30C;
        Wed,  9 Mar 2022 04:47:41 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KDBlD57pFzfYkY;
        Wed,  9 Mar 2022 20:46:16 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 20:47:39 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 20:47:38 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v3 1/3] scsi: iscsi: Add helper functions to manage iscsi_cls_conn
Date:   Wed, 9 Mar 2022 20:57:57 -0500
Message-ID: <20220310015759.3296841-2-haowenchao@huawei.com>
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

iscsi_alloc_conn(): alloc and initialize iscsi_cls_conn
iscsi_add_conn(): expose iscsi_cls_conn to userspace's via sysfs.
iscsi_remove_conn(): remove iscsi_cls_conn from sysfs

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 97 +++++++++++++++++++++++++++++
 include/scsi/scsi_transport_iscsi.h |  4 ++
 2 files changed, 101 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 554b6f784223..65117ed5626e 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2340,6 +2340,103 @@ void iscsi_free_session(struct iscsi_cls_session *session)
 }
 EXPORT_SYMBOL_GPL(iscsi_free_session);
 
+/**
+ * iscsi_alloc_conn - alloc iscsi class connection
+ * @session: iscsi cls session
+ * @dd_size: private driver data size
+ * @cid: connection id
+ */
+struct iscsi_cls_conn *
+iscsi_alloc_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
+{
+	struct iscsi_transport *transport = session->transport;
+	struct iscsi_cls_conn *conn;
+
+	conn = kzalloc(sizeof(*conn) + dd_size, GFP_KERNEL);
+	if (!conn)
+		return NULL;
+	if (dd_size)
+		conn->dd_data = &conn[1];
+
+	mutex_init(&conn->ep_mutex);
+	INIT_LIST_HEAD(&conn->conn_list);
+	INIT_WORK(&conn->cleanup_work, iscsi_cleanup_conn_work_fn);
+	conn->transport = transport;
+	conn->cid = cid;
+	conn->state = ISCSI_CONN_DOWN;
+
+	/* this is released in the dev's release function */
+	if (!get_device(&session->dev))
+		goto free_conn;
+
+	dev_set_name(&conn->dev, "connection%d:%u", session->sid, cid);
+	device_initialize(&conn->dev);
+	conn->dev.parent = &session->dev;
+	conn->dev.release = iscsi_conn_release;
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
+	err = device_add(&conn->dev);
+	if (err) {
+		iscsi_cls_session_printk(KERN_ERR, session,
+					 "could not register connection's dev\n");
+		return err;
+	}
+	err = transport_register_device(&conn->dev);
+	if (err) {
+		iscsi_cls_session_printk(KERN_ERR, session,
+					 "could not register transport's dev\n");
+		device_del(&conn->dev);
+		return err;
+	}
+
+	spin_lock_irqsave(&connlock, flags);
+	list_add(&conn->conn_list, &connlist);
+	spin_unlock_irqrestore(&connlock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iscsi_add_conn);
+
+/**
+ * iscsi_remove_conn - remove iscsi class connection from sysfs
+ * @conn: iscsi cls connection
+ *
+ * this would remove iscsi_cls_conn from sysfs, and wait for previous
+ * read/write of iscsi_cls_conn's attributes in sysfs finishing
+ */
+void iscsi_remove_conn(struct iscsi_cls_conn *conn)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&connlock, flags);
+	list_del(&conn->conn_list);
+	spin_unlock_irqrestore(&connlock, flags);
+
+	transport_unregister_device(&conn->dev);
+	device_del(&conn->dev);
+}
+EXPORT_SYMBOL_GPL(iscsi_remove_conn);
+
 /**
  * iscsi_create_conn - create iscsi class connection
  * @session: iscsi cls session
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index c5d7810fd792..ae686addde0c 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -441,6 +441,10 @@ extern struct iscsi_cls_session *iscsi_create_session(struct Scsi_Host *shost,
 						unsigned int target_id);
 extern void iscsi_remove_session(struct iscsi_cls_session *session);
 extern void iscsi_free_session(struct iscsi_cls_session *session);
+extern struct iscsi_cls_conn *iscsi_alloc_conn(struct iscsi_cls_session *sess,
+						int dd_size, uint32_t cid);
+extern int iscsi_add_conn(struct iscsi_cls_conn *conn);
+extern void iscsi_remove_conn(struct iscsi_cls_conn *conn);
 extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
 						int dd_size, uint32_t cid);
 extern void iscsi_put_conn(struct iscsi_cls_conn *conn);
-- 
2.32.0

