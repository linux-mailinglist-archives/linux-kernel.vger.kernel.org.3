Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ABE465F08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355925AbhLBIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:02:26 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52457 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230274AbhLBICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:02:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uz9BbE7_1638431940;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Uz9BbE7_1638431940)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 15:59:01 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND MERGE REQUEST] mm/damon: move damon_rand() definition into damon.h
Date:   Thu,  2 Dec 2021 15:58:59 +0800
Message-Id: <20211202075859.51341-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_rand() is called in three files:damon/core.c, damon/
paddr.c, damon/vaddr.c, i think there is no need to redefine
this twice, So move it to damon.h will be a good choice.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h   | 4 ++++
 mm/damon/core.c         | 4 ----
 mm/damon/prmtv-common.h | 4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 00ad96f2ec10..c6df025d8704 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -11,12 +11,16 @@
 #include <linux/mutex.h>
 #include <linux/time64.h>
 #include <linux/types.h>
+#include <linux/random.h>

 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)

+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32_max(r - l))
+
 /**
  * struct damon_addr_range - Represents an address region of [@start, @end).
  * @start:	Start address of the region (inclusive).
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4d2c3a0c7c8a..bdec32ef78c0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -11,7 +11,6 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
-#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/string.h>

@@ -23,9 +22,6 @@
 #define DAMON_MIN_REGION 1
 #endif

-/* Get a random number in [l, r) */
-#define damon_rand(l, r) (l + prandom_u32_max(r - l))
-
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;

diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index 61f27037603e..e790cb5f8fe0 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -6,10 +6,6 @@
  */

 #include <linux/damon.h>
-#include <linux/random.h>
-
-/* Get a random number in [l, r) */
-#define damon_rand(l, r) (l + prandom_u32_max(r - l))

 struct page *damon_get_page(unsigned long pfn);

--
2.31.0
