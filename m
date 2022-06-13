Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881F549B03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbiFMSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiFMSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:02:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82143CF2;
        Mon, 13 Jun 2022 06:45:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a15so7218762wrh.2;
        Mon, 13 Jun 2022 06:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2TiwGsa9nhGWe7+rjdwUgqJf1443Z5iWoonROnv/enI=;
        b=mEL3wQ8T2LeY5SU36naJDyiASdHtl4q0VUV82LiKzKEaMXr9uNpCPzSC/fzlemCX3c
         1BhPAQnyxeymprUMBKsoN7gRdOYKZFJ6VjNLujxM53rCFeMjyxz1uBm9Opqn4DOFBZn6
         fhzSbIUtooKP/U4vKPywT3sjiTCu1XPID8weEOXY5aWUr/7kZTTQ05eTIXm/vr50j6Bs
         gKShYU7L+VMlBzlI4DcyhwdrhuoQp3EH7sl5C+6M7g1PA3IySMC+E5LMCdtoyQfnllR2
         9dHYKRXU2OJKrx77GJAGZuqIxZ9MvBfN6RurXx0wCNrt+4iY6Hp/X4CY0WENWoYw8ezx
         B5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2TiwGsa9nhGWe7+rjdwUgqJf1443Z5iWoonROnv/enI=;
        b=KVJMxatHVXN7RdCBHGGJILAh7pSa8QxsmFxZE47NQUsdoMtd1GqE2VmPTdgKeSe0ED
         1xaxc8tlYZlrMuVslGNy3eMPxhMjCjld+QL1JAs51T9mjGp5E9IGH2OCmmcM2+Qnbc0Q
         GoSccGKYqypl5I5cssbSbg3AlTeL9BInSP0va30nowxUzQmOhjJetNO2rs7Sa9EbX0WS
         qNj7XZtvv7OWAu8qg6H8rILJKEV21heiYOoULs6KStGxJH5yvlF9bd/DZHjqQPouzXiD
         pgpAboH0RfNvC31B+NgTdmQx7CnMqgKlronOwfcTrVfiM1e2oRNUUeBjSkZfpjVgKbiJ
         2rzQ==
X-Gm-Message-State: AOAM531r+EmPi7z3LsMG5DfKYRwozSBcXvTgFjNQmQ4fXvI0zXr6XCsX
        RXbkRi0vXKXC5rRXEdXjxBk=
X-Google-Smtp-Source: ABdhPJy7LALH5l6Qt0uy4Ii18rMrF1XbBDKA5/jx7q4sxmDC1uHryoMXSm6dQnFK3gUJymmE1qUlSw==
X-Received: by 2002:adf:d084:0:b0:213:b515:6a06 with SMTP id y4-20020adfd084000000b00213b5156a06mr55211863wrh.702.1655127911783;
        Mon, 13 Jun 2022 06:45:11 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i1-20020a5d5221000000b002103aebe8absm8647510wra.93.2022.06.13.06.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:45:11 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/5] PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
Date:   Mon, 13 Jun 2022 15:42:09 +0200
Message-Id: <20220613134213.8904-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613134213.8904-1-ansuelsmth@gmail.com>
References: <20220613134213.8904-1-ansuelsmth@gmail.com>
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
 drivers/devfreq/governor_passive.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 72c67979ebe1..6252f109f8d1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -223,7 +223,7 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq_cpu_data *parent_cpu_data;
-	int cpu, ret = 0;
+	int ret;
 
 	if (p_data->nb.notifier_call) {
 		ret = cpufreq_unregister_notifier(&p_data->nb,
@@ -232,27 +232,16 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
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
+	list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
 		list_del(&parent_cpu_data->node);
+
 		if (parent_cpu_data->opp_table)
 			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
+
 		kfree(parent_cpu_data);
-		cpufreq_cpu_put(policy);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
-- 
2.36.1

