Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF574634FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhK3NBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:01:31 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:37429 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhK3NB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:01:26 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 04:58:03 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Nov 2021 04:58:02 -0800
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg01-blr.qualcomm.com with ESMTP; 30 Nov 2021 18:27:55 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id 90E6943B0; Tue, 30 Nov 2021 18:27:54 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, ekangupt@qti.qualcomm.com,
        jeyr@qti.qualcomm.com
Subject: [PATCH 2/3] misc: fastrpc: Read virtual machine IDs during probe
Date:   Tue, 30 Nov 2021 18:27:51 +0530
Message-Id: <1638277072-6459-5-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
References: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read virtual machine IDs DT property during rpmsg probe. This property is used
to set up memory protection for remote processor.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
---
 drivers/misc/fastrpc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 39aca77..a9adfa4d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -17,6 +17,7 @@
 #include <linux/rpmsg.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
 
 #define ADSP_DOMAIN_ID (0)
@@ -25,6 +26,7 @@
 #define CDSP_DOMAIN_ID (3)
 #define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
 #define FASTRPC_MAX_SESSIONS	13 /*12 compute, 1 cpz*/
+#define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
 #define FASTRPC_MAX_CRCLIST	64
@@ -207,6 +209,9 @@ struct fastrpc_session_ctx {
 struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
+	int vmcount;
+	u32 perms;
+	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
 	spinlock_t lock;
@@ -1610,8 +1615,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
 	struct fastrpc_channel_ctx *data;
-	int i, err, domain_id = -1;
+	int i, err, domain_id = -1, vmcount;
 	const char *domain;
+	unsigned int vmids[FASTRPC_MAX_VMIDS];
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
 	if (err) {
@@ -1631,9 +1637,24 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -EINVAL;
 	}
 
+	vmcount = of_property_read_variable_u32_array(rdev->of_node,
+				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
+	if (vmcount < 0)
+		vmcount = 0;
+	else if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	if (vmcount) {
+		data->vmcount = vmcount;
+		data->perms = BIT(QCOM_SCM_VMID_HLOS);
+		for (i = 0; i < data->vmcount; i++) {
+			data->vmperms[i].vmid = vmids[i];
+			data->vmperms[i].perm = QCOM_SCM_PERM_RWX;
+		}
+	}
 
 	data->miscdev.minor = MISC_DYNAMIC_MINOR;
 	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
-- 
2.7.4

