Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E684A869F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351561AbiBCOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351293AbiBCOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:33 -0500
Date:   Thu, 03 Feb 2022 14:33:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AJYgRmeOxAPwkFiTuY1HtwKJYzHa8hVprmCAhNN1b0=;
        b=2VXoXmfReVzesRMl1UMPde1AqyWP13P7XXE88FFAykQXDguUQeqsgJMdePVJP/8BWRw/7S
        PPsFcsIssPzSDID5x4dcHaILd8WJp7TYv782VP++z2gFG+maiXhRT9b9dyQJfB59eQ2ByG
        51RRe1SyMppNvmnRRzwnLWlt46DxnCPH5QzjW1fSwqVtKZcUHlw2KObB29gZ5On0bKJfhF
        y7eZ63K9tqMxz7dEjUoGS6CWxw5CrXjvLKlM07XTELs1/D+mYuytlu3rZyq9nUjab/aaUR
        5Llpn9a03HS7fXTDCR4g72cO5euOSqexDsqjf6nXziCo3Rd3G2Tsk9wb6UrxbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AJYgRmeOxAPwkFiTuY1HtwKJYzHa8hVprmCAhNN1b0=;
        b=MUevLcAFxiDr7gDOMmZt5p+hlZAlWpLD+CKKQRyeZjgAQddZphww5noAkOawuUEjiNxV1z
        4IrFMs7cm3hcJmDw==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Relax address filter validation
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131072453.2839535-2-adrian.hunter@intel.com>
References: <20220131072453.2839535-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164389881084.16921.8036371520254354722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c243cecb58e3905baeace8827201c14df8481e2a
Gitweb:        https://git.kernel.org/tip/c243cecb58e3905baeace8827201c14df8481e2a
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 31 Jan 2022 09:24:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:42 +01:00

perf/x86/intel/pt: Relax address filter validation

The requirement for 64-bit address filters is that they are canonical
addresses. In other respects any address range is allowed which would
include user space addresses.

That can be useful for tracing virtual machine guests because address
filtering can be used to advantage in place of current privilege level
(CPL) filtering.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220131072453.2839535-2-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 63 +++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 7f406c1..0ebcf9a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -13,6 +13,8 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/device.h>
 
@@ -1347,11 +1349,37 @@ static void pt_addr_filters_fini(struct perf_event *event)
 	event->hw.addr_filters = NULL;
 }
 
-static inline bool valid_kernel_ip(unsigned long ip)
+#ifdef CONFIG_X86_64
+static u64 canonical_address(u64 vaddr, u8 vaddr_bits)
 {
-	return virt_addr_valid(ip) && kernel_ip(ip);
+	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
 }
 
+static u64 is_canonical_address(u64 vaddr, u8 vaddr_bits)
+{
+	return canonical_address(vaddr, vaddr_bits) == vaddr;
+}
+
+/* Clamp to a canonical address greater-than-or-equal-to the address given */
+static u64 clamp_to_ge_canonical_addr(u64 vaddr, u8 vaddr_bits)
+{
+	return is_canonical_address(vaddr, vaddr_bits) ?
+	       vaddr :
+	       -BIT_ULL(vaddr_bits - 1);
+}
+
+/* Clamp to a canonical address less-than-or-equal-to the address given */
+static u64 clamp_to_le_canonical_addr(u64 vaddr, u8 vaddr_bits)
+{
+	return is_canonical_address(vaddr, vaddr_bits) ?
+	       vaddr :
+	       BIT_ULL(vaddr_bits - 1) - 1;
+}
+#else
+#define clamp_to_ge_canonical_addr(x, y) (x)
+#define clamp_to_le_canonical_addr(x, y) (x)
+#endif
+
 static int pt_event_addr_filters_validate(struct list_head *filters)
 {
 	struct perf_addr_filter *filter;
@@ -1366,14 +1394,6 @@ static int pt_event_addr_filters_validate(struct list_head *filters)
 		    filter->action == PERF_ADDR_FILTER_ACTION_START)
 			return -EOPNOTSUPP;
 
-		if (!filter->path.dentry) {
-			if (!valid_kernel_ip(filter->offset))
-				return -EINVAL;
-
-			if (!valid_kernel_ip(filter->offset + filter->size))
-				return -EINVAL;
-		}
-
 		if (++range > intel_pt_validate_hw_cap(PT_CAP_num_address_ranges))
 			return -EOPNOTSUPP;
 	}
@@ -1397,9 +1417,26 @@ static void pt_event_addr_filters_sync(struct perf_event *event)
 		if (filter->path.dentry && !fr[range].start) {
 			msr_a = msr_b = 0;
 		} else {
-			/* apply the offset */
-			msr_a = fr[range].start;
-			msr_b = msr_a + fr[range].size - 1;
+			unsigned long n = fr[range].size - 1;
+			unsigned long a = fr[range].start;
+			unsigned long b;
+
+			if (a > ULONG_MAX - n)
+				b = ULONG_MAX;
+			else
+				b = a + n;
+			/*
+			 * Apply the offset. 64-bit addresses written to the
+			 * MSRs must be canonical, but the range can encompass
+			 * non-canonical addresses. Since software cannot
+			 * execute at non-canonical addresses, adjusting to
+			 * canonical addresses does not affect the result of the
+			 * address filter.
+			 */
+			msr_a = clamp_to_ge_canonical_addr(a, boot_cpu_data.x86_virt_bits);
+			msr_b = clamp_to_le_canonical_addr(b, boot_cpu_data.x86_virt_bits);
+			if (msr_b < msr_a)
+				msr_a = msr_b = 0;
 		}
 
 		filters->filter[range].msr_a  = msr_a;
