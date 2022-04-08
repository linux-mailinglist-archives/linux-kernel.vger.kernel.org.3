Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42CF4F91B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiDHJP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiDHJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD71E817D;
        Fri,  8 Apr 2022 02:09:07 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BE/OIb5u0XTY6f1jd+KD5smXzWqESOQU9geL5IMJ4Nk=;
        b=tiVlsFnYMWYfAnX5L2WiPTdrMZUthUB/fVm5KoeiieVdYs7t0zqa6k6xtkjI8DWWLUJb6t
        UQn8pq+AhemtWcdBt9PptrWp1kuVQ2VsreG4VFfHHFPf4JKGiIz9Go6Ev/j9kqkNmzGG4i
        lML9n+pOcGjhDGNwyN1Yfsa7RA5YSZ/U5fZy1NofQQ4prLebF3sF/81uGc/TJoGRxWURrx
        z2TMTDaQojMuukEZSQd5/frvLXKK/XAsGfAcFjJxOZv7T1SRbE6C1KVCuzq9gUqbQddL7e
        QZJt08v1VV6ugpNtvOTEWghsqUtGvmDd+j/2ujaSUFaXBir+pB7/GoKctmNSBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BE/OIb5u0XTY6f1jd+KD5smXzWqESOQU9geL5IMJ4Nk=;
        b=xQbmoZ8zIP5HVm/+WkQM6L83VD8IEjeW60BK9y6uuXUUqgfG8BOW78aSOAUyUF1Z8p2OKO
        +9NUXHOdDMNpHWCg==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Register GHCB memory when SEV-SNP is active
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-18-brijesh.singh@amd.com>
References: <20220307213356.2797205-18-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894472.389.321444368930364607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     95d33bfaa3e169cfec1926e0d0f0c6b0ea75d763
Gitweb:        https://git.kernel.org/tip/95d33bfaa3e169cfec1926e0d0f0c6b0ea75d763
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:11 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:16:58 +02:00

x86/sev: Register GHCB memory when SEV-SNP is active

The SEV-SNP guest is required by the GHCB spec to register the GHCB's
Guest Physical Address (GPA). This is because the hypervisor may prefer
that a guest uses a consistent and/or specific GPA for the GHCB associated
with a vCPU. For more information, see the GHCB specification section
"GHCB GPA Registration".

  [ bp: Cleanup comments. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-18-brijesh.singh@amd.com
---
 arch/x86/include/asm/sev.h   |  2 ++-
 arch/x86/kernel/cpu/common.c |  4 +++-
 arch/x86/kernel/head64.c     |  4 ++-
 arch/x86/kernel/sev-shared.c |  2 +-
 arch/x86/kernel/sev.c        | 46 +++++++++++++++++++++++++----------
 5 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e374518..48df027 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -122,6 +122,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+void setup_ghcb(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -130,6 +131,7 @@ static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
+static inline void setup_ghcb(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ed44175..9e45521 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -60,6 +60,7 @@
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
 #include <asm/traps.h>
+#include <asm/sev.h>
 
 #include "cpu.h"
 
@@ -2124,6 +2125,9 @@ void cpu_init_exception_handling(void)
 
 	load_TR_desc();
 
+	/* GHCB needs to be setup to handle #VC. */
+	setup_ghcb();
+
 	/* Finally load the IDT */
 	load_current_idt();
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index cbc285d..83514b9 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -597,8 +597,10 @@ static void startup_64_load_idt(unsigned long physbase)
 void early_setup_idt(void)
 {
 	/* VMM Communication Exception */
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		setup_ghcb();
 		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_boot_ghcb);
+	}
 
 	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
 	native_load_idt(&bringup_idt_descr);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index e9ff13c..3aaef1a 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -68,7 +68,7 @@ static u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
-static void __maybe_unused snp_register_ghcb_early(unsigned long paddr)
+static void snp_register_ghcb_early(unsigned long paddr)
 {
 	unsigned long pfn = paddr >> PAGE_SHIFT;
 	u64 val;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index cb20fb0..39c8746 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -41,7 +41,7 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  * Needs to be in the .data section because we need it NULL before bss is
  * cleared
  */
-static struct ghcb __initdata *boot_ghcb;
+static struct ghcb *boot_ghcb __section(".data");
 
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
@@ -647,15 +647,39 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-/*
- * This function runs on the first #VC exception after the kernel
- * switched to virtual addresses.
- */
-static bool __init sev_es_setup_ghcb(void)
+static void snp_register_per_cpu_ghcb(void)
 {
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	snp_register_ghcb_early(__pa(ghcb));
+}
+
+void setup_ghcb(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return;
+
 	/* First make sure the hypervisor talks a supported protocol. */
 	if (!sev_es_negotiate_protocol())
-		return false;
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
+	/*
+	 * Check whether the runtime #VC exception handler is active. It uses
+	 * the per-CPU GHCB page which is set up by sev_es_init_vc_handling().
+	 *
+	 * If SNP is active, register the per-CPU GHCB page so that the runtime
+	 * exception handler can use it.
+	 */
+	if (initial_vc_handler == (unsigned long)kernel_exc_vmm_communication) {
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			snp_register_per_cpu_ghcb();
+
+		return;
+	}
 
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
@@ -666,7 +690,9 @@ static bool __init sev_es_setup_ghcb(void)
 	/* Alright - Make the boot-ghcb public */
 	boot_ghcb = &boot_ghcb_page;
 
-	return true;
+	/* SNP guest requires that GHCB GPA must be registered. */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1397,10 +1423,6 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
 	vc_ghcb_invalidate(boot_ghcb);
 
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
