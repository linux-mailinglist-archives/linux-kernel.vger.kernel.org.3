Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A923D562DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiGAIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiGAIWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:22:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6881D70E63
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:21:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 23so1759693pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNEnKpORd3QNjxmd6zUBrP8J5Frzy4cYVk636zNrdD0=;
        b=NInfjvO3HxDbJt56x0UYfx+nwvC1lR93+qkcsX05NDwK5rNzTDLLw03Y/CGBpgN+0F
         42bNNL8xJYwDLGgG/Ykhb8FwLm9q44K+YQeq6yGhoul+TvAZIvJZ7fQBSlgtSReLl3hU
         UrohJgZTbFVwxMOKGPQND7n6nVnq9+w0OMtzOM42N5ghKCaZN1xZ26FNFO61XNMS8jtc
         BfouMkbIzHbqaFMUQ0VLJub2rcav1Tnbg61uO893IIz0TTAd/So5sl/RDnLNuponV8Xn
         JQls62z6q0j1+ZvbzjXnFLzpiXo9QPhYOkKiSEq1lrbPT8fdvwRte6cDj0li4Wkh9Xp4
         0V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNEnKpORd3QNjxmd6zUBrP8J5Frzy4cYVk636zNrdD0=;
        b=LVHITs7GpUyABmGRmsSOJl7FIiaXNixE43mKS/LSLHqPr7Wz6HgbJwkHLTLbNTSOE1
         hjvV0VWzWHZu6xadUaFemDC32tePUzXqHp3GG/pzNDauih8n0sp9TXhiqP3ayJ9fXMGR
         d/YIGcvV0R5EwsI/ev4uDlvXuYLE3V966qGzhSiad4SBCY/tbDE7hbZcbIJs/gITxOEk
         nJxW6R0tKktI3py+0XzLIYVGAugC93Ubs69uJpm4yQfeB9bVEoBJ8pp5QVkU4Mp21TyY
         ZZpseRU0V8cNxRxh7mOrultEe71gnK3oicuTOfI+dSK5wAmUEffeLmVqi9W6Ep35xuce
         nhzg==
X-Gm-Message-State: AJIora+IPHrpXk+rIYYcOCVzdcvID9WdRdoOE4dkwJR4iods662LT1v9
        beDBMGpeg4TGuvvK9Nr5USCoOA==
X-Google-Smtp-Source: AGRyM1uYcdqOf+57d5/HlFxYYKsxbNuIuRKJ9aqdI/aVgWcgYUkw2wQLaX4vKBZMZrBpE8TsLtScWA==
X-Received: by 2002:a05:6a00:a12:b0:527:dba9:c416 with SMTP id p18-20020a056a000a1200b00527dba9c416mr15334406pfh.33.1656663695136;
        Fri, 01 Jul 2022 01:21:35 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016a3f9e4865sm15039024plg.148.2022.07.01.01.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH V2 18/30] memory: tegra: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:13 +0530
Message-Id: <74e3e4c6f63ea155aebd1c113d99e39bc2f8fd80.1656660185.git.viresh.kumar@linaro.org>
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
 drivers/memory/tegra/tegra124-emc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 908f8d5392b2..8da6baa4c369 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1395,15 +1395,18 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
-	struct opp_table *hw_opp_table;
-	int err;
+	int opp_token, err;
+	struct dev_pm_opp_config config = {
+		.supported_hw = &hw_version,
+		.supported_hw_count = 1,
+	};
 
-	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
-	err = PTR_ERR_OR_ZERO(hw_opp_table);
-	if (err) {
-		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
+	err = dev_pm_opp_set_config(emc->dev, &config);
+	if (err < 0) {
+		dev_err(emc->dev, "failed to set OPP config: %d\n", err);
 		return err;
 	}
+	opp_token = err;
 
 	err = dev_pm_opp_of_add_table(emc->dev);
 	if (err) {
@@ -1430,7 +1433,7 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 remove_table:
 	dev_pm_opp_of_remove_table(emc->dev);
 put_hw_table:
-	dev_pm_opp_put_supported_hw(hw_opp_table);
+	dev_pm_opp_clear_config(opp_token);
 
 	return err;
 }
-- 
2.31.1.272.g89b43f80a514

