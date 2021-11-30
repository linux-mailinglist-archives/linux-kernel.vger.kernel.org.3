Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385654634E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhK3M6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:58:39 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:4779 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbhK3M63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:58:29 -0500
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 04:55:09 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Nov 2021 04:55:08 -0800
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg01-blr.qualcomm.com with ESMTP; 30 Nov 2021 18:25:00 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id 15D2543B0; Tue, 30 Nov 2021 18:24:59 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     ekangupt@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: [PATCH 2/2] misc: fastrpc: Add dma handle implementation
Date:   Tue, 30 Nov 2021 18:24:55 +0530
Message-Id: <1638276897-6146-4-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638276897-6146-1-git-send-email-jeyr@codeaurora.org>
References: <1638276897-6146-1-git-send-email-jeyr@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma handle instructions to remote arguments.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
---
 drivers/misc/fastrpc.c | 75 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3c937ff..77071ee3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -92,9 +92,20 @@ struct fastrpc_invoke_buf {
 	u32 pgidx;		/* index to start of contiguous region */
 };
 
-struct fastrpc_remote_arg {
-	u64 pv;
-	u64 len;
+struct fastrpc_remote_dmahandle {
+	s32 fd;			/* dma handle fd */
+	u32 offset;		/* dma handle offset */
+	u32 len;		/* dma handle length */
+};
+
+struct fastrpc_remote_buf {
+	u64 pv;			/* buffer pointer */
+	u64 len;		/* length of buffer */
+};
+
+union fastrpc_remote_arg {
+	struct fastrpc_remote_buf buf;
+	struct fastrpc_remote_dmahandle dma;
 };
 
 struct fastrpc_mmap_rsp_msg {
@@ -189,7 +200,7 @@ struct fastrpc_invoke_ctx {
 	struct work_struct put_work;
 	struct fastrpc_msg msg;
 	struct fastrpc_user *fl;
-	struct fastrpc_remote_arg *rpra;
+	union fastrpc_remote_arg *rpra;
 	struct fastrpc_map **maps;
 	struct fastrpc_buf *buf;
 	struct fastrpc_invoke_args *args;
@@ -760,12 +771,26 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	return 0;
 }
 
+static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, u32 sc)
+{
+	unsigned int len = REMOTE_SCALARS_LENGTH(sc);
+
+	return (struct fastrpc_invoke_buf *)(&pra[len]);
+}
+
+static struct fastrpc_phy_page *fastrpc_phy_page_start(u32 sc, struct fastrpc_invoke_buf *buf)
+{
+	unsigned int len = REMOTE_SCALARS_LENGTH(sc);
+
+	return (struct fastrpc_phy_page *)(&buf[len]);
+}
+
 static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 {
 	struct device *dev = ctx->fl->sctx->dev;
-	struct fastrpc_remote_arg *rpra;
+	union fastrpc_remote_arg *rpra = NULL;
 	struct fastrpc_invoke_buf *list;
-	struct fastrpc_phy_page *pages;
+	struct fastrpc_phy_page *pages, *ipage;
 	int inbufs, i, oix, err = 0;
 	u64 len, rlen, pkt_size;
 	u64 pg_start, pg_end;
@@ -773,7 +798,13 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	int metalen;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
-	metalen = fastrpc_get_meta_size(ctx);
+	list = fastrpc_invoke_buf_start(rpra, ctx->sc);
+	pages = fastrpc_phy_page_start(ctx->sc, list);
+	ipage = pages;
+	ipage += ctx->nscalars;
+	metalen = (size_t)&ipage[0] +
+		sizeof(u64) * FASTRPC_MAX_FDLIST +
+		sizeof(u32) * FASTRPC_MAX_CRCLIST;
 	pkt_size = fastrpc_get_payload_size(ctx, metalen);
 
 	err = fastrpc_create_maps(ctx);
@@ -788,12 +819,11 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	memset(ctx->buf->virt, 0, pkt_size);
 
 	rpra = ctx->buf->virt;
-	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
-	pages = ctx->buf->virt + ctx->nscalars * (sizeof(*list) +
-		sizeof(*rpra));
+	ctx->rpra = rpra;
+	list = fastrpc_invoke_buf_start(rpra, ctx->sc);
+	pages = fastrpc_phy_page_start(ctx->sc, list);
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
-	ctx->rpra = rpra;
 
 	for (oix = 0; oix < ctx->nbufs; ++oix) {
 		int mlen;
@@ -801,8 +831,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		i = ctx->olaps[oix].raix;
 		len = ctx->args[i].length;
 
-		rpra[i].pv = 0;
-		rpra[i].len = len;
+		rpra[i].buf.pv = 0;
+		rpra[i].buf.len = len;
 		list[i].num = len ? 1 : 0;
 		list[i].pgidx = i;
 
@@ -812,7 +842,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		if (ctx->maps[i]) {
 			struct vm_area_struct *vma = NULL;
 
-			rpra[i].pv = (u64) ctx->args[i].ptr;
+			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
 			pages[i].addr = ctx->maps[i]->phys;
 
 			mmap_read_lock(current->mm);
@@ -839,7 +869,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			if (rlen < mlen)
 				goto bail;
 
-			rpra[i].pv = args - ctx->olaps[oix].offset;
+			rpra[i].buf.pv = args - ctx->olaps[oix].offset;
 			pages[i].addr = ctx->buf->phys -
 					ctx->olaps[oix].offset +
 					(pkt_size - rlen);
@@ -853,7 +883,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		}
 
 		if (i < inbufs && !ctx->maps[i]) {
-			void *dst = (void *)(uintptr_t)rpra[i].pv;
+			void *dst = (void *)(uintptr_t)rpra[i].buf.pv;
 			void *src = (void *)(uintptr_t)ctx->args[i].ptr;
 
 			if (!kernel) {
@@ -869,12 +899,17 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	}
 
 	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
-		rpra[i].pv = (u64) ctx->args[i].ptr;
-		rpra[i].len = ctx->args[i].length;
+		rpra[i].buf.pv = (u64) ctx->args[i].ptr;
+		rpra[i].buf.len = ctx->args[i].length;
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
-		pages[i].addr = ctx->maps[i]->phys;
-		pages[i].size = ctx->maps[i]->size;
+		if (ctx->maps[i]) {
+			pages[i].addr = ctx->maps[i]->phys;
+			pages[i].size = ctx->maps[i]->size;
+		}
+		rpra[i].dma.fd = ctx->args[i].fd;
+		rpra[i].dma.len = ctx->args[i].length;
+		rpra[i].dma.offset = (u64) ctx->args[i].ptr;
 	}
 
 bail:
-- 
2.7.4

