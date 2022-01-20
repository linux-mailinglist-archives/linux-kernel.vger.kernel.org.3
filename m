Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4CB4951FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbiATQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:06:31 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56696 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376910AbiATQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:04:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V2Mx5lP_1642694669;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V2Mx5lP_1642694669)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 00:04:31 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 2/2] mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
Date:   Fri, 21 Jan 2022 00:04:28 +0800
Message-Id: <00a90e13bba20c252a0ea1c0fb3e1c07b0fbb3b0.1642722660.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1642722660.git.xhao@linux.alibaba.com>
References: <cover.1642722660.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you want to support "DAMON_DBGFS" in config file, it only depends on
any one of "DAMON_VADDR" and "DAMON_PADDR", and sometimes we just want to
use damon virtual address function, but it is unreasonable to include
"DAMON_PADDR" in config file which cause the damon/paddr.c be compiled.

So there just do little change to fix it.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h | 16 ++++++++++++++++
 mm/damon/Kconfig      |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 794b5f453662..c83e4588aa45 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -501,12 +501,28 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 #ifdef CONFIG_DAMON_VADDR
 bool damon_va_target_valid(void *t);
 void damon_va_set_primitives(struct damon_ctx *ctx);
+#else
+static inline void damon_va_set_primitives(struct damon_ctx *ctx) { }
+static inline bool damon_va_target_valid(void *t)
+{
+	return false;
+}
 #endif	/* CONFIG_DAMON_VADDR */

 #ifdef CONFIG_DAMON_PADDR
 bool damon_pa_check(char *buf, size_t count);
 bool damon_pa_target_valid(void *t);
 void damon_pa_set_primitives(struct damon_ctx *ctx);
+#else
+static inline bool damon_pa_check(char *buf, size_t count)
+{
+	return false;
+}
+static inline void damon_pa_set_primitives(struct damon_ctx *ctx) { }
+static inline bool damon_pa_target_valid(void *t)
+{
+	return false;
+}
 #endif	/* CONFIG_DAMON_PADDR */

 #endif	/* _DAMON_H */
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 5bcf05851ad0..a8952af3c8bf 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST

 config DAMON_DBGFS
 	bool "DAMON debugfs interface"
-	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
+	depends on (DAMON_VADDR || DAMON_PADDR) && DEBUG_FS
 	help
 	  This builds the debugfs interface for DAMON.  The user space admins
 	  can use the interface for arbitrary data access monitoring.
--
2.27.0
