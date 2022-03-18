Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B504DDD05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiCRPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiCRPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537411C2D9A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617469; x=1679153469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u1cVO6vC+Je5QgVAf5o9RaTjVFNyO8cnFMef5xqiSLA=;
  b=DrMTCkEZD+WCyJCVtKhfXlUv3cR+y5ZKwiftQ04b+QSMkU2YyESpQHaB
   sIWY+qezoHtLZJ2T6o1bQEjl92vSq0FHAmbTR7EPHOAxi5JIHtwzVvmDZ
   Y/5PDHwpBAzs3CN3FHfbQDAj2UUvOE+3HjWeTbFbzPfORvxJ3eTNHeWgs
   D7vvxUcNDt2qVt+r6m4sSdQZtOOtVnIwq8LChjkaMimwyU7fiUuDD8xLw
   V231YyjMbzwxCMIQoPhQr6xIVYDL0PzXacYSAMp/78B+6Q18r6Gd9jWt4
   nfA75hKyJO2+oIckp8sCQ9AcSspr4qEEGzr6aNwRhjugtpQNPuyywbxkc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257344063"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257344063"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715523785"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 08:30:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1D4F8B16; Fri, 18 Mar 2022 17:30:51 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv7 28/30] x86/tdx: ioapic: Add shared bit for IOAPIC base address
Date:   Fri, 18 Mar 2022 18:30:46 +0300
Message-Id: <20220318153048.51177-29-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

The kernel interacts with each bare-metal IOAPIC with a special
MMIO page. When running under KVM, the guest's IOAPICs are
emulated by KVM.

When running as a TDX guest, the guest needs to mark each IOAPIC
mapping as "shared" with the host.  This ensures that TDX private
protections are not applied to the page, which allows the TDX host
emulation to work.

ioremap()-created mappings such as virtio will be marked as
shared by default. However, the IOAPIC code does not use ioremap() and
instead uses the fixmap mechanism.

Introduce a special fixmap helper just for the IOAPIC code.  Ensure
that it marks IOAPIC pages as "shared".  This replaces
set_fixmap_nocache() with __set_fixmap() since __set_fixmap()
allows custom 'prot' values.

AMD SEV gets IOAPIC pages shared because FIXMAP_PAGE_NOCACHE has _ENC
bit clear. TDX has to set bit to share the page with the host.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c1bb384935b0..a868b76cd3d4 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -65,6 +65,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/pgtable.h>
 
 #define	for_each_ioapic(idx)		\
 	for ((idx) = 0; (idx) < nr_ioapics; (idx)++)
@@ -2677,6 +2678,19 @@ static struct resource * __init ioapic_setup_resources(void)
 	return res;
 }
 
+static void io_apic_set_fixmap(enum fixed_addresses idx, phys_addr_t phys)
+{
+	pgprot_t flags = FIXMAP_PAGE_NOCACHE;
+
+	/*
+	 * Ensure fixmaps for IOAPIC MMIO respect memory encryption pgprot
+	 * bits, just like normal ioremap():
+	 */
+	flags = pgprot_decrypted(flags);
+
+	__set_fixmap(idx, phys, flags);
+}
+
 void __init io_apic_init_mappings(void)
 {
 	unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
@@ -2709,7 +2723,7 @@ void __init io_apic_init_mappings(void)
 				      __func__, PAGE_SIZE, PAGE_SIZE);
 			ioapic_phys = __pa(ioapic_phys);
 		}
-		set_fixmap_nocache(idx, ioapic_phys);
+		io_apic_set_fixmap(idx, ioapic_phys);
 		apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
 			__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK),
 			ioapic_phys);
@@ -2838,7 +2852,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
 	ioapics[idx].mp_config.flags = MPC_APIC_USABLE;
 	ioapics[idx].mp_config.apicaddr = address;
 
-	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
+	io_apic_set_fixmap(FIX_IO_APIC_BASE_0 + idx, address);
 	if (bad_ioapic_register(idx)) {
 		clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
 		return -ENODEV;
-- 
2.34.1

