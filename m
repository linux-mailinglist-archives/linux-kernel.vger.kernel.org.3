Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DB5A59AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH3DCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiH3DBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:01:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E3719C227;
        Mon, 29 Aug 2022 20:01:46 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72uTfQ1jmS0MAA--.50840S3;
        Tue, 30 Aug 2022 11:01:39 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH V3 1/2] ACPI / scan: Support multiple dma windows with different offsets
Date:   Tue, 30 Aug 2022 11:01:38 +0800
Message-Id: <20220830030139.29899-2-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220830030139.29899-1-lvjianmin@loongson.cn>
References: <20220830030139.29899-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72uTfQ1jmS0MAA--.50840S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWkKFyktryfGF48Zw1UJrb_yoW3Cw1rp3
        Za9FyfGr47trsrWrs3Zw4rZ3W5Z3sY93yxXrW7G3sakryq9r1UJFsrA340ka4rAFyqkF4x
        ZF4DtFyrCF4UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9I1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        GVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Av
        z4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
        JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
        IYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DT, of_dma_get_range returns bus_dma_region typed dma regions,
which makes multiple dma windows with different offset available
for translation between dma address and cpu address.

But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
causing no path for setting dev->dma_range_map conveniently. So the
patch changes acpi_dma_get_range and returns bus_dma_region typed
dma regions according to of_dma_get_range.

After changing acpi_dma_get_range, acpi_arch_dma_setup is changed for
ARM64, where original dma_addr and size are removed as these
arguments are now redundant, and pass 0 and U64_MAX for dma_base
and size of arch_setup_dma_ops, so this is a simplification consistent
with what other ACPI architectures also pass to iommu_setup_dma_ops().

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/acpi/arm64/dma.c | 29 ++++++++++++++++----------
 drivers/acpi/scan.c      | 53 +++++++++++++++++++++---------------------------
 include/acpi/acpi_bus.h  |  3 +--
 include/linux/acpi.h     |  7 +++----
 4 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
index f16739a..1ef8e7d 100644
--- a/drivers/acpi/arm64/dma.c
+++ b/drivers/acpi/arm64/dma.c
@@ -4,11 +4,12 @@
 #include <linux/device.h>
 #include <linux/dma-direct.h>
 
-void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
+void acpi_arch_dma_setup(struct device *dev)
 {
 	int ret;
 	u64 end, mask;
-	u64 dmaaddr = 0, size = 0, offset = 0;
+	u64 size = 0;
+	const struct bus_dma_region *map = NULL;
 
 	/*
 	 * If @dev is expected to be DMA-capable then the bus code that created
@@ -26,25 +27,31 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	else
 		size = 1ULL << 32;
 
-	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
+	ret = acpi_dma_get_range(dev, &map);
+	if (!ret && map) {
+		const struct bus_dma_region *r = map;
+
+		for (end = 0; r->size; r++) {
+			if (r->dma_start + r->size - 1 > end)
+				end = r->dma_start + r->size - 1;
+		}
+
+		size = end + 1;
+		dev->dma_range_map = map;
+	}
+
 	if (ret == -ENODEV)
 		ret = iort_dma_get_ranges(dev, &size);
+
 	if (!ret) {
 		/*
 		 * Limit coherent and dma mask based on size retrieved from
 		 * firmware.
 		 */
-		end = dmaaddr + size - 1;
+		end = size - 1;
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
 		dev->bus_dma_limit = end;
 		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
 		*dev->dma_mask = min(*dev->dma_mask, mask);
 	}
-
-	*dma_addr = dmaaddr;
-	*dma_size = size;
-
-	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
-
-	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 762b61f..8c0c2ca 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -20,6 +20,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
 #include <linux/crc32.h>
+#include <linux/dma-direct.h>
 
 #include "internal.h"
 
@@ -1482,25 +1483,21 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
  * acpi_dma_get_range() - Get device DMA parameters.
  *
  * @dev: device to configure
- * @dma_addr: pointer device DMA address result
- * @offset: pointer to the DMA offset result
- * @size: pointer to DMA range size result
+ * @map: pointer to DMA ranges result
  *
- * Evaluate DMA regions and return respectively DMA region start, offset
- * and size in dma_addr, offset and size on parsing success; it does not
- * update the passed in values on failure.
+ * Evaluate DMA regions and return pointer to DMA regions on
+ * parsing success; it does not update the passed in values on failure.
  *
  * Return 0 on success, < 0 on failure.
  */
-int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
-		       u64 *size)
+int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 {
 	struct acpi_device *adev;
 	LIST_HEAD(list);
 	struct resource_entry *rentry;
 	int ret;
 	struct device *dma_dev = dev;
-	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
+	struct bus_dma_region *r;
 
 	/*
 	 * Walk the device tree chasing an ACPI companion with a _DMA
@@ -1525,31 +1522,28 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 
 	ret = acpi_dev_get_dma_resources(adev, &list);
 	if (ret > 0) {
+		r = kcalloc(ret + 1, sizeof(*r), GFP_KERNEL);
+		if (!r) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		*map = r;
+
 		list_for_each_entry(rentry, &list, node) {
-			if (dma_offset && rentry->offset != dma_offset) {
+			if (rentry->res->start >= rentry->res->end) {
 				ret = -EINVAL;
-				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
+				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
 				goto out;
 			}
-			dma_offset = rentry->offset;
 
-			/* Take lower and upper limits */
-			if (rentry->res->start < dma_start)
-				dma_start = rentry->res->start;
-			if (rentry->res->end > dma_end)
-				dma_end = rentry->res->end;
-		}
-
-		if (dma_start >= dma_end) {
-			ret = -EINVAL;
-			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
-			goto out;
+			r->cpu_start = rentry->res->start;
+			r->dma_start = rentry->res->start - rentry->offset;
+			r->size = rentry->res->end - rentry->res->start + 1;
+			r->offset = rentry->offset;
+			r++;
 		}
 
-		*dma_addr = dma_start - dma_offset;
-		len = dma_end - dma_start;
-		*size = max(len, len + 1);
-		*offset = dma_offset;
 	}
  out:
 	acpi_dev_free_resource_list(&list);
@@ -1639,20 +1633,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			  const u32 *input_id)
 {
 	const struct iommu_ops *iommu;
-	u64 dma_addr = 0, size = 0;
 
 	if (attr == DEV_DMA_NOT_SUPPORTED) {
 		set_dma_ops(dev, &dma_dummy_ops);
 		return 0;
 	}
 
-	acpi_arch_dma_setup(dev, &dma_addr, &size);
+	acpi_arch_dma_setup(dev);
 
 	iommu = acpi_iommu_configure_id(dev, input_id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	arch_setup_dma_ops(dev, dma_addr, size,
+	arch_setup_dma_ops(dev, 0, U64_MAX,
 				iommu, attr == DEV_DMA_COHERENT);
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0dc1ea0b..e106073 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -611,8 +611,7 @@ struct acpi_pci_root {
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode,
 			   const struct iommu_ops *ops);
-int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
-		       u64 *size);
+int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
 static inline int acpi_dma_configure(struct device *dev,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 44975c1..34e0545 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -280,12 +280,12 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
 
 #ifdef CONFIG_ARM64
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
-void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
+void acpi_arch_dma_setup(struct device *dev);
 #else
 static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
 static inline void
-acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
+acpi_arch_dma_setup(struct device *dev) { }
 #endif
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
@@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
-static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
-				     u64 *offset, u64 *size)
+static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
-- 
1.8.3.1

