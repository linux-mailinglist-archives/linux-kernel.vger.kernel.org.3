Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE73B59E9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiHWRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiHWRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:34:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0E7FF95
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:13:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a22so18444976edj.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=U0zq/PCYrwctihsvgYpSQTb+BYTHJsLzubPV45oSYQM=;
        b=imU++nr4DV3F8AFg0OZRtnWqGiqZUflqNPL/ea1pxnyBZXCA4xEW3nSe3fih+chfAs
         wF277wI4CF3Qs82pssb7dHsNH9YAsHJyUhgsm1OJe5v1khd9XicHrcQ8a68aWRXdCdnc
         aaGNNO2z5vdeQu0V4a4tJD32knYif4OsYNn86Ve/wH+nVYQ6tpHTaPpQORWTXYe3Uxjy
         mv+6Tz5kj2rVZ9QoNFaXTc0w/2Au+mxfV+spuaVs6aRkGvVQ4TjkYrEGv/ZSoNZ+5x/+
         r7m/OH/0sQL7LVEs8lUiFZPiIDuei1FKhMg+OIvieKzgr+k4UjaqT/IH+hmI7EzeWr7y
         NhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=U0zq/PCYrwctihsvgYpSQTb+BYTHJsLzubPV45oSYQM=;
        b=ATLoLJ5yjQB55YPAXeb9CLuXX/XOtZKQ0B6KjEPWMFULoyVf0Tsag/0l69EMBxVVqA
         rQRb1uzZPMebI4C0eBEptnQGxAxW6vsnpsVWcMDo2uJSj6ozRae1sHc4DvkC0ENmO38y
         pSTCQIQsq+AyW5ixaIuH0/DQ94aVnCJm2LtECtDjE7DLH+dOy8YbgzmkFIMWYIGgk682
         +h7kRY4mkl2pGQTvSG0y9P8S2lwPArtwMqTAN6N2YHWoIEMF7sLkag+okifEJkAJEpQz
         9SpgfZw+2do9N2eRGCQHGY6fqMjjlOjtLQjxSLMH/osJvtIn9kDNtDXNthCoVr2o8bLL
         b2GQ==
X-Gm-Message-State: ACgBeo0URuxlL6BhI5ZpuQHperCjBDkxFwwvYFR+x4dvD1gUg68ZxtT5
        T4CyozMNb2rx/e1IyuD6oMZkQyIPh8UWQg==
X-Google-Smtp-Source: AA6agR4vI6YPaHQJPN9+koD/SZZKWLGxbR7ikyhKtU3MTydZYb0ZLjpc4QpV4SDwD5Wj0nW+dRDw9Q==
X-Received: by 2002:a05:6402:2813:b0:447:2be4:a5d0 with SMTP id h19-20020a056402281300b004472be4a5d0mr2088636ede.104.1661267631321;
        Tue, 23 Aug 2022 08:13:51 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id f20-20020a50fe14000000b00446b9a3189asm1595277edt.19.2022.08.23.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:13:50 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] smpboot: Use atomic_try_cmpxchg in cpu_wait_death and cpu_report_death
Date:   Tue, 23 Aug 2022 17:13:36 +0200
Message-Id: <20220823151336.3984-1-ubizjak@gmail.com>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/smpboot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index b9f54544e749..f3cf1a9a8b44 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -444,16 +444,16 @@ bool cpu_wait_death(unsigned int cpu, int seconds)
 			break;
 		sleep_jf = DIV_ROUND_UP(sleep_jf * 11, 10);
 	}
-update_state:
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
@@ -475,14 +475,14 @@ bool cpu_report_death(void)
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

