Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4669C5A5AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiH3E6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3E6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:58:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8366ABF36
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:58:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso16745688pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=dK8f+bSiX8rZNVbzJ6QM+JiqkHCfSPqcZ+FR3yPajWo=;
        b=mPR9wWeAHBswGlkEijMLxr1cR9rhgQuUAVTE7qdxas7ES5Bnv402ghcZi5oJClOt4M
         1+/qpTBkAikMnvfZYNb5kLkRTeH2fFpAfaOF+dE7DLnwUp01lD2b1A2PeFRaYNaT3+zu
         qdn8kPqSLXut6M0qm5k3LF2U/rExKP6v1jlHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dK8f+bSiX8rZNVbzJ6QM+JiqkHCfSPqcZ+FR3yPajWo=;
        b=DwjFoCxz/u7craPXu6pj4OXwuI0Mr+1gC5laUNtXKF/l/4w6XwRwaX7m8IhSH2deR3
         SLTYlTJyBx7xdjkad4a4q2W01vdblxrYtKGAIzT/AYG6vbYmuYVF2uJZ5MkC1aWVDXbV
         j/InPvrcg5132HiyIjeDK4g0vAursjgA240m4ScodPo1mlt/PpTqhftw5HxXmWVnjq4y
         enBoFjNYLOh+KXJO1V05oZAk1P8dnrGbD84e43Ss9kyhZBNo5q25ek8w1H7vFtZao6HK
         Q3PY5+hwC0fbj8+uLVbvRHy2VWf63QGbV7tYoEdJHz10at+nAgAUiD+LIjyB7FcOy4Fl
         FEcQ==
X-Gm-Message-State: ACgBeo1GCymL0UbOM8O1WCxB1OS9dBPf+eI0kIhBZGt3+O6FR4m+Euj6
        Ggv9ywGSCn8m/7cqv7Kx6yxHSA==
X-Google-Smtp-Source: AA6agR6B6f8pNn5GZX6kUkW/UtxN7Z8yMMAjforcEPhR1lsXozCZCGHrZPkTAamDwEZeSl1y47WyVA==
X-Received: by 2002:a17:902:c651:b0:174:36ce:49ce with SMTP id s17-20020a170902c65100b0017436ce49cemr19431445pls.87.1661835486490;
        Mon, 29 Aug 2022 21:58:06 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:85ae:69db:1857:fbad])
        by smtp.gmail.com with ESMTPSA id n35-20020a17090a2ca600b001fe136b4930sm139328pjd.50.2022.08.29.21.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:58:05 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: it6505: Fix the order of DP_SET_POWER commands
Date:   Tue, 30 Aug 2022 12:57:56 +0800
Message-Id: <20220830045756.1655954-1-treapking@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send DP_SET_POWER_D3 command to the downstream before stopping DP, so the
suspend process will not be interrupted by the HPD interrupt. Also modify
the order in .atomic_enable callback to make the callbacks symmetric.

Fixes: 46ca7da7f1e8 ("drm/bridge: it6505: Send DPCD SET_POWER to downstream")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---

Changes in v2:
- Correct "fixes" tag.
- Collect "Reviewed-by" tag.

 drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index f9251ec49bf0..2bb957cffd94 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2951,9 +2951,6 @@ static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (ret)
 		dev_err(dev, "Failed to setup AVI infoframe: %d", ret);
 
-	it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
-				     DP_SET_POWER_D0);
-
 	it6505_update_video_parameter(it6505, mode);
 
 	ret = it6505_send_video_infoframe(it6505, &frame);
@@ -2963,6 +2960,9 @@ static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
 
 	it6505_int_mask_enable(it6505);
 	it6505_video_reset(it6505);
+
+	it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
+				     DP_SET_POWER_D0);
 }
 
 static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
@@ -2974,9 +2974,9 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
 	DRM_DEV_DEBUG_DRIVER(dev, "start");
 
 	if (it6505->powered) {
-		it6505_video_disable(it6505);
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D3);
+		it6505_video_disable(it6505);
 	}
 }
 
-- 
2.37.2.672.g94769d06f0-goog

