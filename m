Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D7575704
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiGNVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiGNVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:12 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF46EE9E;
        Thu, 14 Jul 2022 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834210; x=1689370210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MKXPIIFCKq1Ix/NaBw0lwW3hR6vL7FK0OLfTG46MOK8=;
  b=ICGSY2Hnkt1QXtX1aWyWcc0g707qyHNr4nBFmINuNYfjXJExlXYVIWPE
   w5Jy3jcwVFIP4LwjQW017xyaRxYyMuPbSO9yH+3Y/L4x+Scbrj64jn78G
   3MeP7/tq7o9z+FOWRRWHZPpe2rOPf4uL53hi1kp3se4oLTXtELJR+Trq0
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:08 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:08 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:08 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 08/11] gunyah: rsc_mgr: Add resource manager RPC core
Date:   Thu, 14 Jul 2022 14:29:37 -0700
Message-ID: <20220714212940.2988436-9-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714212940.2988436-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220714212940.2988436-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource manager is a special virtual machine which is always
running on a Gunyah system. It provides APIs for creating and destroying
VMs, secure memory management, sharing/lending of memory between VMs,
and setup of inter-VM communication. Calls to the resource manager are
made via message queues.

This patch implements the basic probing and RPC mechanism to make those
API calls. Request/response calls can be made with gh_rm_call.
Drivers can also register to notifications pushed by RM via
gh_rm_register_notifier

Specific API calls that resource manager supports will be implemented in
subsequent patches.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                          |   2 +-
 drivers/virt/gunyah/Kconfig          |   1 +
 drivers/virt/gunyah/Makefile         |   1 +
 drivers/virt/gunyah/gunyah_private.h |   3 +
 drivers/virt/gunyah/rsc_mgr.c        | 623 +++++++++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h        |  34 ++
 drivers/virt/gunyah/sysfs.c          |   7 +
 include/linux/gunyah_rsc_mgr.h       |  29 ++
 8 files changed, 699 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.h
 create mode 100644 include/linux/gunyah_rsc_mgr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d46c1f91b92..4bbec2ae4a6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8745,7 +8745,7 @@ F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
 F:	arch/arm64/include/asm/gunyah.h
 F:	drivers/virt/gunyah/
-F:	include/linux/gunyah.h
+F:	include/linux/gunyah*.h
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index e88289963518..2ef4887e280d 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -4,6 +4,7 @@ config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
 	select SYS_HYPERVISOR
+	select AUXILIARY_BUS
 	help
 	  The Gunyah drivers are the helper interfaces that runs in a guest VM
 	  such as basic inter-VM IPC and signaling mechanism,s and higher level
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 94dc8e738911..86655bca8944 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 gunyah-y += sysfs.o device.o msgq.o
+gunyah-y += rsc_mgr.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
\ No newline at end of file
diff --git a/drivers/virt/gunyah/gunyah_private.h b/drivers/virt/gunyah/gunyah_private.h
index 2ade32bd9bdf..6483ffa8c15d 100644
--- a/drivers/virt/gunyah/gunyah_private.h
+++ b/drivers/virt/gunyah/gunyah_private.h
@@ -12,4 +12,7 @@ void gunyah_bus_exit(void);
 int __init gh_msgq_init(void);
 void gh_msgq_exit(void);
 
+int __init gh_rsc_mgr_init(void);
+void gh_rsc_mgr_exit(void);
+
 #endif
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
new file mode 100644
index 000000000000..b8268ee02fab
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_rsc_mgr: " fmt
+
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/kthread.h>
+#include <linux/notifier.h>
+#include <linux/irqdomain.h>
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include "gunyah_private.h"
+#include "rsc_mgr.h"
+
+/* Resource Manager Header */
+struct gh_rm_rpc_hdr {
+	u8 version:4,
+		hdr_words:4;
+	u8 type:2,
+		fragments:6;
+	u16 seq;
+	u32 msg_id;
+} __packed;
+
+/* Standard reply header */
+struct gh_rm_rpc_reply_hdr {
+	struct gh_rm_rpc_hdr rpc_hdr;
+	u32 err_code;
+} __packed;
+
+/* RPC Header versions */
+#define GH_RM_RPC_HDR_VERSION_ONE	0x1
+
+/* RPC Header words */
+#define GH_RM_RPC_HDR_WORDS		0x2
+
+/* RPC Message types */
+#define GH_RM_RPC_TYPE_CONT		0x0
+#define GH_RM_RPC_TYPE_REQ		0x1
+#define GH_RM_RPC_TYPE_RPLY		0x2
+#define GH_RM_RPC_TYPE_NOTIF		0x3
+
+#define GH_RM_MAX_NUM_FRAGMENTS		62
+
+#define GH_RM_MAX_MSG_SIZE	(GH_MSGQ_MAX_MSG_SIZE - sizeof(struct gh_rm_rpc_hdr))
+
+/**
+ * struct gh_rm_connection - Represents a complete message from resource manager
+ * @payload: Combined payload of all the fragments (i.e. msg headers stripped off).
+ * @size: Size of the payload.
+ * @ret: Linux return code, set in case there was an error processing the connection.
+ * @msg_id: Message ID from the header.
+ * @type: GH_RM_RPC_TYPE_RPLY or GH_RM_RPC_TYPE_NOTIF.
+ * @num_fragments: total number of fragments expected to be received for this connection.
+ * @fragments_recieved: fragments received so far.
+ * @rm_error: For request/reply sequences with standard replies.
+ * @seq: Sequence ID for the main message.
+ */
+struct gh_rm_connection {
+	void *payload;
+	size_t size;
+	int ret;
+	u32 msg_id;
+	u8 type;
+
+	u8 num_fragments;
+	u8 fragments_received;
+
+	/* only for req/reply sequence */
+	u32 rm_error;
+	u16 seq;
+	struct completion seq_done;
+};
+
+struct gh_rm_notif_complete {
+	struct gh_rm_connection *conn;
+	struct work_struct work;
+};
+
+struct gh_rsc_mgr {
+	struct task_struct *recv_task;
+	struct gunyah_device *msgq_tx, *msgq_rx;
+
+	struct idr call_idr;
+	struct mutex call_idr_lock;
+
+	struct mutex send_lock;
+};
+
+static struct gh_rsc_mgr *__rsc_mgr;
+SRCU_NOTIFIER_HEAD_STATIC(gh_rm_notifier);
+
+static struct gh_rm_connection *gh_rm_alloc_connection(u32 msg_id, u8 type)
+{
+	struct gh_rm_connection *connection;
+
+	connection = kzalloc(sizeof(*connection), GFP_KERNEL);
+	if (!connection)
+		return NULL;
+
+	connection->type = type;
+	connection->msg_id = msg_id;
+
+	return connection;
+}
+
+/**
+ * gh_rm_init_connection_payload() - Fills the first message for a connection.
+ */
+static int gh_rm_init_connection_payload(struct gh_rm_connection *connection, void *msg,
+					size_t hdr_size, size_t payload_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	size_t max_buf_size;
+
+	connection->num_fragments = hdr->fragments;
+	connection->fragments_received = 0;
+	connection->type = hdr->type;
+
+	/* There's not going to be any payload, no need to allocate buffer. */
+	if (!payload_size && !connection->num_fragments)
+		return 0;
+
+	/*
+	 * maximum payload size is GH_MSGQ_MAX_MSG_SIZE - hdr_size
+	 * and can received (hdr->fragments + 1) of those
+	 */
+	max_buf_size = (GH_MSGQ_MAX_MSG_SIZE - hdr_size) * (hdr->fragments + 1);
+
+	connection->payload = kzalloc(max_buf_size, GFP_KERNEL);
+	if (!connection->payload)
+		return -ENOMEM;
+
+	memcpy(connection->payload, msg + hdr_size, payload_size);
+	connection->size = payload_size;
+	return 0;
+}
+
+static void gh_rm_notif_work(struct work_struct *work)
+{
+	struct gh_rm_notif_complete *notif = container_of(work, struct gh_rm_notif_complete, work);
+	struct gh_rm_connection *connection = notif->conn;
+	u32 notif_id = connection->msg_id;
+	struct gh_rm_notification notification = {
+		.buff = connection->payload,
+		.size = connection->size,
+	};
+
+	srcu_notifier_call_chain(&gh_rm_notifier, notif_id, &notification);
+
+	kfree(connection->payload);
+	kfree(connection);
+	kfree(notif);
+}
+
+static struct gh_rm_connection *gh_rm_process_notif(struct gh_rsc_mgr *rsc_mgr,
+						    void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	struct gh_rm_connection *connection;
+
+	connection = gh_rm_alloc_connection(hdr->msg_id, hdr->type);
+	if (!connection) {
+		pr_err("Failed to alloc connection for notification, dropping.\n");
+		return NULL;
+	}
+
+	if (gh_rm_init_connection_payload(connection, msg, sizeof(*hdr), msg_size - sizeof(*hdr))) {
+		pr_err("Failed to alloc connection buffer for notification, dropping.\n");
+		kfree(connection);
+		return NULL;
+	}
+
+	return connection;
+}
+
+static struct gh_rm_connection *gh_rm_process_rply(struct gh_rsc_mgr *rsc_mgr,
+						   void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
+	struct gh_rm_rpc_hdr *hdr = msg;
+	struct gh_rm_connection *connection;
+
+	if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock))
+		return ERR_PTR(-ERESTARTSYS);
+
+	connection = idr_find(&rsc_mgr->call_idr, hdr->seq);
+	mutex_unlock(&rsc_mgr->call_idr_lock);
+
+	if (!connection) {
+		pr_err("Failed to find connection for sequence %u\n", hdr->seq);
+		return NULL;
+	}
+	if (connection->msg_id != hdr->msg_id) {
+		pr_err("Reply for sequence %u expected msg_id: %x but got %x\n", hdr->seq,
+			connection->msg_id, hdr->msg_id);
+		/*
+		 * Don't complete connection and error the client, maybe resource manager will
+		 * send us the expected reply sequence soon.
+		 */
+		return NULL;
+	}
+
+	if (gh_rm_init_connection_payload(connection, msg, sizeof(*reply_hdr),
+					msg_size - sizeof(*reply_hdr))) {
+		pr_err("Failed to alloc connection buffer for sequence %d\n", hdr->seq);
+		/* Send connection complete and error the client. */
+		connection->ret = -ENOMEM;
+		complete(&connection->seq_done);
+		return NULL;
+	}
+
+	connection->rm_error = reply_hdr->err_code;
+	return connection;
+}
+
+static void gh_rm_process_cont(struct gh_rm_connection *connection, void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	size_t payload_size = msg_size - sizeof(*hdr);
+
+	/*
+	 * hdr->fragments and hdr->msg_id preserves the value from first reply or notif message.
+	 * For sake of sanity, check if it's still intact.
+	 */
+	if (connection->msg_id != hdr->msg_id)
+		pr_warn("Appending mismatched continuation with id %d to connection with id %d\n",
+			hdr->msg_id, connection->msg_id);
+	if (connection->num_fragments != hdr->fragments)
+		pr_warn("Number of fragments mismatch for seq: %d\n", hdr->seq);
+
+	memcpy(connection->payload + connection->size, msg + sizeof(*hdr), payload_size);
+	connection->size += payload_size;
+	connection->fragments_received++;
+}
+
+static bool gh_rm_complete_connection(struct gh_rm_connection *connection)
+{
+	struct gh_rm_notif_complete *notif_work;
+
+	if (!connection)
+		return false;
+
+	if (connection->fragments_received != connection->num_fragments)
+		return false;
+
+	switch (connection->type) {
+	case GH_RM_RPC_TYPE_RPLY:
+		complete(&connection->seq_done);
+		break;
+	case GH_RM_RPC_TYPE_NOTIF:
+		notif_work = kzalloc(sizeof(*notif_work), GFP_KERNEL);
+		if (notif_work == NULL)
+			break;
+
+		notif_work->conn = connection;
+		INIT_WORK(&notif_work->work, gh_rm_notif_work);
+
+		schedule_work(&notif_work->work);
+		break;
+	default:
+		pr_err("Invalid message type (%d) received\n", connection->type);
+		break;
+	}
+
+	return true;
+}
+
+static void gh_rm_abort_connection(struct gh_rm_connection *connection)
+{
+	switch (connection->type) {
+	case GH_RM_RPC_TYPE_RPLY:
+		connection->ret = -EIO;
+		complete(&connection->seq_done);
+		break;
+	case GH_RM_RPC_TYPE_NOTIF:
+		fallthrough;
+	default:
+		kfree(connection->payload);
+		kfree(connection);
+	}
+}
+
+static int gh_rm_recv_task_fn(void *data)
+{
+	struct gh_rsc_mgr *rsc_mgr = data;
+	struct gh_rm_connection *connection = NULL;
+	struct gh_rm_rpc_hdr *hdr = NULL;
+	ssize_t msg_size;
+	void *msg;
+
+	msg = kzalloc(GH_MSGQ_MAX_MSG_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	while (!kthread_should_stop()) {
+		/* Block until a new message is received */
+		msg_size = gh_msgq_recv(rsc_mgr->msgq_rx, msg, GH_MSGQ_MAX_MSG_SIZE, 0);
+		if (msg_size < 0) {
+			pr_err("Failed to receive the message: %ld\n", msg_size);
+			continue;
+		} else if (msg_size <= sizeof(struct gh_rm_rpc_hdr)) {
+			pr_err("Invalid message size received: %ld is too small\n", msg_size);
+			continue;
+		}
+
+		hdr = msg;
+		switch (hdr->type) {
+		case GH_RM_RPC_TYPE_NOTIF:
+			if (connection) {
+				/* Not possible per protocol. Do something better than BUG_ON */
+				pr_warn("Received start of new notification without finishing existing message series.\n");
+				gh_rm_abort_connection(connection);
+			}
+			connection = gh_rm_process_notif(rsc_mgr, msg, msg_size);
+			break;
+		case GH_RM_RPC_TYPE_RPLY:
+			if (connection) {
+				/* Not possible per protocol. Do something better than BUG_ON */
+				pr_warn("Received start of new reply without finishing existing message series.\n");
+				gh_rm_abort_connection(connection);
+			}
+			connection = gh_rm_process_rply(rsc_mgr, msg, msg_size);
+			break;
+		case GH_RM_RPC_TYPE_CONT:
+			if (!connection) {
+				pr_warn("Received a continuation message without receiving initial message\n");
+				break;
+			}
+			gh_rm_process_cont(connection, msg, msg_size);
+			break;
+		default:
+			pr_err("Invalid message type (%d) received\n", hdr->type);
+			continue;
+		}
+
+		if (gh_rm_complete_connection(connection))
+			connection = NULL;
+	}
+
+	return 0;
+}
+
+static int gh_rm_send_request(struct gh_rsc_mgr *rsc_mgr, u32 message_id,
+				const void *req_buff, size_t req_buff_size,
+				struct gh_rm_connection *connection)
+{
+	size_t buff_size_remaining = req_buff_size;
+	const void *req_buff_curr = req_buff;
+	struct gh_rm_rpc_hdr *hdr;
+	unsigned long tx_flags;
+	u32 num_fragments = 0;
+	size_t payload_size;
+	void *msg;
+	int i, ret = 0;
+
+	if (req_buff_size > GH_RM_MAX_MSG_SIZE)
+		num_fragments = req_buff_size / GH_RM_MAX_MSG_SIZE;
+
+	if (WARN(num_fragments > GH_RM_MAX_NUM_FRAGMENTS,
+		 "Limit exceeded for the number of fragments: %u\n", num_fragments))
+		return -E2BIG;
+
+	/*
+	 * The above calculation also includes the count for the 'request' packet.
+	 * Exclude it as the header needs to fill the num. of fragments to follow.
+	 */
+	if (num_fragments)
+		num_fragments--;
+
+	if (mutex_lock_interruptible(&rsc_mgr->send_lock))
+		return -ERESTARTSYS;
+
+	msg = kzalloc(GH_MSGQ_MAX_MSG_SIZE, GFP_KERNEL);
+	if (!msg) {
+		mutex_unlock(&rsc_mgr->send_lock);
+		return -ENOMEM;
+	}
+
+	/* Consider also the 'request' packet for the loop count */
+	for (i = 0; i <= num_fragments; i++) {
+		if (buff_size_remaining > GH_RM_MAX_MSG_SIZE) {
+			payload_size = GH_RM_MAX_MSG_SIZE;
+			buff_size_remaining -= payload_size;
+		} else {
+			payload_size = buff_size_remaining;
+		}
+
+		memset(msg, 0, GH_MSGQ_MAX_MSG_SIZE);
+
+		/* Fill header */
+		hdr = msg;
+		hdr->version = GH_RM_RPC_HDR_VERSION_ONE;
+		hdr->hdr_words = GH_RM_RPC_HDR_WORDS;
+		hdr->type = i == 0 ? GH_RM_RPC_TYPE_REQ : GH_RM_RPC_TYPE_CONT;
+		hdr->fragments = num_fragments;
+		hdr->seq = connection->seq;
+		hdr->msg_id = message_id;
+
+		/* Copy payload */
+		memcpy(msg + sizeof(*hdr), req_buff_curr, payload_size);
+		req_buff_curr += payload_size;
+
+		/* Force the last fragment to be sent immediately to the receiver */
+		tx_flags = (i == num_fragments) ? GH_MSGQ_TX_PUSH : 0;
+
+		ret = gh_msgq_send(rsc_mgr->msgq_tx, msg, sizeof(*hdr) + payload_size, tx_flags);
+
+		if (ret < 0)
+			break;
+	}
+
+	mutex_unlock(&rsc_mgr->send_lock);
+	return ret < 0 ? ret : 0;
+}
+
+/**
+ * gh_rm_call: Achieve request-response type communication with RPC
+ * @message_id: The RM RPC message-id
+ * @req_buff: Request buffer that contains the payload
+ * @req_buff_size: Total size of the payload
+ * @resp_buf: Pointer to a response buffer
+ * @resp_buff_size: Size of the response buffer
+ * @reply_err_code: Returns Gunyah standard error code for the response
+ *
+ * Make a request to the RM-VM and wait for reply back. For a successful
+ * response, the function returns the payload. The size of the payload is set in resp_buff_size.
+ * The resp_buf should be freed by the caller.
+ *
+ * Context: Process context. Will sleep waiting for reply.
+ * Return: >0 is standard reply error from RM. <0 on internal error.
+ */
+int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
+		void **resp_buf, size_t *resp_buff_size)
+{
+	struct gh_rm_connection *connection;
+	int ret;
+	struct gh_rsc_mgr *rsc_mgr = __rsc_mgr;
+
+	/* messaged_id 0 is reserved */
+	if (!message_id)
+		return -EINVAL;
+
+	if (!rsc_mgr)
+		return -EPROBE_DEFER;
+
+	connection = gh_rm_alloc_connection(message_id, GH_RM_RPC_TYPE_RPLY);
+	if (!connection)
+		return -ENOMEM;
+
+	init_completion(&connection->seq_done);
+
+	/* Allocate a new seq number for this connection */
+	if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock)) {
+		kfree(connection);
+		return -ERESTARTSYS;
+	}
+	connection->seq = idr_alloc_cyclic(&rsc_mgr->call_idr, connection, 0, U16_MAX, GFP_KERNEL);
+	mutex_unlock(&rsc_mgr->call_idr_lock);
+
+	/* Send the request to the Resource Manager */
+	ret = gh_rm_send_request(rsc_mgr, message_id, req_buff, req_buff_size, connection);
+	if (ret < 0)
+		goto out;
+
+	/* Wait for response */
+	wait_for_completion(&connection->seq_done);
+
+	if (connection->ret) {
+		ret = connection->ret;
+		kfree(connection->payload);
+		goto out;
+	}
+
+	if (connection->rm_error) {
+		ret = connection->rm_error;
+		kfree(connection->payload);
+		goto out;
+	}
+
+	*resp_buf = connection->payload;
+	*resp_buff_size = connection->size;
+
+out:
+	mutex_lock(&rsc_mgr->call_idr_lock);
+	idr_remove(&rsc_mgr->call_idr, connection->seq);
+	mutex_unlock(&rsc_mgr->call_idr_lock);
+
+	kfree(connection);
+	return ret;
+}
+
+int gh_rm_register_notifier(struct notifier_block *nb)
+{
+	return srcu_notifier_chain_register(&gh_rm_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(gh_rm_register_notifier);
+
+int gh_rm_unregister_notifier(struct notifier_block *nb)
+{
+	return srcu_notifier_chain_unregister(&gh_rm_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(gh_rm_unregister_notifier);
+
+static struct gunyah_device *gh_msgq_platform_probe_direction(struct platform_device *pdev,
+				u8 gh_type, int idx)
+{
+	int irq, ret;
+	u64 capid;
+	struct device_node *node = pdev->dev.of_node;
+	struct gunyah_device *ghdev;
+
+	irq = platform_get_irq(pdev, idx);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, irq);
+		return ERR_PTR(irq);
+	}
+
+	ret = of_property_read_u64_index(node, "reg", idx, &capid);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get capid%d: %d\n", idx, ret);
+		return ERR_PTR(ret);
+	}
+
+	ghdev = gunyah_device_alloc(&pdev->dev, capid, gh_type);
+	ghdev->irq = irq;
+	ret = gunyah_device_add(ghdev);
+	if (ret) {
+		kfree(ghdev);
+		return ERR_PTR(ret);
+	}
+
+	return ghdev;
+}
+
+static int gh_rm_drv_probe(struct platform_device *pdev)
+{
+	struct gh_rsc_mgr *rsc_mgr;
+	int ret;
+
+	rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
+	if (!rsc_mgr)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, rsc_mgr);
+
+	mutex_init(&rsc_mgr->call_idr_lock);
+	idr_init(&rsc_mgr->call_idr);
+	mutex_init(&rsc_mgr->send_lock);
+
+	rsc_mgr->msgq_tx = gh_msgq_platform_probe_direction(pdev, GUNYAH_DEVICE_TYPE_MSGQ_TX, 0);
+	if (IS_ERR(rsc_mgr->msgq_tx))
+		return PTR_ERR(rsc_mgr->msgq_tx);
+	rsc_mgr->msgq_rx = gh_msgq_platform_probe_direction(pdev, GUNYAH_DEVICE_TYPE_MSGQ_RX, 1);
+	if (IS_ERR(rsc_mgr->msgq_rx)) {
+		ret = PTR_ERR(rsc_mgr->msgq_rx);
+		goto err_msgq_tx;
+	}
+
+	rsc_mgr->recv_task = kthread_run(gh_rm_recv_task_fn, rsc_mgr, "gh_rm_recv_task");
+	if (IS_ERR_OR_NULL(rsc_mgr->recv_task)) {
+		ret = PTR_ERR(rsc_mgr->recv_task);
+		goto err_msgq;
+	}
+
+	__rsc_mgr = rsc_mgr;
+
+	return 0;
+
+err_msgq:
+	gunyah_device_remove(rsc_mgr->msgq_rx);
+err_msgq_tx:
+	gunyah_device_remove(rsc_mgr->msgq_tx);
+	return ret;
+}
+
+static int gh_rm_drv_remove(struct platform_device *pdev)
+{
+	struct gh_rsc_mgr *rsc_mgr = platform_get_drvdata(pdev);
+
+	gunyah_device_remove(rsc_mgr->msgq_tx);
+	gunyah_device_remove(rsc_mgr->msgq_rx);
+
+	return 0;
+}
+
+static const struct of_device_id gh_rm_of_match[] = {
+	{ .compatible = "gunyah-resource-manager" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gh_rm_of_match);
+
+static struct platform_driver gh_rsc_mgr_driver = {
+	.probe = gh_rm_drv_probe,
+	.remove = gh_rm_drv_remove,
+	.driver = {
+		.name = "gh_rsc_mgr",
+		.of_match_table = gh_rm_of_match,
+	},
+};
+
+int __init gh_rsc_mgr_init(void)
+{
+	return platform_driver_register(&gh_rsc_mgr_driver);
+}
+
+void gh_rsc_mgr_exit(void)
+{
+	platform_driver_unregister(&gh_rsc_mgr_driver);
+}
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
new file mode 100644
index 000000000000..e4f2499267bf
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef __GH_RSC_MGR_PRIV_H
+#define __GH_RSC_MGR_PRIV_H
+
+#include <linux/gunyah.h>
+
+/* RM Error codes */
+#define GH_RM_ERROR_OK			0x0
+#define GH_RM_ERROR_UNIMPLEMENTED	0xFFFFFFFF
+#define GH_RM_ERROR_NOMEM		0x1
+#define GH_RM_ERROR_NORESOURCE		0x2
+#define GH_RM_ERROR_DENIED		0x3
+#define GH_RM_ERROR_INVALID		0x4
+#define GH_RM_ERROR_BUSY		0x5
+#define GH_RM_ERROR_ARGUMENT_INVALID	0x6
+#define GH_RM_ERROR_HANDLE_INVALID	0x7
+#define GH_RM_ERROR_VALIDATE_FAILED	0x8
+#define GH_RM_ERROR_MAP_FAILED		0x9
+#define GH_RM_ERROR_MEM_INVALID		0xA
+#define GH_RM_ERROR_MEM_INUSE		0xB
+#define GH_RM_ERROR_MEM_RELEASED	0xC
+#define GH_RM_ERROR_VMID_INVALID	0xD
+#define GH_RM_ERROR_LOOKUP_FAILED	0xE
+#define GH_RM_ERROR_IRQ_INVALID		0xF
+#define GH_RM_ERROR_IRQ_INUSE		0x10
+#define GH_RM_ERROR_IRQ_RELEASED	0x11
+
+int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
+		void **resp_buf, size_t *resp_buff_size);
+
+#endif
diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
index 7589689e5e92..7c0efc80f85e 100644
--- a/drivers/virt/gunyah/sysfs.c
+++ b/drivers/virt/gunyah/sysfs.c
@@ -148,7 +148,13 @@ static int __init gunyah_init(void)
 	if (ret)
 		goto err_bus;
 
+	ret = gh_rsc_mgr_init();
+	if (ret)
+		goto err_msgq;
+
 	return ret;
+err_msgq:
+	gh_msgq_exit();
 err_bus:
 	gunyah_bus_exit();
 err_sysfs:
@@ -159,6 +165,7 @@ module_init(gunyah_init);
 
 static void __exit gunyah_exit(void)
 {
+	gh_rsc_mgr_exit();
 	gh_msgq_exit();
 	gunyah_bus_exit();
 	gh_sysfs_unregister();
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
new file mode 100644
index 000000000000..015bd851e1a3
--- /dev/null
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_RSC_MGR_H
+#define _GUNYAH_RSC_MGR_H
+
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/gunyah.h>
+
+typedef u16 gh_vmid_t;
+typedef u32 gh_virq_handle_t;
+
+#define GH_VMID_INVAL	U16_MAX
+
+/* Gunyah recognizes VMID0 as an alias to the current VM's ID */
+#define GH_VMID_SELF			0
+
+struct gh_rm_notification {
+	const void *buff;
+	const size_t size;
+};
+
+int gh_rm_register_notifier(struct notifier_block *nb);
+int gh_rm_unregister_notifier(struct notifier_block *nb);
+
+#endif
-- 
2.25.1

