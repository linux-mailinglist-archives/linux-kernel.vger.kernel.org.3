Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF345260B7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379769AbiEMLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379766AbiEMLJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:09:02 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BA71356A7;
        Fri, 13 May 2022 04:09:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id p4so6494936qtq.12;
        Fri, 13 May 2022 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmgMp6GvUkzNH+zUibeCMplxNIPkAGROCIcy5eW+4vc=;
        b=N2AbmWKlTMtelPKNo0GzQElQkZxny2h3l07Q4c8QSoeEwWdaGMyY7WZZMdWLyz4WVT
         NCj6+gULWAVEkyUOrerghm9J4y/JDVNh6isrScn4ctu4NaimjJFToPZgdVyEo9G2sBeY
         FpZvnTabZCoy9eZ7rDSd2q63+C/JPgqoffdK+lRxHGOKJUSxxLG80EsTUjkR43zbnjYf
         Jl+Fml9F6FSA9v3y6AgPQ9zLBqfBCUtZElkaXNydIOWkKpA0n7PI0qs5xxFCugxymM7W
         WVQ8WaDnqxmDDAE+K0wEclNqGBDxgvloaJ/dXb1iLk8s+HWBMmfmiboz/dhjizMT+aQb
         byXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmgMp6GvUkzNH+zUibeCMplxNIPkAGROCIcy5eW+4vc=;
        b=5L3YSt0STtXel7ulqDWEcfVk/FYXR7faCOj42LI/w4ZvVmGdz5flgy3Oz6T53QA6Hp
         imQJWXdEjdz81cpdOGlIaeVOsC0ShU17LX7n0sACvIz7PQ3mrfpHvHLOy2IvZL6iwG/L
         NCTE8Be5uGzP8pXC02WB0sxXUOaHPeGePujd/9JHhWP8Mw1lvizTEWwmrzu7nHfiqBO6
         88gr6uHdESG7vmy1tYBhkKqefPfYlwY+d8x42m4nTNUN2V7uR4QX0n+8BltWTdkfK0Ek
         OWiucT+Ew2dAthYSF3uMwOs4+Lfzm4aMdasYI/v3Zqs+DrSA/L8C7r+xXod5g1jxJTSc
         SSXg==
X-Gm-Message-State: AOAM533xY37AMXLMHG1nvLjCXH/xERYOXBaWzVRnVuciC/0/VVLKi3Pw
        TmYJ4dMUP5f5hidoVtXdEXt5HRHi7RQHRgUy
X-Google-Smtp-Source: ABdhPJwNGzvFRR5or8n6Km5CQIiApH6yHBiP1d5j6g24mm+kstLp8O5NCyccJ9jSReCuCLlxPzCDcg==
X-Received: by 2002:a05:622a:1e12:b0:2f3:d254:45b7 with SMTP id br18-20020a05622a1e1200b002f3d25445b7mr3995083qtb.88.1652440140560;
        Fri, 13 May 2022 04:09:00 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id b16-20020a05620a04f000b0069fd57d435fsm1127548qkh.101.2022.05.13.04.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2022 04:08:59 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH v5 1/2] cpufreq: Abort show/store for half initialized policy
Date:   Fri, 13 May 2022 19:08:47 +0800
Message-Id: <20220513110848.20204-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
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

If policy initialization fails after the sysfs files are created,
there is a possibility that we may end up running show()/store()
callbacks for half initialized policies, which may have unpredictable
outcomes.

Abort show/store in such a case by making sure the policy is active.
Also inactivate the policy on such failures.

Signed-off-by: Schspa Shi <schspa@gmail.com>

---

Changelog:
v1 -> v2:
        - Fix bad critical region enlarge which causes uninitialized
          unlock.
        - Move cpumask_clear(policy->cpus); before out_offline_policy
v2 -> v3:
        - Remove the missed down_write() before
          cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
v3 -> v4:
        - Seprate to two patchs.
        - Add policy_is_inactive check before sysfs access
v4 -> v5:
        - Change the commit message as Viresh advised.
        - Initialize ret to -EBUSY to get rid of the else part.
---
 drivers/cpufreq/cpufreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 80f535cc8a75..ba73be6f0490 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -947,13 +947,14 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret;
+	ssize_t ret = -EBUSY;
 
 	if (!fattr->show)
 		return -EIO;
 
 	down_read(&policy->rwsem);
-	ret = fattr->show(policy, buf);
+	if (likely(!policy_is_inactive(policy)))
+		ret = fattr->show(policy, buf);
 	up_read(&policy->rwsem);
 
 	return ret;
@@ -964,7 +965,7 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret = -EINVAL;
+	ssize_t ret = -EBUSY;
 
 	if (!fattr->store)
 		return -EIO;
@@ -978,7 +979,8 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	if (cpu_online(policy->cpu)) {
 		down_write(&policy->rwsem);
-		ret = fattr->store(policy, buf, count);
+		if (likely(!policy_is_inactive(policy)))
+			ret = fattr->store(policy, buf, count);
 		up_write(&policy->rwsem);
 	}
 
@@ -1533,6 +1535,7 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
+	cpumask_clear(policy->cpus);
 	up_write(&policy->rwsem);
 
 out_offline_policy:
-- 
2.29.0

