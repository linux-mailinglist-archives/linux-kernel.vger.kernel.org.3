Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0E50342F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiDPCsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiDPCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:48:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24883D1F3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650077181; x=1681613181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MtjqvWdYSMVFb9sE5wCkcuWB6Ee56kJSwh5s11C9Un0=;
  b=gO3yMWW6VXm7adUPBEsNhNDHNPVzsEO9BUpMP730rrrlYNw+VazkQNxp
   LPx0tD971NzKf2I0NYfs3/hIKxZ72H/s8C/yaSUhGOtjYa/gTgXuAK+mc
   TPYEnFCbMIRRHfNAPw0PEjx/8xRzqNXcKF1ksVhh4rxzYFBnw7WpAFThT
   le4xHIcQs6kcYwPFe1bl2S9Y1fxhN75D/IINkT9GLJrIi1lsnDI8MjNOH
   g3q7xo/6gLhB3DQ111mxeqNdQgOf+IritmqT6HtbgjikyHM7z4dUDSH2B
   QxhAVNU4JrVVf+gKpekvEZQNhHqqtu9WakFUyrhYQv1iML3ByY83veBGa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243193401"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243193401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 19:46:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="553410278"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 19:46:21 -0700
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
Subject: [PATCH v3] x86/apic: Do apic driver probe for "nosmp" use case
Date:   Sat, 16 Apr 2022 02:45:32 +0000
Message-Id: <a64f864e1114bcd63593286aaf61142cfce384ea.1650076869.git.sathyanarayanan.kuppuswamy@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

This is observed in TDX platform where x2APIC is enabled, MADT/MP table
exist and "nosmp" command line option is allowed.

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
 RIP: 0010:init_x2apic_ldr+0xaf/0xc0
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
 * Removed upmode = true change for APIC_SYMMETRIC_IO_NO_ROUTING case.
 * Made some minor changes to commit log (like removing register dump
   in panic log)

 arch/x86/kernel/apic/apic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344bf6600..f4d12db8add0 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1419,22 +1419,21 @@ void __init apic_intr_mode_init(void)
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
 		break;
 	}
 
+	default_setup_apic_routing();
+
 	if (x86_platform.apic_post_init)
 		x86_platform.apic_post_init();
 
-- 
2.25.1

