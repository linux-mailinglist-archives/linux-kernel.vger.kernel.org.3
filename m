Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D05531036
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiEWLVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiEWLVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:21:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D0DEE2;
        Mon, 23 May 2022 04:21:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L6FGm5vMszfZ5g;
        Mon, 23 May 2022 19:19:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 19:21:13 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 19:21:12 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <elver@google.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <arnd@arndb.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 1/2] asm-generic: Add memory barrier dma_mb()
Date:   Mon, 23 May 2022 19:31:25 +0800
Message-ID: <20220523113126.171714-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory barrier dma_mb() is introduced by commit a76a37777f2c
("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
which is used to ensure that prior (both reads and writes) accesses
to memory by a CPU are ordered w.r.t. a subsequent MMIO write.

Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/memory-barriers.txt | 11 ++++++-----
 include/asm-generic/barrier.h     |  8 ++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b12df9137e1c..832b5d36e279 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
 
  (*) dma_wmb();
  (*) dma_rmb();
+ (*) dma_mb();
 
      These are for use with consistent memory to guarantee the ordering
      of writes or reads of shared memory accessible to both the CPU and a
@@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
      The dma_rmb() allows us guarantee the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
-     can see it now has ownership.  Note that, when using writel(), a prior
-     wmb() is not needed to guarantee that the cache coherent memory writes
-     have completed before writing to the MMIO region.  The cheaper
-     writel_relaxed() does not provide this guarantee and must not be used
-     here.
+     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
+     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
+     to guarantee that the cache coherent memory writes have completed before
+     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
+     this guarantee and must not be used here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fd7e8fbaeef1..961f4d88f9ef 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -38,6 +38,10 @@
 #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
 #endif
 
+#ifdef __dma_mb
+#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
+#endif
+
 #ifdef __dma_rmb
 #define dma_rmb()	do { kcsan_rmb(); __dma_rmb(); } while (0)
 #endif
@@ -65,6 +69,10 @@
 #define wmb()	mb()
 #endif
 
+#ifndef dma_mb
+#define dma_mb()	mb()
+#endif
+
 #ifndef dma_rmb
 #define dma_rmb()	rmb()
 #endif
-- 
2.35.3

