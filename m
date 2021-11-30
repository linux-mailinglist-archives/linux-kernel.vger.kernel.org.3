Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFB463500
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhK3NBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:01:42 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:30487 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhK3NB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:01:28 -0500
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 04:58:05 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Nov 2021 04:58:03 -0800
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg01-blr.qualcomm.com with ESMTP; 30 Nov 2021 18:27:55 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id 6150743AC; Tue, 30 Nov 2021 18:27:54 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, ekangupt@qti.qualcomm.com,
        jeyr@qti.qualcomm.com
Subject: [PATCH 1/2] misc: fastrpc: Add fdlist implementation
Date:   Tue, 30 Nov 2021 18:27:49 +0530
Message-Id: <1638277072-6459-3-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
References: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fdlist implementation to support dma handles. fdlist is populated
by DSP if any map is no longer used and it is freed during put_args.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
---
 drivers/misc/fastrpc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 39aca77..3c937ff 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -353,7 +353,7 @@ static void fastrpc_context_free(struct kref *ref)
 	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
 	cctx = ctx->cctx;
 
-	for (i = 0; i < ctx->nscalars; i++)
+	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
 	if (ctx->buf)
@@ -785,6 +785,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
 	if (err)
 		return err;
+	memset(ctx->buf->virt, 0, pkt_size);
 
 	rpra = ctx->buf->virt;
 	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
@@ -887,9 +888,19 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			    u32 kernel)
 {
 	struct fastrpc_remote_arg *rpra = ctx->rpra;
-	int i, inbufs;
+	struct fastrpc_map *mmap = NULL;
+	struct fastrpc_invoke_buf *list;
+	struct fastrpc_phy_page *pages;
+	u64 *fdlist;
+	int i, inbufs, outbufs, handles;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
+	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
+	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
+	pages = ctx->buf->virt + ctx->nscalars * (sizeof(*list) +
+		sizeof(*rpra));
+	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
@@ -906,6 +917,13 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 		}
 	}
 
+	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
+		if (!fdlist[i])
+			break;
+		if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
+			fastrpc_map_put(mmap);
+	}
+
 	return 0;
 }
 
-- 
2.7.4

