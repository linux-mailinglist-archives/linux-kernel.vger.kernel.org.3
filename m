Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD86474F26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhLOAZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLOAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:25:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBAAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:25:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y8so14943349plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ie0cKAirDGTix4AW5nZqMbHaJVqohc1+9LbHt6dRbI=;
        b=dz3Isn3hHbXtldJlHtULb4EgoDF3TbUumHn2zXWWLmoyrP+FkeRsYQ6t9/GYbRto0A
         K8f2n9TZFD0XPEJPJoFmk/XvYtZA2sZYlM0mPo/+Wfb/ozXrEwMbFMk+MaT6vnLECrD0
         yt6cviMyl9M8tcNGJB8YU4ClRna/Jn0QxnF3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ie0cKAirDGTix4AW5nZqMbHaJVqohc1+9LbHt6dRbI=;
        b=JxVRf9R87Ws7JYMc3nZB2HtEZbGITRFrFrmAooz4PgZvPNAnUufUkQSM7koTDZiqyE
         HqVCF0Q1LCUptjpR5C9OjGZXlJfzRWTMKXShQJZIhNYFtJnbXAcKCxdR18BL3AKefCMD
         dQ+vX/kZgV3loPqstUeBkyYt0n4DCUdpyliRiuUcKJi6+zI33p+Dg5Ksgm7e5al0kU64
         fLB9c4fif4Jz3XFG3HCuiUUBbKDRIjeQOcxXbJcCv1ljkBFMZDeg/oXeGBVuIpvrAI6z
         vgCGqYbGcBuDZinO/aKWNoeaHvTb8EUJof3T/p9Y/WX+1C3XGGVhDfz7ghlcKWFGh0pl
         2Spg==
X-Gm-Message-State: AOAM532OAB3kMxxrg51sF+qLDym6bTXkMMLGOWs3IWjj1gTChlWRsU8s
        QIwtdf6Z01yDJlDl+a0305zNsQ==
X-Google-Smtp-Source: ABdhPJzET/clzh0hfclzzLyeMJC9G8FDCShSbvTUlZJUNyUiAvtMglTpvWsrWh/WnV82H9rwfIuSew==
X-Received: by 2002:a17:902:7c02:b0:148:a2f7:9d6d with SMTP id x2-20020a1709027c0200b00148a2f79d6dmr1942525pll.140.1639527931578;
        Tue, 14 Dec 2021 16:25:31 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:46aa:90e5:f847:f509])
        by smtp.gmail.com with ESMTPSA id k18sm228347pfc.155.2021.12.14.16.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:25:31 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Set max register for regmap
Date:   Tue, 14 Dec 2021 16:25:29 -0800
Message-Id: <20211215002529.382383-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the maximum register to 0xff so we can dump the registers for this
device in debugfs.

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
Cc: Rob Clark <robdclark@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6154bed0af5b..83d06c16d4d7 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -188,6 +188,7 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
 	.val_bits = 8,
 	.volatile_table = &ti_sn_bridge_volatile_table,
 	.cache_type = REGCACHE_NONE,
+	.max_register = 0xFF,
 };
 
 static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,

base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
https://chromeos.dev

