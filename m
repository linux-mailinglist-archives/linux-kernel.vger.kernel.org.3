Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6280D52FC7D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352060AbiEUM4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347721AbiEUM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:56:07 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB34D27CD1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0lM9e
        iSZ/7u4XdrRd7Dl8KyNTTB09y4sc8qrLKiKecY=; b=RpQtyEWP36dJTB33VXagP
        OdJYZoEmNG6qNqoeQ8YYOCGjW9fzvtf1plOGvSGnrhG2+gwoKViGdRkxuO0ljJA6
        UNuxiXcH5UuC4raRktyWA8VTgSc40UHa1ejAACdtxFEQW83bHgFlppmGwV5htzBF
        tJlTY93Lek02LmpV/n5Fl8=
Received: from localhost (unknown [113.89.246.11])
        by smtp14 (Coremail) with SMTP id EsCowAAXAe8G4YhiIGwTDg--.58702S2;
        Sat, 21 May 2022 20:54:31 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Junwen Wu <wudaemon@163.com>
Subject: [PATCH v1] sched: Fix a typo in scheduler
Date:   Sat, 21 May 2022 12:54:20 +0000
Message-Id: <20220521125420.12683-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAAXAe8G4YhiIGwTDg--.58702S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruw4DWFWrGrW8Xw4DCF47twb_yoW8Jr13pF
        9ruwn7Ja18G3W0gryUZrWDu343W34kWw1fCFyvka4SyFW5tr409Fn8tr42krn8WrWF93Zx
        AFsF93yakr1DJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMv38UUUUUU=
X-Originating-IP: [113.89.246.11]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBxwcIbWB0HlAueAAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice value is MIN_NICE(-20) to MAX_NICE(19), it better uses
int instead of long.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 include/linux/sched.h | 2 +-
 kernel/sched/core.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..cffc7cbed987 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1830,7 +1830,7 @@ static inline int dl_task_check_affinity(struct task_struct *p, const struct cpu
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
-extern void set_user_nice(struct task_struct *p, long nice);
+extern void set_user_nice(struct task_struct *p, int nice);
 extern int task_prio(const struct task_struct *p);
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fcf0c180617c..15c1b63d771b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6888,7 +6888,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 }
 #endif
 
-void set_user_nice(struct task_struct *p, long nice)
+void set_user_nice(struct task_struct *p, int nice)
 {
 	bool queued, running;
 	int old_prio;
-- 
2.25.1

