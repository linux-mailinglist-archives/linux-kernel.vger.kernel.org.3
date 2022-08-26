Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D835A25E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbiHZKco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiHZKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:32:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74881D290C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:32:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z187so1144968pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=dtu5aMtj4xUVB2P5GCPZnShf7gkZy/unClrmm0lDZ+c=;
        b=b83I/LIUmp+5mSHBInI1Ef5MEkkssWTZ9r1cpEBUBRzA/ZJUnTHCJNuWKrDFCDHlfY
         GqFUviJizlXZBDZye7eBnd2IYU1/7zMGh+l+j1i15tqSv/PEnrQDHOfeNAzDVa6cI4zJ
         ASkiPi3xCAUlqtsESLiBaZ5DIwj78VM+MSY/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dtu5aMtj4xUVB2P5GCPZnShf7gkZy/unClrmm0lDZ+c=;
        b=vzKaTpZAbk5N2EcfYCa74w3Fs7kdXt3V2wIqPbHePxMbJkeYTCpCsU+tXEf+Sr8SJ7
         WU2gFZvcfFxnGG1DDG0ftAHorxJ9Dysg4av5S1wbKbKH77XWQgNDGWjkuO46QfTmLV3T
         T/AWiJCQJt2G/w10M7uzVXEPXt7xbhAV4HNNMM4SavcHymF3bBXhg6irW7zDfui7F1yH
         diw3F7wFJb4LFRlExS2q0ld+8GEEieLIBxZ5r/Xcn3RpN2cFgpqs7Is0zlKUHu86kSPd
         mZQ1e7uA2NRKyru39oRV3bX8QH3nJq0CHKqtLzvTwrqysFWA8+I6FwUzzeUaQ4faNivx
         svwg==
X-Gm-Message-State: ACgBeo0O/BvR17r3pW2vTENJATgMI1NTTYeIotmHTp2Rx7mpRmtNlNHS
        wbgs7NGaLmWq6GAnWKV2Gbfk8Q==
X-Google-Smtp-Source: AA6agR6YwO3Xn18S+BIsUXZCFTJcr2ucNOrvG9nC8pX4z4u57OUlF7fWbmEA7/GLENjqSBtMyfM3yQ==
X-Received: by 2002:aa7:8712:0:b0:537:db6d:af66 with SMTP id b18-20020aa78712000000b00537db6daf66mr30006pfo.55.1661509956933;
        Fri, 26 Aug 2022 03:32:36 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:d4a7:ca1d:f607:5a3b])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm1314610pji.41.2022.08.26.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:32:36 -0700 (PDT)
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
Subject: [PATCH] drm/bridge: it6505: Fix the order of DP_SET_POWER commands
Date:   Fri, 26 Aug 2022 18:32:31 +0800
Message-Id: <20220826103231.2504799-1-treapking@chromium.org>
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

Fixes: 77c18864c5fc ("drm/bridge: it6505: Send DP_SET_POWER_D3 before stopping DP")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

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

