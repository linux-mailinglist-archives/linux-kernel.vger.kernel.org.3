Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3904ED170
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352392AbiCaByX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352384AbiCaByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:54:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B7648E76
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648691554; x=1680227554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=URlO580spTiaVdZpvUyPG1TBeyW5elttFCgONtTbcDs=;
  b=dvWLC/ZhWBVznOZV2uMY+pxBtI0Iqb1gqBuXeQRr/AM5GuZ/pm9Dtvr5
   HOBzP/VVe/D0EPqGg6WHWVJKVNFxZ8rpV1w5dOsy0IN3LrXA+e89rB7Kj
   8mz9r/fHcqiQPvck8eiPGcxoJ8jcp9EV/d/trzS1M1PsWDUqvWyukLGu5
   uyZZCbWdYthwoWu9EY/CCHq1+cxZyuMqRvbqvvNArcwmP9ksVu/wh4Gj1
   5SFHjI1yKWJGssg86ZBPiCoNBKcIdG7hNHUGqCDOKP4prrJORmxIgpie6
   MjARS1NMnPPZJe/81BqfP+Gceblc5loPG26Bhl9CGhb901r3yZTYXu41O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258519793"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="258519793"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="639935658"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2022 18:52:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DE451144; Thu, 31 Mar 2022 04:52:39 +0300 (EEST)
Date:   Thu, 31 Mar 2022 04:52:39 +0300
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
Message-ID: <20220331015239.h7bihbfjq4xfrhyj@black.fi.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
 <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
 <20220324152415.grt6xvhblmd4uccu@black.fi.intel.com>
 <4c0c05a8-08f2-7d5d-6746-a92d0d3c5ef0@intel.com>
 <20220330231609.ymxekzgdp2pd7gfy@black.fi.intel.com>
 <9e84cdea-754c-1864-4c54-66beeba7f921@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e84cdea-754c-1864-4c54-66beeba7f921@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:44:13PM -0700, Dave Hansen wrote:
> On 3/30/22 16:16, Kirill A. Shutemov wrote:
> > On Mon, Mar 28, 2022 at 12:17:35PM -0700, Dave Hansen wrote:
> >> Is there anything in the trampoline code or start_secondary() that would
> >> cause damage if it got run later than the kernel expects?
> > 
> > I didn't find anything specific.
> > 
> > But I tried to simulate similar scenario by returning -EIO just after
> > writing wake up command in acpi_wakeup_cpu(). System booted, but there is
> > a warning in the dmesg:
> > 
> > WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:210 irq_startup+0x2a3/0x2b0
> > 
> > System seems recovered fine, but I'm not sure what will happen if
> > wake up is delayed by VMM.
> 
> That shouldn't be too hard to simulate.  Just add a spin loop at the
> beginning of start_secondary() that can spin for grotesque amounts of
> time and have it get more grotesque with each CPU that boots.

I tried to play a bit with delay on start_secondary() side, but I failed
to find anything new.

> If you're still booting CPUs when userspace comes up, you've done as
> much damage as possible.
> 
> But, I do think there are two relatively discrete problems here:
> 1. How long do we wait for a secondary CPU to actually ack the MADT
>    wakeup?  (the answer might be "don't wait").

"don't wait" actually leads to wait in do_boot_cpu(): successful wake up
call leads to 10s wait for sign of life from the secondary CPU.

> 2. How do we verify that a woken-up CPU actually booted all the way?
> 
> Even if #1 is a loooooong time, it might get stalled before it fully boots.

Right. "booted all the way" hard to define. It can be cut off at any
point by VMM.
> 
> So, for this patch, let's just remove the timeout.  If the boot CPU
> hangs (spins forever) because the VMM is being naughty, I'm OK with it.
>  It's hard to do too much damage when you're spinning.
> 
> #2 seems like a separate issue to tackle.  Maybe it's as simple as
> waiting for the secondary CPU to mark itself as online.

As I mentioned above, do_boot_cpu() already does this. I don't think we
can anything sensible beyond that.

> >> It looks like debugging that you add when you're bringing something up.
> >>  I'm not sure of its utility going forward.  I'd just zap it for now and
> >> bring it back later if it's really needed.
> > 
> > Sathya pointed out that this protection was added based on request[1] by
> > Rafael.
> > 
> > TDX should be safe from re-wakeups as we forbid offlining CPUs, but the
> > wake up method suppose to be generic, not limited to TDX.
> > 
> > [1] https://lore.kernel.org/all/CAJZ5v0jonk2Pb2HUHMoe69vnCV4+EV9XZpo2LwKrnYPF3CxD_A@mail.gmail.com/
> 
> Fair enough.  Please just add that reasoning somewhere.

Looking closer, the protections seems to be provided by caller.

apic->wakeup_secondary_cpu_64() is only called from do_boot_cpu() which is
only called from native_cpu_up(). It checks the CPU against cpu_callin_mask
before trying to wake it up, so we don't need to do this here. 

I'm dropping this protection after all.

Does the patch below look okay?

From ab320371f9ef8d24722394ec2505089e68737527 Mon Sep 17 00:00:00 2001
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
 arch/x86/include/asm/apic.h |  5 ++
 arch/x86/kernel/acpi/boot.c | 93 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/apic/apic.c | 10 ++++
 3 files changed, 107 insertions(+), 1 deletion(-)

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
index 5b6d1a95776f..20bd9f674c38 100644
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
