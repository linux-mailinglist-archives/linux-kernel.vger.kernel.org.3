Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA34521EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345840AbiEJPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345782AbiEJPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:33:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D46722B13;
        Tue, 10 May 2022 08:28:25 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m6so18883208iob.4;
        Tue, 10 May 2022 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/xV9jXS6t5BwMHL74xYjDUj8Vksp4bAXLh2xtDAu2Rw=;
        b=osczqvjzu38Guh1XIF7NuRucvRqzIl+tDeQ8r2dLZnddyJnVYfwSlvnSBVB24QVcT8
         PbRoTPBWvS0DmpY/jeaYe2MXmgqW3hUJ8ikyFyEazUpY77lWjcvsdvA9UdwDivoWRt3g
         /h6VUpeP4V3qARNkA3genR1tcJCAsgWprsYBzfbi4JV0zFv0j2NcwqyOplzuh1V/aTm+
         WTD+Xfx7sS1e9Rj7o3RAe5+PLbL7TYiMsH5tzsZ2JI/WtVdkRuhVKVgFQkS5QSDavMkX
         1dM/3/sOIXcA2VmqYU5oDhnHai1nhJYJRgeqv/07tq33nmmAAYDVip0Jk2euzqZA+mqG
         WGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xV9jXS6t5BwMHL74xYjDUj8Vksp4bAXLh2xtDAu2Rw=;
        b=vNM6Rkbx+INWT9LLZNaDaKvN4YNXETN308nzi7EiQaGxxqhjWWV/9wSTuwpN990Nmf
         rOZt3PoOt6m64BkHjIPTbQhjOsDpDWTXbhgQWvK+y1WrOZRcidjcc8vILGcWaD3ySFRT
         Q7DSIRXohlQ8Si1NdT0Y1q7fb9jCfP8DrLGPEoXMLv+FqgKx6epgqEFG/dhpqZP7T4uP
         pKNUzjC4EjiSiZ3iaymlpYH48jd2fySvoD46lQrGAbZCNzoZs1QVv6GJJ5SWrNGcmzot
         GUeiRoiF5LZykGfyziUs4ZSDuIVB9JfTP0MZr4HpR/y8Rb/2ZlREz8IDZ7kH6tt3qfyi
         41Ag==
X-Gm-Message-State: AOAM531yHHCvAZYFHYGa0QN3U0PSEHEpkt96vsAjLSTbbbryUTQ2EH3P
        X2eM9jB4/lrA5us54w9CxkM=
X-Google-Smtp-Source: ABdhPJy7ETJlguxoXdaaR5xy3MaZe01pmd1wdVqOE4gv384fyZUNMunjaypR5dyZYsPYVq5ho95AWw==
X-Received: by 2002:a02:c887:0:b0:32a:fbd6:2e4c with SMTP id m7-20020a02c887000000b0032afbd62e4cmr10062757jao.244.1652196505047;
        Tue, 10 May 2022 08:28:25 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id h14-20020a056e021d8e00b002cde6e3530dsm3809897ila.87.2022.05.10.08.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:28:24 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, schspa@gmail.com
Subject: [PATCH v2] cpufreq: fix race on cpufreq online
Date:   Tue, 10 May 2022 23:28:11 +0800
Message-Id: <20220510152811.88071-1-schspa@gmail.com>
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
---
 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 80f535cc8a75..8edfa840dd74 100644
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
@@ -1533,7 +1533,7 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
-	up_write(&policy->rwsem);
+	cpumask_clear(policy->cpus);
 
 out_offline_policy:
 	if (cpufreq_driver->offline)
@@ -1542,6 +1542,7 @@ static int cpufreq_online(unsigned int cpu)
 out_exit_policy:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
+	up_write(&policy->rwsem);
 
 out_free_policy:
 	cpufreq_policy_free(policy);
-- 
2.24.3 (Apple Git-128)

