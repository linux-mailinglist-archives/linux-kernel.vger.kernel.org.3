Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225D51CD43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387202AbiEFACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387105AbiEFABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486E56128F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795071; x=1683331071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fO8Z/cunSnljRh67cIhZwnOKie+7UxkAbp0EHXuT2pk=;
  b=R/BZoREPEagQvkn9cTpfdazTWZh+mJ1svF8QIhLuUSTtcClwe8DCJdHy
   HROzjNKx+tVbDE+f2A9b88/0GlmxtnRfAqp8uCe0X1kfUq8KnKzoIgLzI
   TNplY29Fd8ew9sD41vB7w5X09sf8qnlTAOAo3+ctvYvueI7txZLsXAie0
   ULfsgyecekv0bdBE/zJLr9oOmeLn4EQpaORaIvAmCW1uR3d/yG7t18mH7
   v6dug/3Ok02NtAU7Dl5r6jtJhi1nyobTLq9pxKEt5YvDUqs5/GXpZXbFN
   MWo0Mu0j4xw+d93mqyR55+Co1GiHwuMzRJC0qtJ1xQRhInBFB+xtAYqWN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283630"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283630"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914361"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:48 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 11/29] iommu/amd: Expose [set|get]_dev_entry_bit()
Date:   Thu,  5 May 2022 16:59:50 -0700
Message-Id: <20220506000008.30892-12-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are used to check and set specific bits in a Device Table
Entry. For instance, they can be used to modify the setting of the NMIPass
field.

Currently, these functions are used only for ACPI-specified devices.
However, an interrupt is to be allocated with NMI as delivery mode, the
Device Table Entry needs modified accordingly in irq_remapping_alloc().

As a first step expose these two functions. No functional changes.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 drivers/iommu/amd/amd_iommu.h | 3 +++
 drivers/iommu/amd/init.c      | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1ab31074f5b3..9f3d1564c84e 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -128,4 +128,7 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+
+extern void set_dev_entry_bit(u16 devid, u8 bit);
+extern int get_dev_entry_bit(u16 devid, u8 bit);
 #endif
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b4a798c7b347..823e76b284f1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -914,7 +914,7 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 }
 
 /* sets a specific bit in the device table entry. */
-static void set_dev_entry_bit(u16 devid, u8 bit)
+void set_dev_entry_bit(u16 devid, u8 bit)
 {
 	int i = (bit >> 6) & 0x03;
 	int _bit = bit & 0x3f;
@@ -922,7 +922,7 @@ static void set_dev_entry_bit(u16 devid, u8 bit)
 	amd_iommu_dev_table[devid].data[i] |= (1UL << _bit);
 }
 
-static int get_dev_entry_bit(u16 devid, u8 bit)
+int get_dev_entry_bit(u16 devid, u8 bit)
 {
 	int i = (bit >> 6) & 0x03;
 	int _bit = bit & 0x3f;
-- 
2.17.1

