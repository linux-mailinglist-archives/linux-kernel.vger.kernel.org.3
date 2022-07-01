Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B9562DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiGAIVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiGAIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:21:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABEB70E43
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:20:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x138so1789355pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5sBbegLJ1lchy2hqalQ5gJ7BZ0uunI8SG7qvUv41a9Y=;
        b=LtIggMzGQOAaeuUsH5+tfhe8ltdiSJAT7ASyNnbMKUFwg5LRGyfiXxcle/SSV3NIfW
         GQx6G+M3HwU+tGz8WVhrwKpvnD+qxamu07mrJMSSs/0srPapAZo80RW4dEZjQcTXyHls
         K3W0fNeg6V086Ehpk8Xs3rbfyBwd0uu3rlLw41Cb9Do8OTDOOUrFx0l7MGq9ATh1GCEe
         cksw4Ni/rTwjaO7EyJIu6wLnrCu75x0oloKisDodgwtR/wlb9pyibOWZ8qFCsM1WWV+s
         P7zuR7ZQLb9ZlwxBaYaLz4eDRX5qaMGQ5zSwoNL2Cw8PjF/0Bchum01YJKqkzUAyKtm9
         H90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sBbegLJ1lchy2hqalQ5gJ7BZ0uunI8SG7qvUv41a9Y=;
        b=l5d1hNppgsIcbU46BtaGa3oQjb26qzBdW29W9tfs602YiTS/+Tp+O/8qzPWcKJJzne
         G2+zZ+xaRCLS4BVqMY8qlOUaCpUcBtG0hiQj4o/TuJp8K8vlXTGbcfCfwTuEsANSkPUc
         NIMV3fIIEWjHwh9iYV8o+4bRiq43ucW92tQiXWq/1Ix1IvtBgQaPHw1uKqQXNEMEYkWB
         okPfsz2EGQJRbnOtUsWmRHQ96a01hkX6ZkVcTqC6VryxJaCtGyXjcSj1xsZBVShOecys
         riw5IwUo7ypAo1pSWamf/k4hM0NcrNDSYYrNPXe353pMdgtarZ8UO8OD1wvlV7kpfAUh
         BOug==
X-Gm-Message-State: AJIora9+QEV/h3+EJdMld3Br6fQqP1S+ZietxUmB//ncnNXeV08EgGnY
        upXvFXq69uCLIB6cAQY9dfTHAw==
X-Google-Smtp-Source: AGRyM1uu8zggOPnDHNiBGQHOAPYQblLb5K23eAAtyPxBWbytzSoamd5/4G+YcLRQ/dpteT5fpwljKw==
X-Received: by 2002:a63:455b:0:b0:411:bf36:f56e with SMTP id u27-20020a63455b000000b00411bf36f56emr4288740pgk.105.1656663653143;
        Fri, 01 Jul 2022 01:20:53 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id cm24-20020a17090afa1800b001ec87220fb9sm5938601pjb.16.2022.07.01.01.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:20:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/30] cpufreq: dt: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:49:58 +0530
Message-Id: <c90a2155c25803f23e8b79a69188c3fb6117607b.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8fcaba541539..9e25bf86e512 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -29,8 +29,8 @@ struct private_data {
 
 	cpumask_var_t cpus;
 	struct device *cpu_dev;
-	struct opp_table *opp_table;
 	struct cpufreq_frequency_table *freq_table;
+	int opp_token;
 	bool have_static_opps;
 };
 
@@ -220,12 +220,16 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	 */
 	reg_name = find_supply_name(cpu_dev);
 	if (reg_name) {
-		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, &reg_name,
-							    1);
-		if (IS_ERR(priv->opp_table)) {
-			ret = PTR_ERR(priv->opp_table);
+		struct dev_pm_opp_config config = {
+			.regulator_names = &reg_name,
+			.regulator_count = 1,
+		};
+
+		priv->opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+		if (priv->opp_token < 0) {
+			ret = priv->opp_token;
 			if (ret != -EPROBE_DEFER)
-				dev_err(cpu_dev, "failed to set regulators: %d\n",
+				dev_err(cpu_dev, "failed to set OPP config: %d\n",
 					ret);
 			goto free_cpumask;
 		}
@@ -295,7 +299,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 out:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-	dev_pm_opp_put_regulators(priv->opp_table);
+	dev_pm_opp_clear_config(priv->opp_token);
 free_cpumask:
 	free_cpumask_var(priv->cpus);
 	return ret;
@@ -309,7 +313,7 @@ static void dt_cpufreq_release(void)
 		dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
 		if (priv->have_static_opps)
 			dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-		dev_pm_opp_put_regulators(priv->opp_table);
+		dev_pm_opp_clear_config(priv->opp_token);
 		free_cpumask_var(priv->cpus);
 		list_del(&priv->node);
 	}
-- 
2.31.1.272.g89b43f80a514

