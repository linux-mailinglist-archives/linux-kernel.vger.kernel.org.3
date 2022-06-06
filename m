Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D453EC44
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiFFLL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiFFLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:11:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B49243EF1;
        Mon,  6 Jun 2022 04:11:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x62so18300958ede.10;
        Mon, 06 Jun 2022 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFBp15JiwiS1Ui+MoaGX6oHH82+d0+woWm07QI8KnOc=;
        b=LFlMGaJzCDNWX1JxMKWQn7CB9NO/Ikcus6L03o/BKI7iVrjuec52i0Km7VIR9H9Cql
         4w6Oa2Y7VcIRTlPn4b2ZXsV4ZPJ2ZWqVOS0dT6bS8Rm/suH1aN7PSZoIK3QEY5Pi5zzQ
         POjGPm+UbqqU82EzvYiGvrgsL5b2Fs+gVVOso148VLre39of/DKak2+fc+YMVzxcdZef
         GH4oy0sZ4ECi7SVnwg9/mx9qLtFgjABUcOWEBm2nfjr3eLv4dTj8DjF6ERk9upeZ6itY
         bClGotVIXwMcLRAEILXEutsh1ne1c8v8rC1jyp28GVJ7+cOjcD3LNRfaP/fzfDDPnzJM
         NaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFBp15JiwiS1Ui+MoaGX6oHH82+d0+woWm07QI8KnOc=;
        b=jFjZcfDvT1yBa+ihBgs53lI5w/BrbV8RZicsAggfRkIWfaqVKdwBn6f1VdDvkNms4s
         dJZeAukrLvjxOizhEPRGqvNWizE2a/X1mEgASxMbvQ3tdlc0xmXSPGmOQB0HU3QTJNPh
         mkLL2I8kB/m5hpz+lu2D7DW8VW1c9jxXL6FSy9w2Za+tWgyriDIpnvkprja6rMR5pNp1
         x21vxpoWeQrHkM2PsO6aBZ4WQPTN4Kn/jMjQVfNYLPsiyUjz1bEhkpBs4N6INePKplRB
         E7hYDnawkMDJ44GSmFShCaKWU7Ebrxdd1c+6NbE6oXXovUKaUZ6MlCQvzW1vGXSUtbI+
         iGXQ==
X-Gm-Message-State: AOAM531W+eZVmMrw3wl8wLecI2f1y9MXYzq6g+rDmjln1J35RsD+3C+h
        LThx7nxn3Ne/pa9SN/YJbv8=
X-Google-Smtp-Source: ABdhPJxrMqy7/bwV0Me0abZxC+r6atKh3gom/y6hzmDfeiWt355IzqO+QcXitTaYTAdveBrUouYPzw==
X-Received: by 2002:a05:6402:c8b:b0:42f:ac38:9c07 with SMTP id cm11-20020a0564020c8b00b0042fac389c07mr16589467edb.292.1654513877366;
        Mon, 06 Jun 2022 04:11:17 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id z14-20020a170906074e00b006fecf62536asm3843506ejb.188.2022.06.06.04.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:11:16 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/5] PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
Date:   Mon,  6 Jun 2022 13:11:00 +0200
Message-Id: <20220606111104.14534-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606111104.14534-1-ansuelsmth@gmail.com>
References: <20220606111104.14534-1-ansuelsmth@gmail.com>
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
index 72c67979ebe1..09b6c852fccc 100644
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
+	list_for_each_entry(parent_cpu_data, &p_data->cpu_data_list, node) {
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

