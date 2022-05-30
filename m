Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A13538875
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbiE3VBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiE3VAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:00:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9891587
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p4so18488561lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgYTJywCKcz2eZ3BdKiVmZnlK+gFcRjkQ0C/gcc8wL0=;
        b=WPbadUUFeZwVP4k9WAfhTLe83VpVBG119TgUz++U+jcFCuUBznYGsIC2lzKm27XdmH
         yXFP5yObX14uURGpzK7F5mfOnsgB0r/BmzpoUM+jVBTGg80yZgw9XLdeLfgwp9ErLoVW
         Q1TnTWrqcB0sDwHHSjrR/52HWB1qz43VoDo1QHHh9ceNvr40y+w6erOOroKP7WNK9jCV
         dGTfhe/dXDLi/T7GIkeydYCCaMf+TjgeRFjPvJnOV+kHivKBp/t3pH1T36Vqg8+3uxjR
         MnAy+xzObuU1AJa9GbSqXq88uHtnxJw/NER+9Xb7clISz49J9BSIQt8o8DWDArCwlTH1
         WvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgYTJywCKcz2eZ3BdKiVmZnlK+gFcRjkQ0C/gcc8wL0=;
        b=78bJ8QPLiX73IvOZR+uYOefDZKCEij+TSTaEtfJ0TrNZ1WmWzGnlFbifklCNNHuZ/2
         VGqdrQPDcPBlx5BK1chUaSjfS/ivZYX/78Vm9LHXODuv0BVFEKWyBHwhZHDc2wTtJLE4
         xp9vAx9Bza38s6HtSYJTNLEhrseX58akZJIsXfozvt2bHcmXbLen4+fZ9a4QJrLxnSKg
         kfbEneglMR/USUEdE4BeHSNRH4JoFqH5JuNHk+fmHuv8EuhXY1NY8g7ZSUYSbnRoDy0X
         zN5NPv96pDAWWaLO5dxhA6UVnffRvRiz30OWGmwiSqlSzhAV/N0XfJ0MX1t8W/Wr8hX0
         68OA==
X-Gm-Message-State: AOAM533TjJfIrsqN6vy2DbfQML4NWqaPrSX9WBdQIxDfbVsbWeQWbCDN
        ptKBW30BlE93kG4bSdrdHn4qKjPNmm4=
X-Google-Smtp-Source: ABdhPJxg9WbJjJF17bN45E1W6bO0HJs4dzI7IisXFVPM5nHpQcExbUbGQhg/zR9oTx50h6uUKqfR1w==
X-Received: by 2002:a05:6512:20c9:b0:477:cc4f:b816 with SMTP id u9-20020a05651220c900b00477cc4fb816mr38993759lfr.521.1653944426468;
        Mon, 30 May 2022 14:00:26 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k21-20020a2ea275000000b0025550e2693asm581541ljm.38.2022.05.30.14.00.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 14:00:26 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 1/8] arm/xen: Introduce xen_setup_dma_ops()
Date:   Tue, 31 May 2022 00:00:10 +0300
Message-Id: <1653944417-17168-2-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

This patch introduces new helper and places it in new header.
The helper's purpose is to assign any Xen specific DMA ops in
a single place. For now, we deal with xen-swiotlb DMA ops only.
The one of the subsequent commits in current series will add
xen-grant DMA ops case.

Also re-use the xen_swiotlb_detect() check on Arm32.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
[For arm64]
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
Changes RFC -> V1:
   - update commit description
   - move commit to the beginning of the series
   - move #ifdef CONFIG_XEN from dma-mapping.c to xen-ops.h

Changes V1 -> V2:
   - add Stefano's R-b
   - add missing SPDX-License-Identifier to xen-ops.h

Changes V2 -> V3:
   - add Catalin's A-b
---
 arch/arm/include/asm/xen/xen-ops.h   |  2 ++
 arch/arm/mm/dma-mapping.c            |  7 ++-----
 arch/arm64/include/asm/xen/xen-ops.h |  2 ++
 arch/arm64/mm/dma-mapping.c          |  7 ++-----
 include/xen/arm/xen-ops.h            | 15 +++++++++++++++
 5 files changed, 23 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/include/asm/xen/xen-ops.h
 create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
 create mode 100644 include/xen/arm/xen-ops.h

diff --git a/arch/arm/include/asm/xen/xen-ops.h b/arch/arm/include/asm/xen/xen-ops.h
new file mode 100644
index 00000000..7ebb7eb
--- /dev/null
+++ b/arch/arm/include/asm/xen/xen-ops.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <xen/arm/xen-ops.h>
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82ffac6..059cce0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -33,7 +33,7 @@
 #include <asm/dma-iommu.h>
 #include <asm/mach/map.h>
 #include <asm/system_info.h>
-#include <xen/swiotlb-xen.h>
+#include <asm/xen/xen-ops.h>
 
 #include "dma.h"
 #include "mm.h"
@@ -2287,10 +2287,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	set_dma_ops(dev, dma_ops);
 
-#ifdef CONFIG_XEN
-	if (xen_initial_domain())
-		dev->dma_ops = &xen_swiotlb_dma_ops;
-#endif
+	xen_setup_dma_ops(dev);
 	dev->archdata.dma_ops_setup = true;
 }
 
diff --git a/arch/arm64/include/asm/xen/xen-ops.h b/arch/arm64/include/asm/xen/xen-ops.h
new file mode 100644
index 00000000..7ebb7eb
--- /dev/null
+++ b/arch/arm64/include/asm/xen/xen-ops.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <xen/arm/xen-ops.h>
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 6719f9e..6099c81 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -9,9 +9,9 @@
 #include <linux/dma-map-ops.h>
 #include <linux/dma-iommu.h>
 #include <xen/xen.h>
-#include <xen/swiotlb-xen.h>
 
 #include <asm/cacheflush.h>
+#include <asm/xen/xen-ops.h>
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
@@ -52,8 +52,5 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (iommu)
 		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
 
-#ifdef CONFIG_XEN
-	if (xen_swiotlb_detect())
-		dev->dma_ops = &xen_swiotlb_dma_ops;
-#endif
+	xen_setup_dma_ops(dev);
 }
diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
new file mode 100644
index 00000000..288deb1
--- /dev/null
+++ b/include/xen/arm/xen-ops.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM_XEN_OPS_H
+#define _ASM_ARM_XEN_OPS_H
+
+#include <xen/swiotlb-xen.h>
+
+static inline void xen_setup_dma_ops(struct device *dev)
+{
+#ifdef CONFIG_XEN
+	if (xen_swiotlb_detect())
+		dev->dma_ops = &xen_swiotlb_dma_ops;
+#endif
+}
+
+#endif /* _ASM_ARM_XEN_OPS_H */
-- 
2.7.4

