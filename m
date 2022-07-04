Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD09565470
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiGDMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiGDMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:08:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AD2120AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c13so4659334pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hg/cFplgKXasJmWL+OFLUAPfuBDqHR87rTqNltqJyMU=;
        b=ElYiOdMFeX2LZAKxIHfhmm1VperaY/9hCjNtv0uXfVRA0MR/4Z1dW/TIwohfrdw3zC
         5yfNElWqi+ZQlyMt+gGiAvZhYKw/Qjl+f5o1xzJhRefBDuQvvdic6QE1KRHBtfZDrYq+
         kfUyRZc4DUd3bZkNdymAucZQfbpm0h1ACBK2Z5S8AhKsxqbd5eFk1viVsmsVnDlDx5eH
         4J6owN15WJFuyS3PC/E8cdgenGdfMDjDrhwo1QhKvN2Kh0IfS0hV1Q3kGYlfXl25rmpT
         tlpSI2LOACnib5AbqMi39qPjHs14KXoEln8otF+FZc4hWZTDlAWv01YhvO2Wv6wlp9wt
         zloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hg/cFplgKXasJmWL+OFLUAPfuBDqHR87rTqNltqJyMU=;
        b=FCdVIg53RFYn+AGNRaC/eQuvCeRc02SnPrvoHf1qmQy1+B9D8C0UwdpqlqgQ19Olnv
         g2SeR8F1bIjIjv6AFrNNWk4nCGmV8e+vg5XeL0Rtor0qNNes9VHg04pu2YI4HGO/RUZF
         w+V8gp4n/gG7PVjhwt+rzFHsKOCUEGKkDj8bIwQXqodVuA14/n5Sb0W6+FpYP6utt1jj
         RdzfgViL3WIeI6UY5Hqzbk2YFGZAR84VQKexRApWIDO2AKrPZjnY4FmPFZcEy2Rt/EUv
         0ueF2Mq2SLbmrGG/IYfdWiPZ5etv0De+zdeVC+Eh2oVInmXK6Mm8xEPjmldrGK1MaDZk
         lUoA==
X-Gm-Message-State: AJIora8AmaP7uhHFaD2X+PcH4KDKQn2qCcknys8HxzJbhDhW0AYnrRed
        S3JuErWSSFc/FCNpxp0saEHA4w==
X-Google-Smtp-Source: AGRyM1tmSfyZts2TP1rVRGtt0oK5UlDreVoEDBr/wzXwSWigCPZMlz1k0k1jEryIK+AZtd70GDM/Rg==
X-Received: by 2002:a17:90b:1488:b0:1ef:82bb:5f08 with SMTP id js8-20020a17090b148800b001ef82bb5f08mr8737098pjb.214.1656936516144;
        Mon, 04 Jul 2022 05:08:36 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id g189-20020a6252c6000000b0052833322760sm6584054pfb.187.2022.07.04.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 09/20] soc/tegra: Migrate to dev_pm_opp_set_config()
Date:   Mon,  4 Jul 2022 17:37:47 +0530
Message-Id: <640201fa0191b27902f92db1cbbda1c74c7befb8.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/tegra/common.c | 52 +++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 9f3fdeb1a11c..dff6d5ef4e46 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -107,36 +107,46 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 {
 	u32 hw_version;
 	int err;
-
 	/*
-	 * For some devices we don't have any OPP table in the DT, and in order
-	 * to use the same code path for all the devices, we create a dummy OPP
-	 * table for them via this call. The dummy OPP table is only capable of
-	 * doing clk_set_rate() on invocation of dev_pm_opp_set_rate() and
-	 * doesn't provide any other functionality.
+	 * The clk's connection id to set is NULL and this is a NULL terminated
+	 * array, hence two NULL entries.
 	 */
-	err = devm_pm_opp_set_clkname(dev, NULL);
-	if (err) {
-		dev_err(dev, "failed to set OPP clk: %d\n", err);
-		return err;
-	}
-
-	/* Tegra114+ doesn't support OPP yet */
-	if (!of_machine_is_compatible("nvidia,tegra20") &&
-	    !of_machine_is_compatible("nvidia,tegra30"))
-		return -ENODEV;
-
-	if (of_machine_is_compatible("nvidia,tegra20"))
+	const char *clk_names[] = { NULL, NULL };
+	struct dev_pm_opp_config config = {
+		/*
+		 * For some devices we don't have any OPP table in the DT, and
+		 * in order to use the same code path for all the devices, we
+		 * create a dummy OPP table for them via this. The dummy OPP
+		 * table is only capable of doing clk_set_rate() on invocation
+		 * of dev_pm_opp_set_rate() and doesn't provide any other
+		 * functionality.
+		 */
+		.clk_names = clk_names,
+	};
+
+	if (of_machine_is_compatible("nvidia,tegra20")) {
 		hw_version = BIT(tegra_sku_info.soc_process_id);
-	else
+		config.supported_hw = &hw_version;
+		config.supported_hw_count = 1;
+	} else if (of_machine_is_compatible("nvidia,tegra30")) {
 		hw_version = BIT(tegra_sku_info.soc_speedo_id);
+		config.supported_hw = &hw_version;
+		config.supported_hw_count = 1;
+	}
 
-	err = devm_pm_opp_set_supported_hw(dev, &hw_version, 1);
+	err = devm_pm_opp_set_config(dev, &config);
 	if (err) {
-		dev_err(dev, "failed to set OPP supported HW: %d\n", err);
+		dev_err(dev, "failed to set OPP config: %d\n", err);
 		return err;
 	}
 
+	/*
+	 * Tegra114+ doesn't support OPP yet, return early for non tegra20/30
+	 * case.
+	 */
+	if (!config.supported_hw)
+		return -ENODEV;
+
 	/*
 	 * Older device-trees have an empty OPP table, we will get
 	 * -ENODEV from devm_pm_opp_of_add_table() in this case.
-- 
2.31.1.272.g89b43f80a514

