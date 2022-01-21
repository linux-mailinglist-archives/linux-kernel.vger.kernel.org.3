Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523E7495DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380033AbiAUKkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:40:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:47859 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238090AbiAUKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642761599; x=1674297599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yc2EonG4xKNYkgh/4jCFbgWhGutbT/2bF8p8hppsmQU=;
  b=di7jITcSMIu7URtXLwK+gmbkB/1psU42f0HoZzperlyOz50LEREvD/kP
   ufR4vKa3YCFHoiUmqvCe5pwLyCzA+hBiQuaNtqcTb52v85hPKLNB/es3j
   PGOnVRS1pbU3GqHZ63Kppc3vIMAjb/CM6p63LL2zvoksKBVb+WXkXhFPG
   PTF0x9gC4tRQysave1eOQj2l2TeWP8jB0JeW1bVLg+oe4nS8ihZOAgbJ/
   BR6c9vN15OxY4MWdNfECL/TelQtiplu5kp85Iehr208Surz6xa0EzWlkO
   PpVbEUGQ4/HWgNwTszLKDOkNj9LsVJ09uhbGkGCYJOkIMXhh7bhLn09G1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="225608828"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="225608828"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 02:39:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="475910023"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2022 02:39:56 -0800
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] x86: Preserve ACPI memory area during hibernation
Date:   Fri, 21 Jan 2022 11:39:38 +0100
Message-Id: <20220121103938.2602637-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When overriding NHLT ACPI-table tests show that on some platforms
there is problem that NHLT contains garbage after hibernation/resume
cycle.

Problem stems from the fact that ACPI override performs early memory
allocation using memblock_phys_alloc_range() in
memblock_phys_alloc_range(). This memory block is later being marked as
ACPI memory block in arch_reserve_mem_area(). Later when memory areas
are considered for hibernation it is being marked as nosave in
e820__register_nosave_regions().

Fix this by skipping ACPI memory area altogether when considering areas
to mark as nosave.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/e820.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..88c1b785ffe4 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -758,6 +758,18 @@ void __init e820__register_nosave_regions(unsigned long limit_pfn)
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
 
+		/*
+		 * Areas containing ACPI tables should be preserved during
+		 * hibernation to prevent potential problems caused by BIOS
+		 * upgrades when offline, as well as to preserve initrd
+		 * ACPI tables overrides which are applied on boot.
+		 * See also acpi_table_upgrade() & arch_reserve_mem_area()
+		 */
+		if (entry->type == E820_TYPE_ACPI) {
+			pfn = PFN_UP(entry->addr + entry->size);
+			continue;
+		}
+
 		if (pfn < PFN_UP(entry->addr))
 			register_nosave_region(pfn, PFN_UP(entry->addr));
 
-- 
2.25.1

