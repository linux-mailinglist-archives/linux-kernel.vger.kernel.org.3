Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6B4AB631
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbiBGHzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348289AbiBGHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:53:41 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F1CC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644220420; x=1675756420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PLdPDLywrxWexnul+G8OpwDVmHBqyL7KeEVS03R8byg=;
  b=qF3CXUEw+YY0KOTK92Ldzl+rrArVgLlN6OWVwK2O7Zo5hMidprEoj88y
   JxMz5TTiIghHIZWTu/kYvLqZRYa5jbX8HNga8wI0nFdbE32CwtFW2CTee
   CyUs/KHGCL+W2h3Azo4D9ZehnEzXriCTq2U0oADChj/ZE0XOVxP8TEE9n
   Z3X8AT97SLWKk+gLPNvaQBz7JX6er6vOzm/t8j+PBuidOUI/SlPk3XFbC
   +wItSdcqtYCnefaEo5uNV4G/r/8tXCE4NxM3gYu5D1MbavTEV1aarxVPv
   J2ac/9K4n/x4b8aLA3azao+/1HbNIK/K8I4O/az1THlIyGz7MfSme9lUg
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21922577"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 08:53:35 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 08:53:35 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 08:53:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644220415; x=1675756415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PLdPDLywrxWexnul+G8OpwDVmHBqyL7KeEVS03R8byg=;
  b=m4mGjM+H+jdqPCb4EkRmlUfySjSRlGRhrXT9yDQEoPp+gA/5+21KcfFG
   CRb5IFmDmB4CKBZxH4H40Qkn8j/5ybwCMX6Ku/SWWM0o2IPZW99thanTR
   ScfMe0g1dakqSZrK0f6d2vQ50WCD/T/Ss/zHXF+JgzKYXxbbSdQxu0z29
   y9f8/bvDnhu3ys64jBueWBUx9pH6WO0yFMDeQ40wfMdorlKwsKbgGGsqc
   zHX9YhMhVhVokfpxYVPSP9X5geTwtrTA5vNY84p+c40KmOPK1iYvOV0qD
   k7v7pqZJbj5iLbAX1tA0Pvfy01c6GmvPe8P275dhVh4Feuc020SPEZ6WK
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21922576"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 08:53:35 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E1341280075;
        Mon,  7 Feb 2022 08:53:34 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Allow GPIO operations to sleep
Date:   Mon,  7 Feb 2022 08:53:25 +0100
Message-Id: <20220207075325.285179-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207075325.285179-1-alexander.stein@ew.tq-group.com>
References: <20220207075325.285179-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to require non-sleeping GPIO access. Silence the
WARN_ON() if GPIO is using e.g. I2C expanders.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
If the GPIO is from an expander on I2C, this warning will rise
obviously. Straight forward fix.

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 1f02596d6db4..2927fa2abd3d 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -346,7 +346,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 	}
 
 	/* Deassert reset */
-	gpiod_set_value(ctx->enable_gpio, 1);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 1);
 	usleep_range(1000, 1100);
 
 	/* Get the LVDS format from the bridge state. */
@@ -497,7 +497,7 @@ static void sn65dsi83_atomic_disable(struct drm_bridge *bridge,
 	int ret;
 
 	/* Put the chip in reset, pull EN line low, and assure 10ms reset low timing. */
-	gpiod_set_value(ctx->enable_gpio, 0);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
 	usleep_range(10000, 11000);
 
 	ret = regulator_disable(ctx->vcc);
-- 
2.25.1

