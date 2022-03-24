Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A54E65F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347796AbiCXPZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiCXPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:25:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A4B1DA4D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648135442; x=1679671442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAhU5polx5xf++8y43PT5whnDwNUuBK5LppJqvSn29o=;
  b=h1BZgxmOyAHCt+hfNJglBjnWAcIGmiy2dL6pj68zvzmj0Pzl+5S3qnU2
   qRvlV3FH8rOE5w2hBOoXaKgXmkJ3hcJ8K50UfqF2uOEe960ovyExdYYYn
   vyhHbcbR1zKTPRthBIIxoxUEd+kLfFsIMEcMj1rqM5n9urYuToCznqHlP
   Rfi9A5xmROqqKoV+EOTheex7kSGGRhsgdjiEjL4NcYwbuVMZUU8FYCmRu
   9g7PewbB+8aVk5RZIMjjCpLSzN2g42bwEzaVtIvPzAHp1wsffG0kUFIHX
   ZDCW7v7s6Bmj4Wpj+XXUXJXBDxB0GGU6pBcr9jAYhTiJjZ1+o9u+wZqlC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="283264867"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="283264867"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 08:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="584116165"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2022 08:23:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 09F9D1D9; Thu, 24 Mar 2022 17:24:15 +0200 (EET)
Date:   Thu, 24 Mar 2022 18:24:15 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCHv7 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
Message-ID: <20220324152415.grt6xvhblmd4uccu@black.fi.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
 <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:23:59AM -0700, Dave Hansen wrote:
> On 3/18/22 08:30, Kirill A. Shutemov wrote:
> > +	/*
> > +	 * After writing the wakeup command, wait for maximum timeout of 0xFF
> > +	 * for firmware to reset the command address back zero to indicate
> > +	 * the successful reception of command.
> > +	 * NOTE: 0xFF as timeout value is decided based on our experiments.
> > +	 *
> > +	 * XXX: Change the timeout once ACPI specification comes up with
> > +	 *      standard maximum timeout value.
> > +	 */
> > +	timeout = 0xFF;
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> > +		cpu_relax();
> 
> I don't feel like this was ever actually resolved.  This timeout
> basically boiled down to "this value seems to work for us".  There are
> also *SURELY* timeouts that are going to happen here.

It makes me think if it can be an attack vector: once kernel initiated
wake up of a secondary vCPU it has no control on how long it takes.

I worry that malicious VMM can induce timeout intentionally, but then wake
up the secondary CPU when kernel doesn't expect it. After quick look I was
not able to convince myself that kernel can deal with this without a
problem.

Is it legitimate concern?

Patch below drops timeout handling completely. Any opinions?

Other option would be to check in the trampoline code that initiated wake
up is legitimate. But it should only be untrue if VMM acting weird (or
virtual BIOS is buggy). I don't think it's right side to deal with the
problem.

> >         /*
> >          * If the CPU wakeup process is successful, store the
> >          * status in apic_id_wakemap to prevent re-wakeup
> >          * requests.
> >          */
> >         physid_set(apicid, apic_id_wakemap);
> > 
> >         return 0;
> > }
> 
> If this goes wrong, won't the new wakeup just timeout?  Do we really
> need a dedicated mechanism to stop re-wakeups?  How much of a problem is
> this going to be?

Well, it can provide a proper diagnostics and a distinct error code. If
you think it is unneeded we can drop it.

From bae59d6e8873a90db5041b6e08e1725d16b57132 Mon Sep 17 00:00:00 2001
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Thu, 15 Apr 2021 10:31:38 -0700
Subject: [PATCH] x86/acpi, x86/boot: Add multiprocessor wake-up support

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
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/apic.h |   5 ++
 arch/x86/kernel/acpi/boot.c | 114 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/apic/apic.c |  10 ++++
 3 files changed, 128 insertions(+), 1 deletion(-)

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
index 5b6d1a95776f..7ec04234dc74 100644
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
@@ -336,7 +343,81 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	return 0;
 }
 
-#endif				/*CONFIG_X86_LOCAL_APIC */
+#ifdef CONFIG_X86_64
+static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+{
+	static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
+
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
+	/*
+	 * If the CPU wakeup process is successful, store the
+	 * status in apic_id_wakemap to prevent re-wakeup
+	 * requests.
+	 */
+	physid_set(apicid, apic_id_wakemap);
+
+	return 0;
+}
+#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
 #define MP_ISA_BUS		0
@@ -1083,6 +1164,29 @@ static int __init acpi_parse_madt_lapic_entries(void)
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
@@ -1278,6 +1382,14 @@ static void __init acpi_process_madt(void)
 
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
 Kirill A. Shutemov
