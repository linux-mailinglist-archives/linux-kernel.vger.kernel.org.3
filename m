Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FED524ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354688AbiELNwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354509AbiELNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:52:43 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762E6542B;
        Thu, 12 May 2022 06:52:42 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n10so4360299qvi.5;
        Thu, 12 May 2022 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AmgPpxvn6EdK4HK0dUjo8+r0C+bjsTldPYOViPnEiM=;
        b=CGaMZSgceeiAXjZ7U/J28/bVw4EJWKiPI1Km/56Zr8PZw45Va2EUqYhgvTLSVDDmI5
         UU5IcKMIeq6skG1u62HlA1MeFKoAmZj5SuYFdSdtZ4S5SF8tR0rOxj95wG4Nc8qLlkvE
         0ZCsdH9B/J3N6NRy1O6HTgaMGebrzxpHQq3t7JJg5JPhc/jYLZCvqOJ4VuCCcUNEjMOM
         4PwEq640w5QerqBZVuLzCh5XrTB4/JvOYJEg5vr/KukoVZwJCCfJxlD5JUd/7ZierVBy
         Jsz4Ir/LLmt5QGQPmT7klktZcHfRUo7d6ldVWzTEM6odz/2pOqy4IXOmNxd+0NPmsuzy
         rETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AmgPpxvn6EdK4HK0dUjo8+r0C+bjsTldPYOViPnEiM=;
        b=yy+Si+WZNr4PPnMdBYr4xv23wO1rA/Rdu/vKNREOiCHYgGCvv2mHJiQhcskz58YFGS
         zz8h6cFFQy1IphE/GsC73+g2yvpewt6t56zcayayO44gKGq2tRqvsUVpCy6naE4hSW+H
         fJhppHGW3QePQX7vDzfLQAV9fPnDGKGrCPdq0PNs9BfjR1aiM9jy2XtbQDwWA16t6SVX
         WH1Nqe0/Ji4UeB9Al+OCZns2nA9vvhUzE8Gfbvawnkv7t110NLKvDBaX2VJNp3dPD905
         c8DW0JI6ChJA6RZFFwWt5xkbZNMl+UhClvpbVRfO93oDeeDrMo23TL/hto4JBVHn69LG
         pM+w==
X-Gm-Message-State: AOAM532GTYYas+EQLUUgjNIhQ/SkfJEzICnoG1/jrffxo1iUUHOqSPrK
        SXcOwav3I7dlrdpixY3kYdgYVNDHPgwb3Ocq
X-Google-Smtp-Source: ABdhPJxtUbZjUiYVcfuwPdRVe417fmbRT6QtnO+1RzhV6qXzSSM2BdMZGCvW5a4vbMorUvAO50ykNg==
X-Received: by 2002:a05:6214:4103:b0:440:e4d1:a2a0 with SMTP id kc3-20020a056214410300b00440e4d1a2a0mr26800735qvb.42.1652363561661;
        Thu, 12 May 2022 06:52:41 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id r204-20020a37a8d5000000b0069fc13ce1e8sm2885591qke.25.2022.05.12.06.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 06:52:41 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH v4 1/2] cpufreq: fix race on cpufreq online
Date:   Thu, 12 May 2022 21:52:30 +0800
Message-Id: <20220512135231.10076-1-schspa@gmail.com>
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

When cpufreq online failed, policy->cpus are not empty while
cpufreq sysfs file available, we may access some data freed.

Take policy->clk as an example:

static int cpufreq_online(unsigned int cpu)
{
  ...
  // policy->cpus != 0 at this time
  down_write(&policy->rwsem);
  ret = cpufreq_add_dev_interface(policy);
  up_write(&policy->rwsem);

  down_write(&policy->rwsem);
  ...
  /* cpufreq nitialization fails in some cases */
  if (cpufreq_driver->get && has_target()) {
    policy->cur = cpufreq_driver->get(policy->cpu);
    if (!policy->cur) {
      ret = -EIO;
      pr_err("%s: ->get() failed\n", __func__);
      goto out_destroy_policy;
    }
  }
  ...
  up_write(&policy->rwsem);
  ...

  return 0;

out_destroy_policy:
	for_each_cpu(j, policy->real_cpus)
		remove_cpu_dev_symlink(policy, get_cpu_device(j));
    up_write(&policy->rwsem);
...
out_exit_policy:
  if (cpufreq_driver->exit)
    cpufreq_driver->exit(policy);
      clk_put(policy->clk);
      // policy->clk is a wild pointer
...
                                    ^
                                    |
                            Another process access
                            __cpufreq_get
                              cpufreq_verify_current_freq
                                cpufreq_generic_get
                                  // acces wild pointer of policy->clk;
                                    |
                                    |
out_offline_policy:                 |
  cpufreq_policy_free(policy);      |
    // deleted here, and will wait for no body reference
    cpufreq_policy_put_kobj(policy);
}

We can fix it by clear the policy->cpus mask.
Both show_scaling_cur_freq and show_cpuinfo_cur_freq will return an
error by checking this mask, thus avoiding UAF.

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
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 80f535cc8a75..35dffd738580 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -953,7 +953,10 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 		return -EIO;
 
 	down_read(&policy->rwsem);
-	ret = fattr->show(policy, buf);
+	if (unlikely(policy_is_inactive(policy)))
+		ret = -EBUSY;
+	else
+		ret = fattr->show(policy, buf);
 	up_read(&policy->rwsem);
 
 	return ret;
@@ -978,7 +981,10 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	if (cpu_online(policy->cpu)) {
 		down_write(&policy->rwsem);
-		ret = fattr->store(policy, buf, count);
+		if (unlikely(policy_is_inactive(policy)))
+			ret = -EBUSY;
+		else
+			ret = fattr->store(policy, buf, count);
 		up_write(&policy->rwsem);
 	}
 
@@ -1533,6 +1539,7 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
+	cpumask_clear(policy->cpus);
 	up_write(&policy->rwsem);
 
 out_offline_policy:
-- 
2.29.0

