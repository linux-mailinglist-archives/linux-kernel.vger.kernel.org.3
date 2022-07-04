Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1592A56546F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiGDMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiGDMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:08:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D233120A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso3022014pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkV+K20z+SrLBFTmdhzZDzVO0y1dFuzDvpTTKeDqBqE=;
        b=i67LpLjm+RKEUcX9+AseN1xHAQF8gguDnDeVc16EdRZV3zXrM/xuJY3hhlgtLsx0ok
         T9jmkGkhFH/kfvg9VVtKDik3j4TEigCWm1J04DznjoQqilFMlH2CLx/D1otcfI23fNZl
         6Hb5WzKGYHFNTs56dwxX0HlcVuEjUw8o2fiMf13exT+gHNf4Pp5wbyVZV5uCkrr2RK2n
         D2S1r9SEC+mObAnXYmZsKRpZ0qUYrOCqXt2gwl0mLWfNIiJNPFRa09F8+GvDYBirW9O2
         sWJVYtrePJfMMCyUTCaaltaUK3NpNWLdEPdHNpiFXYDZk1HNFjRbabdRWkg/lbssqSnc
         0fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkV+K20z+SrLBFTmdhzZDzVO0y1dFuzDvpTTKeDqBqE=;
        b=6/lQD2psuR2m2giOrpC4NNOcmLXFzaDxYttPMaGUf6ZdL5f2dL4HNWRtNzv1SGiybb
         5aGrpzGBDws0lMoXQ5prU7WVbnzG3ct8xD4cyi4GzwKOOeEaVDBZv0ngBnTLuK5XQ/kS
         91ZbOh72+PScMwNBG0lIOAXt69/MBWOAv8Fc3ZRT7GBzqK11VNUcpXljHFXDRJly74X2
         3SxFyT5Lgnq+7IHWuacApzNfTw0PJQqSa1/meqqMZrCzvEp5bBdoWwIzOqyzFLsEVWcO
         AieyBkHGybzTjDgOqL2GfzY27N8nMC1cWiVBLY3soX1Rh3aYMsCW7nMyD0U+/WXL0NYl
         0siA==
X-Gm-Message-State: AJIora+pUM+3uIPVxJRLnwGiIMAA1M1uZUpxN/v+vGJBOAUJ3OPgY3D9
        baK7KHEL8/r/yszUwVm7bCRIXw==
X-Google-Smtp-Source: AGRyM1uSBj2VWwaqLWtNB6ZoVvhK4MFRceFAZjuhKW7adcehXBDxa0PbgVVv7V2mcOW2hlDSqUbQrA==
X-Received: by 2002:a17:90b:1807:b0:1ef:8aa5:1158 with SMTP id lw7-20020a17090b180700b001ef8aa51158mr4472242pjb.163.1656936513213;
        Mon, 04 Jul 2022 05:08:33 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aba1600b001ec71be4145sm12468028pjr.2.2022.07.04.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 08/20] soc/tegra: Add comment over devm_pm_opp_set_clkname()
Date:   Mon,  4 Jul 2022 17:37:46 +0530
Message-Id: <2f93b66f785b91c720aacd3cdb152fbf1e375141.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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

Explain why special handling was required here, it isn't obvious at all.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/tegra/common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 32c346b72635..9f3fdeb1a11c 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -108,6 +108,13 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	u32 hw_version;
 	int err;
 
+	/*
+	 * For some devices we don't have any OPP table in the DT, and in order
+	 * to use the same code path for all the devices, we create a dummy OPP
+	 * table for them via this call. The dummy OPP table is only capable of
+	 * doing clk_set_rate() on invocation of dev_pm_opp_set_rate() and
+	 * doesn't provide any other functionality.
+	 */
 	err = devm_pm_opp_set_clkname(dev, NULL);
 	if (err) {
 		dev_err(dev, "failed to set OPP clk: %d\n", err);
-- 
2.31.1.272.g89b43f80a514

