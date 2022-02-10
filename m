Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3208E4B1977
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbiBJX32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:29:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiBJX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:29:27 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31A7116D;
        Thu, 10 Feb 2022 15:29:27 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h11so5640655ilq.9;
        Thu, 10 Feb 2022 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3bNm5/uTnBAzIRKqMnmZ8YYfpkxkteIvyaUY7P/5B+o=;
        b=fLgRM4uji0XMP07LvJA5cjBtqm7zXPbJEBYtQDz8uGRsGjNkvOmu1mZZGhE7PFB0h8
         7PGHiZ+HnW21lWBjG1Hp5A/io3C7i6JtUrMDThpe5y92omUL2lBUuwmbVl7bS3bU0t7o
         bZq4lw7FX7tlNYB2G04YnPLZMYUK5kOrXpdscRdaz4TtPLlDq3oaDeUrODGU15pKMaSD
         ocKLNnWjsh+fu2AZ1ivgdj8WAlWXHXIdIRLnA9L7DsQS1etO2PvLwSwJhPDSSGAXJiZV
         jG0tuxn4fxzCTULGAwmomyB/ly9laDnDKG1pIYbAduDcAzKjTa3UKRbikmrRgcduFqam
         Yaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bNm5/uTnBAzIRKqMnmZ8YYfpkxkteIvyaUY7P/5B+o=;
        b=0Bm/AANPXhtOTo4MvPfcduVvG7vNSHkhabvMkghPwmHeuiDTPX5YNFnPb/g9EHGqh2
         fjBVFl9N10jUrCgB5t38PHPm3jlztY+pehrrx1MMCAcJ2Yue6teBJn1lFTAwGdgfiipI
         PDaKcrRSlf4USIghBewlGAdUFX+c/bYcg4MfEB2XZ4vd64vxoALvA30DN/Bm/ky8F7PK
         216++5dECfxYb5FHmaa6ahJp40y5NKaUWK2UO8Sd0NYhOusX6TWdp58TcJ4m3CjRmzPK
         xhITWlYkeAg6YlFNH/1z2pgJtp6icyRW4r92IidNqwkFXgBraDUT8TXAVOEA+vfz1D0x
         FZHg==
X-Gm-Message-State: AOAM531VaDJnNz8oCOhMo8TUYCPkobIuWSAu+FAt/9Y+DhrxN1ADEHfs
        cN9sFvWFTluSzEGt95CRZiQ=
X-Google-Smtp-Source: ABdhPJxG4wLZX5EPMqNJ2GZN9s/YWLmAmUwDDdSVvbnGhVn58IPPvR5sZVSRf3Lr6OSWj7N5cae0BA==
X-Received: by 2002:a92:d64e:: with SMTP id x14mr5598201ilp.97.1644535767261;
        Thu, 10 Feb 2022 15:29:27 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id b5sm6717209ilr.0.2022.02.10.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:29:26 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 17/49] cpufreq: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:01 -0800
Message-Id: <20220210224933.379149-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

drivers/cpufreq calls cpumask_weight() to check if any bit of a given
cpumask is set. We can do it more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for SCMI cpufreq driver)
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 drivers/cpufreq/scmi-cpufreq.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 05f3d7876e44..95a0c57ab5bb 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -482,7 +482,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	qcom_get_related_cpus(index, policy->cpus);
-	if (!cpumask_weight(policy->cpus)) {
+	if (cpumask_empty(policy->cpus)) {
 		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
 		ret = -ENOENT;
 		goto error;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 1e0cd4d165f0..919fa6e3f462 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -154,7 +154,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	 * table and opp-shared.
 	 */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->opp_shared_cpus);
-	if (ret || !cpumask_weight(priv->opp_shared_cpus)) {
+	if (ret || cpumask_empty(priv->opp_shared_cpus)) {
 		/*
 		 * Either opp-table is not set or no opp-shared was found.
 		 * Use the CPU mask from SCMI to designate CPUs sharing an OPP
-- 
2.32.0

