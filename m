Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55214951FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376832AbiATQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:06:32 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42985 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376906AbiATQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:04:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V2Mx5lP_1642694669;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V2Mx5lP_1642694669)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 00:04:30 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/2] mm/damon/dbgfs: Put "paddr" check into damon_pa_check() func
Date:   Fri, 21 Jan 2022 00:04:27 +0800
Message-Id: <44060c744a3760b1ecf6ce52a9b4ec842fa55eef.1642722660.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1642722660.git.xhao@linux.alibaba.com>
References: <cover.1642722660.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of putting "paddr" check into damon_pa_check() func
is to better solve "DAMON_DBGFS" dependency on both "DAMON_VADDR"
and "DAMON_PADDR".

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h | 1 +
 mm/damon/dbgfs.c      | 2 +-
 mm/damon/paddr.c      | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5e1e3a128b77..794b5f453662 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -504,6 +504,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
 #endif	/* CONFIG_DAMON_VADDR */

 #ifdef CONFIG_DAMON_PADDR
+bool damon_pa_check(char *buf, size_t count);
 bool damon_pa_target_valid(void *t);
 void damon_pa_set_primitives(struct damon_ctx *ctx);
 #endif	/* CONFIG_DAMON_PADDR */
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 5b899601e56c..cdb9c1e2ab29 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -374,7 +374,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);

-	if (!strncmp(kbuf, "paddr\n", count)) {
+	if (damon_pa_check(kbuf, count)) {
 		id_is_pid = false;
 		/* target id is meaningless here, but we set it just for fun */
 		scnprintf(kbuf, count, "42    ");
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5e8244f65a1a..14a6bf2a2adb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -208,6 +208,14 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }

+bool damon_pa_check(char *buf, size_t count)
+{
+	if (!strncmp(buf, "paddr\n", count))
+		return true;
+
+	return false;
+}
+
 bool damon_pa_target_valid(void *t)
 {
 	return true;
--
2.27.0
