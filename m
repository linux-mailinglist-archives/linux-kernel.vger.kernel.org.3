Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8354D19DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiCHN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbiCHN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:59:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ABC27FEB;
        Tue,  8 Mar 2022 05:58:40 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCcMc5g0rzdfpm;
        Tue,  8 Mar 2022 21:57:16 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 21:58:38 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:58:38 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v2 1/3] scsi: iscsi: Add helper functions to manage iscsi_cls_conn
Date:   Tue, 8 Mar 2022 22:09:14 -0500
Message-ID: <20220309030916.2932316-2-haowenchao@huawei.com>
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

iscsi_alloc_conn(): alloc and initialize iscsi_cls_conn
iscsi_add_conn(): expose iscsi_cls_conn to userspace's via sysfs.
iscsi_remove_conn(): remove iscsi_cls_conn from sysfs
iscsi_free_conn(): free iscsi_cls_conn

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 107 ++++++++++++++++++++++++++++
 include/scsi/scsi_transport_iscsi.h |   5 ++
 2 files changed, 112 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 554b6f784223..8e97c6f88359 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2340,6 +2340,113 @@ void iscsi_free_session(struct iscsi_cls_session *session)
 }
 EXPORT_SYMBOL_GPL(iscsi_free_session);
 
+/**
+ * iscsi_alloc_conn - alloc iscsi class connection
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
+		put_device(&session->dev);
+		return err;
+	}
+	err = transport_register_device(&conn->dev);
+	if (err) {
+		iscsi_cls_session_printk(KERN_ERR, session,
+					 "could not register transport's dev\n");
+		device_del(&conn->dev);
+		put_device(&session->dev);
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
+	device_del(&conn->dev);
+}
+EXPORT_SYMBOL_GPL(iscsi_remove_conn);
+
+void iscsi_free_conn(struct iscsi_cls_conn *conn)
+{
+	put_device(&conn->dev);
+}
+EXPORT_SYMBOL_GPL(iscsi_free_conn);
+
 /**
  * iscsi_create_conn - create iscsi class connection
  * @session: iscsi cls session
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index c5d7810fd792..346f65bc3861 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -441,6 +441,11 @@ extern struct iscsi_cls_session *iscsi_create_session(struct Scsi_Host *shost,
 						unsigned int target_id);
 extern void iscsi_remove_session(struct iscsi_cls_session *session);
 extern void iscsi_free_session(struct iscsi_cls_session *session);
+extern struct iscsi_cls_conn *iscsi_alloc_conn(struct iscsi_cls_session *sess,
+						int dd_size, uint32_t cid);
+extern int iscsi_add_conn(struct iscsi_cls_conn *conn);
+extern void iscsi_remove_conn(struct iscsi_cls_conn *conn);
+extern void iscsi_free_conn(struct iscsi_cls_conn *conn);
 extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
 						int dd_size, uint32_t cid);
 extern void iscsi_put_conn(struct iscsi_cls_conn *conn);
-- 
2.32.0

