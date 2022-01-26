Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687E849CB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiAZNzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241734AbiAZNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55BC061759
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c23so10251466wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiXyCfzx1/PxAADkZ89dPGp+bj7MoZkCRUrA9uccdQg=;
        b=jHhnKjNsPFzZO3rYA2Aat5q+VtxegiMsAaAq28uxHXaRUTBoeFijZa7ktj8cU7Mttf
         1MAnvOBAbL4xpbvFqYK8xC8DebFuKfKEtrXOG9d648lUeP2WP4x1fmQl648lLEbMLPlI
         5ftOgr/k/+BKPAk5Y+PRiI3GewznMpis4fhlqAMxaX7LQxl98G9jxw/iX4YKY0e7IxFM
         1ixXZET+upkKm7OBcJa3gcKOgQMPNn84Lb+qykYy+oborzfd3g9M5o86VnhAmL55lcF0
         tE6JfJ6RnADLKR0CzNWAPYAGSHvZvSNmEp6qt/Em0rvCNniLJ1qi5x49RQY45QHX8Aaw
         BZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiXyCfzx1/PxAADkZ89dPGp+bj7MoZkCRUrA9uccdQg=;
        b=13zg259o1OUj4/Gndgr4+IU4naB1Ub+kKrhPNuOKheT8T43kFhydmP8bJ5D1EZd0+t
         aBkQYAnTwUwXTz6Mwa6SiRjk5luAbjLigtp3gPClsghKxXad+uvKC5DToMShMaGtzS/u
         i4ueaZWN92XbH5G8U69KUQdoQ25s4yuOoSVmuRrR6CiQE4cevJXHUBvhihgZr+1Y2eS0
         8NAUb2tIf1FVugExuPqibWpRuV0QyxZhfn9hWsl95YkgAjdS8yP8QlNU+JqU4yOBfe6J
         NB6T3M8g5F5iKvRmKTfHfLki9dAlv0M7Oo9cbFNTfy7GfNNepF7c4/8EQw3fwk0Cfi9w
         /k5A==
X-Gm-Message-State: AOAM533/V4UnNLk367adb9mBFHIBlF/MxCjlB2W7r8bFc5MS2vz6ZgWt
        aXFJzodaHfdH5Jm2uizvYyD5fg==
X-Google-Smtp-Source: ABdhPJyFC1EVf4ldevQ+b8/qXFk6SWSXEaoSZVE8eBaCf6cJqFZEGpQ5SdB88HZsUlsoL5SnWYOPFA==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr22378536wrs.185.1643205278185;
        Wed, 26 Jan 2022 05:54:38 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 11/12] misc: fastrpc: Add dma handle implementation
Date:   Wed, 26 Jan 2022 13:53:03 +0000
Message-Id: <20220126135304.16340-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>

The remote arguments carry both remote buffers and dma handles. Add proper
dma handle instructions to make it compatible with DSP implementation.

Signed-off-by: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 52 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6052a9cb9e2c..56ec7170b698 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -100,9 +100,20 @@ struct fastrpc_invoke_buf {
 	u32 pgidx;		/* index to start of contiguous region */
 };
 
-struct fastrpc_remote_arg {
-	u64 pv;
-	u64 len;
+struct fastrpc_remote_dmahandle {
+	s32 fd;		/* dma handle fd */
+	u32 offset;	/* dma handle offset */
+	u32 len;	/* dma handle length */
+};
+
+struct fastrpc_remote_buf {
+	u64 pv;		/* buffer pointer */
+	u64 len;	/* length of buffer */
+};
+
+union fastrpc_remote_arg {
+	struct fastrpc_remote_buf buf;
+	struct fastrpc_remote_dmahandle dma;
 };
 
 struct fastrpc_mmap_rsp_msg {
@@ -216,7 +227,7 @@ struct fastrpc_invoke_ctx {
 	struct work_struct put_work;
 	struct fastrpc_msg msg;
 	struct fastrpc_user *fl;
-	struct fastrpc_remote_arg *rpra;
+	union fastrpc_remote_arg *rpra;
 	struct fastrpc_map **maps;
 	struct fastrpc_buf *buf;
 	struct fastrpc_invoke_args *args;
@@ -766,7 +777,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
  * >>>>>>  START of METADATA <<<<<<<<<
  * +---------------------------------+
  * |           Arguments             |
- * | type:(struct fastrpc_remote_arg)|
+ * | type:(union fastrpc_remote_arg)|
  * |             (0 - N)             |
  * +---------------------------------+
  * |         Invoke Buffer list      |
@@ -791,7 +802,7 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 {
 	int size = 0;
 
-	size = (sizeof(struct fastrpc_remote_arg) +
+	size = (sizeof(struct fastrpc_remote_buf) +
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
@@ -856,7 +867,7 @@ static struct fastrpc_phy_page *fastrpc_phy_page_start(struct fastrpc_invoke_buf
 static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 {
 	struct device *dev = ctx->fl->sctx->dev;
-	struct fastrpc_remote_arg *rpra;
+	union fastrpc_remote_arg *rpra;
 	struct fastrpc_invoke_buf *list;
 	struct fastrpc_phy_page *pages;
 	int inbufs, i, oix, err = 0;
@@ -892,8 +903,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		i = ctx->olaps[oix].raix;
 		len = ctx->args[i].length;
 
-		rpra[i].pv = 0;
-		rpra[i].len = len;
+		rpra[i].buf.pv = 0;
+		rpra[i].buf.len = len;
 		list[i].num = len ? 1 : 0;
 		list[i].pgidx = i;
 
@@ -903,7 +914,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		if (ctx->maps[i]) {
 			struct vm_area_struct *vma = NULL;
 
-			rpra[i].pv = (u64) ctx->args[i].ptr;
+			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
 			pages[i].addr = ctx->maps[i]->phys;
 
 			mmap_read_lock(current->mm);
@@ -930,7 +941,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			if (rlen < mlen)
 				goto bail;
 
-			rpra[i].pv = args - ctx->olaps[oix].offset;
+			rpra[i].buf.pv = args - ctx->olaps[oix].offset;
 			pages[i].addr = ctx->buf->phys -
 					ctx->olaps[oix].offset +
 					(pkt_size - rlen);
@@ -944,7 +955,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		}
 
 		if (i < inbufs && !ctx->maps[i]) {
-			void *dst = (void *)(uintptr_t)rpra[i].pv;
+			void *dst = (void *)(uintptr_t)rpra[i].buf.pv;
 			void *src = (void *)(uintptr_t)ctx->args[i].ptr;
 
 			if (!kernel) {
@@ -960,12 +971,15 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	}
 
 	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
-		rpra[i].pv = (u64) ctx->args[i].ptr;
-		rpra[i].len = ctx->args[i].length;
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
@@ -978,7 +992,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			    u32 kernel)
 {
-	struct fastrpc_remote_arg *rpra = ctx->rpra;
+	union fastrpc_remote_arg *rpra = ctx->rpra;
 	struct fastrpc_user *fl = ctx->fl;
 	struct fastrpc_map *mmap = NULL;
 	struct fastrpc_invoke_buf *list;
@@ -995,9 +1009,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
-			void *src = (void *)(uintptr_t)rpra[i].pv;
+			void *src = (void *)(uintptr_t)rpra[i].buf.pv;
 			void *dst = (void *)(uintptr_t)ctx->args[i].ptr;
-			u64 len = rpra[i].len;
+			u64 len = rpra[i].buf.len;
 
 			if (!kernel) {
 				if (copy_to_user((void __user *)dst, src, len))
-- 
2.21.0

