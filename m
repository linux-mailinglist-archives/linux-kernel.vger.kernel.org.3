Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA852DB47
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbiESR2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbiESRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E212DFF4F;
        Thu, 19 May 2022 10:25:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so5842865pjq.2;
        Thu, 19 May 2022 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEarPetEXD2YQGYpP7hMIqZiYpJpE1Z8lNf7Sa8/vnM=;
        b=BvKT+R1LR16GPqLiARV7wcahKZ+cTX7B1WFyzIgW4hu0pijp9ZDuxh7G7Lb+PRW9Ro
         2qoy61P1sC7EX5TaLJCfxaTiqwMSUfKj+HKHWv+XESmte/fUTDq8rX+MMG2DXMvgLzb7
         BAJGmPZvtx8klQ8YYw63yWIcOx50kplligC27G+nY/HwDNThlOE7pmHTd5e9ar5kGBYc
         nG6BWGZqdWOD9Hhqg0uIySkC7895FxVxRlASpPpSjZ/6K9hgcvQDQUXwLDKUgrjIMfpl
         bYtM5L6p+M6dNYAm9uwUmSg3BV7HTuZMsbIZ9WDXvW0pmP0VpOvFOQlrdvEMezW5gDsz
         jHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEarPetEXD2YQGYpP7hMIqZiYpJpE1Z8lNf7Sa8/vnM=;
        b=c1kKMO9W66i/u1NgkE/7xmFssrloIMZ3ysSbtIIf2a3K3hmoP/MEZL8aVDedk9QY4S
         7V6EtRY+KTflI8ohnxpW7jT7rXRm/nkhhE7Gu6FsW0S92/E3VE0XLYyFXvx0WO8sNpgY
         U6STrlXQDi3/cV0UlcxFKibmgZCcFhUYEdnDlM8Q7xA3Tunf4BBOPsrtRfEosY6iFXwj
         O6C96FRls3n66dcQPWBHoiHqXoBcEIXyGBaRKLpeBWqefmZiajTtE9CHYjFd0scdLWuR
         bawYA1hWWeMSsoxNfm0RWwZCEg8YhSQXN2x7h7AwsrmdDtR8oFlDIeYRfL+iN/XungB0
         jSnQ==
X-Gm-Message-State: AOAM5309rjHi+elr2GN71UcQVRQUnNym9CSqnQ5k+XgVfYvKPU34q41c
        Fel5YAbkpEIwk2NFmt7sXD7J5ygKOdM/
X-Google-Smtp-Source: ABdhPJx077FrrQzngojinN9YIPS8DTnwKt1wyQ2e8JYS8VQR6eUnIjK3DYbihQXLLI0Y31FjLK4qjw==
X-Received: by 2002:a17:903:1211:b0:15e:8208:8cc0 with SMTP id l17-20020a170903121100b0015e82088cc0mr5844421plh.52.1652981136600;
        Thu, 19 May 2022 10:25:36 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:35 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 26/28] powerpc: Convert to printbuf
Date:   Thu, 19 May 2022 13:24:19 -0400
Message-Id: <20220519172421.162394-27-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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
index 984813a4d5..f6f7804516 100644
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
+				pr_buf(&s, "XXXXXXXX ");
 				continue;
 			}
-			seq_buf_printf(&s, regs->nip == pc ? "<%08x> " : "%08x ", instr);
+			pr_buf(&s, regs->nip == pc ? "<%08x> " : "%08x ", instr);
 		}
 
-		if (!seq_buf_has_overflowed(&s))
+		if (printbuf_remaining(&s))
 			pr_info("%s[%d]: code: %s\n", current->comm,
-				current->pid, s.buffer);
+				current->pid, s.buf);
 	}
 }
 
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index e159d4093d..5c9bad138c 100644
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
+		pr_buf(&s, "Mitigation: RFI Flush");
 		if (thread_priv)
-			seq_buf_printf(&s, ", L1D private per thread");
-
-		seq_buf_printf(&s, "\n");
-
-		return s.len;
+			pr_buf(&s, ", L1D private per thread");
+
+		pr_buf(&s, "\n");
+	} else if (thread_priv) {
+		pr_buf(&s, "Vulnerable: L1D private per thread\n");
+	} else if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
+		   !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR)) {
+		pr_buf(&s, "Not affected\n");
+	} else {
+		pr_buf(&s, "Vulnerable\n");
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
+			pr_buf(&s, "Mitigation: __user pointer sanitization");
 		else
-			seq_buf_printf(&s, "Vulnerable");
+			pr_buf(&s, "Vulnerable");
 
 		if (security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31))
-			seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+			pr_buf(&s, ", ori31 speculation barrier enabled");
 
-		seq_buf_printf(&s, "\n");
+		pr_buf(&s, "\n");
 	} else
-		seq_buf_printf(&s, "Not affected\n");
+		pr_buf(&s, "Not affected\n");
 
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
+		pr_buf(&s, "Mitigation: ");
 
 		if (bcs)
-			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+			pr_buf(&s, "Indirect branch serialisation (kernel only)");
 
 		if (bcs && ccd)
-			seq_buf_printf(&s, ", ");
+			pr_buf(&s, ", ");
 
 		if (ccd)
-			seq_buf_printf(&s, "Indirect branch cache disabled");
+			pr_buf(&s, "Indirect branch cache disabled");
 
 	} else if (count_cache_flush_type != BRANCH_CACHE_FLUSH_NONE) {
-		seq_buf_printf(&s, "Mitigation: Software count cache flush");
+		pr_buf(&s, "Mitigation: Software count cache flush");
 
 		if (count_cache_flush_type == BRANCH_CACHE_FLUSH_HW)
-			seq_buf_printf(&s, " (hardware accelerated)");
+			pr_buf(&s, " (hardware accelerated)");
 
 	} else if (btb_flush_enabled) {
-		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
+		pr_buf(&s, "Mitigation: Branch predictor state flush");
 	} else {
-		seq_buf_printf(&s, "Vulnerable");
+		pr_buf(&s, "Vulnerable");
 	}
 
 	if (bcs || ccd || count_cache_flush_type != BRANCH_CACHE_FLUSH_NONE) {
 		if (link_stack_flush_type != BRANCH_CACHE_FLUSH_NONE)
-			seq_buf_printf(&s, ", Software link stack flush");
+			pr_buf(&s, ", Software link stack flush");
 		if (link_stack_flush_type == BRANCH_CACHE_FLUSH_HW)
-			seq_buf_printf(&s, " (hardware accelerated)");
+			pr_buf(&s, " (hardware accelerated)");
 	}
 
-	seq_buf_printf(&s, "\n");
+	pr_buf(&s, "\n");
 
-	return s.len;
+	return printbuf_written(&s);
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index f48e87ac89..e55a9af397 100644
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
@@ -843,7 +843,7 @@ static ssize_t perf_stats_show(struct device *dev,
 {
 	int index;
 	ssize_t rc;
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	struct papr_scm_perf_stat *stat;
 	struct papr_scm_perf_stats *stats;
 	struct nvdimm *dimm = to_nvdimm(dev);
@@ -866,18 +866,17 @@ static ssize_t perf_stats_show(struct device *dev,
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
+		pr_buf(&s, "%.8s = 0x%016llX\n",
+		       stat->stat_id,
+		       be64_to_cpu(stat->stat_val));
 	}
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ?: printbuf_written(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -886,7 +885,7 @@ static ssize_t flags_show(struct device *dev,
 {
 	struct nvdimm *dimm = to_nvdimm(dev);
 	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	u64 health;
 	int rc;
 
@@ -897,29 +896,28 @@ static ssize_t flags_show(struct device *dev,
 	/* Copy health_bitmap locally, check masks & update out buffer */
 	health = READ_ONCE(p->health_bitmap);
 
-	seq_buf_init(&s, buf, PAGE_SIZE);
 	if (health & PAPR_PMEM_UNARMED_MASK)
-		seq_buf_printf(&s, "not_armed ");
+		pr_buf(&s, "not_armed ");
 
 	if (health & PAPR_PMEM_BAD_SHUTDOWN_MASK)
-		seq_buf_printf(&s, "flush_fail ");
+		pr_buf(&s, "flush_fail ");
 
 	if (health & PAPR_PMEM_BAD_RESTORE_MASK)
-		seq_buf_printf(&s, "restore_fail ");
+		pr_buf(&s, "restore_fail ");
 
 	if (health & PAPR_PMEM_ENCRYPTED)
-		seq_buf_printf(&s, "encrypted ");
+		pr_buf(&s, "encrypted ");
 
 	if (health & PAPR_PMEM_SMART_EVENT_MASK)
-		seq_buf_printf(&s, "smart_notify ");
+		pr_buf(&s, "smart_notify ");
 
 	if (health & PAPR_PMEM_SCRUBBED_AND_LOCKED)
-		seq_buf_printf(&s, "scrubbed locked ");
+		pr_buf(&s, "scrubbed locked ");
 
-	if (seq_buf_used(&s))
-		seq_buf_printf(&s, "\n");
+	if (printbuf_written(&s))
+		pr_buf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return printbuf_written(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.36.0

