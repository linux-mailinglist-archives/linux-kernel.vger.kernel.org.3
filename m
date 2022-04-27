Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D245115EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiD0LDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiD0LCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:02:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456022294;
        Wed, 27 Apr 2022 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651056320; x=1682592320;
  h=from:to:cc:subject:date:message-id;
  bh=grvj6tMyw3S/5nbVT6GQKTs8XupqF2xocGWEN8DyBms=;
  b=Otq4jIWnc+3joBGa6If+Qwj3xK4vvTJFpOAsbm6JyaLikC3wOYYeN2wa
   O9zmxO7UFxb6OETRCFEETYhHnPJvjbzeF/ZbAJntWJxnEUGVSWPcJI+QU
   SsdrfWviZ+4WSmwRBBbHgwB9uGReVL9CZGgnrN2Gj9org/NPq3aBdD/6B
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 02:53:17 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Apr 2022 02:53:15 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg02-blr.qualcomm.com with ESMTP; 27 Apr 2022 15:22:59 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 271763B1A; Wed, 27 Apr 2022 15:22:58 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasarao Pathipati <quic_spathi@quicinc.com>
Subject: [PATCH V1] arm64: perf: Change PMCR write to read-modify-write
Date:   Wed, 27 Apr 2022 15:21:45 +0530
Message-Id: <1651053105-11557-1-git-send-email-quic_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserve the bitfields of PMCR_EL0 during PMU reset.
Reset routine should set only PMCR.C, PMCR.P and PMCR.LC fields only
to reset the counters. Other fields should not be changed
as they could be set before PMU initialization and their value must
be preserved even after reset.

Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1..9e22326 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1047,7 +1047,7 @@ static void armv8pmu_reset(void *info)
 	if (armv8pmu_has_long_event(cpu_pmu))
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
-	armv8pmu_pmcr_write(pmcr);
+	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | pmcr);
 }
 
 static int __armv8_pmuv3_map_event(struct perf_event *event,
-- 
2.7.4

