Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E927527C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiEPCpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiEPCo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:44:59 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F012E686;
        Sun, 15 May 2022 19:44:58 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id u3so985258qta.8;
        Sun, 15 May 2022 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmgMp6GvUkzNH+zUibeCMplxNIPkAGROCIcy5eW+4vc=;
        b=hGGv72BYX6iJjv/7a5ftHCcnCgpBrvSIuCg1ghANY9ZWQRApMJWMXwf1MFM5eR/UCH
         FLzRpErl4ms+SwwBZdpGOeJ9I84Vy+bQMQJBoNQEietdXQfNm7LcUAGkh3aDnjtO+l/o
         W9gjhGf34Dwt8EmOEYf8TT+GKkiuVeKEXUahhfUXLMG6686AWBeWwa/oGAG4CJClTsn1
         WN41Mlu0WBjQU2DC/Kx6kjI5T39ITvPu6g2DSm23XNw2xdMf0f7QmvO/0E6sZ4+bIXt6
         oBrLpHYuk/cBzsK6IDWnOO3qiU/febP3TA7aDYS1hLniz0Ex1wfyXd66E+IBprJZDZdV
         +glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmgMp6GvUkzNH+zUibeCMplxNIPkAGROCIcy5eW+4vc=;
        b=mt+N9PB6ALbQyLYs5pl/f/l97gOOiBzhWfloXPo4KPceJYnAcMprl+4r7bm6hgdMrJ
         6HCAe6sp+qBWwZtfoBaSSt2CvfSkFPk4n//8Oqyv0NOrH4mUZzHd4tGgOCbtYVEYAMm+
         lTd3Ras3szx5OBJxZRnDEOFKxtee+3ozseVRh6HjPmXxdM4KmdiZlr/Cy0QCqhL4rL4+
         cafpThuhnFG+GBKD81OYK4pwVhGBHSeqtkB3jD+jUv049+8kaujfO49+8GUt7RL5HJq+
         /piWyrgbclH5EBYolaaOx8snDhqdFLBlHzcDYYRF670jAaN6Iv8mt0e6J6vclQOeh4K4
         EJHw==
X-Gm-Message-State: AOAM533wPW1H4+WNjPCcDd49SqN+5aNKKmhxylKUX79k0RH6uAQYLaWG
        PisYUIEQcMn9HN8DPkD6EgBceb2MfX7tE5ut
X-Google-Smtp-Source: ABdhPJxzHcCMYPPl1FS9EKMnN1FcApa3TyJ8RuuK6k64POxXqz4mMyAxDRscJXRnwZoahaDdVQrU4w==
X-Received: by 2002:a05:622a:15c5:b0:2f3:c195:8d5 with SMTP id d5-20020a05622a15c500b002f3c19508d5mr13863473qty.369.1652669097798;
        Sun, 15 May 2022 19:44:57 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id 186-20020a370bc3000000b0069fcabfdaebsm4973821qkl.70.2022.05.15.19.44.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 May 2022 19:44:57 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH v6 1/2] cpufreq: Abort show/store for half initialized policy
Date:   Mon, 16 May 2022 10:44:47 +0800
Message-Id: <20220516024448.14637-1-schspa@gmail.com>
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

