Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290525958F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiHPKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiHPKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:49:04 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC50DEB79
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:54:31 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oNt3k-00FxfB-0V;
        Tue, 16 Aug 2022 11:41:39 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v2 1/4] Make place for common balloon code
Date:   Tue, 16 Aug 2022 12:41:14 +0300
Message-Id: <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File already contains code that is common along balloon
drivers so rename it to reflect its contents.
mm/balloon_compaction.c -> mm/balloon_common.c

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 MAINTAINERS                                              | 4 ++--
 arch/powerpc/platforms/pseries/cmm.c                     | 2 +-
 drivers/misc/vmw_balloon.c                               | 2 +-
 drivers/virtio/virtio_balloon.c                          | 2 +-
 include/linux/{balloon_compaction.h => balloon_common.h} | 2 +-
 mm/Makefile                                              | 2 +-
 mm/{balloon_compaction.c => balloon_common.c}            | 4 ++--
 mm/migrate.c                                             | 2 +-
 mm/vmscan.c                                              | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)
 rename include/linux/{balloon_compaction.h => balloon_common.h} (99%)
 rename mm/{balloon_compaction.c => balloon_common.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..1b94bf3eb95d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21493,8 +21493,8 @@ L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
 F:	include/uapi/linux/virtio_balloon.h
-F:	include/linux/balloon_compaction.h
-F:	mm/balloon_compaction.c
+F:	include/linux/balloon_common.h
+F:	mm/balloon_common.c
 
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 5f4037c1d7fe..3beb109c7e44 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -19,7 +19,7 @@
 #include <linux/stringify.h>
 #include <linux/swap.h>
 #include <linux/device.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon_common.h>
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
 #include <asm/mmu.h>
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 61a2be712bf7..6c6d24783548 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -29,7 +29,7 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon_common.h>
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
 #include <asm/hypervisor.h>
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 3f78a3a1eb75..6f69e483d98a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -13,7 +13,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon_common.h>
 #include <linux/oom.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_common.h
similarity index 99%
rename from include/linux/balloon_compaction.h
rename to include/linux/balloon_common.h
index 5ca2d5699620..a45e9fd76235 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * include/linux/balloon_compaction.h
+ * include/linux/balloon_common.h
  *
  * Common interface definitions for making balloon pages movable by compaction.
  *
diff --git a/mm/Makefile b/mm/Makefile
index 9a564f836403..a3390f255b82 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,7 +112,7 @@ obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
 obj-$(CONFIG_Z3FOLD)	+= z3fold.o
 obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
-obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
+obj-$(CONFIG_MEMORY_BALLOON) += balloon_common.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
diff --git a/mm/balloon_compaction.c b/mm/balloon_common.c
similarity index 99%
rename from mm/balloon_compaction.c
rename to mm/balloon_common.c
index 22c96fed70b5..54ed98653c78 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mm/balloon_compaction.c
+ * mm/balloon_common.c
  *
  * Common interface for making balloon pages movable by compaction.
  *
@@ -9,7 +9,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon_common.h>
 
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 				     struct page *page)
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..a6df467a250a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -41,7 +41,7 @@
 #include <linux/pfn_t.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon_common.h>
 #include <linux/page_idle.h>
 #include <linux/page_owner.h>
 #include <linux/sched/mm.h>
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431352dc..4732f8c24264 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -54,7 +54,7 @@
 #include <asm/div64.h>
 
 #include <linux/swapops.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon_common.h>
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
-- 
2.31.1

