Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8A595CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiHPNE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiHPNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:04:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABFD2608
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:03:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3339532b6a8so26764857b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=bkkVnqdc/I6w9lSMDyw7ls2oYgZwW2vmouL+KxjT3IY=;
        b=AjG38NnL1H4rpVtJyj2PcXMU+Ak5N5yVfMxCUVjiCwlNYfCTWqDE72WfHIZgZxRYkq
         3NCe7Iy70mBLWsWX9KC+o72mCgBEK3M/Hs94qtAlpwhdKZGU0FBjwyaLd2x3R4TH/HPy
         w+AD3Lcfdz7VfoQcvZyArbsnOJHnur1OFEmp8Xg6tQ/3SqEnEGYKpIljWlKFGiYEnI9Q
         1h0ATcNyW0FJnVjMtGokJyXFT2yHJ8vrC/Hr7G7YstIcxP9IEL8P8fsVuw90WQyY2XZj
         OQUmmd5k+90HwEbTn21y4mHpDu7ASGc/LICOJuV6KwV04XmFNeghQd7vUDWGe0fMFqa0
         eBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=bkkVnqdc/I6w9lSMDyw7ls2oYgZwW2vmouL+KxjT3IY=;
        b=K9MhL8HuPMMMb5G1LBl3KbQN3EyA6uSwYmZfmppNGeez6oLs5vALZQFRBFM3H6U+M8
         9H6D9doplH704wM0SpHBNTS3TAHWdBaaqgxIVpmNDmzH9LmA1aRG/8Ycpwh87SCz0En7
         Y9oWvlpvYbVHYKupFrf2Ci8BO0Xse57ABMTGNxV0k5cKOAarYKO6kJCFasoh5Mku+5oP
         iZ9c5lN8AmYvjXhUc37ToIehk9azG3GOIvDC0KyvCqNcMdfHpNivauXHOI05HOIc4RkU
         AfVRelpMXRQY8Sm9vGiqipi8wvx9ElQ+6N3katt+Fn0s+u/coDmLqpRueHJ+XZ1KaBsw
         AOjA==
X-Gm-Message-State: ACgBeo2pjQQiFIdMvl1aWPY+Al0qDJBKkleIBqxo7LApQB/ALvksw+/x
        aXmHHVC9LSIU7TYnc1YPZ95M9Qo6nDnyK047QAPFTa8McOYzMmKlVScOrAvM2vJ+H0R9n0DdDKs
        Dr/C5WtRqyHuZ9V6bWoUy0rF+ns4yZII36DVSbc50BHh+8gMA80OFsKCokiJduuhHDVL4/++3rS
        WJulGLc7M=
X-Google-Smtp-Source: AA6agR7I3uB6myRWh/RohWLRcVhjWkwTQ4WTAJ+LVrhZSNAgvhbokfYsgeRMIEdB7qWLK43vdc/bPsAKR5WMQF2W5A==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:6ca1:b34:654d:9422])
 (user=peternewman job=sendgmr) by 2002:a81:4e95:0:b0:329:9477:b57a with SMTP
 id c143-20020a814e95000000b003299477b57amr17332845ywb.58.1660654989519; Tue,
 16 Aug 2022 06:03:09 -0700 (PDT)
Date:   Tue, 16 Aug 2022 15:02:21 +0200
Message-Id: <20220816130221.885920-1-peternewman@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v3] perf/arm: adjust hwevents mappings on boot
From:   Peter Newman <peternewman@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, peterz@infradead.org, will@kernel.org,
        Stephane Eranian <eranian@google.com>,
        Peter Newman <peternewman@google.com>
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

From: Stephane Eranian <eranian@google.com>

The mapping of perf_events generic hardware events to actual PMU events on
ARM PMUv3 may not always be correct. This is in particular true for the
PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
architected event, it may not always be available. This can be seen with a
simple:

$ perf stat -e branches sleep 0
 Performance counter stats for 'sleep 0':

   <not supported>      branches

       0.001401081 seconds time elapsed

Yet the hardware does have an event that could be used for branches.  This
patch fixes the problem by dynamically validating the generic hardware
events against the supported architected events. If a mapping is wrong it
can be replaced it with another. This is done for the event above at boot
time.

And with that:

$ perf stat -e branches sleep 0

 Performance counter stats for 'sleep 0':

           166,739      branches

       0.000832163 seconds time elapsed

Signed-off-by: Stephane Eranian <eranian@google.com>
Co-developed-by: Peter Newman <peternewman@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
---

v2: https://lore.kernel.org/lkml/20220324181458.3216262-1-eranian@google.com/

since v2, removed prints per Will's suggestion

 arch/arm64/kernel/perf_event.c | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e6138..945c31e3f3e3 100644
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
@@ -1232,6 +1232,37 @@ static void armv8_pmu_register_sysctl_table(void)
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
+				goto retry;
+			}
+			break;
+		default:
+			map[i] = HW_OP_UNSUPPORTED;
+			break;
+		}
+	}
+}
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
@@ -1259,6 +1290,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
+
+	armv8pmu_fixup_perf_map(cpu_pmu);
+
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
 			events : &armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = format ?

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1.595.g718a3a8f04-goog

