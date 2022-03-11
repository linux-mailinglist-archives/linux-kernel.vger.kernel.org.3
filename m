Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7214D5E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiCKJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347553AbiCKJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:35:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76089F3B2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:34:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id E511A1F4649E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646991277;
        bh=6IuTiAPuhKDYgNwCLKRyc4SunUJTB6ruZFYFsOvvpvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gD8SJkWPQ7AVcDYe+nWxXfobtI4INoYCVxW2ZB+Ymm9w2+8CaNz1q4SOTOz0LYPjz
         hGE5rXOAurREVi3IW7YQ+311vbeuCvhAZEtGwT1UQ6JGNN4jw9I5SVByaHfedUpRgk
         8tl6I1ycOfeVe6h3U6FpZHRJQ4a08lXbIc0faRsAqCq1QccSYUlhyRTPdgqB7lD/KD
         nlgN6VZ5BncUXMpaEJHhVlgNMh78y/7kD8lLHl4E8MWn0XAm+B4cW/SdglvOY5S+SS
         JRf3BVt9wetOW7qBA0Od2XtzFbiAg08uBp+EtWKh8s9Wzyz3ipXIE1sm44716SVvX1
         7EEsvho0zxjdg==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: [PATCH 2/2 RESEND] drm/bridge: Add extra checks in pre_enable and post_enable
Date:   Fri, 11 Mar 2022 10:34:06 +0100
Message-Id: <20220311093406.4068019-3-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311093406.4068019-1-ricardo.canuelo@collabora.com>
References: <20220311093406.4068019-1-ricardo.canuelo@collabora.com>
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

