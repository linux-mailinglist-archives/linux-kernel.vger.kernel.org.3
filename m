Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC3585E89
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiGaKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiGaKus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5603F11820
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E616060C01
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7957FC433C1;
        Sun, 31 Jul 2022 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264646;
        bh=VRI3vs/UoRRt7XIQQ4yCSp0v7mr3AjgRc8BdnSir5mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOLPHLvojvV6Q2/Cyata8YNiuAOLv2bNmMt0bIYKnglxQoktVeWMyk3pZZL4rRqUJ
         YwDYL2bd7T2ALF0Y/E0EzGC5FZHTIlXaFkVdWm01uFfubbv4aao+aOo11RhUgsIrT3
         /yLXyjieJbTt8v8optuB0DS3r9pMWHlSh/TSi3n7bgKdp04AeSoXe9sjl3iHbA3BGo
         PmPv8i+IfTq/at1faQ8bS/geWPG8J7raRBu2d31T2Xxw3Tj3/GIG+Oq0qINwcl7Ahq
         sl/26BI7rfGpO1PpoVaDZeN4t8ZFh+AC40VHo0PFeWS3exSkXSuOdF3tIIX/B9BuEy
         Y9VCr5eItdC/w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 4/8] habanalabs: avoid returning a valid handle if map_block() fails
Date:   Sun, 31 Jul 2022 13:50:33 +0300
Message-Id: <20220731105037.545106-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220731105037.545106-1-ogabbay@kernel.org>
References: <20220731105037.545106-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

map_block() sets the block id handle even if get_hw_block_id() fails,
and in this case it uses block id 0 which might be a valid id.
Modify it to set the handle only if get_hw_block_id() succeeds.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 61bc1bfe984a..0698c3c363bd 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1418,18 +1418,23 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	return rc;
 }
 
-static int map_block(struct hl_device *hdev, u64 address, u64 *handle,
-			u32 *size)
+static int map_block(struct hl_device *hdev, u64 address, u64 *handle, u32 *size)
 {
-	u32 block_id = 0;
+	u32 block_id;
 	int rc;
 
+	*handle = 0;
+	if (size)
+		*size = 0;
+
 	rc = hdev->asic_funcs->get_hw_block_id(hdev, address, size, &block_id);
+	if (rc)
+		return rc;
 
 	*handle = block_id | HL_MMAP_TYPE_BLOCK;
 	*handle <<= PAGE_SHIFT;
 
-	return rc;
+	return 0;
 }
 
 static void hw_block_vm_close(struct vm_area_struct *vma)
-- 
2.25.1

