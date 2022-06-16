Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0254ED7F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiFPWpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379093AbiFPWpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:45:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579862137
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:45:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h192so2502007pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rIHyY5SxSb2FOEGYQX1ETJiFgmUNoHIHxQ/cELBswI=;
        b=FlsouGWLGC3MFtPgQ0HWnEqv0JPLdUOiz5fv2YFFv7Dd5JozgHAlaIvj0r/RdbWZHU
         2z2HH8WRKW8ADq1MLwklZ0u7dRhRGikiwvoPRfMbU2Jw9dMkcDj4s9KKWjLbr3aKIA1+
         8k6GUwrH2U6gEnUs026eIfpWn/YkPMtYHjL1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rIHyY5SxSb2FOEGYQX1ETJiFgmUNoHIHxQ/cELBswI=;
        b=Pj/pm2xtlqS6KvexCSKfwXOPgHCPD+dHhJzPZ6ltfTfX1IbRw7CE4ep2rYw1up0wLA
         E5+Qsj9SFzoL0OcMKx8ivzCjLkasikTD3g9U02pfxY7Dd6tfyNdVWsLdAqgfS+CFaSRu
         CPn+D/8SwG3etJGVtlfOd5KqYyT+WDYNnR5EKK+VQH264e+qoPlvWTU10QG/lQNYP5jy
         G2QLLhIhkJwwfrivxF6e7WynlLF2PjZNWOMHR1tsdKVHqHAylpedkT/fJHBzLa2JwwwY
         syVOalQzbV/g7m2kSFmtlAMryx1M4ubWUKwzjD/zKqDhrGDxE5ox2cBbks1N9ZNoiPWn
         jAig==
X-Gm-Message-State: AJIora93G/n+CRoUw/it7zVok9mvrfAErhmUyomFv7piFKSLPyYfVFny
        WMBdOje56hYXY1gU5ZpGBaPyEg==
X-Google-Smtp-Source: AGRyM1uzMcJ25MOB23C3xewgZXgnnulxmYSgh+k9u1IoDbuKbXcPmwuRojXr67JGauBHsTkEvinyag==
X-Received: by 2002:a63:114:0:b0:3fd:431a:dd77 with SMTP id 20-20020a630114000000b003fd431add77mr6461353pgb.619.1655419533368;
        Thu, 16 Jun 2022 15:45:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:410d:c2b8:35ee:6d9c])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b00163f183ab76sm2111942pla.152.2022.06.16.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 15:45:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] cpufreq: qcom-hw: Don't do lmh things without a throttle interrupt
Date:   Thu, 16 Jun 2022 15:45:31 -0700
Message-Id: <20220616224531.3139080-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offlining cpu6 and cpu7 and then onlining cpu6 hangs on
sc7180-trogdor-lazor because the throttle interrupt doesn't exist.
Similarly, things go sideways when suspend/resume runs. That's because
the qcom_cpufreq_hw_cpu_online() and qcom_cpufreq_hw_lmh_exit()
functions are calling genirq APIs with an interrupt value of '-6', i.e.
-ENXIO, and that isn't good.

Check the value of the throttle interrupt like we already do in other
functions in this file and bail out early from lmh code to fix the hang.

Reported-by: Rob Clark <robdclark@chromium.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: a1eb080a0447 ("cpufreq: qcom-hw: provide online/offline operations")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0253731d6d25..36c79580fba2 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -442,6 +442,9 @@ static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
 	struct platform_device *pdev = cpufreq_get_driver_data();
 	int ret;
 
+	if (data->throttle_irq <= 0)
+		return 0;
+
 	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
@@ -469,6 +472,9 @@ static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
 
 static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 {
+	if (data->throttle_irq <= 0)
+		return;
+
 	free_irq(data->throttle_irq, data);
 }
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
https://chromeos.dev

