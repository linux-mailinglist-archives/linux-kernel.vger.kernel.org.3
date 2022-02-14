Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E254B55BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356255AbiBNQLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:11:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356161AbiBNQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C4360AA7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so27770740wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9s/z+n4KaWgaeVcMwcxi+7rViKwYhtyikW3FoYPGfSA=;
        b=uUOmDYB6td1KbzRksk9ZevF3lw4x0Tss16WQRRN4ySyXeNkN3ePvfUXCbPgwMgAtSX
         DZQUHEfAenAjpRRTldgEnyAAfllPcn01ebJoQoJeJwHQQVtC2vfjzM4zu/viPjPt55hk
         p8NUvhQAerwFYlM0tDQRal3OH/wGxvuELHY6wstPhz3nvZ6Ag8EYOnkMujTrhtVQIkrY
         HGRIlpnxUHDlcaK4/wPZp02aMVZWegl9nKXAkBkGniQZdSVAnzFaqT1rBExhBG6NXx6i
         9nssIrSgg0O7hlvChfMRCnF6VI+IIGK3mqBMs8CapkEs4xb3MIjnCRaD4IWdghuugD3L
         otcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9s/z+n4KaWgaeVcMwcxi+7rViKwYhtyikW3FoYPGfSA=;
        b=Q/A0J0HOTzz428GWbOkNRE5CcbvrBF3EU5r30BcyAVJZsKP7aU2qUvmuEmvwTl8DVu
         uPEjD7j3onBPLF9Cl3CbCnum+XOnY6Zd9TUxfW/tQLSrLxRiiJkLR24jy7+Jo1hrng/4
         LrCktyIQZTcTaM7ZvsU2E9nEY0o9fyx1IRms0ii4uIJ7+kwA86kX+cAacsGOdQ/HRMzG
         uh6BoQmVvt/i4dcBEz6YWiWf2rF8hg6D/duNaa7aK+YR/qUqXaDZsH2DAgItNKtejloN
         hTyDAIwHMIRjnBFcYQZNsGvZ7O3+uWswH+mn+O9uIEQ8DPLbQu7TSJMjAWhQhjqYTfgt
         sqDQ==
X-Gm-Message-State: AOAM5317U/UNtOdyCM4VSDtk/4OFeXP5in3sLFTxjXAcUgJ+2f+BbVwS
        mtJbVWGkYIqEwBVn83otV02L4w==
X-Google-Smtp-Source: ABdhPJwGLpofrDLBscQigRPET/R+Ijt+AIrNzYJp/vUQEWhSY29nKc4lMGJH04Bv9emQomZVTL1CZQ==
X-Received: by 2002:a05:6000:1c16:: with SMTP id ba22mr289607wrb.470.1644855017798;
        Mon, 14 Feb 2022 08:10:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id k28sm13677022wms.23.2022.02.14.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:10:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 08/12] misc: fastrpc: Add support to secure memory map
Date:   Mon, 14 Feb 2022 16:09:58 +0000
Message-Id: <20220214161002.6831-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
References: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/misc/Kconfig        |  1 +
 drivers/misc/fastrpc.c      | 65 ++++++++++++++++++++++++++++++++-----
 include/uapi/misc/fastrpc.h |  5 ++-
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..974edd7ce40f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -259,6 +259,7 @@ config QCOM_FASTRPC
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
 	select DMA_SHARED_BUFFER
+	select QCOM_SCM
 	help
 	  Provides a communication mechanism that allows for clients to
 	  make remote method invocations across processor boundary to
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5329d69ecd38..eb1e6d111c77 100644
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
@@ -195,6 +197,7 @@ struct fastrpc_map {
 	void *va;
 	u64 len;
 	u64 raddr;
+	u32 attr;
 	struct kref refcount;
 };
 
@@ -232,6 +235,9 @@ struct fastrpc_session_ctx {
 struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
+	int vmcount;
+	u32 perms;
+	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
 	spinlock_t lock;
@@ -279,6 +285,20 @@ static void fastrpc_free_map(struct kref *ref)
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
@@ -655,7 +675,7 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 };
 
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
-			      u64 len, struct fastrpc_map **ppmap)
+			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
@@ -697,6 +717,22 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
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
@@ -781,16 +817,13 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
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
@@ -1124,7 +1157,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
 		if (err)
 			goto err;
 	}
@@ -1233,7 +1266,6 @@ static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
@@ -1374,7 +1406,6 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
 	fl->pd = pd;
 
@@ -1947,9 +1978,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
@@ -1969,10 +2001,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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

