Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED87054BE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiFOAED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiFOAD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:03:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21565186D4;
        Tue, 14 Jun 2022 17:03:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k19so13180557wrd.8;
        Tue, 14 Jun 2022 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0z4pjcptcunW3Z06jtQN0IsyiyXwTKoHZqtl2Ou09s=;
        b=KgpCqTRfEGlf3dwe8pDO/nofFrcQWOdl1Ueb4bKfDZttESpHrAMwEy67E31EopjSYP
         OJZegYI5PMy9wtdL3qOfwenIoA37aPYn2K8N/v8onwMANEUtZVaRk39w7btWvoKTKbeG
         AkYa0O3/jh5+4ukRyn38cA/CjzUBq4fbMiSxTibT8FOqhO/NmKvNuxolp63EK/FrJ8K9
         r7BKaZ8TIvAYb186tEQFYl69QkCYWceNEmP7z6FucmGhwSlyHZH4RilHU0GJweYHVW+1
         9AJYlD1h2VqXJmMAkT+3zJnFgzFFRJ0dHH6bL1n427fXg+DzEUgIS+lqtOlL6KafgiKh
         0DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0z4pjcptcunW3Z06jtQN0IsyiyXwTKoHZqtl2Ou09s=;
        b=t0I/kHukftplEbIQmQZXr4DBOP90MMQSgVSW+1z6Sw8CUjhOV0ogKUl1nAXL2E8B4k
         hsbDxH/tYEbsAjpLluk9ZfZzfZlzSeR1K6N+9CkKWkzHaQlPtgOnRp7xVkmvhZRMW480
         S3TRlLOXvMPsIVSyTAGC8Fs1fkGZjY0EVp7GRcn4JxA76UCx9x4aknAG6xeyDVsQoKRT
         RVsD9ESIkkeYKJalRjXhVFAR/jlkgob6hOo0T3/BJ9b8icmUUcg/TdaosR6Hl8mpk1Z0
         XcYyGf8YwEhzBzTD/3/BWbF5flBUTFG48k3xDXKCN/FEAVB61rtxkVRJFQERY0uIXeJF
         fFPQ==
X-Gm-Message-State: AJIora/qoBxuQrwZLsD+I1C3uhwYBcMo4UP1lcKACYLUV8if/9qGvYs+
        /CeeRXG8dx0IGjdzAPpVOeg=
X-Google-Smtp-Source: AGRyM1tYIfaQCWcS658ac6B0oKaAAzYroYkLsEdrjkdKjhUR9xE30wDBkIpsd9g4d8IM2wGT1SmSBw==
X-Received: by 2002:a5d:47c3:0:b0:219:b471:f7d with SMTP id o3-20020a5d47c3000000b00219b4710f7dmr6955919wrc.242.1655251433495;
        Tue, 14 Jun 2022 17:03:53 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l7-20020a05600c4f0700b00397342e3830sm5546821wmq.0.2022.06.14.17.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:03:52 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 1/4] PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
Date:   Wed, 15 Jun 2022 01:09:47 +0200
Message-Id: <20220614230950.426-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614230950.426-1-ansuelsmth@gmail.com>
References: <20220614230950.426-1-ansuelsmth@gmail.com>
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

With the passive governor, the cpu based scaling can PROBE_DEFER due to
the fact that CPU policy are not ready.
The cpufreq passive unregister notifier is called both from the
GOV_START errors and for the GOV_STOP and assume the notifier is
successfully registred every time. With GOV_START failing it's wrong to
loop over each possible CPU since the register path has failed for
some CPU policy not ready. Change the logic and unregister the notifer
based on the current allocated parent_cpu_data list to correctly handle
errors and the governor unregister path.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/governor_passive.c | 39 +++++++++++++-----------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 72c67979ebe1..95de336f20d5 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -34,6 +34,20 @@ get_parent_cpu_data(struct devfreq_passive_data *p_data,
 	return NULL;
 }
 
+static void delete_parent_cpu_data(struct devfreq_passive_data *p_data)
+{
+	struct devfreq_cpu_data *parent_cpu_data, *tmp;
+
+	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
+		list_del(&parent_cpu_data->node);
+
+		if (parent_cpu_data->opp_table)
+			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
+
+		kfree(parent_cpu_data);
+	}
+}
+
 static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
 						struct opp_table *p_opp_table,
 						struct opp_table *opp_table,
@@ -222,8 +236,7 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 {
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
-	struct devfreq_cpu_data *parent_cpu_data;
-	int cpu, ret = 0;
+	int ret;
 
 	if (p_data->nb.notifier_call) {
 		ret = cpufreq_unregister_notifier(&p_data->nb,
@@ -232,27 +245,9 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 			return ret;
 	}
 
-	for_each_possible_cpu(cpu) {
-		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-		if (!policy) {
-			ret = -EINVAL;
-			continue;
-		}
-
-		parent_cpu_data = get_parent_cpu_data(p_data, policy);
-		if (!parent_cpu_data) {
-			cpufreq_cpu_put(policy);
-			continue;
-		}
-
-		list_del(&parent_cpu_data->node);
-		if (parent_cpu_data->opp_table)
-			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
-		kfree(parent_cpu_data);
-		cpufreq_cpu_put(policy);
-	}
+	delete_parent_cpu_data(p_data);
 
-	return ret;
+	return 0;
 }
 
 static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
-- 
2.36.1

