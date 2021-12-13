Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A6473143
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbhLMQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhLMQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:07:59 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:07:59 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id de30so14364429qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VPAU6dvYOzvsB1kyIfMQv3U9XrNMQlDiY7WbCBmBes=;
        b=aqwHs4+TE4DLSYVktWLA8eauGvZ1M5mb9cmFWB9dGS9HT8aI1sizuWcY2hhiH7yN1Z
         XBwpxbiE3gKBaxK02sOgWhToQa1yxkGCGb/WDUCYGP+Ps0LA4n9syrEqUWRfEUJxFyIM
         e17dClHwtHeJwNhWM6uak6lwCn+LwuB3upWF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VPAU6dvYOzvsB1kyIfMQv3U9XrNMQlDiY7WbCBmBes=;
        b=fmvQ3TjG0AVJW/9vb4F07qJhxrIayi2wQ8hhFV5Grn9crojd3GqB9YgqDGkQQZz5I5
         fOho5nofu/+iFlb/ol0G3mmS0aN4HTe48O4pexgk/4kdCIvZXxVX9DEYZYcLtAeLpl2i
         Y4AsiiSYfPrI04i0tpHBRWsew43z5OT0D4KzCc/t5pChumevQf5uWFh/WkaWime+tH7u
         ndwId4vQ6RxKGsOnmFnTCMEG8C5ceOxu8U48rvu9dJNlEJp2A5nva6LPsgOv23isMJjS
         5YqbQ0kNNjTZ209EjCVqfJAiqP1GKXXOusR/OFaiGwfvNoDTfyOWTLpQWC0X7oQ/k36m
         EzCw==
X-Gm-Message-State: AOAM532ERHSewXTZNcd03nXTUcjPx//TF1hnqg0PuYIHPjlmD4yfbr2u
        GjKzIsjFFA74vrL9LmDN6mmS+g==
X-Google-Smtp-Source: ABdhPJwVk+NpCyiYqBuxb8qXr1TTL8u2eezR/uX5Vhpcpw+L1CidoZGT5Lo5wmw1ZpnAXNALFjKJ1Q==
X-Received: by 2002:a37:a411:: with SMTP id n17mr33513759qke.722.1639411678428;
        Mon, 13 Dec 2021 08:07:58 -0800 (PST)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:435a:1eff:4bc4:107d])
        by smtp.gmail.com with ESMTPSA id d23sm6054390qkl.70.2021.12.13.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:07:57 -0800 (PST)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     seanpaul@chromium.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, tzungbi@google.com,
        Mark Yacoub <markyacoub@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/mediatek: Set the default value of rotation to DRM_MODE_ROTATE_0
Date:   Mon, 13 Dec 2021 11:07:22 -0500
Message-Id: <20211213160742.744333-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211027162806.2014022-1-markyacoub@chromium.org>
References: <20211027162806.2014022-1-markyacoub@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the reset hook, call __drm_atomic_helper_plane_reset which is
called at the initialization of the plane and sets the default value of
rotation on all planes to DRM_MODE_ROTATE_0 which is equal to 1.

Tested on Jacuzzi (MTK).
Resolves IGT@kms_properties@plane-properties-{legacy,atomic}

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index e6dcb34d30522..accd26481b9fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -44,9 +44,10 @@ static void mtk_plane_reset(struct drm_plane *plane)
 		state = kzalloc(sizeof(*state), GFP_KERNEL);
 		if (!state)
 			return;
-		plane->state = &state->base;
 	}
 
+	__drm_atomic_helper_plane_reset(plane, &state->base);
+
 	state->base.plane = plane;
 	state->pending.format = DRM_FORMAT_RGB565;
 }
-- 
2.34.1.173.g76aa8bc2d0-goog

