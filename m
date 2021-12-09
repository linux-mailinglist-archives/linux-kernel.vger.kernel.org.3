Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3580846E058
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhLIBqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:46:00 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29106 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhLIBqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:46:00 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J8cCV4ft9z1DK2M;
        Thu,  9 Dec 2021 09:39:34 +0800 (CST)
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:42:25 +0800
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>, <yeyunfeng@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v3 1/2] arm64: mm: Rename asid2idx() to ctxid2asid()
Message-ID: <c31516eb-6d15-94e0-421c-305fc010ea79@huawei.com>
Date:   Thu, 9 Dec 2021 09:42:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 0c8ea531b774 ("arm64: mm: Allocate ASIDs in pairs") introduce
the asid2idx and idx2asid macro, but these macros are not really useful
after the commit f88f42f853a8 ("arm64: context: Free up kernel ASIDs if
KPTI is not in use").

The code "(asid & ~ASID_MASK)" can be instead by a macro, which is the
same code with asid2idx(). So rename it to ctxid2asid() for a better
understanding.

Also we add asid2ctxid() macro, the contextid can be generated based on
the asid and generation through this macro.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2 -> v3:
 - Add "Signed-off-by" and "Reviewed-by"

v1 -> v2:
 - Split the patch and rename asid2idx() to ctxid2asid()

 arch/arm64/mm/context.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index cd72576ae2b7..bbc2708fe928 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -35,8 +35,8 @@ static unsigned long *pinned_asid_map;
 #define ASID_FIRST_VERSION	(1UL << asid_bits)

 #define NUM_USER_ASIDS		ASID_FIRST_VERSION
-#define asid2idx(asid)		((asid) & ~ASID_MASK)
-#define idx2asid(idx)		asid2idx(idx)
+#define ctxid2asid(asid)	((asid) & ~ASID_MASK)
+#define asid2ctxid(asid, genid)	((asid) | (genid))

 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
@@ -120,7 +120,7 @@ static void flush_context(void)
 		 */
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
-		__set_bit(asid2idx(asid), asid_map);
+		__set_bit(ctxid2asid(asid), asid_map);
 		per_cpu(reserved_asids, i) = asid;
 	}

@@ -162,7 +162,7 @@ static u64 new_context(struct mm_struct *mm)
 	u64 generation = atomic64_read(&asid_generation);

 	if (asid != 0) {
-		u64 newasid = generation | (asid & ~ASID_MASK);
+		u64 newasid = asid2ctxid(ctxid2asid(asid), generation);

 		/*
 		 * If our current ASID was active during a rollover, we
@@ -183,7 +183,7 @@ static u64 new_context(struct mm_struct *mm)
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
-		if (!__test_and_set_bit(asid2idx(asid), asid_map))
+		if (!__test_and_set_bit(ctxid2asid(asid), asid_map))
 			return newasid;
 	}

@@ -209,7 +209,7 @@ static u64 new_context(struct mm_struct *mm)
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-	return idx2asid(asid) | generation;
+	return asid2ctxid(asid, generation);
 }

 void check_and_switch_context(struct mm_struct *mm)
@@ -300,13 +300,13 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 	}

 	nr_pinned_asids++;
-	__set_bit(asid2idx(asid), pinned_asid_map);
+	__set_bit(ctxid2asid(asid), pinned_asid_map);
 	refcount_set(&mm->context.pinned, 1);

 out_unlock:
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);

-	asid &= ~ASID_MASK;
+	asid = ctxid2asid(asid);

 	/* Set the equivalent of USER_ASID_BIT */
 	if (asid && arm64_kernel_unmapped_at_el0())
@@ -327,7 +327,7 @@ void arm64_mm_context_put(struct mm_struct *mm)
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);

 	if (refcount_dec_and_test(&mm->context.pinned)) {
-		__clear_bit(asid2idx(asid), pinned_asid_map);
+		__clear_bit(ctxid2asid(asid), pinned_asid_map);
 		nr_pinned_asids--;
 	}

-- 
2.27.0
