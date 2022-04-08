Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E084F91BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiDHJOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiDHJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A73B1BB830;
        Fri,  8 Apr 2022 02:09:03 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BMYM664e5WUWwfhSn6BWyrA4zpsuYRZ7AQzv6u6sRo=;
        b=Yo+FGYgMbl7ycuaIPiBGVitkl32+Y899KxjUN9JKCO+VgeBOlVRbpGcw/2A9vXSLhaLz5J
        pNlixojcdE4tkxsN0RAHsxWJLa/aE9+MtV72bAsFU8jcJC3UdAKIWfQv7nlOEkwXv5u8JB
        SFpQWS8kXpHSNATNaHhKo95eplpqSvJSR/dPoBjxp6XQMXWXANXqPvhmhaGHWamRsLmLXc
        /4RIRFKJEewySXudcm0MbYUdnyXNEA5OeYNsPz1eUvDN8CBdbm7zEJX4QfoYL7RiHROSG9
        E9/tVxVSXIrMR/WNNddhDnEbb6CVS1hGQiG55eBj9UYzWA/nPs/7p7OzBs5UQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BMYM664e5WUWwfhSn6BWyrA4zpsuYRZ7AQzv6u6sRo=;
        b=mtccUqiO/M4lDgOrj0Jm3ebSd+JrqHhWSmh7V2uxO9wfruXfRZVL42pfynmTR+tumsCAhF
        pKHWt2RTFdUxKnCA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Use SEV-SNP AP creation to start secondary CPUs
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-23-brijesh.singh@amd.com>
References: <20220307213356.2797205-23-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894048.389.4048882648177694646.tip-bot2@tip-bot2>
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

Commit-ID:     0afb6b660a6b58cb336d1175ed687bf9525849a4
Gitweb:        https://git.kernel.org/tip/0afb6b660a6b58cb336d1175ed687bf9525849a4
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Mar 2022 15:33:32 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 17:06:49 +02:00

x86/sev: Use SEV-SNP AP creation to start secondary CPUs

To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
AP Creation NAE event. This allows for guest control over the AP register
state rather than trusting the hypervisor with the SEV-ES Jump Table
address.

During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
SEV-SNP is active, will set/override apic->wakeup_secondary_cpu. This
will allow the SEV-SNP AP Creation NAE event method to be used to boot
the APs. As a result of installing the override when SEV-SNP is active,
this method of starting the APs becomes the required method. The override
function will fail to start the AP if the hypervisor does not have
support for AP creation.

  [ bp: Work in forgotten review comments. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-23-brijesh.singh@amd.com
---
 arch/x86/include/asm/sev-common.h |   1 +-
 arch/x86/include/asm/sev.h        |   4 +-
 arch/x86/include/uapi/asm/svm.h   |   5 +-
 arch/x86/kernel/sev.c             | 242 +++++++++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c         |   3 +-
 5 files changed, 255 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1aa72b5..e9b6815 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -104,6 +104,7 @@ enum psc_op {
 	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
+#define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
 
 /* SNP Page State Change NAE event */
 #define VMGEXIT_PSC_MAX_ENTRY		253
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index feeb93e..a3203b2 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -66,6 +66,8 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 
+#define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -130,6 +132,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
+void snp_set_wakeup_secondary_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -146,6 +149,7 @@ early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned i
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_wakeup_secondary_cpu(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 64404b4..cfea5e8 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,10 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_AP_CREATION			0x80000013
+#define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
+#define SVM_VMGEXIT_AP_CREATE			1
+#define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
@@ -221,6 +225,7 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,		"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index bf4b578..d7915ae 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -31,9 +32,26 @@
 #include <asm/svm.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 
 #define DR7_RESET_VALUE        0x400
 
+/* AP INIT values as documented in the APM2  section "Processor Initialization State" */
+#define AP_INIT_CS_LIMIT		0xffff
+#define AP_INIT_DS_LIMIT		0xffff
+#define AP_INIT_LDTR_LIMIT		0xffff
+#define AP_INIT_GDTR_LIMIT		0xffff
+#define AP_INIT_IDTR_LIMIT		0xffff
+#define AP_INIT_TR_LIMIT		0xffff
+#define AP_INIT_RFLAGS_DEFAULT		0x2
+#define AP_INIT_DR6_DEFAULT		0xffff0ff0
+#define AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define AP_INIT_XCR0_DEFAULT		0x1
+#define AP_INIT_X87_FTW_DEFAULT		0x5555
+#define AP_INIT_X87_FCW_DEFAULT		0x0040
+#define AP_INIT_CR0_DEFAULT		0x60000010
+#define AP_INIT_MXCSR_DEFAULT		0x1f80
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
@@ -90,6 +108,8 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
+static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -823,6 +843,228 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	pvalidate_pages(vaddr, npages, true);
 }
 
+static int snp_set_vmsa(void *va, bool vmsa)
+{
+	u64 attrs;
+
+	/*
+	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
+	 * using the RMPADJUST instruction. However, for the instruction to
+	 * succeed it must target the permissions of a lesser privileged
+	 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
+	 * instruction in the AMD64 APM Volume 3).
+	 */
+	attrs = 1;
+	if (vmsa)
+		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+}
+
+#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
+#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
+#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
+
+#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
+#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
+
+static void *snp_alloc_vmsa_page(void)
+{
+	struct page *p;
+
+	/*
+	 * Allocate VMSA page to work around the SNP erratum where the CPU will
+	 * incorrectly signal an RMP violation #PF if a large page (2MB or 1GB)
+	 * collides with the RMP entry of VMSA page. The recommended workaround
+	 * is to not use a large page.
+	 *
+	 * Allocate an 8k page which is also 8k-aligned.
+	 */
+	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
+	if (!p)
+		return NULL;
+
+	split_page(p, 1);
+
+	/* Free the first 4k. This page may be 2M/1G aligned and cannot be used. */
+	__free_page(p);
+
+	return page_address(p + 1);
+}
+
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
+{
+	int err;
+
+	err = snp_set_vmsa(vmsa, false);
+	if (err)
+		pr_err("clear VMSA page failed (%u), leaking page\n", err);
+	else
+		free_page((unsigned long)vmsa);
+}
+
+static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+{
+	struct sev_es_save_area *cur_vmsa, *vmsa;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	u8 sipi_vector;
+	int cpu, ret;
+	u64 cr4;
+
+	/*
+	 * The hypervisor SNP feature support check has happened earlier, just check
+	 * the AP_CREATION one here.
+	 */
+	if (!(sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Verify the desired start IP against the known trampoline start IP
+	 * to catch any future new trampolines that may be introduced that
+	 * would require a new protected guest entry point.
+	 */
+	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
+		      "Unsupported SNP start_ip: %lx\n", start_ip))
+		return -EINVAL;
+
+	/* Override start_ip with known protected guest start IP */
+	start_ip = real_mode_header->sev_es_trampoline_start;
+
+	/* Find the logical CPU for the APIC ID */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apic_id))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	cur_vmsa = per_cpu(sev_vmsa, cpu);
+
+	/*
+	 * A new VMSA is created each time because there is no guarantee that
+	 * the current VMSA is the kernels or that the vCPU is not running. If
+	 * an attempt was done to use the current VMSA with a running vCPU, a
+	 * #VMEXIT of that vCPU would wipe out all of the settings being done
+	 * here.
+	 */
+	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page();
+	if (!vmsa)
+		return -ENOMEM;
+
+	/* CR4 should maintain the MCE value */
+	cr4 = native_read_cr4() & X86_CR4_MCE;
+
+	/* Set the CS value based on the start_ip converted to a SIPI vector */
+	sipi_vector		= (start_ip >> 12);
+	vmsa->cs.base		= sipi_vector << 12;
+	vmsa->cs.limit		= AP_INIT_CS_LIMIT;
+	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
+	vmsa->cs.selector	= sipi_vector << 8;
+
+	/* Set the RIP value based on start_ip */
+	vmsa->rip		= start_ip & 0xfff;
+
+	/* Set AP INIT defaults as documented in the APM */
+	vmsa->ds.limit		= AP_INIT_DS_LIMIT;
+	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
+	vmsa->es		= vmsa->ds;
+	vmsa->fs		= vmsa->ds;
+	vmsa->gs		= vmsa->ds;
+	vmsa->ss		= vmsa->ds;
+
+	vmsa->gdtr.limit	= AP_INIT_GDTR_LIMIT;
+	vmsa->ldtr.limit	= AP_INIT_LDTR_LIMIT;
+	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
+	vmsa->idtr.limit	= AP_INIT_IDTR_LIMIT;
+	vmsa->tr.limit		= AP_INIT_TR_LIMIT;
+	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
+
+	vmsa->cr4		= cr4;
+	vmsa->cr0		= AP_INIT_CR0_DEFAULT;
+	vmsa->dr7		= DR7_RESET_VALUE;
+	vmsa->dr6		= AP_INIT_DR6_DEFAULT;
+	vmsa->rflags		= AP_INIT_RFLAGS_DEFAULT;
+	vmsa->g_pat		= AP_INIT_GPAT_DEFAULT;
+	vmsa->xcr0		= AP_INIT_XCR0_DEFAULT;
+	vmsa->mxcsr		= AP_INIT_MXCSR_DEFAULT;
+	vmsa->x87_ftw		= AP_INIT_X87_FTW_DEFAULT;
+	vmsa->x87_fcw		= AP_INIT_X87_FCW_DEFAULT;
+
+	/* SVME must be set. */
+	vmsa->efer		= EFER_SVME;
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl		= 0;
+	vmsa->sev_features	= sev_status >> 2;
+
+	/* Switch the page over to a VMSA page now that it is initialized */
+	ret = snp_set_vmsa(vmsa, true);
+	if (ret) {
+		pr_err("set VMSA page failed (%u)\n", ret);
+		free_page((unsigned long)vmsa);
+
+		return -EINVAL;
+	}
+
+	/* Issue VMGEXIT AP Creation NAE event */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_rax(ghcb, vmsa->sev_features);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
+	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+		pr_err("SNP AP Creation error\n");
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Perform cleanup if there was an error */
+	if (ret) {
+		snp_cleanup_vmsa(vmsa);
+		vmsa = NULL;
+	}
+
+	/* Free up any previous VMSA page */
+	if (cur_vmsa)
+		snp_cleanup_vmsa(cur_vmsa);
+
+	/* Record the current VMSA page */
+	per_cpu(sev_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
+void snp_set_wakeup_secondary_cpu(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	/*
+	 * Always set this override if SNP is enabled. This makes it the
+	 * required method to start APs under SNP. If the hypervisor does
+	 * not support AP creation, then no APs will be started.
+	 */
+	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 2ef1477..85d7b1c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
+#include <asm/sev.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1430,6 +1431,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	snp_set_wakeup_secondary_cpu();
 }
 
 void arch_thaw_secondary_cpus_begin(void)
