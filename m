Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B94527C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiEPDDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiEPDDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:03:05 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F65F56;
        Sun, 15 May 2022 20:03:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a22so11412295qkl.5;
        Sun, 15 May 2022 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tBgExR0vnd7YeIN6exy+FZqzAtBcN823ZwmLJgoZM4=;
        b=Dt0n/o78G8O5CmeL15OxCRf1vH0qc/qDLtvTljzjUaXl4UHcuvQcOoBciZJWAoj8w0
         IUU5EkKv8fRae6PUk/8chmxu+4q5P+mSeV3n1MsAVFR7KYjUTgwIfV91vgj5SxyJoSa1
         lgfs0pZ6OdRLlU7Bh3liLsxkfl9PMwYSUm+LeIV8ojKcxTDPVcfD/m4rJz9hHEU+HvO+
         fubbLv+DS0n2mI8woNBYWIyEjKxtLzjzpKvsQm8xRVort9ZBoacpPxokRF+qXwVSCjy8
         e93zU7mIC1+Ah9buZT1uonJUdGV5q4SSlw99MKh08hkQpgn4HhNTP3vNLyKC8bAKC8+y
         AtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tBgExR0vnd7YeIN6exy+FZqzAtBcN823ZwmLJgoZM4=;
        b=abdvdGIm0nwljTRnZNJFwLl02oSKKiBthAeEYGp6F8yafra9WYoGzwEtBj/z/Z0qFQ
         Kf44uPWk/RTTcRoK3HCTEX1ZVXbjB18vT8Adp8WWGlehU0HjWLaqUpSa7MCHfjq9fTSk
         rqaLFbPMiAMW+jHfHTxfROinn0dfyL3L3Q/7+sQYKBMU0ePbnESoaI58NeZTq6hQVD74
         zLcHILZmSOVP4NCtFT1ZrOqh1kll6VjHi2brGu/QT0Lfjcj8G+YhBc2dZHIQUd6kWvUn
         6R391pYRUhsckWfS/lFXFj6QyFf0nmrMDPOK+pWq7EBHjXoFgGiDUVSVzUzFdzYr3yTJ
         5v/w==
X-Gm-Message-State: AOAM531Hf+SUFS2D3CFN+lFTTXx+a+U4T8ZDfqbn3O7f1592lykaPRuC
        qRcRWbmHXRjbGyaHNl2BY6U=
X-Google-Smtp-Source: ABdhPJygMrdqZ83DlnmDrSrFKeY7Pnw2vBpB8+lhU8+IzsjP/UxNQpyB6rqifHN24jn+Guf9CtE//g==
X-Received: by 2002:a05:620a:993:b0:69f:d0fb:48a5 with SMTP id x19-20020a05620a099300b0069fd0fb48a5mr11019650qkx.562.1652670182328;
        Sun, 15 May 2022 20:03:02 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id 186-20020a370bc3000000b0069fcabfdaebsm4993072qkl.70.2022.05.15.20.02.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 May 2022 20:03:01 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH v6 1/2] cpufreq: Abort show/store for half initialized policy
Date:   Mon, 16 May 2022 11:02:50 +0800
Message-Id: <20220516030251.42323-1-schspa@gmail.com>
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
v5 -> v6:
        - Change up_write(&policy->rwsem); to after out_free_policy;
        - Fixes: https://lore.kernel.org/all/20220515095313.GE10578@xsang-OptiPlex-9020/

Signed-off-by: Schspa Shi <schspa@gmail.com>
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

