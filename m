Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A712575707
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbiGNVas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiGNVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:12 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6B6EEA0;
        Thu, 14 Jul 2022 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834211; x=1689370211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7EpwCPH7kpklNw4k3PRnXjN7KwyE+imFag8eqKdl+0=;
  b=K13w45LhXqTQ/5Ua6MnWT7kEYgYwsOkqrijj5yKq0y7eWVdCTmbzFUra
   U80xHLkbth8qP1P3hL1K0DnQyBgZl7kmX+1KWVxog5nEO5S6zdNOK7EAl
   5DilUZq9HwOI40m1uAIJp8IFspVED0tTnJaD4yAqOT5H7l59EL1bWyzol
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:10 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:10 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:09 -0700
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
Subject: [PATCH v2 10/11] gunyah: rsc_mgr: Add RPC for console services
Date:   Thu, 14 Jul 2022 14:29:39 -0700
Message-ID: <20220714212940.2988436-11-quic_eberman@quicinc.com>
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

Gunyah resource manager defines a simple API for virtual machine log
sharing with the console service. A VM's own log can be opened by using
GH_VMID_SELF. Another VM's log can be accessed via its VMID. Once
opened, characters can be written to the log with a write command.
Characters are received with resource manager notifications (using ID
GH_RM_NOTIF_VM_CONSOLE_CHARS).

These high level rpc calls are kept in
drivers/virt/gunyah/rsc_mgr_rpc.c. Future RPC calls, e.g. to launch a VM
will also be maintained in this file.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   4 +-
 drivers/virt/gunyah/rsc_mgr.h     |  22 +++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 151 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  16 ++++
 4 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 86655bca8944..b3f15c052297 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 gunyah-y += sysfs.o device.o msgq.o
-gunyah-y += rsc_mgr.o
-obj-$(CONFIG_GUNYAH) += gunyah.o
\ No newline at end of file
+gunyah-y += rsc_mgr.o rsc_mgr_rpc.o
+obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index e4f2499267bf..c82a2e97ad49 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -28,6 +28,28 @@
 #define GH_RM_ERROR_IRQ_INUSE		0x10
 #define GH_RM_ERROR_IRQ_RELEASED	0x11
 
+/* Message IDs: VM Management */
+#define GH_RM_RPC_VM_GET_VMID			0x56000024
+
+/* Message IDs: VM Services */
+#define GH_RM_RPC_VM_CONSOLE_OPEN_ID		0x56000081
+#define GH_RM_RPC_VM_CONSOLE_CLOSE_ID		0x56000082
+#define GH_RM_RPC_VM_CONSOLE_WRITE_ID		0x56000083
+#define GH_RM_RPC_VM_CONSOLE_FLUSH_ID		0x56000084
+
+/* Call: CONSOLE_OPEN, CONSOLE_CLOSE, CONSOLE_FLUSH */
+struct gh_vm_console_common_req {
+	gh_vmid_t vmid;
+	u16 reserved0;
+} __packed;
+
+/* Call: CONSOLE_WRITE */
+struct gh_vm_console_write_req {
+	gh_vmid_t vmid;
+	u16 num_bytes;
+	u8 data[0];
+} __packed;
+
 int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
 		void **resp_buf, size_t *resp_buff_size);
 
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..be9317968537
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_rsc_mgr: " fmt
+
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/printk.h>
+#include <linux/gunyah_rsc_mgr.h>
+
+#include "rsc_mgr.h"
+
+/**
+ * gh_rm_get_vmid: Retrieve VMID of this virtual machine
+ * @vmid: Filled with the VMID of this VM
+ */
+int gh_rm_get_vmid(gh_vmid_t *vmid)
+{
+	void *resp;
+	size_t resp_size;
+	int ret;
+	int payload = 0;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_GET_VMID, &payload, sizeof(payload), &resp, &resp_size);
+	if (ret)
+		return ret;
+
+	if (resp_size != sizeof(*vmid))
+		return -EIO;
+	*vmid = *(gh_vmid_t *)resp;
+	kfree(resp);
+
+	return ret;
+}
+
+/**
+ * gh_rm_console_open: Open a console with a VM
+ * @vmid: VMID of the other vmid whose console to open. If VMID is GH_VMID_SELF, the
+ *        console associated with this VM is opened.
+ */
+int gh_rm_console_open(gh_vmid_t vmid)
+{
+	void *resp;
+	struct gh_vm_console_common_req req_payload = {0};
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = vmid;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_CONSOLE_OPEN_ID,
+			  &req_payload, sizeof(req_payload),
+			  &resp, &resp_size);
+	kfree(resp);
+
+	if (!ret && resp_size)
+		pr_warn("Received unexpected payload for CONSOLE_OPEN: %lu\n", resp_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_open);
+
+/**
+ * gh_rm_console_close: Close a console with a VM
+ * @vmid: The vmid of the vm whose console to close.
+ */
+int gh_rm_console_close(gh_vmid_t vmid)
+{
+	void *resp;
+	struct gh_vm_console_common_req req_payload = {0};
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = vmid;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_CONSOLE_CLOSE_ID,
+			  &req_payload, sizeof(req_payload),
+			  &resp, &resp_size);
+	kfree(resp);
+
+	if (!ret && resp_size)
+		pr_warn("Received unexpected payload for CONSOLE_CLOSE: %lu\n", resp_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_close);
+
+/**
+ * gh_rm_console_write: Write to a VM's console
+ * @vmid: The vmid of the vm whose console to write to.
+ * @buf: Buffer to write to the VM's console
+ * @size: Size of the buffer
+ */
+int gh_rm_console_write(gh_vmid_t vmid, const char *buf, size_t size)
+{
+	void *resp;
+	struct gh_vm_console_write_req *req_payload;
+	size_t resp_size;
+	int ret = 0;
+	size_t req_payload_size = sizeof(*req_payload) + size;
+
+	if (size < 1 || size > (U32_MAX - sizeof(*req_payload)))
+		return -EINVAL;
+
+	req_payload = kzalloc(req_payload_size, GFP_KERNEL);
+
+	if (!req_payload)
+		return -ENOMEM;
+
+	req_payload->vmid = vmid;
+	req_payload->num_bytes = size;
+	memcpy(req_payload->data, buf, size);
+
+	ret = gh_rm_call(GH_RM_RPC_VM_CONSOLE_WRITE_ID,
+		   req_payload, req_payload_size,
+		   &resp, &resp_size);
+	kfree(req_payload);
+	kfree(resp);
+
+	if (!ret && resp_size)
+		pr_warn("Received unexpected payload for CONSOLE_WRITE: %lu\n", resp_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_write);
+
+/**
+ * gh_rm_console_flush: Flush a console with a VM
+ * @vmid: The vmid of the vm whose console to flush
+ */
+int gh_rm_console_flush(gh_vmid_t vmid)
+{
+	void *resp;
+	struct gh_vm_console_common_req req_payload = {0};
+	size_t resp_size;
+	int ret;
+
+	req_payload.vmid = vmid;
+
+	ret = gh_rm_call(GH_RM_RPC_VM_CONSOLE_FLUSH_ID,
+			  &req_payload, sizeof(req_payload),
+			  &resp, &resp_size);
+	kfree(resp);
+
+	if (!ret && resp_size)
+		pr_warn("Received unexpected payload for CONSOLE_FLUSH: %lu\n", resp_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_rm_console_flush);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 015bd851e1a3..4211ac9a219c 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -26,4 +26,20 @@ struct gh_rm_notification {
 int gh_rm_register_notifier(struct notifier_block *nb);
 int gh_rm_unregister_notifier(struct notifier_block *nb);
 
+/* Notification type Message IDs */
+#define GH_RM_NOTIF_VM_CONSOLE_CHARS	0x56100080
+
+struct gh_rm_notif_vm_console_chars {
+	gh_vmid_t vmid;
+	u16 num_bytes;
+	u8 bytes[0];
+} __packed;
+
+/* RPC Calls */
+int gh_rm_get_vmid(gh_vmid_t *vmid);
+int gh_rm_console_open(gh_vmid_t vmid);
+int gh_rm_console_close(gh_vmid_t vmid);
+int gh_rm_console_write(gh_vmid_t vmid, const char *buf, size_t size);
+int gh_rm_console_flush(gh_vmid_t vmid);
+
 #endif
-- 
2.25.1

