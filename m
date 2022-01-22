Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE3496DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiAVT64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiAVT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90807C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAF660E04
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E4CC340E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881490;
        bh=1JZpCdmJbIWjv7VDsyDHnYhjTEXVsp5+vZ/FVyYKTfA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MP9USvvO50PpcJIeEpRsdPO0zEUsL5y9e/0CZPbFOutg/YL4b+4rePZS3vlp7ws+c
         3PVX5HmSJ2w10cjydAEJ8i5VzpWg90vpyCHNwSt7uAxakrkKZn7duTeBpmi+MLHN+4
         a9U1h8M8E5ScugBWBY8jjmmpQ8GpHktDgdF3PheoUBqvm/xZCielSTXj4tu5zI0POr
         VMigvxoiT2osAuO5LYmA85NNHLqYY4iY9O+6KsPKt4hj+dzsevOrp3TAprW5lhmCVN
         IVt+EX/w7/wYjVA5UQOXWHORH7hHNLbQllBisekFryRCxIFSSUUrg+LZYI5Z6Zx5qx
         R3f0r5ZityWBg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] habanalabs: reject host map with mmu disabled
Date:   Sat, 22 Jan 2022 21:57:27 +0200
Message-Id: <20220122195731.934494-26-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not something we can do a workaround. It is clearly an error
and we should notify the user that it is an error.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 30 +++++++++----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 4a5d3a179765..f60a9638d9ea 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1967,16 +1967,15 @@ static int export_dmabuf_from_handle(struct hl_ctx *ctx, u64 handle, int flags,
 static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_ctx *ctx = hpriv->ctx;
 	u64 block_handle, device_addr = 0;
+	struct hl_ctx *ctx = hpriv->ctx;
 	u32 handle = 0, block_size;
-	int rc, dmabuf_fd = -EBADF;
+	int rc;
 
 	switch (args->in.op) {
 	case HL_MEM_OP_ALLOC:
 		if (args->in.alloc.mem_size == 0) {
-			dev_err(hdev->dev,
-				"alloc size must be larger than 0\n");
+			dev_err(hdev->dev, "alloc size must be larger than 0\n");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -1997,15 +1996,14 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 
 	case HL_MEM_OP_MAP:
 		if (args->in.flags & HL_MEM_USERPTR) {
-			device_addr = args->in.map_host.host_virt_addr;
-			rc = 0;
+			dev_err(hdev->dev, "Failed to map host memory when MMU is disabled\n");
+			rc = -EPERM;
 		} else {
-			rc = get_paddr_from_handle(ctx, &args->in,
-							&device_addr);
+			rc = get_paddr_from_handle(ctx, &args->in, &device_addr);
+			memset(args, 0, sizeof(*args));
+			args->out.device_virt_addr = device_addr;
 		}
 
-		memset(args, 0, sizeof(*args));
-		args->out.device_virt_addr = device_addr;
 		break;
 
 	case HL_MEM_OP_UNMAP:
@@ -2013,20 +2011,14 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 		break;
 
 	case HL_MEM_OP_MAP_BLOCK:
-		rc = map_block(hdev, args->in.map_block.block_addr,
-				&block_handle, &block_size);
+		rc = map_block(hdev, args->in.map_block.block_addr, &block_handle, &block_size);
 		args->out.block_handle = block_handle;
 		args->out.block_size = block_size;
 		break;
 
 	case HL_MEM_OP_EXPORT_DMABUF_FD:
-		rc = export_dmabuf_from_addr(ctx,
-				args->in.export_dmabuf_fd.handle,
-				args->in.export_dmabuf_fd.mem_size,
-				args->in.flags,
-				&dmabuf_fd);
-		memset(args, 0, sizeof(*args));
-		args->out.fd = dmabuf_fd;
+		dev_err(hdev->dev, "Failed to export dma-buf object when MMU is disabled\n");
+		rc = -EPERM;
 		break;
 
 	default:
-- 
2.25.1

