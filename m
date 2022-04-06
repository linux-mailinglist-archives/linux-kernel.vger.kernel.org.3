Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E834F6B76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiDFUd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiDFUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:33:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55E26FEA0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649271307; x=1680807307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nCOz63NpVNE724shHm0K8baYhqKC2a9PMwtuJZkTVWA=;
  b=F98PrHfsoyeALeBvVzQX8T7UB98y9VwD/RYJfnwYFZMHvnMFOkpp62Yl
   rzfj7lungqKgo+DG4LIDeJ9ufY2+FFVY/4HLhKAn1GJv3UcBZDGIuok0b
   AJKUDUPl3fGhKL/csKGfiaFtmVmDWHOKHygj3GfLEW67D8Jn1h8hcPGll
   I8jREfgaiSOB+UHYj/fY0JaPeKpc+kB9Qq0Mv7kFwrBaIG/X7t3mcmh29
   v/0l1vZOddYNWYISEbBctTzSecdsWzfYwNu/1kwOFaWzBgLvB7dllYGIB
   3+//WwRAuEm0hrI+QBHCD7idO0zivyYt3Rj3VUbpO12EUMZ+xNdIeHqlH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248654246"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="248654246"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:55:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="658650615"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:55:06 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2] x86/apic: Do apic driver probe for "nosmp" use case
Date:   Wed,  6 Apr 2022 18:54:30 +0000
Message-Id: <20220406185430.552016-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the "nosmp" use case, APIC initialization code uses
"APIC_SYMMETRIC_IO_NO_ROUTING" as a default interrupt mode. As per
current design, APIC drivers are not probed (via
default_setup_apic_routing()) for the above mentioned interrupt mode.
Due to missing probe, later when local APIC is initialized (for x2APIC
case), it leads to the null pointer exception due to missing allocation
of "cluster_hotplug_mask" (aka 'cmsk').

This is observed in TDX platform where x2APIC is enabled and "nosmp"
command line option is allowed.

To fix this issue, probe APIC drivers via default_setup_apic_routing()
for the APIC_SYMMETRIC_IO_NO_ROUTING interrupt mode. This will make the
code similar to APIC_SYMMETRIC_IO and APIC_VIRTUAL_WIRE interrupt modes.
Since APIC_SYMMETRIC_IO_NO_ROUTING interrupt mode is in-between
configuration between APIC_SYMMETRIC_IO and APIC_VIRTUAL_WIRE, making
the code similar to them will not have any impact (other than just
loading the apic drivers).

Since default_setup_apic_routing() is called for all cases with a break
statement, move it outside the switch-case.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 1 SMP NOPTI
 CPU: 0 PID: 0 Comm: swapper/0 Tainted: G Y 5.14.0-rc4-tdx-guest-v5.14-2-tdx-attest-y-vsockets+ #32
 RIP: 0010:init_x2apic_ldr+0xaf/0xc0
 Code: fb 76 65 8b 15 9a 88 fb 76 89 d2 f0 48 0f ab 50 08 5b 5d 41 5c 41 5d c3 48 8b 05 74 0d fe 02 48 c7 05 69 0d fe 02 00 00 00 00 <89> 18 eb c9 48 89 e8 eb c7 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
 RSP: 0000:ffffffff8ae03e48 EFLAGS: 00010283
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
 RDX: fffffffffffffffe RSI: 0000000000000000 RDI: 0000000000000200
 RBP: ffffffff8b7704a0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000007 R12: 0000000000000001
 R13: 0000000000017120 R14: ffffffff8ae13108 R15: ffffffff8aab7a20
 FS: 0000000000000000(0000) GS:ffff976a37c00000(0000) knlGS:0000000000000000
 CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000017ae0c001 CR4: 00000000000606f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
 Call Trace:
 setup_local_APIC+0x9b/0x350
 ? printk+0x58/0x6f
 apic_intr_mode_init+0xe5/0x109
 x86_late_time_init+0x20/0x30
 start_kernel+0x5fb/0x6b9
 secondary_startup_64_no_verify+0xbf/0xcb
 Modules linked in:
 CR2: 0000000000000000
 --[ end trace e82759a76de428f6 ]--
 RIP: 0010:init_x2apic_ldr+0xaf/0xc0

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Rebased on top of v5.18-rc1.

 arch/x86/kernel/apic/apic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344bf6600..79b8b521981c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1419,22 +1419,22 @@ void __init apic_intr_mode_init(void)
 		return;
 	case APIC_VIRTUAL_WIRE:
 		pr_info("APIC: Switch to virtual wire mode setup\n");
-		default_setup_apic_routing();
 		break;
 	case APIC_VIRTUAL_WIRE_NO_CONFIG:
 		pr_info("APIC: Switch to virtual wire mode setup with no configuration\n");
 		upmode = true;
-		default_setup_apic_routing();
 		break;
 	case APIC_SYMMETRIC_IO:
 		pr_info("APIC: Switch to symmetric I/O mode setup\n");
-		default_setup_apic_routing();
 		break;
 	case APIC_SYMMETRIC_IO_NO_ROUTING:
 		pr_info("APIC: Switch to symmetric I/O mode setup in no SMP routine\n");
+		upmode = true;
 		break;
 	}
 
+	default_setup_apic_routing();
+
 	if (x86_platform.apic_post_init)
 		x86_platform.apic_post_init();
 
-- 
2.25.1

