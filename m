Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D51534E51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiEZLoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbiEZLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:43:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0CB4131C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so787831pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tnA5+J+gH2mj2CPHfO10MW0xEpoxi+NxT/Ss2uVLmF8=;
        b=AVIp74S5w8hFRIvL44O8yvtl+fDjhV4Adadv/8mJ+X8nnqJGEThB9Kugaum863mxh2
         h9QuOLBSkznxR24EctnKbI9qmhWgcU3DWDFidsDc2fYwO+1F5dcjE8DMFq69+MK23MOE
         A2D664nA5pvQdof/UuQ5L/JNBfmbziqu3a1t3Q+WBqadmHvmtFBW863HQtRfsx3o9iFv
         U7RJQyWAEnlH/UAcghhdjnUwN0vjoTwksBEp3VT3kxKIAylChAm5SfCvCCHZ/8+uj6fT
         3Pn2GlOIIiC/KHtC45LCPo2xysWCycP3oSH7Wy3Yo7Bn2z3W9qoyVg93iL+7FRzxvTiw
         fyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tnA5+J+gH2mj2CPHfO10MW0xEpoxi+NxT/Ss2uVLmF8=;
        b=MgaOAiSR+II2JEmKCJEQJbYS7BVNROcABEzNKaTxeUcnlIqaPmyvX0Su8NfRnA/Qe3
         6YxUvw10wkpN6bV7CAW6E7fVtW06cgHX/1aRqX4wsUQ83NX/oJg8/tmWxeyGNGMbKreM
         SGOw4rvRAQLoUCfoUvH4fNQ3oHF03X+IY9B9dpSz+OyHHbtn2Jh5OXRcxLvRf8GKPeoO
         HgnRAO4Vuy59nuYa4HTG4s7uAcNZI5gxWchA5CSqWizLbM+3HMjoAiALojLbOZqe3+1z
         nj4tIOL1qNM7szQwLidSxt7tapR634TNUnNgQcVGwV2RjCs1HBwbBkvcPsMmJ2MKgOhl
         kmfQ==
X-Gm-Message-State: AOAM532j8FR9PTtQMxXNjlLI3BOY96L1KovBCZUiMPpt+qRiuzUcnp66
        kGZyyFawVZzgHB/GjnUbfrNSmg==
X-Google-Smtp-Source: ABdhPJzRIDXg5OmHJJdS+VFy81IjKYyN226dUfeZcatLo6D42DjmKKzBNFVKfJNIlfgyTjHRouDHZw==
X-Received: by 2002:a17:90b:2c43:b0:1e1:9ff4:fd12 with SMTP id rw3-20020a17090b2c4300b001e19ff4fd12mr1736285pjb.107.1653565426930;
        Thu, 26 May 2022 04:43:46 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b0016198062800sm1374400plg.161.2022.05.26.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/31] cpufreq: sun50i: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:06 +0530
Message-Id: <32db8386ad53c0d0b71c5afba18273e90072c081.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 2deed8d8773f..c1bee39758e2 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -104,6 +104,9 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
 
 	for_each_possible_cpu(cpu) {
+		struct dev_pm_opp_config config = {
+			.prop_name = name,
+		};
 		struct device *cpu_dev = get_cpu_device(cpu);
 
 		if (!cpu_dev) {
@@ -111,10 +114,10 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 			goto free_opp;
 		}
 
-		opp_tables[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
+		opp_tables[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
 		if (IS_ERR(opp_tables[cpu])) {
 			ret = PTR_ERR(opp_tables[cpu]);
-			pr_err("Failed to set prop name\n");
+			pr_err("Failed to set OPP config\n");
 			goto free_opp;
 		}
 	}
@@ -133,7 +136,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	for_each_possible_cpu(cpu) {
 		if (IS_ERR_OR_NULL(opp_tables[cpu]))
 			break;
-		dev_pm_opp_put_prop_name(opp_tables[cpu]);
+		dev_pm_opp_clear_config(opp_tables[cpu]);
 	}
 	kfree(opp_tables);
 
@@ -148,7 +151,7 @@ static int sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_put_prop_name(opp_tables[cpu]);
+		dev_pm_opp_clear_config(opp_tables[cpu]);
 
 	kfree(opp_tables);
 
-- 
2.31.1.272.g89b43f80a514

