Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB54E687C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352569AbiCXSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbiCXSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:17:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E38B716A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:15:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h8-20020a25e208000000b00628c0565607so4183483ybe.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uAIGBPBBBrk2HKfDSuD8YiCa0Mdf4Bk2MGrmkFdR4Ag=;
        b=d0YVX1TyuxumwO45WoJmHwZnCcPXko7eT2ql3Ovs2BMdFmAUfAdp+VpNNLxk1nrl+1
         t8+laF8Mn30mQhUxJgpqBQi2D1949HWPwXQXDAkB1NdxIOIAGT/pJUf4ELiLMkWpKwGJ
         KOK/zpKSKSgRGQOP6+NVVhhB+sXf4So1w9PfdPFi1LRLy0tI2Ipu2yDBdiopOoUXLi4b
         q5yIMKdKbg1HlTI+ivPV/vzlmmU7cXtRaL/SRmVZOUP1WHWmlDTAGdb0LYc0cxz93+uT
         zxFVjSkmM9fgk+oB1JbKqU1K0BKEp5Ko6+MLH86YpAqn2DecVVvtfZJjvWC7GJOF+1g5
         sKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uAIGBPBBBrk2HKfDSuD8YiCa0Mdf4Bk2MGrmkFdR4Ag=;
        b=1oFBgN17ubdsuH8enSQuU+wbEOy+VaNtzBnIVU+3p7Fs6w/xbJcETxmQ4wYe9A4j4x
         Rx3T0xGPG3vnz6lJP9pKkWXzqb2mljdh3I1orwuzfpfiCK7Eaox+E+LQev9ogroUZEeB
         Nb5EKuUcUd37M+wCGRRAkcAZ0iixEw2gOjhNx07cR5SSVpfgOj7Z1Xvay+pLc22hJgFZ
         0KPDspaAF632fu7tzLXknGZ/pf1oLaqKtv3tVUK4W4CuCBowqsLClxHnVOgYUNRv+vaB
         SRyBE3Ys3yU+jxOMiYFvNKA719WPLQW5cgTGkBy/xGHZsPHKEf/+wyPQinrgJ5vu/+pS
         aqyQ==
X-Gm-Message-State: AOAM531Rx+qUWGZgRwz69AIEKEXJtLHjXqSC3JE6WCP3AqmkizzJR6IW
        UinTfmUTiMmAgUsfr2G1Bq24fWVZFUbprD3eA8erE3ieggda/zQxJNEc7HwBG9nhbDm39hWcEU8
        C1GoNeMz/bTVOEPonWUUe8mpB9KFXUdi1dOnZPRLXVGa1nsAhZos9A+XDOhiaxoDSO1ZB6yj1
X-Google-Smtp-Source: ABdhPJwndYD27V6cDBhj5IRC+7yAuYqZeQRr5MOb7G20W5H3DgzRxegfGiq4GTcquOjYYi3/E0ehE5cnfSXA
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f3e0:4f81:f8ae:76b7])
 (user=eranian job=sendgmr) by 2002:a5b:7cf:0:b0:623:df1c:b83d with SMTP id
 t15-20020a5b07cf000000b00623df1cb83dmr5592921ybq.75.1648145748576; Thu, 24
 Mar 2022 11:15:48 -0700 (PDT)
Date:   Thu, 24 Mar 2022 11:14:58 -0700
Message-Id: <20220324181458.3216262-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2] perf/arm: adjust hwevents mappings on boot
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping of perf_events generic hardware events to actual PMU events on
ARM PMUv3 may not always be correct. This is in particular true for the
PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
architected event, it may not always be available. This can be seen with a
simple:

$ perf stat -e branches sleep 0
 Performance counter stats for 'sleep 0':

   <not supported>      branches

       0.001401081 seconds time elapsed

Yet the hardware does have an event that could be used for branches.
This patch fixes the problem by dynamically validating the generic hardware
events against the supported architected events. If a mapping is wrong it
can be replaced it with another. This is done for the event above at boot time
and the kernel will log the remapping:

armv8_pmuv3: hwevent HW_BRANCH_INSTRUCTIONS remapped  from 0xc to 0x21

And with that:

$ perf stat -e branches sleep 0

 Performance counter stats for 'sleep 0':

           166,739      branches

       0.000832163 seconds time elapsed

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cab678ed6618..d438f5a46bdc 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -39,7 +39,7 @@
  * be supported on any given implementation. Unsupported events will
  * be disabled at run-time based on the PMCEID registers.
  */
-static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
+static unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
@@ -1222,6 +1222,42 @@ static void armv8_pmu_register_sysctl_table(void)
 		register_sysctl("kernel", armv8_pmu_sysctl_table);
 }
 
+static void armv8pmu_fixup_perf_map(struct arm_pmu *cpu_pmu)
+{
+	int i, code;
+	unsigned *map = armv8_pmuv3_perf_map;
+
+	for (i = 0; i < PERF_COUNT_HW_MAX; i++) {
+retry:
+		code = map[i];
+		if (code == HW_OP_UNSUPPORTED)
+			continue;
+
+		if (test_bit(map[i], cpu_pmu->pmceid_bitmap))
+			continue;
+		/*
+		 * mapping does not exist,
+		 * let's see if we can fix it
+		 */
+		switch (i) {
+		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
+			if (code == ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED) {
+				map[i] = ARMV8_PMUV3_PERFCTR_BR_RETIRED;
+				pr_info("armv8_pmuv3: hwevent "
+					"HW_BRANCH_INSTRUCTIONS remapped "
+					" from 0x%x to 0x%x\n", code, map[i]);
+				goto retry;
+			}
+			break;
+		default:
+			pr_info("armv8_pmuv3: hwevent %d not supported\n", i);
+			map[i] = HW_OP_UNSUPPORTED;
+			break;
+		}
+
+	}
+}
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
@@ -1249,6 +1285,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
+
+	armv8pmu_fixup_perf_map(cpu_pmu);
+
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
 			events : &armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = format ?
-- 
2.35.1.1021.g381101b075-goog

