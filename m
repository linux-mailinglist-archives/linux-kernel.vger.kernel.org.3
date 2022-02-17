Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5314BACD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbiBQWm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:42:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiBQWmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:42:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA21704D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:42:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso6825378pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mmtHfGvX3QTdzLz6j/Nu6tjim8GE4bCKl/5zpm/NAQ=;
        b=BzfZpeq3rZdStoI1Wr0xcS8Cf55hQJ/D+7O5l60/MUPozDdqMR3PzVwSfYraa+nLNT
         NyD7gmG5bjFJAZvQjb+UrhHZ97vZIwQxC6do5y2+9SD9RrVdz/VEfZyfLpsRW5Svhs3y
         0aDXxqIAti6kqYHFQ6CBjV1g6soYBlxXwNrSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mmtHfGvX3QTdzLz6j/Nu6tjim8GE4bCKl/5zpm/NAQ=;
        b=b44x4GjGPRfmJ54KyFGWr08SSi5E9J17EXZ+Ux9yaHGQOnk0f3IGg/aQEnvo+6moGu
         nRmNMA7Qs3PfH3z5Mcy6VoPOq8PY24ZOKr+n7SFj8Y0z4SXiBVwENcmg7USAPwkZJtP6
         wKPBE3+E6Uazd14znQJYTH0P2bar36oAHeTDo4r9mFRw6XvhTlqoT1+T9S1o/2+RaqX5
         Z0TGj8t6DJbWjvOxNP5vIzE0wG5Z1elIzBr97UO3JL2Bg54CgOE89XRmydRBMnGR/jy2
         FDxB+tAT/jscEZqIh6y/7QI+Lw9gu07ZL7quiK+qeunFLqjydMj8t58pTA2sJUZnQ9ld
         qHig==
X-Gm-Message-State: AOAM530qacPqcUYk+5snKxQzQKW5l+sx0pDHaLWVF5gFApRL8YgyHCJ8
        5WWX8h3WqaaeqARwK5RqjAgJ2w==
X-Google-Smtp-Source: ABdhPJz3bf7M0OSxfziRldKe7HpMouFMO9Ur2/1DPJi+T1EoIE3EpMv4yzP/J7CTVuwGmI1BEieWyg==
X-Received: by 2002:a17:902:bd85:b0:14d:c29b:d534 with SMTP id q5-20020a170902bd8500b0014dc29bd534mr4651443pls.99.1645137728224;
        Thu, 17 Feb 2022 14:42:08 -0800 (PST)
Received: from localhost ([2620:15c:202:201:677e:1914:4c14:1662])
        by smtp.gmail.com with UTF8SMTPSA id 4sm574985pfh.125.2022.02.17.14.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 14:42:07 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Doug Anderson <dianders@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 2/2] drm/bridge: analogix_dp: Enable autosuspend
Date:   Thu, 17 Feb 2022 14:41:46 -0800
Message-Id: <20220217144136.v3.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220217144136.v3.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
References: <20220217144136.v3.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP AUX transactions can consist of many short operations. There's no
need to power things up/down in short intervals.

I pick an arbitrary 100ms; for the systems I'm testing (Rockchip
RK3399), runtime-PM transitions only take a few microseconds.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 - New in v3

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 16be279aed2c..d82a4ddf44e7 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1121,7 +1121,7 @@ static int analogix_dp_get_modes(struct drm_connector *connector)
 
 		pm_runtime_get_sync(dp->dev);
 		edid = drm_get_edid(connector, &dp->aux.ddc);
-		pm_runtime_put(dp->dev);
+		pm_runtime_put_autosuspend(dp->dev);
 		if (edid) {
 			drm_connector_update_edid_property(&dp->connector,
 							   edid);
@@ -1642,7 +1642,7 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
 
 	ret = analogix_dp_transfer(dp, msg);
 out:
-	pm_runtime_put(dp->dev);
+	pm_runtime_put_autosuspend(dp->dev);
 
 	return ret;
 }
@@ -1775,6 +1775,8 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 	if (ret)
 		return ret;
 
+	pm_runtime_use_autosuspend(dp->dev);
+	pm_runtime_set_autosuspend_delay(dp->dev, 100);
 	pm_runtime_enable(dp->dev);
 
 	ret = analogix_dp_create_bridge(drm_dev, dp);
-- 
2.35.1.265.g69c8d7142f-goog

