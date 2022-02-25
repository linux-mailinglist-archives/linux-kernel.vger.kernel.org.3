Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C414C46DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbiBYNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiBYNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:46:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB18210D74
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:45:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 7A6AF1F45F92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645796741;
        bh=PEG3axVN//YyYVluyyyZUdTkTfte6RZExlKRrKGNNGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/oym2rKqKgD8WS1WPUP98b3I3JMruzcQzkNhu3PgRNVN3ZTTJw+3GtVTL7aQoSOC
         ptLBuP3f9+pjoz9+9FnrgPRUlPo8VUleDaWCGLiwJzBpw/YoZOPgnqe50SuZ7CI3JM
         cBm7FrVwATP5cHVP41V99XezDyNEe+JLDXvRQJT3FOB6nF4qJGptcikBkNbiOeKqrq
         cYst4IN9RE4IHAGzU7XZe4bZk0uzpZw6GGOlQiX6xQ8R2LTgwiYm/vHddpjkOwekzs
         5rJVyJdqyqIFY/UJ48Ojz3PCzr+Plzv/pWZts6M45eVOhHQ9qPvjsnEhpEV4N01hB+
         hqRo5dsRtjmaQ==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: [PATCH 1/2] drm/bridge: parade-ps8640: avoid race condition on driver unbinding
Date:   Fri, 25 Feb 2022 14:45:03 +0100
Message-Id: <20220225134504.457245-2-ricardo.canuelo@collabora.com>
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

When unbinding a DRM master driver there's a race condition that
sometimes results in an invalid vm access when userspace (gnome-shell)
issues a DRM_IOCTL_MODE_GETCONNECTOR ioctl right after a bridge has been
removed from an encoder's bridge chain.

This means that once a bridge has been disabled and gone through
ps8640_post_disable(), if ps8640_bridge_get_edid() runs afterwards as a
result of that ioctl call it will call drm_bridge_chain_pre_enable()
and drm_bridge_chain_post_disable() again in a bridge that has been
already detached.

Setting `ps_bridge->pre_enabled = false` at a later stage of the
bringdown path and calling drm_bridge_chain_pre_enable() inside
ps8640_bridge_get_edid() only if needed avoid this, although a proper
subsystem-wide fix would be the proper solution, since the same type of
race conditions might happen somewhere else.

Tested on an Acer Chromebook R13 (Elm, MT8173) with Debian Sid.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 3f17337ee389..a927787a89bf 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -434,8 +434,6 @@ static void ps8640_post_disable(struct drm_bridge *bridge)
 {
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
 
-	ps_bridge->pre_enabled = false;
-
 	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
 	pm_runtime_put_sync_suspend(&ps_bridge->page[PAGE0_DP_CNTL]->dev);
 }
@@ -487,6 +485,7 @@ static void ps8640_bridge_detach(struct drm_bridge *bridge)
 	drm_dp_aux_unregister(&ps_bridge->aux);
 	if (ps_bridge->link)
 		device_link_del(ps_bridge->link);
+	ps_bridge->pre_enabled = false;
 }
 
 static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
@@ -508,7 +507,8 @@ static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
 	 * EDID, for this chip, we need to do a full poweron, otherwise it will
 	 * fail.
 	 */
-	drm_bridge_chain_pre_enable(bridge);
+	if (poweroff)
+		drm_bridge_chain_pre_enable(bridge);
 
 	edid = drm_get_edid(connector,
 			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
-- 
2.25.1

