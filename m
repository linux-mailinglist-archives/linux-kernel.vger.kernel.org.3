Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B87D46363E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhK3OQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhK3OQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:16:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAFFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aEcJKxePikJV2WEjcgQtxNclZ5m8itDIJezRaOTKFs0=; b=NFMMPPTaC1nu9H9cS2Lc72Qc5i
        NraNcR6x2gQFzQDw2gLRplqYrUPS09FwoULFsKvPJF5akrPD/Zg8Z2kKgL8Nb8rLF/Rxp0f16a+XJ
        SvZ17I6oCyPKkzd4jjDqGlQCbsg4TnjYcS8IWwhzsjS4NxVBMmrLfBcrIads69CbBOABOm9h5EiFA
        mXmEh2lxzY3G1TAHREw6/Nczit7egn5/rHQoCOxFtQnKgk70N2BunA2FfaKnsgToQYFJqcUTZnc+O
        6gf1SVN6HrO/LO4lNHELBwGbzCq46wpVuljX69LfVmAuOV2FBsQllrtZEB2TR6dkl8TAdJEh3r/6h
        mo55cIug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms3ss-00CXRY-5Y; Tue, 30 Nov 2021 14:13:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] tools: Fix math.h breakage
Date:   Tue, 30 Nov 2021 14:13:16 +0000
Message-Id: <20211130141316.2987986-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 98e1385ef24b broke the radix tree test suite in two different ways;
first by including math.h which didn't exist in the tools directory, and
second by removing an implicit include of spinlock.h before lockdep.h.
Fix both issues.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/include/linux/kernel.h             | 22 +--------------------
 tools/include/linux/math.h               | 25 ++++++++++++++++++++++++
 tools/testing/radix-tree/linux/lockdep.h |  3 +++
 3 files changed, 29 insertions(+), 21 deletions(-)
 create mode 100644 tools/include/linux/math.h

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index a7e54a08fb54..3e8df500cfbd 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -7,6 +7,7 @@
 #include <assert.h>
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
+#include <linux/math.h>
 #include <endian.h>
 #include <byteswap.h>
 
@@ -14,8 +15,6 @@
 #define UINT_MAX	(~0U)
 #endif
 
-#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
-
 #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
 #define __PERF_ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
 
@@ -52,15 +51,6 @@
 	_min1 < _min2 ? _min1 : _min2; })
 #endif
 
-#ifndef roundup
-#define roundup(x, y) (                                \
-{                                                      \
-	const typeof(y) __y = y;		       \
-	(((x) + (__y - 1)) / __y) * __y;	       \
-}                                                      \
-)
-#endif
-
 #ifndef BUG_ON
 #ifdef NDEBUG
 #define BUG_ON(cond) do { if (cond) {} } while (0)
@@ -104,16 +94,6 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
-/*
- * This looks more complex than it should be. But we need to
- * get the type for the ~ right in round_down (it needs to be
- * as wide as the result!), and we want to evaluate the macro
- * arguments just once each.
- */
-#define __round_mask(x, y) ((__typeof__(x))((y)-1))
-#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
-#define round_down(x, y) ((x) & ~__round_mask(x, y))
-
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
diff --git a/tools/include/linux/math.h b/tools/include/linux/math.h
new file mode 100644
index 000000000000..4e7af99ec9eb
--- /dev/null
+++ b/tools/include/linux/math.h
@@ -0,0 +1,25 @@
+#ifndef _TOOLS_MATH_H
+#define _TOOLS_MATH_H
+
+/*
+ * This looks more complex than it should be. But we need to
+ * get the type for the ~ right in round_down (it needs to be
+ * as wide as the result!), and we want to evaluate the macro
+ * arguments just once each.
+ */
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+
+#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
+
+#ifndef roundup
+#define roundup(x, y) (                                \
+{                                                      \
+	const typeof(y) __y = y;		       \
+	(((x) + (__y - 1)) / __y) * __y;	       \
+}                                                      \
+)
+#endif
+
+#endif
diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix-tree/linux/lockdep.h
index 565fccdfe6e9..016cff473cfc 100644
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ b/tools/testing/radix-tree/linux/lockdep.h
@@ -1,5 +1,8 @@
 #ifndef _LINUX_LOCKDEP_H
 #define _LINUX_LOCKDEP_H
+
+#include <linux/spinlock.h>
+
 struct lock_class_key {
 	unsigned int a;
 };
-- 
2.33.0

