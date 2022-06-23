Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB3558A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiFWUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFWUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A0762719
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98AF960F46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED33C341C0;
        Thu, 23 Jun 2022 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016936;
        bh=YHsFPlnCjHAs3LCgPzGtQcYBSjaSRUUWk/yC/o7Z4eo=;
        h=From:To:Cc:Subject:Date:From;
        b=CLtV07u2UZf2x9iP2vqsLrZ1/fzkfmuURSkZ79Oi5yQ7b9+bHULrDoKvsnnLNkpoi
         /T5vJrk6q2quDCverqN7IhDYdaGYpu+TV3tm4moK+4d5Yk9AqEjpCRgvvJiif8x6v/
         lHTxjnK/DcKjD1+XF/cEcPBqYXno2O4g3uA6XnBYCQTHuvOPTbWjz6MvjijOkmFDeq
         tX3lPJ7lcTuGHJnJrd3FwDQrcBMbcZ4HQ+x5o6cKXa1sJquNteRmWCdLNILw2WJNrJ
         IkANICM6dCVnMisYwN+ssZoMCUj0dWCmMNxbExM+vuruIl0stiS7U1Cuq2f0WaUfSB
         Vid0b0d7onx7g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 1/9] habanalabs: move memory_scrub_val to hdev struct
Date:   Thu, 23 Jun 2022 23:42:04 +0300
Message-Id: <20220623204212.1628709-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

move the field memory_scrub_val from struct hl_dbg_device_entry
to struct hl_device. This is because we want to use
this field also if debugfs is off.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 4 ++--
 drivers/misc/habanalabs/common/habanalabs.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index c6744bfc6da4..0f07c2de986b 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -543,7 +543,7 @@ static ssize_t hl_memory_scrub(struct file *f, const char __user *buf,
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
-	u64 val = entry->memory_scrub_val;
+	u64 val = hdev->memory_scrub_val;
 	int rc;
 
 	if (!hl_device_operational(hdev, NULL)) {
@@ -1516,7 +1516,7 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	debugfs_create_x64("memory_scrub_val",
 				0644,
 				dev_entry->root,
-				&dev_entry->memory_scrub_val);
+				&hdev->memory_scrub_val);
 
 	debugfs_create_file("memory_scrub",
 				0200,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 94893305b928..931fa7092646 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2065,7 +2065,6 @@ struct hl_debugfs_entry {
  * @addr: next address to read/write from/to in read/write32.
  * @mmu_addr: next virtual address to translate to physical address in mmu_show.
  * @userptr_lookup: the target user ptr to look up for on demand.
- * @memory_scrub_val: the value to which the dram will be scrubbed to using cb scrub_device_dram
  * @mmu_asid: ASID to use while translating in mmu_show.
  * @state_dump_head: index of the latest state dump
  * @i2c_bus: generic u8 debugfs file for bus value to use in i2c_data_read.
@@ -2096,7 +2095,6 @@ struct hl_dbg_device_entry {
 	u64				addr;
 	u64				mmu_addr;
 	u64				userptr_lookup;
-	u64				memory_scrub_val;
 	u32				mmu_asid;
 	u32				state_dump_head;
 	u8				i2c_bus;
@@ -2797,6 +2795,7 @@ struct hl_reset_info {
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
  * @fw_major_version: major version of current loaded preboot
  * @dram_used_mem: current DRAM memory consumption.
+ * @memory_scrub_val: the value to which the dram will be scrubbed to using cb scrub_device_dram
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
  *             value is saved so in case of hard-reset, the driver will restore
@@ -2942,6 +2941,7 @@ struct hl_device {
 	u32				*stream_master_qid_arr;
 	u32				fw_major_version;
 	atomic64_t			dram_used_mem;
+	u64				memory_scrub_val;
 	u64				timeout_jiffies;
 	u64				max_power;
 	u64				boot_error_status_mask;
-- 
2.25.1

