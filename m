Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D42514826
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358031AbiD2Lc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiD2Lcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:32:51 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C04348E49;
        Fri, 29 Apr 2022 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651231774; x=1682767774;
  h=from:to:cc:subject:date:message-id;
  bh=MRz2KIgkT3b8vdFbnYzQ1LYA5GdfN15EjaWWPV4+cIs=;
  b=KX3Mkrua/HkPSv1lWoAji8RTrxWPIbFUQuBvXk+9MMOTSDw4RX875uM+
   fBhDrgwG1AIyrejUYl4gkg4OksEzxBDnJ1Fw8k8qcsmLy5eByXJWOBR5b
   HgvFd9F+8LzYl/PUGhUWRrayjAoi6dhhTX6JD8j13vxyhc/DzACygvyDD
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 29 Apr 2022 04:29:34 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 29 Apr 2022 04:29:32 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg01-blr.qualcomm.com with ESMTP; 29 Apr 2022 16:59:16 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id DA5B03784; Fri, 29 Apr 2022 16:59:14 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Subject: [PATCH V2] arm64: perf: Retain PMCR.X of PMCR_EL0 during reset
Date:   Fri, 29 Apr 2022 16:59:09 +0530
Message-Id: <1651231749-19565-1-git-send-email-quic_c_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserve the bit PMCR.X of PMCR_EL0 during PMU reset to export
PMU events. as it could be set before PMU initialization.

Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
---
Changes since V1:
	- Preserving only PMCR_X bit as per Robin Murphy's comment
---
 arch/arm64/kernel/perf_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1..532a417 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1047,6 +1047,9 @@ static void armv8pmu_reset(void *info)
 	if (armv8pmu_has_long_event(cpu_pmu))
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
+	/* Preserve PMCR_X to export PMU events */
+	pmcr |= (armv8pmu_pmcr_read() & ARMV8_PMU_PMCR_X);
+
 	armv8pmu_pmcr_write(pmcr);
 }
 
-- 
2.7.4

