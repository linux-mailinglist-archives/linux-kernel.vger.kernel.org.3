Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2824749CB96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiAZNyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbiAZNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h21so8380693wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJKSsAudCW68wjBcYmZkvSQLNXWe4kcfjmLMXs7MAJs=;
        b=n5LCe9S0O2aMl5iGp+938ABzdGFiNe5O++WgkYnc0QabXJQtECb78QWn+JXKiL69u8
         iG1RvIxZehD4+3EjqZ3Y+3HTXLvxxb6I00AeFmsTq1gU4qO8dbdFkC/CUldRKjeW67Qb
         NMkE+wsLeNwrv4R9clzgwX/LwaPhsOwVQNuTCmYlOBn3dyBn3LRzE2/S/y04oU35PREB
         FqQfqLn/BLeiXOEpQET20mxpYEHZO4NHN1Yh5ZSwl43JiZO2STEeJhj9wMQMc5ap/659
         TzCP3gXkf/heF4LOw3wh0YrXg/li4mfK2svDRHyw50Ur0gwUgMYXlLi4+8Fj21WcDN/l
         lx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJKSsAudCW68wjBcYmZkvSQLNXWe4kcfjmLMXs7MAJs=;
        b=IWMirVp20sjl5FJmNxJwRDXpTlOfUgWVRo7f1Gi0wMbRMwX+HRjGELcgjoPucN97Bl
         Sd1n4+ls/G3nAUN9Ik/NKiPqTyPnphTcnfpkFmQbkchMf9M2Y2EPdLP39+QO5Uqn3aDe
         vkjOP4QlhytF3Fp8EkMSpTc6K1PpZ2VdLDDxOcwo+W/9Wg9aije9miCNOnG0XKsXSzhh
         dFWayo4F8KI68f7vbphzbuw13G6Wh8QyQju05JmXjYVNaqE6j0R3LkDdL/bWSJKlWexq
         n8vHsKfaGMo+40AE1LSUlBxDMAz6KnIQVOjU4oF7d8SGJKCnCnZh7krB+KZgqCfrwZY3
         lHug==
X-Gm-Message-State: AOAM532xUwaPbsuCdj6okTsJmexbNGN+/4FZq8ENaj37PnmS+31yPmHK
        lSPKEa4zxg0gru05ghJ74EDtHHQpQjpqbw==
X-Google-Smtp-Source: ABdhPJy0gbhkanA/nbVs20EytxbtdtXUIJFn7tAbb+200yZNQwNPUlvam3ouo3kk+bqjI5u2zXZ+Lg==
X-Received: by 2002:adf:efcd:: with SMTP id i13mr22951487wrp.343.1643205274661;
        Wed, 26 Jan 2022 05:54:34 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:34 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 08/12] misc: fastrpc: Add support to secure memory map
Date:   Wed, 26 Jan 2022 13:53:00 +0000
Message-Id: <20220126135304.16340-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>

This patch adds support to secure memory allocations for DSP.
It repurposes the reserved field in struct fastrpc_invoke_args
to add attributes to invoke request, for example to setup a secure memory
map for dsp. Secure memory is assigned to DSP Virtual Machine IDs using
Qualcomm SCM calls.

Signed-off-by: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 65 ++++++++++++++++++++++++++++++++-----
 include/uapi/misc/fastrpc.h |  5 ++-
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8e780e2d5d9d..0090085bfbb9 100644
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
@@ -194,6 +196,7 @@ struct fastrpc_map {
 	void *va;
 	u64 len;
 	u64 raddr;
+	u32 attr;
 	struct kref refcount;
 };
 
@@ -231,6 +234,9 @@ struct fastrpc_session_ctx {
 struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
+	int vmcount;
+	u32 perms;
+	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
 	spinlock_t lock;
@@ -278,6 +284,20 @@ static void fastrpc_free_map(struct kref *ref)
 	map = container_of(ref, struct fastrpc_map, refcount);
 
 	if (map->table) {
+		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
+			struct qcom_scm_vmperm perm;
+			int err = 0;
+
+			perm.vmid = QCOM_SCM_VMID_HLOS;
+			perm.perm = QCOM_SCM_PERM_RWX;
+			err = qcom_scm_assign_mem(map->phys, map->size,
+				&(map->fl->cctx->vmperms[0].vmid), &perm, 1);
+			if (err) {
+				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+						map->phys, map->size, err);
+				return;
+			}
+		}
 		dma_buf_unmap_attachment(map->attach, map->table,
 					 DMA_BIDIRECTIONAL);
 		dma_buf_detach(map->buf, map->attach);
@@ -654,7 +674,7 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 };
 
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
-			      u64 len, struct fastrpc_map **ppmap)
+			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
@@ -696,6 +716,22 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	map->len = len;
 	kref_init(&map->refcount);
 
+	if (attr & FASTRPC_ATTR_SECUREMAP) {
+		/*
+		 * If subsystem VMIDs are defined in DTSI, then do
+		 * hyp_assign from HLOS to those VM(s)
+		 */
+		unsigned int perms = BIT(QCOM_SCM_VMID_HLOS);
+
+		map->attr = attr;
+		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &perms,
+				fl->cctx->vmperms, fl->cctx->vmcount);
+		if (err) {
+			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
+					map->phys, map->size, err);
+			goto map_err;
+		}
+	}
 	spin_lock(&fl->lock);
 	list_add_tail(&map->node, &fl->maps);
 	spin_unlock(&fl->lock);
@@ -780,16 +816,13 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	int i, err;
 
 	for (i = 0; i < ctx->nscalars; ++i) {
-		/* Make sure reserved field is set to 0 */
-		if (ctx->args[i].reserved)
-			return -EINVAL;
 
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
 		    ctx->args[i].length == 0)
 			continue;
 
 		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-					 ctx->args[i].length, &ctx->maps[i]);
+			 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
@@ -1123,7 +1156,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
 		if (err)
 			goto err;
 	}
@@ -1232,7 +1265,6 @@ static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
@@ -1373,7 +1405,6 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
 	fl->pd = pd;
 
@@ -1943,9 +1974,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
 	struct fastrpc_channel_ctx *data;
-	int i, err, domain_id = -1;
+	int i, err, domain_id = -1, vmcount;
 	const char *domain;
 	bool secure_dsp;
+	unsigned int vmids[FASTRPC_MAX_VMIDS];
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
 	if (err) {
@@ -1965,10 +1997,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f39edac20305..5e29f2cfa42d 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -63,11 +63,14 @@ enum fastrpc_proc_attr {
 	FASTRPC_MODE_PRIVILEGED		= (1 << 6),
 };
 
+/* Fastrpc attribute for memory protection of buffers */
+#define FASTRPC_ATTR_SECUREMAP	(1)
+
 struct fastrpc_invoke_args {
 	__u64 ptr;
 	__u64 length;
 	__s32 fd;
-	__u32 reserved;
+	__u32 attr;
 };
 
 struct fastrpc_invoke {
-- 
2.21.0

