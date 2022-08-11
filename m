Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAA58FB82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiHKLkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiHKLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:40:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6D2A94E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6960B82008
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EAFC433C1;
        Thu, 11 Aug 2022 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660218008;
        bh=jPHPCbb8J3hHIWeS73AXO0ijMmGt+cW0kQ2jbZLCWkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvztIFa/XPc8E0DgQ9p0gmb/W8HyAnWIUksdgz6evzLNXzOetqR1vESSL5dXwAZcl
         +9SzVmiFX5CDKbf3bB1QGt867Ak/fXWP+JZOidLbQMUaF+mn4R4f1MssLGLf3YbNcj
         YP7dwjTf/mllThvMW1/xZAK0TTTim5KEEZBrA2tICDW2AlSE0PpvfDnNbGvdCPwwhb
         5ZDMDcshQm0JTME+Fk2adtHeC6uBNnaycRugFtO0XJh+dHYAsAQh4qD4CAypiL6gRj
         MSsW6cXcVGCwZpyGulgAjWlaZ4/DYfWwgzVIN+WnckRc+PqRjLlANLR6jh6vx2Njhv
         nSKCX6RvOBMzA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/3] habanalabs: trace MMU map/unmap page
Date:   Thu, 11 Aug 2022 14:39:52 +0300
Message-Id: <20220811113953.1963412-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811113953.1963412-1-ogabbay@kernel.org>
References: <20220811113953.1963412-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This patch utilize the defined tracepoint to trace the MMU's pages
map/unmap operations.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 60740de47b34..60d2a3f8af13 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -9,6 +9,8 @@
 
 #include "../habanalabs.h"
 
+#include <trace/events/habanalabs.h>
+
 /**
  * hl_mmu_get_funcs() - get MMU functions structure
  * @hdev: habanalabs device structure.
@@ -259,7 +261,12 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 	if (flush_pte)
 		mmu_funcs->flush(ctx);
 
-	return rc;
+	if (rc)
+		return rc;
+
+	trace_habanalabs_mmu_unmap(hdev->dev, virt_addr, 0, page_size, flush_pte);
+
+	return 0;
 }
 
 /*
@@ -344,6 +351,8 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_s
 	if (flush_pte)
 		mmu_funcs->flush(ctx);
 
+	trace_habanalabs_mmu_map(hdev->dev, virt_addr, phys_addr, page_size, flush_pte);
+
 	return 0;
 
 err:
-- 
2.25.1

