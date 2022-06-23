Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565A558A50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiFWUmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiFWUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0122F62728
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AA5961DEB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073AAC341C0;
        Thu, 23 Jun 2022 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016944;
        bh=3WqpRqHqrt6XeQWN5b/MjgHVbIJ232IsBCRsZeS/s+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbpX91W93Sx5+zauQK73tjiVb+E6nzNzmzhD7fodveFb2yleQ9/mqY3nzZp+Jct8C
         jtE/tzGancXVW34UHSYrgGCAOpeQ3BA0DucT5nCnuEYrXXJnGTHCBsz91DxpalV3+R
         0CL2ICqtn692DBF/I2zLVt7nH8Km72ODO29UICk7R2rtB7W410hl+i2Y4IqbN9C29P
         dijP0qJetnkeFle5wpf5uh56/58jUXYDnsRXsPm0Uz9AbAKSmPxKVHTdQjuF7MQ2Bx
         75KwkW87W8t2oZp13ITCeABObQ9AA6J1a6HlvyUWmkpaHeZZkgCS20F2126vjesDoJ
         F1fvWtQ8FT/Mg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 7/9] habanalabs/gaudi: use memory_scrub_val from debugfs
Date:   Thu, 23 Jun 2022 23:42:10 +0300
Message-Id: <20220623204212.1628709-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

In the callback scrub_device_mem, use 'memory_scrub_val'
from debugfs for the scrubbing value.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/debugfs-driver-habanalabs | 3 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c               | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 0f8d20fe343f..deb66944cd0c 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -182,7 +182,8 @@ Date:           May 2022
 KernelVersion:  5.19
 Contact:        dhirschfeld@habana.ai
 Description:    The value to which the dram will be set to when the user
-                scrubs the dram using 'memory_scrub' debugfs file
+                scrubs the dram using 'memory_scrub' debugfs file and
+                the scrubbing value when using module param 'memory_scrub'
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/mmu
 Date:           Jan 2019
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index bc5e74505d03..8cf3382fa039 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4851,7 +4851,7 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 addr, size, dummy_val;
 	int rc = 0;
-	u64 val = 0;
+	u64 val = hdev->memory_scrub_val;
 
 	if (!hdev->memory_scrub)
 		return 0;
@@ -4871,7 +4871,6 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev)
 	/* Scrub SRAM */
 	addr = prop->sram_user_base_address;
 	size = hdev->pldm ? 0x10000 : prop->sram_size - SRAM_USER_BASE_OFFSET;
-	val = 0x7777777777777777ull;
 
 	dev_dbg(hdev->dev, "Scrubing SRAM: 0x%09llx - 0x%09llx val: 0x%llx\n",
 			addr, addr + size, val);
@@ -4882,7 +4881,7 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev)
 	}
 
 	/* Scrub HBM using all DMA channels in parallel */
-	rc = gaudi_scrub_device_dram(hdev, 0xdeadbeaf);
+	rc = gaudi_scrub_device_dram(hdev, val);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to clear HBM (%d)\n", rc);
 		return rc;
-- 
2.25.1

