Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A488347F26B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 07:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhLYGc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 01:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhLYGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 01:32:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0AC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 22:32:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu9so23083252lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 22:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gBC/jkuk/B4JtGyE/txGFQBheaZg+UFBXoPs2zfVHSs=;
        b=MYBkV0Cw7aKwMZaylqS4a1e2X2UBwRRiRoh48xR7jBspW3CzOiAPkEQCnyJTen0E1U
         u8uR4kNeIRX6rcL5r8YuinWJ8dUyMXdpuYzV5FAUNcVa2flcJb+srKLpDlX1fh67jccb
         47tOjI0zH52GLzDoQCLlEYONaNuqAt9BtVDvQcsT0mGKk+9hbdw2zSJs+73L0k6glE2k
         FaF3aRXA5CKM/v9YxnUvjmZUg5RcgcIyw3p1l1kVPiKbaAeAo4z5xS0Vtdm6dNUeqZG7
         SEc19GusnbE/cqzAzQmDAHu/KY6tte1kcudh/58iWuyUbI66sfvtd/5cP1Gveme681sO
         8kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gBC/jkuk/B4JtGyE/txGFQBheaZg+UFBXoPs2zfVHSs=;
        b=v7SFMIgOvqLMfa4ixGisbY8SN/bmUBbWFA7sCudDIQCOsedXn0fJZEudwhCpjpc5yy
         jJJCb9OhyRbGUpwvO6X+jPy/HdRJ1nmlU7rSz2B5UW7ImfQuLzkkNwt3xEYbZ7baM1mb
         clASNI69adkAt9cWTJrJoWT+xBhBN9rVbaLIbSHPiFTTMu7juvxvf1zu89kZdrS1d7OC
         b1+6ss/wRBUdFAWjW+GUKf1BKndqtkq2oaHy/Pg2WAQFbFNrqkPh6dvWyI7X1gyzz4E+
         nLJPnUzR0NyqcFrDM3xxw6cYkly33Z7SU9ZEwDGldNKINJ3SJWGkzBvfzbew0UoCkxS7
         cbaA==
X-Gm-Message-State: AOAM533XPfb4TmKC4xR+6luOx7ejmSxtgjYZ6uUjswHvQ9Bo4zNsXAU1
        vZ3MTvYj4mwFm/wZp2ZUKmBVqQ==
X-Google-Smtp-Source: ABdhPJzXtwR95Gpe7oGsl9hPF+1Jcjq5nAzRJ6mv0rM94onIZv7Ckec8p5i9R2e/Z8D+SlMJ9dzYFg==
X-Received: by 2002:a05:6512:a8e:: with SMTP id m14mr7547760lfu.423.1640413946488;
        Fri, 24 Dec 2021 22:32:26 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id m7sm1022490lfr.133.2021.12.24.22.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 22:32:26 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] drm/bridge_connector: enable HPD by default if supported
Date:   Sat, 25 Dec 2021 09:31:51 +0300
Message-Id: <20211225063151.2110878-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hotplug events reported by bridge drivers over drm_bridge_hpd_notify()
get ignored unless somebody calls drm_bridge_hpd_enable(). When the
connector for the bridge is bridge_connector, such a call is done from
drm_bridge_connector_enable_hpd().

However drm_bridge_connector_enable_hpd() is never called on init paths,
documentation suggests that it is intended for suspend/resume paths.

In result, once encoders are switched to bridge_connector,
bridge-detected HPD stops working.

This patch adds a call to that API on init path.

This fixes HDMI HPD with rcar-du + adv7513 case when adv7513 reports HPD
events via interrupts.

Fixes: c24110a8fd09 ("drm: rcar-du: Use drm_bridge_connector_init() helper")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/gpu/drm/drm_bridge_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 791379816837..4f20137ef21d 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -369,8 +369,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 				    connector_type, ddc);
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
-	if (bridge_connector->bridge_hpd)
+	if (bridge_connector->bridge_hpd) {
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
+		drm_bridge_connector_enable_hpd(connector);
+	}
 	else if (bridge_connector->bridge_detect)
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
-- 
2.30.2

