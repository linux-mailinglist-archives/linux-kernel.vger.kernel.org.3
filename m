Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0208758845F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiHBWiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiHBWh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:37:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747972A243
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:37:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so146683pjn.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=m27JGOowCd4CHMBuXr6we9nLLOaaXmb6CU0SMlJjk1E=;
        b=nr4YVt6smhF5lM8TlW5lwPq7KyfS/C26YPxmmu2Zc6EZoZdUzZvl91INVJSUWdzxrJ
         8E92ORrByaq4PXG+1DZ/rK9hKKiA5dibBEeXVcKQUApeyKTltdEp/DQRHmXi2PhNDScy
         zh/7ZisrWQ+I0wLK62Y8uWWFBrR7gqkwXgraU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=m27JGOowCd4CHMBuXr6we9nLLOaaXmb6CU0SMlJjk1E=;
        b=mXTFyln7jyg1Upy+6/cZUfrhdztrRzcEPkHjNW+N/okqepg+Dxgc/9TE1jftsB6zbN
         yf1gBzDtqjuzT19qZLd/IliNt62D7B4FTprcPGnX5TvQpzzBpJkLCE7bolv5kQ3IVq/8
         E74vQOASdamlmkV8xPsBQfxRflDzOHl4UZsgcw0gCDtDHZ5KoT+0t9JHDiGdW/dJdkkQ
         Emj/ZK7TSBgpV7fBZHChbDeh3tUlVU6xhiepfDW3ItB2UyV+NU2uG2IUukqkokIFE+9t
         Xva6vb12Jrq3RvQI2M2yybKVyL1qibbH0/JE1ZzkWaMbxJGDiXUB/VEhM4u5XXi7jPQ8
         ugWg==
X-Gm-Message-State: ACgBeo3ZvTLL9/f15B3YGTs4iTGi7DIKERmrzNEhlkkmeZh2yOUIdSG6
        HLkiyfA7Zu5FGnaBZWXqZpS8Ag==
X-Google-Smtp-Source: AA6agR5D9D9Bbr2PRxppp0iSLjlvHwVkEEUtnwO1UdHI0WhJ+VGHyudMevUSLb4M649mJJwVSTDlTA==
X-Received: by 2002:a17:90b:240e:b0:1e0:775b:f8fc with SMTP id nr14-20020a17090b240e00b001e0775bf8fcmr1756001pjb.132.1659479875832;
        Tue, 02 Aug 2022 15:37:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:31c9:9937:c6bb:62f5])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00528c066678csm11353030pfb.72.2022.08.02.15.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:37:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] drm/msm/dsi: Use the new regulator bulk feature to specify the load
Date:   Tue,  2 Aug 2022 15:37:36 -0700
Message-Id: <20220802153434.v3.4.I7b3c72949883846badb073cfeae985c55239da1d@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220802223738.898592-1-dianders@chromium.org>
References: <20220802223738.898592-1-dianders@chromium.org>
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

As of commit 6eabfc018e8d ("regulator: core: Allow specifying an
initial load w/ the bulk API") we can now specify the initial load in
the bulk data rather than having to manually call regulator_set_load()
on each regulator. Let's use it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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

