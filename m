Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601C5A14E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiHYO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiHYO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:56:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF495BA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:56:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id og21so2530590ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3Zv43Q0L/JzyMH3BFd/bR1lebmOlOV0+mAys2DJf9EY=;
        b=OlsCS2HDTccliQXBk8wqgsAc9wakEKKvKEnQivOBayL/+MtlqkfN8EpMrxQuIhV30L
         LGPLyPujCxjcz6bhT6Bj83/MGUoroqrPBtnJliuz7ArsgSaXS/elTzxBVETgheEvlTbr
         yO6DFqiwD5BJvnSlf1LLl6qtkVMtVa7BqFZYZJGD/vWe8/lQq0Jvx7Lgbcmntrej9Pd5
         3QlE1oykr28VQW8teNjVeB+6R1mswEPWFAnv5CbCNrd7L7vkbExQOm24bIdzGudf0f7Z
         h1WmSDuM2cn4ln0TZZpJT47VP9WZzvC/ust/cItcD3634Dsqp69NHq9GpWuDaDJzxsQs
         I7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3Zv43Q0L/JzyMH3BFd/bR1lebmOlOV0+mAys2DJf9EY=;
        b=eFdnB/QsDGzmqaCpL/x1zbP/uJQacVpcKOe7MO3YPR/pMfKLr83FV5fu7t8PwmM1/i
         TiaO1pmYi/AgRtmG6OcWEwbzfyJTgd+WYSE+8tzyuR/f8Ud0Nf7vPr/u8N045xjl3FoJ
         MIDPM9UcQEkyOCGO5WTvfOmvIwAovqkIFRElSYSJ4UHZzTyoNGwLeMil9vq63lCqjEge
         7IyDRDcjM+jvcQItVj96ZBbW/UqbW2BPelPPSMRcN7XMJn0cNCBJivChQ7MhsBjtTco3
         bEACC1TPYGvS3ybsQd/urQHiLb9bBr/sDcPmMV4biz34imkAS7dc5Pq1mKql1CW24QqQ
         M8/Q==
X-Gm-Message-State: ACgBeo3qMtWG1bCbi0Pu8yHnkakqsD5qEwKHlLHowef6bh9UHwjtChVz
        EuOlwaph9IWRCqt0tRcyT0VP0pb59C23zA==
X-Google-Smtp-Source: AA6agR6xWvdKd0xd5MPQKrRUO/aErozSSEiPpKVZRtUS78OaSQQlZarFDE870qHcDiWgDbFgZpDI/g==
X-Received: by 2002:a17:907:2cd8:b0:73d:8af4:e0ba with SMTP id hg24-20020a1709072cd800b0073d8af4e0bamr2845769ejc.586.1661439392729;
        Thu, 25 Aug 2022 07:56:32 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0073d6cfdc44dsm2561049ejm.115.2022.08.25.07.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:56:32 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] smpboot: Use atomic_try_cmpxchg in cpu_wait_death and cpu_report_death
Date:   Thu, 25 Aug 2022 16:56:03 +0200
Message-Id: <20220825145603.5811-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
in cpu_wait_death and cpu_report_death. x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg).

Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

No functional change intended.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
Changes since v1:
- Fix uninitialized variable in case cpu dies early.
---
 kernel/smpboot.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index b9f54544e749..2c7396da470c 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -433,7 +433,7 @@ bool cpu_wait_death(unsigned int cpu, int seconds)
 
 	/* The outgoing CPU will normally get done quite quickly. */
 	if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) == CPU_DEAD)
-		goto update_state;
+		goto update_state_early;
 	udelay(5);
 
 	/* But if the outgoing CPU dawdles, wait increasingly long times. */
@@ -444,16 +444,17 @@ bool cpu_wait_death(unsigned int cpu, int seconds)
 			break;
 		sleep_jf = DIV_ROUND_UP(sleep_jf * 11, 10);
 	}
-update_state:
+update_state_early:
 	oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
+update_state:
 	if (oldstate == CPU_DEAD) {
 		/* Outgoing CPU died normally, update state. */
 		smp_mb(); /* atomic_read() before update. */
 		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_POST_DEAD);
 	} else {
 		/* Outgoing CPU still hasn't died, set state accordingly. */
-		if (atomic_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
-				   oldstate, CPU_BROKEN) != oldstate)
+		if (!atomic_try_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
+					&oldstate, CPU_BROKEN))
 			goto update_state;
 		ret = false;
 	}
@@ -475,14 +476,14 @@ bool cpu_report_death(void)
 	int newstate;
 	int cpu = smp_processor_id();
 
+	oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
 	do {
-		oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
 		if (oldstate != CPU_BROKEN)
 			newstate = CPU_DEAD;
 		else
 			newstate = CPU_DEAD_FROZEN;
-	} while (atomic_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
-				oldstate, newstate) != oldstate);
+	} while (!atomic_try_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
+				     &oldstate, newstate));
 	return newstate == CPU_DEAD;
 }
 
-- 
2.37.1

