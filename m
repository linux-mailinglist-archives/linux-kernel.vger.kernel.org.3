Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9315252B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356546AbiELQgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356533AbiELQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:35:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1193248E2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so8040418wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iEa/8mAzzO9RlCYIla5k70SI1Iglg8mw5NOlpxJMReg=;
        b=NaCvW4b10j7Xtxd2Yrgzm1tQkfxe+qxD9X9km6qswM7R5iviuD+vgUXO/gH9LW5YQ4
         MLI5HZxCyI8HcHDS240rMWOuEAfzQZ/cTa4nsQK4a8QfD4WHNpbJ5iO6lA0yLQwpwEZ0
         eUOs1Ui2jlWss3IsKQmh3zsj79p5rz1POnbv8G0aNVjWXKxpaYgiu4eFY3LbNvi9mMv5
         YA8OjL2p/sBfGY5yfuy0BUR0O2YlLrIXJebV+xkfppf5bpmMUvE1U1QkR3Y6eifRf4cK
         1o0eG4n3HkJxG50Vd/PQWKs8o39BKS/pyVi/KfedPTGZL5vACqA1/KVgo87s9Q7yNx0y
         97Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iEa/8mAzzO9RlCYIla5k70SI1Iglg8mw5NOlpxJMReg=;
        b=jdtJIoDByKPRpXv+wElCCrVzrHl4k4wbxMopNMOzGlUMLBq441g7ae7qfZ6mzC19gU
         GqagthSp7JHglgn++AWehdXyBC1C0hKxqsMcyxdQEzEK2e3/dX+fL9kSvYaj34fBssX8
         81q4km8U7C57MAGHF77pg8630VqEIlbWgrGH8MHEz29AIPMYQTUT2YsRgRKYxesR4NBO
         BxE4LrvYAcVTY3ESvR+7vnam49IG4ybgSOWbHQ2Vnz7NYxUWJ4lVUHXICpdjPb2aTRMC
         8GRDlXCxWX9yGyyr2Wi7Gjo/MXhqYL9+uBkyzgaiMVReO5pR6QBp9XTSz5kgU1gahvwF
         iatQ==
X-Gm-Message-State: AOAM5309iMf75nj6ANPvjFslp7I9YPGnHXJoG8CnE2hmmZ8f1tgg5zUL
        56UHEs1uPR8BY8yG3pn57TNSbQ==
X-Google-Smtp-Source: ABdhPJy1LcibwDb9MJE8lAR7DRt7CFWMODxweOaiwfYI3YYaI09MJQ7HOtUcThFhi4aeVSSIeG3mqA==
X-Received: by 2002:adf:ed8f:0:b0:20a:e2a7:7201 with SMTP id c15-20020adfed8f000000b0020ae2a77201mr463281wro.26.1652373357971;
        Thu, 12 May 2022 09:35:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:35:56 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 4/7] sched/core: Add permission checks for setting the latency_nice value
Date:   Thu, 12 May 2022 18:35:31 +0200
Message-Id: <20220512163534.2572-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512163534.2572-1-vincent.guittot@linaro.org>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
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
index 036bd9ff66e9..2c0f782a9089 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7340,6 +7340,10 @@ static int __sched_setscheduler(struct task_struct *p,
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

