Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4484FA149
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiDIB3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbiDIB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88110242B;
        Fri,  8 Apr 2022 18:27:22 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hS4ThWOQAWnwSJVvu+j6r1vOFuoOlOSD6fagvzGDZVc=;
        b=XRrKYUzhsDjucfwgrpksrzLOymNLLByTrfkfi/V1klMbPjKrTfi7mR1fsO87LNE5UdIP5x
        X947FmLyibAVAvojl4Io8uUb5KlnQofQ4694rWZKbK8kWHKtFUwLlYqNz7qEInropJB3Yw
        QM4/ST10OLNuKIf8hqtTR4TB/PMIYNfbPV5l6KFeTldWopiQF0PvGZdnwVeExypOihEe19
        XQ4smlcqtVyhfvSswhal5s0cD5Dv1tkgxbeLUgcvWPqqOL1XW6ltmUM2ghPoCGbSOhk/Xl
        hI6K77VEwKdLRcqf4IHfy7kv1mzQBdynp8PWj4tumo0PN0xgEAZgoupVHZ9XBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hS4ThWOQAWnwSJVvu+j6r1vOFuoOlOSD6fagvzGDZVc=;
        b=38J0srL9TOHW2OheyU9GV28GzjDQMpigEvpsr0c1hcLf64Wwx2Ub3cFyz/V92nAdXQOfqR
        /v0vQwDpPypTEhBQ==
From:   "tip-bot2 for Isaku Yamahata" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx/ioapic: Add shared bit for IOAPIC base address
Cc:     Isaku Yamahata <isaku.yamahata@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-29-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-29-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946763982.4207.6455220351838692404.tip-bot2@tip-bot2>
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

Commit-ID:     f4c9361f97c40d365c34f9cb8b8bc3eae0ee7778
Gitweb:        https://git.kernel.org/tip/f4c9361f97c40d365c34f9cb8b8bc3eae0ee7778
Author:        Isaku Yamahata <isaku.yamahata@intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:37 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:53 -07:00

x86/tdx/ioapic: Add shared bit for IOAPIC base address

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
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-29-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/apic/io_apic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c1bb384..a868b76 100644
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
@@ -2709,7 +2723,7 @@ fake_ioapic_page:
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
