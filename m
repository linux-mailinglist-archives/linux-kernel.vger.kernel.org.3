Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FCC550E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiFTAo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiFTAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:49 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D44B488
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g15so6878217qke.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nzGqFu+zHLzrMtmSIDmXnbGgXz0ZoUV2UNHlwfAYis=;
        b=qgc7SgH+16gmkiml4CM55Sc/NiPCmG43s+8mnXVuSjWJR+qnDFN+VRyjVt3jWNXz+V
         se4AYMrcDghbfK3vCuVrlw1rGNYR3WRWfgDjnemLQd0+xUmBohaKWSoVBJZi+/rVjb1d
         4u7SFtvPGSO29vjhRjn59EWi45PR+z8JFRjlm2SxKUM6RecPMSBgyZr5R34ogtBtRwWQ
         uOqW0fGzirpaYNKRBxr/h+Em5z7d9t/dYT786nB/9Oc7Ak+lSGm8wf48t7mhOyYRUoL6
         HeGuiN+ALvJLjx+E2jjO7li0VzB9YNWNLQSviSJInscDgOxRMqoegcFJBixRTnNEolTY
         d0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nzGqFu+zHLzrMtmSIDmXnbGgXz0ZoUV2UNHlwfAYis=;
        b=R/Vs4Q3fP9pcBCPZxrtaHYRzMk0Wy2+lUlwG1sorrHYn5A2HbE3+/PuxnmijvsE7pw
         jVIiXp3yLZzagI68EhgArLUoBsLmwtQiUpKC5TXLec6Vtx+aZilaU1RNfmFXWe6YUhEB
         eZglGs/Orx9ZnKG7qUDzOV63pZ8j+7P2TsNd8MyO+8TuWLyhm3q5JU7Ho490rfhfW6fQ
         5INi7kNWQXBBmhAXUverR5j4oapNYCcetcatRZEbfEjsjS0KlAgGUaRJdUAd/UNB3VJt
         056Ch0k1q4hMMRSCEQYGqXP+XOes1EAH2ZwLI4HkMjQ7W3G4UNdwsrwS2tgptwHH+yuV
         KVJg==
X-Gm-Message-State: AJIora9TaCJNOnvZxYIM+xNGyukgfNZ4wXEEDpscAMIAJqq6QkVlsq3A
        W/oomKYV3Pf5wUQ/ZgI8MWfwMNlO/452FNg=
X-Google-Smtp-Source: AGRyM1t8MdXUx5SALS5SayNF2uuahMxKQ6ZwFtczQoVY1aB8OhLl5wSWuzDcjoh/34x6wWj9s8wVeA==
X-Received: by 2002:a05:620a:4553:b0:6a6:fcb5:c2f9 with SMTP id u19-20020a05620a455300b006a6fcb5c2f9mr15185639qkp.299.1655685816923;
        Sun, 19 Jun 2022 17:43:36 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j16-20020a05620a147000b006addb0af23asm1545655qkl.78.2022.06.19.17.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:36 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 27/34] powerpc: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:26 -0400
Message-Id: <20220620004233.3805-28-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 984813a4d5..fb8ba50223 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -39,7 +39,7 @@
 #include <linux/uaccess.h>
 #include <linux/elf-randomize.h>
 #include <linux/pkeys.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 
 #include <asm/interrupt.h>
 #include <asm/io.h>
@@ -1399,32 +1399,30 @@ void show_user_instructions(struct pt_regs *regs)
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
index 39962c9055..317d4513db 100644
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
@@ -1145,7 +1145,7 @@ static ssize_t perf_stats_show(struct device *dev,
 {
 	int index;
 	ssize_t rc;
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	struct papr_scm_perf_stat *stat;
 	struct papr_scm_perf_stats *stats;
 	struct nvdimm *dimm = to_nvdimm(dev);
@@ -1168,18 +1168,17 @@ static ssize_t perf_stats_show(struct device *dev,
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
 
@@ -1188,7 +1187,7 @@ static ssize_t flags_show(struct device *dev,
 {
 	struct nvdimm *dimm = to_nvdimm(dev);
 	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	u64 health;
 	int rc;
 
@@ -1199,29 +1198,28 @@ static ssize_t flags_show(struct device *dev,
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

