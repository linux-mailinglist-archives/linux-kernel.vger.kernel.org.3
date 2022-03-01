Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4354C8ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiCAPTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiCAPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:19:31 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7A36B59;
        Tue,  1 Mar 2022 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646147930; x=1677683930;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=DpUbeK9rCW5mmGDlaG3iZGepsQWpQLt/Ci1wOJJLfR4=;
  b=clytCVi4FrVsZ0M99M75VlaeESMKaLjOyD97uQf1m7S3YuU3H0k9okO4
   FJU9UbPgqZzUVTWGNlSgImBWHqHO3DvUa0ZtD9XbsM6taiTl1uRItBIyT
   j7MeRJVRkppRO3r2n+sxj423eox7ZWkvxD3Hke/Jv1OauDX47e7UuLFjT
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Mar 2022 07:18:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:18:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 07:18:48 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 07:18:45 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V5 1/2] soc: qcom: smem: map only partitions used by local HOST
Date:   Tue, 1 Mar 2022 20:48:32 +0530
Message-ID: <1646147913-15791-1-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMEM driver is IO mapping complete region and CPU is doing a speculative
read into a partition where local HOST does not have permission resulting
in a NOC error.

Map only those partitions which are accessibly to local HOST.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
---
 drivers/soc/qcom/smem.c | 226 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 164 insertions(+), 62 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e2057d8..2dde9b6 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -195,6 +195,20 @@ struct smem_partition_header {
 	__le32 reserved[3];
 };
 
+/**
+ * struct smem_partition - describes smem partition
+ * @virt_base:	starting virtual address of partition
+ * @phys_base:	starting physical address of partition
+ * @cacheline:	alignment for "cached" entries
+ * @size:	size of partition
+ */
+struct smem_partition {
+	void __iomem *virt_base;
+	phys_addr_t phys_base;
+	size_t cacheline;
+	size_t size;
+};
+
 static const u8 SMEM_PART_MAGIC[] = { 0x24, 0x50, 0x52, 0x54 };
 
 /**
@@ -250,11 +264,9 @@ struct smem_region {
  * struct qcom_smem - device data for the smem device
  * @dev:	device pointer
  * @hwlock:	reference to a hwspinlock
- * @global_partition:	pointer to global partition when in use
- * @global_cacheline:	cacheline size for global partition
- * @partitions:	list of pointers to partitions affecting the current
- *		processor/host
- * @cacheline:	list of cacheline sizes for each host
+ * @ptable: virtual base of partition table
+ * @global_partition: describes for global partition when in use
+ * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
  * @num_regions: number of @regions
@@ -265,12 +277,11 @@ struct qcom_smem {
 
 	struct hwspinlock *hwlock;
 
-	struct smem_partition_header *global_partition;
-	size_t global_cacheline;
-	struct smem_partition_header *partitions[SMEM_HOST_COUNT];
-	size_t cacheline[SMEM_HOST_COUNT];
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct smem_ptable *ptable;
+	struct smem_partition global_partition;
+	struct smem_partition partitions[SMEM_HOST_COUNT];
 
 	unsigned num_regions;
 	struct smem_region regions[];
@@ -348,14 +359,17 @@ static struct qcom_smem *__smem;
 #define HWSPINLOCK_TIMEOUT	1000
 
 static int qcom_smem_alloc_private(struct qcom_smem *smem,
-				   struct smem_partition_header *phdr,
+				   struct smem_partition *part,
 				   unsigned item,
 				   size_t size)
 {
 	struct smem_private_entry *hdr, *end;
+	struct smem_partition_header *phdr;
 	size_t alloc_size;
 	void *cached;
 
+	phdr = (struct smem_partition_header __force *)part->virt_base;
+
 	hdr = phdr_to_first_uncached_entry(phdr);
 	end = phdr_to_last_uncached_entry(phdr);
 	cached = phdr_to_last_cached_entry(phdr);
@@ -442,7 +456,7 @@ static int qcom_smem_alloc_global(struct qcom_smem *smem,
  */
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 {
-	struct smem_partition_header *phdr;
+	struct smem_partition *part;
 	unsigned long flags;
 	int ret;
 
@@ -464,12 +478,12 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 	if (ret)
 		return ret;
 
-	if (host < SMEM_HOST_COUNT && __smem->partitions[host]) {
-		phdr = __smem->partitions[host];
-		ret = qcom_smem_alloc_private(__smem, phdr, item, size);
-	} else if (__smem->global_partition) {
-		phdr = __smem->global_partition;
-		ret = qcom_smem_alloc_private(__smem, phdr, item, size);
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
+		part = &__smem->partitions[host];
+		ret = qcom_smem_alloc_private(__smem, part, item, size);
+	} else if (__smem->global_partition.virt_base) {
+		part = &__smem->global_partition;
+		ret = qcom_smem_alloc_private(__smem, part, item, size);
 	} else {
 		ret = qcom_smem_alloc_global(__smem, item, size);
 	}
@@ -511,12 +525,14 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 }
 
 static void *qcom_smem_get_private(struct qcom_smem *smem,
-				   struct smem_partition_header *phdr,
-				   size_t cacheline,
+				   struct smem_partition *part,
 				   unsigned item,
 				   size_t *size)
 {
 	struct smem_private_entry *e, *end;
+	struct smem_partition_header *phdr;
+
+	phdr = (struct smem_partition_header __force *)part->virt_base;
 
 	e = phdr_to_first_uncached_entry(phdr);
 	end = phdr_to_last_uncached_entry(phdr);
@@ -538,7 +554,7 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 
 	/* Item was not found in the uncached list, search the cached list */
 
-	e = phdr_to_first_cached_entry(phdr, cacheline);
+	e = phdr_to_first_cached_entry(phdr, part->cacheline);
 	end = phdr_to_last_cached_entry(phdr);
 
 	while (e > end) {
@@ -553,7 +569,7 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 			return cached_entry_to_item(e);
 		}
 
-		e = cached_entry_next(e, cacheline);
+		e = cached_entry_next(e, part->cacheline);
 	}
 
 	return ERR_PTR(-ENOENT);
@@ -576,9 +592,8 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
  */
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 {
-	struct smem_partition_header *phdr;
+	struct smem_partition *part;
 	unsigned long flags;
-	size_t cacheln;
 	int ret;
 	void *ptr = ERR_PTR(-EPROBE_DEFER);
 
@@ -594,14 +609,12 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (host < SMEM_HOST_COUNT && __smem->partitions[host]) {
-		phdr = __smem->partitions[host];
-		cacheln = __smem->cacheline[host];
-		ptr = qcom_smem_get_private(__smem, phdr, cacheln, item, size);
-	} else if (__smem->global_partition) {
-		phdr = __smem->global_partition;
-		cacheln = __smem->global_cacheline;
-		ptr = qcom_smem_get_private(__smem, phdr, cacheln, item, size);
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
+		part = &__smem->partitions[host];
+		ptr = qcom_smem_get_private(__smem, part, item, size);
+	} else if (__smem->global_partition.virt_base) {
+		part = &__smem->global_partition;
+		ptr = qcom_smem_get_private(__smem, part, item, size);
 	} else {
 		ptr = qcom_smem_get_global(__smem, item, size);
 	}
@@ -622,6 +635,7 @@ EXPORT_SYMBOL(qcom_smem_get);
  */
 int qcom_smem_get_free_space(unsigned host)
 {
+	struct smem_partition *part;
 	struct smem_partition_header *phdr;
 	struct smem_header *header;
 	unsigned ret;
@@ -629,12 +643,14 @@ int qcom_smem_get_free_space(unsigned host)
 	if (!__smem)
 		return -EPROBE_DEFER;
 
-	if (host < SMEM_HOST_COUNT && __smem->partitions[host]) {
-		phdr = __smem->partitions[host];
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
+		part = &__smem->partitions[host];
+		phdr = part->virt_base;
 		ret = le32_to_cpu(phdr->offset_free_cached) -
 		      le32_to_cpu(phdr->offset_free_uncached);
-	} else if (__smem->global_partition) {
-		phdr = __smem->global_partition;
+	} else if (__smem->global_partition.virt_base) {
+		part = &__smem->global_partition;
+		phdr = part->virt_base;
 		ret = le32_to_cpu(phdr->offset_free_cached) -
 		      le32_to_cpu(phdr->offset_free_uncached);
 	} else {
@@ -646,6 +662,11 @@ int qcom_smem_get_free_space(unsigned host)
 }
 EXPORT_SYMBOL(qcom_smem_get_free_space);
 
+static bool addr_in_range(void __iomem *base, size_t size, void *addr)
+{
+	return base && (addr >= base && addr < base + size);
+}
+
 /**
  * qcom_smem_virt_to_phys() - return the physical address associated
  * with an smem item pointer (previously returned by qcom_smem_get()
@@ -655,17 +676,36 @@ EXPORT_SYMBOL(qcom_smem_get_free_space);
  */
 phys_addr_t qcom_smem_virt_to_phys(void *p)
 {
-	unsigned i;
+	struct smem_partition *part;
+	struct smem_region *area;
+	u64 offset;
+	u32 i;
+
+	for (i = 0; i < SMEM_HOST_COUNT; i++) {
+		part = &__smem->partitions[i];
+
+		if (addr_in_range(part->virt_base, part->size, p)) {
+			offset = p - part->virt_base;
+
+			return (phys_addr_t)part->phys_base + offset;
+		}
+	}
+
+	part = &__smem->global_partition;
+
+	if (addr_in_range(part->virt_base, part->size, p)) {
+		offset = p - part->virt_base;
+
+		return (phys_addr_t)part->phys_base + offset;
+	}
 
 	for (i = 0; i < __smem->num_regions; i++) {
-		struct smem_region *region = &__smem->regions[i];
+		area = &__smem->regions[i];
 
-		if (p < region->virt_base)
-			continue;
-		if (p < region->virt_base + region->size) {
-			u64 offset = p - region->virt_base;
+		if (addr_in_range(area->virt_base, area->size, p)) {
+			offset = p - area->virt_base;
 
-			return region->aux_base + offset;
+			return (phys_addr_t)area->aux_base + offset;
 		}
 	}
 
@@ -689,7 +729,7 @@ static struct smem_ptable *qcom_smem_get_ptable(struct qcom_smem *smem)
 	struct smem_ptable *ptable;
 	u32 version;
 
-	ptable = smem->regions[0].virt_base + smem->regions[0].size - SZ_4K;
+	ptable = smem->ptable;
 	if (memcmp(ptable->magic, SMEM_PTABLE_MAGIC, sizeof(ptable->magic)))
 		return ERR_PTR(-ENOENT);
 
@@ -728,9 +768,14 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		struct smem_ptable_entry *entry, u16 host0, u16 host1)
 {
 	struct smem_partition_header *header;
+	u32 phys_addr;
 	u32 size;
 
-	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
+	phys_addr = smem->regions[0].aux_base + le32_to_cpu(entry->offset);
+	header = devm_ioremap_wc(smem->dev, phys_addr, le32_to_cpu(entry->size));
+
+	if (!header)
+		return NULL;
 
 	if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
 		dev_err(smem->dev, "bad partition magic %4ph\n", header->magic);
@@ -772,7 +817,7 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	bool found = false;
 	int i;
 
-	if (smem->global_partition) {
+	if (smem->global_partition.virt_base) {
 		dev_err(smem->dev, "Already found the global partition\n");
 		return -EINVAL;
 	}
@@ -807,8 +852,11 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	if (!header)
 		return -EINVAL;
 
-	smem->global_partition = header;
-	smem->global_cacheline = le32_to_cpu(entry->cacheline);
+	smem->global_partition.virt_base = (void __iomem *)header;
+	smem->global_partition.phys_base = smem->regions[0].aux_base +
+								le32_to_cpu(entry->offset);
+	smem->global_partition.size = le32_to_cpu(entry->size);
+	smem->global_partition.cacheline = le32_to_cpu(entry->cacheline);
 
 	return 0;
 }
@@ -848,7 +896,7 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 			return -EINVAL;
 		}
 
-		if (smem->partitions[remote_host]) {
+		if (smem->partitions[remote_host].virt_base) {
 			dev_err(smem->dev, "duplicate host %hu\n", remote_host);
 			return -EINVAL;
 		}
@@ -857,13 +905,47 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 		if (!header)
 			return -EINVAL;
 
-		smem->partitions[remote_host] = header;
-		smem->cacheline[remote_host] = le32_to_cpu(entry->cacheline);
+		smem->partitions[remote_host].virt_base = (void __iomem *)header;
+		smem->partitions[remote_host].phys_base = smem->regions[0].aux_base +
+										le32_to_cpu(entry->offset);
+		smem->partitions[remote_host].size = le32_to_cpu(entry->size);
+		smem->partitions[remote_host].cacheline = le32_to_cpu(entry->cacheline);
 	}
 
 	return 0;
 }
 
+static int qcom_smem_map_toc(struct qcom_smem *smem, struct smem_region *region)
+{
+	u32 ptable_start;
+
+	/* map starting 4K for smem header */
+	region->virt_base = devm_ioremap_wc(smem->dev, region->aux_base, SZ_4K);
+	ptable_start = region->aux_base + region->size - SZ_4K;
+	/* map last 4k for toc */
+	smem->ptable = devm_ioremap_wc(smem->dev, ptable_start, SZ_4K);
+
+	if (!region->virt_base || !smem->ptable)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
+{
+	u32 phys_addr;
+
+	phys_addr = smem->regions[0].aux_base;
+
+	smem->regions[0].size = size;
+	smem->regions[0].virt_base = devm_ioremap_wc(smem->dev, phys_addr, size);
+
+	if (!smem->regions[0].virt_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int qcom_smem_resolve_mem(struct qcom_smem *smem, const char *name,
 				 struct smem_region *region)
 {
@@ -894,10 +976,12 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	struct smem_header *header;
 	struct reserved_mem *rmem;
 	struct qcom_smem *smem;
+	unsigned long flags;
 	size_t array_size;
 	int num_regions;
 	int hwlock_id;
 	u32 version;
+	u32 size;
 	int ret;
 	int i;
 
@@ -933,7 +1017,12 @@ static int qcom_smem_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	for (i = 0; i < num_regions; i++) {
+
+	ret = qcom_smem_map_toc(smem, &smem->regions[0]);
+ 	if (ret)
+ 		return ret;
+
+	for (i = 1; i < num_regions; i++) {
 		smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,
 							     smem->regions[i].aux_base,
 							     smem->regions[i].size);
@@ -950,7 +1039,30 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
+	if (hwlock_id < 0) {
+		if (hwlock_id != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
+		return hwlock_id;
+	}
+
+	smem->hwlock = hwspin_lock_request_specific(hwlock_id);
+	if (!smem->hwlock)
+		return -ENXIO;
+
+	ret = hwspin_lock_timeout_irqsave(smem->hwlock, HWSPINLOCK_TIMEOUT, &flags);
+	if (ret)
+		return ret;
+	size = readl_relaxed(&header->available) + readl_relaxed(&header->free_offset);
+	hwspin_unlock_irqrestore(smem->hwlock, &flags);
+
 	version = qcom_smem_get_sbl_version(smem);
+	/*
+	 * smem header mapping is required only in heap version scheme, so unmap
+	 * it here. It will be remapped in qcom_smem_map_global() when whole
+	 * partition is mapped again.
+	 */
+	devm_iounmap(smem->dev, smem->regions[0].virt_base);
 	switch (version >> 16) {
 	case SMEM_GLOBAL_PART_VERSION:
 		ret = qcom_smem_set_global_partition(smem);
@@ -959,6 +1071,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		smem->item_count = qcom_smem_get_item_count(smem);
 		break;
 	case SMEM_GLOBAL_HEAP_VERSION:
+		qcom_smem_map_global(smem, size);
 		smem->item_count = SMEM_ITEM_COUNT;
 		break;
 	default:
@@ -971,17 +1084,6 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -ENOENT)
 		return ret;
 
-	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
-	if (hwlock_id < 0) {
-		if (hwlock_id != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
-		return hwlock_id;
-	}
-
-	smem->hwlock = hwspin_lock_request_specific(hwlock_id);
-	if (!smem->hwlock)
-		return -ENXIO;
-
 	__smem = smem;
 
 	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
-- 
2.7.4

