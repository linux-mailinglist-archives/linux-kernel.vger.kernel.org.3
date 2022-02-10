Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB84B1139
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbiBJPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:05:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiBJPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:05:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA4EA1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644505543; x=1676041543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvDOY79Q2gjpg6f1x/4HPyiA0Mvu6fmD5T9PEpYf1WM=;
  b=ReoiDKsAcj3oQXaODosM/v/0j9Qyhv9mTPKkBPYnUVeHi0JfyTFBFln5
   vfBIQWHpZrTh8Mw88b333voHfGTOmcsuUitRTcj7Y7qEFoDMoj/llBFQX
   v+hts0a8tTiZ/m+nzM+Vz1w6dxAyhu2uLaNY4fk6gkhUcc1LpQ7gEihBo
   gzm3qDR5Tf6bO3z+YtOLEpemG4V0nuMjL5lp+aiLTWhVnhBAtlDzPFmWE
   rzGUaxZ5G4v+G8HEvZeQB/u/idbagAewoSVv3rHuIN8gwkmnS0DuO6olj
   NyWzp59YmobHhMAx1rWw5R9KqpFLFBUMnyq3oxrkq5MKtJ6V1sciwI1BM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230153250"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230153250"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:05:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500422639"
Received: from barabano-mobl.ccr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.41.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:05:39 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH v2 4/9] ASoC: SOF: Split up utils.c into sof-utils and iomem-utils
Date:   Thu, 10 Feb 2022 17:05:20 +0200
Message-Id: <20220210150525.30756-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210150525.30756-1-peter.ujfalusi@linux.intel.com>
References: <20220210150525.30756-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utils.c contains wrappers and implementation for accessing iomem mapped
regions and a single unrelated function to create a compressed page table
from snd_dma_buffer for firmware use.

The latter is used by the PCM and the dma trace code and it needs to be
moved to a generic source/header for the client conversion to be possible.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/Makefile                   |  5 +-
 sound/soc/sof/compress.c                 |  1 +
 sound/soc/sof/{utils.c => iomem-utils.c} | 61 +------------------
 sound/soc/sof/pcm.c                      |  1 +
 sound/soc/sof/sof-priv.h                 |  4 --
 sound/soc/sof/sof-utils.c                | 77 ++++++++++++++++++++++++
 sound/soc/sof/sof-utils.h                | 19 ++++++
 sound/soc/sof/trace.c                    |  1 +
 8 files changed, 104 insertions(+), 65 deletions(-)
 rename sound/soc/sof/{utils.c => iomem-utils.c} (59%)
 create mode 100644 sound/soc/sof/sof-utils.c
 create mode 100644 sound/soc/sof/sof-utils.h

diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
index 964b429146be..4b9fccacc2b7 100644
--- a/sound/soc/sof/Makefile
+++ b/sound/soc/sof/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 
 snd-sof-objs := core.o ops.o loader.o ipc.o pcm.o pm.o debug.o topology.o\
-		control.o trace.o utils.o sof-audio.o stream-ipc.o
+		control.o trace.o iomem-utils.o sof-audio.o stream-ipc.o
 
 snd-sof-$(CONFIG_SND_SOC_SOF_DEBUG_PROBES) += sof-probes.o
 snd-sof-$(CONFIG_SND_SOC_SOF_COMPRESS) += compress.o
@@ -12,9 +12,12 @@ snd-sof-of-objs := sof-of-dev.o
 
 snd-sof-nocodec-objs := nocodec.o
 
+snd-sof-utils-objs := sof-utils.o
+
 obj-$(CONFIG_SND_SOC_SOF) += snd-sof.o
 obj-$(CONFIG_SND_SOC_SOF_NOCODEC) += snd-sof-nocodec.o
 
+obj-$(CONFIG_SND_SOC_SOF) += snd-sof-utils.o
 
 obj-$(CONFIG_SND_SOC_SOF_ACPI_DEV) += snd-sof-acpi.o
 obj-$(CONFIG_SND_SOC_SOF_OF_DEV) += snd-sof-of.o
diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 91a9c95929cd..2137d1d65dd9 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -9,6 +9,7 @@
 #include <sound/compress_driver.h>
 #include "sof-audio.h"
 #include "sof-priv.h"
+#include "sof-utils.h"
 
 static void sof_set_transferred_bytes(struct snd_compr_tstamp *tstamp,
 				      u64 host_pos, u64 buffer_size)
diff --git a/sound/soc/sof/utils.c b/sound/soc/sof/iomem-utils.c
similarity index 59%
rename from sound/soc/sof/utils.c
rename to sound/soc/sof/iomem-utils.c
index 66fa6602fb67..3f57f6cf6542 100644
--- a/sound/soc/sof/utils.c
+++ b/sound/soc/sof/iomem-utils.c
@@ -3,7 +3,7 @@
 // This file is provided under a dual BSD/GPLv2 license.  When using or
 // redistributing this file, you may do so under either license.
 //
-// Copyright(c) 2018 Intel Corporation. All rights reserved.
+// Copyright(c) 2018-2022 Intel Corporation. All rights reserved.
 //
 // Author: Keyon Jie <yang.jie@linux.intel.com>
 //
@@ -125,62 +125,3 @@ int sof_block_read(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_type,
 	return 0;
 }
 EXPORT_SYMBOL(sof_block_read);
-
-/*
- * Generic buffer page table creation.
- * Take the each physical page address and drop the least significant unused
- * bits from each (based on PAGE_SIZE). Then pack valid page address bits
- * into compressed page table.
- */
-
-int snd_sof_create_page_table(struct device *dev,
-			      struct snd_dma_buffer *dmab,
-			      unsigned char *page_table, size_t size)
-{
-	int i, pages;
-
-	pages = snd_sgbuf_aligned_pages(size);
-
-	dev_dbg(dev, "generating page table for %p size 0x%zx pages %d\n",
-		dmab->area, size, pages);
-
-	for (i = 0; i < pages; i++) {
-		/*
-		 * The number of valid address bits for each page is 20.
-		 * idx determines the byte position within page_table
-		 * where the current page's address is stored
-		 * in the compressed page_table.
-		 * This can be calculated by multiplying the page number by 2.5.
-		 */
-		u32 idx = (5 * i) >> 1;
-		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >> PAGE_SHIFT;
-		u8 *pg_table;
-
-		dev_vdbg(dev, "pfn i %i idx %d pfn %x\n", i, idx, pfn);
-
-		pg_table = (u8 *)(page_table + idx);
-
-		/*
-		 * pagetable compression:
-		 * byte 0     byte 1     byte 2     byte 3     byte 4     byte 5
-		 * ___________pfn 0__________ __________pfn 1___________  _pfn 2...
-		 * .... ....  .... ....  .... ....  .... ....  .... ....  ....
-		 * It is created by:
-		 * 1. set current location to 0, PFN index i to 0
-		 * 2. put pfn[i] at current location in Little Endian byte order
-		 * 3. calculate an intermediate value as
-		 *    x = (pfn[i+1] << 4) | (pfn[i] & 0xf)
-		 * 4. put x at offset (current location + 2) in LE byte order
-		 * 5. increment current location by 5 bytes, increment i by 2
-		 * 6. continue to (2)
-		 */
-		if (i & 1)
-			put_unaligned_le32((pg_table[0] & 0xf) | pfn << 4,
-					   pg_table);
-		else
-			put_unaligned_le32(pfn, pg_table);
-	}
-
-	return pages;
-}
-EXPORT_SYMBOL(snd_sof_create_page_table);
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 37fb8e6cd493..62cb61655761 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -19,6 +19,7 @@
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_PROBES)
 #include "sof-probes.h"
 #endif
+#include "sof-utils.h"
 
 /* Create DMA buffer page table for DSP */
 static int create_page_table(struct snd_soc_component *component,
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 2e474048d708..27d2f3ca2f06 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -502,10 +502,6 @@ void snd_sof_complete(struct device *dev);
 
 void snd_sof_new_platform_drv(struct snd_sof_dev *sdev);
 
-int snd_sof_create_page_table(struct device *dev,
-			      struct snd_dma_buffer *dmab,
-			      unsigned char *page_table, size_t size);
-
 /*
  * Firmware loading.
  */
diff --git a/sound/soc/sof/sof-utils.c b/sound/soc/sof/sof-utils.c
new file mode 100644
index 000000000000..a3300ecee062
--- /dev/null
+++ b/sound/soc/sof/sof-utils.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018-2022 Intel Corporation. All rights reserved.
+//
+// Author: Keyon Jie <yang.jie@linux.intel.com>
+//
+
+#include <asm/unaligned.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/device.h>
+#include <sound/memalloc.h>
+#include <linux/module.h>
+#include "sof-utils.h"
+
+/*
+ * Generic buffer page table creation.
+ * Take the each physical page address and drop the least significant unused
+ * bits from each (based on PAGE_SIZE). Then pack valid page address bits
+ * into compressed page table.
+ */
+
+int snd_sof_create_page_table(struct device *dev,
+			      struct snd_dma_buffer *dmab,
+			      unsigned char *page_table, size_t size)
+{
+	int i, pages;
+
+	pages = snd_sgbuf_aligned_pages(size);
+
+	dev_dbg(dev, "generating page table for %p size 0x%zx pages %d\n",
+		dmab->area, size, pages);
+
+	for (i = 0; i < pages; i++) {
+		/*
+		 * The number of valid address bits for each page is 20.
+		 * idx determines the byte position within page_table
+		 * where the current page's address is stored
+		 * in the compressed page_table.
+		 * This can be calculated by multiplying the page number by 2.5.
+		 */
+		u32 idx = (5 * i) >> 1;
+		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >> PAGE_SHIFT;
+		u8 *pg_table;
+
+		dev_vdbg(dev, "pfn i %i idx %d pfn %x\n", i, idx, pfn);
+
+		pg_table = (u8 *)(page_table + idx);
+
+		/*
+		 * pagetable compression:
+		 * byte 0     byte 1     byte 2     byte 3     byte 4     byte 5
+		 * ___________pfn 0__________ __________pfn 1___________  _pfn 2...
+		 * .... ....  .... ....  .... ....  .... ....  .... ....  ....
+		 * It is created by:
+		 * 1. set current location to 0, PFN index i to 0
+		 * 2. put pfn[i] at current location in Little Endian byte order
+		 * 3. calculate an intermediate value as
+		 *    x = (pfn[i+1] << 4) | (pfn[i] & 0xf)
+		 * 4. put x at offset (current location + 2) in LE byte order
+		 * 5. increment current location by 5 bytes, increment i by 2
+		 * 6. continue to (2)
+		 */
+		if (i & 1)
+			put_unaligned_le32((pg_table[0] & 0xf) | pfn << 4,
+					   pg_table);
+		else
+			put_unaligned_le32(pfn, pg_table);
+	}
+
+	return pages;
+}
+EXPORT_SYMBOL(snd_sof_create_page_table);
+
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/sof-utils.h b/sound/soc/sof/sof-utils.h
new file mode 100644
index 000000000000..6f902893807e
--- /dev/null
+++ b/sound/soc/sof/sof-utils.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2022 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __SOC_SOF_UTILS_H
+#define __SOC_SOF_UTILS_H
+
+struct snd_dma_buffer;
+struct device;
+
+int snd_sof_create_page_table(struct device *dev,
+			      struct snd_dma_buffer *dmab,
+			      unsigned char *page_table, size_t size);
+
+#endif
diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index 2335d0f06d42..104388c551cb 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -12,6 +12,7 @@
 #include <linux/sched/signal.h>
 #include "sof-priv.h"
 #include "ops.h"
+#include "sof-utils.h"
 
 #define TRACE_FILTER_ELEMENTS_PER_ENTRY 4
 #define TRACE_FILTER_MAX_CONFIG_STRING_LENGTH 1024
-- 
2.35.1

