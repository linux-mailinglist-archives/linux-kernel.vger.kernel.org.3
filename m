Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D464F5368
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiDFDSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447856AbiDFCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:14:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B175F1B0BF1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201721; x=1680737721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=STeG2FLbbPpowTlB6rRMQFgXepPD61nn14I5PqRZN/U=;
  b=YUKGYazOCx71MX7Y9KnscI6+5VlOT/XIkrCUGncmfWhkK+YibAeH1Kzb
   s8dr/JCPbMcdrnkf16U+4JXdwvAHsqQy7DXYLtXXAZc8csQrONDLNSyGx
   57GYV7eYxSCfLS8pD9+LizqG43D4VkHGRVputpA29RXG9zLbrQE5H5qQO
   4Q2VKU0IaPjr5sQ7Y4D51MtZe8MKInoC5dFnMb9co976VoIDqF3KRDvkN
   eVfQ82XQQImHbp+kA3On5pCP0ZelXfYQxG4mzYeakD7N3ei+qv3ZGji1z
   ZH6ZkkctS1V3A51flHE6xczX1YWfgKqroxg1drgz9fon35c1g+rERnCcu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260884699"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260884699"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="641812570"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 16:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EB82810A3; Wed,  6 Apr 2022 02:29:46 +0300 (EEST)
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
Subject: [PATCHv8 28/30] x86/tdx: ioapic: Add shared bit for IOAPIC base address
Date:   Wed,  6 Apr 2022 02:29:37 +0300
Message-Id: <20220405232939.73860-29-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
2.35.1

