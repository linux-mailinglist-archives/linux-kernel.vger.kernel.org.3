Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1D4D54BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiCJWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344399AbiCJWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:43:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF58B43;
        Thu, 10 Mar 2022 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646952151; x=1678488151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=izaQGn4N6pWq6eZ9auQerRJ5Q9RTLRKiYGRicinCT3M=;
  b=RRZFR1N/tF6MgPVmVb3YAcBc4JfN4q0El5TDPkcSNSFV+NGSsUuCuEdS
   xJQBipGgguRTnsuNdXuHURaHFRYw1uePPuMeQpCJ6sYShslHf1SNxb4SS
   sTE+FvoQdeWjoeTY6n5NUb9AfvN/cB03K3QtUJpGgoJwTIb/JM0XSVAO1
   WZADNbMsR1q/MsIdPseSmBMaTyo1gLSztHfI9qqPNnc9hC8DzIf7b9F+j
   HrpOgdyklGRP85g34G8DulhMbGq0yLYvT4hDFrJLTzHhT5ImP61+tOLCV
   6kRk9uYY+MzCie9/cP+kwxR0Wau7AD03dbOfxLGol/7czbcYyWi4U4O94
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="242847417"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="242847417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 14:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="642748946"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 10 Mar 2022 14:42:29 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Use firmware default EPP
Date:   Thu, 10 Mar 2022 14:42:23 -0800
Message-Id: <20220310224223.684007-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some specific platforms (E.g. AlderLake) the balance performance
EPP is updated from the hard coded value in the driver. This acts as
the default and balance_performance EPP. The purpose of this EPP
update is to reach maximum 1 core turbo frequency (when possible) out
of the box.

Although we can achieve the objective by using hard coded value in the
driver, there can be other EPP which can be better in terms of power.
But that will be very subjective based on platform and use cases.
This is not practical to have a per platform specific default hard coded
in the driver.

If a platform wants to specify default EPP, it can be set in the firmware.
If this EPP is not the chipset default of 0x80 (balance_perf_epp unless
driver changed it) and more performance oriented but not 0, the driver
can use this as the default and balanced_perf EPP. In this case no driver
update is required every time there is some new platform and default EPP.

If the firmware didn't update the EPP from the chipset default then
the hard coded value is used as per existing implementation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bc7f7e6759bd..846bb3a78788 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1692,6 +1692,37 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 	}
 }
 
+static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
+{
+	cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
+
+	/*
+	 * If this CPU gen doesn't call for change in balance_perf
+	 * EPP return.
+	 */
+	if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE)
+		return;
+
+	/*
+	 * If powerup EPP is something other than chipset default 0x80 and
+	 * - is more performance oriented than 0x80 (default balance_perf EPP)
+	 * - But less performance oriented than performance EPP
+	 *   then use this as new balance_perf EPP.
+	 */
+	if (cpudata->epp_default < HWP_EPP_BALANCE_PERFORMANCE &&
+	    cpudata->epp_default > HWP_EPP_PERFORMANCE) {
+		epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = cpudata->epp_default;
+		return;
+	}
+
+	/*
+	 * Use hard coded value per gen to update the balance_perf
+	 * and default EPP.
+	 */
+	cpudata->epp_default = epp_values[EPP_INDEX_BALANCE_PERFORMANCE];
+	intel_pstate_set_epp(cpudata, cpudata->epp_default);
+}
+
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
 	/* First disable HWP notification interrupt till we activate again */
@@ -1705,12 +1736,7 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 	if (cpudata->epp_default >= 0)
 		return;
 
-	if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE) {
-		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
-	} else {
-		cpudata->epp_default = epp_values[EPP_INDEX_BALANCE_PERFORMANCE];
-		intel_pstate_set_epp(cpudata, cpudata->epp_default);
-	}
+	intel_pstate_update_epp_defaults(cpudata);
 }
 
 static int atom_get_min_pstate(void)
-- 
2.31.1

