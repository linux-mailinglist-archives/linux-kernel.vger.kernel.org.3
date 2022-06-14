Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5D54AF05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356116AbiFNLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354637AbiFNLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:07:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457CF1DD;
        Tue, 14 Jun 2022 04:07:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 25so11065796edw.8;
        Tue, 14 Jun 2022 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VpymEQ2SM4sdFNjN8CXfMk2cob9z6e+G7rfp2XXs6Y=;
        b=g80KvKkijMyNFribSNfDp/tQz40YkJoztJe2wI3n8bEln512a8vq3onke9yY0WShbP
         PhXkoeXhiBeQlY6kQ/HZCunsBvi3vAFScpzfrSkQzIw7u1afCQqei1RywDwzyEZkz9gi
         B3cDLtPC6zzUf7fuJkWcnBIpSqafmXBdiFrtVhiSkaA/zCmEq/AWiNGN9Pw89e0sBRR+
         jHS/alOGQHkDw6hTxRhNz9w6Wcf7GxwE66kBxtvxewV4k2T2Cq7DGKfvb4vTCfN711ez
         RrQXZ5jjFMru5m2LAFaCNqHn2WJPFSSfIpjU9Z3ZvLysIQD1Oxc6YI10tsQCnqU63lxy
         U1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VpymEQ2SM4sdFNjN8CXfMk2cob9z6e+G7rfp2XXs6Y=;
        b=HqzSN9zuVMm/KFYpqCxLDLPOgLLWHC+IXcFhGwIi3uTMOMf3DkoTtS4amwm8m0Zgyl
         a4luuy1JAHJ7vENyzRLejnsf3fJE/u2RD6p+GXdn0yS8fr7YM+lsiRWZRIlwu2ZP32e5
         zudqIjI09bwQvLPNtX6y8V3vAvyr4uXqD4KIUGnw2oeGZ5XtmeUULZVEH51YgoPaRc6K
         6unRM+oavI1S98ne3oXXzAPMBExUq+luRxHnX2LLrspi0VbYTmQx9jf6Ue1f38jLFIxF
         Rw8LDhre8DiuPxbKNFfJ4FsMzQs8ArrmXjmXEf30vvTk9wC8gbJ51vjDGKuJ6IcwAkMg
         Uj9A==
X-Gm-Message-State: AOAM530PTdjvEo2JhTlZhoc020pc8MAQGhEaoctK1du6iX1XZDKfq1sH
        hqZnyUxU00XJOmmwPejGTwQ=
X-Google-Smtp-Source: ABdhPJxsT+N/LKmek9PUQmIhbgUYTJBYSR+4rnrZPzzWsTxxbw2G2mwupPxhF4Xg1v0lIweCY5q0zA==
X-Received: by 2002:a05:6402:908:b0:434:f9d9:3b18 with SMTP id g8-20020a056402090800b00434f9d93b18mr5351491edz.37.1655204842728;
        Tue, 14 Jun 2022 04:07:22 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id cb2-20020a0564020b6200b00433b5f22864sm6867456edb.20.2022.06.14.04.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:07:22 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 2/5] PM / devfreq: Fix kernel warning with cpufreq passive register fail
Date:   Tue, 14 Jun 2022 13:06:58 +0200
Message-Id: <20220614110701.31240-3-ansuelsmth@gmail.com>
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

When the cpufreq passive register path from the passive governor fails,
the cpufreq_passive_unregister is called and a kernel WARNING is always
reported.
This is caused by the fact that the devfreq driver already call the
governor unregister with the GOV_STOP, for this reason the second
cpufreq_passive_unregister always return error and a WARN is printed
from the WARN_ON function.
Remove the unregister call from the error handling of the cpufreq register
notifier as it's fundamentally wrong and already handled by the devfreq
core code.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/governor_passive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 0188c32f5198..3c3322adea03 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -325,7 +325,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 err_put_policy:
 	cpufreq_cpu_put(policy);
 err:
-	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 
 	return ret;
 }
-- 
2.36.1

