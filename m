Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4342252EE46
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiETOdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350338AbiETOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:33:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB318169E0B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D21D3B82BBF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9A3C34114;
        Fri, 20 May 2022 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653057194;
        bh=k3pKXR4/zhO8SZIhn7eYes9mPjp6RoTyUX/0TMAgj7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLMOOFKKhgyLdnbQm6NVo+ha8J1CWmvsG8M2YRdLVOxAK4jlaZzqEV75CZwcax3DJ
         qldCcFx5U/BNwAwJGk+K0/3FOlHGSyVGSNcFfNZZCdI9DyTPxB2pHQjf8eB6SHw8WX
         q4lz3Bo2IJtU+EFAILFZDd+3pN7rmoA818Huipq1dR80HtvEEfkjZoD0vwghAWGvdI
         DlnBHWuoqxTBgSMDICz++g/xARsHYfF+7+O9vSGu8vDuVVUO5grkB93uW1ekubif3w
         FM8IHLjXaJ8N41OQl7iEO2KUowvjoVdHM1OFVWH2JtFoQLQt/c6lIrawjXMen7zlJT
         9moqiI+VYQpHA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 4/5] habanalabs: fix missing handle shift during mmap
Date:   Fri, 20 May 2022 17:33:03 +0300
Message-Id: <20220520143304.1906895-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520143304.1906895-1-ogabbay@kernel.org>
References: <20220520143304.1906895-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

During mmap operation on the unified memory manager buffer, the vma
page offset is shifted to extract the handle value. Due to a typo, it
was not shifted back at the end. That could cause the offset to be
modified after mmap operation, that may affect subsequent operations.
In addition, in allocation flow, in case of out of memory error, idr
would not be correctly destroyed, again because of a missing shift.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 3dbe388d592d..ea5f2bd31b0a 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -183,7 +183,7 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 
 remove_idr:
 	spin_lock(&mmg->lock);
-	idr_remove(&mmg->handles, buf->handle);
+	idr_remove(&mmg->handles, lower_32_bits(buf->handle >> PAGE_SHIFT));
 	spin_unlock(&mmg->lock);
 free_buf:
 	kfree(buf);
@@ -295,7 +295,7 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 	}
 
 	buf->real_mapped_size = buf->mappable_size;
-	vma->vm_pgoff = handle;
+	vma->vm_pgoff = handle >> PAGE_SHIFT;
 
 	return 0;
 
-- 
2.25.1

