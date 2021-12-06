Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588304695FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbhLFM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:56:16 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36745 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243423AbhLFM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:56:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UzdP6MJ_1638795164;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UzdP6MJ_1638795164)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 20:52:45 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/damon: Modify damon_rand() macro to static inline function
Date:   Mon,  6 Dec 2021 20:52:43 +0800
Message-Id: <110ffcd4e420c86c42b41ce2bc9f0fe6a4f32cd3.1638795127.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The damon_rand() func can not be implemented as a macro.
Example:
	damon_rand(a++, b);
The value of 'a' will be incremented twice, This is obviously
unreasonable, So there fix it.

Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c6df025d8704..a58046cd45e6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -19,7 +19,10 @@
 #define DAMOS_MAX_SCORE		(99)

 /* Get a random number in [l, r) */
-#define damon_rand(l, r) (l + prandom_u32_max(r - l))
+static inline unsigned long damon_rand(unsigned long l, unsigned long r)
+{
+	return l + prandom_u32_max(r - l);
+}

 /**
  * struct damon_addr_range - Represents an address region of [@start, @end).
--
2.31.0
