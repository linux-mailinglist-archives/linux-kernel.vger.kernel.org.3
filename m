Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC514FA11D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiDIBaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240263AbiDIB3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010DA107A91;
        Fri,  8 Apr 2022 18:27:27 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wd+X6w6qGPdRDeh9NXXbO/1wQAvgPr8tuO8HEb4PaB4=;
        b=E9hFhmC5CZ00onnAZyP73LDXVxDP6wIpCFHRccdkEraMDG0ejaYeTb2dc4w++ujPzVYodP
        oGAIO0/6qWuoo5uUMP0JK71GlZ66IWLlCQL4QwJeHECaalFEtE7VBbYpXzP0bTB0gZd/mL
        V+2gSaVkhX9kFQri04gfzH3MC+06W2b4MKQERlhtjk//yHxSQkDJKwodeOijWtgzF3JxNQ
        raZiIq9ii5pM3VfzTN+ioxPvfds5xP7PHYgfu9ZjSsqEzgDscwZBE+9C34p7sMPL5PeRoE
        zxvkGfcWIpaYXMzfkZF9KcDDxoNiKYzKPTzi0utGzPUKce6L4Piqb4HIZnB8yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wd+X6w6qGPdRDeh9NXXbO/1wQAvgPr8tuO8HEb4PaB4=;
        b=3L1cuL41n1ztDnmnuKiX69cGNthc43UbrF/0Vw7g758BkoK82eW0JGR38qc2DSxNEabmtW
        yzenJbMN282aTkDQ==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/acpi/x86/boot: Add multiprocessor wake-up support
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-22-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-22-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764561.4207.3385809780690620067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     f39642d0dbacded8b4a816a9197a73efb74e5702
Gitweb:        https://git.kernel.org/tip/f39642d0dbacded8b4a816a9197a73efb74e5702
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:30 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:53 -07:00

x86/acpi/x86/boot: Add multiprocessor wake-up support

Secondary CPU startup is currently performed with something called
the "INIT/SIPI protocol".  This protocol requires assistance from
VMMs to boot guests.  As should be a familiar story by now, that
support can not be provded to TDX guests because TDX VMMs are
not trusted by guests.

To remedy this situation a new[1] "Multiprocessor Wakeup Structure"
has been added to to an existing ACPI table (MADT).  This structure
provides the physical address of a "mailbox".  A write to the mailbox
then steers the secondary CPU to the boot code.

Add ACPI MADT wake structure parsing support and wake support.  Use
this support to wake CPUs whenever it is present instead of INIT/SIPI.

While this structure can theoretically be used on 32-bit kernels,
there are no 32-bit TDX guest kernels.  It has not been tested and
can not practically *be* tested on 32-bit.  Make it 64-bit only.

1. Details about the new structure can be found in ACPI v6.4, in the
   "Multiprocessor Wakeup Structure" section.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-22-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/apic.h |  5 ++-
 arch/x86/kernel/acpi/boot.c | 93 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/apic/apic.c | 10 ++++-
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 35006e1..bd8ae0a 100644
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
index 0d01e7f..6d2c508 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -65,6 +65,13 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 static bool acpi_support_online_capable;
 #endif
 
+#ifdef CONFIG_X86_64
+/* Physical address of the Multiprocessor Wakeup Structure mailbox */
+static u64 acpi_mp_wake_mailbox_paddr;
+/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+#endif
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -336,7 +343,60 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	return 0;
 }
 
-#endif				/*CONFIG_X86_LOCAL_APIC */
+#ifdef CONFIG_X86_64
+static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+{
+	/*
+	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
+	 *
+	 * Wakeup of secondary CPUs is fully serialized in the core code.
+	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
+	 */
+	if (!acpi_mp_wake_mailbox) {
+		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+						sizeof(*acpi_mp_wake_mailbox),
+						MEMREMAP_WB);
+	}
+
+	/*
+	 * Mailbox memory is shared between the firmware and OS. Firmware will
+	 * listen on mailbox command address, and once it receives the wakeup
+	 * command, the CPU associated with the given apicid will be booted.
+	 *
+	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
+	 * firmware before the wakeup command is visible.  smp_store_release()
+	 * ensures ordering and visibility.
+	 */
+	acpi_mp_wake_mailbox->apic_id	    = apicid;
+	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
+	smp_store_release(&acpi_mp_wake_mailbox->command,
+			  ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	/*
+	 * Wait for the CPU to wake up.
+	 *
+	 * The CPU being woken up is essentially in a spin loop waiting to be
+	 * woken up. It should not take long for it wake up and acknowledge by
+	 * zeroing out ->command.
+	 *
+	 * ACPI specification doesn't provide any guidance on how long kernel
+	 * has to wait for a wake up acknowledgement. It also doesn't provide
+	 * a way to cancel a wake up request if it takes too long.
+	 *
+	 * In TDX environment, the VMM has control over how long it takes to
+	 * wake up secondary. It can postpone scheduling secondary vCPU
+	 * indefinitely. Giving up on wake up request and reporting error opens
+	 * possible attack vector for VMM: it can wake up a secondary CPU when
+	 * kernel doesn't expect it. Wait until positive result of the wake up
+	 * request.
+	 */
+	while (READ_ONCE(acpi_mp_wake_mailbox->command))
+		cpu_relax();
+
+	return 0;
+}
+#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
 #define MP_ISA_BUS		0
@@ -1083,6 +1143,29 @@ static int __init acpi_parse_madt_lapic_entries(void)
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
@@ -1278,6 +1361,14 @@ static void __init acpi_process_madt(void)
 
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
index b70344b..3c8f2c7 100644
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
