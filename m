Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14E54EAE93
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiC2Ngd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiC2Ng1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:36:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3D22500;
        Tue, 29 Mar 2022 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648560884; x=1680096884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/EGHJPKzQdz3iS6a0HGD7FNUtM2u9pCw7nlJatrvxuY=;
  b=NF1i6yLrzKkhpZvYprK1VBBhPl/YrWfocl8r7LHf36D5W2Kxkdrod9SQ
   J2wp5ss2mZz+bKWrF39YdctMoIgPvP9pUEpU0/VKDwlj0oeyIT5bG3K34
   iy1ItfRSr2aE/Ub0bVMun1AOWQL6UWnYlWY7pLY3K1qLGEmzhQHVpDuDS
   Sv16FeJBxgdebFp+A858x2/4xlwZztt80BvVe88PoDpyDn+tTqc4Ak4/+
   2Un4sj304AESar7C0+uDj5GXxUOOx9iC5GHcBDuJ/zwL5oBK6Yx8+OL5x
   L2gZONpl3clA3ABt/mVtZN+sXnQmnAB7Tg/LCGw1zS3fJDl36qfKgbIek
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="322434844"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="322434844"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="546386851"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2022 06:34:41 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2] x86/acpi: Preserve ACPI-table override during hibernation
Date:   Tue, 29 Mar 2022 15:33:52 +0200
Message-Id: <20220329133352.3361248-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When overriding NHLT ACPI-table tests show that on some platforms
there is problem that NHLT contains garbage after hibernation/resume
cycle.

Problem stems from the fact that ACPI override performs early memory
allocation using memblock_phys_alloc_range() in
memblock_phys_alloc_range(). This memory block is later being marked as
ACPI memory block in arch_reserve_mem_area(). Later when memory areas
are considered for hibernation it is being marked as nosave in
e820__register_nosave_regions().

Fix this by marking ACPI override memory area as ACPI NVS
(Non-Volatile-Sleeping), which according to specification needs to be
saved on entering S4 and restored when leaving and is implemented as
such in kernel.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---

Changes in v2:
 * Changed approach as method used in v1 introduced potential for memory
   corruption, which was caught by tests.
 * Adjusted commit message describing above change in approach.

---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 0d01e7f5078c..2eeca97b730b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1772,7 +1772,7 @@ int __acpi_release_global_lock(unsigned int *lock)
 
 void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 {
-	e820__range_add(addr, size, E820_TYPE_ACPI);
+	e820__range_add(addr, size, E820_TYPE_NVS);
 	e820__update_table_print();
 }
 
-- 
2.25.1

