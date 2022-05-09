Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183EB51F325
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiEIEJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiEIEBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:01:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F3DFC773
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:57:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q76so10948075pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 20:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA3QBtPI3O1Tfh2czp5nCb1ZHar3YqBZK+8IBbh2GL4=;
        b=XLrOMOGf7eUqDcGo2C93lcSbcOVHHwJ9AgWvnOp8InbUmMb/p3Scnt+HB8KagrN/tc
         UjylYfTzYjNZRUfJqWwtyl51PBL3wEUZ8yVf8OR3+euT7YTetZ851DxFJi5YuQa1d7lm
         uFvF3reXbjEUoD1nBmIOTiCP1wj+Y295CLSSFeA6m+2RBshBptzctNgjEgFWhAwXrvp4
         XnPP6Ol9tToQu0lWkTS3TxmwTZmuaxWKIUGOdN0RlTCKMvoN8oBPyg/q2Wdv1ESm0ScD
         es+sg8xzgki86NGN9fG04yl6k6R15szh60hwNjgmJ6mMjNM0k9iyOre+UpjfhNlBEzAv
         8xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA3QBtPI3O1Tfh2czp5nCb1ZHar3YqBZK+8IBbh2GL4=;
        b=HJ68RwfOHpbr0/vo2T+etrBcqtoS5SGMxPd6b9cn6aJlpni+okVRMfk/90X07UYukc
         seQyiMZv1PqgVZCwcTMjcH3291jijv9hj6yU4hYB6gOYNSif7A2j+IzWUNBljki628XV
         +/Fre8Lv6c0d4nE2H2UAay1TWdezrt/pimmWyGu+Y2SJbYEEM7R+qjCVOauqf6UeMYmf
         o2poklR6Hw8P/Xiwtn7RJhyvMygArMpYLl4BkaQBRI3kj1FbagKXHTbbjLGrKSs2NJLj
         b7BnFZwpm+LgBcyhqCDOe1i3pXjzYaMo9V/f0DQojEBtfsP2ZarPvQjdUAlJOPuxU15J
         gzAQ==
X-Gm-Message-State: AOAM531meqnLbiRU9tk1MwSZR/pfJxNhBMXPakadh2nFFZdtvhrG21J+
        sk5wmEAc5C8PxH3TRNWRIYjR0A==
X-Google-Smtp-Source: ABdhPJyfcZT4vyA7LsNd4ftNp8j+EWMdDGp+1rPoJM6Ybs2WwPT8EbYICPTbejvD3GjrYAYUfrqAgA==
X-Received: by 2002:a62:ce82:0:b0:50d:512f:7b76 with SMTP id y124-20020a62ce82000000b0050d512f7b76mr14401183pfg.79.1652068663103;
        Sun, 08 May 2022 20:57:43 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b0015e8d4eb1d0sm5961358pls.26.2022.05.08.20.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 20:57:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Schspa Shi <schspa@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "cpufreq: Fix possible race in cpufreq online error path"
Date:   Mon,  9 May 2022 09:27:37 +0530
Message-Id: <7f505491f4e8207bb5d79b1b7b34a28b6d1f03b6.1652068655.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f346e96267cd76175d6c201b40f770c0116a8a04.

The commit tried to fix a possible real bug but it made it even worse.
The fix was simply buggy as now an error out to out_offline_policy or
out_exit_policy will try to release a semaphore which was never taken in
the first place. This works fine only if we failed late, i.e. via
out_destroy_policy.

Fixes: f346e96267cd ("cpufreq: Fix possible race in cpufreq online error path")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 233e8af48848..fbaa8e6c7d23 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1534,6 +1534,8 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
+	up_write(&policy->rwsem);
+
 out_offline_policy:
 	if (cpufreq_driver->offline)
 		cpufreq_driver->offline(policy);
@@ -1542,9 +1544,6 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
-	cpumask_clear(policy->cpus);
-	up_write(&policy->rwsem);
-
 out_free_policy:
 	cpufreq_policy_free(policy);
 	return ret;
-- 
2.31.1.272.g89b43f80a514

