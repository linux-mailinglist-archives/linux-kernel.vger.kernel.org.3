Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA646CE82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbhLHHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLHHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:53:28 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5817C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 23:49:56 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so1001722plx.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 23:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+r6igfAf/kslegJBovNbjh0dSnNN1eggHfhBS76iGU=;
        b=Adkx7HRAgXk7B0Yttk5KzozcClXve5ymmcn5bxXZFwjzzOJDKh4xAxa5K3jSkIg8qv
         tS7FsKM38KbcSR4ohgKDwiZ/BQA/2RFvhV4qxN2jHkPuic7V6Ik2cE1WKj9htcFA2Q8f
         mJXtEElhYd6zLpPFYHU9jDjlEupZRerFzNJoApJ+16eW+jy+nCaE7v2tOoD1ErWSWf+H
         sEIW1JRFOtLm09pI+tf3bWIrGYwd8FQcum+DD019nD+B7eBxcSZwTIvNXjvM1qG8rxQ5
         gLBtcJ0Z8TWMLJa6gjhoWaWrAwFJnJfdGgEzfExI6iw6KYQHaaf92NXIlJuLnVWboyg3
         EYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+r6igfAf/kslegJBovNbjh0dSnNN1eggHfhBS76iGU=;
        b=SMF0GKjcvlEr0kZ8NzwQupDtsqNSYJcVwA3DtOPbEp2c1SUy74rglV1CODWWzQLczI
         znDv5MiJXrQzA9WlqOt86qxRrgPDJTsT51kMQsNQj8GHQoa4m3Z64jZWgzxrOoDl514c
         Eq8jyAZXZkHy6SBUvAQrdgHOysRIZzdbjE7vtolXCedCLvOz6Moi207WpMVqGPi2LnSR
         KP4SAFNprhrrDhAMGeHBBHwYFgYyNPHGndFAFf5Oqg3lPi0Q38Z2ZTXOwt0W5DnUmTsu
         cS/e9FItjvvom0yb+aGtUU1izuKzAaN+05cOtEHYGs3wuwabzLAOX/P3KOqsSRW4KZvy
         1OOA==
X-Gm-Message-State: AOAM530T0PrW/yHD+VwhtaJXJ0maUUJekUFzwJJD+WNCJQTXkue47Tso
        y3/qu06cn7erOFuaT5X2Ncs=
X-Google-Smtp-Source: ABdhPJzKB2STTgrXaQBp8/xtEHyw6/KqQ8cSUqipNRApmeAEKFN6GkhRvPSQ4rnENVP/L+q+n8rfOw==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr5322731pjb.3.1638949796472;
        Tue, 07 Dec 2021 23:49:56 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y12sm2251752pfe.140.2021.12.07.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:49:56 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915/display: Remove the useless variable offset and its assignment
Date:   Wed,  8 Dec 2021 07:49:52 +0000
Message-Id: <20211208074952.404381-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The existence of offset is meaningless, so it should be deleted.

The clang_analyzer complains as follows:

Value stored to 'offset' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/i915/display/i9xx_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
index b1439ba..a478b7f 100644
--- a/drivers/gpu/drm/i915/display/i9xx_plane.c
+++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
@@ -964,7 +964,7 @@ i9xx_get_initial_plane_config(struct intel_crtc *crtc,
 	struct intel_plane *plane = to_intel_plane(crtc->base.primary);
 	enum i9xx_plane_id i9xx_plane = plane->i9xx_plane;
 	enum pipe pipe;
-	u32 val, base, offset;
+	u32 val, base;
 	int fourcc, pixel_format;
 	unsigned int aligned_height;
 	struct drm_framebuffer *fb;
@@ -1006,14 +1006,14 @@ i9xx_get_initial_plane_config(struct intel_crtc *crtc,
 	fb->format = drm_format_info(fourcc);
 
 	if (IS_HASWELL(dev_priv) || IS_BROADWELL(dev_priv)) {
-		offset = intel_de_read(dev_priv, DSPOFFSET(i9xx_plane));
+		intel_de_read(dev_priv, DSPOFFSET(i9xx_plane));
 		base = intel_de_read(dev_priv, DSPSURF(i9xx_plane)) & 0xfffff000;
 	} else if (DISPLAY_VER(dev_priv) >= 4) {
 		if (plane_config->tiling)
-			offset = intel_de_read(dev_priv,
+			intel_de_read(dev_priv,
 					       DSPTILEOFF(i9xx_plane));
 		else
-			offset = intel_de_read(dev_priv,
+			intel_de_read(dev_priv,
 					       DSPLINOFF(i9xx_plane));
 		base = intel_de_read(dev_priv, DSPSURF(i9xx_plane)) & 0xfffff000;
 	} else {
-- 
2.15.2


