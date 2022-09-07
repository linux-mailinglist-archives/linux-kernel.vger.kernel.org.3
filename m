Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761A35B0124
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiIGKAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiIGJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:59:36 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CBBB6D7B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:59:07 -0700 (PDT)
X-UUID: 2b3e77ac65814881ac522e7693da1f56-20220907
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 121
        audit/email.address 1
        dict/adv 1
        dict/operate 1
X-CPASD-INFO: d7bf69fc2f0b4186a654f66424c10b5b@rYechmNrlJNehnKug3SDcIFnZWSWYla
        DdG6DYV6SYYKVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3s3mchmhnlg==
X-CLOUD-ID: d7bf69fc2f0b4186a654f66424c10b5b
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:196.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:176.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:2.0,SPC:0,SIG:-
        5,AUF:8,DUF:4281,ACD:73,DCD:73,SL:0,EISP:0,AG:0,CFC:0.786,CFSR:0.037,UAT:0,RA
        F:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,E
        AF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 2b3e77ac65814881ac522e7693da1f56-20220907
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 2b3e77ac65814881ac522e7693da1f56-20220907
X-User: chenzhang@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <chenzhang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 619361442; Wed, 07 Sep 2022 17:52:04 +0800
From:   chen zhang <chenzhang@kylinos.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     chenzhang_0901@163.com, linux-kernel@vger.kernel.org,
        chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] sched/fair: fix a -Wmissing-prototypes warning
Date:   Wed,  7 Sep 2022 17:51:13 +0800
Message-Id: <20220907095113.68153-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when building kernel with W=1:

  kernel/sched/fair.c:11510:6: warning: no previous prototype for ‘task_vruntime_update’ [-Werror=missing-prototypes]

Add the missing declaration in head file to fix this. And remove
the unnecessary declaration in kernel/sched/core.c.

Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
 kernel/sched/core.c  | 2 --
 kernel/sched/sched.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b60422300af6..5a354b4bcd0c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5874,8 +5874,6 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	BUG(); /* The idle class should always have a runnable task. */
 }
 
-extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
-
 static void queue_core_balance(struct rq *rq);
 
 static struct task_struct *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f616e0cec20c..ae8554356108 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2268,6 +2268,8 @@ static inline bool sched_fair_runnable(struct rq *rq)
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
+extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
+
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
 #define SCA_MIGRATE_ENABLE	0x04
-- 
2.25.1

