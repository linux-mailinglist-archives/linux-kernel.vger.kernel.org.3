Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9234C534E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbiEZLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347321AbiEZLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F845CFE26
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 137so1129936pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbZ69EBj+CLxahhE5rw5q494M5c4cxGAZWpQHb2IOAc=;
        b=CYrVjUIuWd0zfRIJSi8HO31AD9AB7Z/b4ZGo/R1bvdZBPaGfQHMVsp9no9MCPRLZSu
         Rx1UKPigFvdWFI3gG/HlfhuEFFhdBc8tINuYmFZ2So48AD+5LQVHGJMBlzObMv8wxjVS
         yxTShzVoWieKyQP/hK9o+Iv3sCcjl67EpSLJ4d2H1lHxljTM5NdTslfMlya8H+j/wS4D
         5jzP9DwrV/aPT9HOxUtxo26dGuXTskGfoJK1LPz5Wf7KLcG8wn5snDKw2cATPMw3anCP
         5FnfmuUON+mH1UD1VSlbTe1asCjQWGQZLQNt973KfqWmp4KKOCgcij5STXxI/EUUQ76d
         2vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbZ69EBj+CLxahhE5rw5q494M5c4cxGAZWpQHb2IOAc=;
        b=ic8fq9q7D2OJM1o+nNg0X3Es/ODRsd1mU50G70QOJh+/2ibe7RmfvoSvtD25WnTmuD
         JEymGEHuv4J5RC2lbs4xrTpVYV0hUl5cfl+Z9ZgGObgmctMNnou6Xfwh+Htqkv9hf5UE
         /AcpLGT0nRwbrFVUxDTfgD1bPkfHBjRU+Y6IU79+/ef3flcNAQfxUTkFI5o3TST21Lc5
         HF5CdeqlyfkGJE7D9I3//Fthmb4ynTP6xMnv9p9fHm/vXHqO3s9z8L7QQQM7HVkbITDZ
         Y5yzt0QmiksWpe1u9ZTR+l24taFA0kCFtENyP6bHvW9ub3/JiVSTld5IwYIYWdN5BMK+
         wYkw==
X-Gm-Message-State: AOAM530889Ufr43stNhN7XUti1cO8i+R01b2Eh5y0B5jtapaIGWlji3r
        CQHKtMjmV6FlGSNDOjSqg2x1YQ==
X-Google-Smtp-Source: ABdhPJyI36Xh7JTRb61yxLCPh2nssAdsbatU80ZBS3PRQ6y4gvF9EpP1vtaAGYqIfWJADbOhRY1hSw==
X-Received: by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP id c18-20020a056a000ad200b004f12734a3d9mr38397886pfl.61.1653565478103;
        Thu, 26 May 2022 04:44:38 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001637d72b314sm1231655pld.10.2022.05.26.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:37 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/31] spi: qcom: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:22 +0530
Message-Id: <09fde85449e0e189572ea847e86148943aff8b2e.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/spi/spi-geni-qcom.c | 5 ++++-
 drivers/spi/spi-qcom-qspi.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 4e83cc5b445d..d869f270dcca 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -892,6 +892,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *clk;
 	struct device *dev = &pdev->dev;
+	struct dev_pm_opp_config config = {
+		.clk_name = "se",
+	};
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -922,7 +925,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.base = base;
 	mas->se.clk = clk;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index c334dfec4117..5ab3ae406ef7 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -458,6 +458,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct spi_master *master;
 	struct qcom_qspi *ctrl;
+	struct dev_pm_opp_config config = {
+		.clk_name = "core",
+	};
 
 	dev = &pdev->dev;
 
@@ -529,7 +532,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->handle_err = qcom_qspi_handle_err;
 	master->auto_runtime_pm = true;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
-- 
2.31.1.272.g89b43f80a514

