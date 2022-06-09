Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161755441AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiFICze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiFICzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:55:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52851A40A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:55:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30047b94aa8so191956017b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4ARLjw1Nof83y9YpqKOn8wr8VcsjNu7ZoweP/sOCfPY=;
        b=Qx1sTnuPnKZIjWGGtQpVlxmYsryyYfV8gpq2IWXczHI0T4WeB1Br9zEitH904E54mq
         H/0ip/CRw0YEASts5sNTWaNhY0oRQr6A7hb6ThHml3YNQKEJArAPGo6OliXJoNIIysc1
         h3Xk2URRY5Ucr+OXNiRif2REJZFh3RMfiQwVMNRP5p26Hezp3dC+Y0C4sqeXbCTRpngD
         lgeg/i9DP75mo0gGPVoAtu8kojzoUan4q5GPPH7acGQ7Nn9+KC2oWZ0Q25NRN1SynuwJ
         1C2OhZaremYmei+jCVLFLhB6/D/xllOCWw4LnNkLs5peDWuet25EyV7BAz6S4rCpF0mU
         qDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4ARLjw1Nof83y9YpqKOn8wr8VcsjNu7ZoweP/sOCfPY=;
        b=39UaYoJjBWsVwfORw3AA9q2UbYDznSu3MzIdC85kF8ifrm2wKuqsaDESntB5yKv/aE
         joqb7UBJ33zul8ONxT7dGBJ8FJXxqRbAeVRhYM1u5pkcNYI0IRFaHSxkc9Q7lkaXt2Ex
         /DPoSCDJZ8vCHd6ir5doF73nb7izpWUNwaekM05vp/HYOzuEs1KTqvv9ILQx1BmYD8BF
         /XUvB+dVn5xttvZcdDSxjy0q/8Fo7VdG5uFUQ46+FZyt3LZjg3pX+NVDWbtm6/g6NAS1
         6x6a7WW5VTXHzbPXoB54II90hrVJikzQiyOS43RtlJgJ3r9t4vwQTmU+NlGmDdnHx+xy
         IUEA==
X-Gm-Message-State: AOAM532NhNpHEWHXdKrsNzjyFoJNE5xqCLdyrgxG1gvUBUU7leOOyvS4
        aZlG5oGodlvKDFGVmhmri+kvB6K/ZV4N
X-Google-Smtp-Source: ABdhPJzIUpNdNmjpAsA+6DSe+J/A6mY/fMcRgrfg6mHex4M8OMq0i4HV4v0BEgMdcCTu8ykV4/NJhr8V0EpT
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:af3:3e2d:508a:9cef])
 (user=joshdon job=sendgmr) by 2002:a81:c4e:0:b0:30f:fc76:672b with SMTP id
 75-20020a810c4e000000b0030ffc76672bmr36722807ywm.371.1654743328998; Wed, 08
 Jun 2022 19:55:28 -0700 (PDT)
Date:   Wed,  8 Jun 2022 19:55:15 -0700
Message-Id: <20220609025515.2086253-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] sched: allow newidle balancing to bail out of load_balance
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
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

While doing newidle load balancing, it is possible for new tasks to
arrive, such as with pending wakeups. newidle_balance() already accounts
for this by exiting the sched_domain load_balance() iteration if it
detects these cases. This is very important for minimizing wakeup
latency.

However, if we are already in load_balance(), we may stay there for a
while before returning back to newidle_balance(). This is most
exacerbated if we enter a 'goto redo' loop in the LBF_ALL_PINNED case. A
very straightforward workaround to this is to adjust should_we_balance()
to bail out if we're doing a CPU_NEWLY_IDLE balance and new tasks are
detected.

This was tested with the following reproduction:
- two threads that take turns sleeping and waking each other up are
  affined to two cores
- a large number of threads with 100% utilization are pinned to all
  other cores

Without this patch, wakeup latency was ~120us for the pair of threads,
almost entirely spent in load_balance(). With this patch, wakeup latency
is ~6us.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8c5b74f66bd3..5abf30117824 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9834,9 +9834,15 @@ static int should_we_balance(struct lb_env *env)
 	/*
 	 * In the newly idle case, we will allow all the CPUs
 	 * to do the newly idle load balance.
+	 *
+	 * However, we bail out if we already have tasks or a wakeup pending,
+	 * to optimize wakeup latency.
 	 */
-	if (env->idle == CPU_NEWLY_IDLE)
+	if (env->idle == CPU_NEWLY_IDLE) {
+		if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
+			return 0;
 		return 1;
+	}
 
 	/* Try to find first idle CPU */
 	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
-- 
2.36.1.476.g0c4daa206d-goog

