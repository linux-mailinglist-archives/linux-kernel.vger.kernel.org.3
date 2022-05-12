Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB94F524ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354721AbiELNvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354509AbiELNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:51:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1186620A;
        Thu, 12 May 2022 06:51:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t16so4297241qtr.9;
        Thu, 12 May 2022 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AmgPpxvn6EdK4HK0dUjo8+r0C+bjsTldPYOViPnEiM=;
        b=iVNlugp1YwMJo71BnKtgeDbh28Ui7pbxjG3thnmCDBTSz/5p4OMIWjSIoLUhobuchS
         3pHHkiKLDRXpw1LWQPvdiPtvsyOShBDdcuzrFIrUidIgVfkrc3g24l8+ESyvP7mxxRZS
         oqXH3S7HjgrZ5G8F8OSIb0JUj5WuQKZKxonDzXWlLUPAcHiQ0wX/ZC8B5SCpweeFqmsw
         3xEFkVkyc4bOz+rdaEIhZC13WR4XACAnazzFuN5/HKqbW3XXjwUFclugaDYFREDWGL1F
         yKlBnfWz8+8qVlK9FHqIsyskpy7pOAp+Or009poBY+lK0qtU2nZBVpxRknTISLgzlhVU
         UCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AmgPpxvn6EdK4HK0dUjo8+r0C+bjsTldPYOViPnEiM=;
        b=UJi9JYsZXy3d7SWEIb5/5AblYbG6xJuso6k60oNtDXPEiddtR1sRf69Wz6VVP5NP41
         7rgdw8mx7RKUiErPRPO62Ii8BFCra0yNLlqD09JYtid6qTkSu4Ko/Rbi4vzdtQuNnS6R
         9WwJibts76c+eSkgcE/B+iVCFydZoTFLjvOiuvRj10wRHyt9kGm8YhnxngpFwn8LCVBg
         2uNHlTnxUve4Q56+vh84L9GcCrMwzdfvtnmUPuyjYAukeB4gyBVyiQ+Rm+pYX7fSPGPH
         +EOKT8j3TtWqlxsUeE2jW83kPrJ3QBdOWm/xW7/rPedxVCe2F5JZCbwx2+NjU2msVwwz
         QxNA==
X-Gm-Message-State: AOAM533uOjY7U64F5iTr26cpu2qgBRjBHFVYqZxEua+rfDDxjgtfNzFz
        AjfbCaQC5xYl1mMwgaiZb0Q=
X-Google-Smtp-Source: ABdhPJwOnZvfFv3s61HvTNVHJwrqa/g8CsemUMP21n2PsTfQG3JCvTbhr/MA/Z9DMhV3QgYMMUuTyg==
X-Received: by 2002:ac8:598a:0:b0:2f3:cbf4:7b4e with SMTP id e10-20020ac8598a000000b002f3cbf47b4emr26814459qte.449.1652363501377;
        Thu, 12 May 2022 06:51:41 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id 193-20020a3704ca000000b0069fc13ce251sm2851503qke.130.2022.05.12.06.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 06:51:41 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH 1/2] cpufreq: fix race on cpufreq online
Date:   Thu, 12 May 2022 21:51:28 +0800
Message-Id: <20220512135129.8493-1-schspa@gmail.com>
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

