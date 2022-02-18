Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91C54BBD56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiBRQSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiBRQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:56 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3243A5DF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201047; x=1676737047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EvrY+fLFyt0AjjIeJc3eqvET5iI6uNtGs7idg2+y+vU=;
  b=VSgIWMrTKY3bZ+lmmdahzUxa7k6KHgZZBRoRqHLwhTl85EPPGg6Srjn7
   UPnyWFlfU3S7Kxf1MI1jDaip12DCrIt1Lk5m6Fw4QMR+X+CVqZHVGmhEw
   4yA8LhS/bJaLt9gNMAQWCFonnn3t0cnsX92l06sy2f/fUbsSp4sUCiOUb
   1RouX4KUW60DefjKnE4P8W91kuJVlke7TUZY+PA0M7kG8ohA/KFWNbNcQ
   90ElRPSqh0rFt6tzVXF98wICdU01PG7JT7ZQGH8R6RvGgKpURn0+b1B0b
   /pUQjaWEWzj/X/13dYVABGohyM/Ad9OEZA7sprcgyr5eyFhP2YRjDXtJy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311897906"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="311897906"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="775328286"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Feb 2022 08:17:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 21A2BD06; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 22/32] x86/acpi, x86/boot: Add multiprocessor wake-up support
Date:   Fri, 18 Feb 2022 19:17:08 +0300
Message-Id: <20220218161718.67148-23-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

TDX cannot use INIT/SIPI protocol to bring up secondary CPUs because it
requires assistance from untrusted VMM.

For platforms that do not support SIPI/INIT, ACPI defines a wakeup
model (using mailbox) via MADT multiprocessor wakeup structure. More
details about it can be found in ACPI specification v6.4, the section
titled "Multiprocessor Wakeup Structure". If a platform firmware
produces the multiprocessor wakeup structure, then OS may use this
new mailbox-based mechanism to wake up the APs.

Add ACPI MADT wake structure parsing support for x86 platform and if
MADT wake table is present, update apic->wakeup_secondary_cpu_64 with
new API which uses MADT wake mailbox to wake-up CPU.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/apic.h |   5 ++
 arch/x86/kernel/acpi/boot.c | 118 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/apic.c |  10 +++
 3 files changed, 133 insertions(+)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 35006e151774..bd8ae0a7010a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -490,6 +490,11 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
+#ifdef CONFIG_X86_64
+typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
+extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
+#endif
+
 extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 5b6d1a95776f..99518eac2bbc 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -65,6 +65,15 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 static bool acpi_support_online_capable;
 #endif
 
+#ifdef CONFIG_X86_64
+/* Physical address of the Multiprocessor Wakeup Structure mailbox */
+static u64 acpi_mp_wake_mailbox_paddr;
+/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+/* Lock to protect mailbox (acpi_mp_wake_mailbox) from parallel access */
+static DEFINE_SPINLOCK(mailbox_lock);
+#endif
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -336,6 +345,84 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
+/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
+static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+{
+	static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
+	u8 timeout;
+
+	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
+	if (physids_empty(apic_id_wakemap)) {
+		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+						sizeof(*acpi_mp_wake_mailbox),
+						MEMREMAP_WB);
+	}
+
+	/*
+	 * According to the ACPI specification r6.4, section titled
+	 * "Multiprocessor Wakeup Structure" the mailbox-based wakeup
+	 * mechanism cannot be used more than once for the same CPU.
+	 * Skip wakeups if they are attempted more than once.
+	 */
+	if (physid_isset(apicid, apic_id_wakemap)) {
+		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
+		       apicid);
+		return -EINVAL;
+	}
+
+	spin_lock(&mailbox_lock);
+
+	/*
+	 * Mailbox memory is shared between firmware and OS. Firmware will
+	 * listen on mailbox command address, and once it receives the wakeup
+	 * command, CPU associated with the given apicid will be booted.
+	 *
+	 * The value of apic_id and wakeup_vector has to be set before updating
+	 * the wakeup command. To let compiler preserve order of writes, use
+	 * smp_store_release.
+	 */
+	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
+	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
+	smp_store_release(&acpi_mp_wake_mailbox->command,
+			  ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	/*
+	 * After writing the wakeup command, wait for maximum timeout of 0xFF
+	 * for firmware to reset the command address back zero to indicate
+	 * the successful reception of command.
+	 * NOTE: 0xFF as timeout value is decided based on our experiments.
+	 *
+	 * XXX: Change the timeout once ACPI specification comes up with
+	 *      standard maximum timeout value.
+	 */
+	timeout = 0xFF;
+	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
+		cpu_relax();
+
+	/* If timed out (timeout == 0), return error */
+	if (!timeout) {
+		/*
+		 * XXX: Is there a recovery path after timeout is hit?
+		 * Spec is unclear. Reset command to 0 if timeout is hit.
+		 */
+		acpi_mp_wake_mailbox->command = 0;
+		spin_unlock(&mailbox_lock);
+		return -EIO;
+	}
+
+	/*
+	 * If the CPU wakeup process is successful, store the
+	 * status in apic_id_wakemap to prevent re-wakeup
+	 * requests.
+	 */
+	physid_set(apicid, apic_id_wakemap);
+
+	spin_unlock(&mailbox_lock);
+
+	return 0;
+}
+#endif
 #endif				/*CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1083,6 +1170,29 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	}
 	return 0;
 }
+
+#ifdef CONFIG_X86_64
+static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+				     const unsigned long end)
+{
+	struct acpi_madt_multiproc_wakeup *mp_wake;
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -ENODEV;
+
+	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
+	if (BAD_MADT_ENTRY(mp_wake, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+
+	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
+
+	return 0;
+}
+#endif				/* CONFIG_X86_64 */
 #endif				/* CONFIG_X86_LOCAL_APIC */
 
 #ifdef	CONFIG_X86_IO_APIC
@@ -1278,6 +1388,14 @@ static void __init acpi_process_madt(void)
 
 				smp_found_config = 1;
 			}
+
+#ifdef CONFIG_X86_64
+			/*
+			 * Parse MADT MP Wake entry.
+			 */
+			acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
+					      acpi_parse_mp_wake, 1);
+#endif
 		}
 		if (error == -EINVAL) {
 			/*
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344bf6600..3c8f2c797a98 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2551,6 +2551,16 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
 }
 EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
 
+#ifdef CONFIG_X86_64
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu_64 = handler;
+}
+#endif
+
 /*
  * Override the generic EOI implementation with an optimized version.
  * Only called during early boot when only one CPU is active and with
-- 
2.34.1

