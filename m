Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80251CD51
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387336AbiEFAEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387123AbiEFAC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:02:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E061289
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795084; x=1683331084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OMAzr1b+gR0ghYqlTvIkOvlFxefky6ROYu4/AGgKvYI=;
  b=KOScxYLh9RpWN1+/gGfLBOuP7yLtkhBmAM3/h/WJ1UiPvuuONwyh6dZh
   1qFzF5j7u2HsLCxaLB7BFjGQUG4GWs8JpTynKLW8BFQbk61jeqWjQLi8v
   N1bTLTTcT08xicRk2JM4dAGtBPT9qhFsn30yWBfBr/Vn3VXIIRgKuq+Q9
   lyFSgz957eK0c69/gS/tb0SBAFwUO87dbVxeLP9VK2QxqVaCQzMtNmOIo
   T5N8qav91tsq7NCJ7LbFxSbcDavQZWV8JHdCAH7n1c84cNVbj5uO+zO8k
   gaLga0n68CQuuesblf6mP7HqsJkFheOiyxP+Cu8WFoC2rxCjJIWBz9bpy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283664"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283664"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914455"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:56 -0700
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
Subject: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining tsc_khz
Date:   Thu,  5 May 2022 17:00:07 -0700
Message-Id: <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
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

The HPET hardlockup detector relies on tsc_khz to estimate the value of
that the TSC will have when its HPET channel fires. A refined tsc_khz
helps to estimate better the expected TSC value.

Using the early value of tsc_khz may lead to a large error in the expected
TSC value. Restarting the NMI watchdog detector has the effect of kicking
its HPET channel and make use of the refined tsc_khz.

When the HPET hardlockup is not in use, restarting the NMI watchdog is
a noop.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch

Changes since v4
 * N/A

Changes since v3
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/tsc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..cc1843044d88 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1386,6 +1386,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	/* Inform the TSC deadline clockevent devices about the recalibration */
 	lapic_update_tsc_freq();
 
+	/*
+	 * If in use, the HPET hardlockup detector relies on tsc_khz.
+	 * Reconfigure it to make use of the refined tsc_khz.
+	 */
+	lockup_detector_reconfigure();
+
 	/* Update the sched_clock() rate to match the clocksource one */
 	for_each_possible_cpu(cpu)
 		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop);
-- 
2.17.1

