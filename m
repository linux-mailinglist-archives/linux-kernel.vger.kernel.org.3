Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417144C9B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiCBCMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiCBCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:12:34 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01004A6507
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:11:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o23so347235pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 18:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bN6s6TEZphRwWI80xPm4aDtJet1ujkPpuwP31QhXI/4=;
        b=Gi3ddJmZGU2EBvfYqXHrtA6sMRGzkmAZ0ATThinzacPTB+38oNB9Joc0MX5AaExxvf
         MnAEUHidDLO8fgXj+3CVfa620VMN43lZ1TjqxDWvnHrFvaZpRFmiWRl7nQoeoWpbPDxw
         8498XmP5qcqTmjP9MchQOKq88Y1K1krgttZz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bN6s6TEZphRwWI80xPm4aDtJet1ujkPpuwP31QhXI/4=;
        b=6kP1eWU4xuX/VvwvMCSUocCPT4TVkUcArgvMwfV+ZyPTlEysZ9KTgLeDFZQQFKl00B
         8i23hxMhKzMRy2t4hoLXWID1pxW3cq+yI+RrsN7hPsUscDi7NS1KxHsWh9kGSpsyqjCB
         8KVlN9x9x6u61WkH92X34LN/rmlvXzIRcrptpEg2WvsVo9zY1BVNhR2B88y+fA2Un52G
         SnCVs30gWB5nDxLzzL+Ka3WtB/cqiDjBFzcnMM8TKSoPPsHypXQZZoguH/8z65GHPEOr
         udeBqaTrFWOgGu6R09rQyZp68XJBG0Ume84XxJl48py9BWpxms3LP6cDcPZYT17RPEz3
         cQVQ==
X-Gm-Message-State: AOAM531Dj7DpbwrbTyHT4PMDNuo1nIL/HE5W1cA4NEy5mqQ+ViIV9twU
        Dg6rqcXS23+0kbaISnziRnOfxg==
X-Google-Smtp-Source: ABdhPJxqAYWE+06jubmS6vphEWSmGaG3d5IxrqcrnICb1nu8otRMzyUve+NDlL+vrTTB6Qb3KPoVww==
X-Received: by 2002:a63:f745:0:b0:373:8350:889f with SMTP id f5-20020a63f745000000b003738350889fmr24420532pgk.620.1646187112488;
        Tue, 01 Mar 2022 18:11:52 -0800 (PST)
Received: from localhost ([2620:15c:202:201:ddf3:7c12:38c:3c61])
        by smtp.gmail.com with UTF8SMTPSA id f15-20020a056a0022cf00b004f3b99a6c43sm18651273pfj.219.2022.03.01.18.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 18:11:51 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 2/2] drm/bridge: analogix_dp: Enable autosuspend
Date:   Tue,  1 Mar 2022 18:11:39 -0800
Message-Id: <20220301181107.v4.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
In-Reply-To: <20220301181107.v4.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
References: <20220301181107.v4.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v4:
 - call pm_runtime_mark_last_busy() and
   pm_runtime_dont_use_autosuspend()
 - drop excess pm references around drm_get_edid(), now that we grab and
   hold in the dp-aux helper

Changes in v3:
 - New in v3

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 16be279aed2c..b248d352f2bd 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1119,9 +1119,7 @@ static int analogix_dp_get_modes(struct drm_connector *connector)
 			return 0;
 		}
 
-		pm_runtime_get_sync(dp->dev);
 		edid = drm_get_edid(connector, &dp->aux.ddc);
-		pm_runtime_put(dp->dev);
 		if (edid) {
 			drm_connector_update_edid_property(&dp->connector,
 							   edid);
@@ -1642,7 +1640,8 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
 
 	ret = analogix_dp_transfer(dp, msg);
 out:
-	pm_runtime_put(dp->dev);
+	pm_runtime_mark_last_busy(dp->dev);
+	pm_runtime_put_autosuspend(dp->dev);
 
 	return ret;
 }
@@ -1775,6 +1774,8 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 	if (ret)
 		return ret;
 
+	pm_runtime_use_autosuspend(dp->dev);
+	pm_runtime_set_autosuspend_delay(dp->dev, 100);
 	pm_runtime_enable(dp->dev);
 
 	ret = analogix_dp_create_bridge(drm_dev, dp);
@@ -1786,6 +1787,7 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 	return 0;
 
 err_disable_pm_runtime:
+	pm_runtime_dont_use_autosuspend(dp->dev);
 	pm_runtime_disable(dp->dev);
 	drm_dp_aux_unregister(&dp->aux);
 
@@ -1804,6 +1806,7 @@ void analogix_dp_unbind(struct analogix_dp_device *dp)
 	}
 
 	drm_dp_aux_unregister(&dp->aux);
+	pm_runtime_dont_use_autosuspend(dp->dev);
 	pm_runtime_disable(dp->dev);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
-- 
2.35.1.574.g5d30c73bfb-goog

