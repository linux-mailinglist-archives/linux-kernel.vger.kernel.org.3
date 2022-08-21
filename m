Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D759B2AE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiHUIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiHUIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3301A3A7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEDA260DB9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6221C433D6;
        Sun, 21 Aug 2022 08:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661069179;
        bh=mqXsFwh+05iiPRNW7M9j0aSWVfB/2J8LNjTrDN/eDxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYMd1UzzNphHb8iRHDLims0gh3V8ZnccAgVHIX+a/FMXEKwQX6AXzezVIg/zpwDPL
         V6aDvilMWFzpqtbcH1QgvKkqefCM3Pq0HB4p2KW6TRpPvBwkbjTV186S1EzMRQUqXX
         tqLuEub+vxrR0jV7isyQROn9uj3lXGApoG7Z9B6ogZrav/oJOER74zH/Y5ZnIpyWZ1
         qd/LcdFad2is3htvMkvWmwR8XVt6Elit4eVJdhGPIVvEWKfhUQUIYK7YdzMoEISjbR
         TObhMR/WwN1taCdDti5AggERsPc0X770H8C/Aj0oUSbON1YM3tFYyHYPhVeDm/YRx/
         PLHuIxDnLKZkQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH v2 2/3] habanalabs: trace MMU map/unmap page
Date:   Sun, 21 Aug 2022 11:06:07 +0300
Message-Id: <20220821080608.27486-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220821080608.27486-1-ogabbay@kernel.org>
References: <20220821080608.27486-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
Changes in v2:
 - Avoid check the return code in case tracing is disabled

 drivers/misc/habanalabs/common/mmu/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 60740de47b34..f901e668a468 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -9,6 +9,8 @@
 
 #include "../habanalabs.h"
 
+#include <trace/events/habanalabs.h>
+
 /**
  * hl_mmu_get_funcs() - get MMU functions structure
  * @hdev: habanalabs device structure.
@@ -259,6 +261,9 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 	if (flush_pte)
 		mmu_funcs->flush(ctx);
 
+	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
+		trace_habanalabs_mmu_unmap(hdev->dev, virt_addr, 0, page_size, flush_pte);
+
 	return rc;
 }
 
@@ -344,6 +349,8 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_s
 	if (flush_pte)
 		mmu_funcs->flush(ctx);
 
+	trace_habanalabs_mmu_map(hdev->dev, virt_addr, phys_addr, page_size, flush_pte);
+
 	return 0;
 
 err:
-- 
2.25.1

