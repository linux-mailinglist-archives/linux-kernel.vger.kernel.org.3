Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC0488C52
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiAIUlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiAIUlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:41:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA8C06173F;
        Sun,  9 Jan 2022 12:41:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l4so7510343wmq.3;
        Sun, 09 Jan 2022 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtFdLLS5GcaegKjbKWr5PvQazf86TAVRtVOt+lG9vE4=;
        b=U4hhmH566w5zWI55wGgJnTqS9jf9efCX2WsmQDgdRcTPzUkLHRb6UYhv2d3KppN1AW
         pJpe7U1eMuVmludZhiXBKATaLPbPvm3+FhHvo2KD3Nh7FA8ZJmn7zMXEY5ZlccF/E9pJ
         ln6oCp81fP61NcmBcaxXtJ3X0Ueb90TE79kNzS2u8mb8dsLKSyECfFzzh+wXQTeiAz3b
         Ym3z8d8PetpMJT7GAM96YCpDrKC3ED4qE85RTIcISgiZE2Og3pECZRt2Xer5dyrdmOhg
         WT4Q65bYqt7oy9ctRDE3zMty39B3GP1J9Irib3qUgvKimSGM04kQ2EvHu2L0AfESCMYQ
         Ja4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtFdLLS5GcaegKjbKWr5PvQazf86TAVRtVOt+lG9vE4=;
        b=2/n3oZn2Vf/AoMfAZSxWiiaTSRGcFkSzzCYNZ0LQky3POc2uo1mIfgJWYwpdaix8Qo
         hX6QZ1DurW/O5ORHa4l9Hm7NPRm0N3asIjg5wyyJo0C+1LNrQqu0a3wWzmUI4Ubu9a7i
         hg+wqj3WXBtOT3At0rep4G97OMx85LDIsiRMh8ZZ47HdHazY6wLOmj7HLYv/dVHkdWdE
         g8BAAulzy2V+G0KS7pFsH6wIIqd1QrObnZ2Aca7Dp6KTsXIqH4RghtIeFS8iFw74uEwj
         Al4+rWOw2WRogdGYiHbXSTtC1uMyFlZ5wcCK78bkWVjMYguudLMPecaJQbYTdTVaopDy
         3piQ==
X-Gm-Message-State: AOAM533neb9K2PIrNu01038354/7gIpvqK7Wk+K/73bTr8W3UpGza6ZT
        SxtGPfZncKmyM8ovn1+J9RE=
X-Google-Smtp-Source: ABdhPJzHCw1tXMWCxa7fiZNVNwfLK9Kt3oRY8ZzA/AzZbu+FBVQcxtbSaDPcxTYHuir+4pMQVkg4rg==
X-Received: by 2002:a1c:a78c:: with SMTP id q134mr3323567wme.103.1641760866167;
        Sun, 09 Jan 2022 12:41:06 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w17sm5560413wmc.14.2022.01.09.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 12:41:05 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: adv7533: make array clock_div_by_lanes static const
Date:   Sun,  9 Jan 2022 20:41:05 +0000
Message-Id: <20220109204105.51878-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array clock_div_by_lanes on the stack but
instead it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7533.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index eb7579dec40a..ef6270806d1d 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -29,7 +29,7 @@ static void adv7511_dsi_config_timing_gen(struct adv7511 *adv)
 	struct mipi_dsi_device *dsi = adv->dsi;
 	struct drm_display_mode *mode = &adv->curr_mode;
 	unsigned int hsw, hfp, hbp, vsw, vfp, vbp;
-	u8 clock_div_by_lanes[] = { 6, 4, 3 };	/* 2, 3, 4 lanes */
+	static const u8 clock_div_by_lanes[] = { 6, 4, 3 };	/* 2, 3, 4 lanes */
 
 	hsw = mode->hsync_end - mode->hsync_start;
 	hfp = mode->hsync_start - mode->hdisplay;
-- 
2.32.0

