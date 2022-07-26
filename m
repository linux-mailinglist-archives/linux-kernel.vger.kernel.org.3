Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378C75818AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiGZRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiGZRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:39:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754B2ED6F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so1090344pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJDgGsVp/9ym8bVCX4DEK3+iI9mT2ogd+Xryi1JgPAI=;
        b=Kh87AJklhSGHbjnLYi6JWYNUx2pSx4cl7szgvn8ecj57yYy/kDlcZRplDlDfTYEQeD
         VeOBmELL2x+VZtbXQl1HJsHWW97OevB9j0uYetTvCvznTRNUGnVpz+YsDZxMKMRKUS7b
         Ol1oRoWylsF/kXc/l31Y5qUVh9tgo5947EuPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJDgGsVp/9ym8bVCX4DEK3+iI9mT2ogd+Xryi1JgPAI=;
        b=LUDQ/iRABfx8ofFH+d7QjcPCY/C1eM9JXFTwpf3QBgL8UU5k0IC3aLqCh7kGYOLQnL
         lZa0Rzhj3vkvEZyqJzttEsl/Ekam3Z7F/izs1MUXYxxi/UFrmPVmUBpPGUIZ/u5EjOfr
         09pgDictM7jmNWjre48DlSgSIqydko5Yqbcv8KHYxDLTzMdXEJo6qPU7NBUks8gv1OU4
         Xr2SNpCsXyekIxnt9roDLx6TkcV1Hulzf/BBi48fFt6Kj3l+NvWgUj2Tf2Wb2JYZ1Abu
         3QlIA+1QbraqJdqDmApCDgNRrkSppBcAI0jcdFAGHqwgZZgB0AwlQW/HG+JuauvzY96B
         o2cA==
X-Gm-Message-State: AJIora+vW2LAy/Fh3CM4BEzuR87jCesqH2d5ndGQ8jaSuPeADJzo8qP9
        WSV8Xl/Z4LIG2SM/eFyCjLXgAQ==
X-Google-Smtp-Source: AGRyM1tK5CVcyHdW+12ue/Q8sK3OVVAYgnuYyRdNJt8CWfhB2C2YLXNxFl4ZmN8vVRUHRpLhGnvE/w==
X-Received: by 2002:a17:902:d581:b0:16b:e6b8:4080 with SMTP id k1-20020a170902d58100b0016be6b84080mr17779542plh.146.1658857130908;
        Tue, 26 Jul 2022 10:38:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8693:e9aa:75c0:5134])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b0016d9ecd71f4sm245884plb.77.2022.07.26.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:38:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
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
Subject: [PATCH v2 5/7] drm/msm/dsi: Use the new regulator bulk feature to specify the load
Date:   Tue, 26 Jul 2022 10:38:22 -0700
Message-Id: <20220726103631.v2.5.I7b3c72949883846badb073cfeae985c55239da1d@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220726173824.1166873-1-dianders@chromium.org>
References: <20220726173824.1166873-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of the patch ("regulator: core: Allow specifying an initial load w/
the bulk API") we can now specify the initial load in the bulk data
rather than having to manually call regulator_set_load() on each
regulator. Let's use it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Use the new regulator bulk feature to specify the load") new for v2.

 drivers/gpu/drm/msm/dsi/dsi_host.c    | 13 +++----------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 13 +++----------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 04265ad2fbef..dec7a94cf819 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -279,8 +279,10 @@ static int dsi_regulator_init(struct msm_dsi_host *msm_host)
 	int num = msm_host->cfg_hnd->cfg->reg_cfg.num;
 	int i, ret;
 
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
 		s[i].supply = regs[i].name;
+		s[i].init_load_uA = regs[i].enable_load;
+	}
 
 	ret = devm_regulator_bulk_get(&msm_host->pdev->dev, num, s);
 	if (ret < 0) {
@@ -289,15 +291,6 @@ static int dsi_regulator_init(struct msm_dsi_host *msm_host)
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
index 330c0c4e7f9d..f42ff57861da 100644
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
2.37.1.359.gd136c6c3e2-goog

