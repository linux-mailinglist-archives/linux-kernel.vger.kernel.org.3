Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B7E55DE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiF0U1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiF0U0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B11A806
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F35B960C02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64321C385A2;
        Mon, 27 Jun 2022 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361604;
        bh=0LZ4aPPeOvGBNIq2BUO7uRqaXqEwrTrI6gEZPYntW0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgv3AMex8UuSbnwjh8fo39WHByrleMSg1Z77HpgCTTemwKfcRwoRZNDWs+KyQ7AWV
         05PCb/n0QR5jcQI1EfkDjAzNiUxIwE0Gq/SST2ljXo4XPh20hcGuHQQFGgLiJfLflu
         z8XD5RRO/LT1ad0OrVgSKAnP8uQG9LDTNOLY4rTdBWKFXeMY3UwaG8VZgj1WoPJBwv
         NpuV6UMMTAnRSbBn52sCJy+iUCmKpZVjdwi3UBA84hnXhaHVt13uIv+IR/6hx9vbs5
         gs3Jba3s7j/M+Ib3OqAt8HxyxtFmoi87lLz0nrigNkLO+vFmgy2ByFlmJH4dPKl4Fx
         vU+ymMgsY6thg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 10/12] habanalabs: add gaudi2 MMU support
Date:   Mon, 27 Jun 2022 23:26:18 +0300
Message-Id: <20220627202620.961350-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627202620.961350-1-ogabbay@kernel.org>
References: <20220627202620.961350-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

Gaudi2 has new MMU units. A PMMU for device->host accesses, and HMMU
for HBM accesses.

The page tables of both MMUs are located in the host's memory (referred
to in the code as host-resident pgt).

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c      |  77 ++-
 drivers/misc/habanalabs/common/habanalabs.h   |  99 +++-
 .../misc/habanalabs/common/habanalabs_ioctl.c |   2 +-
 drivers/misc/habanalabs/common/memory.c       |  21 +-
 drivers/misc/habanalabs/common/mmu/Makefile   |   3 +-
 drivers/misc/habanalabs/common/mmu/mmu.c      | 496 +++++++++++++++++-
 .../misc/habanalabs/common/mmu/mmu_v2_hr.c    | 399 ++++++++++++++
 7 files changed, 1064 insertions(+), 33 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 90273481a466..3da39662abd9 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -450,7 +450,7 @@ static int mmu_show(struct seq_file *s, void *data)
 	if (hl_mmu_get_tlb_info(ctx, virt_addr, &hops_info)) {
 		dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
 				virt_addr);
-		return 0;
+		goto put_ctx;
 	}
 
 	hl_mmu_va_to_pa(ctx, virt_addr, &phys_addr);
@@ -476,6 +476,10 @@ static int mmu_show(struct seq_file *s, void *data)
 				i, hops_info.hop_info[i].hop_pte_val);
 	}
 
+put_ctx:
+	if (dev_entry->mmu_asid != HL_KERNEL_ASID_ID)
+		hl_ctx_put(ctx);
+
 	return 0;
 }
 
@@ -522,6 +526,66 @@ static ssize_t mmu_asid_va_write(struct file *file, const char __user *buf,
 	return -EINVAL;
 }
 
+static int mmu_ack_error(struct seq_file *s, void *data)
+{
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_device *hdev = dev_entry->hdev;
+	int rc;
+
+	if (!hdev->mmu_enable)
+		return 0;
+
+	if (!dev_entry->mmu_cap_mask) {
+		dev_err(hdev->dev, "mmu_cap_mask is not set\n");
+		goto err;
+	}
+
+	rc = hdev->asic_funcs->ack_mmu_errors(hdev, dev_entry->mmu_cap_mask);
+	if (rc)
+		goto err;
+
+	return 0;
+err:
+	return -EINVAL;
+}
+
+static ssize_t mmu_ack_error_value_write(struct file *file,
+		const char __user *buf,
+		size_t count, loff_t *f_pos)
+{
+	struct seq_file *s = file->private_data;
+	struct hl_debugfs_entry *entry = s->private;
+	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	struct hl_device *hdev = dev_entry->hdev;
+	char kbuf[MMU_KBUF_SIZE];
+	ssize_t rc;
+
+	if (!hdev->mmu_enable)
+		return count;
+
+	if (count > sizeof(kbuf) - 1)
+		goto err;
+
+	if (copy_from_user(kbuf, buf, count))
+		goto err;
+
+	kbuf[count] = 0;
+
+	if (strncmp(kbuf, "0x", 2))
+		goto err;
+
+	rc = kstrtoull(kbuf, 16, &dev_entry->mmu_cap_mask);
+	if (rc)
+		goto err;
+
+	return count;
+err:
+	dev_err(hdev->dev, "usage: echo <0xmmu_cap_mask > > mmu_error\n");
+
+	return -EINVAL;
+}
+
 static int engines_show(struct seq_file *s, void *data)
 {
 	struct hl_debugfs_entry *entry = s->private;
@@ -667,7 +731,8 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 		dev_err(hdev->dev,
 			"virt addr 0x%llx is not mapped\n",
 			virt_addr);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto put_ctx;
 	}
 
 	rc = hl_mmu_va_to_pa(ctx, virt_addr, phys_addr);
@@ -678,6 +743,9 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 		rc = -EINVAL;
 	}
 
+put_ctx:
+	hl_ctx_put(ctx);
+
 	return rc;
 }
 
@@ -728,7 +796,7 @@ static void hl_access_host_mem(struct hl_device *hdev, u64 addr, u64 *val,
 }
 
 static int hl_access_mem(struct hl_device *hdev, u64 addr, u64 *val,
-	enum debugfs_access_type acc_type)
+				enum debugfs_access_type acc_type)
 {
 	size_t acc_size = (acc_type == DEBUGFS_READ64 || acc_type == DEBUGFS_WRITE64) ?
 		sizeof(u64) : sizeof(u32);
@@ -1462,7 +1530,8 @@ static const struct hl_info_list hl_debugfs_list[] = {
 	{"vm", vm_show, NULL},
 	{"userptr_lookup", userptr_lookup_show, userptr_lookup_write},
 	{"mmu", mmu_show, mmu_asid_va_write},
-	{"engines", engines_show, NULL}
+	{"mmu_error", mmu_ack_error, mmu_ack_error_value_write},
+	{"engines", engines_show, NULL},
 };
 
 static int hl_debugfs_open(struct inode *inode, struct file *file)
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bd2ecb836bc7..f61389115c26 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -104,6 +104,18 @@ enum hl_mmu_page_table_location {
 	MMU_NUM_PGT_LOCATIONS	/* num of PGT locations */
 };
 
+/**
+ * enum hl_mmu_enablement - what mmu modules to enable
+ * @MMU_EN_NONE: mmu disabled.
+ * @MMU_EN_ALL: enable all.
+ * @MMU_EN_PMMU_ONLY: Enable only the PMMU leaving the DMMU disabled.
+ */
+enum hl_mmu_enablement {
+	MMU_EN_NONE = 0,
+	MMU_EN_ALL = 1,
+	MMU_EN_PMMU_ONLY = 3,	/* N/A for Goya/Gaudi */
+};
+
 /*
  * HL_RSVD_SOBS 'sync stream' reserved sync objects per QMAN stream
  * HL_RSVD_MONS 'sync stream' reserved monitors per QMAN stream
@@ -238,20 +250,27 @@ struct hl_gen_wait_properties {
 
 /**
  * struct pgt_info - MMU hop page info.
- * @node: hash linked-list node for the pgts shadow hash of pgts.
+ * @node: hash linked-list node for the pgts on host (shadow pgts for device resident MMU and
+ *        actual pgts for host resident MMU).
  * @phys_addr: physical address of the pgt.
- * @shadow_addr: shadow hop in the host.
+ * @virt_addr: host virtual address of the pgt (see above device/host resident).
+ * @shadow_addr: shadow hop in the host for device resident MMU.
  * @ctx: pointer to the owner ctx.
- * @num_of_ptes: indicates how many ptes are used in the pgt.
+ * @num_of_ptes: indicates how many ptes are used in the pgt. used only for dynamically
+ *               allocated HOPs (all HOPs but HOP0)
+ *
+ * The MMU page tables hierarchy can be placed either on the device's DRAM (in which case shadow
+ * pgts will be stored on host memory) or on host memory (in which case no shadow is required).
  *
- * The MMU page tables hierarchy is placed on the DRAM. When a new level (hop)
- * is needed during mapping, a new page is allocated and this structure holds
- * its essential information. During unmapping, if no valid PTEs remained in the
- * page, it is freed with its pgt_info structure.
+ * When a new level (hop) is needed during mapping this structure will be used to describe
+ * the newly allocated hop as well as to track number of PTEs in it.
+ * During unmapping, if no valid PTEs remained in the page of a newly allocated hop, it is
+ * freed with its pgt_info structure.
  */
 struct pgt_info {
 	struct hlist_node	node;
 	u64			phys_addr;
+	u64			virt_addr;
 	u64			shadow_addr;
 	struct hl_ctx		*ctx;
 	int			num_of_ptes;
@@ -1704,6 +1723,9 @@ struct hl_cs_outcome_store {
  * @mem_hash: holds mapping from virtual address to virtual memory area
  *		descriptor (hl_vm_phys_pg_list or hl_userptr).
  * @mmu_shadow_hash: holds a mapping from shadow address to pgt_info structure.
+ * @hr_mmu_phys_hash: if host-resident MMU is used, holds a mapping from
+ *                    MMU-hop-page physical address to its host-resident
+ *                    pgt_info structure.
  * @hpriv: pointer to the private (Kernel Driver) data of the process (fd).
  * @hdev: pointer to the device structure.
  * @refcount: reference counter for the context. Context is released only when
@@ -1742,6 +1764,7 @@ struct hl_cs_outcome_store {
 struct hl_ctx {
 	DECLARE_HASHTABLE(mem_hash, MEM_HASH_TABLE_BITS);
 	DECLARE_HASHTABLE(mmu_shadow_hash, MMU_HASH_TABLE_BITS);
+	DECLARE_HASHTABLE(hr_mmu_phys_hash, MMU_HASH_TABLE_BITS);
 	struct hl_fpriv			*hpriv;
 	struct hl_device		*hdev;
 	struct kref			refcount;
@@ -2199,6 +2222,7 @@ struct hl_debugfs_entry {
  * @state_dump_sem: protects state_dump.
  * @addr: next address to read/write from/to in read/write32.
  * @mmu_addr: next virtual address to translate to physical address in mmu_show.
+ * @mmu_cap_mask: mmu hw capability mask, to be used in mmu_ack_error.
  * @userptr_lookup: the target user ptr to look up for on demand.
  * @mmu_asid: ASID to use while translating in mmu_show.
  * @state_dump_head: index of the latest state dump
@@ -2229,6 +2253,7 @@ struct hl_dbg_device_entry {
 	struct rw_semaphore		state_dump_sem;
 	u64				addr;
 	u64				mmu_addr;
+	u64				mmu_cap_mask;
 	u64				userptr_lookup;
 	u32				mmu_asid;
 	u32				state_dump_head;
@@ -2612,11 +2637,27 @@ struct hl_mmu_per_hop_info {
 struct hl_mmu_hop_info {
 	u64 scrambled_vaddr;
 	u64 unscrambled_paddr;
-	struct hl_mmu_per_hop_info hop_info[MMU_ARCH_5_HOPS];
+	struct hl_mmu_per_hop_info hop_info[MMU_ARCH_6_HOPS];
 	u32 used_hops;
 	enum hl_va_range_type range_type;
 };
 
+/**
+ * struct hl_hr_mmu_funcs - Device related host resident MMU functions.
+ * @get_hop0_pgt_info: get page table info structure for HOP0.
+ * @get_pgt_info: get page table info structure for HOP other than HOP0.
+ * @add_pgt_info: add page table info structure to hash.
+ * @get_tlb_mapping_params: get mapping parameters needed for getting TLB info for specific mapping.
+ */
+struct hl_hr_mmu_funcs {
+	struct pgt_info *(*get_hop0_pgt_info)(struct hl_ctx *ctx);
+	struct pgt_info *(*get_pgt_info)(struct hl_ctx *ctx, u64 phys_hop_addr);
+	void (*add_pgt_info)(struct hl_ctx *ctx, struct pgt_info *pgt_info, dma_addr_t phys_addr);
+	int (*get_tlb_mapping_params)(struct hl_device *hdev, struct hl_mmu_properties **mmu_prop,
+								struct hl_mmu_hop_info *hops,
+								u64 virt_addr, bool *is_huge);
+};
+
 /**
  * struct hl_mmu_funcs - Device related MMU functions.
  * @init: initialize the MMU module.
@@ -2631,22 +2672,21 @@ struct hl_mmu_hop_info {
  * @get_tlb_info: returns the list of hops and hop-entries used that were
  *                created in order to translate the giver virtual address to a
  *                physical one.
+ * @hr_funcs: functions specific to host resident MMU.
  */
 struct hl_mmu_funcs {
 	int (*init)(struct hl_device *hdev);
 	void (*fini)(struct hl_device *hdev);
 	int (*ctx_init)(struct hl_ctx *ctx);
 	void (*ctx_fini)(struct hl_ctx *ctx);
-	int (*map)(struct hl_ctx *ctx,
-			u64 virt_addr, u64 phys_addr, u32 page_size,
-			bool is_dram_addr);
-	int (*unmap)(struct hl_ctx *ctx,
-			u64 virt_addr, bool is_dram_addr);
+	int (*map)(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
+				bool is_dram_addr);
+	int (*unmap)(struct hl_ctx *ctx, u64 virt_addr, bool is_dram_addr);
 	void (*flush)(struct hl_ctx *ctx);
 	void (*swap_out)(struct hl_ctx *ctx);
 	void (*swap_in)(struct hl_ctx *ctx);
-	int (*get_tlb_info)(struct hl_ctx *ctx,
-			u64 virt_addr, struct hl_mmu_hop_info *hops);
+	int (*get_tlb_info)(struct hl_ctx *ctx, u64 virt_addr, struct hl_mmu_hop_info *hops);
+	struct hl_hr_mmu_funcs hr_funcs;
 };
 
 /**
@@ -3453,10 +3493,39 @@ int hl_mmu_prefetch_cache_range(struct hl_ctx *ctx, u32 flags, u32 asid, u64 va,
 u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte);
 u64 hl_mmu_get_hop_pte_phys_addr(struct hl_ctx *ctx, struct hl_mmu_properties *mmu_prop,
 					u8 hop_idx, u64 hop_addr, u64 virt_addr);
+void hl_mmu_hr_flush(struct hl_ctx *ctx);
+int hl_mmu_hr_init(struct hl_device *hdev, struct hl_mmu_hr_priv *hr_priv, u32 hop_table_size,
+			u64 pgt_size);
+void hl_mmu_hr_fini(struct hl_device *hdev, struct hl_mmu_hr_priv *hr_priv, u32 hop_table_size);
+void hl_mmu_hr_free_hop_remove_pgt(struct pgt_info *pgt_info, struct hl_mmu_hr_priv *hr_priv,
+				u32 hop_table_size);
+u64 hl_mmu_hr_pte_phys_to_virt(struct hl_ctx *ctx, struct pgt_info *pgt, u64 phys_pte_addr,
+							u32 hop_table_size);
+void hl_mmu_hr_write_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info, u64 phys_pte_addr,
+							u64 val, u32 hop_table_size);
+void hl_mmu_hr_clear_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info, u64 phys_pte_addr,
+							u32 hop_table_size);
+int hl_mmu_hr_put_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info, struct hl_mmu_hr_priv *hr_priv,
+							u32 hop_table_size);
+void hl_mmu_hr_get_pte(struct hl_ctx *ctx, struct hl_hr_mmu_funcs *hr_func, u64 phys_hop_addr);
+struct pgt_info *hl_mmu_hr_get_next_hop_pgt_info(struct hl_ctx *ctx,
+							struct hl_hr_mmu_funcs *hr_func,
+							u64 curr_pte);
+struct pgt_info *hl_mmu_hr_alloc_hop(struct hl_ctx *ctx, struct hl_mmu_hr_priv *hr_priv,
+							struct hl_hr_mmu_funcs *hr_func,
+							struct hl_mmu_properties *mmu_prop);
+struct pgt_info *hl_mmu_hr_get_alloc_next_hop(struct hl_ctx *ctx,
+							struct hl_mmu_hr_priv *hr_priv,
+							struct hl_hr_mmu_funcs *hr_func,
+							struct hl_mmu_properties *mmu_prop,
+							u64 curr_pte, bool *is_new_hop);
+int hl_mmu_hr_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr, struct hl_mmu_hop_info *hops,
+							struct hl_hr_mmu_funcs *hr_func);
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 int hl_mmu_if_set_funcs(struct hl_device *hdev);
 void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu);
+void hl_mmu_v2_hr_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu);
 int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr);
 int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 			struct hl_mmu_hop_info *hops);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index a7a00f8dab30..96e12ab7a924 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -69,7 +69,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 
 	dram_available_size = prop->dram_size - dram_kmd_size;
 
-	if (hdev->mmu_enable)
+	if (hdev->mmu_enable == MMU_EN_ALL)
 		hw_ip.dram_size = DIV_ROUND_DOWN_ULL(dram_available_size,
 				prop->dram_page_size) * prop->dram_page_size;
 	else
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 0964c26d717c..61bc1bfe984a 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -627,7 +627,7 @@ static u64 get_va_block(struct hl_device *hdev,
 
 	/* Check if we need to ignore hint address */
 	if ((is_align_pow_2 && (hint_addr & (va_block_align - 1))) ||
-		(!is_align_pow_2 && is_hint_dram_addr &&
+			(!is_align_pow_2 && is_hint_dram_addr &&
 			do_div(tmp_hint_addr, va_range->page_size))) {
 
 		if (force_hint) {
@@ -2477,17 +2477,20 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr,
  * va_range_init() - initialize virtual addresses range.
  * @hdev: pointer to the habanalabs device structure.
  * @va_ranges: pointer to va_ranges array.
- * @start: range start address.
- * @end: range end address.
+ * @range_type: virtual address range type.
+ * @start: range start address, inclusive.
+ * @end: range end address, inclusive.
  * @page_size: page size for this va_range.
  *
  * This function does the following:
  * - Initializes the virtual addresses list of the given range with the given
  *   addresses.
  */
-static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
-				u64 start, u64 end, u32 page_size)
+static int va_range_init(struct hl_device *hdev, struct hl_va_range **va_ranges,
+				enum hl_va_range_type range_type, u64 start,
+				u64 end, u32 page_size)
 {
+	struct hl_va_range *va_range = va_ranges[range_type];
 	int rc;
 
 	INIT_LIST_HEAD(&va_range->list);
@@ -2605,7 +2608,7 @@ static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
 
 	mutex_init(&ctx->va_range[HL_VA_RANGE_TYPE_HOST]->lock);
 
-	rc = va_range_init(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST],
+	rc = va_range_init(hdev, ctx->va_range, HL_VA_RANGE_TYPE_HOST,
 			host_range_start, host_range_end, host_page_size);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init host vm range\n");
@@ -2616,7 +2619,7 @@ static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
 		mutex_init(&ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]->lock);
 
 		rc = va_range_init(hdev,
-			ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE],
+			ctx->va_range, HL_VA_RANGE_TYPE_HOST_HUGE,
 			host_huge_range_start, host_huge_range_end,
 			host_huge_page_size);
 		if (rc) {
@@ -2632,7 +2635,7 @@ static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
 
 	mutex_init(&ctx->va_range[HL_VA_RANGE_TYPE_DRAM]->lock);
 
-	rc = va_range_init(hdev, ctx->va_range[HL_VA_RANGE_TYPE_DRAM],
+	rc = va_range_init(hdev, ctx->va_range, HL_VA_RANGE_TYPE_DRAM,
 			dram_range_start, dram_range_end, dram_page_size);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init dram vm range\n");
diff --git a/drivers/misc/habanalabs/common/mmu/Makefile b/drivers/misc/habanalabs/common/mmu/Makefile
index d852c3874658..1806c524e04a 100644
--- a/drivers/misc/habanalabs/common/mmu/Makefile
+++ b/drivers/misc/habanalabs/common/mmu/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-HL_COMMON_MMU_FILES := common/mmu/mmu.o common/mmu/mmu_v1.o
+HL_COMMON_MMU_FILES := common/mmu/mmu.o common/mmu/mmu_v1.o \
+			common/mmu/mmu_v2_hr.o
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index f3734718d94f..3f0f84498125 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2020 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -51,8 +51,17 @@ int hl_mmu_init(struct hl_device *hdev)
 			return rc;
 	}
 
-	if (hdev->mmu_func[MMU_HR_PGT].init != NULL)
+	if (hdev->mmu_func[MMU_HR_PGT].init != NULL) {
 		rc = hdev->mmu_func[MMU_HR_PGT].init(hdev);
+		if (rc)
+			goto fini_dr_mmu;
+	}
+
+	return 0;
+
+fini_dr_mmu:
+	if (hdev->mmu_func[MMU_DR_PGT].fini != NULL)
+		hdev->mmu_func[MMU_DR_PGT].fini(hdev);
 
 	return rc;
 }
@@ -103,8 +112,17 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 			return rc;
 	}
 
-	if (hdev->mmu_func[MMU_HR_PGT].ctx_init != NULL)
+	if (hdev->mmu_func[MMU_HR_PGT].ctx_init != NULL) {
 		rc = hdev->mmu_func[MMU_HR_PGT].ctx_init(ctx);
+		if (rc)
+			goto fini_dr_ctx;
+	}
+
+	return 0;
+
+fini_dr_ctx:
+	if (hdev->mmu_func[MMU_DR_PGT].fini != NULL)
+		hdev->mmu_func[MMU_DR_PGT].fini(hdev);
 
 	return rc;
 }
@@ -607,6 +625,11 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 	case ASIC_GAUDI_SEC:
 		hl_mmu_v1_set_funcs(hdev, &hdev->mmu_func[MMU_DR_PGT]);
 		break;
+	case ASIC_GAUDI2:
+	case ASIC_GAUDI2_SEC:
+		/* MMUs in Gaudi2 are always host resident */
+		hl_mmu_v2_hr_set_funcs(hdev, &hdev->mmu_func[MMU_HR_PGT]);
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 			hdev->asic_type);
@@ -745,3 +768,470 @@ u64 hl_mmu_get_hop_pte_phys_addr(struct hl_ctx *ctx, struct hl_mmu_properties *m
 	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size * ((virt_addr & mask) >> shift);
 }
 
+static void mmu_dma_mem_free_from_chunk(struct gen_pool *pool,
+					struct gen_pool_chunk *chunk,
+					void *data)
+{
+	struct hl_device *hdev = (struct hl_device *)data;
+
+	hl_asic_dma_free_coherent(hdev, (chunk->end_addr - chunk->start_addr) + 1,
+					(void *)chunk->start_addr, chunk->phys_addr);
+}
+
+void hl_mmu_hr_flush(struct hl_ctx *ctx)
+{
+	/* a flush operation requires memory barrier */
+	mb();
+	asm volatile ("mfence" : : : "memory");
+}
+
+/**
+ * hl_mmu_hr_pool_destroy() - destroy genpool
+ * @hdev: habanalabs device structure.
+ * @hr_priv: MMU HR private data.
+ * @hop_table_size: HOP table size.
+ *
+ * This function does the following:
+ * - free entries allocated for shadow HOP0
+ * - free pool chunks
+ * - free pool
+ */
+static void hl_mmu_hr_pool_destroy(struct hl_device *hdev, struct hl_mmu_hr_priv *hr_priv,
+					u32 hop_table_size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gen_pool **pool = &hr_priv->mmu_pgt_pool;
+	struct pgt_info *hop0_pgt;
+	int asid;
+
+	if (ZERO_OR_NULL_PTR(*pool))
+		return;
+
+	/* Free the Fixed allocation of HOPs0 */
+	if (hr_priv->mmu_asid_hop0) {
+		for (asid = 0 ; asid < prop->max_asid ; asid++) {
+			hop0_pgt = &hr_priv->mmu_asid_hop0[asid];
+			if (ZERO_OR_NULL_PTR(hop0_pgt->virt_addr))
+				continue;
+
+			gen_pool_free(*pool, (uintptr_t) hop0_pgt->virt_addr, hop_table_size);
+		}
+	}
+
+	gen_pool_for_each_chunk(*pool, mmu_dma_mem_free_from_chunk, hdev);
+	gen_pool_destroy(*pool);
+
+	/* Make sure that if we arrive here again without init was called we
+	 * won't cause kernel panic. This can happen for example if we fail
+	 * during hard reset code at certain points
+	 */
+	*pool = NULL;
+}
+
+/**
+ * hl_mmu_hr_init() - initialize the MMU module.
+ * @hdev: habanalabs device structure.
+ * @hr_priv: MMU HR private data.
+ * @hop_table_size: HOP table size.
+ * @pgt_size: memory size allocated for the page table
+ *
+ * @return 0 on success otherwise non-zero error code
+ *
+ * This function does the following:
+ * - Create a pool of pages for pgt_infos.
+ * - Create a shadow table for pgt
+ */
+int hl_mmu_hr_init(struct hl_device *hdev, struct hl_mmu_hr_priv *hr_priv, u32 hop_table_size,
+			u64 pgt_size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	size_t pool_chunk_size = SZ_4M;
+	struct pgt_info *hop0_pgt;
+	u64 virt_addr, phys_addr;
+	int i, rc;
+
+	/*
+	 * we set alloc size as PAGE_SIZE (sine dma_alloc_coherent allocation order/size is
+	 * PAGE_SHIFT/PAGE_SIZE) in order to be able to control the allocations alignment.
+	 * This way we can call "DMA alloc align" according to dma_alloc granularity and supply
+	 * allocations with higher-order alignment restrictions
+	 */
+	hr_priv->mmu_pgt_pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (ZERO_OR_NULL_PTR(hr_priv->mmu_pgt_pool)) {
+		dev_err(hdev->dev, "Failed to create hr page pool\n");
+		return -ENOMEM;
+	}
+
+	hr_priv->mmu_asid_hop0 = kvcalloc(prop->max_asid, sizeof(struct pgt_info), GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(hr_priv->mmu_asid_hop0)) {
+		dev_err(hdev->dev, "Failed to allocate hr-mmu hop0 table\n");
+		rc = -ENOMEM;
+		goto destroy_mmu_pgt_pool;
+	}
+
+	for (i = 0 ; i < pgt_size ; i += pool_chunk_size) {
+		virt_addr = (uintptr_t) hl_asic_dma_alloc_coherent(hdev, pool_chunk_size,
+									&phys_addr,
+									GFP_KERNEL | __GFP_ZERO);
+		if (ZERO_OR_NULL_PTR(virt_addr)) {
+			dev_err(hdev->dev,
+				"Failed to allocate memory for host-resident page pool\n");
+			rc = -ENOMEM;
+			goto destroy_mmu_pgt_pool;
+		}
+
+		rc = gen_pool_add_virt(hr_priv->mmu_pgt_pool, virt_addr, phys_addr,
+						pool_chunk_size, -1);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to fill host-resident page pool\n");
+			goto destroy_mmu_pgt_pool;
+		}
+	}
+
+	for (i = 0 ; i < prop->max_asid ; i++) {
+		hop0_pgt = &hr_priv->mmu_asid_hop0[i];
+		hop0_pgt->virt_addr = (uintptr_t)
+					gen_pool_dma_zalloc_align(hr_priv->mmu_pgt_pool,
+									hop_table_size,
+									&hop0_pgt->phys_addr,
+									hop_table_size);
+		if (!hop0_pgt->virt_addr) {
+			dev_err(hdev->dev, "Failed to allocate HOP from pgt pool\n");
+			rc = -ENOMEM;
+			goto destroy_mmu_pgt_pool;
+		}
+	}
+
+	/* MMU H/W init will be done in device hw_init() */
+
+	return 0;
+
+destroy_mmu_pgt_pool:
+	hl_mmu_hr_pool_destroy(hdev, hr_priv, hop_table_size);
+	if (!ZERO_OR_NULL_PTR(hr_priv->mmu_asid_hop0))
+		kvfree(hr_priv->mmu_asid_hop0);
+
+	return rc;
+}
+
+/**
+ * hl_mmu_hr_fini() - release the MMU module.
+ * @hdev: habanalabs device structure.
+ * @hr_priv: MMU host resident private info.
+ * @hop_table_size: HOP table size
+ *
+ * This function does the following:
+ * - Disable MMU in H/W.
+ * - Free the pgt_infos pool.
+ *
+ * All contexts should be freed before calling this function.
+ */
+void hl_mmu_hr_fini(struct hl_device *hdev, struct hl_mmu_hr_priv *hr_priv, u32 hop_table_size)
+{
+	/* MMU H/W fini was already done in device hw_fini() */
+
+	hl_mmu_hr_pool_destroy(hdev, hr_priv, hop_table_size);
+
+	if (!ZERO_OR_NULL_PTR(hr_priv->mmu_asid_hop0)) {
+		kvfree(hr_priv->mmu_asid_hop0);
+
+		/* Make sure that if we arrive here again without init was
+		 * called we won't cause kernel panic. This can happen for
+		 * example if we fail during hard reset code at certain points
+		 */
+		hr_priv->mmu_asid_hop0 = NULL;
+	}
+}
+
+/**
+ * hl_mmu_hr_free_hop_remove_pgt() - free HOP and remove PGT from hash
+ * @pgt_info: page table info structure.
+ * @hr_priv: MMU HR private data.
+ * @hop_table_size: HOP table size.
+ */
+void hl_mmu_hr_free_hop_remove_pgt(struct pgt_info *pgt_info, struct hl_mmu_hr_priv *hr_priv,
+					u32 hop_table_size)
+{
+	gen_pool_free(hr_priv->mmu_pgt_pool, pgt_info->virt_addr, hop_table_size);
+	hash_del(&pgt_info->node);
+	kfree(pgt_info);
+}
+
+/**
+ * hl_mmu_hr_pte_phys_to_virt() - translate PTE phys addr to virt addr
+ * @ctx: pointer to the context structure
+ * @pgt: pgt_info for the HOP hosting the PTE
+ * @phys_pte_addr: phys address of the PTE
+ * @hop_table_size: HOP table size
+ *
+ * @return PTE virtual address
+ *
+ * The function use the pgt_info to get HOP base virt addr and obtain the PTE's virt addr
+ * by adding the PTE offset.
+ */
+u64 hl_mmu_hr_pte_phys_to_virt(struct hl_ctx *ctx, struct pgt_info *pgt,
+							u64 phys_pte_addr, u32 hop_table_size)
+{
+	u64 page_mask = (hop_table_size - 1);
+	u64 pte_offset = phys_pte_addr & page_mask;
+
+	return pgt->virt_addr + pte_offset;
+}
+
+/**
+ * hl_mmu_hr_write_pte() - write HR PTE
+ * @ctx: pointer to the context structure
+ * @pgt_info: HOP's page table info structure
+ * @phys_pte_addr: phys PTE address
+ * @val: raw PTE data
+ * @hop_table_size: HOP table size
+ */
+void hl_mmu_hr_write_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info, u64 phys_pte_addr,
+								u64 val, u32 hop_table_size)
+{
+	/*
+	 * The value to write is the phys address of the next hop +
+	 * flags at the 12 LSBs.
+	 */
+	u64 virt_addr = hl_mmu_hr_pte_phys_to_virt(ctx, pgt_info, phys_pte_addr, hop_table_size);
+
+	*(u64 *) virt_addr = val;
+}
+
+/**
+ * hl_mmu_hr_clear_pte() - clear HR PTE
+ * @ctx: pointer to the context structure
+ * @pgt_info: HOP's page table info structure
+ * @phys_pte_addr: phys PTE address
+ * @hop_table_size: HOP table size
+ */
+void hl_mmu_hr_clear_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info, u64 phys_pte_addr,
+						u32 hop_table_size)
+{
+	/* no need to transform the value to physical address */
+	hl_mmu_hr_write_pte(ctx, pgt_info, phys_pte_addr, 0, hop_table_size);
+}
+
+/**
+ * hl_mmu_hr_put_pte() - put HR PTE and remove it if necessary (no more PTEs)
+ * @ctx: pointer to the context structure
+ * @pgt_info: HOP's page table info structure
+ * @hr_priv: HR MMU private info
+ * @hop_table_size: HOP table size
+ *
+ * @return number of PTEs still in the HOP
+ */
+int hl_mmu_hr_put_pte(struct hl_ctx *ctx, struct pgt_info *pgt_info,
+						struct hl_mmu_hr_priv *hr_priv,
+						u32 hop_table_size)
+{
+	int num_of_ptes_left;
+
+	pgt_info->num_of_ptes--;
+
+	/*
+	 * Need to save the number of ptes left because free_hop might free
+	 * the pgt_info
+	 */
+	num_of_ptes_left = pgt_info->num_of_ptes;
+	if (!num_of_ptes_left)
+		hl_mmu_hr_free_hop_remove_pgt(pgt_info, hr_priv, hop_table_size);
+
+	return num_of_ptes_left;
+}
+
+/**
+ * hl_mmu_hr_get_pte() - increase PGT PTE count
+ * @ctx: pointer to the context structure
+ * @hr_func: host resident functions
+ * @phys_hop_addr: HOP phys address
+ */
+void hl_mmu_hr_get_pte(struct hl_ctx *ctx, struct hl_hr_mmu_funcs *hr_func, u64 phys_hop_addr)
+{
+	hr_func->get_pgt_info(ctx, phys_hop_addr)->num_of_ptes++;
+}
+
+/**
+ * hl_mmu_hr_get_next_hop_pgt_info() - get pgt_info structure for the next HOP
+ * @ctx: pointer to the context structure.
+ * @hr_func: host resident functions.
+ * @curr_pte: current PTE value.
+ *
+ * @return pgt_info structure on success, otherwise NULL.
+ */
+struct pgt_info *hl_mmu_hr_get_next_hop_pgt_info(struct hl_ctx *ctx,
+							struct hl_hr_mmu_funcs *hr_func,
+							u64 curr_pte)
+{
+	u64 next_hop_phys_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
+
+	if (next_hop_phys_addr == ULLONG_MAX)
+		return NULL;
+
+	return hr_func->get_pgt_info(ctx, next_hop_phys_addr);
+}
+
+/**
+ * hl_mmu_hr_alloc_hop() - allocate HOP
+ * @ctx: pointer to the context structure.
+ * @hr_priv: host resident private info structure.
+ * @hr_func: host resident functions.
+ * @mmu_prop: MMU properties.
+ *
+ * @return pgt_info structure associated with the allocated HOP on success, otherwise NULL.
+ */
+struct pgt_info *hl_mmu_hr_alloc_hop(struct hl_ctx *ctx, struct hl_mmu_hr_priv *hr_priv,
+							struct hl_hr_mmu_funcs *hr_func,
+							struct hl_mmu_properties *mmu_prop)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct pgt_info *pgt_info;
+	dma_addr_t phys_addr;
+	void *virt_addr;
+	int i, retry = 1;
+
+	pgt_info = kmalloc(sizeof(*pgt_info), GFP_KERNEL);
+	if (!pgt_info)
+		return NULL;
+
+	for (i = 0; i <= retry; i++) {
+		virt_addr = gen_pool_dma_zalloc_align(hr_priv->mmu_pgt_pool,
+							mmu_prop->hop_table_size,
+							&phys_addr,
+							mmu_prop->hop_table_size);
+		if (virt_addr)
+			break;
+
+		/* No memory in pool - get some and try again */
+		virt_addr = hl_asic_dma_alloc_coherent(hdev, SZ_2M, &phys_addr,
+							GFP_KERNEL | __GFP_ZERO);
+		if (ZERO_OR_NULL_PTR(virt_addr))
+			break;
+
+		if (gen_pool_add_virt(hr_priv->mmu_pgt_pool, (unsigned long)virt_addr,
+								phys_addr, SZ_2M, -1)) {
+			hl_asic_dma_free_coherent(hdev, SZ_2M, virt_addr, phys_addr);
+			virt_addr = NULL;
+			break;
+		}
+	}
+
+	if (ZERO_OR_NULL_PTR(virt_addr)) {
+		dev_err(hdev->dev, "failed to allocate page\n");
+		goto pool_alloc_err;
+	}
+
+	pgt_info->phys_addr = phys_addr;
+	pgt_info->shadow_addr = (unsigned long) NULL;
+	pgt_info->virt_addr = (unsigned long)virt_addr;
+	pgt_info->ctx = ctx;
+	pgt_info->num_of_ptes = 0;
+	hr_func->add_pgt_info(ctx, pgt_info, phys_addr);
+
+	return pgt_info;
+
+pool_alloc_err:
+	kfree(pgt_info);
+
+	return NULL;
+}
+
+/**
+ * hl_mmu_hr_get_alloc_next_hop() - get the next HOP, allocate it if it does not exist
+ * @ctx: pointer to the context structure.
+ * @hr_priv: host resident private info structure.
+ * @hr_func: host resident functions.
+ * @mmu_prop: MMU properties.
+ * @curr_pte: current PTE value.
+ * @is_new_hop: set to true if HOP is new (caller responsibility to set it to false).
+ *
+ * @return pgt_info structure associated with the allocated HOP on success, otherwise NULL.
+ */
+struct pgt_info *hl_mmu_hr_get_alloc_next_hop(struct hl_ctx *ctx,
+							struct hl_mmu_hr_priv *hr_priv,
+							struct hl_hr_mmu_funcs *hr_func,
+							struct hl_mmu_properties *mmu_prop,
+							u64 curr_pte, bool *is_new_hop)
+{
+	u64 hop_addr = hl_mmu_get_next_hop_addr(ctx, curr_pte);
+
+	if (hop_addr != ULLONG_MAX)
+		return hr_func->get_pgt_info(ctx, hop_addr);
+
+	*is_new_hop = true;
+	return hl_mmu_hr_alloc_hop(ctx, hr_priv, hr_func, mmu_prop);
+}
+
+/**
+ * hl_mmu_hr_get_tlb_info() - get the TLB info (info for a specific mapping)
+ * @ctx: pointer to the context structure.
+ * @virt_addr: the virt address for which to get info.
+ * @hops: HOPs info structure.
+ * @hr_func: host resident functions.
+ *
+ * @return 0 on success, otherwise non 0 error code..
+ */
+int hl_mmu_hr_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr, struct hl_mmu_hop_info *hops,
+								struct hl_hr_mmu_funcs *hr_func)
+{
+	/* using 6 HOPs as this is the maximum number of HOPs */
+	struct pgt_info *hops_pgt_info[MMU_ARCH_6_HOPS] = { NULL };
+	struct hl_device *hdev = ctx->hdev;
+	struct hl_mmu_properties *mmu_prop;
+	int rc, i, used_hops;
+	bool is_huge;
+
+	rc = hr_func->get_tlb_mapping_params(hdev, &mmu_prop, hops, virt_addr, &is_huge);
+	if (rc)
+		return rc;
+
+	used_hops = mmu_prop->num_hops;
+
+	/* huge pages use one less hop */
+	if (is_huge)
+		used_hops--;
+
+	hops->scrambled_vaddr = hdev->asic_funcs->scramble_addr(hdev, virt_addr);
+
+	for (i = 0 ; i < used_hops ; i++) {
+		if (i == 0)
+			hops_pgt_info[i] = hr_func->get_hop0_pgt_info(ctx);
+		else
+			hops_pgt_info[i] = hl_mmu_hr_get_next_hop_pgt_info(ctx, hr_func,
+								hops->hop_info[i - 1].hop_pte_val);
+
+		if (!hops_pgt_info[i])
+			return -EFAULT;
+
+		hops->hop_info[i].hop_addr = hops_pgt_info[i]->phys_addr;
+		hops->hop_info[i].hop_pte_addr =
+				hl_mmu_get_hop_pte_phys_addr(ctx, mmu_prop, i,
+								hops->hop_info[i].hop_addr,
+								hops->scrambled_vaddr);
+		hops->hop_info[i].hop_pte_val = *(u64 *) (uintptr_t)
+						hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
+								hops->hop_info[i].hop_pte_addr,
+								mmu_prop->hop_table_size);
+
+		if (!(hops->hop_info[i].hop_pte_val & PAGE_PRESENT_MASK))
+			return -EFAULT;
+
+		if (hops->hop_info[i].hop_pte_val & mmu_prop->last_mask)
+			break;
+	}
+
+	/* if passed over all hops then no last hop was found */
+	if (i == mmu_prop->num_hops)
+		return -EFAULT;
+
+	if (hops->scrambled_vaddr != virt_addr)
+		hops->unscrambled_paddr = hdev->asic_funcs->descramble_addr
+				(hdev, hops->hop_info[i].hop_pte_val);
+	else
+		hops->unscrambled_paddr = hops->hop_info[i].hop_pte_val;
+
+	hops->used_hops = i + 1;
+
+	return 0;
+}
+
diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c b/drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c
new file mode 100644
index 000000000000..afe7ef964f82
--- /dev/null
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020-2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "../habanalabs.h"
+#include "../../include/hw_ip/mmu/mmu_general.h"
+
+#include <linux/slab.h>
+
+static struct pgt_info *hl_mmu_v2_hr_get_pgt_info(struct hl_ctx *ctx, u64 phys_hop_addr)
+{
+	struct pgt_info *pgt_info = NULL;
+
+	hash_for_each_possible(ctx->hr_mmu_phys_hash, pgt_info, node,
+				(unsigned long) phys_hop_addr)
+		if (phys_hop_addr == pgt_info->phys_addr)
+			break;
+
+	return pgt_info;
+}
+
+static void hl_mmu_v2_hr_add_pgt_info(struct hl_ctx *ctx, struct pgt_info *pgt_info,
+					dma_addr_t phys_addr)
+{
+	hash_add(ctx->hr_mmu_phys_hash, &pgt_info->node, phys_addr);
+}
+
+static struct pgt_info *hl_mmu_v2_hr_get_hop0_pgt_info(struct hl_ctx *ctx)
+{
+	return &ctx->hdev->mmu_priv.hr.mmu_asid_hop0[ctx->asid];
+}
+
+/**
+ * hl_mmu_v2_hr_init() - initialize the MMU module.
+ * @hdev: habanalabs device structure.
+ *
+ * This function does the following:
+ * - Create a pool of pages for pgt_infos.
+ * - Create a shadow table for pgt
+ *
+ * Return: 0 for success, non-zero for failure.
+ */
+static inline int hl_mmu_v2_hr_init(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	return hl_mmu_hr_init(hdev, &hdev->mmu_priv.hr, prop->mmu_hop_table_size,
+				prop->mmu_pgt_size);
+}
+
+/**
+ * hl_mmu_v2_hr_fini() - release the MMU module.
+ * @hdev: habanalabs device structure.
+ *
+ * This function does the following:
+ * - Disable MMU in H/W.
+ * - Free the pgt_infos pool.
+ *
+ * All contexts should be freed before calling this function.
+ */
+static inline void hl_mmu_v2_hr_fini(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	hl_mmu_hr_fini(hdev, &hdev->mmu_priv.hr, prop->mmu_hop_table_size);
+}
+
+/**
+ * hl_mmu_v2_hr_ctx_init() - initialize a context for using the MMU module.
+ * @ctx: pointer to the context structure to initialize.
+ *
+ * Initialize a mutex to protect the concurrent mapping flow, a hash to hold all
+ * page tables hops related to this context.
+ * Return: 0 on success, non-zero otherwise.
+ */
+static int hl_mmu_v2_hr_ctx_init(struct hl_ctx *ctx)
+{
+	hash_init(ctx->hr_mmu_phys_hash);
+	return 0;
+}
+
+/*
+ * hl_mmu_v2_hr_ctx_fini - disable a ctx from using the mmu module
+ *
+ * @ctx: pointer to the context structure
+ *
+ * This function does the following:
+ * - Free any pgts which were not freed yet
+ * - Free the mutex
+ * - Free DRAM default page mapping hops
+ */
+static void hl_mmu_v2_hr_ctx_fini(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct pgt_info *pgt_info;
+	struct hlist_node *tmp;
+	int i;
+
+	if (!hash_empty(ctx->hr_mmu_phys_hash))
+		dev_err(hdev->dev, "ctx %d is freed while it has pgts in use\n",
+			ctx->asid);
+
+	hash_for_each_safe(ctx->hr_mmu_phys_hash, i, tmp, pgt_info, node) {
+		dev_err_ratelimited(hdev->dev,
+			"pgt_info of addr 0x%llx of asid %d was not destroyed, num_ptes: %d\n",
+			pgt_info->phys_addr, ctx->asid, pgt_info->num_of_ptes);
+		hl_mmu_hr_free_hop_remove_pgt(pgt_info, &ctx->hdev->mmu_priv.hr,
+							ctx->hdev->asic_prop.mmu_hop_table_size);
+	}
+}
+
+static int _hl_mmu_v2_hr_unmap(struct hl_ctx *ctx,
+				u64 virt_addr, bool is_dram_addr)
+{
+	u64 curr_pte, scrambled_virt_addr, hop_pte_phys_addr[MMU_ARCH_6_HOPS] = { 0 };
+	struct pgt_info *hops_pgt_info[MMU_ARCH_6_HOPS] = { NULL };
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop;
+	struct hl_mmu_properties *mmu_prop;
+	bool is_huge = false;
+	int i, hop_last;
+
+	prop = &hdev->asic_prop;
+
+	/* shifts and masks are the same in PMMU and HMMU, use one of them */
+	mmu_prop = is_dram_addr ? &prop->dmmu : &prop->pmmu;
+	hop_last = mmu_prop->num_hops - 1;
+
+	scrambled_virt_addr = hdev->asic_funcs->scramble_addr(hdev, virt_addr);
+	curr_pte = 0;
+
+	for (i = 0 ; i < mmu_prop->num_hops ; i++) {
+		/* we get HOP0 differently, it doesn't need curr_pte */
+		if (i == 0)
+			hops_pgt_info[i] = hl_mmu_v2_hr_get_hop0_pgt_info(ctx);
+		else
+			hops_pgt_info[i] = hl_mmu_hr_get_next_hop_pgt_info(ctx,
+					&ctx->hdev->mmu_func[MMU_HR_PGT].hr_funcs, curr_pte);
+		if (!hops_pgt_info[i])
+			goto not_mapped;
+
+		hop_pte_phys_addr[i] = hl_mmu_get_hop_pte_phys_addr(ctx, mmu_prop, i,
+									hops_pgt_info[i]->phys_addr,
+									scrambled_virt_addr);
+		if (hop_pte_phys_addr[i] == U64_MAX)
+			return -EFAULT;
+
+		curr_pte = *(u64 *) (uintptr_t) hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
+							hop_pte_phys_addr[i],
+							ctx->hdev->asic_prop.mmu_hop_table_size);
+
+		if ((i < hop_last) && (curr_pte & mmu_prop->last_mask)) {
+			hop_last = i;
+			is_huge = true;
+			break;
+		}
+	}
+
+	if (is_dram_addr && !is_huge) {
+		dev_err(hdev->dev, "DRAM unmapping should use huge pages only\n");
+		return -EFAULT;
+	}
+
+	if (!(curr_pte & PAGE_PRESENT_MASK))
+		goto not_mapped;
+
+	for (i = hop_last ; i > 0 ; i--) {
+		hl_mmu_hr_clear_pte(ctx, hops_pgt_info[i], hop_pte_phys_addr[i],
+						ctx->hdev->asic_prop.mmu_hop_table_size);
+
+		if (hl_mmu_hr_put_pte(ctx, hops_pgt_info[i], &ctx->hdev->mmu_priv.hr,
+						ctx->hdev->asic_prop.mmu_hop_table_size))
+			goto mapped;
+	}
+	hl_mmu_hr_clear_pte(ctx, hops_pgt_info[0], hop_pte_phys_addr[0],
+						ctx->hdev->asic_prop.mmu_hop_table_size);
+
+mapped:
+	return 0;
+
+not_mapped:
+	dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n", virt_addr);
+
+	return -EINVAL;
+}
+
+static int hl_mmu_v2_get_last_hop(struct hl_mmu_properties *mmu_prop, u32 page_size)
+{
+	int hop;
+
+	for (hop = (mmu_prop->num_hops - 1); hop; hop--) {
+		if (mmu_prop->hop_shifts[hop] == 0)
+			continue;
+
+		if (page_size <= (1 << mmu_prop->hop_shifts[hop]))
+			break;
+	}
+
+	return hop;
+}
+
+static int _hl_mmu_v2_hr_map(struct hl_ctx *ctx,
+			u64 virt_addr, u64 phys_addr,
+			u32 page_size, bool is_dram_addr)
+{
+	u64 hop_pte_phys_addr[MMU_ARCH_6_HOPS] = { 0 },
+		curr_pte = 0, scrambled_virt_addr, scrambled_phys_addr;
+	struct pgt_info *hops_pgt_info[MMU_ARCH_6_HOPS] = { NULL };
+	bool hop_new[MMU_ARCH_6_HOPS] = { false };
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
+	int i, hop_last, rc = -ENOMEM;
+
+	/*
+	 * This mapping function can map a page or a huge page. For huge page
+	 * there are only 4 hops rather than 5. Currently the DRAM allocation
+	 * uses huge pages only but user memory could have been allocated with
+	 * one of the two page sizes. Since this is a common code for all the
+	 * three cases, we need this hugs page check.
+	 */
+	if (is_dram_addr)
+		mmu_prop = &prop->dmmu;
+	else if (page_size == prop->pmmu_huge.page_size)
+		mmu_prop = &prop->pmmu_huge;
+	else
+		mmu_prop = &prop->pmmu;
+
+	hop_last = hl_mmu_v2_get_last_hop(mmu_prop, page_size);
+	if (hop_last <= 0) {
+		dev_err(ctx->hdev->dev, "Invalid last HOP %d\n", hop_last);
+		return -EFAULT;
+	}
+
+	scrambled_virt_addr = hdev->asic_funcs->scramble_addr(hdev, virt_addr);
+	scrambled_phys_addr = hdev->asic_funcs->scramble_addr(hdev, phys_addr);
+
+	for (i = 0 ; i <= hop_last ; i++) {
+
+		if (i == 0)
+			hops_pgt_info[i] = hl_mmu_v2_hr_get_hop0_pgt_info(ctx);
+		else
+			hops_pgt_info[i] = hl_mmu_hr_get_alloc_next_hop(ctx,
+							&ctx->hdev->mmu_priv.hr,
+							&ctx->hdev->mmu_func[MMU_HR_PGT].hr_funcs,
+							mmu_prop, curr_pte, &hop_new[i]);
+		if (!hops_pgt_info[i])
+			goto err;
+
+		hop_pte_phys_addr[i] = hl_mmu_get_hop_pte_phys_addr(ctx, mmu_prop, i,
+									hops_pgt_info[i]->phys_addr,
+									scrambled_virt_addr);
+		curr_pte = *(u64 *) (uintptr_t) hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
+							hop_pte_phys_addr[i],
+							ctx->hdev->asic_prop.mmu_hop_table_size);
+	}
+
+	if (curr_pte & PAGE_PRESENT_MASK) {
+		dev_err(hdev->dev, "mapping already exists for virt_addr 0x%llx\n",
+									scrambled_virt_addr);
+
+		for (i = 0 ; i <= hop_last ; i++)
+			dev_dbg(hdev->dev, "hop%d pte: 0x%llx (0x%llx)\n",
+					i,
+					*(u64 *) (uintptr_t)
+					hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
+							hop_pte_phys_addr[i],
+							ctx->hdev->asic_prop.mmu_hop_table_size),
+					hop_pte_phys_addr[i]);
+		rc = -EINVAL;
+		goto err;
+	}
+
+	curr_pte = (scrambled_phys_addr & HOP_PHYS_ADDR_MASK) | mmu_prop->last_mask
+			| PAGE_PRESENT_MASK;
+
+	/* Write the PTEs */
+	hl_mmu_hr_write_pte(ctx, hops_pgt_info[hop_last], hop_pte_phys_addr[hop_last], curr_pte,
+							ctx->hdev->asic_prop.mmu_hop_table_size);
+
+	/* for each new hop, add its address to the table of previous-hop */
+	for (i = 1 ; i <= hop_last ; i++) {
+		if (hop_new[i]) {
+			curr_pte = (hops_pgt_info[i]->phys_addr & HOP_PHYS_ADDR_MASK) |
+							PAGE_PRESENT_MASK;
+			hl_mmu_hr_write_pte(ctx, hops_pgt_info[i - 1], hop_pte_phys_addr[i - 1],
+						curr_pte, ctx->hdev->asic_prop.mmu_hop_table_size);
+			if (i - 1)
+				hl_mmu_hr_get_pte(ctx, &ctx->hdev->mmu_func[MMU_HR_PGT].hr_funcs,
+								hops_pgt_info[i - 1]->phys_addr);
+		}
+	}
+
+	hl_mmu_hr_get_pte(ctx, &ctx->hdev->mmu_func[MMU_HR_PGT].hr_funcs,
+						hops_pgt_info[hop_last]->phys_addr);
+
+	return 0;
+
+err:
+	for (i = 1 ; i <= hop_last ; i++)
+		if (hop_new[i] && hops_pgt_info[i])
+			hl_mmu_hr_free_hop_remove_pgt(hops_pgt_info[i], &ctx->hdev->mmu_priv.hr,
+							ctx->hdev->asic_prop.mmu_hop_table_size);
+
+	return rc;
+}
+
+/*
+ * hl_mmu_v2_swap_out - marks all mapping of the given ctx as swapped out
+ *
+ * @ctx: pointer to the context structure
+ *
+ */
+static void hl_mmu_v2_hr_swap_out(struct hl_ctx *ctx)
+{
+
+}
+
+/*
+ * hl_mmu_v2_swap_in - marks all mapping of the given ctx as swapped in
+ *
+ * @ctx: pointer to the context structure
+ *
+ */
+static void hl_mmu_v2_hr_swap_in(struct hl_ctx *ctx)
+{
+
+}
+
+static int hl_mmu_v2_hr_get_tlb_mapping_params(struct hl_device *hdev,
+							struct hl_mmu_properties **mmu_prop,
+							struct hl_mmu_hop_info *hops,
+							u64 virt_addr, bool *is_huge)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	bool is_dram_addr, is_pmmu_addr, is_pmmu_h_addr;
+
+	is_dram_addr = hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
+						prop->dmmu.start_addr,
+						prop->dmmu.end_addr);
+	is_pmmu_addr = hl_mem_area_inside_range(virt_addr, prop->pmmu.page_size,
+						prop->pmmu.start_addr,
+						prop->pmmu.end_addr);
+	is_pmmu_h_addr = hl_mem_area_inside_range(virt_addr,
+						prop->pmmu_huge.page_size,
+						prop->pmmu_huge.start_addr,
+						prop->pmmu_huge.end_addr);
+	if (is_dram_addr) {
+		*mmu_prop = &prop->dmmu;
+		*is_huge = true;
+		hops->range_type = HL_VA_RANGE_TYPE_DRAM;
+	} else if (is_pmmu_addr) {
+		*mmu_prop = &prop->pmmu;
+		*is_huge = false;
+		hops->range_type = HL_VA_RANGE_TYPE_HOST;
+	} else if (is_pmmu_h_addr) {
+		*mmu_prop = &prop->pmmu_huge;
+		*is_huge = true;
+		hops->range_type = HL_VA_RANGE_TYPE_HOST_HUGE;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hl_mmu_v2_hr_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
+					struct hl_mmu_hop_info *hops)
+{
+	return hl_mmu_hr_get_tlb_info(ctx, virt_addr, hops,
+					&ctx->hdev->mmu_func[MMU_HR_PGT].hr_funcs);
+}
+
+/*
+ * hl_mmu_v2_prepare - prepare mmu_if for working with mmu v2
+ *
+ * @hdev: pointer to the device structure
+ * @mmu_if: pointer to the mmu interface structure
+ */
+void hl_mmu_v2_hr_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu)
+{
+	mmu->init = hl_mmu_v2_hr_init;
+	mmu->fini = hl_mmu_v2_hr_fini;
+	mmu->ctx_init = hl_mmu_v2_hr_ctx_init;
+	mmu->ctx_fini = hl_mmu_v2_hr_ctx_fini;
+	mmu->map = _hl_mmu_v2_hr_map;
+	mmu->unmap = _hl_mmu_v2_hr_unmap;
+	mmu->flush = hl_mmu_hr_flush;
+	mmu->swap_out = hl_mmu_v2_hr_swap_out;
+	mmu->swap_in = hl_mmu_v2_hr_swap_in;
+	mmu->get_tlb_info = hl_mmu_v2_hr_get_tlb_info;
+	mmu->hr_funcs.get_hop0_pgt_info = hl_mmu_v2_hr_get_hop0_pgt_info;
+	mmu->hr_funcs.get_pgt_info = hl_mmu_v2_hr_get_pgt_info;
+	mmu->hr_funcs.add_pgt_info = hl_mmu_v2_hr_add_pgt_info;
+	mmu->hr_funcs.get_tlb_mapping_params = hl_mmu_v2_hr_get_tlb_mapping_params;
+}
-- 
2.25.1

