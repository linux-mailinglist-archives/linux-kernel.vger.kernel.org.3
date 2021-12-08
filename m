Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A036B46DBD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhLHTNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhLHTNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:13:17 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E270AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:09:44 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id m25so3103138qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ji1mvPknDhdOmYpOyzWQYdOGcoOMkKQYqnM5UxcNn1k=;
        b=ePGN+fQlX9ZDIDadtyh99MJ3jIvTxzM7/e+8xxksGts1MB+YbRwB7PtErJtgiJRZUj
         7sVewD/SARtWcJruveNmgDsYVgpggb3vP8zYClqZhlU008yWZTGp5bKP68sBXSVSu95O
         cbPI245hJgs0z42jAvVCw6WSxuVQe/r2Yp+To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ji1mvPknDhdOmYpOyzWQYdOGcoOMkKQYqnM5UxcNn1k=;
        b=4FcrJcaWGnC0JikuGhLThLO7jnB6LILtUTRcngsRbsztwsizJ6pgPG5qK9DCVaTfLZ
         QN0k/XmHtlxKF+kc6bhoYxWeXamX7rPSDz4/By6XRK/dmhxQsAMcdQJOfhlSL/UixPya
         bkmSka2Xm/2h1vJpejmvHzBPP+I54x//OyadUbwzCJRKoESjZBF1iQCuqSWpDWo9bduj
         YI+Hg1mBzUQJeA2OE0Om80f3BU0vx249RbTJ39YRhEVTKBX2plbVKW841u/dGyoNI53/
         CZkCRnR3DaVww4JW5Os+crH6bl475la8cx/GrYgAb1kQa1NSGuttjf7GIzTYCF3xrAs8
         guYQ==
X-Gm-Message-State: AOAM532fZHNi9o7rbn60eeYJ47CO0dHWrm12HDhVjPfxOz+EYCZsnE4k
        J7gb3obEscCT4XLEhqlv2xU3kg==
X-Google-Smtp-Source: ABdhPJwfE5wTjaJrI7YGlf6iH+HGfN7+U8y+ErYNboRLOLubGkSlxTFlPcGBO7bO0YjTYP1fRWb5Nw==
X-Received: by 2002:a05:622a:1c6:: with SMTP id t6mr10311770qtw.211.1638990584025;
        Wed, 08 Dec 2021 11:09:44 -0800 (PST)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:eb6e:9a77:7a91:9461])
        by smtp.gmail.com with ESMTPSA id o21sm2142939qta.89.2021.12.08.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:09:43 -0800 (PST)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     seanpaul@chromium.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, tzungbi@google.com,
        Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: Validate the CRTC LUT size.
Date:   Wed,  8 Dec 2021 14:09:13 -0500
Message-Id: <20211208190921.128702-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

[Why]
The user space can allocate a LUT of any size. We must validate that it
is the expected MTK_LUT_SIZE.

[How]
Bring the .atomic_check function internal to mediatek driver and check
that the new CRTC state LUT size is equal to MTK_LUT_SIZE.

Fixes igt@kms_color@pipe-A-invalid-gamma-lut-sizes
Tested on Jacuzzi (MTK)

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 40 +++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index f47801737b88f..82de83656d159 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -54,9 +54,47 @@ mtk_drm_mode_fb_create(struct drm_device *dev,
 	return drm_gem_fb_create(dev, file, cmd);
 }
 
+static bool is_lut_size_expected(const struct drm_device *dev,
+				 const struct drm_property_blob *lut)
+{
+	int len;
+
+	if (!lut)
+		return true;
+
+	len = drm_color_lut_size(lut);
+	if (len != MTK_LUT_SIZE) {
+		drm_dbg_state(dev, "Invalid LUT size; got %d, expected %d\n",
+			      len, MTK_LUT_SIZE);
+		return false;
+	}
+
+	return true;
+}
+
+static int mtk_drm_atomic_check(struct drm_device *dev,
+				struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+	int ret, i;
+
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+		if (!is_lut_size_expected(dev, new_crtc_state->degamma_lut) ||
+		    !is_lut_size_expected(dev, new_crtc_state->gamma_lut))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.fb_create = mtk_drm_mode_fb_create,
-	.atomic_check = drm_atomic_helper_check,
+	.atomic_check = mtk_drm_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
-- 
2.34.1.400.ga245620fadb-goog

