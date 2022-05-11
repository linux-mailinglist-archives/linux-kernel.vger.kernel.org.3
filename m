Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961145228F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbiEKB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiEKB0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:26:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5760D90
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:26:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id l72-20020a63914b000000b003c1ac4355f5so250651pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pnUaG30jMgngG5x6l8ucLv0AptNmlu+5TwnQDCkmbWE=;
        b=GWQnoLZChQmkh7O7LbbpX7hz1tdrDmZCE2Eh4kV1tDjfkA0wwHWyCJi8pkErwLA3dg
         nbJFcnvxOz3Aj5PWMjB9p3q8NZdGg1GtdkCwB0w3BbPhbHtcnuxbUP4BVCkzwM+vxN1w
         CovkD/Z/bazGywUQvxoJxzFAEkNd52bwRMhINhJWwmJl0OgBOUpNBlz9h46zWn4w+Pf6
         1Ei4Vuu6/gTZYRILEW8N5Cg0vVAC3Ug3WdU2xfeUNYy2qIBAiTF3jSbR3PlVgq5OlQYM
         3mZdnrjorSMFCR0o/Ti9WnBPvyZLJzo1uNzfpuvH74fW2Lr5yU1YXQ6JUPSvxNmUS09x
         rzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pnUaG30jMgngG5x6l8ucLv0AptNmlu+5TwnQDCkmbWE=;
        b=6QbsQ7WsD3SD42l2vc3uG/QWyYRPMrBCTm8bi5qD5mWIaOY3Kto5ZGKJvv3p9+i/tu
         jjTue9dNzLLB0LdycSFvL4jGtKjSgPFx2gjJ1c0GlxyUPbUnsKb8l2hkz6Z5FOqHp5yt
         PF/J8yuL0zeYyenuqINYcAAx2ttjkCGF8bTvC5U/PVTxZgdvLrMXABNdT8EfkxRNepMN
         odV6htzWgCUejy/uuyrrCsHsgNeg+2vkyJrac32j7qiFmFucXQOpNys3G+S/nN2pFvA9
         BZzTE+85/XzqP16Zvd011ebzAE/pW14k0yXPxxhN5sOIx/Ph3AX123yMdmWpn0kW40w2
         FJCQ==
X-Gm-Message-State: AOAM5330BMCTmO3A0c03QAJtiSVH7PEqXMuj8E1FptRwLLgu/DXZXpaT
        kqEVCdJhIJNfie10yCpWw40EAs9kA94w9MV+J+T2+YK20vnJhr27ecyVj138TpZIyLcDscpirtc
        VWYkod005btd9bOkUdgf6umZH/YAGP4q/NP8MogJsSplA54t6dddnbIoSS7j6UgQEdiECxuA=
X-Google-Smtp-Source: ABdhPJxHi+T8HFFIdsi+8fpFBbHek8sX6pvBeLqEFs+VsU0dvLtN3RLwFFfJEUEB4PZZm8piLA05k5qawVDt
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a62:1788:0:b0:50d:dc1f:70b0 with SMTP id
 130-20020a621788000000b0050ddc1f70b0mr22543275pfx.48.1652232388031; Tue, 10
 May 2022 18:26:28 -0700 (PDT)
Date:   Wed, 11 May 2022 01:26:11 +0000
Message-Id: <20220511012612.3297577-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 1/2] drm/bridge: lt9611: Consolidate detection logic
From:   John Stultz <jstultz@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Foss <robert.foss@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply consolidates the duplicated detection
functionality in the driver.

Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: kernel-team@android.com
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: John Stultz <jstultz@google.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 63df2e8a8abc..bf66af668f61 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -578,10 +578,8 @@ static struct lt9611_mode *lt9611_find_mode(const struct drm_display_mode *mode)
 }
 
 /* connector funcs */
-static enum drm_connector_status
-lt9611_connector_detect(struct drm_connector *connector, bool force)
+static enum drm_connector_status __lt9611_detect(struct lt9611 *lt9611)
 {
-	struct lt9611 *lt9611 = connector_to_lt9611(connector);
 	unsigned int reg_val = 0;
 	int connected = 0;
 
@@ -594,6 +592,12 @@ lt9611_connector_detect(struct drm_connector *connector, bool force)
 	return lt9611->status;
 }
 
+static enum drm_connector_status
+lt9611_connector_detect(struct drm_connector *connector, bool force)
+{
+	return __lt9611_detect(connector_to_lt9611(connector));
+}
+
 static int lt9611_read_edid(struct lt9611 *lt9611)
 {
 	unsigned int temp;
@@ -887,17 +891,7 @@ static void lt9611_bridge_mode_set(struct drm_bridge *bridge,
 
 static enum drm_connector_status lt9611_bridge_detect(struct drm_bridge *bridge)
 {
-	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
-	unsigned int reg_val = 0;
-	int connected;
-
-	regmap_read(lt9611->regmap, 0x825e, &reg_val);
-	connected  = reg_val & BIT(0);
-
-	lt9611->status = connected ?  connector_status_connected :
-				connector_status_disconnected;
-
-	return lt9611->status;
+	return __lt9611_detect(bridge_to_lt9611(bridge));
 }
 
 static struct edid *lt9611_bridge_get_edid(struct drm_bridge *bridge,
-- 
2.36.0.512.ge40c2bad7a-goog

