Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1954AF08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356126AbiFNLH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbiFNLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:07:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352391C2;
        Tue, 14 Jun 2022 04:07:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y19so16439614ejq.6;
        Tue, 14 Jun 2022 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nFYikEZQyy7dcuLpIYSHTQjryLYDTf8L+QZXU1RkIA=;
        b=QS+9nJAugz9WPCBTtO6v5P2CE7DxfNzf6c8HFpXvyccj0UpFO/HlaYRL01gRyCJwSm
         krROrCcBtCRH1ET0pgUE3o8iOzVLxRu7Ag1kPO/Nz5YnsUbUElUA6D4SAs8AFiJS152X
         NtcHZD1gh9C5OApmH9ufLKOx4j+Z0BIBtgYjV8pF1wle2qpodY6todKJWAox1jbGZMDc
         1mS5KL+5snp0NQLbCW2r2QE8IlVeYPJaZjW1ERGFUvLYtkL27mfnRyrLup3nkd0mt+wt
         LwqNgRpp2R0IhqPYFLzY9qzty+KljSd8m7AfkiMLLuayX0jtnP7Ajkt+q3swucU2jMlT
         SWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nFYikEZQyy7dcuLpIYSHTQjryLYDTf8L+QZXU1RkIA=;
        b=GcL1h5imv3wYrKMolpJE38Fi7cdXKbwON9uKJcZC83EM3+XczZpa+fHxmqhRYMuKFS
         wdNJ78PjGzIr8mRHaCUKnO55g3r+SGfsEmlu3xQvxdD+r7zGI7QDka9UQ7fz7POoMUhk
         spC8kxcosAE9D+GqUuDkBWdPfGX+UVi+eusvdNSA4M9hzaX4uAj+1SkMSvl3BFSx/hpW
         BVKI4j+DMWN52KJPmjD+eVzvNU8Z7MAFEYS92pmosXng5/xJ0ief5DpkyVz099vNJ1Cd
         W9xAcaT3VnyL1cA0UdZ/loMwAJg+hQZWHZ8jqsk+p/sR1qOf1Yh1AHpnxWHGo5CW0RH9
         bSzQ==
X-Gm-Message-State: AOAM530VoONla89ARzuleeu7AgULBBee77Bz1k6ay4QCIkbdMD+Vkryo
        PSvs5U+aSPDeAVkO4IkwoY0=
X-Google-Smtp-Source: ABdhPJzhBZAqXGSKoy4zcGJmq9W2gGQRovFlV7OvqS6GK/RC/Izv4TSuHzZiMmJRTLN7tbg+0Ouhkw==
X-Received: by 2002:a17:906:fb0f:b0:715:7e23:bbbc with SMTP id lz15-20020a170906fb0f00b007157e23bbbcmr3762937ejb.373.1655204841530;
        Tue, 14 Jun 2022 04:07:21 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id cb2-20020a0564020b6200b00433b5f22864sm6867456edb.20.2022.06.14.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:07:21 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 1/5] PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
Date:   Tue, 14 Jun 2022 13:06:57 +0200
Message-Id: <20220614110701.31240-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614110701.31240-1-ansuelsmth@gmail.com>
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
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
 drivers/devfreq/governor_passive.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 72c67979ebe1..0188c32f5198 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -222,8 +222,8 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 {
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
-	struct devfreq_cpu_data *parent_cpu_data;
-	int cpu, ret = 0;
+	struct devfreq_cpu_data *parent_cpu_data, *tmp;
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
+	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
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

