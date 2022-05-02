Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62922517895
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387490AbiEBUy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387414AbiEBUyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:54:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736EA194;
        Mon,  2 May 2022 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651524654; x=1683060654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sl4N8i1omNpsjiy3tkB6ukBb3Fz0rso7EMwA3taLqsQ=;
  b=MT3Ki9JXEfqC2bdqyUp5uyTJR+gvNsHqZtPoyv5SpyRfSkdBb8f9jNI2
   r/idP4SLQxd8kiqYNcF3RI4zI4h+g663iwxWDQFC2rYDrpAQy1Kj3Rd06
   7NFzlU/fDqltEbTNVQ//j2gMJQbqb9x1AL+W5xywBIdcH7uu2/Ao59aaT
   NBb5aTkaCrbTEGnCnTWNPUneoZITXInAXJ9ro4W95WBrR3fqkCVX/cIPK
   D00irbgjLS4+dyUYPAjD51GbG5hi6EvLbId0b/y5dU0u9dV+fxTYjZVt8
   jbvoNkDlUDQ2H1OMxeHc9DfInsywSsSktCC44lPqyzrL/ngB8aXZlrS1R
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="327870006"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="327870006"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="546616829"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2022 13:50:54 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Support Sapphire Rapids OOB mode
Date:   Mon,  2 May 2022 13:50:52 -0700
Message-Id: <20220502205052.1257462-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent intel_pstate to load when OOB (Out Of Band) P-states mode is
enabled in Sapphire Rapids. The OOB identifying bits are same as the
prior generation CPUs like Ice Lake servers. So, also add Sapphire
Rapids to intel_pstate_cpu_oob_ids list.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 846bb3a78788..76d59b3f35e4 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2424,6 +2424,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(BROADWELL_X,		core_funcs),
 	X86_MATCH(SKYLAKE_X,		core_funcs),
 	X86_MATCH(ICELAKE_X,		core_funcs),
+	X86_MATCH(SAPPHIRERAPIDS_X,	core_funcs),
 	{}
 };
 
-- 
2.31.1

