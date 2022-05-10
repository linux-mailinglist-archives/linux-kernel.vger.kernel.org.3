Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661FB52205C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbiEJQBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346250AbiEJPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890252CC94
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id p4so13818002qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRZCptIM03juaQv67hbbg4JReeAbmT3D5f9cphqNW9A=;
        b=FEVX6hWuLn7gTdB8Ry8/1gWnCWSO+tOkXnA4I3M29xUL2FIgRHi1ILsobsRmN+EpZs
         aJH3WxU0uKmKDheSwl2lRSJE/3sDCZJ4nttB8pgAs/Jb0gVUKEMRWbmgN22YlLJyAhO/
         MR3DDWLJLejOAErjVdhHpMLI0ZE2IfCrl0kvgfpceVOdesnEQR3haqdchVZb3vXFvGTi
         A9Eff4upsFZrO/ORpwjECQ15qnwpy5an9lFA0Dta3brrC0DNBcFh9UA8fiQoS/huVUpJ
         Xb3JDk0nFnbWoRKp4O8h//ZwQT3H7sVnUe6PHMYnDuzpCQoye+G+yIvGR28Qs81aHwLn
         vIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRZCptIM03juaQv67hbbg4JReeAbmT3D5f9cphqNW9A=;
        b=Jkut5vv5z6zX9te8Ow+/xdxxLL2FPfVysijKszlK4t5UPBkpwkPRA7iMZORRSslNYS
         M0DFD3KAQi1VSLe5/hBtqvBxjBjeQpsuXVUlhEgo+R6oPTGWNS4L2th6upTb3jY4duRg
         slE/Wfk5bxbpJaEeHbJQ8RK0Nb9UxX70QXBJ333w0/NwW1yiNJt7sRTfoitaj4QIrT7Q
         1z2h2AAfUPXZXv4s7m7QnM8H3RjedGKkQHchWkTHBfoSEYXPP5Rg3D1LB9Pl3jGsFeOo
         bQ/hEM1z5cU8MuVsOWDLr8dgzLGwqc5XnlTFP5eCS4FSUo1pcWJqnBTTn3Y6SooK0qGt
         PSEA==
X-Gm-Message-State: AOAM530SG65W3gOinoQjM2EuKJo+GQ53YS6HtA4QemWuhSvfEBOZDEhd
        kO4dKVH5DoHhwlF/a0sOZ1g=
X-Google-Smtp-Source: ABdhPJxOyrqz39sJo5kShX2mHmWAGuRDJv6Z8jgBVfVRbzekEbV4JEux0WZeo9gXBj1oPecD4VRcuw==
X-Received: by 2002:a05:622a:143:b0:2e0:b7c8:3057 with SMTP id v3-20020a05622a014300b002e0b7c83057mr20386773qtw.179.1652197698712;
        Tue, 10 May 2022 08:48:18 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id h4-20020ac87764000000b002f39b99f6a2sm9129878qtu.60.2022.05.10.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:18 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 18/22] sched/core: remove unneeded cpumask_weight() in sched_core_cpu_{starting,deactivate}
Date:   Tue, 10 May 2022 08:47:46 -0700
Message-Id: <20220510154750.212913-19-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
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

The following cpumask_any_but() implicitly calculates if number of smt cpus
is equal to 1, therefore we can drop the code that does it explicitly.

CC: Ben Segall <bsegall@google.com>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Valentin Schneider <vschneid@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
This is RFC because it drops WARN_ON_ONCE(rq->core != rq). If this warinig
is important, I'll rework the patch.

 kernel/sched/core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9700001948d0..07b8f35cbe36 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6133,12 +6133,10 @@ static void sched_core_cpu_starting(unsigned int cpu)
 
 	WARN_ON_ONCE(rq->core != rq);
 
-	/* if we're the first, we'll be our own leader */
-	if (cpumask_weight(smt_mask) == 1)
-		goto unlock;
-
 	/* find the leader */
 	t = cpumask_any_but(smt_mask, cpu);
+
+	/* if we're the first, we'll be our own leader */
 	if (t >= nr_cpu_ids)
 		goto unlock;
 
@@ -6171,18 +6169,14 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 
 	sched_core_lock(cpu, &flags);
 
-	/* if we're the last man standing, nothing to do */
-	if (cpumask_weight(smt_mask) == 1) {
-		WARN_ON_ONCE(rq->core != rq);
-		goto unlock;
-	}
-
 	/* if we're not the leader, nothing to do */
 	if (rq->core != rq)
 		goto unlock;
 
 	/* find a new leader */
 	t = cpumask_any_but(smt_mask, cpu);
+
+	/* if we're the last man standing, nothing to do */
 	if (t >= nr_cpu_ids)
 		goto unlock;
 
-- 
2.32.0

