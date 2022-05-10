Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605DA521F37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbiEJPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiEJPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:46:46 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252AB4;
        Tue, 10 May 2022 08:42:48 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i22so11609278ila.1;
        Tue, 10 May 2022 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2rG2ZonGqmcTKkQBsuORfQrqsivhm0tmLUtFBAJyAo=;
        b=KkmDf/x3u/7PriJ/qWykqpS2fZfsk+Jx4H75SBzbfvV8P9CUQJh2t3x7vOp7Z5KAP+
         Gsp6NJgLT3wN79LjsXqfonm9BvVOp60fFRr9++TCGXx8GeDZ47IgK/+lebG55s6V+Wkc
         mBqxSAjzdX/HK6n8rf7INPRJaZkUYRVycsxNqR26GqRxy6oyv57yIZhD8cORh6LRvMRP
         /3hT/dCNpCjSgMsE+7Z0O0ubjETjX/S6FaJvasbZWKdPcfz8XzSTzX8gyncPDgSlStev
         OG/EPT2kE6wFYcbnXPNbcNQ5G5KDBImNIEGZR/JYwnEzhpbPcX76qq3G+EoYqpxuIr1p
         ioGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2rG2ZonGqmcTKkQBsuORfQrqsivhm0tmLUtFBAJyAo=;
        b=EOZ/hWqBWb6JfmszAjeW9PMivpDuyjLv6ly4qoqtciilznSz141Aayqhf1vP1ZY8Kq
         d9WVVTgAQgZa0lVRmgUIUVze5KuRh0dYkDpvNcEp307odZRgC+t8aF18869ja27I12lm
         jeTup7gbJUe8Unhk5JMU5ofNPCIYufm7XTWmkZR8wjbS1C0ATezgQrhO/W1F7zmYsg7E
         QZJI4bjtx3rBcOahxb3rfbhv6QmYMhW2yR0jPM0y4uKKT4d+qwooCdMfeeLSV6zfOP/2
         R3bsY/gLpKr+HAIOjCtQQ+zq0CCCDJPzKG3r2vSXch9zrr7QzlDW2vNZG10waPrfeg5X
         q8BA==
X-Gm-Message-State: AOAM532rHfDNYhsiMf7wClNd8Nbd+fvpm9lNNNovBadWuwDHWjX2cYnt
        gCGZYDvhYzrXQRYt7x/sV0Q=
X-Google-Smtp-Source: ABdhPJy8JEyKuuGwsF8dyWch0XhpqkGP9xMJVmgiHuJfW4VuiQHawfhnTlgI0z/LnQk/jYYCm7mQxg==
X-Received: by 2002:a05:6e02:2146:b0:2cf:87ae:ddb0 with SMTP id d6-20020a056e02214600b002cf87aeddb0mr8438621ilv.188.1652197367963;
        Tue, 10 May 2022 08:42:47 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id y12-20020a92090c000000b002cde6e352d1sm4001307ilg.27.2022.05.10.08.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:42:47 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, schspa@gmail.com
Subject: [PATCH v3] cpufreq: fix race on cpufreq online
Date:   Tue, 10 May 2022 23:42:36 +0800
Message-Id: <20220510154236.88753-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
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
v2 -> v3:
        - Remove the missed down_write() before
          cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 80f535cc8a75..d93958dbdab8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1337,12 +1337,12 @@ static int cpufreq_online(unsigned int cpu)
 		down_write(&policy->rwsem);
 		policy->cpu = cpu;
 		policy->governor = NULL;
-		up_write(&policy->rwsem);
 	} else {
 		new_policy = true;
 		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			return -ENOMEM;
+		down_write(&policy->rwsem);
 	}
 
 	if (!new_policy && cpufreq_driver->online) {
@@ -1382,7 +1382,6 @@ static int cpufreq_online(unsigned int cpu)
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
 
-	down_write(&policy->rwsem);
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1533,7 +1532,7 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
-	up_write(&policy->rwsem);
+	cpumask_clear(policy->cpus);
 
 out_offline_policy:
 	if (cpufreq_driver->offline)
@@ -1542,6 +1541,7 @@ static int cpufreq_online(unsigned int cpu)
 out_exit_policy:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
+	up_write(&policy->rwsem);
 
 out_free_policy:
 	cpufreq_policy_free(policy);
-- 
2.24.3 (Apple Git-128)

