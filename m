Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7C4C46DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbiBYNqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiBYNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:46:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402B210D75
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:45:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 38B651F45F94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645796741;
        bh=6IuTiAPuhKDYgNwCLKRyc4SunUJTB6ruZFYFsOvvpvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=furnXzpdMdgCyVoYEJ4jDsNkBjXVwWUIBhNi74Q0yGH4QrCYy2xcC23hpHNo4n5G1
         y8Ob0c1jgVIFTYAcUYS0VgI+V4cihoITEyo8tyqT6WCgnBVRZAwEIIomHmYKBxSzBt
         Dht/iRxyKUmfqcBqP4xEmfexO2cMyX4S0ivgJEH+iaqsHPSzatnnyPqq1iRfrV4b4u
         qfp/5GFOhhwNbEnaYRe9iWYSMgpbdoygnLQc8OU1T8IM4sTQQYPQz75DX31oGd8161
         ibLHJGZwlRfOAm0FWAFpDkxesQSeTlLajZta2f58kEj2pvFTU9sy/6WHJQ3UtXQ8ic
         0d/WRZ7lQBuGw==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: [PATCH 2/2] drm/bridge: Add extra checks in pre_enable and post_enable
Date:   Fri, 25 Feb 2022 14:45:04 +0100
Message-Id: <20220225134504.457245-3-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225134504.457245-1-ricardo.canuelo@collabora.com>
References: <20220225134504.457245-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the bridge code, certain userspace events during a driver
teardown (such as a DRM ioctl call) might cause a race condition where
the drm_bridge_chain_pre_enable() and drm_bridge_chain_post_enable()
functions could be called for a bridge that has just been detached and
removed from the bridge chain of an encoder.

This change makes these functions a bit more robust by bailing out if
the bridge has already been detached.

Tested on an Acer Chromebook R13 (Elm, MT8173) with Debian Sid.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c96847fc0ebc..e074aa456dd1 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -529,7 +529,7 @@ void drm_bridge_chain_post_disable(struct drm_bridge *bridge)
 {
 	struct drm_encoder *encoder;
 
-	if (!bridge)
+	if (!bridge || !bridge->dev)
 		return;
 
 	encoder = bridge->encoder;
@@ -585,7 +585,7 @@ void drm_bridge_chain_pre_enable(struct drm_bridge *bridge)
 	struct drm_encoder *encoder;
 	struct drm_bridge *iter;
 
-	if (!bridge)
+	if (!bridge || !bridge->dev)
 		return;
 
 	encoder = bridge->encoder;
-- 
2.25.1

