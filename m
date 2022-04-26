Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D418C50F339
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiDZIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiDZIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:01:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E11A245A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:58:23 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KnZ4X4m9vzhYmL;
        Tue, 26 Apr 2022 15:58:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 15:58:21 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 15:58:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <elver@google.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mark.rutland@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] arm64: kcsan: Fix kcsan test_barrier fail and panic
Date:   Tue, 26 Apr 2022 08:17:00 +0000
Message-ID: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As "kcsan: Support detecting a subset of missing memory barriers"
introduced KCSAN_STRICT which make kcsan detects more missing memory
barrier, but arm64 don't have KCSAN instrumentation for barriers, so
the new selftest test_barrier() will fail, then panic.

Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
defined the final instrumented version of these barriers, which will
fix the above issues.

Fixes: dd03762ab608 ("arm64: Enable KCSAN")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/barrier.h | 12 ++++++------
 include/asm-generic/barrier.h    |  4 ++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 62217be36217..9760a8d4ed0a 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -46,13 +46,13 @@
 #define pmr_sync()	do {} while (0)
 #endif
 
-#define mb()		dsb(sy)
-#define rmb()		dsb(ld)
-#define wmb()		dsb(st)
+#define __mb()		dsb(sy)
+#define __rmb()		dsb(ld)
+#define __wmb()		dsb(st)
 
-#define dma_mb()	dmb(osh)
-#define dma_rmb()	dmb(oshld)
-#define dma_wmb()	dmb(oshst)
+#define __dma_mb()	dmb(osh)
+#define __dma_rmb()	dmb(oshld)
+#define __dma_wmb()	dmb(oshst)
 
 #define io_stop_wc()	dgh()
 
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fd7e8fbaeef1..18863c50e9ce 100644
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
-- 
2.27.0

