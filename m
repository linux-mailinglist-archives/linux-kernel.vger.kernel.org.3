Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0292A4884B8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiAHQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiAHQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:52:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439BDC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 08:52:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e9so16091949wra.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbP6l9e9WPV7+5ZHWs4pOKGgGXLLRP9ERXDPMtE742M=;
        b=ijB1mmORd5xw+l7Hxh3xST5FVoqGTx9yCeIHp7jV0qngf8E00G3RxEs1Jdh7zIvCev
         lMv9phcfD4cDeTSQ/RYXPqyJjGyz0BVe+/1e6USleTvyACydxUDPlcgQu8dWrNuhNC4r
         qvr8eMznhyQcgQwbTY4cxBYnriLwKyR57Ihzp2GxJ2nnd9BdANjIiyVNtpf5NFrMJ+Z2
         7uNPH+UnZyqu9cYnLxto6D/wV6ZBg4y8dGBur0rNtd5Rbwynzy0YZwCTZDfkIHed1G77
         tyLQ/FcE7TnWD2EPQeGOckiQ+Gn9M+jBBC4O7JYsFSvft3xKt/5smy9cXuu9mjJv0sV3
         MTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbP6l9e9WPV7+5ZHWs4pOKGgGXLLRP9ERXDPMtE742M=;
        b=A5w7Qyfvw30kDSgJY4ppxVvQgCuzg2jaFDg1XuIJpXEiD9WVEOMPs1YXKEsmYHyXCK
         MPWu+b0ro14hQIc6TZdU4Ph/mfMYybyi5c/+KrHEvQL6cqnoHB8QEQL0cifveFWZx2Q+
         mEx2HsamqRrtBKZUdac7CDXdNnCiWa5KAGQLDGbMfs5fADX4N1Lv+vOuBJ79BiJ0LN7J
         geEH52DhNNHh4U9Gj0v2zeg5xT9dIpI/ZrQpN9gzq3BvTlI57AojQoI1GcRLcGqooDvQ
         HG0V/PvfwwxHUeRlHVsJJ3vT4BipWkNv+U+iQTAfuR1gGC6aE0XJ8qrFdCYtwVDp9q++
         qOYA==
X-Gm-Message-State: AOAM531fGIxJ/L3Kio3c5kV30xoWYkpwz++HXe2Fq6m6unaI1PVZ1+vE
        D2D5fAcR36KZc9kEpxiuziVlvc68b3E28w==
X-Google-Smtp-Source: ABdhPJyP3K2xyfHsiOTYzsNlxEQq1yvbgeoIsW8mx3C8Bd5U5lyhs6OogxOaB9jsymdj5SYPzdyWOg==
X-Received: by 2002:a05:6000:1085:: with SMTP id y5mr60144131wrw.696.1641660754296;
        Sat, 08 Jan 2022 08:52:34 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id p21sm1994610wmq.20.2022.01.08.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:52:33 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     LW@karo-electronics.de
Cc:     airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] drm/imx: Fix memory leak in imx_pd_connector_get_modes
Date:   Sat,  8 Jan 2022 17:52:30 +0100
Message-Id: <20220108165230.44610-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid leaking the display mode variable if of_get_drm_display_mode
fails.

Fixes: 76ecd9c9fb24 ("drm/imx: parallel-display: check return code from of_get_drm_display_mode()")
Addresses-Coverity-ID: 1443943 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Improve commit message
---
 drivers/gpu/drm/imx/parallel-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index a8aba0141ce7..3bf8e0a4803a 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -75,8 +75,10 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		ret = of_get_drm_display_mode(np, &imxpd->mode,
 					      &imxpd->bus_flags,
 					      OF_USE_NATIVE_MODE);
-		if (ret)
+		if (ret) {
+			drm_mode_destroy(connector->dev, mode);
 			return ret;
+		}
 
 		drm_mode_copy(mode, &imxpd->mode);
 		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
-- 
2.25.1

