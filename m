Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7C535824
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiE0Dxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiE0Dxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:53:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A7E27B0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:53:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3316529pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ufg1eOhDqrWLS5IemSf2tmmF5r8nZpWc+mO2s4T3ZiU=;
        b=i+XHgWM4eeyGv4W88AgzSozzfSs6Qg6ZOmwwhXCEY/eEo8uT1ENLZBS6JE5xrZJgd6
         M0bWeqCcWnZBoYw0VVp4ofmvyf8QSEDY5GooUN0pkWTmaGbhltS+RZhSl9W10TZtNdEb
         pcHDxXDkgZxQIMrsVpXIcBUNfGJ7KEM7XMz//owDzyDeod2UPqdHWmV8uugIp71ubW0u
         3UgQsDFzBAmC2bkxuKoryk75D4L0pSHriTAF5px9Km86V6U2aLgv6nBZPg8SG5BlOwp6
         FGdKjbrxRvCSpuBbx3/3lrYxFY93C8U4NZn/zMDgCtsubeOHzTeqv24Qo46GBpnjhmmg
         pmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ufg1eOhDqrWLS5IemSf2tmmF5r8nZpWc+mO2s4T3ZiU=;
        b=tEUs2ufroeAYnOu//RlugfAB9FTiEmF8C50qv08H2brQYw1LCevgPz3vYxi3PGOdYS
         ArfckLgqghMrBaQpuqV+BhQ4QiLTOjK5cGq+9xSrg+jNniOHvIEMVGk8/L1MrQ6L0pgN
         6kQNbWWJGCC812QfpZW17QUYPKzTLcIr5al7/qc1iGHnsGBMQ79b4QvErdxEERZ0DKPx
         rYErbf4Wa82PpduyfZ1MjYnab8OSVfWdmTL0JB/yTPqeRQOUp8lEkMDn+DalgjDKxEdT
         gHdTcbAs0gcDKqH22av5uxa+/JEgChjICw5cUiKdgPHZKxkgb86xdoTU7wGl/9krA8Dz
         A60A==
X-Gm-Message-State: AOAM5330G/hX+1pc6jQmbzg/uKRuY+UnZrzF99Lnkn6Kw9p+OKIv7pZc
        oeQpK79YqXMcgnx8Rsed9hAq/w==
X-Google-Smtp-Source: ABdhPJx9cXBV6Q+xZtryzM0jvpX+xr6ovhw58pdOP6bQEX6ZBGgJBjm0hPCgTQLuDju8WpMuHTIO2A==
X-Received: by 2002:a17:903:1c1:b0:161:aa16:f279 with SMTP id e1-20020a17090301c100b00161aa16f279mr41441831plh.88.1653623623300;
        Thu, 26 May 2022 20:53:43 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a3f8e00b001d2edf4b513sm423635pjc.56.2022.05.26.20.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 20:53:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] cpufreq: Panic if policy is active in cpufreq_policy_free()
Date:   Fri, 27 May 2022 09:23:34 +0530
Message-Id: <426bf6edc80b2e944d459fa7b8dffbe8b73bb3d9.1653623526.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
References: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
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

With the new design in place, to avoid potential races show() and
store() callbacks check if the policy is active or not before proceeding
any further. And in order to guarantee that cpufreq_policy_free() must
be called after clearing the policy->cpus mask, i.e. by marking it
inactive.

Lets make sure we don't get a bug around this later and catch this early
by putting a BUG_ON() within cpufreq_policy_free().

Also update cpufreq_online() a bit to make sure we clear the cpus mask
for each error case before calling cpufreq_policy_free().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Update cpufreq_online() and changelog.

 drivers/cpufreq/cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e24aa5d4bca5..0f8245731783 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1284,6 +1284,12 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	unsigned long flags;
 	int cpu;
 
+	/*
+	 * The callers must ensure the policy is inactive by now, to avoid any
+	 * races with show()/store() callbacks.
+	 */
+	BUG_ON(!policy_is_inactive(policy));
+
 	/* Remove policy from list */
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	list_del(&policy->policy_list);
@@ -1538,8 +1544,6 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
 
-	cpumask_clear(policy->cpus);
-
 out_offline_policy:
 	if (cpufreq_driver->offline)
 		cpufreq_driver->offline(policy);
@@ -1549,6 +1553,7 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->exit(policy);
 
 out_free_policy:
+	cpumask_clear(policy->cpus);
 	up_write(&policy->rwsem);
 
 	cpufreq_policy_free(policy);
-- 
2.31.1.272.g89b43f80a514

