Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87DD4E4353
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiCVPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiCVPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:51:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B969CF1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:50:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B85F1F38F;
        Tue, 22 Mar 2022 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647964203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0gBQScvwdVxKjyAG3NnuySYmJTXr2MBLbV0LSshhlNE=;
        b=afvnMB1oJlsl/b3emSQC6H8gKTFIKJg5Sc/SuVd6iP/V++emD24ObjlNEq4Xv6JNmb8o5z
        64M9iZG9MF92a5pRco8xDcqCCDNo5ST9NtI58QuqtL1DVMM/3ryb8mNpSMl5SESRX14yZh
        uNYkz1RkrTpIp3hOpN6/M/q8eInbatM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0871133B6;
        Tue, 22 Mar 2022 15:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oAPJLSrwOWJYVwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Mar 2022 15:50:02 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [PATCH] xen: fix is_xen_pmu()
Date:   Tue, 22 Mar 2022 16:50:01 +0100
Message-Id: <20220322155001.21979-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_xen_pmu() is taking the cpu number as parameter, but it is not using
it. Instead it just tests whether the Xen PMU initialization on the
current cpu did succeed. As this test is done by checking a percpu
pointer, preemption needs to be disabled in order to avoid switching
the cpu while doing the test. While resuming from suspend() this seems
not to be the case:

[   88.082751] ACPI: PM: Low-level resume complete
[   88.087933] ACPI: EC: EC started
[   88.091464] ACPI: PM: Restoring platform NVS memory
[   88.097166] xen_acpi_processor: Uploading Xen processor PM info
[   88.103850] Enabling non-boot CPUs ...
[   88.108128] installing Xen timer for CPU 1
[   88.112763] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-sleep/7138
[   88.122256] caller is is_xen_pmu+0x12/0x30
[   88.126937] CPU: 0 PID: 7138 Comm: systemd-sleep Tainted: G        W         5.16.13-2.fc32.qubes.x86_64 #1
[   88.137939] Hardware name: Star Labs StarBook/StarBook, BIOS 7.97 03/21/2022
[   88.145930] Call Trace:
[   88.148757]  <TASK>
[   88.151193]  dump_stack_lvl+0x48/0x5e
[   88.155381]  check_preemption_disabled+0xde/0xe0
[   88.160641]  is_xen_pmu+0x12/0x30
[   88.164441]  xen_smp_intr_init_pv+0x75/0x100

Fix that by replacing is_xen_pmu() by a simple boolean variable which
reflects the Xen PMU initialization state on cpu 0.

Modify xen_pmu_init() to return early in case it is being called for a
cpu other than cpu 0 and the boolean variable not being set.

Fixes: bf6dfb154d93 ("xen/PMU: PMU emulation code")
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/pmu.c    | 11 ++++++-----
 arch/x86/xen/pmu.h    |  3 ++-
 arch/x86/xen/smp_pv.c |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 89dd6b1708b0..0efe452eb13e 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -506,10 +506,7 @@ irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
-bool is_xen_pmu(int cpu)
-{
-	return (get_xenpmu_data() != NULL);
-}
+bool is_xen_pmu;
 
 void xen_pmu_init(int cpu)
 {
@@ -520,7 +517,7 @@ void xen_pmu_init(int cpu)
 
 	BUILD_BUG_ON(sizeof(struct xen_pmu_data) > PAGE_SIZE);
 
-	if (xen_hvm_domain())
+	if (xen_hvm_domain() || (cpu != 0 && !is_xen_pmu))
 		return;
 
 	xenpmu_data = (struct xen_pmu_data *)get_zeroed_page(GFP_KERNEL);
@@ -542,6 +539,7 @@ void xen_pmu_init(int cpu)
 	per_cpu(xenpmu_shared, cpu).flags = 0;
 
 	if (cpu == 0) {
+		is_xen_pmu = true;
 		perf_register_guest_info_callbacks(&xen_guest_cbs);
 		xen_pmu_arch_init();
 	}
@@ -572,4 +570,7 @@ void xen_pmu_finish(int cpu)
 
 	free_pages((unsigned long)per_cpu(xenpmu_shared, cpu).xenpmu_data, 0);
 	per_cpu(xenpmu_shared, cpu).xenpmu_data = NULL;
+
+	if (cpu == 0)
+		is_xen_pmu = false;
 }
diff --git a/arch/x86/xen/pmu.h b/arch/x86/xen/pmu.h
index 0e83a160589b..65c58894fc79 100644
--- a/arch/x86/xen/pmu.h
+++ b/arch/x86/xen/pmu.h
@@ -4,6 +4,8 @@
 
 #include <xen/interface/xenpmu.h>
 
+extern bool is_xen_pmu;
+
 irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id);
 #ifdef CONFIG_XEN_HAVE_VPMU
 void xen_pmu_init(int cpu);
@@ -12,7 +14,6 @@ void xen_pmu_finish(int cpu);
 static inline void xen_pmu_init(int cpu) {}
 static inline void xen_pmu_finish(int cpu) {}
 #endif
-bool is_xen_pmu(int cpu);
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err);
 bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err);
 int pmu_apic_update(uint32_t reg);
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 4a6019238ee7..688aa8b6ae29 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -129,7 +129,7 @@ int xen_smp_intr_init_pv(unsigned int cpu)
 	per_cpu(xen_irq_work, cpu).irq = rc;
 	per_cpu(xen_irq_work, cpu).name = callfunc_name;
 
-	if (is_xen_pmu(cpu)) {
+	if (is_xen_pmu) {
 		pmu_name = kasprintf(GFP_KERNEL, "pmu%d", cpu);
 		rc = bind_virq_to_irqhandler(VIRQ_XENPMU, cpu,
 					     xen_pmu_irq_handler,
-- 
2.34.1

