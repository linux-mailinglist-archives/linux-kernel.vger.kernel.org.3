Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C4551CD35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387095AbiEFABm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387035AbiEFAB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA360DB2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795067; x=1683331067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=H881t49gt9ruU/EtOx7+sxhRpxmGtS427Z13jRF3PD8=;
  b=U3k/HwjtI1RpT+f9U5hA5Pnky5VzdJD0D5edFJxnMChqEq6c25uJ1EL8
   cO1frK+72Ykotb0WtQvdJJTeDKt7MNlvbLjEQ3Bgs0kM/6byKkc7LbnB4
   /62XrVS3cNIiaONBPcDXvivn0i92rFqUJz6/wZnCaZegGJ7aPy7Grz91W
   eJ0bU+xNHWAGoEExxIShlAFl5yxH13nMM3GtV/g4tcZjGQx2a5POQmn/C
   HhX0QDelzeNIW7dI0DIooLZtPkV8GIiepcutN+j9aCjpRJqqIx+P8XYop
   K1TQ8kVOxurZATT7dbNZoSY3czZ1whHrgwxxUoVAEosc09nf8De5tftqV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283613"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283613"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914332"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:45 -0700
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v6 03/29] x86/apic/msi: Set the delivery mode individually for each IRQ
Date:   Thu,  5 May 2022 16:59:42 -0700
Message-Id: <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
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

There are no restrictions in hardware to set  MSI messages with its
own delivery mode. Use the mode specified in the provided IRQ hardware
configuration data. Since most of the IRQs are configured to use the
delivery mode of the APIC driver in use (set in all of them to
APIC_DELIVERY_MODE_FIXED), the only functional changes are where
IRQs are configured to use a specific delivery mode.

Changing the utility function __irq_msi_compose_msg() takes care of
implementing the change in the in the local APIC, PCI-MSI, and DMAR-MSI
irq_chips.

The IO-APIC irq_chip configures the entries in the interrupt redirection
table using the delivery mode specified in the corresponding MSI message.
Since the MSI message is composed by a higher irq_chip in the hierarchy,
it does not need to be updated.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
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
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 189d3a5e471a..d1e12da1e9af 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2528,7 +2528,7 @@ void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 	msg->arch_addr_lo.dest_mode_logical = apic->dest_mode_logical;
 	msg->arch_addr_lo.destid_0_7 = cfg->dest_apicid & 0xFF;
 
-	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	msg->arch_data.delivery_mode = cfg->delivery_mode;
 	msg->arch_data.vector = cfg->vector;
 
 	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
-- 
2.17.1

