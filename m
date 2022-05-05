Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817C51CD3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387265AbiEFACp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387116AbiEFABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BD612A4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795073; x=1683331073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TyPidIU9s9JbwJNwvFvgLrTu4E+Y5y97BFEdQg2cUk8=;
  b=me41SlqkT0DwRfIzvo/ciQAoCLD1qsyy+SULhWMBbDYPBkr6IZBCGILz
   uIBBkZP4/VYX7Ffh8bgJA8nLbrhIbPTBA2xAc+WtH8pbKY1H7yx4tz8uq
   ck7ONI9SE6ZKZ7wXCYnavlaJ3ogLfekAiQBLloYruWD/sz6cu3NzM2ReF
   bwGOb053f/Rbuc44c5xkws0eciOSfLdaYQhqIyc8VViJ9s+gw663F4dPV
   PlJ1Kd4Jb3u9vsIFkfKHMmRreHCTv3+2LxNqywYCsWgJJHEiT3/oNxi5i
   jY5rcNx6HdPYnoYWaPxmbP9kVjV2p7ka0JfPewu+Nu7FXmgFQlHdpjPFo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283639"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914380"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:50 -0700
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
Subject: [PATCH v6 15/29] x86/hpet: Add helper function hpet_set_comparator_periodic()
Date:   Thu,  5 May 2022 16:59:54 -0700
Message-Id: <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
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

Programming an HPET channel as periodic requires setting the
HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
register must be written twice (once for the comparator value and once for
the periodic value). Since this programming might be needed in several
places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
add a helper function for this purpose.

A helper function hpet_set_comparator_oneshot() could also be implemented.
However, such function would only program the comparator register and the
function would be quite small. Hence, it is better to not bloat the code
with such an obvious function.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
When programming the HPET channel in periodic mode, a udelay(1) between
the two successive writes to HPET_Tn_CMP was introduced in commit
e9e2cdb41241 ("[PATCH] clockevents: i386 drivers"). The commit message
does not give any reason for such delay. The hardware specification does
not seem to require it. The refactoring in this patch simply carries such
delay.
---
Changes since v5:
 * None

Changes since v4:
 * Implement function only for periodic mode. This removed extra logic to
   to use a non-zero period value as a proxy for periodic mode
   programming. (Thomas)
 * Added a comment on the history of the udelay() when programming the
   channel in periodic mode. (Ashok)

Changes since v3:
 * Added back a missing hpet_writel() for time configuration.

Changes since v2:
 *  Introduced this patch.

Changes since v1:
 * N/A
---
 arch/x86/include/asm/hpet.h |  2 ++
 arch/x86/kernel/hpet.c      | 49 ++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index be9848f0883f..486e001413c7 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -74,6 +74,8 @@ extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
 extern void hpet_writel(unsigned int d, unsigned int a);
 extern void force_hpet_resume(void);
+extern void hpet_set_comparator_periodic(int channel, unsigned int cmp,
+					 unsigned int period);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 47678e7927ff..2c6713b40921 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -294,6 +294,39 @@ static void hpet_enable_legacy_int(void)
 	hpet_legacy_int_enabled = true;
 }
 
+/**
+ * hpet_set_comparator_periodic() - Helper function to set periodic channel
+ * @channel:	The HPET channel
+ * @cmp:	The value to be written to the comparator/accumulator
+ * @period:	Number of ticks per period
+ *
+ * Helper function for updating comparator, accumulator and period values.
+ *
+ * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
+ * to the Tn_CMP to update the accumulator. Then, HPET needs a second
+ * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
+ * The HPET_TN_SETVAL bit is automatically cleared after the first write.
+ *
+ * This function takes a 1 microsecond delay. However, this function is supposed
+ * to be called only once (or when reprogramming the timer) as it deals with a
+ * periodic timer channel.
+ *
+ * See the following documents:
+ *   - Intel IA-PC HPET (High Precision Event Timers) Specification
+ *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
+ */
+void hpet_set_comparator_periodic(int channel, unsigned int cmp, unsigned int period)
+{
+	unsigned int v = hpet_readl(HPET_Tn_CFG(channel));
+
+	hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(channel));
+
+	hpet_writel(cmp, HPET_Tn_CMP(channel));
+
+	udelay(1);
+	hpet_writel(period, HPET_Tn_CMP(channel));
+}
+
 static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
@@ -306,19 +339,11 @@ static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 	now = hpet_readl(HPET_COUNTER);
 	cmp = now + (unsigned int)delta;
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
-	       HPET_TN_32BIT;
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_Tn_CFG(channel));
-	hpet_writel(cmp, HPET_Tn_CMP(channel));
-	udelay(1);
-	/*
-	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
-	 * cleared) to T0_CMP to set the period. The HPET_TN_SETVAL
-	 * bit is automatically cleared after the first write.
-	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
-	 * Publication # 24674)
-	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(channel));
+
+	hpet_set_comparator_periodic(channel, cmp, (unsigned int)delta);
+
 	hpet_start_counter();
 	hpet_print_config();
 
-- 
2.17.1

