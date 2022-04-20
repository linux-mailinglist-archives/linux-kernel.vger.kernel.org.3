Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B399509033
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381687AbiDTTSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiDTTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:18:45 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4C647C;
        Wed, 20 Apr 2022 12:15:58 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h4so1625221ilq.8;
        Wed, 20 Apr 2022 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOudaK8u8RZc6AtXty/18V0scDsmCBhssZ3goh1YV7A=;
        b=P5BGBaGXMvgspLe6ktrXk40s0GI2UxD6dSMsksk7uwnzfMZh4+gf0hovfAGkZ3Cb1C
         ydnSEbIqVWq0UJUe8EYLK85BUxfnxW2S9F5qdvCnrKXhhAEJZCFic8weXuHXlnKu/H8d
         LeAL2FB/REz6NJ/7jjwU/3KVUbnp2gY2Cf/SocLof6NRyycn7ZPXBVgupnKV871ZmafN
         1IY7HJc1zm3l8l5eJXk2RkM9g5EzaL7xFXEOL98RzH4NxNByj4bO4wsqd/a05snyoCyl
         r4ber8wKyflk+bOdN3i9xjFXt8vA0fFHJCMIRw87lZfCTxwE50e+Tp5ePo5alUEvN4QH
         3cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOudaK8u8RZc6AtXty/18V0scDsmCBhssZ3goh1YV7A=;
        b=aWkJ3RLf2ZVGMv0at2Ikpo2G3R2v8GbYDu+TCbYBA1HSMgTo0W9XiRczc+9fvckjks
         ENceL6vb+08PXk0KTudVMIHhPFFPXwYQOcNQX5yZy4mVrBX/u3uBZ2h2L9mN3qFTYAhH
         sRcDflFksK8+iinY9ObqKQYtQ/EaHYv+iwqlYIgvZ2KKLSZ605fCdFJJNHhhvDq98WJt
         cwjZ3BK0PtzbPW6ZYcBDgVMYdvoJg4dyydeZQv1s6A8I2zvvaPUsC8KLDsbHqfck9WVP
         wzI0zx3/aY5n9Tgqz1YXEKjMsPlf9gXklCUrV1GTzwjjDbxrAYeJD5MmXfQoRasUms0w
         NWnw==
X-Gm-Message-State: AOAM5333y6q5TnULQ/cLWx+CfjzV+TVxOeqqdmM56zmchgTd2mQT1YUO
        EPN7WiCy5lV0BKC+fdf2PN0=
X-Google-Smtp-Source: ABdhPJwasSMXid+ZBWeJxd8gP8wdY75eGF7pQFjwtMcvpEUo6pZts6ETQ2KWiqu4E0GJe0a+cKjK4g==
X-Received: by 2002:a05:6e02:c28:b0:2ca:8380:8390 with SMTP id q8-20020a056e020c2800b002ca83808390mr9350897ilg.174.1650482158192;
        Wed, 20 Apr 2022 12:15:58 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id c15-20020a5d8b4f000000b00648f75d0289sm11834873iot.6.2022.04.20.12.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 12:15:57 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH] cpufreq: fix race on cpufreq online
Date:   Thu, 21 Apr 2022 03:15:41 +0800
Message-Id: <20220420191541.99528-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 80f535cc8a75..0d58b0f8f3af 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1533,8 +1533,6 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
-	up_write(&policy->rwsem);
-
 out_offline_policy:
 	if (cpufreq_driver->offline)
 		cpufreq_driver->offline(policy);
@@ -1543,6 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
+	cpumask_clear(policy->cpus);
+	up_write(&policy->rwsem);
+
 out_free_policy:
 	cpufreq_policy_free(policy);
 	return ret;
-- 
2.24.3 (Apple Git-128)

