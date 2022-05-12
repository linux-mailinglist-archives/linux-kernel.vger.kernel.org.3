Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271455252B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356528AbiELQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiELQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:35:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4242124BCD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so8040418wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WI3cwKsmHof/OcrqvPRziZY0WNbcOSp0pjtWhKscn90=;
        b=ql4skT3syzulvYtB3mKtdEZYmL+0sBTcLlZkplV4e+tc73rQf/EFwdUuvtl976ZNKQ
         Qx9+5MRx4oZYAIeIXr/MvmILjPot4qN73EAR4RfMxYoNRhFXkqobqwNrpQwkGwVyOyWc
         e0pNGwBKkNOQLDyDBkHJWsT/xmyzAnCAY/sedn5zoEzhkHDVOCiMytzk0Soi2tdWLNoy
         dHWKXbxzsuE+h2zeN/jeMFM5EWcF+9RwNK3YWT1ZC99eZl9CIF+HwdTweUnSm48vuosI
         tEiN6tPk5evLbVMtkmOZMTTypc27oCdkAnHFf0PGmg8kbYE4yRIx2hD2SkhOM9IMT7Kf
         5YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WI3cwKsmHof/OcrqvPRziZY0WNbcOSp0pjtWhKscn90=;
        b=aLWBHxM1ONY67BvSLr8ux5mFy2gqza4JNz8KNAazr7CWYUO0zbYdDqDWox36IpGry3
         VvZJUXnfy6clLye7XMAzds8ZkrDk3OEbQExDwp9EmkOnHyyZdkH6eAEEPeKBZ/s1akQj
         EB2PtpEOcjfD3TFaoqddfow+vdDuSxBFhlgdIQ7Q4wR65AnV1502cJyNIBoUPWy+p7em
         n88geXZSsYVGUEXTfGJowgyyRLFHzZh8kukour5ZypLO7hzOQdDgg7rYbhS1aWvrxI81
         FI9N5iDUpfmhzjn2juCIUxhHW+bdhBqaTUb4ZLjc8JJ9T1h5jbFXxybNtmkMOfNksvNE
         ITDQ==
X-Gm-Message-State: AOAM530tJxTewpFFM3kEYdwVAJUk23vp4Ryy6XotHSVR3u2NVawSGE8E
        CDyF+WHQNwmmdpUHPuuG4cr44g==
X-Google-Smtp-Source: ABdhPJyO/iWs0LX48cRHJvndLLMM3GLztO2pjnzf7Kd816KCuJ25oK4UEqNfvXeqmVis0QtYeoQNsg==
X-Received: by 2002:a5d:64cc:0:b0:20c:6339:3790 with SMTP id f12-20020a5d64cc000000b0020c63393790mr467141wri.378.1652373353490;
        Thu, 12 May 2022 09:35:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:35:52 -0700 (PDT)
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
Subject: [PATCH v2 2/7] sched/core: Propagate parent task's latency requirements to the child task
Date:   Thu, 12 May 2022 18:35:29 +0200
Message-Id: <20220512163534.2572-3-vincent.guittot@linaro.org>
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

Clone parent task's latency_nice attribute to the forked child task.

Reset the latency_nice value to default value when the child task is
set to sched_reset_on_fork.

Also, initialize init_task.latency_nice value with DEFAULT_LATENCY_NICE
value

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase - minor fixes]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 init/init_task.c    | 1 +
 kernel/sched/core.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..225d11a39bc9 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,6 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
+	.latency_nice	= DEFAULT_LATENCY_NICE,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 07bacb050198..1f04b815b588 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4473,6 +4473,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	/* Propagate the parent's latency requirements to the child as well */
+	p->latency_nice = current->latency_nice;
+
 	uclamp_fork(p);
 
 	/*
@@ -4489,6 +4492,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

