Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866BA466638
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358583AbhLBPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhLBPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:15:31 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D493C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:12:09 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b67so177672qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 07:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5win83yfqpxb3G0uDT7ZMvmOCj3Tw1TRZr233dyvDuc=;
        b=mo+uivjzmHsuRBaFi8uHymmczEF4b/SLFl7A/ASUdGfiz9FYm3VHvfLfmvHEwQrhiE
         A9B+Q6R4HBswpJbv52KBTgTLuVgrceBao9La0Kj9ajy8Mb0jNAkXUoM93OvkRiYviWxf
         0u9xWvjCiOnuxPkwQAY6zmKDmY4Kl61B7jd6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5win83yfqpxb3G0uDT7ZMvmOCj3Tw1TRZr233dyvDuc=;
        b=bY00hBZI4caI7zLlseZzIcsgLiIRtMOuYNVIhtv8HbBB1RzshhbR+IOyfgw4Va5ar5
         xEActJr038Lrvaw566Jq13DVdIFmZShcFuJvjHDQ/KNY+4yMA6eDFN19EUcg7Wq1E2kM
         IjoXSL7BRDdRnblFonk+Wr9SxpZfZincV2z+ByLol3tqU4xRzKlbdOcdnQks9KeAdN+i
         R67yhPl0btsiboi9G8tT5kMQgnJ7FfXyAS48/Dn1PT3URsYxeBVfRfXi3No8blLmCwJZ
         09BWJ1S30ZS5Z6764PRL4wzM4C7hNmux55TB9LZQTo/HGPnN4IyLHhayfw5rIMn1iAh2
         L/2w==
X-Gm-Message-State: AOAM533dXc8t+mkx8m739w1rBKhI7lSZ9RtFVrF3SYPQwc0M62bfF9Xs
        9sPQPMrEH4IkXwJyzPw46aWztw==
X-Google-Smtp-Source: ABdhPJyKW64deXqmMjT9ZCpai94tANaoaVT4bykBTn5Yw2GwqCoFkWdSZwlMgR1aQYIkqnzgC7294w==
X-Received: by 2002:a37:6103:: with SMTP id v3mr12191774qkb.694.1638457928563;
        Thu, 02 Dec 2021 07:12:08 -0800 (PST)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:f841:769c:df54:f26f])
        by smtp.gmail.com with ESMTPSA id k16sm1726988qtx.92.2021.12.02.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 07:12:08 -0800 (PST)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     seanpaul@chromium.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, tzungbi@google.com,
        Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: send vblank event with the attached sequence rather than current
Date:   Thu,  2 Dec 2021 10:11:55 -0500
Message-Id: <20211202151200.3125685-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

[Why]
drm_handle_vblank_events loops over vblank_event_list to send any event
that is current or has passed.
More than 1 event could be pending with past sequence time that need to
be send. This can be a side effect of drivers without hardware vblank
counter and they depend on the difference in the timestamps and the
frame/field duration calculated in drm_update_vblank_count. This can
lead to 1 vblirq being ignored due to very small diff, resulting in a
subsequent vblank with 2 pending vblank events to be sent, each with a
unique sequence expected by user space.

[How]
Send each pending vblank event with the sequence it's waiting on instead
of assigning the current sequence to all of them.

Fixes igt@kms_flip "Unexpected frame sequence"
Tested on Jacuzzi (MT8183)

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 3417e1ac79185..47da8056abc14 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1902,7 +1902,7 @@ static void drm_handle_vblank_events(struct drm_device *dev, unsigned int pipe)
 
 		list_del(&e->base.link);
 		drm_vblank_put(dev, pipe);
-		send_vblank_event(dev, e, seq, now);
+		send_vblank_event(dev, e, e->sequence, now);
 	}
 
 	if (crtc && crtc->funcs->get_vblank_timestamp)
-- 
2.34.0.rc2.393.gf8c9666880-goog

