Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A0593402
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiHOR0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiHOR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:28 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C46E0F1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAF9K0B15Mg9PXoNhljhPMrq2h3hanygoptxnBRwP88=;
        b=hYkT2mwtEHl/Dmni1fV8tRpNeajYKpl855tPfZMOFMDFiYBD3s8Wg9UuXHO000/2jR53Ip
        iCqTru9P+eCI04wbgEHOm6lPKdwvIIQXavnHhbS75JLTwDIIzeXQgbKab/BcNHq7kGf6og
        Dn4b4scGRiBuekijB+oPUSran8bojyE=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/11] powerpc: Convert to printbuf
Date:   Mon, 15 Aug 2022 13:26:06 -0400
Message-Id: <20220815172613.621627-5-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode, so it's a direct conversion, aside from some trivial
refactoring in cpu_show_meltdown() to make the code more consistent.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/process.c             | 16 +++--
 arch/powerpc/kernel/security.c            | 75 ++++++++++-------------
 arch/powerpc/platforms/pseries/papr_scm.c | 34 +++++-----
 3 files changed, 57 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 0fbda89cd1..05654dbeb2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -37,7 +37,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 
 #include <asm/interrupt.h>
 #include <asm/io.h>
@@ -1396,32 +1396,30 @@ void show_user_instructions(struct pt_regs *regs)
 {
 	unsigned long pc;
 	int n = NR_INSN_TO_PRINT;
-	struct seq_buf s;
 	char buf[96]; /* enough for 8 times 9 + 2 chars */
+	struct printbuf s = PRINTBUF_EXTERN(buf, sizeof(buf));
 
 	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
-	seq_buf_init(&s, buf, sizeof(buf));
-
 	while (n) {
 		int i;
 
-		seq_buf_clear(&s);
+		printbuf_reset(&s);
 
 		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
 			int instr;
 
 			if (copy_from_user_nofault(&instr, (void __user *)pc,
 					sizeof(instr))) {
-				seq_buf_printf(&s, "XXXXXXXX ");
+				prt_printf(&s, "XXXXXXXX ");
 				continue;
 			}
-			seq_buf_printf(&s, regs->nip == pc ? "<%08x> " : "%08x ", instr);
+			prt_printf(&s, regs->nip == pc ? "<%08x> " : "%08x ", instr);
 		}
 
-		if (!seq_buf_has_overflowed(&s))
+		if (printbuf_remaining(&s))
 			pr_info("%s[%d]: code: %s\n", current->comm,
-				current->pid, s.buffer);
+				current->pid, s.buf);
 	}
 }
 
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index d96fd14bd7..b34de62e65 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -10,7 +10,7 @@
 #include <linux/memblock.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/debugfs.h>
 
 #include <asm/asm-prototypes.h>
@@ -144,31 +144,28 @@ void __init setup_spectre_v2(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	bool thread_priv;
 
 	thread_priv = security_ftr_enabled(SEC_FTR_L1D_THREAD_PRIV);
 
 	if (rfi_flush) {
-		struct seq_buf s;
-		seq_buf_init(&s, buf, PAGE_SIZE - 1);
 
-		seq_buf_printf(&s, "Mitigation: RFI Flush");
+		prt_printf(&s, "Mitigation: RFI Flush");
 		if (thread_priv)
-			seq_buf_printf(&s, ", L1D private per thread");
-
-		seq_buf_printf(&s, "\n");
-
-		return s.len;
+			prt_printf(&s, ", L1D private per thread");
+
+		prt_printf(&s, "\n");
+	} else if (thread_priv) {
+		prt_printf(&s, "Vulnerable: L1D private per thread\n");
+	} else if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
+		   !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR)) {
+		prt_printf(&s, "Not affected\n");
+	} else {
+		prt_printf(&s, "Vulnerable\n");
 	}
 
-	if (thread_priv)
-		return sprintf(buf, "Vulnerable: L1D private per thread\n");
-
-	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
-	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
-		return sprintf(buf, "Not affected\n");
-
-	return sprintf(buf, "Vulnerable\n");
+	return printbuf_written(&s);
 }
 
 ssize_t cpu_show_l1tf(struct device *dev, struct device_attribute *attr, char *buf)
@@ -179,70 +176,66 @@ ssize_t cpu_show_l1tf(struct device *dev, struct device_attribute *attr, char *b
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct seq_buf s;
-
-	seq_buf_init(&s, buf, PAGE_SIZE - 1);
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 
 	if (security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) {
 		if (barrier_nospec_enabled)
-			seq_buf_printf(&s, "Mitigation: __user pointer sanitization");
+			prt_printf(&s, "Mitigation: __user pointer sanitization");
 		else
-			seq_buf_printf(&s, "Vulnerable");
+			prt_printf(&s, "Vulnerable");
 
 		if (security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31))
-			seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+			prt_printf(&s, ", ori31 speculation barrier enabled");
 
-		seq_buf_printf(&s, "\n");
+		prt_printf(&s, "\n");
 	} else
-		seq_buf_printf(&s, "Not affected\n");
+		prt_printf(&s, "Not affected\n");
 
-	return s.len;
+	return printbuf_written(&s);
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	bool bcs, ccd;
 
-	seq_buf_init(&s, buf, PAGE_SIZE - 1);
-
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
 
 	if (bcs || ccd) {
-		seq_buf_printf(&s, "Mitigation: ");
+		prt_printf(&s, "Mitigation: ");
 
 		if (bcs)
-			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+			prt_printf(&s, "Indirect branch serialisation (kernel only)");
 
 		if (bcs && ccd)
-			seq_buf_printf(&s, ", ");
+			prt_printf(&s, ", ");
 
 		if (ccd)
-			seq_buf_printf(&s, "Indirect branch cache disabled");
+			prt_printf(&s, "Indirect branch cache disabled");
 
 	} else if (count_cache_flush_type != BRANCH_CACHE_FLUSH_NONE) {
-		seq_buf_printf(&s, "Mitigation: Software count cache flush");
+		prt_printf(&s, "Mitigation: Software count cache flush");
 
 		if (count_cache_flush_type == BRANCH_CACHE_FLUSH_HW)
-			seq_buf_printf(&s, " (hardware accelerated)");
+			prt_printf(&s, " (hardware accelerated)");
 
 	} else if (btb_flush_enabled) {
-		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
+		prt_printf(&s, "Mitigation: Branch predictor state flush");
 	} else {
-		seq_buf_printf(&s, "Vulnerable");
+		prt_printf(&s, "Vulnerable");
 	}
 
 	if (bcs || ccd || count_cache_flush_type != BRANCH_CACHE_FLUSH_NONE) {
 		if (link_stack_flush_type != BRANCH_CACHE_FLUSH_NONE)
-			seq_buf_printf(&s, ", Software link stack flush");
+			prt_printf(&s, ", Software link stack flush");
 		if (link_stack_flush_type == BRANCH_CACHE_FLUSH_HW)
-			seq_buf_printf(&s, " (hardware accelerated)");
+			prt_printf(&s, " (hardware accelerated)");
 	}
 
-	seq_buf_printf(&s, "\n");
+	prt_printf(&s, "\n");
 
-	return s.len;
+	return printbuf_written(&s);
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 20f6ed813b..a1fd25243c 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -12,7 +12,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/nd.h>
 
 #include <asm/plpar_wrappers.h>
@@ -1142,7 +1142,7 @@ static ssize_t perf_stats_show(struct device *dev,
 {
 	int index;
 	ssize_t rc;
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	struct papr_scm_perf_stat *stat;
 	struct papr_scm_perf_stats *stats;
 	struct nvdimm *dimm = to_nvdimm(dev);
@@ -1165,18 +1165,17 @@ static ssize_t perf_stats_show(struct device *dev,
 	 * values. Since stat_id is essentially a char string of
 	 * 8 bytes, simply use the string format specifier to print it.
 	 */
-	seq_buf_init(&s, buf, PAGE_SIZE);
 	for (index = 0, stat = stats->scm_statistic;
 	     index < be32_to_cpu(stats->num_statistics);
 	     ++index, ++stat) {
-		seq_buf_printf(&s, "%.8s = 0x%016llX\n",
-			       stat->stat_id,
-			       be64_to_cpu(stat->stat_val));
+		prt_printf(&s, "%.8s = 0x%016llX\n",
+		       stat->stat_id,
+		       be64_to_cpu(stat->stat_val));
 	}
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ?: printbuf_written(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -1185,7 +1184,7 @@ static ssize_t flags_show(struct device *dev,
 {
 	struct nvdimm *dimm = to_nvdimm(dev);
 	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	u64 health;
 	int rc;
 
@@ -1196,29 +1195,28 @@ static ssize_t flags_show(struct device *dev,
 	/* Copy health_bitmap locally, check masks & update out buffer */
 	health = READ_ONCE(p->health_bitmap);
 
-	seq_buf_init(&s, buf, PAGE_SIZE);
 	if (health & PAPR_PMEM_UNARMED_MASK)
-		seq_buf_printf(&s, "not_armed ");
+		prt_printf(&s, "not_armed ");
 
 	if (health & PAPR_PMEM_BAD_SHUTDOWN_MASK)
-		seq_buf_printf(&s, "flush_fail ");
+		prt_printf(&s, "flush_fail ");
 
 	if (health & PAPR_PMEM_BAD_RESTORE_MASK)
-		seq_buf_printf(&s, "restore_fail ");
+		prt_printf(&s, "restore_fail ");
 
 	if (health & PAPR_PMEM_ENCRYPTED)
-		seq_buf_printf(&s, "encrypted ");
+		prt_printf(&s, "encrypted ");
 
 	if (health & PAPR_PMEM_SMART_EVENT_MASK)
-		seq_buf_printf(&s, "smart_notify ");
+		prt_printf(&s, "smart_notify ");
 
 	if (health & PAPR_PMEM_SCRUBBED_AND_LOCKED)
-		seq_buf_printf(&s, "scrubbed locked ");
+		prt_printf(&s, "scrubbed locked ");
 
-	if (seq_buf_used(&s))
-		seq_buf_printf(&s, "\n");
+	if (printbuf_written(&s))
+		prt_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return printbuf_written(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.36.1

