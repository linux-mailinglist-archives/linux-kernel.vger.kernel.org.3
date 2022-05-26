Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4D534E79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbiEZLpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbiEZLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C2D0299
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so1463938pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mf/PBhXudWeikzmFArA4THf+WTmY69KBHxrOKvhpwhE=;
        b=JJrDny96JbGaIUMj4x/xpDMp+oQkXSZkQxSJGDuiTpnzlerMBuCp6OEPjlDrZjuPGT
         Ko/TRfplkx+duYaqEwQlc0npS3jyDJoPUUj95Jj7S1x78QZlaZpnETowzov1T7FLNHKU
         WwhZ5zjbbr6Y21jmTQLTrFTh3LFNLxfdnUmOgs8YH+knP5vuy3iYUy+BqPnqIgXEJgQF
         6MlBwSUd/twgwhmgeO4ve2f17aHiDTqmPYpNpwHO8HQ5mZCaJ6iDUFUENAp/dQOh8H7d
         XjUQRyeQoBQTh7b7PW0XCab62PJdTIzFONf+GOV+J2n7JXOk0ovYgBxDCyJ7plc4qzKt
         +rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mf/PBhXudWeikzmFArA4THf+WTmY69KBHxrOKvhpwhE=;
        b=vJZlWvDGeUlhj6vdrv87aqS1GK6MZ6eWXWQ+RJ769XArRUDPfB6q3OuYK20zjsYbF5
         VCirddO8ZU4RjjWXlRt+zc7pb3dBQ4L8/z9akPPlG0RwBfw70ubZWBXu8RfcClSNtDHS
         1o6uhix++aHLEJv2/CudnxbMW/792iCGvNwl2fxIS3HEOgDZtwydffxH9kebQ2iBlcP4
         AZbcV6wfZ7COtnCOtjS9IIPMfD8RVQRiQtJdm7/WZeayMKqL+jDqk48Q9xCccMayMj0g
         mXx2FB4XBeZJc8C9VaNBHb+TN/O2QPB88pRM1vK57ayJfb5OkE0Pcn+WrmmpCtRTvwoO
         pvOA==
X-Gm-Message-State: AOAM530lErIZeRiBtUFtLPHdesMFFGRq1cuppRz4abrKjxRgdYTosG88
        6HZc7HVCoTALfPpHS3sPkePNmA==
X-Google-Smtp-Source: ABdhPJziKnYEnwECbcUqLKProhmiWCkQ4BTngGPQbdjiQrftLw4d0/7RPvrSr33wj3o4SRqnCdRUlQ==
X-Received: by 2002:a62:15ca:0:b0:518:2bd1:aa65 with SMTP id 193-20020a6215ca000000b005182bd1aa65mr37845386pfv.78.1653565455809;
        Thu, 26 May 2022 04:44:15 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id j17-20020a170903025100b00161b407771dsm1313142plh.48.2022.05.26.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/31] drm/tegra: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:15 +0530
Message-Id: <b2272734b4ab0063569ea033dc218d18fec6aba8.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/gpu/drm/tegra/gr3d.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index a1fd3113ea96..05c45c104e13 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -389,6 +389,10 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 	struct device_link *link;
 	unsigned int i;
 	int err;
+	struct dev_pm_opp_config config = {
+		.genpd_names = opp_genpd_names,
+		.virt_devs = &opp_virt_devs,
+	};
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
 					 "#power-domain-cells");
@@ -421,7 +425,7 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 	if (dev->pm_domain)
 		return 0;
 
-	err = devm_pm_opp_attach_genpd(dev, opp_genpd_names, &opp_virt_devs);
+	err = devm_pm_opp_set_config(dev, &config);
 	if (err)
 		return err;
 
-- 
2.31.1.272.g89b43f80a514

