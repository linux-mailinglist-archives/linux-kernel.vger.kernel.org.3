Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BE51DE05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444032AbiEFREf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382740AbiEFREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:04:33 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477423BF2;
        Fri,  6 May 2022 10:00:49 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z12so5163450ilp.8;
        Fri, 06 May 2022 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hv4at3JYf4y09rWLgIApsDSX2KKaSl4kYTsB/P5mJ0=;
        b=gua7RI8qZk25ZAewCZAiAJMawwqFhhz80joRswrrSwHhsVDCOOYu8i13fjCzBt77/h
         NbNLUJDn8YVcp1T+41qtfChmCn5sms9aEYSKHPEUFPjKcWBvSgi2cSMdHJb/lJ8Rkvz+
         X2anB5H7ASVH7YcisrXDldbK8a3ib96x3P5dL08H/Rcybuo+zLoc9AA6dRB1m/ubO4dF
         Fha/oqnTvNexNyXgQgkDoLs44Yt0NUj037nxdZaV2JfHyv3ZxHmgu7FeN5koqiKFiSwp
         IX7eH+Yic3HhFj4z4mEikD/Zhgyb0iSyeRznbJVTZhpmXlFiF8PCQ0akxhk6PRcU/cge
         PEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hv4at3JYf4y09rWLgIApsDSX2KKaSl4kYTsB/P5mJ0=;
        b=bk0GOKLQu4+KMDvfYPa3X/7/QFTMe/TdtM2kuM3ZskuL2W/UZP/rW7/gijgdySK+iH
         DwgTGyZ3r4WJ+LDPE5dSvQ8BkCC1vc/h0HHRyvEcrZ6Nkt9d4pkuOEom4fj4R7iiday6
         qZw7lkd7iGfGW3XvtlYpubxbB4VkfiszkbfgnSSz30A8jBEDhcfQrz4EW5deiy+Xls5p
         HNfQtxoBX5rgei47Y8gnqZURXg0Q5iA+/gu/KTU6PA9onE9NDaSMrz6IIsjA/WMQVgus
         uBDSTMuw7mDDAMvMSZ1QQ3L22cltQ1jn/jtE/8zBhfHMCT6K4Q3onjzg2hcObwr0fMaU
         eGTA==
X-Gm-Message-State: AOAM530JUse//jvhNiUFPz+pMFUbpTLt3YbJbpAZwb+QkzXYf5lPCJ1l
        nq9oixlea94EOvyi0WQ245ODiGbGG3TguXxK
X-Google-Smtp-Source: ABdhPJwjp2QyOO3aX6GanfAOk4ePC/7fufotuPndabaMczq0WyiENpJP23ShZvUPg96s0ojmnnoBWA==
X-Received: by 2002:a05:6e02:198e:b0:2cf:4a7a:faf8 with SMTP id g14-20020a056e02198e00b002cf4a7afaf8mr1589453ilf.206.1651856449165;
        Fri, 06 May 2022 10:00:49 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id f21-20020a05660215d500b0065a47e16f63sm1411863iow.53.2022.05.06.10.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 10:00:48 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        dan.carpenter@oracle.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH] cpufreq: fix double unlock when cpufreq online
Date:   Sat,  7 May 2022 01:00:35 +0800
Message-Id: <20220506170035.32115-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220506072146.GD4031@kadam>
References: <20220506072146.GD4031@kadam>
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

The patch f346e96267cd: ("cpufreq: Fix possible race in cpufreq online
error path") expand the critical region. But policy->rwsem is not held when
calling cpufreq_driver->online and cpufreq_driver->init calls, which lead to bad
unlock.

And it's well to hold this lock when calling cpufreq_driver->online, which
provide more protects without bad influence.

Fixes: f346e96267cd: ("cpufreq: Fix possible race in cpufreq online error path")
Link: https://lore.kernel.org/all/YnKZCGaig+EXSowf@kili/

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0d58b0f8f3af..43dfaa8124e2 100644
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
@@ -1542,9 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->exit(policy);
 
 	cpumask_clear(policy->cpus);
-	up_write(&policy->rwsem);
 
 out_free_policy:
+	up_write(&policy->rwsem);
 	cpufreq_policy_free(policy);
 	return ret;
 }
-- 
2.24.3 (Apple Git-128)

