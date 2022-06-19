Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02872550D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiFSWaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFSWaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:30:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B44A447;
        Sun, 19 Jun 2022 15:30:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y19so17814274ejq.6;
        Sun, 19 Jun 2022 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8D8HPXSeJ7Wq8gI4AgA5yZmGmYBQ/tmS39eh3e7yPls=;
        b=kXAJ/WguNOLHDfnTYFC9KJYpyWYve+QFQKUcY+C6EM++81doOJV6QAG/AfuUNMPyKv
         +QcP0NJU0jSH572Da7tsrEAdAjEuurDCdJ0HPe3UMcxIu4+FVrP3bx6rwtA8Zzh3uGvr
         rF/Utq4mQqBod2Faw+0eDbYwvfq9lg+PAnpf/f17B+1GT/ztVJsEPHBDRkPHQHOzK6j/
         f9gFmXepkgfw+fBxAfen4j8g+UXNo41bFTcpPkRC+eWLHVCuh5b6guJ4qOYuKy70gQgN
         AM6UcvYqwM0mL6nVuSKT7ZAzMzNUswg/ytqXvdn8gCUIhMAv8WbtXfWX9UcIc7Qk2+Jn
         lCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8D8HPXSeJ7Wq8gI4AgA5yZmGmYBQ/tmS39eh3e7yPls=;
        b=YLr8eM4j+HX+VXwcGm02ZSHWvesLQnvdPX2LIB9A5mtUNvaFvvZisQw8xgzWkmVuHQ
         TfAuwWBO3ih9VRnI6gs5hi/6hk1hJmWDjFl+vlJmWePWR8Rei8pYzMu32r8bAN/3ISRC
         Nzc0m+cUhFZPCDFMOqM9g+i8/rSSyNWhAuR+iADL5QzTy7uPVIf1ixUTijg4l43/wATM
         7wsnnJgivWwRfaj85e9br5bwOayjmLWvbiOwrfN0MqACj9pdG883qb8q5jf7RNdkwifB
         IcC3E3PsQ9rN3mtmhOnr1SOBprEZ7IaDNGIlLat6dHH10N/cgt0mF3KRkeK8Jql98ffo
         p7Gg==
X-Gm-Message-State: AJIora9EiMND9Ww0zh1yGQt86XYvBskOUR5ah4M4ErBVfA3/fgXBFDxv
        li6nmCTviDCtb27S+mGC7MUIKNvwN3Q=
X-Google-Smtp-Source: AGRyM1s6lmelPXylVYiDfXc5wEtncueTziFanYQ7JyYf0PbybUGktOBcwFoz5Eo9e6Gx47tkOVLVaA==
X-Received: by 2002:a17:907:a40f:b0:71c:3ffc:530a with SMTP id sg15-20020a170907a40f00b0071c3ffc530amr16124989ejc.672.1655677799309;
        Sun, 19 Jun 2022 15:29:59 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id x2-20020a05640225c200b0043559d9e8b9sm7200083edb.53.2022.06.19.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 15:29:58 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] PM / devfreq: Fix kernel warning with cpufreq passive register fail
Date:   Mon, 20 Jun 2022 00:29:39 +0200
Message-Id: <20220619222939.32029-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Remove cpufreq_passive_unregister_notifier from
cpufreq_passive_register_notifier in case of error as devfreq core
already call unregister on GOV_START fail.

This fix the kernel always printing a WARN on governor PROBE_DEFER as
cpufreq_passive_unregister_notifier is called two times and return
error on the second call as the cpufreq is already unregistered.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/governor_passive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 72c67979ebe1..8055801cf182 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -336,7 +336,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 err_put_policy:
 	cpufreq_cpu_put(policy);
 err:
-	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 
 	return ret;
 }
-- 
2.36.1

