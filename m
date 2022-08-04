Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6057589DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiHDOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiHDOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:39:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91774E846
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:39:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w14so34995plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TIL4a15Tear7wqoyrS0QJFyJN6mV7W482wt1Z99mhWE=;
        b=ifuF0R5Bm5ESJe+THOczxbs9o+TODhu42iDzd7OZtQ+eADUwBlb4PID/+60b15Tnde
         8sygYfuzlbi0T9PjGKep+CG1vcBq8VPN+hj7yfUeeJgEx5Y8zdMsb7QMUSwGYfigJ9cd
         zoOjLxet1NYfx/YPF3PwEv0hk31xJpYQFVJD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TIL4a15Tear7wqoyrS0QJFyJN6mV7W482wt1Z99mhWE=;
        b=730h/V1faC+CMjGYEAgTwf/r5h0YqjLkH88bf/KyRbxFdU3rkMzgtrVzcpX8Cf+445
         BplsoD1x/T/k6vfyyh7gq6W1rKe8NWEV+QNMyfB3V/6W4cp0v1e+wRHz2PcsuApyl3lj
         thROuOcbdxKWJw/IQ9nkUDJQvaGWn1Lzp34sJWdKj/PigxS+QQr58OnZhbjzgCSbDkIe
         4ZGUIKY1LaUQnIrgjAzhjyDanasl9eaB2ARGgdTM4d5ex62umxJ0wwpoI+Y40VU5l2n/
         RW/9gnNEoeoMA7+pOzSqfdAlDUJ83DAnmlxuZ2/t2mEhpGXH3HpfZXEWS2pwYs5SRvAC
         7Mbg==
X-Gm-Message-State: ACgBeo2F71L/7ikHbyOQyIrE4adIUXSD2vwxiKTukPapyQ+pZ4vFq0Jr
        CyKUq23Z3FLBNfMv7HPmweK6UA==
X-Google-Smtp-Source: AA6agR4Dlj4ARF0GtPX1pdHejOAKxewL+VkYltn+zaqj/m3u8XwAM4OgPNOgmQgqDKQq01Dc+zhnrA==
X-Received: by 2002:a17:90b:1d8e:b0:1f5:525d:4d90 with SMTP id pf14-20020a17090b1d8e00b001f5525d4d90mr7168029pjb.126.1659623966333;
        Thu, 04 Aug 2022 07:39:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:aa71:2553:6f54:5cb1])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016a111c83cdsm1075071plk.119.2022.08.04.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 07:39:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] drm/msm/dsi: Use the new regulator bulk feature to specify the load
Date:   Thu,  4 Aug 2022 07:38:51 -0700
Message-Id: <20220804073608.v4.4.I7b3c72949883846badb073cfeae985c55239da1d@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220804143854.1544395-1-dianders@chromium.org>
References: <20220804143854.1544395-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 6eabfc018e8d ("regulator: core: Allow specifying an
initial load w/ the bulk API") we can now specify the initial load in
the bulk data rather than having to manually call regulator_set_load()
on each regulator. Let's use it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---

(no changes since v3)

Changes in v3:
- Update commit message to point at the git hash of the regulator change.

Changes in v2:
- ("Use the new regulator bulk feature to specify the load") new for v2.

 drivers/gpu/drm/msm/dsi/dsi_host.c    | 13 +++----------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 13 +++----------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 9df278d39559..a0a1b6d61d05 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -260,8 +260,10 @@ static int dsi_regulator_init(struct msm_dsi_host *msm_host)
 	int num = msm_host->cfg_hnd->cfg->reg_cfg.num;
 	int i, ret;
 
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
 		s[i].supply = regs[i].name;
+		s[i].init_load_uA = regs[i].enable_load;
+	}
 
 	ret = devm_regulator_bulk_get(&msm_host->pdev->dev, num, s);
 	if (ret < 0) {
@@ -270,15 +272,6 @@ static int dsi_regulator_init(struct msm_dsi_host *msm_host)
 		return ret;
 	}
 
-	for (i = 0; i < num; i++) {
-		if (regs[i].enable_load >= 0) {
-			ret = regulator_set_load(s[i].consumer,
-						 regs[i].enable_load);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 7c105120d73e..efb6b1726cdb 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -515,8 +515,10 @@ static int dsi_phy_regulator_init(struct msm_dsi_phy *phy)
 	int num = phy->cfg->reg_cfg.num;
 	int i, ret;
 
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
 		s[i].supply = regs[i].name;
+		s[i].init_load_uA = regs[i].enable_load;
+	}
 
 	ret = devm_regulator_bulk_get(dev, num, s);
 	if (ret < 0) {
@@ -529,15 +531,6 @@ static int dsi_phy_regulator_init(struct msm_dsi_phy *phy)
 		return ret;
 	}
 
-	for (i = 0; i < num; i++) {
-		if (regs[i].enable_load >= 0) {
-			ret = regulator_set_load(s[i].consumer,
-							regs[i].enable_load);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.37.1.455.g008518b4e5-goog

