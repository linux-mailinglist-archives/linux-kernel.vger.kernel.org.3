Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2451E4A2B84
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbiA2DtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:49:02 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60992 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238931AbiA2Ds5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:48:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V35EraQ_1643428129;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V35EraQ_1643428129)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 11:48:54 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] powerpc/fadump: Use swap() instead of open coding it
Date:   Sat, 29 Jan 2022 11:48:47 +0800
Message-Id: <20220129034847.76902-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the following coccicheck warning:

./arch/powerpc/kernel/fadump.c:1291:34-35: WARNING opportunity for
swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/powerpc/kernel/fadump.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d0ad86b67e66..de08dd078081 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1271,7 +1271,6 @@ static void fadump_release_reserved_area(u64 start, u64 end)
 static void sort_and_merge_mem_ranges(struct fadump_mrange_info *mrange_info)
 {
 	struct fadump_memory_range *mem_ranges;
-	struct fadump_memory_range tmp_range;
 	u64 base, size;
 	int i, j, idx;
 
@@ -1286,11 +1285,8 @@ static void sort_and_merge_mem_ranges(struct fadump_mrange_info *mrange_info)
 			if (mem_ranges[idx].base > mem_ranges[j].base)
 				idx = j;
 		}
-		if (idx != i) {
-			tmp_range = mem_ranges[idx];
-			mem_ranges[idx] = mem_ranges[i];
-			mem_ranges[i] = tmp_range;
-		}
+		if (idx != i)
+			swap(mem_ranges[idx], mem_ranges[i]);
 	}
 
 	/* Merge adjacent reserved ranges */
-- 
2.20.1.7.g153144c

