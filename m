Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818B24634FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhK3NBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:01:40 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:37429 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhK3NB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:01:28 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 04:58:05 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Nov 2021 04:58:04 -0800
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg01-blr.qualcomm.com with ESMTP; 30 Nov 2021 18:27:56 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id B11C943DE; Tue, 30 Nov 2021 18:27:54 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, ekangupt@qti.qualcomm.com,
        jeyr@qti.qualcomm.com
Subject: [PATCH 3/3] misc: fastrpc: Handle mapping of invoke argument with attribute
Date:   Tue, 30 Nov 2021 18:27:52 +0530
Message-Id: <1638277072-6459-6-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
References: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow mapping of arguments for remote invocations with attribute.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
---
 drivers/misc/fastrpc.c      | 25 ++++++++++++++++---------
 include/uapi/misc/fastrpc.h |  5 ++++-
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9adfa4d..f6a6e4d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -172,6 +172,7 @@ struct fastrpc_map {
 	u64 size;
 	void *va;
 	u64 len;
+	u32 attr;
 	struct kref refcount;
 };
 
@@ -246,6 +247,10 @@ static void fastrpc_free_map(struct kref *ref)
 	map = container_of(ref, struct fastrpc_map, refcount);
 
 	if (map->table) {
+		if (map->attr & FASTRPC_SECUREMAP) {
+			/* Invoke qcom_scm API to assign memory access
+			 * back to HLOS
+			 */
 		dma_buf_unmap_attachment(map->attach, map->table,
 					 DMA_BIDIRECTIONAL);
 		dma_buf_detach(map->buf, map->attach);
@@ -622,7 +627,7 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 };
 
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
-			      u64 len, struct fastrpc_map **ppmap)
+			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
@@ -664,6 +669,14 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	map->len = len;
 	kref_init(&map->refcount);
 
+	if (attr & FASTRPC_SECUREMAP) {
+		map->attr = attr;
+		/*
+		 * If subsystem VMIDs are defined in DTSI, then do
+		 * hyp_assign from HLOS to those VM(s).
+		*/
+	}
+
 	spin_lock(&fl->lock);
 	list_add_tail(&map->node, &fl->maps);
 	spin_unlock(&fl->lock);
@@ -746,16 +759,12 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	int i, err;
 
 	for (i = 0; i < ctx->nscalars; ++i) {
-		/* Make sure reserved field is set to 0 */
-		if (ctx->args[i].reserved)
-			return -EINVAL;
-
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
 		    ctx->args[i].length == 0)
 			continue;
 
 		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-					 ctx->args[i].length, &ctx->maps[i]);
+					 ctx->args[i].length, ctx->args[i].attr, x->maps[i]);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
@@ -1062,7 +1071,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
 		if (err)
 			goto err;
 	}
@@ -1171,7 +1180,6 @@ static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
@@ -1307,7 +1315,6 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
 	fl->pd = pd;
 
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 0a89f95..4dd4a9e 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -14,11 +14,14 @@
 #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
 
+/* Fastrpc attribute for memory protection of buffers */
+#define FASTRPC_SECUREMAP (1)
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
2.7.4

