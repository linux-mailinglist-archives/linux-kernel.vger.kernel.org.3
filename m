Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EE47F671
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhLZKlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 05:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhLZKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 05:41:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DFC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 02:41:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso6924676wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 02:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/cIP//uzFRFV87jVN39f0dog6UQJqLvS7DxqTem8FA=;
        b=k9o44mibKBF3U3K6MpVibRS05DQ39Bkul1GNZ17pr1M8wR7rI/PVYDPPHit3jxFmmo
         /Ok6zyd+o7Djl71zz/LUBXTkgTzp3iuturrtFZi59y6BOBYVGuIxzFabexVva7x5+qm8
         GsDw/GAkZM5+zxo5tVW6lR83ozxgc+kkgWtJtKzhnUeGOS/Ri15ZxapxHcvmSuluo6LJ
         s3iI35tiRj39TDbylzOL9gdo//QL+GyNIeT7XtzF4xoqK/cvb87M9rJuQ7ZE29wEdqe0
         /YVYOWPhbvj+PQrSySyQh8SJWpUoMUeuoLC1Y9cFvqEF/Ki1cpfk/ZV4amNDcGMHEyFx
         reMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/cIP//uzFRFV87jVN39f0dog6UQJqLvS7DxqTem8FA=;
        b=Qe0BWYTOf1n5A+nqq5ml+96D+oBmKKRBTIG6p95GPDwjl2U0l5rT9EVDVqDKsIDrbK
         py2ZN2h3h/TJbU87vjGGo8hgabY1L10+f+V123RP8kSrAtxrhhMcyCy5O5N9qQe83ZgW
         2mHaRE6o+axRnqf5oR61Wa3nrP/lhjHtAY4IHU8B3MLimefTuU5Agp1dATYkwld0/YCC
         A5KUO7wdAuGgTUyNL9jxsPxEyA8tkP5/djuSzkqMStl1tdHBd+DD0AJp2wlwyoPaL3U+
         egMKOq0dok3K4H1x5/aGn2tzZ4qNogAQQdSYYzrEZ2MtJZHlf5BFE3Y7nZg6Q1yvtO3h
         iJCw==
X-Gm-Message-State: AOAM530sbZ6YPRiCRYdJzDzQjL38TLStWELxRmW5/SBC7qGKvhrY/1Pf
        DmhaeCy7wn7JxRoyJkx3E7s=
X-Google-Smtp-Source: ABdhPJz05AhIC7RinIUTTsIaa8i1N21Jei/lBp2V+EMhlzIwtMLrYG+QsCfrfJcsqgckjmR1Nkwj1A==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr9325342wmq.195.1640515271595;
        Sun, 26 Dec 2021 02:41:11 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g9sm12592729wmq.22.2021.12.26.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 02:41:11 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/3] drm/vkms: add support for multiple overlay planes
Date:   Sun, 26 Dec 2021 11:40:58 +0100
Message-Id: <20211226104059.11265-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226104059.11265-1-jose.exposito89@gmail.com>
References: <20211226104059.11265-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create 8 overlay planes instead of 1 when the "enable_overlay" module
parameter is set.

The following igt-gpu-tools tests were executed without finding
regressions. Notice than the numbers are identical:

                    |     master branch     |      this  patch      |
                    | SUCCESS | SKIP | FAIL | SUCCESS | SKIP | FAIL |
 kms_atomic         |      10 |   02 |   00 |      10 |   02 |   00 |
 kms_plane_cursor   |      09 |   45 |   00 |      09 |   45 |   00 |
 kms_plane_multiple |      01 |   23 |   00 |      01 |   23 |   00 |
 kms_writeback      |      04 |   00 |   00 |      04 |   00 |   00 |

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2:

 - Set the number of overlay planes as a constant instead of as a
   module parameter (Melissa Wen)

 - Add a test results in the commit message (Melissa Wen)
---
 drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
 drivers/gpu/drm/vkms/vkms_output.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index d48c23d40ce5..9496fdc900b8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -20,6 +20,8 @@
 #define XRES_MAX  8192
 #define YRES_MAX  8192
 
+#define NUM_OVERLAY_PLANES 8
+
 struct vkms_writeback_job {
 	struct dma_buf_map map[DRM_FORMAT_MAX_PLANES];
 	struct dma_buf_map data[DRM_FORMAT_MAX_PLANES];
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 2e805b2d36ae..ba0e82ae549a 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -57,15 +57,18 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct vkms_plane *primary, *cursor = NULL;
 	int ret;
 	int writeback;
+	unsigned int n;
 
 	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
 	if (vkmsdev->config->overlay) {
-		ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
-		if (ret)
-			return ret;
+		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
+			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (vkmsdev->config->cursor) {
-- 
2.25.1

