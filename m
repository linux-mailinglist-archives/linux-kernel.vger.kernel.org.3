Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A9565A61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiGDPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiGDPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:52:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318B5585
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:52:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s21so5182839pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sRl2t1rvyRttEeKDRjtLGVtQ9G7VQBGwaD5cR1+2zVc=;
        b=OWKeLJydETTHHzSeYEolojpSDDynSbdRGgZm+mwRATvXzsZHkOvQyJvG5dYMEGhHFU
         y6om+6LA9NOz7PBv6WJuL0+3CGBn/7lsiqmoVu47CFHPb+Sjw3invk2dczk8ks80fLRR
         x3MKnYuYYZGB5G553t9jZfszkYAA7RPLHEyy3jtqkuhanvuRt6HY8kqSe9jgJ/pQdzSi
         tho+Xtw+mcp+/DADlPU+yaMqr2YltubKFj+BtqX0uLgnv5VDw1jxAc0gAvqdJZ0Py4u0
         mpQCusU/77yjDkKmo5zO194I0MxPBNwVZsn+fGKW1ipn51skzJ2KRejOhBdp6wKpaS0k
         lWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sRl2t1rvyRttEeKDRjtLGVtQ9G7VQBGwaD5cR1+2zVc=;
        b=fWSQKbSa4XEfO2usCp+msSb6R18smJ4xtNyulvQVpY2bgiGV/2a6oqA3BT2QDIRmXw
         sZKlr9tDhy2XnX7eHNV8r5vi6/NROyPJaW2SuU2OF5btLTA/W6p8Y3BKiUsRSoaPLdnv
         PswW/V04f2ybWVaE7alG1fDKgN8vf2LvKiWa2GJFTQ6Pvb+NzzJnffsayTE6NJHoWe8g
         vuOPrwV6T0Ma07lnXWjGB3hYRwzHw+9370s/T/p0WGiRkAi7RiE4H+hHXCrWgcgRKmlo
         KNpO0Qj9XG9bi480kxq22rIp+Y4qBQnWi69ML8RSakR5sozZDjlwU9a+E1Dh5JiiK3o1
         weuA==
X-Gm-Message-State: AJIora+Yq4QC06FR9+f+PhW1mM41oOFVmQfGbBw1ZIvqKj5e0YeGYKcr
        tgy5pt/4lg7vN2rCd9V0mhdjiA==
X-Google-Smtp-Source: AGRyM1udrllayvfg/+/oNvT3GBTgY3hCV6AUGqvJ+UTbijLSpRL5ts+FK9A7Qg9ItLWQubsj3FVXyw==
X-Received: by 2002:a17:902:9b8b:b0:16a:14fa:cd27 with SMTP id y11-20020a1709029b8b00b0016a14facd27mr37368228plp.86.1656949947517;
        Mon, 04 Jul 2022 08:52:27 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902d34a00b0016be0571ef8sm2922134plk.143.2022.07.04.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:52:26 -0700 (PDT)
Date:   Mon, 4 Jul 2022 21:22:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220704155225.n4kmgwnvsuksbo2p@vireshk-i7>
References: <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
 <40e616eb-22f9-19c2-8d77-20cd3c7c518b@nvidia.com>
 <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
 <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
 <8367c38b-8cd3-cde1-5833-874769ef3350@collabora.com>
 <20220630095245.otvo53ezd4avoujw@vireshk-i7>
 <b899ff5f-b424-5f44-7c94-deb013ff6bbc@collabora.com>
 <20220630101540.5dafkegrmcattt2c@vireshk-i7>
 <20220704120915.s3ermueulcofg7nj@vireshk-i7>
 <58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-22, 16:17, Dmitry Osipenko wrote:
> Actually the freq was 0 and it was 1 on the next loop like you suggested.
> 
> Previously, the _read_opp_key() was always reading the opp-hz. Now it
> skips reading the rates in _read_rate() because opp_table->clk_count=0
> for the tegra30-devfreq driver the uses devm_pm_opp_of_add_table_noclk().

This is exactly what I wrote in an earlier email :)

Anyway, I have pushed two patches on top of my opp/linux-next branch
and they should fix it in a good way now I suppose. Can you please
give that a try.

This is how the diff looks like:

PM / devfreq: tegra30: Register config_clks helper

There is a corner case with Tegra30, where we want to skip clk
configuration via dev_pm_opp_set_opp(), but still want the OPP core to
read the "opp-hz" property so we can find the right OPP via freq finding
helpers.

The OPP core provides support for the platforms to provide config_clks
helpers now, lets use them instead of devm_pm_opp_of_add_table_noclk()
to achieve the same result, as the OPP core won't parse the DT's
"opp-hz" property if the clock isn't provided.

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 65ecf17a36f4..0e0a4058f45c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -821,6 +821,15 @@ static int devm_tegra_devfreq_init_hw(struct device *dev,
 	return err;
 }
 
+static int tegra_devfreq_config_clks_nop(struct device *dev,
+					 struct opp_table *opp_table,
+					 struct dev_pm_opp *opp, void *data,
+					 bool scaling_down)
+{
+	/* We want to skip clk configuration via dev_pm_opp_set_opp() */
+	return 0;
+}
+
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
@@ -830,6 +839,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	unsigned int i;
 	long rate;
 	int err;
+	const char *clk_names[] = { "actmon", NULL };
+	struct dev_pm_opp_config config = {
+		.supported_hw = &hw_version,
+		.supported_hw_count = 1,
+		.clk_names = clk_names,
+		.config_clks = tegra_devfreq_config_clks_nop,
+	};
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
@@ -874,13 +890,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_pm_opp_set_supported_hw(&pdev->dev, &hw_version, 1);
+	err = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
+		dev_err(&pdev->dev, "Failed to set OPP config: %d\n", err);
 		return err;
 	}
 
-	err = devm_pm_opp_of_add_table_noclk(&pdev->dev, 0);
+	err = devm_pm_opp_of_add_table_indexed(&pdev->dev, 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
 		return err;
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 94c19e9b8cbf..03283ada3341 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2142,7 +2142,7 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 		count = 1;
 
 	/* Fail early for invalid configurations */
-	if (!count || (config_clks && count == 1) || (!config_clks && count > 1))
+	if (!count || (!config_clks && count > 1))
 		return -EINVAL;
 
 	/* Another CPU that shares the OPP table has set the clkname ? */
@@ -2168,10 +2168,12 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 	}
 
 	opp_table->clk_count = count;
+	opp_table->config_clks = config_clks;
 
 	/* Set generic single clk set here */
 	if (count == 1) {
-		opp_table->config_clks = _opp_config_clk_single;
+		if (!opp_table->config_clks)
+			opp_table->config_clks = _opp_config_clk_single;
 
 		/*
 		 * We could have just dropped the "clk" field and used "clks"
@@ -2186,8 +2188,6 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 		 * too.
 		 */
 		opp_table->clk = opp_table->clks[0];
-	} else {
-		opp_table->config_clks = config_clks;
 	}
 
 	return 0;
