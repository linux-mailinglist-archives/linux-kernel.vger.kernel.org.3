Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E84D65D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350209AbiCKQPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350189AbiCKQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478271B50D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r6so13245220wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UsEhnvvFHgaQjzBQyJf4AjmX5slWha5zqrOlGHdJd7o=;
        b=nMW5qngXigefmP0YsG7knNofZZNEK38X697gX8WPLTVRVFSKbnTzPgGk7D46v5VeAC
         VAzaWLfXXq1QIoBMJkuDok9flIV+FC9DTPxYqqou4Xud7ufZdXRjnPM5hVVTogX7IGTz
         dtXoahuNiH+r/rMy04o9E+rnnFg2pdnnG7JftEknbQKHHVdm9oREOKEHdLt7JbqR86uO
         Q/plhpDTwDq3bruNJLpyaB+izF6nfKJaytvREOhQ3a8i8VO7LRvpxLmIEQXgPt+//XJ8
         XCR7A9DUCqLU+AaXLB1pHSBCB0uBv7Lq9qiK6x3qFmoja6qY84TFxIFscuC5SnojPciZ
         w6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UsEhnvvFHgaQjzBQyJf4AjmX5slWha5zqrOlGHdJd7o=;
        b=U2HicaxuOutvdxOY9sBr9VjcRinjDvl2GGXucf8DAE+rgCNnvpE+DSLwYFu/Cj8WlC
         nUIGo9vbAE9juvvBXF8l77ovo/jOk9r3kAAgMh6qNfj+q5S+LvM09aonQSuS/QXKcMeF
         Nr2LRNvLdRg9Ik108MrXKBAR7zMUR8P75Mxn4PomfNDpL/Crt1STQHfE7pgvvi85J5ln
         kentsw7IvaLGhmGBMYeyTi/ajBMV9HKaKrnnufl/4BTqgv03Dz3cH/wKlelIB4t+6ftN
         lU5nhCXXA9vqbWfV7MzE8sZlF5gv4BlsqHVM58IkDGdjLR1umu4nn7rptjgT+/+C94lz
         1V7g==
X-Gm-Message-State: AOAM532Q8hQAu/aI0R5LLevm8aY+Tyt1LUKtI7nHwnD36LEXMVFjnn03
        HnGG1bcq8MjNaiad2LFYwQ0T5g==
X-Google-Smtp-Source: ABdhPJyfLeZtrGD8qr1pbQSQd+rDwHWzBZKe88bVygqK/Q9QfnhTS8JgIl2JfKORHOcuQ0FCLwIq6g==
X-Received: by 2002:a5d:50c5:0:b0:1f0:2111:8f74 with SMTP id f5-20020a5d50c5000000b001f021118f74mr7797356wrt.211.1647015261595;
        Fri, 11 Mar 2022 08:14:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70d9:405c:a1e4:4d23])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm6464137wry.78.2022.03.11.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:20 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/6] sched/core: Add permission checks for setting the latency_nice value
Date:   Fri, 11 Mar 2022 17:14:04 +0100
Message-Id: <20220311161406.23497-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311161406.23497-1-vincent.guittot@linaro.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Since the latency_nice uses the similar infrastructure as NICE, use the
already existing CAP_SYS_NICE security checks for the latency_nice. This
should return -EPERM for the non-root user when trying to set the task
latency_nice value to any lower than the current value.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3edba1a38ecb..8f8b102a75c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7360,6 +7360,10 @@ static int __sched_setscheduler(struct task_struct *p,
 			return -EINVAL;
 		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
 			return -EINVAL;
+		/* Use the same security checks as NICE */
+		if (attr->sched_latency_nice < p->latency_nice &&
+		    !capable(CAP_SYS_NICE))
+			return -EPERM;
 	}
 
 	if (pi)
-- 
2.17.1

